Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5BF606A31D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 06:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ccj3tFOJ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJ3Qa-0003AL-4t; Tue, 20 Oct 2026 02:34:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xJ3QU-00039J-DR
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 02:34:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xJ3QS-0007yG-Me
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 02:34:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792478060;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2L1Riof/tsskGgWRRN1Q63y9Y2v2VJrWVSW2rnCZKzY=;
 b=ccj3tFOJYeGhbli2FoT+mtWgXNEtrcidI8w1wS+r+iVuMuJsfLaH8oxWG6UFWHQOzurVlL
 bcXU+FuXt2l99W9c6i9EmpFKTspu6uCd9Pk1mzy/qKy8PFetdm9ypGe4dhwcCC26wc+y0J
 PYpu4+x76jWyoP8JjdsJCi4Ob+EEYIk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-104-2r0N0Zm9OZyFzP2rfZlPTw-1; Tue,
 20 Oct 2026 02:34:09 -0400
X-MC-Unique: 2r0N0Zm9OZyFzP2rfZlPTw-1
X-Mimecast-MFC-AGG-ID: 2r0N0Zm9OZyFzP2rfZlPTw_1792478048
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 87D06180266E; Tue, 20 Oct 2026 06:34:08 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 899B241B; Tue, 20 Oct 2026 06:34:07 +0000 (UTC)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v6 17/65] qom: add
 object_{class_}property_add_qapi_enum
From: marcandre.lureau@redhat.com
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, pbonzini@redhat.com, 
 berrange@redhat.com, michael.roth@amd.com, 
 pierrick.bouvier@oss.qualcomm.com, philmd@oss.qualcomm.com, 
 kkostiuk@redhat.com, alistair.francis@wdc.com, amachhiw@linux.ibm.com
In-Reply-To: <20261019141929.1594337-18-armbru@redhat.com>
References: <20261019141929.1594337-1-armbru@redhat.com>
 <20261019141929.1594337-18-armbru@redhat.com>
Date: Tue, 20 Oct 2026 10:33:32 +0400
Message-Id: <179247801297.2782576.3885857387150737502.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=5824;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=ADTeQF6S9CBHCuqkKyxeWb8Tkxsq7mZo+ZjfOe8iq28=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq1wtC7LFRMacxQVA6linFkQv5fgUQHqH/lruCO
 2mmMUSmB4OJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCatcLQgAKCRDa6OEJdZac
 5UgyD/9nXM6tOIkmlAHn3vgKlwKBgb+eT5xY3JVW/8WcPnYjiDs1rhher19bnkDmAtexJ6AECFU
 6GybtJ2gJCTGUrZv/T7YRuSaYWxKOUf9gOlVyo2CmcDvCE2qkt7w7Oe0txgWL6h1PF6Iny7JM6f
 nO7kY3zB0BarkfAzvvLVCPWwTu0yvDY5Gp8ZWyAfLMjSKoA+3zqcc2/XoWiRcv9dRW4HQCQ1MKb
 nZdaMDtmSMpFtHIvKOUE4hwa2q49bbGFTypNELsh6QiWfQuFUapFbPYZN37bP7nV5LNmdnYI0vx
 qkAUIIvddAuwm6PRrhaky+CovjsT0T4EanVxO23vGkoO2Fpd4fQsJnqAyivICksRjOypHPlT57X
 e4Oz8yUCz7digs/lSdJWHIk6j52bnMPYkkvqVqms7VIwj4Ef+cqpAZ9wYLEgYrsIz8GKQKnMouE
 t48Hjh6iVTWY6cd2qlRDgfsKCjzWmRob9qLEu81s73FmULyPx+ZUH4eK2GiqXMeVlNHj+z91c3O
 slJNiK6QgOnmR32gg7mODEQyHngIycJWrf3xZG3xohsnD75xRwFpPaYAns8F+lPPLE2sIaWObpV
 wlKsXq2xkx1dPO7mwlXut5UJWATIB6KbY3ER/0ERJkgWjC2bQgen6OVPGg+E6073tYTSf3mufXG
 O/UzQ2sxjIyXxMA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.329,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Message-ID: <20261019141929.1594337-18-armbru@redhat.com>
> ---
>  include/qom/object.h | 74 ++++++++++++++++++++++++++++++++++++
>  qom/object.c         | 89 +++++++++++++++++++++++++++++++++++++++++---
>  2 files changed, 158 insertions(+), 5 deletions(-)
>
> diff --git a/include/qom/object.h b/include/qom/object.h
> index 365d819d35a3..ce9375f37af9 100644
> --- a/include/qom/object.h
> +++ b/include/qom/object.h
> @@ -2006,6 +2006,80 @@ ObjectProperty *object_class_property_add_enum(ObjectClass *klass,
>                                      int (*get)(Object *, Error **),
>                                      void (*set)(Object *, int, Error **));
>  
> +/**
> + * struct QapiEnumProp: Descriptor for a property backed by a QAPI enum type
> + *
> + * Binds a QOM object property to a QAPI enum, providing automatic
> + * string<->int conversion through QAPI visitors and optional
> + * default-value initialization during object instance init.
> + *
> + * Use the QAPI_ENUM_PROP() macro to construct instances inline.
> + *
> + * @name: property name exposed on the QOM object
> + * @description: human-readable description (shown in ``-device help``, etc.)
> + * @default_value: initial enum value applied via @set during instance init,
> + *                 or -1 (the QAPI_ENUM_PROP default) to skip initialization
> + * @qapi_type: pointer to the generated QAPITypeInfo for the enum
> + *             (provides the string<->int lookup table)
> + * @get: getter that returns the current enum value as int, or -1 on error
> + * @set: setter that receives the enum value as int; %NULL for read-only props
> + */
> +typedef struct QapiEnumProp {
> +    const char *name;
> +    const char *description;
> +    const int default_value;
> +    const QAPITypeInfo *qapi_type;
> +    int (*get)(Object *, Error **);
> +    void (*set)(Object *, int, Error **);
> +} QapiEnumProp;
> +
> +#define QAPI_ENUM_PROP(...) ({                                           \
> +    static const QapiEnumProp _prop = {                                  \
> +        .default_value = -1, __VA_ARGS__                                 \
> +    };                                                                   \
> +    &_prop; })
> +
> +/**
> + * object_property_add_qapi_enum:
> + * @obj: the object to add a property to
> + * @prop: property descriptor
> + *
> + * Add an enum property with QAPI type association.
> + *
> + * Returns: The newly added property on success, or %NULL on failure.
> + */
> +ObjectProperty *
> +object_property_add_qapi_enum(Object *obj, const QapiEnumProp *prop);
> +
> +/**
> + * object_class_property_add_qapi_enum:
> + * @klass: the class object to add a property to
> + * @prop: property descriptor
> + *
> + * Add an enum property with QAPI type association.
> + *
> + * Use the QAPI_ENUM_PROP() macro to construct the property descriptor
> + * inline. If .default_value is not set, the property is not initialized
> + * (default_value is -1). Otherwise, the setter is called with
> + * default_value during object instance init.
> + *
> + * Example::
> + *
> + *   object_class_property_add_qapi_enum(oc, QAPI_ENUM_PROP(
> + *       .name = "policy",
> + *       .description = "Set the NUMA policy",
> + *       .default_value = HOST_MEM_POLICY_DEFAULT,
> + *       .qapi_type = &HostMemPolicy_type_info,
> + *       .get = my_get_policy,
> + *       .set = my_set_policy,
> + *   ));
> + *
> + * Returns: The newly added property on success, or %NULL on failure.
> + */
> +ObjectProperty *
> +object_class_property_add_qapi_enum(ObjectClass *klass,
> +                                    const QapiEnumProp *prop);
> +
>  /**
>   * object_property_add_qapi:
>   * @obj: the object to add a property to
> diff --git a/qom/object.c b/qom/object.c
> index bebbfc43556d..c1aa2b96fcc2 100644
> --- a/qom/object.c
> +++ b/qom/object.c
> @@ -1219,7 +1219,7 @@ static void object_class_foreach_tramp(gpointer key, gpointer value,
>          return;
>      }
>  
> -    if (data->implements_type && 
> +    if (data->implements_type &&
>          !object_class_dynamic_cast(k, data->implements_type)) {
>          return;
>      }
> @@ -1786,7 +1786,6 @@ int object_property_get_enum(Object *obj, const char *name,
>      char *str;
>      int ret;
>      ObjectProperty *prop = object_property_find_err(obj, name, errp);
> -    EnumProperty *enumprop;
>  
>      if (prop == NULL) {
>          return -1;
> @@ -1799,14 +1798,17 @@ int object_property_get_enum(Object *obj, const char *name,
>          return -1;
>      }
>  
> -    enumprop = prop->opaque;
> -
>      str = object_property_get_str(obj, name, errp);
>      if (!str) {
>          return -1;
>      }
>  
> -    ret = qapi_enum_parse(enumprop->lookup, str, -1, errp);
> +    if (prop->qapi_type) {
> +        ret = qapi_enum_parse(prop->qapi_type->lookup, str, -1, errp);
> +    } else {
> +        EnumProperty *enumprop = prop->opaque;
> +        ret = qapi_enum_parse(enumprop->lookup, str, -1, errp);
> +    }
>      g_free(str);
>  
>      return ret;
> @@ -2609,6 +2611,83 @@ object_class_property_add_enum(ObjectClass *klass, const char *name,
>                                       prop);
>  }
>  
> +static void get_qapi_enum(Object *obj, Visitor *v, const char *name,
> +                          void *opaque, Error **errp)
> +{
> +    const QapiEnumProp *prop = opaque;
> +    int value;
> +    Error *err = NULL;
> +
> +    value = prop->get(obj, &err);

It could assert (value != -1 || err)

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


