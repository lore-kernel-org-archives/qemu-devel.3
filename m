Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A08A8C5DF81
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 17:54:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwkTl-0007fB-Ai; Wed, 19 Aug 2026 13:53:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wwkTj-0007ed-PS
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 13:53:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wwkTi-0005Tj-5N
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 13:53:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787162009;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=znznNhCG1Dv9wDb3ZFQez5s2Q0scx0T+x7ZLee9vo74=;
 b=GCnTVXiGMVFvQEzSBapUmsXlUGjtS2KZ4XHUv7b+K9evDOX/wcqSuEOqKl7fyp4HSweVC8
 Kt3YXdfAcKlAXLbbtujmuwokTBw6KVqgj9hCdePzo4byR0yFRM1ljvE2Zhc2i9ONhErDF7
 5lc6gDmPHmGLKOLQv7P4Ea43Q3jaCCQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-695-Cvx_As-zNjKwXg79KObDsg-1; Wed,
 19 Aug 2026 13:53:25 -0400
X-MC-Unique: Cvx_As-zNjKwXg79KObDsg-1
X-Mimecast-MFC-AGG-ID: Cvx_As-zNjKwXg79KObDsg_1787162004
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E4E4F195609D; Wed, 19 Aug 2026 17:53:23 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 74EE01944DCD; Wed, 19 Aug 2026 17:53:22 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 11/15] qom/object.c: add
 object_class_property_add_uint16_ptr()
From: marcandre.lureau@redhat.com
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Cc: mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com, 
 philmd@mailo.com, aurelien@aurel32.net, peter.maydell@linaro.org, 
 pbonzini@redhat.com, richard.henderson@linaro.org, berrange@redhat.com, 
 marcandre.lureau@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org
In-Reply-To: <20260819133816.3497033-12-mark.caveayland@nutanix.com>
References: <20260819133816.3497033-1-mark.caveayland@nutanix.com>
 <20260819133816.3497033-12-mark.caveayland@nutanix.com>
Date: Wed, 19 Aug 2026 21:52:43 +0400
Message-Id: <178716196333.2018258.5136509672601641912.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3350;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=9Y39CwHDnK89/RHqP3bSqqkaAPh4sLMzLBhFIcoRZSw=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqhe1+LM5OJQdO61u10xiSqe7qa7PxmUUpUlCbe
 LbUOl0twX2JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaoXtfgAKCRDa6OEJdZac
 5bkgD/9sKp2WcmXZPgpjAua8P+zuejg13Yz0QEijIeO/TtJTUvFaVSbhZdjnZ7JC2g12w6YnOGl
 LISa9T3k+984MptBOxiUszi771lR2lqfD5mFQyFz32AK3BMXIpVC2/PPj0t3KhhCHWa7jldQiIi
 97YrjiYIwJPK6gAFZJz2Z/oty/IkVvTRKOFb/poj6IhdWpCkN/ToB69CrzHKLIbgUMIyIvJeKfF
 J/pCDpSVvRs3IDcUQgKZnkfaWbUAl/NABIt7kmFO2RNMp4RZlGt0v2n92JTBkCca8f7bIRipDXe
 JB4o6jkS50CmAXutNX4pouD3nXL4cThL3tf3C6w1s2C3BlTMKvlqXWlhjPNUS8RfjhV9Eh88VW+
 bpJe3k1tClR2I2Vx/tB8kwFs5wCoqL4UFWXVWjzpeT3XtItLlt8YD3lmU2Zpi42ys4GIPujKXRa
 2PxlpsAATO2sVeT+T/Y7oh0Usf0ODpa0hZFrLFuk8s686Geb59JkRT1XNFMYRD2CoLyHAxxiDGj
 0smv/lwcnluDmAzg2uSzRxd/kN8rVTK+M/n4dLYgD58Sf1ad1u+XlatRbZvEYx/mCV3M4qAJFyM
 76c3IGcM+zXJGvIYR4N7ERlc3gI56NID0uRCog3xjFLZaK9KgGxynpXR7uYEWQmGaHCp6bza+By
 LA9mKV6lr/SyjFw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

> This adds a class property that references a uint16_t within the object instance
> and is intended to be a replacement for object_property_add_uint16_ptr().
> 
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> Message-ID: <20260819133816.3497033-12-mark.caveayland@nutanix.com>
>
> diff --git a/include/qom/object.h b/include/qom/object.h
> index b469740782ac..dce1c5ebc8b9 100644
> --- a/include/qom/object.h
> +++ b/include/qom/object.h
> @@ -2108,6 +2108,24 @@ ObjectProperty *object_property_add_uint16_ptr(Object *obj, const char *name,
>                                      const uint16_t *v,
>                                      ObjectPropertyFlags flags);
>  
> +/**
> + * object_class_property_add_uint16_ptr:
> + * @klass: the object class to add a property to
> + * @name: the name of the property
> + * @offset: the offset from the object instance where the uint8 value is
> + *   stored

Should be "uint16 value", not "uint8 value".
otherwise lgtm

> + * @flags: bitwise-or'd ObjectPropertyFlags
> + *
> + * Add an integer property in memory.  This function will add a
> + * property of type 'uint16'.
> + *
> + * Returns: The newly added property on success, or %NULL on failure.
> + */
> +ObjectProperty *object_class_property_add_uint16_ptr(ObjectClass *klass,
> +                                         const char *name,
> +                                         ptrdiff_t offset,
> +                                         ObjectPropertyFlags flags);
> +
>  /**
>   * object_class_static_property_add_uint16_ptr:
>   * @klass: the object class to add a static property to
> diff --git a/qom/object.c b/qom/object.c
> index b82f10376a44..ca426b87b9dd 100644
> --- a/qom/object.c
> +++ b/qom/object.c
> @@ -2742,6 +2742,7 @@ static void *object_class_prop_ptr(Object *obj, ptrdiff_t offset)
>      OBJECT_CLASS_PROPERTY_SCALAR_SETTER(type)
>  
>  DEFINE_OBJECT_CLASS_PROPERTY_SCALAR_METHODS(uint8)
> +DEFINE_OBJECT_CLASS_PROPERTY_SCALAR_METHODS(uint16)
>  DEFINE_OBJECT_CLASS_PROPERTY_SCALAR_METHODS(uint32)
>  
>  #undef OBJECT_CLASS_PROPERTY_SCALAR_GETTER
> @@ -2873,6 +2874,26 @@ object_property_add_uint16_ptr(Object *obj, const char *name,
>                                 getter, setter, NULL, (void *)v);
>  }
>  
> +ObjectProperty *
> +object_class_property_add_uint16_ptr(ObjectClass *klass, const char *name,
> +                                     ptrdiff_t offset,
> +                                     ObjectPropertyFlags flags)
> +{
> +    ObjectPropertyAccessor *getter = NULL;
> +    ObjectPropertyAccessor *setter = NULL;
> +
> +    if ((flags & OBJ_PROP_FLAG_READ) == OBJ_PROP_FLAG_READ) {
> +        getter = property_class_get_uint16_ptr;
> +    }
> +
> +    if ((flags & OBJ_PROP_FLAG_WRITE) == OBJ_PROP_FLAG_WRITE) {
> +        setter = property_class_set_uint16_ptr;
> +    }
> +
> +    return object_class_property_add(klass, name, "uint16",
> +                                     getter, setter, NULL, (void *)offset);
> +}
> +
>  ObjectProperty *
>  object_class_static_property_add_uint16_ptr(ObjectClass *klass,
>                                              const char *name,

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


