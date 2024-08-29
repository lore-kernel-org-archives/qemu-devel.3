Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B34AC71150
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2024 00:03:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjSdW-0005eB-Gh; Wed, 28 Aug 2024 20:03:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sjSdS-0005NX-EG; Wed, 28 Aug 2024 20:03:34 -0400
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sjSdQ-00043U-JW; Wed, 28 Aug 2024 20:03:34 -0400
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-709339c91f9so81502a34.0; 
 Wed, 28 Aug 2024 17:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724889811; x=1725494611; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HF0D/INjLnEzeQQxXzZpuB5pJ7mH4alvhthEBT/aFGQ=;
 b=nEnZUG9wjVbHs2p+s+sDYCilT55esMxtWy11rn1sedw10JdrvBxrLsYDrS7IiDwGFF
 xAwQL6p4P+/nCGs7FhauwdnnLYeijW77adt30Z9CJNm+HxCI+JqPSnLnfLc8Az8mitxx
 +9JX57LJ2Lc7px8mSpkO43oWMufaT4ykSKwka3mpoBLJrm7SeUWhwDeZqmORU5vZ6p7K
 QC+wWCv2wxf5y8i3z1/vdmiYQlbmZqrUfD66A86Vjxq9bywOkWLUN/XpIRSxQlzyRrVJ
 /QbsmVH52r4k7sfyCOToJM6i2o4wB2TZGguqJmNvEiHImX3Dr2jnBPFF4ot82Ly99n3K
 onSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724889811; x=1725494611;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HF0D/INjLnEzeQQxXzZpuB5pJ7mH4alvhthEBT/aFGQ=;
 b=L8uAjQAxcjf7Qhy+fipk3t1LPKp57YjCsZsi2KzhpMiD1FgbVgDyNyRCCcPrM3IYpi
 DJ/WtIzaGXwZK70q7EEad0/bSFX1Fd07rjZ31eFhAACSrp1Avim1gvErSOkatAHTmLAZ
 4BDoWOwXq52Eli6+m0NFbDCmhTOSk+iLLhYNMH+wa0wvVFWSwhHFgCGlPWYyL0INLiET
 rOkQqFiTvyDR9Pv0tTQKNDgRTy9LaEaDeXTJe339lFE47TtwzaqV3mSC8CIPvVnNxXoH
 CgNE2OuxL6eVnIEc6tisAldJ+vvMb9vds53CwMya/On7X74e+sLy11H32uwVg0aODcou
 sktg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWLxmqtF8MdOJP9BqHx9cjlP6i2K6az9ndAOrTdfZ3ffdLtxKfb7OeQVVOi6CXj1G4/vtZE1io202t8@nongnu.org
X-Gm-Message-State: AOJu0YxiWHaaGn23qNfiRpuDJBRDoslgw3XhByehsuFW7PozFcbNlC6P
 uaZRmKHKY87W9xNxWqm9PT02CX1IEnV3k6WL6HvtN4A9manP9xvYSbLNgqU2llm7pzOZzvEED+e
 hkBjSNSAhxrfdL9vni+P8IORWd7k=
X-Google-Smtp-Source: AGHT+IE0ag0RB6NORn11bVsHZBtVSe4Yjyic0maT8jZrRBlDoWjNpE9Ppc21+i4mx7DpOBV0GFnea1L7p0unL6FoLco=
X-Received: by 2002:a05:6808:1587:b0:3dc:299d:c4fb with SMTP id
 5614622812f47-3df05ec4050mr982290b6e.40.1724889810850; Wed, 28 Aug 2024
 17:03:30 -0700 (PDT)
MIME-Version: 1.0
References: <20240828174739.714313-1-debug@rivosinc.com>
 <20240828174739.714313-14-debug@rivosinc.com>
 <CAKmqyKPyyupykqc-0yrGm+msZPuf+=jVWvD86yz7mfqjn5MT9A@mail.gmail.com>
 <Zs+2mIsAw2BKODtk@debug.ba.rivosinc.com>
In-Reply-To: <Zs+2mIsAw2BKODtk@debug.ba.rivosinc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 29 Aug 2024 10:03:04 +1000
Message-ID: <CAKmqyKNVA3Y06824XbbsZ+7n2Ach==ah5m-28zxzCn-48En=9g@mail.gmail.com>
Subject: Re: [PATCH v11 13/20] target/riscv: mmu changes for zicfiss shadow
 stack protection
To: Deepak Gupta <debug@rivosinc.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, palmer@dabbelt.com, 
 Alistair.Francis@wdc.com, laurent@vivier.eu, bmeng.cn@gmail.com, 
 liwei1518@gmail.com, dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, 
 jim.shu@sifive.com, andy.chiu@sifive.com, kito.cheng@sifive.com, 
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::334;
 envelope-from=alistair23@gmail.com; helo=mail-ot1-x334.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, Aug 29, 2024 at 9:45=E2=80=AFAM Deepak Gupta <debug@rivosinc.com> w=
rote:
>
> On Thu, Aug 29, 2024 at 09:29:49AM +1000, Alistair Francis wrote:
> >On Thu, Aug 29, 2024 at 3:49=E2=80=AFAM Deepak Gupta <debug@rivosinc.com=
> wrote:
> >>
> >> zicfiss protects shadow stack using new page table encodings PTE.W=3D1=
,
> >> PTE.R=3D0 and PTE.X=3D0. This encoding is reserved if zicfiss is not
> >> implemented or if shadow stack are not enabled.
> >> Loads on shadow stack memory are allowed while stores to shadow stack
> >> memory leads to access faults. Shadow stack accesses to RO memory
> >> leads to store page fault.
> >>
> >> To implement special nature of shadow stack memory where only selected
> >> stores (shadow stack stores from sspush) have to be allowed while rest
> >> of regular stores disallowed, new MMU TLB index is created for shadow
> >> stack.
> >>
> >> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
> >> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> >> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> >> ---
> >>  target/riscv/cpu_helper.c | 37 +++++++++++++++++++++++++++++++------
> >>  target/riscv/internals.h  |  3 +++
> >>  2 files changed, 34 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> >> index be4ac3d54e..39544cade6 100644
> >> --- a/target/riscv/cpu_helper.c
> >> +++ b/target/riscv/cpu_helper.c
> >> @@ -893,6 +893,8 @@ static int get_physical_address(CPURISCVState *env=
, hwaddr *physical,
> >>      hwaddr ppn;
> >>      int napot_bits =3D 0;
> >>      target_ulong napot_mask;
> >> +    bool is_sstack_idx =3D ((mmu_idx & MMU_IDX_SS_WRITE) =3D=3D MMU_I=
DX_SS_WRITE);
> >> +    bool sstack_page =3D false;
> >>
> >>      /*
> >>       * Check if we should use the background registers for the two
> >> @@ -1101,21 +1103,36 @@ restart:
> >>          return TRANSLATE_FAIL;
> >>      }
> >>
> >> +    target_ulong rwx =3D pte & (PTE_R | PTE_W | PTE_X);
> >>      /* Check for reserved combinations of RWX flags. */
> >> -    switch (pte & (PTE_R | PTE_W | PTE_X)) {
> >> -    case PTE_W:
> >> +    switch (rwx) {
> >>      case PTE_W | PTE_X:
> >>          return TRANSLATE_FAIL;
> >> +    case PTE_W:
> >> +        /* if bcfi enabled, PTE_W is not reserved and shadow stack pa=
ge */
> >> +        if (cpu_get_bcfien(env) && first_stage) {
> >> +            sstack_page =3D true;
> >> +            /* if ss index, read and write allowed. else only read al=
lowed */
> >> +            rwx =3D is_sstack_idx ? PTE_R | PTE_W : PTE_R;
> >> +            break;
> >> +        }
> >> +        return TRANSLATE_FAIL;
> >> +    case PTE_R:
> >> +        /* shadow stack writes to readonly memory are page faults */
> >> +        if (is_sstack_idx && access_type =3D=3D MMU_DATA_STORE) {
>
> While responding to your question, I noticed there is a bug here. Its a l=
eftover from
> previous patches where I was promoting shadow stack loads to stores. No n=
eed to check
> `access_type =3D=3D MMU_DATA_STORE` because we store unwind information a=
s part of tcg
> compile.
>
> Will fix it.
>
> >> +            return TRANSLATE_FAIL;
> >> +        }
> >> +        break;
> >>      }
> >>
> >>      int prot =3D 0;
> >> -    if (pte & PTE_R) {
> >> +    if (rwx & PTE_R) {
> >>          prot |=3D PAGE_READ;
> >>      }
> >> -    if (pte & PTE_W) {
> >> +    if (rwx & PTE_W) {
> >>          prot |=3D PAGE_WRITE;
> >>      }
> >> -    if (pte & PTE_X) {
> >> +    if (rwx & PTE_X) {
> >>          bool mxr =3D false;
> >>
> >>          /*
> >> @@ -1160,7 +1177,7 @@ restart:
> >>
> >>      if (!((prot >> access_type) & 1)) {
> >>          /* Access check failed */
> >> -        return TRANSLATE_FAIL;
> >> +        return sstack_page ? TRANSLATE_PMP_FAIL : TRANSLATE_FAIL;
> >
> >Why is it a PMP error if it's a shadow stack page?
>
> A shadow stack page is readable by regular loads.
> We are making sure of that in `case PTE_W` in above switch case.
> But shadow stack page is not writeable via regular stores. And must raise
> access fault. return code `TRANSLATE_PMP_FAIL` is translated to access fa=
ult
> while raising fault.

Ah, ok. It's worth commenting that we are returning TRANSLATE_PMP_FAIL
as that will be translated to an access fault

Alistair

>
> >
> >Alistair

