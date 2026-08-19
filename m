Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1079C5DF81
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 17:53:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwkTf-0007d7-DJ; Wed, 19 Aug 2026 13:53:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wwkTe-0007cL-19
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 13:53:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wwkTb-0005SA-JA
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 13:53:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787162003;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uIWXCSn8kbb732h2c0oHrs/Qn/3vyl4IQ2es5MZ7s4k=;
 b=boxG4P4kBnSOFR0s/iaFKdNvi2QfDixBiH7xYb93g45cHHXGpwuULVotK5IGEqa+gpT7sY
 oXrYLFuKTBgjFBK+JcwFB7WSO0Y3ZVXHUHoEiDdxpNBO0mI+l9JYlxdT2vNRqlF24fTGOJ
 HiXTPQrINrmsIK1nNoYz7cR/9H5NmIY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-296-fEgrD-EKO_Ktr8noI45PRg-1; Wed,
 19 Aug 2026 13:53:09 -0400
X-MC-Unique: fEgrD-EKO_Ktr8noI45PRg-1
X-Mimecast-MFC-AGG-ID: fEgrD-EKO_Ktr8noI45PRg_1787161988
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3306C18005B3; Wed, 19 Aug 2026 17:53:07 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 156CE1944DCD; Wed, 19 Aug 2026 17:53:04 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 07/15] qom/object.c: add
 object_class_property_add_uint32_ptr()
From: marcandre.lureau@redhat.com
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Cc: mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com, 
 philmd@mailo.com, aurelien@aurel32.net, peter.maydell@linaro.org, 
 pbonzini@redhat.com, richard.henderson@linaro.org, berrange@redhat.com, 
 marcandre.lureau@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org
In-Reply-To: <20260819133816.3497033-8-mark.caveayland@nutanix.com>
References: <20260819133816.3497033-1-mark.caveayland@nutanix.com>
 <20260819133816.3497033-8-mark.caveayland@nutanix.com>
Date: Wed, 19 Aug 2026 21:52:43 +0400
Message-Id: <178716196330.2018258.6471457150873358597.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3367;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=HNlb9h1Jdiy0LB9GPOXKKKjp7YV4aF6oHdutseT+FX0=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqhe19X97EFZbb03s4+KF+59/c75JVSYJ8MY9dp
 c5DUNAa4jyJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaoXtfQAKCRDa6OEJdZac
 5RE6EACxf8f+YUZc5y+BRUp1CsbSn2FVMUoUVnUXViIH93Q7XQylNaJd8erR3r4n1cGsQ1oX3vt
 kYyZHRv59ohifESQL/JxqWkkhWOn76ZHN+d2rl7a2vFAlix7H6YEL70PFEiB26yYHdFuRyUJY2g
 TnoxKllulMJkC0J7eRY/8SzrvwH7jy8McAOFjH+sMRJ94FD7tkYl26k2WmBpB/1ireVvKRvCpzy
 eS4T4uQzmzzNXyi3obglwIQT4S9J458yzhpzIxWyKA9d56UjLZrvT0LDjg4nEAlVI0UQ2k9vTbR
 Tl96CQwqIjgs4TA34AfW40PFeuZPtAJxIHi9r6EfYJSAjs/3FmDNwOfJMCFiMo8tmADNde+qLlF
 ZuMRL9VvQuDWkx2aRcPwcxGSdswxAiRPPT/SiNToExDveews73FRxaD8i8QFJkWPsql/Mclb5u3
 TiuK4/nW1b4Remgv8AWOaV5FHF9gyFXmUX+4zNn+Bxv0QBlRwHFAvyQImHz4ftS4mnNsdPp5LRH
 8jEsHw8MS9UbQ3AhgYVXAqYQxOYkN8ofEkLy0pPWNOSQ3ieWU0CQSpKfvCEYM2bcVahFEZCeM9O
 jFE+3DrV8B9+Znkv+wXuk85AVcs9GQB9PkJOVvNsQOmZXmsHQr9En5qyJwdBM8x4RarQ1OEvvAB
 lIjWe1K0daLZTcQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

> This adds a class property that references a uint32_t within the object instance
> and is intended to be a replacement for object_property_add_uint32_ptr().
> 
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> Message-ID: <20260819133816.3497033-8-mark.caveayland@nutanix.com>
>
> diff --git a/include/qom/object.h b/include/qom/object.h
> index eba675d218eb..e0c88453b1e0 100644
> --- a/include/qom/object.h
> +++ b/include/qom/object.h
> @@ -2129,6 +2129,24 @@ ObjectProperty *object_property_add_uint32_ptr(Object *obj, const char *name,
>                                      const uint32_t *v,
>                                      ObjectPropertyFlags flags);
>  
> +/**
> + * object_class_property_add_uint32_ptr:
> + * @klass: the object class to add a property to
> + * @name: the name of the property
> + * @offset: the offset from the object instance where the uint8 value is
> + *   stored

Should be "uint32 value", not "uint8 value".

> + * @flags: bitwise-or'd ObjectPropertyFlags
> + *
> + * Add an integer property in memory.  This function will add a
> + * property of type 'uint16'.

Should be "property of type 'uint32'", not 'uint16'.

> + *
> + * Returns: The newly added property on success, or %NULL on failure.
> + */
> +ObjectProperty *object_class_property_add_uint32_ptr(ObjectClass *klass,
> +                                    const char *name,
> +                                    ptrdiff_t offset,
> +                                    ObjectPropertyFlags flags);
> +
>  /**
>   * object_class_static_property_add_uint32_ptr:
>   * @klass: the object class to add a static property to
> diff --git a/qom/object.c b/qom/object.c
> index a480fdd40089..fe032c96190c 100644
> --- a/qom/object.c
> +++ b/qom/object.c
> @@ -2742,6 +2742,7 @@ static void *object_class_prop_ptr(Object *obj, ptrdiff_t offset)
>      OBJECT_CLASS_PROPERTY_SCALAR_SETTER(type)
>  
>  DEFINE_OBJECT_CLASS_PROPERTY_SCALAR_METHODS(uint8)
> +DEFINE_OBJECT_CLASS_PROPERTY_SCALAR_METHODS(uint32)
>  
>  #undef OBJECT_CLASS_PROPERTY_SCALAR_GETTER
>  #undef OBJECT_CLASS_PROPERTY_SCALAR_SETTER
> @@ -2870,6 +2871,26 @@ object_property_add_uint32_ptr(Object *obj, const char *name,
>                                 getter, setter, NULL, (void *)v);
>  }
>  
> +ObjectProperty *
> +object_class_property_add_uint32_ptr(ObjectClass *klass, const char *name,
> +                                     ptrdiff_t offset,
> +                                     ObjectPropertyFlags flags)
> +{
> +    ObjectPropertyAccessor *getter = NULL;
> +    ObjectPropertyAccessor *setter = NULL;
> +
> +    if ((flags & OBJ_PROP_FLAG_READ) == OBJ_PROP_FLAG_READ) {
> +        getter = property_class_get_uint32_ptr;
> +    }
> +
> +    if ((flags & OBJ_PROP_FLAG_WRITE) == OBJ_PROP_FLAG_WRITE) {
> +        setter = property_class_set_uint32_ptr;
> +    }
> +
> +    return object_class_property_add(klass, name, "uint32",
> +                                     getter, setter, NULL, (void *)offset);
> +}
> +
>  ObjectProperty *
>  object_class_static_property_add_uint32_ptr(ObjectClass *klass,
>                                              const char *name,

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


