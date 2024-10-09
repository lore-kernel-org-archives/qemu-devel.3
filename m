Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 034E1CEDD97
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 14:00:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syXDq-0005TL-RN; Wed, 09 Oct 2024 09:59:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1syXDp-0005TC-Hf
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 09:59:25 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1syXDn-0006Du-Mz
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 09:59:25 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5c721803a89so9089390a12.1
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2024 06:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728482362; x=1729087162; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=l0I3hgXYskFaM1WPaQBMv7Pv3MdsYJHuri7ua6DX/GE=;
 b=v/V1Ska6G6bg5TNRf90QQ4GFAmqfWDPchWhI0UsOBIglrouheboHIoyt6X8nOZRzA3
 z3I12c8uqMjrcCMfwb1GDGZMtvICOe+tBo077QvPWOamUezttbsaohZZkcRM0/5P/2sH
 137RyhmByxLl7fDXVdDZUIxqbeY/YxPH3FijBvPMCebSXWjVskoCCE/+TsYFVp2xo3V2
 PHoryxs7oAZnkYQ9lL7VwLLpn1hO78ZvKn8vkv8+Xo18nj+WQ/cBKsJycPQqARKNZN5k
 Gfbk24ru9eQdD30ZOwnUhjkgZtB6/aGjnsDGUI/pu6RYW5EuKxiJpMgPmYg7r0ihM95Q
 tKzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728482362; x=1729087162;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=l0I3hgXYskFaM1WPaQBMv7Pv3MdsYJHuri7ua6DX/GE=;
 b=e2XxhHNGVsllBJT1WZ/1YwS87rxFFBQ2lR51OZs9ijAk1mA2LbmYr/QnzQuHyKgvEB
 TEtTgsN7EC8c+7VsiibcEM8EVe4STVE+sHtdn4Oi++Ksb6mIkoxhW5cwckCHQZfJDFEs
 q34RjWn7mSStmmOL6euROE3sWJZmO9oX4/FGi963/HjxyBT53q4etvnRS2wuMQ9YFeyX
 w4PS3sQF6zJIsOitv5ehPuKB15jUWce4A+1+2TT564CRBXHKBmXf5MIrNANjlSRZ8P2y
 XnFNzqOLK3ou5mLFfeNpgMR7JaYc9mx+ZTrCFSMRli5HBUqltXMmM5QnfxpXGjTbBwg2
 v/Zw==
X-Gm-Message-State: AOJu0YzUHO000C9+tf1NCx6C5pNzVYa63YSlQdfJDuVt9PAFZpNdWXQh
 ntoUercPevdtj1zx0FjvHJE0/T3X0daeecIdcN+4mpz1uRjsxnD9ck133OyEQKao/0WRnurw7WG
 DuIOjvLT0M4Z37WgeElfwWvfkqfoHKgQWroi3Iw==
X-Google-Smtp-Source: AGHT+IFcaDAmv5R+/Xh7CHX50o4jgaS6RwlGJuW4592TQfJL+6zctEsY3T1VEpWaMxyXf+D46/DImjU/Acw+HiHxBUI=
X-Received: by 2002:a05:6402:2813:b0:5c2:6d16:ad5e with SMTP id
 4fb4d7f45d1cf-5c91d63e0e4mr2429095a12.19.1728482361560; Wed, 09 Oct 2024
 06:59:21 -0700 (PDT)
MIME-Version: 1.0
References: <20241005200600.493604-1-richard.henderson@linaro.org>
 <20241005200600.493604-14-richard.henderson@linaro.org>
 <CAFEAcA_jXTuB6c8oVcXmi66zcXn5-PYM7W9z1wf7-fzXg7_Oiw@mail.gmail.com>
 <5c33b223-10cc-4ad6-a3e8-15082266b31d@linaro.org>
In-Reply-To: <5c33b223-10cc-4ad6-a3e8-15082266b31d@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 9 Oct 2024 14:59:10 +0100
Message-ID: <CAFEAcA9jwsD3p3Voj=q1Tcv0CZ7u2mADdfo6oQrGXr5FfFQQBg@mail.gmail.com>
Subject: Re: [PATCH v2 13/21] target/arm: Pass MemOp to get_phys_addr
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, deller@kernel.org, alex.bennee@linaro.org, 
 linux-parisc@vger.kernel.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52b.google.com
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

On Tue, 8 Oct 2024 at 18:32, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 10/8/24 07:45, Peter Maydell wrote:
> > On Sat, 5 Oct 2024 at 21:06, Richard Henderson
> > <richard.henderson@linaro.org> wrote:
> >>
> >> Zero is the safe do-nothing value for callers to use.
> >>
> >> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> >> ---
> >>   target/arm/internals.h      | 3 ++-
> >>   target/arm/ptw.c            | 2 +-
> >>   target/arm/tcg/m_helper.c   | 8 ++++----
> >>   target/arm/tcg/tlb_helper.c | 2 +-
> >>   4 files changed, 8 insertions(+), 7 deletions(-)
> >
> >> diff --git a/target/arm/tcg/m_helper.c b/target/arm/tcg/m_helper.c
> >> index 23d7f73035..f7354f3c6e 100644
> >> --- a/target/arm/tcg/m_helper.c
> >> +++ b/target/arm/tcg/m_helper.c
> >> @@ -222,7 +222,7 @@ static bool v7m_stack_write(ARMCPU *cpu, uint32_t addr, uint32_t value,
> >>       int exc;
> >>       bool exc_secure;
> >>
> >> -    if (get_phys_addr(env, addr, MMU_DATA_STORE, mmu_idx, &res, &fi)) {
> >> +    if (get_phys_addr(env, addr, MMU_DATA_STORE, 0, mmu_idx, &res, &fi)) {
> >>           /* MPU/SAU lookup failed */
> >>           if (fi.type == ARMFault_QEMU_SFault) {
> >>               if (mode == STACK_LAZYFP) {
> >> @@ -311,7 +311,7 @@ static bool v7m_stack_read(ARMCPU *cpu, uint32_t *dest, uint32_t addr,
> >>       bool exc_secure;
> >>       uint32_t value;
> >>
> >> -    if (get_phys_addr(env, addr, MMU_DATA_LOAD, mmu_idx, &res, &fi)) {
> >> +    if (get_phys_addr(env, addr, MMU_DATA_LOAD, 0, mmu_idx, &res, &fi)) {
> >>           /* MPU/SAU lookup failed */
> >>           if (fi.type == ARMFault_QEMU_SFault) {
> >>               qemu_log_mask(CPU_LOG_INT,
> >
> > We do actually know what kind of memory operation we're doing here:
> > it's a 4-byte access. (It should never be unaligned because an M-profile
> > SP can't ever be un-4-aligned, though I forget whether our implementation
> > really enforces that.)
> >
> >> @@ -2009,7 +2009,7 @@ static bool v7m_read_half_insn(ARMCPU *cpu, ARMMMUIdx mmu_idx, bool secure,
> >>                         "...really SecureFault with SFSR.INVEP\n");
> >>           return false;
> >>       }
> >> -    if (get_phys_addr(env, addr, MMU_INST_FETCH, mmu_idx, &res, &fi)) {
> >> +    if (get_phys_addr(env, addr, MMU_INST_FETCH, 0, mmu_idx, &res, &fi)) {
> >>           /* the MPU lookup failed */
> >>           env->v7m.cfsr[env->v7m.secure] |= R_V7M_CFSR_IACCVIOL_MASK;
> >>           armv7m_nvic_set_pending(env->nvic, ARMV7M_EXCP_MEM, env->v7m.secure);
> >
> > Similarly this is a 16-bit load that in theory should never
> > be possible to be unaligned.
> >
> >> @@ -2045,7 +2045,7 @@ static bool v7m_read_sg_stack_word(ARMCPU *cpu, ARMMMUIdx mmu_idx,
> >>       ARMMMUFaultInfo fi = {};
> >>       uint32_t value;
> >>
> >> -    if (get_phys_addr(env, addr, MMU_DATA_LOAD, mmu_idx, &res, &fi)) {
> >> +    if (get_phys_addr(env, addr, MMU_DATA_LOAD, 0, mmu_idx, &res, &fi)) {
> >>           /* MPU/SAU lookup failed */
> >>           if (fi.type == ARMFault_QEMU_SFault) {
> >>               qemu_log_mask(CPU_LOG_INT,
> >
> > and this is another 4-byte load via sp.
> >
> >> diff --git a/target/arm/tcg/tlb_helper.c b/target/arm/tcg/tlb_helper.c
> >> index 885bf4ec14..1d8b7bcaa2 100644
> >> --- a/target/arm/tcg/tlb_helper.c
> >> +++ b/target/arm/tcg/tlb_helper.c
> >> @@ -344,7 +344,7 @@ bool arm_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
> >>        * return false.  Otherwise populate fsr with ARM DFSR/IFSR fault
> >>        * register format, and signal the fault.
> >>        */
> >> -    ret = get_phys_addr(&cpu->env, address, access_type,
> >> +    ret = get_phys_addr(&cpu->env, address, access_type, 0,
> >>                           core_to_arm_mmu_idx(&cpu->env, mmu_idx),
> >>                           &res, fi);
> >>       if (likely(!ret)) {
>
> The question is: if it should be impossible for them to be misaligned, should we pass an
> argument that checks alignment and then (!) potentially raise a guest exception.
>
> I suspect the answer is no.
>
> If it should be impossible, no alignment fault is ever visible to the guest in this
> context, then we should at most assert(), otherwise do nothing.
>
> We *can* pass, e.g. MO_32 or MO_16 for documentation purposes, if you like.  Without
> additional adornment, this does not imply alignment enforcement (i.e. MO_ALIGN).  But this
> would be functionally indistinguishable from 0 (which I imperfectly documented with "or 0"
> in the function block comments).

Mmm. I think I thought when I started reviewing this series that we might
have a bigger set of "we put in 0 here but is that the right thing?"
callsites. But I think in working through it it turns out there aren't
very many and for all of those "don't check alignment" is the right thing.

thanks
-- PMM

