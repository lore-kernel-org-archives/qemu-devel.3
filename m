Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FB1CD149C0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2024 16:17:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4N00-0002rG-27; Fri, 25 Oct 2024 12:17:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t4Mzw-0002r2-N2
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 12:17:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t4Mzu-0006eE-9F
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 12:17:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729873028;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eRhFszuGnY4+CeOiYI2fU8xruu5vtjRmneLAWaUqBG8=;
 b=h6OYIFbGhK6BUjaA5EwUe36aeV6579aisUiKyzwTinnG0Ehy6aIKBhp37mTulzSvA3Krgk
 reuDfXQQkU8DCaZVe5TK3w0kYOAQ+XilX0mCNxdJUPc3wFzvScdT7YnFTLdUreJ1yEb7TV
 W2TjyRVpzpcDkIQCZmztfzZ/m2oeuYg=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-pImvQ-BSNOO_922lmEIR1Q-1; Fri, 25 Oct 2024 12:17:07 -0400
X-MC-Unique: pImvQ-BSNOO_922lmEIR1Q-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-460ba8f6a5aso35328131cf.1
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2024 09:17:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729873026; x=1730477826;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eRhFszuGnY4+CeOiYI2fU8xruu5vtjRmneLAWaUqBG8=;
 b=wVUUdfuuU5+nbO83HG0HGY8n+znO2rPKVJdpQzsCZc3sbwtm2eujvOOjv2B0oPLpFU
 zOWp+aUXvbvFEvi3aAaeRwK1HC4iLsFsnIF3eyvp5RD3p3bjAECbVLwnyZD6ktNgpvNo
 esRpKn8Jfj51A2XB+lsE99iNscDMRTQ0iwEFYEIN6+hZf34EsxzPyXRn/45cVzDjle79
 cdK6bvG6myOCJBFqd301pPytOAqYB7Rvv1gBDntqYkUYrkKiCrp9KjtyijLjQMEGh4UL
 qoKi08aC25+/KYKIl0aTUtQuIsmCQQWfu4SKZ/MMpeRhmmOYls9kFVsbqfkaSfILK21J
 SANg==
X-Gm-Message-State: AOJu0Yz4SPgcAj8zfztV5ZBmrc/Jtwq1SOi/q4/sLlT34pAihZZoBLrt
 CZ5Oe8iSvPjFr8hKRtwjB6XoEe6jbCHEf+b6SaAcL0H3M9VgM/xtHmEpaWlYCS0vnheyD9qe4Pu
 t+3sJGW/qjqK7RxU4d8tuGOoy6UuwrXIKd8teuoTEJOMIYZ+WnS3y
X-Received: by 2002:ac8:4504:0:b0:461:16ce:7de2 with SMTP id
 d75a77b69052e-46116ce807amr99311831cf.0.1729873026520; 
 Fri, 25 Oct 2024 09:17:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHgaSkxMEASyafylq3UdYZtv5NfVxzQ1a9444qfDpLx8MvB5CEOKc9DG8yASrmjH1wwmvfhag==
X-Received: by 2002:ac8:4504:0:b0:461:16ce:7de2 with SMTP id
 d75a77b69052e-46116ce807amr99311381cf.0.1729873026028; 
 Fri, 25 Oct 2024 09:17:06 -0700 (PDT)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-461357007d4sm5165691cf.88.2024.10.25.09.17.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Oct 2024 09:17:05 -0700 (PDT)
Date: Fri, 25 Oct 2024 12:17:02 -0400
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Igor Mammedov <imammedo@redhat.com>, Juraj Marcin <jmarcin@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 1/4] qom: TYPE_SINGLETON interface
Message-ID: <ZxvEfrj5B59J5HHj@x1n>
References: <20241024165627.1372621-1-peterx@redhat.com>
 <20241024165627.1372621-2-peterx@redhat.com>
 <ZxtqGQbd4Hq4APtm@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZxtqGQbd4Hq4APtm@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.454,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.697,
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

On Fri, Oct 25, 2024 at 10:51:21AM +0100, Daniel P. Berrangé wrote:
> On Thu, Oct 24, 2024 at 12:56:24PM -0400, Peter Xu wrote:
> 
> Adding significant new functionality to QOM should really come
> with a commit message explaining the rationale and the design
> choices
> 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  include/qom/object_interfaces.h | 47 +++++++++++++++++++++++++++++++++
> >  qom/object.c                    |  3 +++
> >  qom/object_interfaces.c         | 24 +++++++++++++++++
> >  qom/qom-qmp-cmds.c              | 22 ++++++++++++---
> >  system/qdev-monitor.c           |  7 +++++
> >  5 files changed, 100 insertions(+), 3 deletions(-)
> 
> snip
> 
> > + * Singleton class describes the type of object classes that can only
> > + * provide one instance for the whole lifecycle of QEMU.  It will fail the
> > + * operation if one attemps to create more than one instance.
> > + *
> > + * One can fetch the single object using class's get_instance() callback if
> > + * it was created before.  This can be useful for operations like QMP
> > + * qom-list-properties, where dynamically creating an object might not be
> > + * feasible.
> 
> snip
> 
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
> With this design, all code that uses a given type needs to know
> whether or not it is intended to be a singleton. If some code
> somewhere mistakenly calls 'object_new' instead of 'singleton_get_instance',
> the singleton type  is no longer a singleton, except you handle this by
> adding an assert in object_initialize_with_type.

Yes, that's really the current goal, and why I added that assert(), so it
fails any attempts trying to create one more instance of it, because
normally it's by accident.  The theory issue to solve is when some class is
not ready for being created more than once, so it must not happen.

My plan was to properly guard qdev creation with this which can fail
pretty, so it's a "programming error" otherwise.

> 
> This is still a bit of a loaded foot-gun IMHO, as we don't want random
> code asserting.
> 
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
> 
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
> > +    } else {
> > +        obj = singleton_get_instance(klass);
> > +    }
> 
> This is the first foot-gun example.
> 
> I really strongly dislike that the design pattern forces us to
> create code like this, as we can never be confident we've
> correctly identified all the places which may call object_new
> on a singleton...

Yeah I agree it's not pretty, IMHO it's a trade-off comparing to glib's,
I'll comment below for that.

Meanwhile I hope there should be very limited places in QEMU to randomly
create "any" object on the fly.. so far only qom/device-list-properties
that I see.

> 
> > @@ -172,7 +181,9 @@ ObjectPropertyInfoList *qmp_device_list_properties(const char *typename,
> >          QAPI_LIST_PREPEND(prop_list, info);
> >      }
> >  
> > -    object_unref(obj);
> > +    if (create) {
> > +        object_unref(obj);
> > +    }
> 
> ...and this just compounds the ugliness.
> 
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
> 
> Another example of the foot-gun firing at random code
> 
> > +    if (object_class_is_abstract(klass) || object_class_is_singleton(klass)) {
> >          object_class_property_iter_init(&iter, klass);
> >      } else {
> >          obj = object_new(typename);
> 
> 
> With changes to QOM, I think it is generally informative to look at how
> GLib has handled the problem, since the QOM design has heavily borrowed
> from its GObject design.
> 
> In GObject, singletons are handled in a very differnt way. It has a
> concept of a "constructor" function against the class, which is what is
> responsible for allocating the object. By default the 'constructor' will
> call g_new0, but a class which wishes to become a singleton will override
> the 'constructor' function to allocate on first call, and return the
> cached object on subsequent calls. This is illustrated here:
> 
>   https://gitlab.gnome.org/GNOME/glib/-/blob/main/gobject/gobject.h#L297
> 
> The key benefit of this is that everything can carry on calling
> g_object_new() as before, as it will just "do the right thing"
> in terms of allocation.
> 
> In QOM, we don't have a 'constructor' class function, we just directly
> call g_malloc from object_new_with_type. This is because at the time,
> we didn't see an immediate need for it. We could easily change that
> though to introduce the concept of a 'constructor', which could
> probably make singletons work without needing updates to existing code.

I think glib's implementation is not thread safe on its own... consider two
threads invoke g_object_new() on the singleton without proper locking.  I
am guessing it could be relevant to glib's heavy event model.

And that's fundamentally what I want to have for QEMU's migration object,
so that it doesn't need locking on its own of the singleton idea: the
locking, if necessary, should be done in get_instance(), in this case.
So I did it wrong indeed in this current series at least there, where it
should need to take migration's new mutex, then take a refcount before
return, rightfully as Markus pointed out elsewhere.

The other concern I have with glib's singleton is, fundamentally
object_new() didn't really create a new object, which can be against the
gut feelings of whoever read it.  I'm not sure whether that's really what
we want.. or maybe that's only my own concern, so it might be subjective.

Thanks,

-- 
Peter Xu


