Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C4F4C2BD09
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 18:59:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sP5BD-0000tm-Uj; Wed, 03 Jul 2024 14:58:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sP5BB-0000pd-48
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 14:58:09 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sP5B9-0006Vb-7L
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 14:58:08 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-707040e3017so4158970a12.3
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 11:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720033085; x=1720637885; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yNjYrhQ3rB5C/zaTJWdUfr/OHiwiEuLPgoHPYxZQylQ=;
 b=P4tZkNmzp1sw3XHczeJ6ZO5Khoviwij/OrkSFDB8hDgOK+25EeCy9ooMub7i07XSHl
 llPGvgeIv9cK8hWYpz3/csnXZMMfnszgAh4gLlEp1EPUVv293MBg1tfyXBV8/sbx7rp7
 VW7r24EOI+G0d5fxJJ006g3nY1zycAd2eRdcPr32myc08qamhxNRC6VqTxcOKSW7UR2c
 UMJkXJ4VmsUtb9rfiY+wVRzC2XB+hVUdQ9q1ripv3Xs8L5hDn0NWd8DDhp/b3SgQD49O
 Zh4G+oGFEnucn8yzi4iak4dnIHrP8pDl2JHqKgu1aI2qrTNd6cB0fa2VoloFxIXLMdMK
 M6YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720033085; x=1720637885;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yNjYrhQ3rB5C/zaTJWdUfr/OHiwiEuLPgoHPYxZQylQ=;
 b=IDr2vdZXkhYt+pLp/OCX2aKbdn6FgRbnWvYaGC2ygtb70sChPpj7j/7x0JNFzfnUbo
 hy8UGJx9xJROPZ2ywXzLKVf4NaEDG2Tr8Xa1aSFvh9tMkMy3IwZbpY3eR2wNiTgwePC2
 rwKC9RhQ9XviiKFgI4ekA3ZDm/i5lUgxo4ruTTUehNdbvs7VIK6q8m+tFAHPbWD2n6wg
 iYRem9YayY7FvbYeXpKLtRLZblZM/BYTPar5uzaMjWgJCUlSD6zswcKLMGwddKv1muVW
 Q8nR6YRrcWC+ImrA1NXbHYa+CAvW+1n7G7SWq68wBzewob1Z8a1TIZXMJInM6sxYk4MD
 u/Uw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXKeYUUzF2+lp8KNl3czaBZMSHKunxZAruBpuLyykFvQTnEbMvyUqdf/IcsrJvpL92klJRvh0KaauOikpX0l4IuZu9Qyvs=
X-Gm-Message-State: AOJu0Yz3kECBStJRDS+JUHbq0qE255nCQd54oST/Mz/UKkALolUZB0JW
 27QNsXcsVNkNDec5UdxxHF/rwaV2FZEtpne7UXP0Q2hlwoKC7d3hvgJaQx7Nk1A=
X-Google-Smtp-Source: AGHT+IGeVnfUczI9xtVc08XotnI5vshl8/pR+zZwLqffG9IkUXsxIKk/rsIp4tQcJEnyZzd0QGFKAw==
X-Received: by 2002:a05:6a20:840d:b0:1bd:260e:be9d with SMTP id
 adf61e73a8af0-1bef6216eddmr16316781637.39.1720033085032; 
 Wed, 03 Jul 2024 11:58:05 -0700 (PDT)
Received: from [192.168.0.4] (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-708048935ddsm10792379b3a.189.2024.07.03.11.58.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jul 2024 11:58:04 -0700 (PDT)
Message-ID: <1118b3e7-31c7-4918-a63a-e9b9279941c4@linaro.org>
Date: Wed, 3 Jul 2024 11:58:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/7] plugins: save value during memory accesses
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Alexandre Iooss
 <erdnaxe@crans.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
References: <20240702184448.551705-1-pierrick.bouvier@linaro.org>
 <20240702184448.551705-3-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240702184448.551705-3-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52d.google.com
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

On 7/2/24 11:44, Pierrick Bouvier wrote:
> Different code paths handle memory accesses:
> - tcg generated code
> - load/store helpers
> - atomic helpers
> 
> This value is saved in cpu->plugin_state.
> 
> Atomic operations are doing read/write at the same time, so we generate
> two memory callbacks instead of one, to allow plugins to access distinct
> values.
> 
> For now, we can have access only up to 128 bits, thus split this in two
> 64 bits words. When QEMU will support wider operations, we'll be able to
> reconsider this.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   accel/tcg/atomic_template.h   | 66 ++++++++++++++++++++++++++++----
>   include/qemu/plugin.h         |  8 ++++
>   plugins/core.c                |  7 ++++
>   tcg/tcg-op-ldst.c             | 72 +++++++++++++++++++++++++++++++----
>   accel/tcg/atomic_common.c.inc | 13 ++++++-
>   accel/tcg/ldst_common.c.inc   | 38 +++++++++++-------
>   6 files changed, 173 insertions(+), 31 deletions(-)

It looks correct so,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Possibilities for follow-up improvement:


> --- a/tcg/tcg-op-ldst.c
> +++ b/tcg/tcg-op-ldst.c
> @@ -148,14 +148,24 @@ static TCGv_i64 plugin_maybe_preserve_addr(TCGTemp *addr)
>       return NULL;
>   }
>   
> +#ifdef CONFIG_PLUGIN
>   static void
> -plugin_gen_mem_callbacks(TCGv_i64 copy_addr, TCGTemp *orig_addr, MemOpIdx oi,
> +plugin_gen_mem_callbacks(TCGv_i64 value_low, TCGv_i64 value_high,
> +                         TCGv_i64 copy_addr, TCGTemp *orig_addr, MemOpIdx oi,
>                            enum qemu_plugin_mem_rw rw)
>   {
> -#ifdef CONFIG_PLUGIN
>       if (tcg_ctx->plugin_insn != NULL) {
>           qemu_plugin_meminfo_t info = make_plugin_meminfo(oi, rw);
>   
> +        TCGv_ptr plugin_state = tcg_temp_ebb_new_ptr();
> +        tcg_gen_ld_ptr(plugin_state, tcg_env,
> +                       offsetof(CPUState, plugin_state) - sizeof(CPUState));
> +        tcg_gen_st_i64(value_low, plugin_state,
> +                       offsetof(CPUPluginState, mem_value_low));
> +        tcg_gen_st_i64(value_high, plugin_state,
> +                       offsetof(CPUPluginState, mem_value_high));

Maybe better to place this data at the beginning of CPUNegativeOffsetState?
This would eliminate a load dependency and most hosts would be able to use (relatively) 
small negative offset efficiently.

> +static void
> +plugin_gen_mem_callbacks_i32(TCGv_i32 val,
> +                             TCGv_i64 copy_addr, TCGTemp *orig_addr,
> +                             MemOpIdx oi, enum qemu_plugin_mem_rw rw)
> +{
> +#ifdef CONFIG_PLUGIN
> +    if (tcg_ctx->plugin_insn != NULL) {
> +        TCGv_i64 ext_val = tcg_temp_ebb_new_i64();
> +        tcg_gen_extu_i32_i64(ext_val, val);
> +        plugin_gen_mem_callbacks(ext_val, tcg_constant_i64(0),

This zero extension got me to thinking:
(1) why zero extension and not sign-extension based on MO_SIGN from oi?
(2) given that the callback will have oi, do we really need any extension
     at all here?  We could allow the bits outside oi be garbage.
     This would eliminate the store to value_high entirely for most ops,
     and would allow this i32 op to avoid the extension -- simply perform
     a 32-bit store into the low half of value_low.

That appears to be what you're doing anyway with qemu_plugin_mem_value in the next patch.


r~

