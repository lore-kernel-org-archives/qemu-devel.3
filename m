Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B531CC4828D
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 20:04:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXo9U-0004ei-0s; Wed, 07 Feb 2024 15:04:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1rXo9N-0004cN-Uf
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 15:04:06 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1rXo9M-0003hs-4A
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 15:04:05 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1d98fc5ebceso7039325ad.1
 for <qemu-devel@nongnu.org>; Wed, 07 Feb 2024 12:04:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707336242; x=1707941042; darn=nongnu.org;
 h=content-transfer-encoding:content-language:in-reply-to:mime-version
 :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ioKl1Fdwa9P3L3uKTM+GqEAzOADfMNO4SBTyXhL2C0I=;
 b=Y4l4U8PsDQIKtBk8+nQ/MKnVSe6jhpGyJEINZd4Rkm0IqSkR9FSkPdC0BAmvqek5pk
 Ib4NIDvq1oC6/dz9LFHJlXOtdisRFmXHBUMxMOY65wHmLpoPDkORWzEQSM34iwPLbqN7
 GjTDH+B6g4U39RDVoek02z4mgBO8/0cVeCzVe4SAPCm7L0i27ocDuBydN15OLOWZYJFr
 +kDnzzIUmfneeYWyYYJ/Y7k+Q4RbBghox6+1mFRWUDEiUcccz6EN0O/nVUenqCd84baK
 YJNe29LnMQzixBEYxWuPiYQSQ6W2f8N/9+B8SNbHXbnn++nBMqynn/+vjXWoI6XQECnV
 qMAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707336242; x=1707941042;
 h=content-transfer-encoding:content-language:in-reply-to:mime-version
 :user-agent:date:message-id:from:references:cc:to:subject
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ioKl1Fdwa9P3L3uKTM+GqEAzOADfMNO4SBTyXhL2C0I=;
 b=nQHvJ8yX5xC0lbqnNbdk39pvK0PKiPUi/f46yZDo+dDY25laUWCORgpogYHCepPZ3i
 /ioFo6n4X9IrxCMB99XwWsJsjLcE6y9yUqCMUYkY17KdbjRvJpJY97b5kAP+Z/lhLib8
 nMToee2MxSB/UymjFeXIO4aLhfTk41AxG8x7Dac0SZ6reLga+EzPo0bpYwEeeSlRe5YQ
 l+QYhMBo4eV47szXzfCVTlkXgQbmnVDkF5I0Qio8mxs5NaEmbt7v05FpqQFO/P6/3DC0
 WbN7zbG6b1iVW0I8RLY4dxAye8uR0lH26ZXEfT23e85BQYK9cMC1Tm9oSa9/XQQ8qpPd
 09jw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVmsTtwkw+xJIzlZH2R1cjEi6KFMHHFIUkyNWo0WY0+tJfM/O2+BeCsd4kDymx5lK1KOEmLJBvztfjPqSfIlr96Tvy1f8M=
X-Gm-Message-State: AOJu0YxxKFabBfP2ND5EnoBYhOMXaf6eraDcfRVuQBsd48EeJ9CicnQF
 ZQq828N7YY3fnomNd9rQw005xTAefE28h/nDNt3zfoPOmy6BtUkHOFmEoC6aXBc=
X-Google-Smtp-Source: AGHT+IEoLWdZVjUo/hL9PsZYiYEV+zkxuqNhVbYXg9hlCu6k9aLVEhCmzgIE5QKf2G3AA1WNcj0fpA==
X-Received: by 2002:a17:902:7406:b0:1d8:ed67:c360 with SMTP id
 g6-20020a170902740600b001d8ed67c360mr5378051pll.65.1707336242093; 
 Wed, 07 Feb 2024 12:04:02 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVvG2sxrEFk4s2plYd2i4SEUnAZieGcyi8AKybQxlwUeo7THpbF09KuEUacakoE1q7A8/CNHE/EFOMXG0vpvD1syfu7IcPPTVZotyKCKugI0Vi3znE7UlONSQtoX0M=
Received: from ?IPv6:2804:7f0:b402:df90:2add:f1b6:5717:16e1?
 ([2804:7f0:b402:df90:2add:f1b6:5717:16e1])
 by smtp.gmail.com with ESMTPSA id
 jz4-20020a170903430400b001d8fe6cd0f0sm1844373plb.150.2024.02.07.12.04.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Feb 2024 12:04:01 -0800 (PST)
Subject: Re: [PATCH v3 1/6] linux-user/aarch64: Choose SYNC as the preferred
 MTE mode
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-stable@nongnu.org
References: <20240207025210.8837-1-richard.henderson@linaro.org>
 <20240207025210.8837-2-richard.henderson@linaro.org>
From: Gustavo Romero <gustavo.romero@linaro.org>
Message-ID: <2ba0228b-fec3-0710-11a1-18825bc1476d@linaro.org>
Date: Wed, 7 Feb 2024 17:03:59 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20240207025210.8837-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pl1-x631.google.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.632,
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


On 2/6/24 11:52 PM, Richard Henderson wrote:
> The API does not generate an error for setting ASYNC | SYNC; that merely
> constrains the selection vs the per-cpu default.  For qemu linux-user,
> choose SYNC as the default.
> 
> Cc: qemu-stable@nongnu.org
> Reported-by: Gustavo Romero <gustavo.romero@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   linux-user/aarch64/target_prctl.h | 29 +++++++++++++++++------------
>   1 file changed, 17 insertions(+), 12 deletions(-)
> 
> diff --git a/linux-user/aarch64/target_prctl.h b/linux-user/aarch64/target_prctl.h
> index 5067e7d731..aa8e203c15 100644
> --- a/linux-user/aarch64/target_prctl.h
> +++ b/linux-user/aarch64/target_prctl.h
> @@ -173,21 +173,26 @@ static abi_long do_prctl_set_tagged_addr_ctrl(CPUArchState *env, abi_long arg2)
>       env->tagged_addr_enable = arg2 & PR_TAGGED_ADDR_ENABLE;
>   
>       if (cpu_isar_feature(aa64_mte, cpu)) {
> -        switch (arg2 & PR_MTE_TCF_MASK) {
> -        case PR_MTE_TCF_NONE:
> -        case PR_MTE_TCF_SYNC:
> -        case PR_MTE_TCF_ASYNC:
> -            break;
> -        default:
> -            return -EINVAL;
> -        }
> -
>           /*
>            * Write PR_MTE_TCF to SCTLR_EL1[TCF0].
> -         * Note that the syscall values are consistent with hw.
> +         *
> +         * The kernel has a per-cpu configuration for the sysadmin,
> +         * /sys/devices/system/cpu/cpu<N>/mte_tcf_preferred,
> +         * which qemu does not implement.
> +         *
> +         * Because there is no performance difference between the modes, and
> +         * because SYNC is most useful for debugging MTE errors, choose SYNC
> +         * as the preferred mode.  With this preference, and the way the API
> +         * uses only two bits, there is no way for the program to select
> +         * ASYMM mode.
>            */
> -        env->cp15.sctlr_el[1] =
> -            deposit64(env->cp15.sctlr_el[1], 38, 2, arg2 >> PR_MTE_TCF_SHIFT);
> +        unsigned tcf = 0;
> +        if (arg2 & PR_MTE_TCF_SYNC) {
> +            tcf = 1;
> +        } else if (arg2 & PR_MTE_TCF_ASYNC) {
> +            tcf = 2;
> +        }
> +        env->cp15.sctlr_el[1] = deposit64(env->cp15.sctlr_el[1], 38, 2, tcf);
>   
>           /*
>            * Write PR_MTE_TAG to GCR_EL1[Exclude].
> 

ok, so no ASYMM in QEMU user-mode, plus if both SYNC and ASYNC flags are
specified by the user SYNC is selected. Contrary to what happens by default
on Linux, because of the mte_tcf_preferred value, which is ASYNC, and the
final value selected is define by:

resolved_mte_tcf = (mte_ctrl & pref) ? pref : mte_ctrl; [0]

where pref is mte_tcf_preferred (CPU, the value set in sys /mte_tcf_preferred)
and mte_ctr comes from the process, i.e. is the value specified by the user in
the flags -- hence the default on Linux if both flags are specified is ASYNC,
not SYNC.

(just some notes for the records).

Thanks.


[0] https://github.com/torvalds/linux/blob/master/arch/arm64/kernel/mte.c#L180-L186

