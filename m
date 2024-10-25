Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 558E2D0C61F
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2024 15:18:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4M3y-0002Hu-Uw; Fri, 25 Oct 2024 11:17:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t4M3x-0002HW-Em
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 11:17:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t4M3v-0007IA-Mi
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 11:17:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729869434;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ogf30TefIp5A00FtClSfbDYW5v471Ll2hDynpcL1WSU=;
 b=bCpDFDOUofcTrjyFT881RYyHUKJ00QNxnmDCjPuu3kyRf7f4WTOsXDWWDpLkugWO575seR
 y3zyXCSK99BMdF7AngCv573kIi+wyhMF6r6gWP9fIAdNBXx0sZbBMT7nn5o/txeWSmbolL
 qTOrVSVV6x8I3yUxevbMotsyCfliB8I=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-PUHrUEInMyWNt9PxpJgUpg-1; Fri, 25 Oct 2024 11:17:11 -0400
X-MC-Unique: PUHrUEInMyWNt9PxpJgUpg-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-6cbf039dccfso28362426d6.0
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2024 08:17:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729869430; x=1730474230;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ogf30TefIp5A00FtClSfbDYW5v471Ll2hDynpcL1WSU=;
 b=vzV5ZjnNrE6oXNiPAsjPY2j+QBGpId3k52duQj8w/rEYNkDHhrWMpPARgaQ+pVqDzr
 idxVBojfUYuOUriAv5ksHDozp2+Lct8xDSnDKqBX7HtmyUOnsVCh7TqJsh8GEJIjYtpV
 6xvArGaEoz7/944o+SiMnBowpSNHxgvhFnqlharEEtx8vuWBlFAERwn01tefFtkFYIwp
 XLEkwViOYQUvmd6RiqVXYF7cN4xofhuXLd4KFOGDIW6G2kI9yYJwsbmpm1bSR/4vdk5W
 73f/Cj6PSEOvy34QvPUXw9p/hV672U+Dk4DWIgub/iX+YUJTrYN8uusUB+KCNPsicnRH
 Iwrg==
X-Gm-Message-State: AOJu0YwD/HmmVdGipLZEmioICEJ+s+kPGAUHkIy0td1IfpQdeh2FMcGX
 SNbgcSjxjkgngwaVjDaCmd+39mS8q9iYLVUv6kMCj865sUMPB96b1vSKPqCHeCH2riiUrHTPADa
 6lplF2QGtSshh+iRNgoLbMhPh3FGrunF3a8WiR3TX9RsM1AKrf5yu
X-Received: by 2002:a05:6214:5a03:b0:6cb:ef96:c79e with SMTP id
 6a1803df08f44-6d09268cbecmr67993226d6.34.1729869430449; 
 Fri, 25 Oct 2024 08:17:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG8BYvDxtGkLfCytcNcNsS7QCvaxRARwYpdX8lt6P0YzQDQUFRcKK0QFYtLsdLIwrpJzCFIEA==
X-Received: by 2002:a05:6214:5a03:b0:6cb:ef96:c79e with SMTP id
 6a1803df08f44-6d09268cbecmr67992766d6.34.1729869430018; 
 Fri, 25 Oct 2024 08:17:10 -0700 (PDT)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d1799fd518sm6449486d6.102.2024.10.25.08.17.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Oct 2024 08:17:09 -0700 (PDT)
Date: Fri, 25 Oct 2024 11:17:04 -0400
From: Peter Xu <peterx@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Igor Mammedov <imammedo@redhat.com>, Juraj Marcin <jmarcin@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 1/4] qom: TYPE_SINGLETON interface
Message-ID: <Zxu2cKTFFZj36cpK@x1n>
References: <20241024165627.1372621-1-peterx@redhat.com>
 <20241024165627.1372621-2-peterx@redhat.com>
 <87plnoli5c.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87plnoli5c.fsf@pond.sub.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.454,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Oct 25, 2024 at 10:07:59AM +0200, Markus Armbruster wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  include/qom/object_interfaces.h | 47 +++++++++++++++++++++++++++++++++
> >  qom/object.c                    |  3 +++
> >  qom/object_interfaces.c         | 24 +++++++++++++++++
> >  qom/qom-qmp-cmds.c              | 22 ++++++++++++---
> >  system/qdev-monitor.c           |  7 +++++
> >  5 files changed, 100 insertions(+), 3 deletions(-)
> >
> > diff --git a/include/qom/object_interfaces.h b/include/qom/object_interfaces.h
> > index 02b11a7ef0..9b2cc0e554 100644
> > --- a/include/qom/object_interfaces.h
> > +++ b/include/qom/object_interfaces.h
> > @@ -177,4 +177,51 @@ bool user_creatable_del(const char *id, Error **errp);
> >   */
> >  void user_creatable_cleanup(void);
> >  
> > +#define TYPE_SINGLETON "singleton"
> > +
> > +typedef struct SingletonClass SingletonClass;
> > +DECLARE_CLASS_CHECKERS(SingletonClass, SINGLETON, TYPE_SINGLETON)
> > +
> > +/**
> > + * SingletonClass:
> > + *
> > + * @parent_class: the base class
> > + * @get_instance: fetch the singleton instance if it is created,
> > + *                NULL otherwise.
> > + *
> > + * Singleton class describes the type of object classes that can only
> > + * provide one instance for the whole lifecycle of QEMU.  It will fail the
> > + * operation if one attemps to create more than one instance.
> > + *
> > + * One can fetch the single object using class's get_instance() callback if
> > + * it was created before.  This can be useful for operations like QMP
> > + * qom-list-properties, where dynamically creating an object might not be
> > + * feasible.
> > + */
> > +struct SingletonClass {
> > +    /* <private> */
> > +    InterfaceClass parent_class;
> > +    /* <public> */
> > +    Object *(*get_instance)(Error **errp);
> > +};
> > +
> > +/**
> > + * object_class_is_singleton:
> > + *
> > + * @class: the class to detect singleton
> > + *
> > + * Returns: true if it's a singleton class, false otherwise.
> > + */
> > +bool object_class_is_singleton(ObjectClass *class);
> > +
> > +/**
> > + * singleton_get_instance:
> > + *
> > + * @class: the class to fetch singleton instance
> > + *
> > + * Returns: the object* if the class is a singleton class and the singleton
> > + *          object is created, NULL otherwise.
> > + */
> > +Object *singleton_get_instance(ObjectClass *class);
> 
> A non-null return value can become dangling when the object gets
> destroyed.  This could conceivably happen in another thread.
> 
> The obviously safe interface would take a reference the caller must
> unref when done.

Ouch, thanks for spotting this!  Yes we definitely need a refcount at
least..

> 
> > +
> >  #endif
> > diff --git a/qom/object.c b/qom/object.c
> > index 11424cf471..ded299ae1a 100644
> > --- a/qom/object.c
> > +++ b/qom/object.c
> > @@ -553,6 +553,9 @@ static void object_initialize_with_type(Object *obj, size_t size, TypeImpl *type
> >      g_assert(type->abstract == false);
> >      g_assert(size >= type->instance_size);
> >  
> > +    /* Singleton class can only create one object */
> > +    g_assert(!singleton_get_instance(type->class));
> > +
> >      memset(obj, 0, type->instance_size);
> >      obj->class = type->class;
> >      object_ref(obj);
> > diff --git a/qom/object_interfaces.c b/qom/object_interfaces.c
> > index e0833c8bfe..6766060d0a 100644
> > --- a/qom/object_interfaces.c
> > +++ b/qom/object_interfaces.c
> > @@ -354,6 +354,23 @@ void user_creatable_cleanup(void)
> >      object_unparent(object_get_objects_root());
> >  }
> >  
> > +bool object_class_is_singleton(ObjectClass *class)
> > +{
> > +    return !!object_class_dynamic_cast(class, TYPE_SINGLETON);
> > +}
> > +
> > +Object *singleton_get_instance(ObjectClass *class)
> > +{
> > +    SingletonClass *singleton =
> > +        (SingletonClass *)object_class_dynamic_cast(class, TYPE_SINGLETON);
> > +
> > +    if (!singleton) {
> > +        return NULL;
> > +    }
> > +
> > +    return singleton->get_instance(&error_abort);
> > +}
> > +
> >  static void register_types(void)
> >  {
> >      static const TypeInfo uc_interface_info = {
> > @@ -362,7 +379,14 @@ static void register_types(void)
> >          .class_size = sizeof(UserCreatableClass),
> >      };
> >  
> > +    static const TypeInfo singleton_interface_info = {
> > +        .name          = TYPE_SINGLETON,
> > +        .parent        = TYPE_INTERFACE,
> > +        .class_size = sizeof(SingletonClass),
> > +    };
> > +
> >      type_register_static(&uc_interface_info);
> > +    type_register_static(&singleton_interface_info);
> >  }
> >  
> >  type_init(register_types)
> > diff --git a/qom/qom-qmp-cmds.c b/qom/qom-qmp-cmds.c
> > index e91a235347..ecc1cf781c 100644
> > --- a/qom/qom-qmp-cmds.c
> > +++ b/qom/qom-qmp-cmds.c
> > @@ -126,6 +126,7 @@ ObjectPropertyInfoList *qmp_device_list_properties(const char *typename,
> >      ObjectProperty *prop;
> >      ObjectPropertyIterator iter;
> >      ObjectPropertyInfoList *prop_list = NULL;
> > +    bool create;
> >  
> >      klass = module_object_class_by_name(typename);
> >      if (klass == NULL) {
> > @@ -141,7 +142,15 @@ ObjectPropertyInfoList *qmp_device_list_properties(const char *typename,
> >          return NULL;
> >      }
> >  
> > -    obj = object_new(typename);
> > +    /* Avoid creating multiple instances if the class is a singleton */
> > +    create = !object_class_is_singleton(klass) ||
> > +        !singleton_get_instance(klass);
> > +
> > +    if (create) {
> > +        obj = object_new(typename);
> 
> If the class is not a singleton or else if no instance exists, we create
> a temporary instance.
> 
> > +    } else {
> > +        obj = singleton_get_instance(klass);
> 
> If the class is a singleton and the instance exists, we use that
> instead.
> 
> Any properties the instance has created dynamically after object_new()
> are visible to introspection.  This is not the case when we create a
> temporary instance.  Such subtle differences are problematic.  If we
> decide we're okay with this one, we need to document it.

I am thinking what's the major use case for device-list-properties.

If it's for mgmt to query a device property list for set/get before
operating on a real instance (which represents already somewhere in the
device tree), I hope it's fine.  Basically, it means whatever queried here
can always be used with qom-get/qom-set for this singleton as long as it's
already created and present.

I hope Libvirt cannot cache this results anyway, because we already have:

##
# @device-list-properties:
# ...
# .. note:: Objects can create properties at runtime, for example to
#    describe links between different devices and/or objects.  These
#    properties are not included in the output of this command.

So I think it means mgmt cannot cache these results, but only query before
qom-set/qom-get to make sure it's valid.  In that case, maybe we can change
that to s/are not included/may not be included/?

> 
> > +    }
> >  
> >      object_property_iter_init(&iter, obj);
> >      while ((prop = object_property_iter_next(&iter))) {
> > @@ -172,7 +181,9 @@ ObjectPropertyInfoList *qmp_device_list_properties(const char *typename,
> >          QAPI_LIST_PREPEND(prop_list, info);
> >      }
> >  
> > -    object_unref(obj);
> > +    if (create) {
> > +        object_unref(obj);
> > +    }
> >  
> >      return prop_list;
> >  }
> > @@ -199,7 +210,12 @@ ObjectPropertyInfoList *qmp_qom_list_properties(const char *typename,
> >          return NULL;
> >      }
> >  
> > -    if (object_class_is_abstract(klass)) {
> > +    /*
> > +     * Abstract classes are not for instantiations, meanwhile avoid
> > +     * creating temporary singleton objects because it can cause conflicts
> > +     * if there's already one created.
> > +     */
> > +    if (object_class_is_abstract(klass) || object_class_is_singleton(klass)) {
> >          object_class_property_iter_init(&iter, klass);
> >      } else {
> >          obj = object_new(typename);
> 
> If the class is a singleton, we treat it as if it was abstract.  Its
> instance properties, if any, are not visible in qom-list-properties.
> This is a defect.  If you make an existing class with instance
> properties a singleton, the defect is a regression.

I can switch to get_instance() for singleton when it's available.  Would
that work?

Thanks!

> 
> > diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
> > index 44994ea0e1..1310f35c9f 100644
> > --- a/system/qdev-monitor.c
> > +++ b/system/qdev-monitor.c
> > @@ -36,6 +36,7 @@
> >  #include "qemu/option.h"
> >  #include "qemu/qemu-print.h"
> >  #include "qemu/option_int.h"
> > +#include "qom/object_interfaces.h"
> >  #include "sysemu/block-backend.h"
> >  #include "migration/misc.h"
> >  #include "qemu/cutils.h"
> > @@ -643,6 +644,12 @@ DeviceState *qdev_device_add_from_qdict(const QDict *opts,
> >          return NULL;
> >      }
> >  
> > +    if (singleton_get_instance(OBJECT_CLASS(dc))) {
> > +        error_setg(errp, "Class '%s' only supports one instance",
> > +                   driver);
> > +        return NULL;
> > +    }
> > +
> >      /* find bus */
> >      path = qdict_get_try_str(opts, "bus");
> >      if (path != NULL) {
> 

-- 
Peter Xu


