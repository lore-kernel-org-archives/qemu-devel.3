Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8527ED1CA0E
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 02:58:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t89l2-0001M9-84; Mon, 04 Nov 2024 21:57:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1t89kz-0001Lx-UF; Mon, 04 Nov 2024 21:57:27 -0500
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1t89kw-0004x7-JD; Mon, 04 Nov 2024 21:57:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1730775425; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
 bh=TLkZRXZJ0N7alAVwEloPFb4/OYZquJnSb4GDE7GWofk=;
 b=qaaMOqZsE7PFq025BrFVA1JVDfKuRVzBYEH8kRCnkYXXSwfd2AOgfkJINPu2w2sshaioqQEz8Enn6RyY4M9tWagO6EKjiuw03pklyzgqNQIirU7/ct2wOYFtha+vs6IMrw0+LmKNJFajP2qGz2X5RhJl2NwXbvPPd7N6IhdlszE=
Received: from 30.166.64.101(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0WIlKOFR_1730775423 cluster:ay36) by smtp.aliyun-inc.com;
 Tue, 05 Nov 2024 10:57:04 +0800
Message-ID: <b2de2778-df6f-4f5e-a4c8-bf8b721f64ab@linux.alibaba.com>
Date: Tue, 5 Nov 2024 10:57:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hw/riscv: fix build error with clang
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Roman Bolshakov <rbolshakov@ddn.com>, Bin Meng <bmeng.cn@gmail.com>,
 tjeznach@rivosinc.com, qemu-riscv@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, pbonzini@redhat.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 peter.maydell@linaro.org, Cameron Esfahani <dirty@apple.com>,
 Weiwei Li <liwei1518@gmail.com>
References: <20241104222225.1523751-1-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
In-Reply-To: <20241104222225.1523751-1-pierrick.bouvier@linaro.org>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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


On 2024/11/5 06:22, Pierrick Bouvier wrote:
> Introduced in 0c54ac, "hw/riscv: add RISC-V IOMMU base emulation"
>
> ../hw/riscv/riscv-iommu.c:187:17: error: redefinition of '_pext_u64'
>
>    187 | static uint64_t _pext_u64(uint64_t val, uint64_t ext)
>
>        |                 ^
>
> D:/a/_temp/msys64/clang64/lib/clang/18/include/bmi2intrin.h:217:1: note: previous definition is here
>
>    217 | _pext_u64(unsigned long long __X, unsigned long long __Y)
>
>        | ^
>
> After a conversation on the mailing list, it was decided to rename and
> add a comment for this function.
>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>

Zhiwei

> ---
>   hw/riscv/riscv-iommu.c | 23 ++++++++++++++++++++---
>   1 file changed, 20 insertions(+), 3 deletions(-)
>
> diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
> index feb650549ac..12f01a75f5d 100644
> --- a/hw/riscv/riscv-iommu.c
> +++ b/hw/riscv/riscv-iommu.c
> @@ -183,8 +183,25 @@ static void riscv_iommu_pri(RISCVIOMMUState *s,
>       }
>   }
>   
> -/* Portable implementation of pext_u64, bit-mask extraction. */
> -static uint64_t _pext_u64(uint64_t val, uint64_t ext)
> +/*
> + * Discards all bits from 'val' whose matching bits in the same
> + * positions in the mask 'ext' are zeros, and packs the remaining
> + * bits from 'val' contiguously at the least-significant end of the
> + * result, keeping the same bit order as 'val' and filling any
> + * other bits at the most-significant end of the result with zeros.
> + *
> + * For example, for the following 'val' and 'ext', the return 'ret'
> + * will be:
> + *
> + * val = a b c d e f g h
> + * ext = 1 0 1 0 0 1 1 0
> + * ret = 0 0 0 0 a c f g
> + *
> + * This function, taken from the riscv-iommu 1.0 spec, section 2.3.3
> + * "Process to translate addresses of MSIs", is similar to bit manip
> + * function PEXT (Parallel bits extract) from x86.
> + */
> +static uint64_t riscv_iommu_pext_u64(uint64_t val, uint64_t ext)
>   {
>       uint64_t ret = 0;
>       uint64_t rot = 1;
> @@ -528,7 +545,7 @@ static MemTxResult riscv_iommu_msi_write(RISCVIOMMUState *s,
>       int cause;
>   
>       /* Interrupt File Number */
> -    intn = _pext_u64(PPN_DOWN(gpa), ctx->msi_addr_mask);
> +    intn = riscv_iommu_pext_u64(PPN_DOWN(gpa), ctx->msi_addr_mask);
>       if (intn >= 256) {
>           /* Interrupt file number out of range */
>           res = MEMTX_ACCESS_ERROR;

