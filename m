Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D724CFC519
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Nov 2025 03:25:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMcjI-0000Ha-Cb; Fri, 21 Nov 2025 20:48:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fustini@kernel.org>)
 id 1vMbPX-0004Jq-1Z; Fri, 21 Nov 2025 19:23:32 -0500
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fustini@kernel.org>)
 id 1vMbPK-0002Rd-Ug; Fri, 21 Nov 2025 19:23:27 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id E279643F60;
 Fri, 21 Nov 2025 18:57:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88AC9C116C6;
 Fri, 21 Nov 2025 18:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1763751448;
 bh=4v/4H6HK6k3+IlgT1aQrDWAFbJmsD5QFrpz8ER7m8To=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=h+eh58ZTHyPR4P+AvJ2h0q4tV95gSs5RcRkWveyF7jFNjY/Z7Sq8gKDB+1GSRP7DS
 fdgaxRaemEMg2U6lJQeQygFZMJG4vw8ANnv4R9/kTRBFcDGKXK3HEugMfNuP5AMHo5
 iXYcpUFHEu7sdS8lkMYLZWX9z+JjD+jp/ZOhT9Fv8XoRJWF+gVv8zJIs7d6UtKQ6EC
 z3Hc4N51Zhmc2ZlfGeiweCj0/s46Nbg5Tc+PbGAgA+l3RavZuLTXeqzSUyaAo9Vtai
 /4hzTFF0CtmK1LxOf6Kk/mMAGY46sPte3TfOW85DEHj7JTT6+8Gf0+SowQRB3/Sikj
 IVB1zPJ907seA==
Date: Fri, 21 Nov 2025 10:57:26 -0800
From: Drew Fustini <fustini@kernel.org>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Nicolas Pitre <npitre@baylibre.com>,
 Kornel =?utf-8?Q?Dul=C4=99ba?= <mindal@semihalf.com>,
 Atish Kumar Patra <atishp@rivosinc.com>,
 Atish Patra <atish.patra@linux.dev>,
 Vasudevan Srinivasan <vasu@rivosinc.com>,
 Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@ventanamicro.com>,
 yunhui cui <cuiyunhui@bytedance.com>,
 Chen Pei <cp0613@linux.alibaba.com>, guo.wenjia23@zte.com.cn,
 liu.qingtao2@zte.com.cn
Subject: Re: [PATCH 3/7] hw/riscv: implement CBQRI capacity controller
Message-ID: <aSC2FhUFlrKSSuwI@x1>
References: <20251119-riscv-ssqosid-cbqri-v1-0-3392fc760e48@kernel.org>
 <20251119-riscv-ssqosid-cbqri-v1-3-3392fc760e48@kernel.org>
 <ea794b78-2b7e-44eb-96e2-342f6a338090@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea794b78-2b7e-44eb-96e2-342f6a338090@ventanamicro.com>
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

On Thu, Nov 20, 2025 at 08:47:44AM -0300, Daniel Henrique Barboza wrote:
> [ ...]
> 
> > +
> > +static void riscv_cbqri_cc_write(void *opaque, hwaddr addr,
> > +                                 uint64_t value, unsigned size)
> > +{
> > +    RiscvCbqriCapacityState *cc = opaque;
> > +
> > +    assert((addr % 8) == 0);
> > +    assert(size == 8);
> 
> So here and in the read callback (riscv_cbqri_cc_read) you're doing asserts for
> size == 8, while your memoryops has:
> 
> static const MemoryRegionOps riscv_cbqri_cc_ops = {
>     .read = riscv_cbqri_cc_read,
>     .write = riscv_cbqri_cc_write,
>     .endianness = DEVICE_LITTLE_ENDIAN,
>     .valid.min_access_size = 4,  <==========
>     .valid.max_access_size = 8,
>     .impl.min_access_size = 8,
>     .impl.max_access_size = 8,
> };
> 
> 
> You can get rid of assert(size == 8) in both callbacks by setting
> min_access_size = 8.

Thanks for the review. 

I think that the assert in riscv_cbqri_cc_write maybe incorrect.

The CBQRI spec states that the registers:
 - start at an 8-byte aligned physical address. 
 - can accessed by using naturally aligned 4-byte or 8-byte accesses
 - 4-byte access to a register must be single-copy atomic
 - It is UNSPECIFIED whether 8-byte access must be single-copy atomic
 - 8-byte access can appear internally to the CBQRI implementation as
   if two separate 4-byte accesses are performed.

The spec further notes that:

"The CBQRI registers are defined so that software can perform two
individual 4 byte accesses, or hardware can perform two independent 4
byte transactions resulting from an 8 byte access, to the high and low
halves of the register as long as the register semantics, with regards
to side-effects, are respected between the two software accesses, or two
hardware transactions, respectively."

Based on the above, I believe .valid.min_access_size does need to stay
at 4 bytes. The Qemu documentation states that otherwise "accesses
outside this range will have device and bus specific behaviour (ignored,
or machine check)".

I am confused whether ".impl.min_access_size = 8" is correct. The Qemu
documentation states that "other access sizes will be emulated using the
ones available. For example a 4-byte write will be emulated using four
1-byte writes, if .impl.max_access_size = 1."

Radim asked if 32-bit (4 byte) access would be supported, but I am
confused how other access sizes are emulated.

Do I need to add code to the read and write hooks for riscv_cbqri_cc_ops
and riscv_cbqri_bc_ops?

Or is there some aspect of MemoryRegionOps that can handle the emulation
of other sizes automatically?

Thanks,
Drew

