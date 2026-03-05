Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 818DDF30946
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 13:01:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vy8KV-0001rF-Fz; Thu, 05 Mar 2026 08:01:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1vy8KG-0001l8-5t
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 08:01:12 -0500
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1vy8KC-0005sU-Mx
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 08:01:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=oQe6q6JWI+91z38P/r7QWUTavm03XGroy2Z+9oYLf6A=; b=AzrBzSdb1U1yJeB
 NOcbX8ZQBe8Wc+x1YfeZi8UBinaPkSWUHNPe091b39zjpmQ28EcveLn2uZmt+zY2JAY+bF+gp2u3P
 hbkJ4Mx/8o6kSUEjPCGCZmcJ8VyGpWLgOkLmW1EZ074k0M31j0cpzfWg7mwCn5LHlWDQghcYhewJd
 TM=;
Date: Thu, 5 Mar 2026 14:04:47 +0100
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, 
 Richard Henderson <richard.henderson@linaro.org>, Helge Deller <deller@gmx.de>
Subject: Re: [PATCH v5 3/4] hppa: Get physical address space bits from
 HPPACPUDef
Message-ID: <aal89loH-NrAw_Yj@hive.localdomain>
References: <20260303-hppa-c3600-v5-0-277bfe6b40b8@rev.ng>
 <20260303-hppa-c3600-v5-3-277bfe6b40b8@rev.ng>
 <9a30c7c5-17d2-4767-b874-c1bb698e905a@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9a30c7c5-17d2-4767-b874-c1bb698e905a@linaro.org>
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.892, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.622,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 04/03/26, Philippe Mathieu-Daudé wrote:
> On 3/3/26 17:11, Anton Johansson via qemu development wrote:
> > Reviewed-by: Helge Deller <deller@gmx.de>
> > Signed-off-by: Anton Johansson <anjo@rev.ng>
> > ---
> >   target/hppa/cpu.h        | 11 ++++++++---
> >   hw/hppa/machine.c        |  4 ++--
> >   hw/pci-host/astro.c      |  2 +-
> >   target/hppa/cpu.c        |  9 ++++++++-
> >   target/hppa/mem_helper.c | 39 +++++++++++----------------------------
> >   5 files changed, 30 insertions(+), 35 deletions(-)
> 
> 
> > diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
> > index 5d0d4de09e..bb6b7dc76c 100644
> > --- a/hw/hppa/machine.c
> > +++ b/hw/hppa/machine.c
> > @@ -181,12 +181,12 @@ static uint64_t linux_kernel_virt_to_phys(void *opaque, uint64_t addr)
> >   static uint64_t translate_pa10(void *dummy, uint64_t addr)
> >   {
> > -    return hppa_abs_to_phys_pa1x(addr);
> > +    return hppa_abs_to_phys_pa1x(cpu_env(first_cpu), addr);
> 
> I'm not keen of these @first_cpu uses (for heterogeneous emulation
> we want to restrict this variable to accel/, and poison it elsewhere
> like in hw/). Can we resolve earlier or pass CPUState* around?

Right, I had this in the back of my mind somewhere.  Both uses in
machine.c can be changed to instead use the first created HPPA cpu
through `&cpu[0]->env`, which is commonly used in machine.c.

As for the use in astro.c, I think the best option is to add a property
for `phys_addr_bits`.  However, this requires changing
hppa_abs_to_phys*() to take `uint8_t phys_addr_bits` instead of
`CPUHPPAState *env`, which IMO is preferable as
`hppa_get_physical_address()` becomes a bit simpler

  int hppa_get_physical_address(CPUHPPAState *env, vaddr addr, int mmu_idx,
                                int type, MemOp mop, hwaddr *pphys, int *pprot)
  {
      hwaddr phys;
      int prot, r_prot, w_prot, x_prot, priv;
      HPPATLBEntry *ent;
      int ret = -1;
  
      /* Virtual translation disabled.  Map absolute to physical.  */
      if (MMU_IDX_MMU_DISABLED(mmu_idx)) {
 +        const uint8_t pa_bits = hppa_phys_addr_bits(env);
          switch (mmu_idx) {
          case MMU_ABS_W_IDX:
 -            phys = hppa_abs_to_phys_pa2_w1(env, addr);
 +            phys = hppa_abs_to_phys_pa2_w1(pa_bits, addr);
              break;
          case MMU_ABS_IDX:
              if (hppa_is_pa20(env)) {
 -                phys = hppa_abs_to_phys_pa2_w0(env, addr);
 +                phys = hppa_abs_to_phys_pa2_w0(pa_bits, addr);
              } else {
 -                phys = hppa_abs_to_phys_pa1x(env, addr);
 +                phys = hppa_abs_to_phys_pa1x(pa_bits, addr);
              }
              break;
          default:
              g_assert_not_reached();
          }
          prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
          goto egress_align;
      }

      ...
  }

-- 
Anton Johansson
rev.ng Labs Srl.

