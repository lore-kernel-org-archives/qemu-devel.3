Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41226C54E60
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 13:13:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmZGr-0008Fm-13; Tue, 19 Mar 2024 09:12:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rmZGo-0008FY-VT
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 09:12:46 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rmZGn-00069R-8N
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 09:12:46 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-56ba6c83805so53917a12.0
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 06:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710853963; x=1711458763; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WfKPU/MNZF0rvwYCuG3/a6UB090EvsdzGfO7tmpsLtI=;
 b=dExLTtjvlan3GsRmT0jOpnJTbkdvGQmzrAqKvBDTLoqfCOxLF7PjkuoyDX4rRT9+y6
 caiy0Dir/a3/dtQOkU4TW4RcLBijdgcJGNzryn710tlv30r6bN8dvCQrbJfU8GFRLvlh
 NB6QiT1hAJaNsxXWSK7+ciUedn72jwHWuZ+ew6Bn7Vomdt+H4Ltoq0jgh0pkbhE3a87q
 2NOOq8C2+2yNYnzcP+DDySDofjBhOq4iguBFOEpzKzXRawFuHZgS//r+f8h95VTGp9Tc
 mnuTWP0vQnQYrPnEfYyoD2QXkH2DfOIzgMqqd5v5eNMntUkGIK/KZJwt6HS/N2aUMSPi
 Xo/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710853963; x=1711458763;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WfKPU/MNZF0rvwYCuG3/a6UB090EvsdzGfO7tmpsLtI=;
 b=UMsMImaY3/TExj3Uy635zfsAXtMjzTXPDh4oo4cTwPAtMgSUJK6+VDRHIlL9Mw1Kss
 SZa6osfDGc/dP69r0ltvkBB5Z+8BPZB0aOKeGnkz2iWyMnviQwZMIQd/f5dS+G4DM7b1
 N0iyZ8UuUxZMeMiDfCW8X571RHzrUmE80uDQ7llUbom0zZAzpD5rbhGgGQ6eZneweL8l
 SCODMzHRqqmTDijxaafPX50EDbfJAaxV912kHz6sW8zpWCDX6WNJ7+XeYfThq4WhqfIt
 u23vrAy0zcQs/BoRUWHC27S4+2cha5BYl7LlXjUmsYit7shTuyCiZj53bOZh4CyxMpe8
 gzbQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV3tiflGQS7MW9xgnvmsN2qJ8MFJcGyKpVFu00grXhuOWOamnX5+5D25bROM5LtC8boyTLBaQnR6ZKcZkb00lvCo120H7k=
X-Gm-Message-State: AOJu0YyAPvJbYDqTVMbX2PYQ4DGwR/6BEnhI6s8xlmFqdvYaXZhaMxn/
 ekGrfX1WMO+PZWKJ7BO3b7Pj+8G9Pp/1FdyrwG81UXkCSi1QiD60Jh9eASmWRYyrL0MbVyd7wcu
 qa8o=
X-Google-Smtp-Source: AGHT+IE+/WX1Cp1TFIjqBVaUB+y0sFYbWljW7NEvvu515vIlscv3wvJNER6q5QQ3/RM9ZGB2UeqfzA==
X-Received: by 2002:a05:6402:1945:b0:566:fbf5:a279 with SMTP id
 f5-20020a056402194500b00566fbf5a279mr11239175edz.20.1710853963599; 
 Tue, 19 Mar 2024 06:12:43 -0700 (PDT)
Received: from [192.168.1.24] ([102.35.208.160])
 by smtp.gmail.com with ESMTPSA id
 f6-20020a056402194600b0056b98d7ba00sm630712edz.90.2024.03.19.06.12.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Mar 2024 06:12:43 -0700 (PDT)
Message-ID: <9eec79a8-6ebd-4d41-af8f-459c1a83499f@linaro.org>
Date: Tue, 19 Mar 2024 17:12:39 +0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/22] plugins: Create TCGHelperInfo for all out-of-line
 callbacks
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org
References: <20240316015720.3661236-1-richard.henderson@linaro.org>
 <20240316015720.3661236-7-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20240316015720.3661236-7-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-ed1-x52a.google.com
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

On 3/16/24 05:57, Richard Henderson wrote:
> TCGHelperInfo includes the ABI for every function call.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/qemu/plugin.h |  1 +
>   plugins/core.c        | 51 ++++++++++++++++++++++++++++++++++++++-----
>   2 files changed, 46 insertions(+), 6 deletions(-)
> 
> diff --git a/include/qemu/plugin.h b/include/qemu/plugin.h
> index 143262dca8..793c44f1f2 100644
> --- a/include/qemu/plugin.h
> +++ b/include/qemu/plugin.h
> @@ -92,6 +92,7 @@ struct qemu_plugin_dyn_cb {
>       union {
>           struct {
>               union qemu_plugin_cb_sig f;
> +            TCGHelperInfo *info;
>           } regular;
>           struct {
>               qemu_plugin_u64 entry;
> diff --git a/plugins/core.c b/plugins/core.c
> index 837c373690..b0a2e80874 100644
> --- a/plugins/core.c
> +++ b/plugins/core.c
> @@ -338,12 +338,26 @@ void plugin_register_dyn_cb__udata(GArray **arr,
>                                      enum qemu_plugin_cb_flags flags,
>                                      void *udata)
>   {
> -    struct qemu_plugin_dyn_cb *dyn_cb = plugin_get_dyn_cb(arr);
> +    static TCGHelperInfo info[3] = {
> +        [QEMU_PLUGIN_CB_NO_REGS].flags = TCG_CALL_NO_RWG | TCG_CALL_PLUGIN,
> +        [QEMU_PLUGIN_CB_R_REGS].flags = TCG_CALL_NO_WG | TCG_CALL_PLUGIN,
> +        [QEMU_PLUGIN_CB_RW_REGS].flags = TCG_CALL_PLUGIN,
> +        /*
> +         * Match qemu_plugin_vcpu_udata_cb_t:
> +         *   void (*)(uint32_t, void *)
> +

Any chance we could have a static assert ensuring this?
I know it's possible in C11, but I don't know if glib offers something 
for this.

          */
> +        [0 ... 2].typemask = (dh_typemask(void, 0) |
> +                              dh_typemask(i32, 1) |
> +                              dh_typemask(ptr, 2))
> +    };
>   
> +    struct qemu_plugin_dyn_cb *dyn_cb = plugin_get_dyn_cb(arr);
>       dyn_cb->userp = udata;
> -    /* Note flags are discarded as unused. */
> -    dyn_cb->regular.f.vcpu_udata = cb;
>       dyn_cb->type = PLUGIN_CB_REGULAR;
> +    dyn_cb->regular.f.vcpu_udata = cb;
> +
> +    assert((unsigned)flags < ARRAY_SIZE(info));
> +    dyn_cb->regular.info = &info[flags];
>   }
>   
>   void plugin_register_vcpu_mem_cb(GArray **arr,
> @@ -352,14 +366,39 @@ void plugin_register_vcpu_mem_cb(GArray **arr,
>                                    enum qemu_plugin_mem_rw rw,
>                                    void *udata)
>   {
> -    struct qemu_plugin_dyn_cb *dyn_cb;
> +    /*
> +     * Expect that the underlying type for enum qemu_plugin_meminfo_t
> +     * is either int32_t or uint32_t, aka int or unsigned int.
> +     */
> +    QEMU_BUILD_BUG_ON(
> +        !__builtin_types_compatible_p(qemu_plugin_meminfo_t, uint32_t) &&
> +        !__builtin_types_compatible_p(qemu_plugin_meminfo_t, int32_t));
>   
> -    dyn_cb = plugin_get_dyn_cb(arr);
> +    static TCGHelperInfo info[3] = {
> +        [QEMU_PLUGIN_CB_NO_REGS].flags = TCG_CALL_NO_RWG | TCG_CALL_PLUGIN,
> +        [QEMU_PLUGIN_CB_R_REGS].flags = TCG_CALL_NO_WG | TCG_CALL_PLUGIN,
> +        [QEMU_PLUGIN_CB_RW_REGS].flags = TCG_CALL_PLUGIN,
> +        /*
> +         * Match qemu_plugin_vcpu_mem_cb_t:
> +         *   void (*)(uint32_t, qemu_plugin_meminfo_t, uint64_t, void *)
> +         */
> +        [0 ... 2].typemask =
> +            (dh_typemask(void, 0) |
> +             dh_typemask(i32, 1) |
> +             (__builtin_types_compatible_p(qemu_plugin_meminfo_t, uint32_t)
> +              ? dh_typemask(i32, 2) : dh_typemask(s32, 2)) |
> +             dh_typemask(i64, 3) |
> +             dh_typemask(ptr, 4))
> +    };
> +
> +    struct qemu_plugin_dyn_cb *dyn_cb = plugin_get_dyn_cb(arr);
>       dyn_cb->userp = udata;
> -    /* Note flags are discarded as unused. */
>       dyn_cb->type = PLUGIN_CB_REGULAR;
>       dyn_cb->rw = rw;
>       dyn_cb->regular.f.vcpu_mem = cb;
> +
> +    assert((unsigned)flags < ARRAY_SIZE(info));
> +    dyn_cb->regular.info = &info[flags];
>   }
>   
>   /*

else,
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

