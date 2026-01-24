Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D06ED715E4
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Jan 2026 17:56:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjhrS-0007aM-RP; Sat, 24 Jan 2026 12:55:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fustini@kernel.org>)
 id 1vjhrP-0007a1-3M; Sat, 24 Jan 2026 12:55:47 -0500
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fustini@kernel.org>)
 id 1vjhrN-0002Ms-Cn; Sat, 24 Jan 2026 12:55:46 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id B7C8660055;
 Sat, 24 Jan 2026 17:55:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32716C116D0;
 Sat, 24 Jan 2026 17:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1769277336;
 bh=h1MaTzcBmyRjlL1Vme76HVwVGSrQKPurVRH/gUj2nqc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=SyAgu04p8nyqSxOT2qttO+nM50GNd95TxXg/0BW18fnFbVbEmp6u6E9zzYJgG/NBx
 /qtqhw4w68igfgBs7iDS0rc2qYW15tEgQep1cxz+UA5QyK+o87Hjtw6TpTEATsfb3X
 x/ksbTvGOxzRNcAMdcZKEx6SaSW1D3enX7T2QwiE+DnFArZ1iyUuiiHfMc8POj/PEx
 A7M7kDPZDVio7o9AHubMB+WN6zuYd3u+yjcBgSCecGGxavet73D9ApInEh/ibFbQpn
 jbX09ELjRg4pdGjBIM6j0ZJ7ZizVS2rpPffBifhaG0OGS8XfKeXEYG7UbSfPDBHSix
 TnAsIhv0RSg/w==
Date: Sat, 24 Jan 2026 09:55:34 -0800
From: Drew Fustini <fustini@kernel.org>
To: Radim =?utf-8?B?S3LEjW3DocWZ?= <radim.krcmar@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Nicolas Pitre <npitre@baylibre.com>,
 Kornel =?utf-8?Q?Dul=C4=99ba?= <mindal@semihalf.com>,
 Atish Kumar Patra <atishp@rivosinc.com>,
 Atish Patra <atish.patra@linux.dev>,
 Vasudevan Srinivasan <vasu@rivosinc.com>,
 Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@ventanamicro.com>,
 yunhui cui <cuiyunhui@bytedance.com>,
 Chen Pei <cp0613@linux.alibaba.com>, guo.wenjia23@zte.com.cn,
 liu.qingtao2@zte.com.cn
Subject: Re: [PATCH v4 3/6] hw/riscv: implement CBQRI capacity controller
Message-ID: <aXUHls5y7WCo80e9@x1>
References: <20260105-riscv-ssqosid-cbqri-v4-0-9ad7671dde78@kernel.org>
 <20260105-riscv-ssqosid-cbqri-v4-3-9ad7671dde78@kernel.org>
 <DFQ6PDOR5QOS.6B2ASHZOJ0U7@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DFQ6PDOR5QOS.6B2ASHZOJ0U7@oss.qualcomm.com>
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=fustini@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.082,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Jan 16, 2026 at 05:20:00PM +0000, Radim Krčmář wrote:
> Sorry, I changed emails, and this series flew under my radar, since
> qemu-riscv lore public inbox has been silent for a month and I was
> happily oblivious that it's a bug on their side.
> 
> I'm addressing only the access size issue in this mail and I'll look at
> the rest next week.
> 
> 2026-01-05T13:54:21-08:00, Drew Fustini <fustini@kernel.org>:
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
> > Signed-off-by: Drew Fustini <fustini@kernel.org>
> > ---
> > diff --git a/hw/riscv/cbqri_capacity.c b/hw/riscv/cbqri_capacity.c
> > +static const MemoryRegionOps riscv_cbqri_cc_ops = {
> > +    .read = riscv_cbqri_cc_read,
> > +    .write = riscv_cbqri_cc_write,
> > +    .endianness = DEVICE_LITTLE_ENDIAN,
> > +    .valid.min_access_size = 4,
> > +    .valid.max_access_size = 8,
> > +    .impl.min_access_size = 8,
> 
> The .impl.min_access_size should be 4, since access_with_adjusted_size
> doesn't seem to do what we want.

Ok, thanks.

> > +    .impl.max_access_size = 8,
> 
> I think we can reuse the current 8 byte iplementation by adding
> something like the following hack for 4 byte accesses:
> 
>   static uint64_t riscv_cbqri_cc_read_wrapper(void *opaque, hwaddr addr,
>                                               unsigned size)
>   {
>       uint64_t value = riscv_cbqri_br_read(opaque, addr & ~0x7UL, 8);
>       if (size == 4) {
>           if (addr & 0x7) {
>               return value >> 32;
>           } else {
>               return value & 0xffffffff;
>           }
>       }
>       return value;
>   }
> 
> read has no side-effects, so the wrapper should be conceptually correct.

Thank you very much for the suggestion. I'll try it out and get a new
revision ready.

> 
> 
>   static uint64_t riscv_cbqri_cc_write_wrapper(void *opaque, hwaddr addr,
>                                                uint64_t value, unsigned size)
>   {
>       if (size == 4) {
>           uint64_t reg = riscv_cbqri_br_read(opaque, addr & ~0x7UL, 8);
>           if (addr & 0x7) {
>               value = value << 32 | reg & 0xffffffff;
>           } else {
>               value = value | reg & ~0xffffffffUL;
>           }
>       }
> 
>       riscv_cbqri_cc_write(opaque, addr & ~0x7UL, value, 8);
>   }
>  
> The control registers will execute an operation on a write to the upper
> half as well, which doesn't seem desirable, but it's unspecified afaik.
> The upper half of control registers has no fields that software would
> ever want to write, so I think it's not really a practical issue,
> especially since we're basically a skeleton implementation.

Thanks for the suggestion, I think that is an acceptable solution. The
main point of the Qemu implementation is to exercise the Linux kernel
code ahead of silicon that implements CBQRI.

> Another solution would be to implement just 4 byte registers, and handle
> 8 byte writes as a combination of two 4 byte -- the spec hints that this
> is an expected implementation, but with all registers being defined as 8
> byte, I think my hack would need "clarifications" to make it incorrect.

Thanks for also suggesting this. I agree that the previous suggestion is
sufficent.

-Drew

