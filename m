Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A46ADC43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 12:05:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh4YJ-0002HQ-Ec; Tue, 07 Jul 2026 08:05:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wh4YE-0002H0-3A
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 08:05:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wh4Y7-0002xB-4F
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 08:05:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783425913;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=i9u+sHxyxHyeI6bZRhJIcZlmAvs8yo0w2vYaMQD4lqk=;
 b=A0WkJz66ur03teqSOQWCYGvl8rpSfENfnxhAkW4irTnSERMP8u1WfJS3V+5OoIUrAv3XwI
 qD+/cB3dX2c/dV5V7zB9Pia3xsbLRQK6ghRRZfAQe3rh5wpUlXCZ0UG6ECR0cCD0YWkphw
 SMByniGOY0Mm9NJm4KG6HmK0CJPAZjI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-161-9a0S1HNSNVC1t5-2Jro1ag-1; Tue,
 07 Jul 2026 08:05:10 -0400
X-MC-Unique: 9a0S1HNSNVC1t5-2Jro1ag-1
X-Mimecast-MFC-AGG-ID: 9a0S1HNSNVC1t5-2Jro1ag_1783425908
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DF9EF1954120; Tue,  7 Jul 2026 12:05:07 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.142])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7D70A180067C; Tue,  7 Jul 2026 12:05:03 +0000 (UTC)
Date: Tue, 7 Jul 2026 13:05:00 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Cc: mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com,
 philmd@mailo.com, aurelien@aurel32.net, peter.maydell@linaro.org,
 pbonzini@redhat.com, richard.henderson@linaro.org,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org
Subject: Re: [PATCH v2 01/12] qom/object.c: rename
 object_class_property_uint*_ptr() to
 object_class_static_property_uint*_ptr()
Message-ID: <akzrbOKbBwZAKK8D@redhat.com>
References: <20260703135512.3213964-1-mark.caveayland@nutanix.com>
 <20260703135512.3213964-2-mark.caveayland@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260703135512.3213964-2-mark.caveayland@nutanix.com>
User-Agent: Mutt/2.3.2 (2026-04-26)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Jul 03, 2026 at 02:53:03PM +0100, Mark Cave-Ayland wrote:
> This more accurately reflects that these properties are held within the class and
> not the object.
> 
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> ---
>  include/qom/object.h |  8 ++++----
>  hw/riscv/spike.c     |  5 +++--
>  qom/object.c         | 28 ++++++++++++++++------------
>  3 files changed, 23 insertions(+), 18 deletions(-)
> 
> diff --git a/include/qom/object.h b/include/qom/object.h
> index 11f55613fc..89c23d45ab 100644
> --- a/include/qom/object.h
> +++ b/include/qom/object.h
> @@ -1956,7 +1956,7 @@ ObjectProperty *object_property_add_uint8_ptr(Object *obj, const char *name,
>                                                const uint8_t *v,
>                                                ObjectPropertyFlags flags);
>  
> -ObjectProperty *object_class_property_add_uint8_ptr(ObjectClass *klass,
> +ObjectProperty *object_class_static_property_add_uint8_ptr(ObjectClass *klass,
>                                           const char *name,
>                                           const uint8_t *v,
>                                           ObjectPropertyFlags flags);
> @@ -1977,7 +1977,7 @@ ObjectProperty *object_property_add_uint16_ptr(Object *obj, const char *name,
>                                      const uint16_t *v,
>                                      ObjectPropertyFlags flags);
>  
> -ObjectProperty *object_class_property_add_uint16_ptr(ObjectClass *klass,
> +ObjectProperty *object_class_static_property_add_uint16_ptr(ObjectClass *klass,
>                                            const char *name,
>                                            const uint16_t *v,
>                                            ObjectPropertyFlags flags);
> @@ -1998,7 +1998,7 @@ ObjectProperty *object_property_add_uint32_ptr(Object *obj, const char *name,
>                                      const uint32_t *v,
>                                      ObjectPropertyFlags flags);
>  
> -ObjectProperty *object_class_property_add_uint32_ptr(ObjectClass *klass,
> +ObjectProperty *object_class_static_property_add_uint32_ptr(ObjectClass *klass,
>                                            const char *name,
>                                            const uint32_t *v,
>                                            ObjectPropertyFlags flags);
> @@ -2019,7 +2019,7 @@ ObjectProperty *object_property_add_uint64_ptr(Object *obj, const char *name,
>                                      const uint64_t *v,
>                                      ObjectPropertyFlags flags);
>  
> -ObjectProperty *object_class_property_add_uint64_ptr(ObjectClass *klass,
> +ObjectProperty *object_class_static_property_add_uint64_ptr(ObjectClass *klass,
>                                            const char *name,
>                                            const uint64_t *v,
>                                            ObjectPropertyFlags flags);
> diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
> index 9fde0faf39..630b65f569 100644
> --- a/hw/riscv/spike.c
> +++ b/hw/riscv/spike.c
> @@ -278,8 +278,9 @@ static void spike_machine_class_init(ObjectClass *oc, const void *data)
>      object_class_property_add_str(oc, "signature", NULL, spike_set_signature);
>      object_class_property_set_description(oc, "signature",
>                                            "File to write ACT test signature");
> -    object_class_property_add_uint8_ptr(oc, "signature-granularity",
> -                                        &line_size, OBJ_PROP_FLAG_WRITE);
> +    object_class_static_property_add_uint8_ptr(oc, "signature-granularity",
> +                                               &line_size,
> +                                               OBJ_PROP_FLAG_WRITE);

When we have just one use of these "static property" API in the code base,
I wonder if we genuinely need these APIs ?

I wonder why "line_size" isn't merely a field in the machine class ?
External code ought to be able to fetch the current machine and read
a line_size struct field, surely ?


With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


