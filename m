Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063DE606A31F
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 23:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dEwq/94m
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMZpp-0004fp-TC; Thu, 29 Oct 2026 19:47:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fustini@kernel.org>)
 id 1xMZpn-0004fU-Qw; Thu, 29 Oct 2026 19:47:03 -0400
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fustini@kernel.org>)
 id 1xMZpl-000837-AX; Thu, 29 Oct 2026 19:47:03 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0C79141AE8;
 Thu, 29 Oct 2026 23:46:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A61A1F000C1;
 Thu, 29 Oct 2026 23:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793317618;
 bh=IYiCIDJQDzIy9sVZnACs7hlnPViMC7eFuP0TFj2bx9o=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=dEwq/94msYQCgD6yl0InVsQ3JY418ifxXs6kdpIY6UvoAUXhOgb5XglYVs/fhCShK
 5Ws8aK7U/Iuz0Oh9OFt/QjcYWiAiJa0VbRO7A6Wt8Gzp3edGdAoXFrW/w7pfO9XX4Y
 tSDNME5Y1q+YeJBusxqNyg5r57EBt+jNVekj9lGMsEvybYbqvkhc3isd5OGrELbBvg
 VsFSFt9uEvEjf0T+SjbLSrj4iInext4/H9wu+x470zm3uC+l1MA3mmbePAaH9b+o0b
 2nzhzl0rCyE9MfqOa59lpwkkskHIWYvS8ba91zNRL+LoYT84fzCZXqEETIuqLAI6U2
 9QL3IlxrfMI/g==
Date: Thu, 29 Oct 2026 16:46:57 -0700
From: Drew Fustini <fustini@kernel.org>
To: Prajwal N <prajwal.n@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Sunil V L <sunilvl@oss.qualcomm.com>,
 Anup Patel <anup.patel@oss.qualcomm.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Nicolas Pitre <npitre@baylibre.com>,
 Kornel =?utf-8?Q?Dul=C4=99ba?= <mindal@semihalf.com>,
 Atish Patra <atish.patra@linux.dev>,
 Radim =?utf-8?B?S3LEjW3DocWZ?= <radim.krcmar@oss.qualcomm.com>,
 yunhui cui <cuiyunhui@bytedance.com>,
 Chen Pei <cp0613@linux.alibaba.com>, guo.wenjia23@zte.com.cn,
 liu.qingtao2@zte.com.cn, prajwal.n.oss@gmail.com
Subject: Re: [PATCH v6 3/6] hw/riscv: implement CBQRI capacity controller
Message-ID: <auPa8dDH6tj8nZfH@thelio>
References: <20261026-riscv-ssqosid-cbqri-v6-0-1a367a35cd0e@kernel.org>
 <20261026-riscv-ssqosid-cbqri-v6-3-1a367a35cd0e@kernel.org>
 <b789deea-1d49-4d3e-8203-58ff42fcb930@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b789deea-1d49-4d3e-8203-58ff42fcb930@oss.qualcomm.com>
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=fustini@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Oct 28, 2026 at 07:02:32PM +0530, Prajwal N wrote:
> Hi Drew,
> 
> On 26-10-2026 23:17, Drew Fustini wrote:
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
> > Link: https://github.com/riscv-non-isa/riscv-cbqri/releases/tag/v1.0
> > Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
> > [fustini: add fields introduced in the ratified spec: cunits, rpfx, p]
> > Reviewed-by: Radim Krčmář <radim.krcmar@oss.qualcomm.com>
> > Signed-off-by: Drew Fustini <fustini@kernel.org>
> > ---
> >  MAINTAINERS               |   1 +
> >  hw/riscv/cbqri_capacity.c | 727 ++++++++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 728 insertions(+)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 2984779ce43a..f230cdbbe1b8 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -408,6 +408,7 @@ M: Nicolas Pitre <npitre@baylibre.com>
> >  M: Drew Fustini <fustini@kernel.org>
> >  L: qemu-riscv@nongnu.org
> >  S: Supported
> > +F: hw/riscv/cbqri_capacity.c
> >  F: include/hw/riscv/cbqri.h
> >  
> >  RISC-V SiFive (Xsf*) extensions
> > diff --git a/hw/riscv/cbqri_capacity.c b/hw/riscv/cbqri_capacity.c
> > new file mode 100644
> > index 000000000000..7ea20532b950
> > --- /dev/null
> > +++ b/hw/riscv/cbqri_capacity.c
> > @@ -0,0 +1,727 @@
> > +/*
> > + * RISC-V Capacity and Bandwidth QoS Register Interface
> > + * URL: https://github.com/riscv-non-isa/riscv-cbqri/releases/tag/v1.0
> > + *
> > + * Copyright (c) 2023 BayLibre SAS
> > + * SPDX-License-Identifier: GPL-2.0-or-later
> > + *
> > + * This file contains the Capacity-controller QoS Register Interface.
> > + */
> > +
> > +#include "qemu/osdep.h"
> > +#include "qapi/error.h"
> > +#include "qemu/error-report.h"
> > +#include "qemu/log.h"
> > +#include "qemu/module.h"
> > +#include "qemu/bitmap.h"
> > +#include "hw/core/qdev-properties.h"
> > +#include "hw/core/sysbus.h"
> > +#include "target/riscv/cpu.h"
> > +#include "hw/riscv/cbqri.h"
> 
> [...]
> 
> > +static void riscv_cbqri_cc_write(void *opaque, hwaddr addr,
> > +                                 uint64_t value, unsigned size)
> > +{
> > +    RiscvCbqriCapacityState *cc = opaque;
> > +
> > +    assert((addr % 8) == 0);
> > +
> The same comments in the riscv_cbqri_cc_read() below are applicable
> here as well.
> 
> > +    switch (addr) {
> > +    case A_CC_CAPABILITIES:
> > +        /* read-only register */
> > +        break;
> > +    case A_CC_MON_CTL:
> > +        riscv_cbqri_cc_write_mon_ctl(cc, value);
> > +        break;
> > +    case A_CC_ALLOC_CTL:
> > +        riscv_cbqri_cc_write_alloc_ctl(cc, value);
> > +        break;
> > +    case A_CC_MON_CTR_VAL:
> > +        /* read-only register */
> > +        break;
> > +    case A_CC_BLOCK_MASK:
> > +        if (cc->ncblks == 0) {
> > +            break;
> > +        }
> > +        /* fallthrough */
> > +    default:
> > +        uint32_t blkmask_slot = (addr - A_CC_BLOCK_MASK) / 8;
> > +        if (blkmask_slot == get_slots(cc)) {
> > +            /* this is cc_cunits register */
> > +            break;
> > +        } else if (blkmask_slot > get_slots(cc)) {
> > +            qemu_log_mask(LOG_GUEST_ERROR,
> > +                          "%s: out of bounds (addr=0x%x)",
> > +                          __func__, (uint32_t)addr);
> > +            break;
> > +        }
> > +        cc->alloc_blockmasks[blkmask_slot] = value;
> > +    }
> > +}
> > +
> > +static uint64_t riscv_cbqri_cc_read(void *opaque, hwaddr addr, unsigned size)
> > +{
> > +    RiscvCbqriCapacityState *cc = opaque;
> > +    uint64_t value = 0;
> > +
> > +    assert((addr % 8) == 0);
> > +
> To access the 64 bit CBQRI register, the Linux kernel is performing two
> 32 bit reads. The register offsets that are passed to this function are 0x00,
> 0x04, 0x08 ... The assert is triggered for the addr 0x04, 0x0c.. and the
> QEMU exists.
> This check should have been:
> assert((addr %4) == 0)
> 
> The switch statement uses the register offsets that are 8-byte aligned.
> A_CC_CAPABILITIES (0x00), A_CC_MON_CTL (0x08) etc.
> Since the kernel invokes read twice, the second readl() has the offset addr
> 0x04. This does not match any offset and falls into the default case.
> The following change fixes the problem.
> 
>        hwaddr reg_addr = addr & ~7ULL; /* align down to 8-byte boundary */> +    switch (addr) {
>        switch (reg_addr) {> +    case A_CC_CAPABILITIES:
> > +        value = FIELD_DP64(value, CC_CAPABILITIES, VER_MAJOR,
> > +                           RISCV_CBQRI_VERSION_MAJOR);
> > +        value = FIELD_DP64(value, CC_CAPABILITIES, VER_MINOR,
> > +                           RISCV_CBQRI_VERSION_MINOR);
> > +        value = FIELD_DP64(value, CC_CAPABILITIES, NCBLKS,
> > +                           cc->ncblks);
> > +        value = FIELD_DP64(value, CC_CAPABILITIES, FRCID,
> > +                           cc->supports_alloc_op_flush_rcid);
> > +        value = FIELD_DP64(value, CC_CAPABILITIES, CUNITS, 0);
> > +        value = FIELD_DP64(value, CC_CAPABILITIES, RPFX, 0);
> > +        value = FIELD_DP64(value, CC_CAPABILITIES, P, 0);
> > +        break;
> > +    case A_CC_MON_CTL:
> > +        value = cc->cc_mon_ctl;
> > +        break;
> > +    case A_CC_ALLOC_CTL:
> > +        value = cc->cc_alloc_ctl;
> > +        break;
> > +    case A_CC_MON_CTR_VAL:
> > +        value = cc->cc_mon_ctr_val;
> > +        break;
> > +    case A_CC_BLOCK_MASK:
> > +        if (cc->ncblks == 0) {
> > +            break;
> > +        }
> > +        /* fallthrough */
> > +    default:
> > +        unsigned int blkmask_slot = (addr - A_CC_BLOCK_MASK) / 8;
> > +        if (blkmask_slot == get_slots(cc)) {
> > +            /*
> > +             * The cc_cunits register is always the slot following the
> > +             * last slot of cc_blockmask register. Capacity units are
> > +             * not supported by this implementation so must return 0.
> > +             */
> > +            value = 0;
> > +            break;
> > +        } else if (blkmask_slot > get_slots(cc)) {
> > +            qemu_log_mask(LOG_GUEST_ERROR, "%s: out of bounds (addr=0x%x)",
> > +                          __func__, (uint32_t)addr);
> > +            break;
> > +        }
> > +        value = cc->alloc_blockmasks[blkmask_slot];
> > +    }
> > +
> The logic within the switch statement always computes the full 64-bit register
> value. But the Linux kernel requested for 32 bits. The kernel is creating a
> 64-bit value with the two 32-bit values. This should return only the relevant half.
> The following code snippet fixed the problem.
>     /* Return the correct 32-bit */
>     if (size == 4) {
>         if (addr & 4)
>             return value >> 32;   // high word
>         else
>             return value & 0xffffffff;  // low word
>     }
> 
> Thanks,
> Prajwal N

Thank you for reviewing. Did you see that riscv_cbqri_cc_ops actually
invokes riscv_cbqri_cc_read_wrapper() and
riscv_cbqri_cc_write_wrapper()?

Those wrappers were added in v5 based on Radim's feedback on v4.

Thanks,
Drew

