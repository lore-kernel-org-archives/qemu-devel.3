Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F11A9D149C3
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2024 16:22:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4N4F-0004qv-Mc; Fri, 25 Oct 2024 12:21:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t4N4D-0004nq-K4
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 12:21:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t4N4B-0007PZ-L8
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 12:21:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729873293;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3rUFevykI4a1u60ZU7qOJ3pwc4PMxH7Rvg/IACovPHw=;
 b=VPVB6ZsbvghUYA/txduP7ktQlEC/zDz7K9o6jyRf8I5HnFmD+Dg86WdZKWOxT6/mSSsUlV
 tdnB6UvX3burPjq0VOBkl6mVF05Ei+/0RhW4zd/ew8IIZ6fG3gB5TpF+/8WojRlx4Cji1r
 QIO2jv2a8nYbFN36v1jtK54jc45e2ic=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-96-Rt4pJ7IKPoOnxjkwTbtftg-1; Fri, 25 Oct 2024 12:21:32 -0400
X-MC-Unique: Rt4pJ7IKPoOnxjkwTbtftg-1
Received: by mail-ot1-f71.google.com with SMTP id
 46e09a7af769-7181ab2d667so1891666a34.2
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2024 09:21:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729873291; x=1730478091;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3rUFevykI4a1u60ZU7qOJ3pwc4PMxH7Rvg/IACovPHw=;
 b=f6lZhPghN9qhxkS5CTtLYdWtaJgwsVWSXvbZbtLXaVOyOugg2vtK5cFN+kkbcG9CR6
 cWNrrcTNRiSCILm7lohbiPH1wVItYh6p8bWBDBsdCHq1Ita0n8Wj1bgVgA5GhSk166ok
 g7/p12AnoOgdPyU3E14exac9IUfrY3pUSUoX5bwrkBCQTI1Do8bKxUfYV1axVEXQx3KP
 kBCnQzCk1EsSywMaEFi5gKnNg+TXGakPpzaNPPTV9b5DK+7DfEujEiY+P4D3GesIozJy
 +wksghGDakAvjvWaVBljNIgWaMF+KzXJ8Y3WLNP2ekHi9Adq4I3Zfaa/nYdy3LZ6AIfc
 MwrA==
X-Gm-Message-State: AOJu0YzRAjcKSml2Z3E98tidByo9dqGXiesETjQKT1el3G8hZxiv/y0/
 DStk5XgIxP7v3GY+9S8Bi8XLLAU+kE2tJDXUKK15w/Ja6v1oUGFPk4e1NSI7Hwn+j5kDH0U1gJ4
 cnrJKI+jS6qBTthTBdldciX/gd5nbXtNsInw6OlkReWiSaBF0xPV2
X-Received: by 2002:a05:6358:7e9b:b0:1c3:7d12:708d with SMTP id
 e5c5f4694b2df-1c3e4d1fd78mr407110755d.11.1729873291442; 
 Fri, 25 Oct 2024 09:21:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEdnHZyU5ZpvY8IaWntLOl1MkU0hBmzZ5HqeZRhC34AEXQLpYRav6xzeHN919AvoAGvs+uKtA==
X-Received: by 2002:a05:6358:7e9b:b0:1c3:7d12:708d with SMTP id
 e5c5f4694b2df-1c3e4d1fd78mr407107155d.11.1729873291028; 
 Fri, 25 Oct 2024 09:21:31 -0700 (PDT)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b18d27915csm67521385a.8.2024.10.25.09.21.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Oct 2024 09:21:30 -0700 (PDT)
Date: Fri, 25 Oct 2024 12:21:28 -0400
From: Peter Xu <peterx@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Fabiano Rosas <farosas@suse.de>, Igor Mammedov <imammedo@redhat.com>,
 Juraj Marcin <jmarcin@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 1/4] qom: TYPE_SINGLETON interface
Message-ID: <ZxvFiGvkxm6lAwrY@x1n>
References: <20241024165627.1372621-1-peterx@redhat.com>
 <20241024165627.1372621-2-peterx@redhat.com>
 <20dec12b-69e0-4996-9962-6aac9d40fc07@linaro.org>
 <ZxqztLdfV__sGuDZ@x1n>
 <69eef5ad-93e3-4e6f-82c0-e8ee627128d4@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <69eef5ad-93e3-4e6f-82c0-e8ee627128d4@linaro.org>
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

On Fri, Oct 25, 2024 at 12:11:51PM -0300, Philippe Mathieu-Daudé wrote:
> On 24/10/24 17:53, Peter Xu wrote:
> > On Thu, Oct 24, 2024 at 05:02:19PM -0300, Philippe Mathieu-Daudé wrote:
> > > Hi Peter,
> > 
> > Hi, Phil,
> > 
> > Thanks for the quick reviews!
> > 
> > > 
> > > (Cc'ing Mark)
> > > 
> > > On 24/10/24 13:56, Peter Xu wrote:
> > > > Signed-off-by: Peter Xu <peterx@redhat.com>
> > > > ---
> > > >    include/qom/object_interfaces.h | 47 +++++++++++++++++++++++++++++++++
> > > >    qom/object.c                    |  3 +++
> > > >    qom/object_interfaces.c         | 24 +++++++++++++++++
> > > >    qom/qom-qmp-cmds.c              | 22 ++++++++++++---
> > > >    system/qdev-monitor.c           |  7 +++++
> > > >    5 files changed, 100 insertions(+), 3 deletions(-)
> > > 
> > > 
> > > > +/**
> > > > + * SingletonClass:
> > > > + *
> > > > + * @parent_class: the base class
> > > > + * @get_instance: fetch the singleton instance if it is created,
> > > > + *                NULL otherwise.
> > > > + *
> > > > + * Singleton class describes the type of object classes that can only
> > > > + * provide one instance for the whole lifecycle of QEMU.  It will fail the
> > > > + * operation if one attemps to create more than one instance.
> > > > + *
> > > > + * One can fetch the single object using class's get_instance() callback if
> > > > + * it was created before.  This can be useful for operations like QMP
> > > > + * qom-list-properties, where dynamically creating an object might not be
> > > > + * feasible.
> > > > + */
> > > > +struct SingletonClass {
> > > > +    /* <private> */
> > > > +    InterfaceClass parent_class;
> > > > +    /* <public> */
> > > > +    Object *(*get_instance)(Error **errp);
> > > 
> > > IMHO asking get_instance() is overkill ...
> > > 
> > > > +};
> > > > +
> > > > +/**
> > > > + * object_class_is_singleton:
> > > > + *
> > > > + * @class: the class to detect singleton
> > > > + *
> > > > + * Returns: true if it's a singleton class, false otherwise.
> > > > + */
> > > > +bool object_class_is_singleton(ObjectClass *class);
> > > > +
> > > > +/**
> > > > + * singleton_get_instance:
> > > > + *
> > > > + * @class: the class to fetch singleton instance
> > > > + *
> > > > + * Returns: the object* if the class is a singleton class and the singleton
> > > > + *          object is created, NULL otherwise.
> > > > + */
> > > > +Object *singleton_get_instance(ObjectClass *class);
> > > > +
> > > >    #endif
> > > 
> > > > diff --git a/qom/object_interfaces.c b/qom/object_interfaces.c
> > > > index e0833c8bfe..6766060d0a 100644
> > > > --- a/qom/object_interfaces.c
> > > > +++ b/qom/object_interfaces.c
> > > > @@ -354,6 +354,23 @@ void user_creatable_cleanup(void)
> > > >        object_unparent(object_get_objects_root());
> > > >    }
> > > > +bool object_class_is_singleton(ObjectClass *class)
> > > > +{
> > > > +    return !!object_class_dynamic_cast(class, TYPE_SINGLETON);
> > > > +}
> > > > +
> > > > +Object *singleton_get_instance(ObjectClass *class)
> > > > +{
> > > 
> > > ... when we can use object_resolve_type_unambiguous:
> > > 
> > >        return object_resolve_type_unambiguous(object_class_get_name(class,
> > > NULL));
> > 
> > I think an issue is migration object is nowhere to be find under
> > object_get_root(), so it won't work there.  A side benefit is, it's also
> > faster..
> 
> Maybe a simpler alternative is to add a field in ObjectClass, maintain
> a single GHashTable to store TypeName -> Instance and retrieve as:
> 
> Object *singleton_get_instance(ObjectClass *class)
> {
>     return g_hash_table_lookup(&singletons,
>                                object_class_get_name(class));
> }

This may need some proper locking too as Markus pointed out, so that the
object needs to boost its refcount before returned.  It might be a problem
if the singleton class has its own locking.. I'll need to think about it.

In migration's case, there's going to be a new migration mutex protecting
the singleton object being updated (not included in this series, posted
elsewhere [1]).

[1] https://lore.kernel.org/r/20241024213056.1395400-9-peterx@redhat.com

> 
> TBH the TYPE_SINGLETON interface seems a bit over-engineered and its
> implementation error prone.

Please feel free to suggest something else if you come up with.

The issue so far is qom/device-list-properties now can randomly create
migration object, which is defined to be global, while the plan is we need
to do something tricky in instance_finalize() for migration object (operate
on global vars; which is tricky but it could solve some issue we
encounter), so we must make sure it's never created more than once.

Thanks,

> 
> > How about I use object_resolve_type_unambiguous() as a fallback?  Then it's
> > used only if get_instance() is not provided.
> > 
> > > 
> > > BTW should we pass Error** argument to singleton_get_instance()?
> > 
> > I didn't expect it to fail, hence I didn't even add it to make it more like
> > "this will always success or it asserts" kind of things.  I left Error** in
> > the hook just to be slightly flexible, but I always pass in error_abort()
> > in this patch.
> > 
> > I can either add Error** if anyone thinks it useful, or even drop Error**
> > in ->get_instance() since it's mostly not used at least for now.
> > 
> > Let me know!
> > 
> > > 
> > > > +    SingletonClass *singleton =
> > > > +        (SingletonClass *)object_class_dynamic_cast(class, TYPE_SINGLETON);
> > > > +
> > > > +    if (!singleton) {
> > > > +        return NULL;
> > > > +    }
> > > > +
> > > > +    return singleton->get_instance(&error_abort);
> > > > +}
> > > 
> > > Alternatively call object_resolve_type_unambiguous() in instance_init()?
> > 
> > Thanks,
> > 
> 

-- 
Peter Xu


