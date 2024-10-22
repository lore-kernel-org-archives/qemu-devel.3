Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C743D1715E
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 04:32:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t36Yt-0007Hr-O2; Tue, 22 Oct 2024 00:32:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t36Ys-0007HU-Fk
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 00:32:02 -0400
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t36Yl-0006cN-3T
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 00:31:58 -0400
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-3e5fee32e76so1840613b6e.1
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2024 21:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729571510; x=1730176310; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=W38HLrDjvHS1Bya//zl/DbBG9mrU++l95Uy9irJfwNc=;
 b=sH/5TNyszRhxaQXYG70VhVbM5QmcRgTQR72QG4jTFK6PuMZ5l/QlvRhzhxnbbmWP23
 VZj/ZcueZwqU+WwEq6A5ZNaM/vLe9RkZBm5YGxeG/YgnjeZzDJYZBvwqXYVVnTAEdaQb
 mZ8tsaYM11tOHcqvlUdsEFkeQKcUZshYAb2XDWZd9cPDIxNArCCLW3DQ91FERRVfWVhH
 ylaGBsNwKeTw87k82e45U36LfFn8mv3uQwkZ/+QUIaYh9tgrswDKZwWKIZXTZ6fB/11E
 4zHkpU7bsjFCxuaAAuPHQ+qrlt+9Z+BaR4dkebOQzj0l7zXSdgjk64b9lI+Wka14h9tD
 t8Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729571510; x=1730176310;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=W38HLrDjvHS1Bya//zl/DbBG9mrU++l95Uy9irJfwNc=;
 b=SEYPjUzBjtSCR0gbCp3GUEpMQXN2EM6RH7B1WDSVeYJ+gC/9MGXqCeiUODIV6qK5eO
 a1L8jLZFIz5NKSGpyKcYuDtOs+EQvhj+NITouUMX0RcbjmI2PWwWUeK8Pny5jbHWgQl/
 L+XqQuloVHLXtoWKWDLf5VYZ56FXIPMBPnCNK3dyWO9NaififkdqGsGiuI644F4pfg+T
 474X+63HbakccjMZ3kwfn7ubphyVP3o1+vmYLSr284TkzcjGPuReHD2DsE81Ysa4VuOV
 jiGiQFTBWfsHx2SGzINogmD1HVgHmSJjrwpLeBHUCrP/PD07okBVfKERPwqM40wtWCXW
 G8gQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVthggnKV596xzOB2zGQtA/Mj6IdqfAEJansS4Yd6UJg6SXDrgNgWX5FUGzH29qj0dRyJVD65r+whRe@nongnu.org
X-Gm-Message-State: AOJu0YztOxW2LOPD2i+wIV+NX/LCbvY98/HN26yzj4GZ4YGUs2WXk5K3
 y8T6uQ8//+8dPSY1Wfx9METfUNCcGWmds4gTr4HytXDcjwj5QvdUc+AdK8/iQxA=
X-Google-Smtp-Source: AGHT+IG+khaOytjn1j32a5Nk6fRnSl5hW4UiEMCsjHK0f7ToM4tzmyu4Y0zDGwiudkoaecPXjvbL6Q==
X-Received: by 2002:a05:6870:440c:b0:277:fdb5:9ce5 with SMTP id
 586e51a60fabf-2892c331c8cmr12015861fac.27.1729571509764; 
 Mon, 21 Oct 2024 21:31:49 -0700 (PDT)
Received: from [192.168.100.49] ([45.176.88.171])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7eaeabd8955sm4034128a12.78.2024.10.21.21.31.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Oct 2024 21:31:49 -0700 (PDT)
Message-ID: <12b03ebb-6bc2-4ffe-99cc-4818b5d992ee@linaro.org>
Date: Tue, 22 Oct 2024 01:31:45 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/13] qdev: make properties array "const"
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Junjie Mao <junjie.mao@hotmail.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <eduardo@habkost.net>
References: <20241021163538.136941-1-pbonzini@redhat.com>
 <20241021163538.136941-11-pbonzini@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241021163538.136941-11-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22e;
 envelope-from=philmd@linaro.org; helo=mail-oi1-x22e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi,

On 21/10/24 13:35, Paolo Bonzini wrote:
> Constify all accesses to qdev properties, except for the
> ObjectPropertyAccessor itself.  This makes it possible to place them in
> read-only memory, and also lets Rust bindings switch from "static mut"
> arrays to "static"; which is advantageous, because mutable statics are
> highly discouraged.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   include/hw/qdev-core.h       |  4 ++--
>   include/hw/qdev-properties.h |  4 ++--
>   hw/core/qdev-properties.c    | 26 +++++++++++++-------------
>   system/qdev-monitor.c        |  2 +-
>   4 files changed, 18 insertions(+), 18 deletions(-)


> -void qdev_property_add_static(DeviceState *dev, Property *prop)
> +void qdev_property_add_static(DeviceState *dev, const Property *prop)
>   {
>       Object *obj = OBJECT(dev);
>       ObjectProperty *op;
> @@ -980,7 +980,7 @@ void qdev_property_add_static(DeviceState *dev, Property *prop)
>                                field_prop_getter(prop->info),
>                                field_prop_setter(prop->info),
>                                prop->info->release,
> -                             prop);
> +                             (Property *)prop);

I like the overall patch idea, but I'm not keep on casting
const to non-const. Should we adapt the callee -- here
object_property_add() -- to also take a const argument?

>   
>       object_property_set_description(obj, prop->name,
>                                       prop->info->description);
> @@ -994,7 +994,7 @@ void qdev_property_add_static(DeviceState *dev, Property *prop)
>   }
>   
>   static void qdev_class_add_property(DeviceClass *klass, const char *name,
> -                                    Property *prop)
> +                                    const Property *prop)
>   {
>       ObjectClass *oc = OBJECT_CLASS(klass);
>       ObjectProperty *op;
> @@ -1007,7 +1007,7 @@ static void qdev_class_add_property(DeviceClass *klass, const char *name,
>                                          field_prop_getter(prop->info),
>                                          field_prop_setter(prop->info),
>                                          prop->info->release,
> -                                       prop);
> +                                       (Property *)prop);
>       }
>       if (prop->set_default) {
>           prop->info->set_default_value(op, prop);
> @@ -1046,7 +1046,7 @@ static void qdev_get_legacy_property(Object *obj, Visitor *v,
>    * Do not use this in new code!  QOM Properties added through this interface
>    * will be given names in the "legacy" namespace.
>    */
> -static void qdev_class_add_legacy_property(DeviceClass *dc, Property *prop)
> +static void qdev_class_add_legacy_property(DeviceClass *dc, const Property *prop)
>   {
>       g_autofree char *name = NULL;
>   
> @@ -1058,12 +1058,12 @@ static void qdev_class_add_legacy_property(DeviceClass *dc, Property *prop)
>       name = g_strdup_printf("legacy-%s", prop->name);
>       object_class_property_add(OBJECT_CLASS(dc), name, "str",
>           prop->info->print ? qdev_get_legacy_property : prop->info->get,
> -        NULL, NULL, prop);
> +        NULL, NULL, (Property *)prop);
>   }

