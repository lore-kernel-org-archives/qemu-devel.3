Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AA26C52D6F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 01:08:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbV90-0007Uz-Kk; Tue, 06 Aug 2024 21:07:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sbV8t-0007SY-9d
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 21:07:09 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sbV8o-0000VZ-K0
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 21:07:05 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1ff4568676eso13684515ad.0
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2024 18:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722992820; x=1723597620; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=r2G/83kamrNJvv+5+rbZr0omz0f2TmybXFQMg0Ebn6Y=;
 b=O+22PiS1HAj5DoQZWj3ZV2WUD3Z0HTbM/gEUlNDrqb5VonmnRBzH5WO43PrSz41M0y
 PEnjaAVhkCjv8pMAIqi4nxWKaC6oE7pdT5ThrPLz1wqG5zmoXIrEGRs4+AdNqZENvvKX
 TfLQZ16V0eV9Ye5AgKeZgQjU8uY9xOHid4dAi7FK1+0Qiy909T0CDd68Tw/nhX9xSBGP
 zZUycbEjqUPf/Cuk5VUdsMMcej4T1NDgPyPCJrTVcRjGQywLXPLJN3N1fJNAcL0yYzSm
 1UO388rLIFzBN9hr9fW7PBki/aWGiaLisHdmAw3y2gdw1V0JhBSZfHymrXdWtFCE8x1Z
 Zqrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722992820; x=1723597620;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=r2G/83kamrNJvv+5+rbZr0omz0f2TmybXFQMg0Ebn6Y=;
 b=gQX90jvaqABsCIi6gE8JVPtdnough0RYFNotdS32BnUbDxWV67pa4YZkk0yV7mevE3
 PTnM3XlV7K9J0wpGbWQqdO6eWrH8hia1rMkSfaEcJbQt4w5Euras33/FdxP8byyq1U6L
 rQEGMup0d7mXPawcSwXBeryOMaXgSiKhDAWe4qSldIm/FnQ6qcSkychHD0iUuiN33g+Y
 dqaSasznc6/CHIHAYDlAyquQCSKhw3DrhEmThhGToROSUwhZnpu/5b6W7H4DPThQ0pq+
 mSeUGeMT7S6ylbraTct8p5+cinPzMhTS7I5YkcNkWi6DYabWOXXdlUOlKKI9nMqRepFO
 Pfzw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUVpWRpB6fIjitYGvqE6wYA0X9eEEr7VwKinCYmZQ/yQraqnYbgbaiF6f9nWclc8NAN3fqb2Pn7mnlIFLAIFgXwvGoJnDk=
X-Gm-Message-State: AOJu0Yyw0NTgkgQXigeGMR5PdhY9qhwKZLTzKGQY7+bl2y1PGgn1RPcB
 2MCcaZAHQmoJ+Qbwq9F86Qo7WI5eYGnwswJAysKQfK8iPhaL3rNRWuecAMzxuM8=
X-Google-Smtp-Source: AGHT+IEzyo0kBsnOYmU7J95FW6PTu4FvyLaQtTDdtdCyFROEcIBLI3nnE5DZk9ppvy6TjINhQnQi/g==
X-Received: by 2002:a17:902:e80c:b0:1ff:50b0:f5e3 with SMTP id
 d9443c01a7336-1ff57292a15mr212589755ad.28.1722992820129; 
 Tue, 06 Aug 2024 18:07:00 -0700 (PDT)
Received: from ?IPV6:2403:580a:f89b:0:e01b:92e5:d779:1bc0?
 (2403-580a-f89b-0-e01b-92e5-d779-1bc0.ip6.aussiebb.net.
 [2403:580a:f89b:0:e01b:92e5:d779:1bc0])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1ff59298e8bsm93785795ad.268.2024.08.06.18.06.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Aug 2024 18:06:59 -0700 (PDT)
Message-ID: <e2d6dfe2-0c99-4caa-bba9-ce9b1225d0c4@linaro.org>
Date: Wed, 7 Aug 2024 11:06:49 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/20] target/riscv: save and restore elp state on priv
 transitions
To: Deepak Gupta <debug@rivosinc.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: pbonzini@redhat.com, palmer@dabbelt.com, Alistair.Francis@wdc.com,
 laurent@vivier.eu, bmeng.cn@gmail.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 Jim Shu <jim.shu@sifive.com>, Andy Chiu <andy.chiu@sifive.com>
References: <20240807000652.1417776-1-debug@rivosinc.com>
 <20240807000652.1417776-5-debug@rivosinc.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240807000652.1417776-5-debug@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

On 8/7/24 10:06, Deepak Gupta wrote:
> elp state is recorded in *status on trap entry (less privilege to higher
> privilege) and restored in elp from *status on trap exit (higher to less
> privilege).
> 
> Additionally this patch introduces a forward cfi helper function to
> determine if current privilege has forward cfi is enabled or not based on
> *envcfg (for U, VU, S, VU, HS) or mseccfg csr (for M). For qemu-user, a
> new field `ufcfien` is introduced which is by default set to false and
> helper function returns value deposited in `ufcfien` for qemu-user.
> 
> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
> Co-developed-by: Jim Shu <jim.shu@sifive.com>
> Co-developed-by: Andy Chiu <andy.chiu@sifive.com>
> ---
>   target/riscv/cpu.c        |  5 ++++
>   target/riscv/cpu.h        |  2 ++
>   target/riscv/cpu_helper.c | 58 +++++++++++++++++++++++++++++++++++++++
>   target/riscv/op_helper.c  | 18 ++++++++++++
>   4 files changed, 83 insertions(+)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 82fa85a8d6..e1526c7ab5 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -1022,6 +1022,11 @@ static void riscv_cpu_reset_hold(Object *obj, ResetType type)
>       env->load_res = -1;
>       set_default_nan_mode(1, &env->fp_status);
>   
> +#ifdef CONFIG_USER_ONLY
> +    /* qemu-user for riscv, fcfi is off by default */
> +    env->ufcfien = false;
> +#endif
> +
>   #ifndef CONFIG_USER_ONLY
>       if (cpu->cfg.debug) {
>           riscv_trigger_reset_hold(env);
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index ae436a3179..8c7841fc08 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -226,6 +226,7 @@ struct CPUArchState {
>       cfi_elp      elp;
>   #ifdef CONFIG_USER_ONLY
>       uint32_t elf_flags;
> +    bool ufcfien;
>   #endif
>   
>   #ifndef CONFIG_USER_ONLY
> @@ -530,6 +531,7 @@ void riscv_cpu_set_geilen(CPURISCVState *env, target_ulong geilen);
>   bool riscv_cpu_vector_enabled(CPURISCVState *env);
>   void riscv_cpu_set_virt_enabled(CPURISCVState *env, bool enable);
>   int riscv_env_mmu_index(CPURISCVState *env, bool ifetch);
> +bool cpu_get_fcfien(CPURISCVState *env);
>   G_NORETURN void  riscv_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
>                                                  MMUAccessType access_type,
>                                                  int mmu_idx, uintptr_t retaddr);
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index 6709622dd3..8c69c55576 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -33,6 +33,7 @@
>   #include "cpu_bits.h"
>   #include "debug.h"
>   #include "tcg/oversized-guest.h"
> +#include "pmp.h"
>   
>   int riscv_env_mmu_index(CPURISCVState *env, bool ifetch)
>   {
> @@ -63,6 +64,35 @@ int riscv_env_mmu_index(CPURISCVState *env, bool ifetch)
>   #endif
>   }
>   
> +bool cpu_get_fcfien(CPURISCVState *env)
> +{
> +#ifdef CONFIG_USER_ONLY
> +    return env->ufcfien;
> +#else
> +    /* no cfi extension, return false */
> +    if (!env_archcpu(env)->cfg.ext_zicfilp) {
> +        return false;
> +    }

Keep extension check common between user/system.
Recall that you can choose -cpu from user as well.

> +    /*
> +     * Interrupt/exception/trap delivery is asynchronous event and as per
> +     * Zisslpcfi spec CPU should clear up the ELP state. If cfi extension is
> +     * available, clear ELP state.
> +     */
> +
> +    if (cpu->cfg.ext_zicfilp) {
> +        env->elp = NO_LP_EXPECTED;
> +    }

If extension is not available, elp isn't a thing.
You can just as easily make the store unconditional and save the test.

> 
> +    /*
> +     * If forward cfi enabled for new priv, restore elp status
> +     * and clear spelp in mstatus
> +     */
> +    if (cpu_get_fcfien(env)) {
> +        env->elp = get_field(env->mstatus, MSTATUS_SPELP);
> +        env->mstatus = set_field(env->mstatus, MSTATUS_SPELP, 0);
> +    }

The spec is perhaps poorly written here.  I read

   ... if xPP holds the value y, then ELP is set to the value of xPELP if yLPE is 1;
   otherwise, it is set to NO_LP_EXPECTED; xPELP is set to NO_LP_EXPECTED.

as xPELP always being cleared, regardless of yLPE.


r~

