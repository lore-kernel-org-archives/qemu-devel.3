Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A744C5DF85
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 17:53:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwkTd-0007bS-AL; Wed, 19 Aug 2026 13:53:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wwkTb-0007aR-8A
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 13:53:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wwkTZ-0005RX-Jx
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 13:53:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787162000;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zzHymwvufz9uUy1m8PxV3GbR79zDKFCy+bCNG5STAtg=;
 b=VAJIjb/SzByVTMnlev2Yi/KXelp0PyfssQPaIPQ2NCSZZp/ltbfNo9UOkETZBKV04VuZHm
 /DwaX0xMtFY5xaWCe/blOepN3QFNWknz/S44unx2oCj3YpotBkZMG9gCbUgjmt15z6FZ4O
 A66P6260yPzo7E5aKyBtwpCftbHeYwA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-578-FWXND1y1M-KPTg93ZXdaEA-1; Wed,
 19 Aug 2026 13:53:17 -0400
X-MC-Unique: FWXND1y1M-KPTg93ZXdaEA-1
X-Mimecast-MFC-AGG-ID: FWXND1y1M-KPTg93ZXdaEA_1787161996
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 272731955F5A; Wed, 19 Aug 2026 17:53:16 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3B2A030002EC; Wed, 19 Aug 2026 17:53:13 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 09/15] qom/object.c: add
 object_class_property_add_bool_ptr()
From: marcandre.lureau@redhat.com
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Cc: mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com, 
 philmd@mailo.com, aurelien@aurel32.net, peter.maydell@linaro.org, 
 pbonzini@redhat.com, richard.henderson@linaro.org, berrange@redhat.com, 
 marcandre.lureau@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org
In-Reply-To: <20260819133816.3497033-10-mark.caveayland@nutanix.com>
References: <20260819133816.3497033-1-mark.caveayland@nutanix.com>
 <20260819133816.3497033-10-mark.caveayland@nutanix.com>
Date: Wed, 19 Aug 2026 21:52:43 +0400
Message-Id: <178716196332.2018258.9610593235879631054.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3626;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=dVHHTwgtzEhqCflOeFY2K+zbIkcFIO9Dpc1bPCJjVG8=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqhe19QFt6XlRKqorEmJRLvv13/q29IqdLXOWGo
 hTunJuAg3SJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaoXtfQAKCRDa6OEJdZac
 5W29D/9ycie3LkntMyNWYuCuYQaV8nA9Zc9QT2hvccFDSaPh+ni+tbagFo0qJ4JRklePspxfe7p
 7HfPNcITHDVbSu9YyMpvPNlDAuQ70FYV+WVvI4cyIyqcu/UJkJp+FasUELTkyGUhOMIJStAthng
 0XbaUAKcTHbKfdFgHLBKUKI5WebkkgLhBu7ZGiOUvFpAt/FkgTDoRRvbl30yaOBWU5AG/HGY5iK
 0MxY0vAcfO2g/DvcuceCnn+VmsXclV/Q38MMdmriyR1uhDtNdsoug8Hy+7L3AhC2DQK92rZSBBx
 X7CHsdUk80A5vipYBEjteuLF927H/nOoe6k+O+y5uV+7z32GRTnXTwAd8QKvcLiJeaBVn+6FuG9
 UYGPXorOZXlSSxfjtcRPjoxSzfSJrQ8HdUQqahjU2qgTFFWUQUK6IX0KyAOdmciR6iBZZvHW6rk
 gUctdxtciZFejjYusEvkWEWnhygg786Gv6wpCs27w9WfAp0IbEg+XL1GwnSQdz6cUMG3utUf1L7
 5omRgQd9XJQ2uwp/YExJYckvaYvlJYps+O0OC14zXuNECD/EgSUlL7gY/6I/N60EetUKwldFF85
 W/SDLiocHatkCOhBnDJCWDKU7qZJMHDtqahl7wd7UM0ij+pk4ptpIZg8c0xw2pbKI1/MhTghKKN
 UXfs9zPlw1TdoWA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

> This adds a class property that references a bool within the object instance
> and is intended to be used as a replacement for object_class_property_add_bool()
> where possible.
> 
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> Message-ID: <20260819133816.3497033-10-mark.caveayland@nutanix.com>
>
> diff --git a/include/qom/object.h b/include/qom/object.h
> index e0c88453b1e0..b469740782ac 100644
> --- a/include/qom/object.h
> +++ b/include/qom/object.h
> @@ -2017,6 +2017,24 @@ typedef enum {
>      OBJ_PROP_FLAG_READWRITE = (OBJ_PROP_FLAG_READ | OBJ_PROP_FLAG_WRITE),
>  } ObjectPropertyFlags;
>  
> +/**
> + * object_class_property_add_bool_ptr:
> + * @klass: the object class to add a property to
> + * @name: the name of the property
> + * @offset: the offset from the object instance where the bool value is
> + *   stored
> + * @flags: bitwise-or'd ObjectPropertyFlags
> + *
> + * Add an integer property in memory.  This function will add a

"Add an integer property" -> "Add a boolean property"

> + * property of type 'bool'.
> + *
> + * Returns: The newly added property on success, or %NULL on failure.
> + */
> +ObjectProperty *object_class_property_add_bool_ptr(ObjectClass *klass,
> +                                         const char *name,
> +                                         ptrdiff_t offset,
> +                                         ObjectPropertyFlags flags);
> +
>  /**
>   * object_property_add_uint8_ptr:
>   * @obj: the object to add a property to
> diff --git a/qom/object.c b/qom/object.c
> index fe032c96190c..b82f10376a44 100644
> --- a/qom/object.c
> +++ b/qom/object.c
> @@ -2749,6 +2749,49 @@ DEFINE_OBJECT_CLASS_PROPERTY_SCALAR_METHODS(uint32)
>  #undef DEFINE_OBJECT_CLASS_PROPERTY_SCALAR_METHODS
>  
>  
> +static void property_class_get_bool_ptr(Object *obj, Visitor *v,
> +                                        const char *name,
> +                                        void *opaque, Error **errp)
> +{
> +    bool value = *(bool *)object_class_prop_ptr(obj, (ptrdiff_t)opaque);
> +
> +    visit_type_bool(v, name, &value, errp); \

extra \

> +}
> +
> +static void property_class_set_bool_ptr(Object *obj, Visitor *v,
> +                                        const char *name,
> +                                        void *opaque, Error **errp)
> +{
> +    bool *field = (bool *)object_class_prop_ptr(obj, (ptrdiff_t)opaque);
> +    bool value;
> +
> +    if (!visit_type_bool(v, name, &value, errp)) {
> +        return;
> +    }
> +
> +    *field = value;
> +}
> +
> +ObjectProperty *
> +object_class_property_add_bool_ptr(ObjectClass *klass, const char *name,
> +                                   ptrdiff_t offset,
> +                                   ObjectPropertyFlags flags)
> +{
> +    ObjectPropertyAccessor *getter = NULL;
> +    ObjectPropertyAccessor *setter = NULL;
> +
> +    if ((flags & OBJ_PROP_FLAG_READ) == OBJ_PROP_FLAG_READ) {
> +        getter = property_class_get_bool_ptr;
> +    }
> +
> +    if ((flags & OBJ_PROP_FLAG_WRITE) == OBJ_PROP_FLAG_WRITE) {
> +        setter = property_class_set_bool_ptr;
> +    }
> +
> +    return object_class_property_add(klass, name, "bool",
> +                                     getter, setter, NULL, (void *)offset);
> +}
> +
>  ObjectProperty *
>  object_property_add_uint8_ptr(Object *obj, const char *name,
>                                const uint8_t *v,

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


