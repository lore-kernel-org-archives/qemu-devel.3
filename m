Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F009EC27C53
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2024 06:25:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFT1c-0001Mc-Bw; Fri, 07 Jun 2024 02:24:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sFT1b-0001MP-Cv
 for qemu-devel@nongnu.org; Fri, 07 Jun 2024 02:24:31 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sFT1Z-0008St-Gv
 for qemu-devel@nongnu.org; Fri, 07 Jun 2024 02:24:31 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a6265d48ec3so204014666b.0
 for <qemu-devel@nongnu.org>; Thu, 06 Jun 2024 23:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717741463; x=1718346263; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6GDfOeQG7wlVzHncOd6AmTSekULNx9I4Gb/6O209FJQ=;
 b=MIp+96uc26VicCZGF0N/6/1kg0gxq0xpXWgEWb1Ema3iOxOklP/lHxlBcZb/ee+xrz
 lkpglhXTQoodCXfVfhVBm03VNGOKMPRjhsE4NIDhBxJiF9zOx3C86QVyDD2DwbLUYAiB
 gU3JmifoTRqIEXK6qZtK+m3IKM84ceGz5SxCRLl0fi07naKb2QFiwS3uUhjjKqwI7AQS
 KkRQlzChONL/eCkbnqRODFP7Y7QxzUO7KE7s3WtmiusHO92LvH1ivLwnmS7RDzbnYaYv
 6OtwkgbFb4GW15xzdMf9pQpniV2ZbAW94fg3pFkjug7pwr3qzb+YwNuvGkAsXo0l65q4
 H2Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717741463; x=1718346263;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6GDfOeQG7wlVzHncOd6AmTSekULNx9I4Gb/6O209FJQ=;
 b=Hu7mCK8ZRor4RpdJWyMozRUArHRsYEw8xv8MeJkOuSojACtJjHTCA0VOWqOYe3ROwS
 zB/IbRuhcLBmhUe3Wh9NWzGDOgyC8ml1WCDM5pyi209c3roldU3rUDE4yvLm8Dy1ibH/
 aAgvV2rMMVk3a33CmD+jY7ORLTdtc39b1/P4bwpoPa1JjDdSskKmzjxv2ySvCY6FZywF
 H5N4oq/7vuaCxadWAxeBHslcnhuIfA7qtLoWzaa8Yx6VYrj9lSLnw6fNknDDsBXtgC4m
 OUqh2XJcfmdxq3mamGKESL6YGoEn1jXOvEBlVwaEqRfiOicqn0e8GLL6HAMGoelVlbDs
 6tag==
X-Forwarded-Encrypted: i=1;
 AJvYcCWItzc0hVFVNNcJIF2moamh4bd69HeH+hjFYjNU8ayD/f/FTtRDFKkmh3CBlyijRuJ73DcG/k9uvyz5knVqT+gKbnDfhfs=
X-Gm-Message-State: AOJu0Yy0DtSzptWlTq5E+9LtbLmHPk4ZIWAhQzOGPsiU72ifZT4mE26Y
 l7zHxPNhSXbMCW13K182jP5bj2A3NtjK9989Z/75HoTc7eWDoxNb0P+6jWYh2kQ=
X-Google-Smtp-Source: AGHT+IFX7XFw5OqcHaDgPnQAL5STaH9JhFTt7PFRbVL6uAUYwC/vLBxZN52BALtIPvO7r7kMYAiTVw==
X-Received: by 2002:a17:906:2355:b0:a68:ae1b:edbc with SMTP id
 a640c23a62f3a-a6cd675cda6mr106493966b.24.1717741463263; 
 Thu, 06 Jun 2024 23:24:23 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.196.231])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6c8070e9b1sm194125566b.165.2024.06.06.23.24.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Jun 2024 23:24:22 -0700 (PDT)
Message-ID: <fcd15341-26a1-4ec5-a2c9-ddb862cf9ec0@linaro.org>
Date: Fri, 7 Jun 2024 08:24:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] qom: allow to mark objects as deprecated or not
 secure.
To: Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster
 <armbru@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Eric Blake <eblake@redhat.com>, Thomas Huth <thuth@redhat.com>
References: <20240606143010.1318226-1-kraxel@redhat.com>
 <20240606143010.1318226-2-kraxel@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240606143010.1318226-2-kraxel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 6/6/24 16:30, Gerd Hoffmann wrote:
> Add flags to ObjectClass for objects which are deprecated or not secure.
> Add 'deprecated' and 'not-secure' bools to ObjectTypeInfo, report in
> 'qom-list-types'.  Print the flags when listing devices via '-device
> help'.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>   include/qom/object.h  | 3 +++
>   qom/qom-qmp-cmds.c    | 8 ++++++++
>   system/qdev-monitor.c | 8 ++++++++
>   qapi/qom.json         | 8 +++++++-
>   4 files changed, 26 insertions(+), 1 deletion(-)
> 
> diff --git a/include/qom/object.h b/include/qom/object.h
> index 13d3a655ddf9..419bd9a4b219 100644
> --- a/include/qom/object.h
> +++ b/include/qom/object.h
> @@ -136,6 +136,9 @@ struct ObjectClass
>       ObjectUnparent *unparent;
>   
>       GHashTable *properties;
> +
> +    bool deprecated;
> +    bool not_secure;

LGTM but I'd rather use a reason string instead of a boolean,
so we are forced to justify.

That would be in line with MachineClass::deprecation_reason:

  * MachineClass:
  * @deprecation_reason: If set, the machine is marked as deprecated.
  *    The string should provide some clear information about what to
  *    use instead.

>   };
>   
>   /**
> diff --git a/qom/qom-qmp-cmds.c b/qom/qom-qmp-cmds.c
> index e91a2353472a..325ff0ba2a25 100644
> --- a/qom/qom-qmp-cmds.c
> +++ b/qom/qom-qmp-cmds.c
> @@ -101,6 +101,14 @@ static void qom_list_types_tramp(ObjectClass *klass, void *data)
>       if (parent) {
>           info->parent = g_strdup(object_class_get_name(parent));
>       }
> +    if (klass->deprecated) {
> +        info->has_deprecated = true;
> +        info->deprecated = true;
> +    }
> +    if (klass->not_secure) {
> +        info->has_not_secure = true;
> +        info->not_secure = true;
> +    }
>   
>       QAPI_LIST_PREPEND(*pret, info);
>   }
> diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
> index 6af6ef7d667f..effdc95d21d3 100644
> --- a/system/qdev-monitor.c
> +++ b/system/qdev-monitor.c
> @@ -144,6 +144,8 @@ static bool qdev_class_has_alias(DeviceClass *dc)
>   
>   static void qdev_print_devinfo(DeviceClass *dc)
>   {
> +    ObjectClass *klass = OBJECT_CLASS(dc);
> +
>       qemu_printf("name \"%s\"", object_class_get_name(OBJECT_CLASS(dc)));
>       if (dc->bus_type) {
>           qemu_printf(", bus %s", dc->bus_type);
> @@ -157,6 +159,12 @@ static void qdev_print_devinfo(DeviceClass *dc)
>       if (!dc->user_creatable) {
>           qemu_printf(", no-user");
>       }
> +    if (klass->deprecated) {
> +        qemu_printf(", deprecated");
> +    }
> +    if (klass->not_secure) {
> +        qemu_printf(", not-secure");
> +    }
>       qemu_printf("\n");
>   }
>   
> diff --git a/qapi/qom.json b/qapi/qom.json
> index 8bd299265e39..3f20d4c6413b 100644
> --- a/qapi/qom.json
> +++ b/qapi/qom.json
> @@ -163,10 +163,16 @@
>   #
>   # @parent: Name of parent type, if any (since 2.10)
>   #
> +# @deprecated: the type is deprecated (since 9.1)
> +#
> +# @not-secure: the type (typically a device) is not considered
> +#     a security boundary (since 9.1)
> +#
>   # Since: 1.1
>   ##
>   { 'struct': 'ObjectTypeInfo',
> -  'data': { 'name': 'str', '*abstract': 'bool', '*parent': 'str' } }
> +  'data': { 'name': 'str', '*abstract': 'bool', '*parent': 'str',
> +            '*deprecated': 'bool', '*not-secure': 'bool' } }
>   
>   ##
>   # @qom-list-types:


