Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96128C4451C
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 12:33:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkhkA-0000FH-6G; Fri, 17 Jul 2026 08:32:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wkhk5-0000Ew-EP
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 08:32:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wkhk3-0000On-3D
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 08:32:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784291553;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=J0gbHxwTiJEEBoIgLT2zLS6z14N7yrgOoEPjZ26S1iA=;
 b=aw/fb1uBtD5K6D+MuhGj/wNGl9zRXIQofMX1k/Kgazyk2Lr5GkmjY7kxT3sseAR0eWuXO4
 zpMoVjBqO4narKQFTifdKZUG3CoKAnCX64vCPCfqHNLuyOy7hKhXvC0UJv/b3SyfBbsxSy
 zKHQDvRheHyKiFU4JiTfduvYojo3cDU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-650-RmNkef_xN9mt1CGGgJoqJA-1; Fri,
 17 Jul 2026 08:32:32 -0400
X-MC-Unique: RmNkef_xN9mt1CGGgJoqJA-1
X-Mimecast-MFC-AGG-ID: RmNkef_xN9mt1CGGgJoqJA_1784291550
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3534B1955DC7; Fri, 17 Jul 2026 12:32:30 +0000 (UTC)
Received: from redhat.com (unknown [10.44.34.221])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B5D13180058F; Fri, 17 Jul 2026 12:32:26 +0000 (UTC)
Date: Fri, 17 Jul 2026 13:32:23 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu@processmission.com, pbonzini@redhat.com,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH 5/5] qom/object.c: rename
 object_class_property_uint*_ptr() to
 object_class_static_property_uint*_ptr()
Message-ID: <alog1_vFOi0agPww@redhat.com>
References: <20260717112022.444367-1-mark.caveayland@nutanix.com>
 <20260717112022.444367-6-mark.caveayland@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260717112022.444367-6-mark.caveayland@nutanix.com>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: permerror client-ip=170.10.133.124;
 envelope-from=berrange@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=no autolearn_force=no
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

On Fri, Jul 17, 2026 at 12:19:12PM +0100, Mark Cave-Ayland wrote:
> This more accurately reflects that these properties are held within the class and
> not the object.
> 
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> ---
>  include/qom/object.h | 32 ++++++++++++++++----------------
>  hw/riscv/spike.c     |  5 +++--
>  qom/object.c         | 28 ++++++++++++++++------------
>  3 files changed, 35 insertions(+), 30 deletions(-)
> 
> diff --git a/include/qom/object.h b/include/qom/object.h
> index 95fdf01e30..9df02de93b 100644
> --- a/include/qom/object.h
> +++ b/include/qom/object.h
> @@ -2038,18 +2038,18 @@ ObjectProperty *object_property_add_uint8_ptr(Object *obj, const char *name,
>                                                ObjectPropertyFlags flags);
>  
>  /**
> - * object_class_property_add_uint8_ptr:
> - * @klass: the object class to add a property to
> + * object_class_static_property_add_uint8_ptr:
> + * @klass: the object class to add a static property to
>   * @name: the name of the property
>   * @v: pointer to value
>   * @flags: bitwise-or'd ObjectPropertyFlags
>   *
> - * Add an integer property in memory.  This function will add a
> + * Add a static integer property in memory.  This function will add a
>   * property of type 'uint8'.
>   *

Can we add a bit boiler guidance here, something like

    "A static property is one which is stored outside of
     the object instance, typically in global variables.
     It is only appropropriate to use static properties
     when the class is designed as a singleton. If there
     is a possibility of multiple instances, then properties
     must be stored per-instance."


>   * Returns: The newly added property on success, or %NULL on failure.
>   */
> -ObjectProperty *object_class_property_add_uint8_ptr(ObjectClass *klass,
> +ObjectProperty *object_class_static_property_add_uint8_ptr(ObjectClass *klass,
>                                           const char *name,
>                                           const uint8_t *v,
>                                           ObjectPropertyFlags flags);
> @@ -2071,18 +2071,18 @@ ObjectProperty *object_property_add_uint16_ptr(Object *obj, const char *name,
>                                      ObjectPropertyFlags flags);
>  
>  /**
> - * object_class_property_add_uint16_ptr:
> - * @klass: the object class to add a property to
> + * object_class_static_property_add_uint16_ptr:
> + * @klass: the object class to add a static property to
>   * @name: the name of the property
>   * @v: pointer to value
>   * @flags: bitwise-or'd ObjectPropertyFlags
>   *
> - * Add an integer property in memory.  This function will add a
> + * Add a static integer property in memory.  This function will add a
>   * property of type 'uint16'.
>   *
>   * Returns: The newly added property on success, or %NULL on failure.
>   */
> -ObjectProperty *object_class_property_add_uint16_ptr(ObjectClass *klass,
> +ObjectProperty *object_class_static_property_add_uint16_ptr(ObjectClass *klass,
>                                            const char *name,
>                                            const uint16_t *v,
>                                            ObjectPropertyFlags flags);
> @@ -2104,18 +2104,18 @@ ObjectProperty *object_property_add_uint32_ptr(Object *obj, const char *name,
>                                      ObjectPropertyFlags flags);
>  
>  /**
> - * object_class_property_add_uint32_ptr:
> - * @klass: the object class to add a property to
> + * object_class_static_property_add_uint32_ptr:
> + * @klass: the object class to add a static property to
>   * @name: the name of the property
>   * @v: pointer to value
>   * @flags: bitwise-or'd ObjectPropertyFlags
>   *
> - * Add an integer property in memory.  This function will add a
> + * Add a static integer property in memory.  This function will add a
>   * property of type 'uint32'.
>   *
>   * Returns: The newly added property on success, or %NULL on failure.
>   */
> -ObjectProperty *object_class_property_add_uint32_ptr(ObjectClass *klass,
> +ObjectProperty *object_class_static_property_add_uint32_ptr(ObjectClass *klass,
>                                            const char *name,
>                                            const uint32_t *v,
>                                            ObjectPropertyFlags flags);
> @@ -2137,18 +2137,18 @@ ObjectProperty *object_property_add_uint64_ptr(Object *obj, const char *name,
>                                      ObjectPropertyFlags flags);
>  
>  /**
> - * object_class_property_add_uint64_ptr:
> - * @klass: the object class to add a property to
> + * object_class_static_property_add_uint64_ptr:
> + * @klass: the object class to add a static property to
>   * @name: the name of the property
>   * @v: pointer to value
>   * @flags: bitwise-or'd ObjectPropertyFlags
>   *
> - * Add an integer property in memory.  This function will add a
> + * Add a static integer property in memory.  This function will add a
>   * property of type 'uint64'.
>   *
>   * Returns: The newly added property on success, or %NULL on failure.
>   */
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
>      object_class_property_set_description(oc, "signature-granularity",
>                                            "Size of each line in ACT signature "
>                                            "file");
> diff --git a/qom/object.c b/qom/object.c
> index 622840f9f8..47977b1f44 100644
> --- a/qom/object.c
> +++ b/qom/object.c
> @@ -2724,9 +2724,10 @@ object_property_add_uint8_ptr(Object *obj, const char *name,
>  }
>  
>  ObjectProperty *
> -object_class_property_add_uint8_ptr(ObjectClass *klass, const char *name,
> -                                    const uint8_t *v,
> -                                    ObjectPropertyFlags flags)
> +object_class_static_property_add_uint8_ptr(ObjectClass *klass,
> +                                           const char *name,
> +                                           const uint8_t *v,
> +                                           ObjectPropertyFlags flags)
>  {
>      ObjectPropertyAccessor *getter = NULL;
>      ObjectPropertyAccessor *setter = NULL;
> @@ -2764,9 +2765,10 @@ object_property_add_uint16_ptr(Object *obj, const char *name,
>  }
>  
>  ObjectProperty *
> -object_class_property_add_uint16_ptr(ObjectClass *klass, const char *name,
> -                                     const uint16_t *v,
> -                                     ObjectPropertyFlags flags)
> +object_class_static_property_add_uint16_ptr(ObjectClass *klass,
> +                                            const char *name,
> +                                            const uint16_t *v,
> +                                            ObjectPropertyFlags flags)
>  {
>      ObjectPropertyAccessor *getter = NULL;
>      ObjectPropertyAccessor *setter = NULL;
> @@ -2804,9 +2806,10 @@ object_property_add_uint32_ptr(Object *obj, const char *name,
>  }
>  
>  ObjectProperty *
> -object_class_property_add_uint32_ptr(ObjectClass *klass, const char *name,
> -                                     const uint32_t *v,
> -                                     ObjectPropertyFlags flags)
> +object_class_static_property_add_uint32_ptr(ObjectClass *klass,
> +                                            const char *name,
> +                                            const uint32_t *v,
> +                                            ObjectPropertyFlags flags)
>  {
>      ObjectPropertyAccessor *getter = NULL;
>      ObjectPropertyAccessor *setter = NULL;
> @@ -2844,9 +2847,10 @@ object_property_add_uint64_ptr(Object *obj, const char *name,
>  }
>  
>  ObjectProperty *
> -object_class_property_add_uint64_ptr(ObjectClass *klass, const char *name,
> -                                     const uint64_t *v,
> -                                     ObjectPropertyFlags flags)
> +object_class_static_property_add_uint64_ptr(ObjectClass *klass,
> +                                            const char *name,
> +                                            const uint64_t *v,
> +                                            ObjectPropertyFlags flags)
>  {
>      ObjectPropertyAccessor *getter = NULL;
>      ObjectPropertyAccessor *setter = NULL;
> -- 
> 2.43.0
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


