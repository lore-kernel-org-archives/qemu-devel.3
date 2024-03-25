Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 283DDC54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 17:48:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rooPs-000388-2h; Mon, 25 Mar 2024 13:47:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rooPp-00036R-WC
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 13:47:22 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rooPn-0008PM-OW
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 13:47:21 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-56c0d1bddc1so1632438a12.3
 for <qemu-devel@nongnu.org>; Mon, 25 Mar 2024 10:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711388838; x=1711993638; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bWrbnLxFKjOO8Zg9ju9PNohfLtfWQCN1aRYrxRosex8=;
 b=w8t/qqYKCjF1O6B8A4RP27CGaWp9UnSMtmDnJyWceJQidz32gFEBKPnJAYTAAodP/H
 pb7Z6Svg5aSygg/ZScGwHeSaYiiB9JEK367reSy57tnMzlXm/EEsduoZV0wOI6Gu8yqv
 bl1m7qMT8TR2PyWDvUE05o5+/nnG2FGBW413Pwqh2vW9NmLEBk1cDqV0ZY+IL4WdThio
 o9HUMxNRpoUtWtDGbzReShtL+aemB8tULMd5PFCgNHtxJoINVxAxYWnZyxD+U5l3SSWC
 2RhU2QoAXKaJmNpClDnKb4UageUhs4VVA7ghvkOne0D++C5v2CuW9U1z2rx3dIgLiKeF
 zq9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711388838; x=1711993638;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bWrbnLxFKjOO8Zg9ju9PNohfLtfWQCN1aRYrxRosex8=;
 b=aYIn2QaCt7HtC6/J6//79BTzaw738tIHLpjW5T/VXrMr1pdjgon6tctwyEwAPPtBls
 s5LwfH3DYJ25RfT4GGAt9aJxZSyWxdFDLRbud3E8jWFLyL4ZeSGRWcOJ6ko9CVOh2muz
 FF/ZYo5KGPZWDPZZ54fGCOu+9Kpso4pZSKhy0JzZp/rrtrgNm/neMdYcApnN0Sq5pd5o
 BVbwTStwf3iVek4WkjfObORBV2+QqvZ8h9SKhbrG3d/4P95fOfxGeFh8QjsyOK5KEikC
 8fK9Eml1RPZ7YDjbI9nLUiN5sTIAmNMP2hwzFP3mPqTKuvC9Ntl3mhaM5ntU51damV04
 B/Vg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW9APVuaX8dGPmrgOGhPAeo8+tqzKcrDnx310Q2LDeOPxDSjhGwVG2K3ndJoUgKnHK7o6Je0dnW9ZDWaVnQTzxnKv86Kyw=
X-Gm-Message-State: AOJu0Yy2llHgjcFEn2HoL3uGz933tuPCITbSs9zFNydw+DQIXdgAlxlU
 gRTaGbxtxMTSqI897MOChejjmu/McEld6R0yjuEnqGm0XVaXk+PzNPs1RPDlrYQ=
X-Google-Smtp-Source: AGHT+IEF0+fT0YxlBflDrqYqIPmDe0Qgg1vLpLHrSn1DsU5W/stmxgQ7YBcLYkGcJ6EWXlCsHyOUGA==
X-Received: by 2002:a17:907:1184:b0:a49:fa33:a413 with SMTP id
 uz4-20020a170907118400b00a49fa33a413mr2874748ejb.69.1711388837620; 
 Mon, 25 Mar 2024 10:47:17 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.208.214])
 by smtp.gmail.com with ESMTPSA id
 lu7-20020a170906fac700b00a46a9cdcfa5sm3256537ejb.162.2024.03.25.10.47.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 Mar 2024 10:47:17 -0700 (PDT)
Message-ID: <0caa3a2b-3869-4608-b408-73eff762fbe8@linaro.org>
Date: Mon, 25 Mar 2024 18:47:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] Refactor common functions between POSIX and
 Windows implementation
Content-Language: en-US
To: aidan_leuck@selinc.com, qemu-devel@nongnu.org
Cc: kkostiuk@redhat.com, berrange@redhat.com
References: <20240322174637.499113-1-aidan_leuck@selinc.com>
 <20240322174637.499113-2-aidan_leuck@selinc.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240322174637.499113-2-aidan_leuck@selinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x533.google.com
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

Hi Aidan,

On 22/3/24 18:46, aidan_leuck@selinc.com wrote:
> From: Aidan Leuck <aidan_leuck@selinc.com>
> 
> Signed-off-by: Aidan Leuck <aidan_leuck@selinc.com>
> ---
>   qga/commands-posix-ssh.c | 47 +--------------------------------
>   qga/commands-ssh-core.c  | 57 ++++++++++++++++++++++++++++++++++++++++
>   qga/commands-ssh-core.h  |  8 ++++++
>   qga/meson.build          |  1 +
>   4 files changed, 67 insertions(+), 46 deletions(-)
>   create mode 100644 qga/commands-ssh-core.c
>   create mode 100644 qga/commands-ssh-core.h

We already have:
- commands-common.h
- commands-posix-ssh.c

what about using the same pattern?
- commands-common-ssh.c

> diff --git a/qga/commands-posix-ssh.c b/qga/commands-posix-ssh.c
> index 236f80de44..9a71b109f9 100644
> --- a/qga/commands-posix-ssh.c
> +++ b/qga/commands-posix-ssh.c
> @@ -9,6 +9,7 @@
>   #include <locale.h>
>   #include <pwd.h>
>   
> +#include "commands-ssh-core.h"
>   #include "qapi/error.h"
>   #include "qga-qapi-commands.h"
>   
> @@ -80,37 +81,6 @@ mkdir_for_user(const char *path, const struct passwd *p,
>       return true;
>   }
>   
> -static bool
> -check_openssh_pub_key(const char *key, Error **errp)
> -{
> -    /* simple sanity-check, we may want more? */
> -    if (!key || key[0] == '#' || strchr(key, '\n')) {
> -        error_setg(errp, "invalid OpenSSH public key: '%s'", key);
> -        return false;
> -    }
> -
> -    return true;
> -}
> -
> -static bool
> -check_openssh_pub_keys(strList *keys, size_t *nkeys, Error **errp)
> -{
> -    size_t n = 0;
> -    strList *k;
> -
> -    for (k = keys; k != NULL; k = k->next) {
> -        if (!check_openssh_pub_key(k->value, errp)) {
> -            return false;
> -        }
> -        n++;
> -    }
> -
> -    if (nkeys) {
> -        *nkeys = n;
> -    }
> -    return true;
> -}
> -
>   static bool
>   write_authkeys(const char *path, const GStrv keys,
>                  const struct passwd *p, Error **errp)
> @@ -139,21 +109,6 @@ write_authkeys(const char *path, const GStrv keys,
>       return true;
>   }
>   
> -static GStrv
> -read_authkeys(const char *path, Error **errp)
> -{
> -    g_autoptr(GError) err = NULL;
> -    g_autofree char *contents = NULL;
> -
> -    if (!g_file_get_contents(path, &contents, NULL, &err)) {
> -        error_setg(errp, "failed to read '%s': %s", path, err->message);
> -        return NULL;
> -    }
> -
> -    return g_strsplit(contents, "\n", -1);
> -
> -}
> -
>   void
>   qmp_guest_ssh_add_authorized_keys(const char *username, strList *keys,
>                                     bool has_reset, bool reset,
> diff --git a/qga/commands-ssh-core.c b/qga/commands-ssh-core.c
> new file mode 100644
> index 0000000000..f165c4a337
> --- /dev/null
> +++ b/qga/commands-ssh-core.c
> @@ -0,0 +1,57 @@
> +/*
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include <qga-qapi-types.h>
> +#include <stdbool.h>
> +#include "qapi/error.h"
> +#include "commands-ssh-core.h"
> +
> +GStrv read_authkeys(const char *path, Error **errp)
> +{
> +    g_autoptr(GError) err = NULL;
> +    g_autofree char *contents = NULL;
> +
> +    if (!g_file_get_contents(path, &contents, NULL, &err))
> +    {

Please keep QEMU style while moving the code, see
https://www.qemu.org/docs/master/devel/submitting-a-patch.html#use-the-qemu-coding-style 
which explain how to run scripts/checkpatch.pl
before posting your patches.

Otherwise the refactor LGTM.

Regards,

Phil.

> +        error_setg(errp, "failed to read '%s': %s", path, err->message);
> +        return NULL;
> +    }
> +
> +    return g_strsplit(contents, "\n", -1);
> +}


