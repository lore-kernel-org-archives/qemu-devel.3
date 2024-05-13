Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDEA6C25B5F
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 02:52:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6LnT-0008S2-VJ; Sun, 12 May 2024 22:52:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1s6LnJ-0008RO-IQ; Sun, 12 May 2024 22:52:07 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1s6LnG-0005rx-3e; Sun, 12 May 2024 22:52:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1715568715; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
 bh=y8+lqmna9PA0dgdfPGW1nPZSPRpexLGI05XdqOlzoWI=;
 b=a6f49jM3/De0MlJrU9intNjk8OPjYnfG6S14kquo6NCZIJ+e5Vp6Q4Byf0PKx8hWoC0EhvZtgB+VRvIMVwIbUPM0KYhY9CvTWpt4x4Tdgqi2zhy+IUZAa42hvD9FEMDR5zJ9RDaBFY5G3wFm45LQ+eNUgex9iDSqFmyWQx+J5rs=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R531e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033037067111;
 MF=zhiwei_liu@linux.alibaba.com; NM=1; PH=DS; RN=9; SR=0;
 TI=SMTPD_---0W6H5eKN_1715568712; 
Received: from 30.198.0.184(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0W6H5eKN_1715568712) by smtp.aliyun-inc.com;
 Mon, 13 May 2024 10:51:54 +0800
Message-ID: <c4e44f4a-5409-4914-b4b8-f6ab3b14e71b@linux.alibaba.com>
Date: Mon, 13 May 2024 10:51:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] target/riscv: Add 'P1P13' bit in SMSTATEEN0
To: "Fea.Wang" <fea.wang@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Frank Chang <frank.chang@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
References: <20240510065856.2436870-1-fea.wang@sifive.com>
 <20240510065856.2436870-4-fea.wang@sifive.com>
Content-Language: en-US
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
In-Reply-To: <20240510065856.2436870-4-fea.wang@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=115.124.30.130;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-130.freemail.mail.aliyun.com
X-Spam_score_int: -174
X-Spam_score: -17.5
X-Spam_bar: -----------------
X-Spam_report: (-17.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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


On 2024/5/10 14:58, Fea.Wang wrote:
> Based on privilege 1.13 spec, there should be a bit56 for 'P1P13' in
> SMSTATEEN0 that controls access to the hedeleg.
>
> Signed-off-by: Fea.Wang <fea.wang@sifive.com>
> Reviewed-by: Frank Chang <frank.chang@sifive.com>
> ---
>   target/riscv/cpu_bits.h |  1 +
>   target/riscv/csr.c      | 10 ++++++++++
>   2 files changed, 11 insertions(+)
>
> diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
> index 74318a925c..28bd3fb0b4 100644
> --- a/target/riscv/cpu_bits.h
> +++ b/target/riscv/cpu_bits.h
> @@ -315,6 +315,7 @@
>   #define SMSTATEEN0_CS       (1ULL << 0)
>   #define SMSTATEEN0_FCSR     (1ULL << 1)
>   #define SMSTATEEN0_JVT      (1ULL << 2)
> +#define SMSTATEEN0_P1P13    (1ULL << 56)
>   #define SMSTATEEN0_HSCONTXT (1ULL << 57)
>   #define SMSTATEEN0_IMSIC    (1ULL << 58)
>   #define SMSTATEEN0_AIA      (1ULL << 59)
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index 6b460ee0e8..d844ce770e 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -2248,6 +2248,11 @@ static RISCVException write_mstateen0(CPURISCVState *env, int csrno,
>           wr_mask |= SMSTATEEN0_FCSR;
>       }
>   
> +    RISCVCPU *cpu = env_archcpu(env);
> +    if (cpu->env.priv_ver >= PRIV_VERSION_1_13_0) {
Why not use env directly?
> +        wr_mask |= SMSTATEEN0_P1P13;
> +    }
> +
>       return write_mstateen(env, csrno, wr_mask, new_val);
>   }
>   
> @@ -2283,6 +2288,11 @@ static RISCVException write_mstateen0h(CPURISCVState *env, int csrno,
>   {
>       uint64_t wr_mask = SMSTATEEN_STATEEN | SMSTATEEN0_HSENVCFG;
>   
> +    RISCVCPU *cpu = env_archcpu(env);
> +    if (cpu->env.priv_ver >= PRIV_VERSION_1_13_0) {
Same here.
> +            wr_mask |= SMSTATEEN0_P1P13;

Indent.

Zhiwei

> +    }
> +
>       return write_mstateenh(env, csrno, wr_mask, new_val);
>   }
>   

