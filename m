Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAAD1CD4F54
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 20:52:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPRQE-0007kC-LW; Tue, 19 May 2026 16:52:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPRQD-0007dH-KG
 for qemu-devel@nongnu.org; Tue, 19 May 2026 16:52:13 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPRQB-0006u5-Ew
 for qemu-devel@nongnu.org; Tue, 19 May 2026 16:52:13 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-488b0e1b870so60462645e9.2
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 13:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779223929; x=1779828729; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=h/Pg2nN5smjrQdPUXnPPDbBVzw7eB/JdcJ22w+HyICM=;
 b=LOlScQZd7P+v8k5uYZc0VHYO3Q9FwQbF1pwgUB+Q7taB+vqC50eiBt7N0twxpuMvq7
 QPX9cKXufvmS5+N/Pcs8TeFhm5g/0vUIYwXlo0QoWawbgnOmLuwwkYUfkx26F0X5hQDm
 PF+OOna8V4pTGk+xIqh/4FIgQsSllZSIDaX2+Ph+/KhJ/qwdi7qrRnTkRgCTcwx3Zlbp
 N94A5+o3HX8nOmYoQYRv+HxLrYc09ltDR2zRefjesx8odexZ4yGnv+sGgAo4grzzrRqh
 mxwa+/+fI8YuggK7idbnPE5KltTTs80xS4PFNb1XMYnR/ZhEwsvW0/Ww3OpKY1J/HO+k
 9Rig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779223929; x=1779828729;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=h/Pg2nN5smjrQdPUXnPPDbBVzw7eB/JdcJ22w+HyICM=;
 b=X7OmRoTifNie2270tPfTPbodTiwssmGNBr2ectALbIGx3PxjIZSg1cHMPj8nVEXab/
 4WR6sPlk4PhNHmimBbUnfFANgy1Qk+PmqycmDtTXFAuoyboMZm4Ip4pVW2ISmCmzSMEr
 GB9/5mrKhDPVSfYVVIl3nwjMTG/yJFKMpjr27DoWY0FoJRU4RZ8S5v2L4raUVld+if1a
 mBsD5kAx1x4aTraJpvZIcCz7yFxEcQmdhLEV7xIVaCs34h3yoMhFk+R3honZqxadeZaa
 r3wzmOdqhCqbfjmNvDWeq9rL5vBg7n/RyzzlqLs00CL7gjsRfWBMn2vyxRutBgt5Sq3d
 oe2Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ9z3PL0gN9TPrMcL4zvIhmbnxzE5eqzptvsTLiPjE6hLnlmpmIASexcZd9i0PGZgSswmhvcOdtpJ5V8@nongnu.org
X-Gm-Message-State: AOJu0Yxr9hXfSpiEG0VqOpqX0fiVVbPjSwHb5Z/cjzeWMy0W/h3JaGxB
 6AuEho15CmHi6/t/s6koGZ4fMRgNmfycHT60Ox31w5+4+0vBzoN+WGRXjWR6Vru/YXw=
X-Gm-Gg: Acq92OGYQXou2hi82uRaodd8/XhP0+qW8cSp2yqlBH09WYFRil94RfZd26E44ubOHPi
 mGN0CPUIVmryQJNiMt9rfACl1c4Pr8l68jDE53/PKry9vulvUgYrK0h65u/0c1V3q70tLzxq/1L
 0ulAkV2Tolt3WoN8ZikNQIx6StQe1SqTczi0k9DG7z/j0vFlxBmABemyq65BZlK9tSaa7n0Qe0l
 ZJaT6gFkqFSRvjZx5kyOwsgqMqsEBWe4jmvViIOR8AjsvKKLNiSn2W0HG+kt+V2Yjae+n0jdnsz
 OJOULwfeMD6Gbm94OdJhf7YnHJzrB42viNZk3QEpqaHF2MqOksiVOvqDtyUEYDtZIz6mmOGU4Q8
 p5bNiVWVh2KJwJw2HvMPqAkvzOOQaVX1AIHtAbXGlUjp8iItZRSUwgYjjuBe8pgC8aIzb7OdHZq
 YYLMbK0xHNeYtR0E1olpCyr2wVr47e2CirsLdERGgCq8LVSSkpHueKlqoj056xhJv5NYlQ3PRUm
 k42
X-Received: by 2002:a05:600c:c087:b0:48d:c0a:3813 with SMTP id
 5b1f17b1804b1-48fe60de6a7mr261180545e9.3.1779223929442; 
 Tue, 19 May 2026 13:52:09 -0700 (PDT)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4900c16c744sm178560705e9.3.2026.05.19.13.52.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 May 2026 13:52:08 -0700 (PDT)
Message-ID: <46d5ad2c-4a76-46fa-80cc-e2a33b9fa923@linaro.org>
Date: Tue, 19 May 2026 22:52:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 13/40] tcg: Introduce tcg_gen_addN_i64
Content-Language: en-US
To: James Hilliard <james.hilliard1@gmail.com>, qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Jiaxun Yang
 <jiaxun.yang@flygoat.com>, Aleksandar Rikalo <arikalo@gmail.com>,
 Huacai Chen <chenhuacai@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>
References: <20260519-mips-octeon-missing-insns-v2-v9-0-d7dd735ecddd@gmail.com>
 <20260519-mips-octeon-missing-insns-v2-v9-13-d7dd735ecddd@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260519-mips-octeon-missing-insns-v2-v9-13-d7dd735ecddd@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

On 19/5/26 18:22, James Hilliard wrote:
> From: Richard Henderson <richard.henderson@linaro.org>
> 
> Add a helper for multi-limb 64-bit addition. The helper emits native
> carry-chain TCG ops when they are available and falls back to explicit
> carry propagation otherwise.
> 
> This lets target translators build wider integer accumulators inline
> without open-coding the same add-with-carry sequence at each use site.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> 
> ---
> Changes v7 -> v8:
>    - New patch from Richard Henderson's v7.5 multiplier rework.
> ---
>   include/tcg/tcg-op-common.h |  1 +
>   tcg/tcg-op.c                | 42 ++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 43 insertions(+)

Richard, could we squash something like this?

-- >8 --
diff --git a/docs/devel/tcg-ops.rst b/docs/devel/tcg-ops.rst
index fd3a50bf4c4..1ac53a61114 100644
--- a/docs/devel/tcg-ops.rst
+++ b/docs/devel/tcg-ops.rst
@@ -672,6 +672,12 @@ Multiword arithmetic support
         | If mulu2/muls2 are not provided by the backend, the tcg-op 
generator
           can obtain the same results by emitting a pair of opcodes, 
mul + muluh/mulsh.

+   * - addN *n*, *t0*, *t1*, *t2*
+
+     - | For each *n*, compute *t0* = *t1* + *t2* + *C*,
+         where *C* is the input carry bit provided by the host
+         architecture, and also compute the output carry bit.
+         Overlap between *t0* and *t1*/*t2* arrays is not allowed.

  Memory Barrier support
  ----------------------
---

> diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
> index e02f209c09..ee0ad5f6a3 100644
> --- a/include/tcg/tcg-op-common.h
> +++ b/include/tcg/tcg-op-common.h
> @@ -251,6 +251,7 @@ void tcg_gen_sub2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 al,
>                         TCGv_i64 ah, TCGv_i64 bl, TCGv_i64 bh);
>   void tcg_gen_addcio_i64(TCGv_i64 r, TCGv_i64 co,
>                           TCGv_i64 a, TCGv_i64 b, TCGv_i64 ci);
> +void tcg_gen_addN_i64(int n, TCGv_i64 *r, TCGv_i64 *a, TCGv_i64 *b);
>   void tcg_gen_mulu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
>   void tcg_gen_muls2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
>   void tcg_gen_mulsu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
> diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
> index d8ae57d604..28ef5bacfd 100644
> --- a/tcg/tcg-op.c
> +++ b/tcg/tcg-op.c
> @@ -2275,6 +2275,48 @@ void tcg_gen_addcio_i64(TCGv_i64 r, TCGv_i64 co,
>       }
>   }
>   
> +void tcg_gen_addN_i64(int n, TCGv_i64 *r, TCGv_i64 *a, TCGv_i64 *b)
> +{
> +    tcg_debug_assert(n > 2);
> +
> +    /* ??? Don't allow overlap for now. */
> +    for (int i = 0; i < n - 1; ++i) {
> +        for (int j = i + 1; j < n; ++j) {
> +            tcg_debug_assert(r[i] != a[j]);
> +            tcg_debug_assert(r[i] != b[j]);
> +        }
> +    }
> +
> +    if (tcg_op_supported(INDEX_op_addci, TCG_TYPE_I64, 0)) {
> +        tcg_gen_op3_i64(INDEX_op_addco, r[0], a[0], b[0]);
> +        for (int i = 1; i < n - 1; ++i) {
> +            tcg_gen_op3_i64(INDEX_op_addcio, r[i], a[i], b[i]);
> +        }
> +        tcg_gen_op3_i64(INDEX_op_addci, r[n - 1], a[n - 1], b[n - 1]);
> +    } else {
> +        TCGv_i64 t = tcg_temp_ebb_new_i64();
> +        TCGv_i64 c = tcg_temp_ebb_new_i64();
> +
> +        tcg_gen_add_i64(t, a[0], b[0]);
> +        tcg_gen_setcond_i64(TCG_COND_LTU, c, t, a[0]);
> +        tcg_gen_mov_i64(r[0], t);
> +
> +        for (int i = 1; i < n - 1; ++i) {
> +            tcg_gen_add_i64(t, a[i], c);
> +            tcg_gen_setcond_i64(TCG_COND_LTU, c, t, c);
> +            tcg_gen_add_i64(r[i], b[i], t);
> +            tcg_gen_setcond_i64(TCG_COND_LTU, t, r[i], t);
> +            tcg_gen_or_i64(c, c, t);
> +        }
> +
> +        tcg_gen_add_i64(r[n - 1], a[n - 1], b[n - 1]);
> +        tcg_gen_add_i64(r[n - 1], r[n - 1], c);
> +
> +        tcg_temp_free_i64(t);
> +        tcg_temp_free_i64(c);
> +    }
> +}
> +
>   void tcg_gen_sub2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 al,
>                         TCGv_i64 ah, TCGv_i64 bl, TCGv_i64 bh)
>   {
> 


