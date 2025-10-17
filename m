Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09E0FCCD199
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 16:09:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9n0R-00018B-KV; Fri, 17 Oct 2025 12:08:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1v9n0P-00017s-Ao
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 12:08:37 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1v9n0M-0006YJ-O1
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 12:08:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=173uQA5NH6LcksUCXyl99aCzRxLtCiNmt6tc8mGCPGg=; b=J/z3zu23cub2YaC
 HmS0mKf/bnG4FI7u8xXCY5AvzKssr8/pfmyA0IV8/0XTzKpXtD6yfED8SMoqKSbDjNhSv5S0r3NnF
 avvBjypKApzxJRV8ItKQ9N4GhdFVTbyLpWvtohHycDrmjnSJRocjNS35P7dcsrJaX5uu7513LpxWR
 uA=;
Date: Fri, 17 Oct 2025 18:11:00 +0200
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: richard.henderson@linaro.org, Paolo Bonzini <pbonzini@redhat.com>, 
 pierrick.bouvier@linaro.org, qemu-devel@nongnu.org, alistair.francis@wdc.com, 
 palmer@dabbelt.com
Subject: Re: [PATCH 4/5] target-info: Introduce runtime
 TARGET_PHYS_ADDR_SPACE_BITS
Message-ID: <7jzcbl2yqkssu5lshz4umayaesoxwg3gcskrrkobc37df2p4z2@s26yst4mfxoe>
References: <20251015-feature-single-binary-hw-v1-v1-0-8b416eda42cf@rev.ng>
 <20251015-feature-single-binary-hw-v1-v1-4-8b416eda42cf@rev.ng>
 <673e3c7b-b8ef-4908-b74d-62203b131229@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <673e3c7b-b8ef-4908-b74d-62203b131229@linaro.org>
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 15/10/25, Philippe Mathieu-Daudé wrote:
> On 15/10/25 15:27, Anton Johansson wrote:
> > Signed-off-by: Anton Johansson <anjo@rev.ng>
> > ---
> >   include/qemu/target-info-impl.h | 2 ++
> >   include/qemu/target-info.h      | 8 ++++++++
> >   target-info.c                   | 5 +++++
> >   3 files changed, 15 insertions(+)
> > 
> > diff --git a/include/qemu/target-info-impl.h b/include/qemu/target-info-impl.h
> > index 17887f64e2..80d1613128 100644
> > --- a/include/qemu/target-info-impl.h
> > +++ b/include/qemu/target-info-impl.h
> > @@ -18,6 +18,8 @@ typedef struct TargetInfo {
> >       SysEmuTarget target_arch;
> >       /* runtime equivalent of TARGET_LONG_BITS definition */
> >       unsigned long_bits;
> > +    /* runtime equivalent of TARGET_PHYS_ADDR_SPACE_BITS definition */
> > +    unsigned phys_addr_space_bits;
> >       /* runtime equivalent of CPU_RESOLVING_TYPE definition */
> >       const char *cpu_type;
> >       /* QOM typename machines for this binary must implement */
> 
> 
> > diff --git a/target-info.c b/target-info.c
> > index 3110ab32f7..3d696ae0b3 100644
> > --- a/target-info.c
> > +++ b/target-info.c
> > @@ -22,6 +22,11 @@ unsigned target_long_bits(void)
> >       return target_info()->long_bits;
> >   }
> > +unsigned target_phys_addr_space_bits(void)
> > +{
> > +    return target_info()->phys_addr_space_bits;
> > +}
> 
> Missing field initialization in target_info_stub[].

Ugh right, thanks!

> 
> BTW this definition seems unused by common code since commit
> 2e8fe327eb6 ("accel/tcg: Simplify L1_MAP_ADDR_SPACE_BITS").
> 
> Do we still need to expose it to common components?
> 

Hmm you're right looking at git grep -C1 TARGET_PHYS_ADDR_SPACE_BITS
(output below excluding the hw/riscv change in the following patch),
there are really aren't that many uses left and none in common code.

We still got to move it to a runtime value somewhere though, what
would be a more suitable location?  Maybe as a field in CPUArchState or
some parent QOM machine as only i386, hppa, loongarch, riscv, alpha
actually use the definition.

  hw/loongarch/boot.c:    return addr & MAKE_64BIT_MASK(0, TARGET_PHYS_ADDR_SPACE_BITS);
  --
  hw/loongarch/boot.c-    *kernel_entry = extract64(le64_to_cpu(hdr->kernel_entry),
  hw/loongarch/boot.c:                              0, TARGET_PHYS_ADDR_SPACE_BITS);
  hw/loongarch/boot.c-    *kernel_low = extract64(le64_to_cpu(hdr->load_offset),
  hw/loongarch/boot.c:                            0, TARGET_PHYS_ADDR_SPACE_BITS);
  --
  linux-user/alpha/target_proc.h-            "L3 cache\t\t: n/a\n",
  linux-user/alpha/target_proc.h:            model, TARGET_PAGE_SIZE, TARGET_PHYS_ADDR_SPACE_BITS,
  linux-user/alpha/target_proc.h-            max_cpus, num_cpus, cpu_mask);
  --
  target/hppa/mem_helper.c:    QEMU_BUILD_BUG_ON(TARGET_PHYS_ADDR_SPACE_BITS > 54);
  target/hppa/mem_helper.c:    return sextract64(addr, 0, TARGET_PHYS_ADDR_SPACE_BITS);
  --
  target/hppa/mem_helper.c:        addr |= -1ull << (TARGET_PHYS_ADDR_SPACE_BITS - 4);
  --
  target/hppa/mem_helper.c-    /* Ignore the bits beyond physical address space. */
  target/hppa/mem_helper.c:    ent->pa = sextract64(ent->pa, 0, TARGET_PHYS_ADDR_SPACE_BITS);
  --
  target/i386/cpu.c-        if (cpu->phys_bits &&
  target/i386/cpu.c:            (cpu->phys_bits > TARGET_PHYS_ADDR_SPACE_BITS ||
  target/i386/cpu.c-            cpu->phys_bits < 32)) {
  --
  target/i386/cpu.c-                             " (but is %u)",
  target/i386/cpu.c:                             TARGET_PHYS_ADDR_SPACE_BITS, cpu->phys_bits);
  --
  target/i386/kvm/kvm.c:        QEMU_BUILD_BUG_ON(TARGET_PHYS_ADDR_SPACE_BITS > 52);
  target/i386/kvm/kvm.c:        assert(cpu->phys_bits <= TARGET_PHYS_ADDR_SPACE_BITS);
  --
  target/i386/tcg/helper-tcg.h:QEMU_BUILD_BUG_ON(TCG_PHYS_ADDR_BITS > TARGET_PHYS_ADDR_SPACE_BITS);
  --
  target/loongarch/internals.h:#define TARGET_PHYS_MASK MAKE_64BIT_MASK(0, TARGET_PHYS_ADDR_SPACE_BITS)
  target/loongarch/internals.h-#define TARGET_VIRT_MASK MAKE_64BIT_MASK(0, TARGET_VIRT_ADDR_SPACE_BITS)


