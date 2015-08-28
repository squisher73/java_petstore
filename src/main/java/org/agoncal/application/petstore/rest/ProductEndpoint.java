package org.agoncal.application.petstore.rest;

import java.util.List;

import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.OptimisticLockException;
import javax.persistence.PersistenceContext;
import javax.persistence.TypedQuery;
import javax.ws.rs.Consumes;
import javax.ws.rs.DELETE;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.PUT;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.Response.Status;
import javax.ws.rs.core.UriBuilder;
import org.agoncal.application.petstore.model.Product;
import org.agoncal.application.petstore.util.Loggable;

/**
 * @author Antonio Goncalves
 *         http://www.antoniogoncalves.org
 *         --
 */

@Stateless
@Path("/products")
@Loggable
public class ProductEndpoint
{

   // ======================================
   // =             Attributes             =
   // ======================================

   @PersistenceContext(unitName = "applicationPetstorePU")
   private EntityManager em;

   // ======================================
   // =          Business methods          =
   // ======================================

   @POST
   @Consumes( {"application/xml", "application/json"})
   public Response create(Product entity)
   {
      em.persist(entity);
      return Response.created(UriBuilder.fromResource(ProductEndpoint.class).path(String.valueOf(entity.getId())).build()).build();
   }

   @DELETE
   @Path("/{id:[0-9][0-9]*}")
   public Response deleteById(@PathParam("id") Long id)
   {
      Product entity = em.find(Product.class, id);
      if (entity == null)
      {
         return Response.status(Status.NOT_FOUND).build();
      }
      em.remove(entity);
      return Response.noContent().build();
   }

   @GET
   @Path("/{id:[0-9][0-9]*}")
   @Produces( {"application/xml", "application/json"})
   public Response findById(@PathParam("id") Long id)
   {
      TypedQuery<Product> findByIdQuery = em.createQuery("SELECT DISTINCT p FROM Product p LEFT JOIN FETCH p.category WHERE p.id = :entityId ORDER BY p.id", Product.class);
      findByIdQuery.setParameter("entityId", id);
      Product entity;
      try
      {
         entity = findByIdQuery.getSingleResult();
      }
      catch (NoResultException nre)
      {
         entity = null;
      }
      if (entity == null)
      {
         return Response.status(Status.NOT_FOUND).build();
      }
      return Response.ok(entity).build();
   }

   @GET
   @Produces( {"application/xml", "application/json"})
   public List<Product> listAll(@QueryParam("start") Integer startPosition, @QueryParam("max") Integer maxResult)
   {
      TypedQuery<Product> findAllQuery = em.createQuery("SELECT DISTINCT p FROM Product p LEFT JOIN FETCH p.category ORDER BY p.id", Product.class);
      if (startPosition != null)
      {
         findAllQuery.setFirstResult(startPosition);
      }
      if (maxResult != null)
      {
         findAllQuery.setMaxResults(maxResult);
      }
      final List<Product> results = findAllQuery.getResultList();
      return results;
   }

   @PUT
   @Path("/{id:[0-9][0-9]*}")
   @Consumes( {"application/xml", "application/json"})
   public Response update(Product entity)
   {
      try
      {
         entity = em.merge(entity);
      }
      catch (OptimisticLockException e)
      {
         return Response.status(Response.Status.CONFLICT).entity(e.getEntity()).build();
      }

      return Response.noContent().build();
   }
}
