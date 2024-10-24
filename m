Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8FABD1036C
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2024 20:53:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t44pb-0007yx-HJ; Thu, 24 Oct 2024 16:53:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t44pa-0007ym-4h
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 16:53:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t44pY-0000ve-1Q
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 16:53:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729803194;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ae6YeWsBc8LOPkSK4fE8mWd0zxflGpf7qmzGzD9dwOY=;
 b=inRaSLOr0TtGYoieRZgTfNglAuMQC2v4aEaUmq36OdOYMM4BpRl/JcajPzuoBtMWwuy+mw
 G9dKAlNOIeCuRa4wZRQMGFAQZHVdW5wjMXG9frB46jfUvuT2P/v8S81rmw6LhrC/9pAbDo
 QlXe2WD1+i++fgH+oDpSON0dSl0fiDA=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-693-hsBo6aWAPXaVakNWrk_JRg-1; Thu, 24 Oct 2024 16:53:12 -0400
X-MC-Unique: hsBo6aWAPXaVakNWrk_JRg-1
Received: by mail-oo1-f71.google.com with SMTP id
 006d021491bc7-5eb24a3a3d6so1258716eaf.2
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2024 13:53:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729803191; x=1730407991;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ae6YeWsBc8LOPkSK4fE8mWd0zxflGpf7qmzGzD9dwOY=;
 b=uGVZkcALzKMZ2HBRtK8xyfvY8ITo6yt1U6nO5pWlEts8ymlXXQnsS+FolnfpnaVpP4
 Mu+k/21Z9dWsw70l+y84UTu9q/7Iz+5U1ZNLuGd/IVAt5e0OrRaSFLNAWOfzDiyUJdo9
 aXjX3XVof/8hTAQ6hjBvyAIMcD3j0664OK2UGa9ezIaPx13/zQPMppblwnWUjpK9Abyo
 OIZJCey1/C/gCttmjwDjMb6oOMdpcqPABOIbZTKDOVhEM+khz62lD38YycZDVjf8k6zF
 md3l+wxjFZYV6MAw83hHxm6uNqMzJdsUsDiXEQIJiPldIdiib7QxyiCDKsbJEc5dWBvl
 3jVw==
X-Gm-Message-State: AOJu0YzKp1BEX1h079qLiFjNB/kqn7Delebd+3MXAipN+xJGC1jjgp3h
 xQYNKnn5OI8WYmQEczezF/7QyzVQqLGy2w9UTSis2W0dTb8cCIyh4jh72yVSa6xA3IW3+oEK8Ad
 8wmXfRFeUQt8hQBeMCvWV5GfFZYSX3dMcFLqHxFPkbopysWMnXPsf
X-Received: by 2002:a05:6358:78b:b0:1c2:f482:5c06 with SMTP id
 e5c5f4694b2df-1c3e4d317c0mr317256955d.14.1729803191615; 
 Thu, 24 Oct 2024 13:53:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE+Vrd9jpJe7FK0pV1y2clOzo8EI0l9cXMQk9HT9LtK2FoSUlmdaHGi8bJpBH/LoMbuKrLVmg==
X-Received: by 2002:a05:6358:78b:b0:1c2:f482:5c06 with SMTP id
 e5c5f4694b2df-1c3e4d317c0mr317254355d.14.1729803191260; 
 Thu, 24 Oct 2024 13:53:11 -0700 (PDT)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b165a5c605sm523781585a.74.2024.10.24.13.53.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2024 13:53:10 -0700 (PDT)
Date: Thu, 24 Oct 2024 16:53:08 -0400
From: Peter Xu <peterx@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Fabiano Rosas <farosas@suse.de>, Igor Mammedov <imammedo@redhat.com>,
 Juraj Marcin <jmarcin@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 1/4] qom: TYPE_SINGLETON interface
Message-ID: <ZxqztLdfV__sGuDZ@x1n>
References: <20241024165627.1372621-1-peterx@redhat.com>
 <20241024165627.1372621-2-peterx@redhat.com>
 <20dec12b-69e0-4996-9962-6aac9d40fc07@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20dec12b-69e0-4996-9962-6aac9d40fc07@linaro.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.263,
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

On Thu, Oct 24, 2024 at 05:02:19PM -0300, Philippe Mathieu-Daudé wrote:
> Hi Peter,

Hi, Phil,

Thanks for the quick reviews!

> 
> (Cc'ing Mark)
> 
> On 24/10/24 13:56, Peter Xu wrote:
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >   include/qom/object_interfaces.h | 47 +++++++++++++++++++++++++++++++++
> >   qom/object.c                    |  3 +++
> >   qom/object_interfaces.c         | 24 +++++++++++++++++
> >   qom/qom-qmp-cmds.c              | 22 ++++++++++++---
> >   system/qdev-monitor.c           |  7 +++++
> >   5 files changed, 100 insertions(+), 3 deletions(-)
> 
> 
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
> 
> IMHO asking get_instance() is overkill ...
> 
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
> > +
> >   #endif
> 
> > diff --git a/qom/object_interfaces.c b/qom/object_interfaces.c
> > index e0833c8bfe..6766060d0a 100644
> > --- a/qom/object_interfaces.c
> > +++ b/qom/object_interfaces.c
> > @@ -354,6 +354,23 @@ void user_creatable_cleanup(void)
> >       object_unparent(object_get_objects_root());
> >   }
> > +bool object_class_is_singleton(ObjectClass *class)
> > +{
> > +    return !!object_class_dynamic_cast(class, TYPE_SINGLETON);
> > +}
> > +
> > +Object *singleton_get_instance(ObjectClass *class)
> > +{
> 
> ... when we can use object_resolve_type_unambiguous:
> 
>       return object_resolve_type_unambiguous(object_class_get_name(class,
> NULL));

I think an issue is migration object is nowhere to be find under
object_get_root(), so it won't work there.  A side benefit is, it's also
faster..

How about I use object_resolve_type_unambiguous() as a fallback?  Then it's
used only if get_instance() is not provided.

> 
> BTW should we pass Error** argument to singleton_get_instance()?

I didn't expect it to fail, hence I didn't even add it to make it more like
"this will always success or it asserts" kind of things.  I left Error** in
the hook just to be slightly flexible, but I always pass in error_abort()
in this patch.

I can either add Error** if anyone thinks it useful, or even drop Error**
in ->get_instance() since it's mostly not used at least for now.

Let me know!

> 
> > +    SingletonClass *singleton =
> > +        (SingletonClass *)object_class_dynamic_cast(class, TYPE_SINGLETON);
> > +
> > +    if (!singleton) {
> > +        return NULL;
> > +    }
> > +
> > +    return singleton->get_instance(&error_abort);
> > +}
> 
> Alternatively call object_resolve_type_unambiguous() in instance_init()?

Thanks,

-- 
Peter Xu


