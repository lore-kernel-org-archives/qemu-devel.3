Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C61B5CFC515
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Nov 2025 03:53:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMcrV-00069T-6Z; Fri, 21 Nov 2025 20:56:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fustini@kernel.org>)
 id 1vMbdx-0004XH-Pc; Fri, 21 Nov 2025 19:38:26 -0500
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fustini@kernel.org>)
 id 1vMbdm-0006Fp-9d; Fri, 21 Nov 2025 19:38:21 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 9035B419AD;
 Fri, 21 Nov 2025 19:50:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31AE4C4CEF1;
 Fri, 21 Nov 2025 19:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1763754652;
 bh=ocvIczLizuo1p7TQN3uTgxUV3nXqKPquig4s0T4MZA0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=JPutPbb2v5Nir2ApZigTa5LMg4wHA5HTzGZip80UIWUjlEE15ri/H7Vp5ZtkoRfeE
 Y2K5lcuTCfC8UuZnWTY36LgvMCXtGf2wIv1fmxkGvymhbsc2pS3lfstx2CksQCsncc
 wEm1en+84bEsw+iHwjzewl50K7Y2K/vhX6ZgUxjyx46HERAc+UVKAJUEkTi8dtRsYq
 KFY4M7JbEgs3BlKIXlr6mrzWJtpEHutDwu8dUWP00c3n1qUtd2RanNslFTOGABC3ue
 RybzMgl8r8r/eg/hngplmDaeQ6wShv8+5OjjEdHIaKijFLTuABsxB4osY0rWqJZs39
 yqjVsDguWkifQ==
Date: Fri, 21 Nov 2025 11:50:50 -0800
From: Drew Fustini <fustini@kernel.org>
To: Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@ventanamicro.com>
Cc: qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Nicolas Pitre <npitre@baylibre.com>,
 Kornel =?utf-8?Q?Dul=C4=99ba?= <mindal@semihalf.com>,
 Atish Kumar Patra <atishp@rivosinc.com>,
 Atish Patra <atish.patra@linux.dev>,
 Vasudevan Srinivasan <vasu@rivosinc.com>,
 yunhui cui <cuiyunhui@bytedance.com>,
 Chen Pei <cp0613@linux.alibaba.com>, guo.wenjia23@zte.com.cn,
 liu.qingtao2@zte.com.cn,
 qemu-riscv-bounces+qemu-riscv=archiver.kernel.org@nongnu.org
Subject: Re: [PATCH 3/7] hw/riscv: implement CBQRI capacity controller
Message-ID: <aSDCmrvONUgvzqbV@x1>
References: <20251119-riscv-ssqosid-cbqri-v1-0-3392fc760e48@kernel.org>
 <20251119-riscv-ssqosid-cbqri-v1-3-3392fc760e48@kernel.org>
 <DEDROLF9I9YQ.2MQIEGB7I4BKH@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DEDROLF9I9YQ.2MQIEGB7I4BKH@ventanamicro.com>
Received-SPF: pass client-ip=172.234.252.31; envelope-from=fustini@kernel.org;
 helo=sea.source.kernel.org
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

On Thu, Nov 20, 2025 at 08:25:44PM +0100, Radim Krčmář wrote:
> 2025-11-19T16:42:19-08:00, Drew Fustini <fustini@kernel.org>:
> > From: Nicolas Pitre <npitre@baylibre.com>
> >
> > Implement a capacity controller according to the Capacity and Bandwidth
> > QoS Register Interface (CBQRI) which supports these capabilities:
> >
> >   - Number of access types: 2 (code and data)
> >   - Usage monitoring operations: CONFIG_EVENT, READ_COUNTER
> >   - Event IDs supported: None, Occupancy
> >   - Capacity allocation ops: CONFIG_LIMIT, READ_LIMIT, FLUSH_RCID
> >
> > Link: https://github.com/riscv-non-isa/riscv-cbqri/blob/main/riscv-cbqri.pdf
> > Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
> > [fustini: add fields introduced in the ratified spec: cunits, rpfx, p]
> > Signed-off-by: Drew Fustini <fustini@kernel.org>
> > ---
> > diff --git a/hw/riscv/cbqri_capacity.c b/hw/riscv/cbqri_capacity.c
> > [...]
> > +static void riscv_cbqri_cc_write_alloc_ctl(RiscvCbqriCapacityState *cc,
> > +                                           uint64_t value)
> > +{
> >[...]
> > +    if (rcid >= cc->nb_rcids) {
> > +        status = CC_ALLOC_STATUS_INVAL_RCID;
> > +    } else if (atv && !is_valid_at(cc, at)) {
> > +        status = CC_ALLOC_STATUS_INVAL_AT;
> > +    } else if (op == CC_ALLOC_OP_CONFIG_LIMIT &&
> > +               cc->supports_alloc_op_config_limit) {
> > +        status = alloc_blockmask_config(cc, rcid, at, &busy);
> > +    } else if (op == CC_ALLOC_OP_READ_LIMIT &&
> > +               cc->supports_alloc_op_read_limit) {
> > +        status = alloc_blockmask_read(cc, rcid, at, &busy);
> > +    } else if (op == CC_ALLOC_OP_FLUSH_RCID &&
> > +               cc->supports_alloc_op_flush_rcid) {
> > +        status = alloc_blockmask_init(cc, rcid, at, false, &busy);
> 
> The spec says the following about flush:
> 
>   "The configured capacity block allocation or the capacity unit limit
>    is not changed by this operation."
> 
> Limits are not implemented, so I think it's supposed to be a nop.

Thanks, that makes sense. I'll change it for the next revision.

> > [...]
> > +static uint64_t riscv_cbqri_cc_read(void *opaque, hwaddr addr, unsigned size)
> > +{
> > +    RiscvCbqriCapacityState *cc = opaque;
> > +    uint64_t value = 0;
> > +
> > +    assert((addr % 8) == 0);
> > +    assert(size == 8);
> 
> Is there a plan to extend support for 32 bit operations?
> 
>   "The CBQRI registers are defined so that software can perform two
>    individual 4 byte accesses."

Good question. Daniel also commented about the asserts for size == 8
while your MemoryRegionOps has .valid.min_access_size = 4. It does seem
like from the spec that these CBQRI controllers do need to support 4
byte accesses.

However, I need to understand better how to accomplish that. I'm
uncertain if I need to add code to the read and write hooks for that, or
if something in MemoryRegionOps can handle it automatically.

> > [...]
> > +    case A_CC_BLOCK_MASK:
> > +        if (cc->ncblks == 0) {
> > +            break;
> > +        }
> > +        /* fallthrough */
> > +    default:
> > +        unsigned int blkmask_slot = (addr - A_CC_BLOCK_MASK) / 8;
> > +        if (blkmask_slot >= (cc->ncblks + 63) / 64) {
> > +            qemu_log_mask(LOG_GUEST_ERROR,
> > +                          "%s: out of bounds (addr=0x%x)",
> > +                          __func__, (uint32_t)addr);
> > +            break;
> > +        }
> > +        value = cc->alloc_blockmasks[blkmask_slot];
> 
> There is supposed to be a cc_cunits registers after the cc_block_mask.

Good point, I need to update the code to account for cc_units.

> > [...]
> > +static void riscv_cbqri_cc_realize(DeviceState *dev, Error **errp)
> > +{
> > +    RiscvCbqriCapacityState *cc = RISCV_CBQRI_CC(dev);
> > +
> > +    if (!cc->mmio_base) {
> > +        error_setg(errp, "mmio_base property not set");
> > +        return;
> > +    }
> > +
> > +    assert(cc->mon_counters == NULL);
> > +    cc->mon_counters = g_new0(MonitorCounter, cc->nb_mcids);
> > +
> > +    assert(cc->alloc_blockmasks == NULL);
> > +    uint64_t *end = get_blockmask_location(cc, cc->nb_rcids, 0);
> > +    unsigned int blockmasks_size = end - cc->alloc_blockmasks;
> > +    cc->alloc_blockmasks = g_new0(uint64_t, blockmasks_size);
> > +
> > +    memory_region_init_io(&cc->mmio, OBJECT(dev), &riscv_cbqri_cc_ops,
> > +                          cc, TYPE_RISCV_CBQRI_CC".mmio", 4 * 1024);
> 
> Shouldn't the region size take cc->ncblks into account?
> (A bitmask for 2^16 ids is 8kB.)

cc_block_mask field is BMW / 8. In the case of NCBLKS of 12 and NCBLKS
of 16, both end up with a BMW of 64 which would be 8 bytes. I think the
the only reason the allocation is 4KB is that is meant to be aligned to
the page size. Otherwise, the capacity controller register layout is
pretty small.

> > +    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &cc->mmio);
> > +    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, cc->mmio_base);
> > +}
> > +
> > +static void riscv_cbqri_cc_reset(DeviceState *dev)
> > +{
> > +    RiscvCbqriCapacityState *cc = RISCV_CBQRI_CC(dev);
> > +
> > +    cc->cc_mon_ctl = 0;
> > +    cc->cc_alloc_ctl = 0;
> 
> Only the busy field must be reset to 0.  I think the decision warrants a
> comment that we're zeroing more to have simpler code.

Okay, will do.

> > +
> > +    /* assign all capacity only to rcid0 */
> > +    for (unsigned int rcid = 0; rcid < cc->nb_rcids; rcid++) {
> 
> rcid != 0 are unspecified on reset, so I would prefer not to touch them.

Okay, that is a good point that the spec does state that. I'll fix this
in the next rev.

> > +        bool any_at = false;
> > +
> > +        if (cc->supports_at_data) {
> > +            alloc_blockmask_init(cc, rcid, CC_AT_DATA,
> > +                                 rcid == 0, NULL);
> > +            any_at = true;
> > +        }
> > +        if (cc->supports_at_code) {
> > +            alloc_blockmask_init(cc, rcid, CC_AT_CODE,
> > +                                 rcid == 0, NULL);
> > +            any_at = true;
> > +        }
> > +        if (!any_at) {
> > +            alloc_blockmask_init(cc, rcid, 0,
> > +                                 rcid == 0, NULL);
> > +        }
> > +    }
> 
> I think it looks a bit better if AT values were expressed as a bitfield
> of size 8: (untested)
> 
>     unsigned long at = find_next_bit(&cc->supported_at_mask, 8, 0);
> 
>     do {
>         alloc_blockmask_init(cc, rcid, at < 8 ? at : 0, rcid == 0, NULL);
>         at = find_next_bit(&cc->supported_at_mask, 8, at + 1);
>     } while (at < 8);

Thanks for the suggestion. I will give that a try.

Drew

