Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F583D46C15
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Jan 2026 22:44:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlEGn-00018v-8Q; Wed, 28 Jan 2026 17:44:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vlEGj-00017L-NA
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 17:44:13 -0500
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vlEGh-0006Et-Kr
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 17:44:13 -0500
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-81e8b1bdf0cso201461b3a.3
 for <qemu-devel@nongnu.org>; Wed, 28 Jan 2026 14:44:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769640249; x=1770245049; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AB/L4h1xtV5dKvWWKpZ41E8Nq5MMtDjyPYA9PnFQ/Xw=;
 b=LxYhMGhqr4yKwNnvgnqtaOwQrlXzZmIkCjfilV9yy2DXddGZtuCKbuIIS2M6LmMR0e
 cWkfKOqJr7qKt5PRYB9A+Qwu0emrcU2N1gW4AQDLIyc9HIbLAVPL0dnL2PbgwDrbWem4
 ECSoUjuQFtAvLI7eMYXI3ycU3Nb0qooQFDaM4c/9+xAapIZEX882Jz/IuHffD10MmAvM
 M9o4MoW05Mp2S+wWZhjznClKOiQZn6eelMENKHNOTjy/pYp081LprO/HfNBupSGu4SZf
 QohP0uD2c4uKRg9vjLlKCZKQDOO2PgcOdngvIBQRHA4Evc4ME0sI9Dk35JO+RjJba+Ph
 PspQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769640249; x=1770245049;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AB/L4h1xtV5dKvWWKpZ41E8Nq5MMtDjyPYA9PnFQ/Xw=;
 b=BvXBlR37sPMol0ZxU16p9GycMRrv/WqUN7TOomB3wgsUIT+cbAIfOWXi2/bLa9dAnh
 QEyfNjmqoN2PD7a6ZJkv2o0kQasVdDoeNFgDSk97r8QwtU2kuD5ntgGnDuZH10a4Ifjk
 /qt32oX9ujaRSm7hfqFdOfC23/UYRNVKWuhjRfFsYI10J7jSUjbXWpYpluhMjmdxuMON
 Oc29ce/zSZQ2s8LrB+wU6UVzSzIEE468reDy+ZOqGbPViW0vRfQno2SizHu9ED6gSmVf
 N0lEywhghrYUkefEDpAuW8eWPdEq5y2CqiNP9MaJUlDE8CSL15GErQ457ysFwTCrttTS
 mN6A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUm1fLZf0YzhzNnuI8nAHAx2SNeRh/2+D3VdJo81dePex7CXBrzE+8WTTCBURspZoAWsX7w+9g4G6Yz@nongnu.org
X-Gm-Message-State: AOJu0YzJnFpQEmLhTJ2xuOmfFyk0uRwBSodxMGnd1kQbJQywG0UWQXXx
 Nc0ps93Jg6/yOOFQQ+IXQ9cdVAUDFyXTZozXhIa7wfP2ZF3hRbk6rtxGEH5vKAyXzYE=
X-Gm-Gg: AZuq6aJA2+kP1vRSKtv8LJzIYNPRIbVxckOEfzv7o4JoBo5okOVntm7OzbuLBx0LwPd
 mXM05OJCHFFSO6ywUpsEeTNdFRjWfg8lUWlYE2yhrInoHLKpMhoCMGpT3mnHHhC7t5PduQn/wV6
 SymgkRswR+MfTLlLO3ZH3wGFl3Urzdlu97YrD8NhNriBRSkOBZyZ8Q/jjXnDpNFPxTBLl/+C0OB
 xYtTiLyFaICBMJn8qRzTeji34OlG3X8yJW4CIiPq687zmUQO3Z5P8YqZ9xKfElO5cnZLZ0wCxQw
 SI0SBnkX2CkcuL7ZIj3ahZYzoZUhX62AHdB8N6pITxvhtt9s2gfiRZUi+0xp06nUM/NaorLR0Pe
 dHOIYK865EcdB+iAeklEba9ySx6xC7Xojik7Bf8JvsfK3ktFDPcdKTnCMrO5KitpiGRGsuyfJpO
 v1x9sVwswed2t4rZYRRHA9fuq7sUEceg==
X-Received: by 2002:a05:6a00:179f:b0:81c:8d47:33ff with SMTP id
 d2e1a72fcca58-823692af9e8mr6765772b3a.47.1769640249030; 
 Wed, 28 Jan 2026 14:44:09 -0800 (PST)
Received: from [192.168.10.140] ([180.233.125.201])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82379b4e7b7sm3461124b3a.21.2026.01.28.14.44.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Jan 2026 14:44:08 -0800 (PST)
Message-ID: <912aab4f-869a-4ca5-b0ab-65966499bbe9@linaro.org>
Date: Thu, 29 Jan 2026 09:44:03 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 3/3] target/arm: Permit configurations with SME but
 not SVE
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
References: <20260127154813.591744-1-peter.maydell@linaro.org>
 <20260127154813.591744-4-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260127154813.591744-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
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

On 1/28/26 02:48, Peter Maydell wrote:
> In commit f7767ca30179 ("target/arm: Disable SME if SVE is disabled")
> we added code that forces SME to be disabled if SVE is disabled.
> This was something we did in the run-up to a release to avoid an
> assertion failure in smcr_write() if the user disabled SVE on the
> 'max' CPU without disabling SME also.
> 
> Now that we have corrected the code so that it doesn't assert
> in an SME-without-SVE setup, we can let users select it.
> 
> This effectively reverts f7767ca30179.
> 
> Note that this now means that command lines like
> "-cpu max,sve=off" which used to turn off SME and SVE will
> now give you a CPU with SME but not SVE. This is permitted
> by our loose "max can always give you extra stuff" rules,
> but may be unexpected to users.
> 
> In particular, gdb crashes when told about a CPU with only
> SME via the gdbstub register XML with this error:
> 
>   (gdb) target remote :1234
>   Remote debugging using :1234
>   /build/gdb-1WjiBe/gdb-15.0.50.20240403/gdb/aarch64-tdep.c:3066: internal-error: aarch64_pseudo_register_type: bad register number 160
>   A problem internal to GDB has been detected,
>   further debugging may prove unreliable.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/arm/cpu.c | 10 ----------
>   1 file changed, 10 deletions(-)
> 
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index 6e1cbf3d61..1cb30076ad 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -1571,16 +1571,6 @@ void arm_cpu_finalize_features(ARMCPU *cpu, Error **errp)
>               return;
>           }
>   
> -        /*
> -         * FEAT_SME is not architecturally dependent on FEAT_SVE (unless
> -         * FEAT_SME_FA64 is present). However our implementation currently
> -         * assumes it, so if the user asked for sve=off then turn off SME also.
> -         * (KVM doesn't currently support SME at all.)
> -         */
> -        if (cpu_isar_feature(aa64_sme, cpu) && !cpu_isar_feature(aa64_sve, cpu)) {
> -            object_property_set_bool(OBJECT(cpu), "sme", false, &error_abort);
> -        }
> -
>           arm_cpu_sme_finalize(cpu, &local_err);
>           if (local_err != NULL) {
>               error_propagate(errp, local_err);

We do need to squash FA64 if sve=off, probably in arm_cpu_sme_finalize, perhaps as a 
previous patch.

Anyway, as far as this goes,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

