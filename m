Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F600CD3445
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 18:56:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLQM8-0004Lb-W4; Fri, 08 May 2026 14:55:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wLQM6-0004LS-S9
 for qemu-devel@nongnu.org; Fri, 08 May 2026 14:55:23 -0400
Received: from mail-dy1-x1332.google.com ([2607:f8b0:4864:20::1332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wLQM5-0007Uh-0t
 for qemu-devel@nongnu.org; Fri, 08 May 2026 14:55:22 -0400
Received: by mail-dy1-x1332.google.com with SMTP id
 5a478bee46e88-2c156c4a9efso3178761eec.1
 for <qemu-devel@nongnu.org>; Fri, 08 May 2026 11:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778266519; x=1778871319; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TqQ7q5qS0MU5oGGFp6jCdYrumOm5X3Ek28lISUuERGI=;
 b=AEHp953R7tTvQ57v8aA8ZrfzUf4GJTsFcaT14uwbr0nd5UUbC2yCpZkEsw4qWZ0Hkl
 0YgBl+PhDIw50LrUv6tAKZeQbkoS6r3KsO6nmXtOBKfeJi1QDIiDAR3d3nxMSU2J3f8F
 yFsM38zObodw9GxtbWwIKgX5cH73E4CfT28X6qM4+brHmOzhun1oOgn5ooegOf1XSwdC
 r9oBRPflSS+hrHOfqcrVvkre+Ngo22CKpiJnnzh0FsV2WRbTRopXX15uRvS8cA9O2UnQ
 0MtrPltm3cPCGdb5hD7poAjMZHPxYdzXClPsS4RB11stnrkCHt4O425Zc0eyfKt2yygZ
 wXdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778266519; x=1778871319;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TqQ7q5qS0MU5oGGFp6jCdYrumOm5X3Ek28lISUuERGI=;
 b=tDx7v59wPcIiGnngCaoqPIARi8NAo1kywT6fKj1J670WHYo5UZMB6MaDNTXG4+yo9Q
 m2+Mkkl2wx1mt6GWDjaxzNaR2gHCp4TEfEaSYOI/HzABxTwcBG7Vk7VtpFB1rCCc0Kx8
 kUYcbsz4usRNJJUx5GqWvu+hzDKR11TV6M7PplWqaPtzUSZbhVSUCj0yWCDpsi8ZNlWa
 swpjVWEpd126Oe1ruJE7h4SZDoihF8Tz4Hs+ssefRoH13XghKrRfkw5E/Ci3PJtlEleb
 0BTfvH4/hBH8LIIYcRCfu3vfHBqh6G8B1YyZO97VKHeBP2SNRFZfNBFhtDLJBKBFY+fZ
 Rwkg==
X-Forwarded-Encrypted: i=1;
 AFNElJ97pcZK51nPG57Mo0LZN87aXkPqqL5Btpm/alsAh9BuPEHwYrZnm8ebVWr3WQgYQL0NXxoput/o0J1H@nongnu.org
X-Gm-Message-State: AOJu0YyVzqt1vnVOIsFpUN/a7tGF7H1CZDiTansiEFzI+TWrLnF1lHeg
 hb3Bgs618jf10zw/XH5Ly24jDPv6hU5haKvk+7VgQHC51KBLvoQmLfaitYGRrc3dTR0=
X-Gm-Gg: Acq92OEbfIiKezNxMB8AA4pAK2PDj2UA9rY8/H8IvJp4b+ibR7XXs67HkCbj/lcl4aG
 CtMXh5xpgkkRA6uTeiKc3Vp/z3aJ6Q58eEMHUYjNkNCMg7nNpifYiHCExZ8mY7PMFAKaYcVy4X2
 ZquN5rXDLxPeRDj0JvxNYWbd55vpE4Q9XgLorPetq0IOVvR7Ffdrj+Zt7i7cvq/wvw2SdkHGN3n
 vvDWaDXREXEUMRJ2FH6oYNpXUaw0hxzSNAJUDeXF/goNDnHOkq0yuBvG8Tj7hvNxG4rjei5iQQl
 AIfigIVGJHz0rz7EfpqjTxo7FKEhPLqU3Q6250AyR5kHqbOzIU80K+mAXbFDQjXQV2x4sCVP0Ff
 6vgIBBP0WXwQS+ay0LQMJVzhJ3O63i57Z2WbTases3g1oj4LCcueefqZSTOJRDkukDUgYpFyh19
 JpPlGCds2aGcaBt+6bG7h2hGQ4wbZ3s4JG7a+hKg45miK4PTkuiFm+KNCEeU8HKehPG7kcToE7I
 Vp7lqS67A==
X-Received: by 2002:a05:7300:72c8:b0:2f5:23fb:9aac with SMTP id
 5a478bee46e88-2f550b4320amr7038565eec.31.1778266518614; 
 Fri, 08 May 2026 11:55:18 -0700 (PDT)
Received: from ?IPV6:2600:381:c938:6375:4b0a:aabe:cbe1:bd0c?
 ([2600:381:c938:6375:4b0a:aabe:cbe1:bd0c])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2f88885b87dsm3984642eec.21.2026.05.08.11.55.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 May 2026 11:55:18 -0700 (PDT)
Message-ID: <21c6ed67-ad7a-440b-b6e8-20835cacd389@linaro.org>
Date: Fri, 8 May 2026 13:55:14 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/6] qom/object: register OBJECT and INTERFACE QOM
 types before main
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>, marcandre.lureau@redhat.com,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Max Filippov <jcmvbkbc@gmail.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
References: <20260505224826.2698753-1-pierrick.bouvier@oss.qualcomm.com>
 <20260505224826.2698753-3-pierrick.bouvier@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260505224826.2698753-3-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1332;
 envelope-from=richard.henderson@linaro.org; helo=mail-dy1-x1332.google.com
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

On 5/5/26 17:48, Pierrick Bouvier wrote:
> Those types are special, as they are the base of all other QOM types. In
> next commit, we'll introduce an extra step in module initialization for
> target-info-* types.
> 
> However, those types depend on TYPE_OBJECT, which is only registered
> at MODULE_INIT_QOM step.
> 
> To avoid having to introduce another step, and modify all code calling
> module_call_init(MODULE_INIT_QOM), we simply register those base types
> directly in the static constructor, before anything else.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>   qom/object.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/qom/object.c b/qom/object.c
> index f981e270440..a5d268d0722 100644
> --- a/qom/object.c
> +++ b/qom/object.c
> @@ -2839,7 +2839,7 @@ static void object_class_init(ObjectClass *klass, const void *data)
>                                     NULL);
>   }
>   
> -static void register_types(void)
> +static void __attribute__((constructor)) register_types(void)
>   {
>       static const TypeInfo interface_info = {
>           .name = TYPE_INTERFACE,
> @@ -2857,5 +2857,3 @@ static void register_types(void)
>       type_interface = type_register_internal(&interface_info);
>       type_register_internal(&object_info);
>   }
> -
> -type_init(register_types)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

As a followup QOM improvement, we could use this constructor to explicitly initialize 
type_table, and drop type_table_get() and its continual checking for NULL.


r~

