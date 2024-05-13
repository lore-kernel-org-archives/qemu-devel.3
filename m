Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 228BFC25B4F
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 02:50:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6Ll2-0007Hj-4S; Sun, 12 May 2024 22:49:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1s6Ll0-0007HW-Ds; Sun, 12 May 2024 22:49:42 -0400
Received: from out30-97.freemail.mail.aliyun.com ([115.124.30.97])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1s6Lky-0005Q1-96; Sun, 12 May 2024 22:49:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1715568573; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
 bh=zp5uFVm3nFAfT+F7u0n/FtKL1mlqAQXjKwq+vAabzhE=;
 b=F9j4IRFilGqJra6/Ag83rlxJeVGAh1ce8Lzq7s70CrFJoPNhHVQhVzYvLpS9KZa10fIMdy812aQ2JmafmVeMBrhl1y9Wh9OytHO2kyxd9cY8URMPGoRYKUGRNWcd5E1GGWkgD/psCHFKhkG3debqbA0jJTyPgIxW6d28867QymQ=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R141e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033037067109;
 MF=zhiwei_liu@linux.alibaba.com; NM=1; PH=DS; RN=9; SR=0;
 TI=SMTPD_---0W6H4snT_1715568570; 
Received: from 30.198.0.184(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0W6H4snT_1715568570) by smtp.aliyun-inc.com;
 Mon, 13 May 2024 10:49:32 +0800
Message-ID: <c9969b2a-db87-4694-9fe9-bad7aa6bf749@linux.alibaba.com>
Date: Mon, 13 May 2024 10:48:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] target/riscv: Add MEDELEGH, HEDELEGH csrs for RV32
To: "Fea.Wang" <fea.wang@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Frank Chang <frank.chang@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
References: <20240510065856.2436870-1-fea.wang@sifive.com>
 <20240510065856.2436870-5-fea.wang@sifive.com>
Content-Language: en-US
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
In-Reply-To: <20240510065856.2436870-5-fea.wang@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=115.124.30.97;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-97.freemail.mail.aliyun.com
X-Spam_score_int: -174
X-Spam_score: -17.5
X-Spam_bar: -----------------
X-Spam_report: (-17.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
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
> Based on privileged spec 1.13, the RV32 needs to implement MEDELEGH
> and HEDELEGH for exception codes 32-47 for reserving and exception codes
> 48-63 for custom use. Add the CSR number though the implementation is
> just reading zero and writing ignore. Besides, for accessing HEDELEGH, it
> should be controlled by mstateen0 'P1P13' bit.
>
> Signed-off-by: Fea.Wang <fea.wang@sifive.com>
> Reviewed-by: Frank Chang <frank.chang@sifive.com>
> ---
>   target/riscv/cpu_bits.h |  2 ++
>   target/riscv/csr.c      | 31 +++++++++++++++++++++++++++++++
>   2 files changed, 33 insertions(+)
>
> diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
> index 28bd3fb0b4..f888025c59 100644
> --- a/target/riscv/cpu_bits.h
> +++ b/target/riscv/cpu_bits.h
> @@ -156,6 +156,8 @@
>   
>   /* 32-bit only */
>   #define CSR_MSTATUSH        0x310
> +#define CSR_MEDELEGH        0x312
> +#define CSR_HEDELEGH        0x612
>   
>   /* Machine Trap Handling */
>   #define CSR_MSCRATCH        0x340
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index d844ce770e..4d7313f456 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -3227,6 +3227,33 @@ static RISCVException write_hedeleg(CPURISCVState *env, int csrno,
>       return RISCV_EXCP_NONE;
>   }
>   
> +static RISCVException read_hedelegh(CPURISCVState *env, int csrno,
> +                                   target_ulong *val)
> +{
> +    RISCVException ret;
> +    ret = smstateen_acc_ok(env, 0, SMSTATEEN0_P1P13);
> +    if (ret != RISCV_EXCP_NONE) {
> +        return ret;
> +    }
> +
> +    /* Reserved, now read zero */
> +    *val = 0;
> +    return RISCV_EXCP_NONE;
> +}
> +
> +static RISCVException write_hedelegh(CPURISCVState *env, int csrno,
> +                                    target_ulong val)
> +{
> +    RISCVException ret;
> +    ret = smstateen_acc_ok(env, 0, SMSTATEEN0_P1P13);
> +    if (ret != RISCV_EXCP_NONE) {
> +        return ret;
> +    }
> +
> +    /* Reserved, now write ignore */
> +    return RISCV_EXCP_NONE;
> +}
> +
>   static RISCVException rmw_hvien64(CPURISCVState *env, int csrno,
>                                       uint64_t *ret_val,
>                                       uint64_t new_val, uint64_t wr_mask)
> @@ -4674,6 +4701,10 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
>   
>       [CSR_MSTATUSH]    = { "mstatush",   any32, read_mstatush,
>                             write_mstatush                                   },
> +    [CSR_MEDELEGH]    = { "medelegh",   any32, read_zero, write_ignore,
> +                          .min_priv_ver = PRIV_VERSION_1_13_0              },
> +    [CSR_HEDELEGH]    = { "hedelegh",   any32, read_hedelegh, write_hedelegh,

Using hmode32 instead of any32.

Otherwise,

Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>

> +                          .min_priv_ver = PRIV_VERSION_1_13_0              },
>   
>       /* Machine Trap Handling */
>       [CSR_MSCRATCH] = { "mscratch", any,  read_mscratch, write_mscratch,

