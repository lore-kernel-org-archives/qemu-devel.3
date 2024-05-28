Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1B7EC25B74
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 03:31:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBnXz-0001W2-Bm; Mon, 27 May 2024 23:30:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sBnXw-0001VB-GU; Mon, 27 May 2024 23:30:45 -0400
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sBnXs-0003Ev-P1; Mon, 27 May 2024 23:30:43 -0400
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-6f8e9522bfaso249192a34.0; 
 Mon, 27 May 2024 20:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716867037; x=1717471837; darn=nongnu.org;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vo7o/UOKNrEq5PeEM4j7jMh3fFUMFEa/MBgK46/t8YU=;
 b=d/AD/hurlhpzSf3x4ZBvQY0AzeV9oA0+KLgHQSZHYDnx7JsHvJiTOpKuEYfUtQBm53
 IjnrIFL5WfrOHcnS+T066xSL7/rMqd3/3A++6Lfn6FwOoqX92ZWQyzW+gFRWEv/wlbAa
 w5RLPReSt2erbmBtb3N5qlxreWaJHn0pxcHgwLTOiqQHPxo4vLGil09PAvd3j8qgeMc8
 evgUUrI2fL3vf0a5F/0iwyTabYuNDrrHi73HEYjpVM3O6GHD6NhuvGLvGf/6du7nz/Ir
 YovoddwMyMdhXpW1MluERAUxiS92e3vGFl+cIf0CTnKTRP4xlWy2VQ1YipYHuUVXD3hw
 nOAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716867037; x=1717471837;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=vo7o/UOKNrEq5PeEM4j7jMh3fFUMFEa/MBgK46/t8YU=;
 b=Q1tcEnKshYwYLWzMFm4kSTpWjwtvXvw0nSWqeGkd45FjpA74zKFmBH7rJQdDr5EIEU
 qeBzSDglH0nJZwkaSsWSGKERr4S+CVHI7UAqyVQSJT3vLpmGuMA7jpSEgWMvp395B9Na
 fg3iCfR8goxDIwhGrCnYI+VBKuMmeuge1G4KQ3WFQTb9jdIeBQwmSccAtsNCsH08ipxE
 dCHzLDzhOII65bE6mMYuH5Of2W1Y3Iv7sgnZGYeISthpmC/4NUNqg69SiEaNREK8WFDK
 PRY+yzbls1K9l6p/JSnrbBEFp8DnWImq9FGpFu+3PWcebuAcD3HqIPbqe31Iyf98Pcq6
 P8hw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUykchvPc/251BgFqpMTaXR92rKa9bOwHauEzoBr0L0d2usxOk8fJtq9q1ttZsWQDd+TURWDYgYE4iZM5e7Ocge8iW/
X-Gm-Message-State: AOJu0YwVU8j1lXq0yMG1WoAWzHoce3q5JJDnuUYm+CUYaC9PYTKMNm/0
 Egm7lI16PBSuVbW5f9odLWbpmrmBH9F/9bvK872+rdqIqVlX8XUv+T3oaA==
X-Google-Smtp-Source: AGHT+IHR5TKFWCN4ZRcc+XKTX2CaQoWLlRTDmsaDPM0V0SqtDD90vAsIX5F/bDhOjUbu2DJLFLnTSg==
X-Received: by 2002:a05:6871:7824:b0:241:98e4:5590 with SMTP id
 586e51a60fabf-24ca105dc6cmr14273015fac.5.1716867036944; 
 Mon, 27 May 2024 20:30:36 -0700 (PDT)
Received: from localhost (110-175-65-7.tpgi.com.au. [110.175.65.7])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-68218501df4sm5674972a12.0.2024.05.27.20.30.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 May 2024 20:30:36 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 28 May 2024 13:30:32 +1000
Message-Id: <D1KYKI566RW8.4Z4BEJR53QYB@gmail.com>
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "BALATON Zoltan" <balaton@eik.bme.hu>
Cc: <qemu-devel@nongnu.org>, <qemu-ppc@nongnu.org>, "Richard Henderson"
 <richard.henderson@linaro.org>
Subject: Re: TCG change broke MorphOS boot on sam460ex
X-Mailer: aerc 0.17.0
References: <fe59ceb1-e8cd-f488-d6f0-6372923a8a33@eik.bme.hu>
 <48e5e0b8-9b0a-4c9f-9f3e-c30e2fddc502@linaro.org>
 <2a286d38-1fd7-d53a-d7db-e953e6aefbf2@eik.bme.hu>
 <3386e6ec-9b87-fa01-9bf0-967a362bf90a@eik.bme.hu>
 <D0A8CN9E4ZZG.3RV43XZWO6S5H@gmail.com>
 <01b67a5a-111c-ba3a-f51d-9c8a5b228500@eik.bme.hu>
In-Reply-To: <01b67a5a-111c-ba3a-f51d-9c8a5b228500@eik.bme.hu>
Received-SPF: pass client-ip=2607:f8b0:4864:20::32d;
 envelope-from=npiggin@gmail.com; helo=mail-ot1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Tue May 28, 2024 at 8:23 AM AEST, BALATON Zoltan wrote:
> On Wed, 3 Apr 2024, Nicholas Piggin wrote:
> > On Tue Apr 2, 2024 at 9:32 PM AEST, BALATON Zoltan wrote:
> >> On Thu, 21 Mar 2024, BALATON Zoltan wrote:
> >>> On 27/2/24 17:47, BALATON Zoltan wrote:
> >>>> Hello,
> >>>>
> >>>> Commit 18a536f1f8 (accel/tcg: Always require can_do_io) broke bootin=
g
> >>>> MorphOS on sam460ex (this was before 8.2.0 and I thought I've verifi=
ed it
> >>>> before that release but apparently missed it back then). It can be
> >>>> reproduced with https://www.morphos-team.net/morphos-3.18.iso and fo=
llowing
> >>>> command:
> >>>>
> >>>> qemu-system-ppc -M sam460ex -serial stdio -d unimp,guest_errors \
> >>>>  =C2=A0 -drive if=3Dnone,id=3Dcd,format=3Draw,file=3Dmorphos-3.18.is=
o \
> >>>>  =C2=A0 -device ide-cd,drive=3Dcd,bus=3Dide.1
> >>
> >> Any idea on this one? While MorphOS boots on other machines and other =
OSes
> >> seem to boot on this machine it may still suggest there's some problem
> >> somewhere as this worked before. So it may worth investigating it to m=
ake
> >> sure there's no bug that could affect other OSes too even if they boot=
. I
> >> don't know how to debug this so some help would be needed.
> >
> > In the bad case it crashes after running this TB:
> >
> > ----------------
> > IN:
> > 0x00c01354:  38c00040  li       r6, 0x40
> > 0x00c01358:  38e10204  addi     r7, r1, 0x204
> > 0x00c0135c:  39010104  addi     r8, r1, 0x104
> > 0x00c01360:  39410004  addi     r10, r1, 4
> > 0x00c01364:  39200000  li       r9, 0
> > 0x00c01368:  7cc903a6  mtctr    r6
> > 0x00c0136c:  84c70004  lwzu     r6, 4(r7)
> > 0x00c01370:  7cc907a4  tlbwehi  r6, r9
> > 0x00c01374:  84c80004  lwzu     r6, 4(r8)
> > 0x00c01378:  7cc90fa4  tlbwelo  r6, r9
> > 0x00c0137c:  84ca0004  lwzu     r6, 4(r10)
> > 0x00c01380:  7cc917a4  tlbwehi  r6, r9
> > 0x00c01384:  39290001  addi     r9, r9, 1
> > 0x00c01388:  4200ffe4  bdnz     0xc0136c
> > ----------------
> > IN:
> > 0x00c01374: unable to read memory
> > ----------------
> >
> > "unable to read memory" is the tracer, it does actually translate
> > the address, but it points to a wayward real address which returns
> > 0 to TCG, which is an invalid instruction.
> >
> > The good case instead doesn't exit the TB after 0x00c01370 but after
> > the complete loop at the bdnz. That look like this after the same
> > first TB:
> >
> > ----------------
> > IN:
> > 0x00c0136c:  84c70004  lwzu     r6, 4(r7)
> > 0x00c01370:  7cc907a4  tlbwehi  r6, r9
> > 0x00c01374:  84c80004  lwzu     r6, 4(r8)
> > 0x00c01378:  7cc90fa4  tlbwelo  r6, r9
> > 0x00c0137c:  84ca0004  lwzu     r6, 4(r10)
> > 0x00c01380:  7cc917a4  tlbwehi  r6, r9
> > 0x00c01384:  39290001  addi     r9, r9, 1
> > 0x00c01388:  4200ffe4  bdnz     0xc0136c
> > ----------------
> > IN:
> > 0x00c0138c:  4c00012c  isync
> >
> > All the tlbwe are executed in the same TB. MMU tracing shows the
> > first tlbwehi creates a new valid(!) TLB for 0x00000000-0x100000000
> > that has a garbage RPN because the tlbwelo did not run yet.
> >
> > What's happening in the bad case is that the translator breaks
> > and "re-fetches" instructions in the middle of that sequence, and
> > that's where the bogus translation causes 0 to be returned. The
> > good case the whole block is executed in the same fetch which
> > creates correct translations.
> >
> > So it looks like a morphos bug, the can-do-io change just happens
> > to cause it to re-fetch in that place, but that could happen for
> > a number of reasons, so you can't rely on TLB *only* changing or
> > ifetch *only* re-fetching at a sync point like isync.
> >
> > I would expect code like this to write an invalid entry with tlbwehi,
> > then tlbwelo to set the correct RPN, then make the entry valid with
> > the second tlbwehi. It would probably fix the bug if you just did the
> > first tlbwehi with r6=3D0 (or at least without the 0x200 bit set).
>
> Revisiting this, I've found in the docs that PPC440 has shadow TLBs so=20
> this code can rely upon the TLB not being invalidated until isync and=20
> works on real machine but breaks on QEMU.

I never programmed for 440 but it's unclear to me from the docs how
much you can rely on this programatically (you would have to ensure
no page crossings, disable interrupts, hope for no machine check,
etc).

But it does break real software so whether or not it is following
exact letter of the law, it would be good to fix.

> We would either need to make=20
> sure the TB runs until the sync or somehow emulate the shadow TLB. I've=
=20
> experimented with the latter but I could not make it work (and=20
> unexpectedly keeping a cache of the most recently used entries is slower=
=20
> than always searching through all TLB entries as done now so I've=20
> abandoned that idea). The problem is that an entry is modified by multipl=
e=20
> tlbwe instructions but these can come in any order (and sometimes only on=
e=20
> of them is done like invalidating an entry seems to only do one write) so=
=20
> I don't know when to copy the new entry to the TLB and when to wait for=
=20
> more parts and keep the old one. Any idea how to fix this?

Depends what the important common cases are and exactly how faithfully
you want to model the hardware behaviour I guess.

How are you trying to emulate the shadow TLB? I attached a really quick
hack to see what that would look like... That is modeling the hardware
filled TLB structure ahead of the machine's software TLB. It's not a
perfect model but might be enough, one downside is that it flushes
entire QEMU TLB for any BookE TLB entry change.

The other way to go might be to keep a structure containing the list of
outstanding BookE TLB modifications, and replay that into the TLB on
sync events. That way your QEMU TLB refill path has no extra data
structure to look up or maintain, and you could do more precise
flushing of the QEMU TLB when you apply the changes.

Difficulty would be that TLB instructions would become more complicated
and expensive (reads can't just go to the TLB they would have to
find the most recent change, etc). But maybe that is the better tradeoff
if your lookups are relatively much more common than software-tlb
instructions are not.

Thanks,
Nick

---
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 2015e603d4..afbc766fd1 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -377,6 +377,12 @@ union ppc_tlb_t {
     ppc6xx_tlb_t *tlb6;
     ppcemb_tlb_t *tlbe;
     ppcmas_tlb_t *tlbm;
+
+    /* 440 shadow TLB */
+    ppcemb_tlb_t ishadow[4];
+    int ishadow_idx;
+    ppcemb_tlb_t dshadow[8];
+    int dshadow_idx;
 };
=20
 /* possible TLB variants */
diff --git a/target/ppc/helper_regs.c b/target/ppc/helper_regs.c
index 02076e96fb..3207b594e1 100644
--- a/target/ppc/helper_regs.c
+++ b/target/ppc/helper_regs.c
@@ -363,10 +363,22 @@ void store_40x_sler(CPUPPCState *env, uint32_t val)
     env->spr[SPR_405_SLER] =3D val;
 }
=20
+void ppc4xx_tlb_invalidate_shadow(CPUPPCState *env);
 void check_tlb_flush(CPUPPCState *env, bool global)
 {
     CPUState *cs =3D env_cpu(env);
=20
+    if (env->mmu_model =3D=3D POWERPC_MMU_SOFT_4xx) {
+        assert(!(env->tlb_need_flush & TLB_NEED_GLOBAL_FLUSH));
+
+        if (env->tlb_need_flush & TLB_NEED_LOCAL_FLUSH) {
+            env->tlb_need_flush &=3D ~TLB_NEED_LOCAL_FLUSH;
+            ppc4xx_tlb_invalidate_shadow(env);
+            tlb_flush(cs);
+        }
+        return;
+    }
+
     /* Handle global flushes first */
     if (global && (env->tlb_need_flush & TLB_NEED_GLOBAL_FLUSH)) {
         env->tlb_need_flush &=3D ~TLB_NEED_GLOBAL_FLUSH;
diff --git a/target/ppc/mmu-booke.c b/target/ppc/mmu-booke.c
index 55e5dd7c6b..31509be39b 100644
--- a/target/ppc/mmu-booke.c
+++ b/target/ppc/mmu-booke.c
@@ -74,55 +74,91 @@ int mmu40x_get_physical_address(CPUPPCState *env, hwadd=
r *raddr, int *prot,
 {
     ppcemb_tlb_t *tlb;
     int i, ret, zsel, zpr, pr;
+    uint32_t pid =3D env->spr[SPR_40x_PID];
=20
     ret =3D -1;
-    pr =3D FIELD_EX64(env->msr, MSR, PR);
+
+    /* Check "shadow TLBs" first */
+    if (access_type =3D=3D MMU_INST_FETCH) {
+        for (i =3D 0; i < 4; i++) {
+            tlb =3D &env->tlb.ishadow[i];
+            if (ppcemb_tlb_check(env, tlb, raddr, address, pid, -i)) {
+                goto found;
+            }
+        }
+    } else {
+        for (i =3D 0; i < 8; i++) {
+            tlb =3D &env->tlb.dshadow[i];
+            if (ppcemb_tlb_check(env, tlb, raddr, address, pid, -i)) {
+                goto found;
+            }
+        }
+    }
+    /* Then check main (software visible) TLB */
     for (i =3D 0; i < env->nb_tlb; i++) {
         tlb =3D &env->tlb.tlbe[i];
-        if (!ppcemb_tlb_check(env, tlb, raddr, address,
-                              env->spr[SPR_40x_PID], i)) {
-            continue;
+        if (ppcemb_tlb_check(env, tlb, raddr, address, pid, i)) {
+            goto found_main;
         }
-        zsel =3D (tlb->attr >> 4) & 0xF;
-        zpr =3D (env->spr[SPR_40x_ZPR] >> (30 - (2 * zsel))) & 0x3;
-        qemu_log_mask(CPU_LOG_MMU,
-                      "%s: TLB %d zsel %d zpr %d ty %d attr %08x\n",
-                      __func__, i, zsel, zpr, access_type, tlb->attr);
-        /* Check execute enable bit */
-        switch (zpr) {
-        case 0x2:
-            if (pr !=3D 0) {
-                goto check_perms;
-            }
-            /* fall through */
-        case 0x3:
-            /* All accesses granted */
-            *prot =3D PAGE_RWX;
-            ret =3D 0;
-            break;
+    }
+    goto out;
=20
-        case 0x0:
-            if (pr !=3D 0) {
-                /* Raise Zone protection fault.  */
-                env->spr[SPR_40x_ESR] =3D 1 << 22;
-                *prot =3D 0;
-                ret =3D -2;
-                break;
-            }
-            /* fall through */
-        case 0x1:
-check_perms:
-            /* Check from TLB entry */
-            *prot =3D tlb->prot;
-            if (check_prot_access_type(*prot, access_type)) {
-                ret =3D 0;
-            } else {
-                env->spr[SPR_40x_ESR] =3D 0;
-                ret =3D -2;
-            }
+found_main:
+    /* Shadow must be reloaded, FIFO replacement */
+    if (access_type =3D=3D MMU_INST_FETCH) {
+        env->tlb.ishadow[env->tlb.ishadow_idx] =3D *tlb;
+        env->tlb.ishadow_idx++;
+        env->tlb.ishadow_idx %=3D 4;
+    } else {
+        env->tlb.dshadow[env->tlb.dshadow_idx] =3D *tlb;
+        env->tlb.dshadow_idx++;
+        env->tlb.dshadow_idx %=3D 8;
+    }
+
+found:
+    pr =3D FIELD_EX64(env->msr, MSR, PR);
+
+    zsel =3D (tlb->attr >> 4) & 0xF;
+    zpr =3D (env->spr[SPR_40x_ZPR] >> (30 - (2 * zsel))) & 0x3;
+    qemu_log_mask(CPU_LOG_MMU,
+                  "%s: TLB %d zsel %d zpr %d ty %d attr %08x\n",
+                  __func__, i, zsel, zpr, access_type, tlb->attr);
+    /* Check execute enable bit */
+    switch (zpr) {
+    case 0x2:
+        if (pr !=3D 0) {
+            goto check_perms;
+        }
+        /* fall through */
+    case 0x3:
+        /* All accesses granted */
+        *prot =3D PAGE_RWX;
+        ret =3D 0;
+        break;
+
+    case 0x0:
+        if (pr !=3D 0) {
+            /* Raise Zone protection fault.  */
+            env->spr[SPR_40x_ESR] =3D 1 << 22;
+            *prot =3D 0;
+            ret =3D -2;
             break;
         }
+        /* fall through */
+    case 0x1:
+check_perms:
+        /* Check from TLB entry */
+        *prot =3D tlb->prot;
+        if (check_prot_access_type(*prot, access_type)) {
+            ret =3D 0;
+        } else {
+            env->spr[SPR_40x_ESR] =3D 0;
+            ret =3D -2;
+        }
+        break;
     }
+
+out:
     qemu_log_mask(CPU_LOG_MMU, "%s: access %s " TARGET_FMT_lx " =3D> "
                   HWADDR_FMT_plx " %d %d\n",  __func__,
                   ret < 0 ? "refused" : "granted", address,
diff --git a/target/ppc/mmu_helper.c b/target/ppc/mmu_helper.c
index b0a0676beb..502ddf65b6 100644
--- a/target/ppc/mmu_helper.c
+++ b/target/ppc/mmu_helper.c
@@ -108,6 +108,22 @@ static void ppc6xx_tlb_store(CPUPPCState *env, target_=
ulong EPN, int way,
 }
=20
 /* Helpers specific to PowerPC 40x implementations */
+void ppc4xx_tlb_invalidate_shadow(CPUPPCState *env);
+void ppc4xx_tlb_invalidate_shadow(CPUPPCState *env)
+{
+    ppcemb_tlb_t *tlb;
+    int i;
+
+    for (i =3D 0; i < 4; i++) {
+        tlb =3D &env->tlb.ishadow[i];
+        tlb->prot &=3D ~PAGE_VALID;
+    }
+    for (i =3D 0; i < 8; i++) {
+        tlb =3D &env->tlb.dshadow[i];
+        tlb->prot &=3D ~PAGE_VALID;
+    }
+}
+
 static inline void ppc4xx_tlb_invalidate_all(CPUPPCState *env)
 {
     ppcemb_tlb_t *tlb;
@@ -117,6 +133,7 @@ static inline void ppc4xx_tlb_invalidate_all(CPUPPCStat=
e *env)
         tlb =3D &env->tlb.tlbe[i];
         tlb->prot &=3D ~PAGE_VALID;
     }
+    ppc4xx_tlb_invalidate_shadow(env);
     tlb_flush(env_cpu(env));
 }
=20
@@ -719,6 +736,7 @@ target_ulong helper_4xx_tlbre_lo(CPUPPCState *env, targ=
et_ulong entry)
     return ret;
 }
=20
+#if 0
 static void ppcemb_tlb_flush(CPUState *cs, ppcemb_tlb_t *tlb)
 {
     unsigned mmu_idx =3D 0;
@@ -736,6 +754,7 @@ static void ppcemb_tlb_flush(CPUState *cs, ppcemb_tlb_t=
 *tlb)
     tlb_flush_range_by_mmuidx(cs, tlb->EPN, tlb->size, mmu_idx,
                               TARGET_LONG_BITS);
 }
+#endif
=20
 void helper_4xx_tlbwe_hi(CPUPPCState *env, target_ulong entry,
                          target_ulong val)
@@ -753,7 +772,7 @@ void helper_4xx_tlbwe_hi(CPUPPCState *env, target_ulong=
 entry,
         qemu_log_mask(CPU_LOG_MMU, "%s: invalidate old TLB %d start "
                       TARGET_FMT_lx " end " TARGET_FMT_lx "\n", __func__,
                       (int)entry, tlb->EPN, tlb->EPN + tlb->size);
-        ppcemb_tlb_flush(cs, tlb);
+        env->tlb_need_flush |=3D TLB_NEED_LOCAL_FLUSH;
     }
     tlb->size =3D booke_tlb_to_page_size((val >> PPC4XX_TLBHI_SIZE_SHIFT)
                                        & PPC4XX_TLBHI_SIZE_MASK);
@@ -792,7 +811,7 @@ void helper_4xx_tlbwe_hi(CPUPPCState *env, target_ulong=
 entry,
 void helper_4xx_tlbwe_lo(CPUPPCState *env, target_ulong entry,
                          target_ulong val)
 {
-    CPUState *cs =3D env_cpu(env);
+//    CPUState *cs =3D env_cpu(env);
     ppcemb_tlb_t *tlb;
=20
     qemu_log_mask(CPU_LOG_MMU, "%s entry %i val " TARGET_FMT_lx "\n",
@@ -804,7 +823,7 @@ void helper_4xx_tlbwe_lo(CPUPPCState *env, target_ulong=
 entry,
         qemu_log_mask(CPU_LOG_MMU, "%s: invalidate old TLB %d start "
                       TARGET_FMT_lx " end " TARGET_FMT_lx "\n", __func__,
                       (int)entry, tlb->EPN, tlb->EPN + tlb->size);
-        ppcemb_tlb_flush(cs, tlb);
+        env->tlb_need_flush |=3D TLB_NEED_LOCAL_FLUSH;
     }
     tlb->attr =3D val & PPC4XX_TLBLO_ATTR_MASK;
     tlb->RPN =3D val & PPC4XX_TLBLO_RPN_MASK;
@@ -865,7 +884,7 @@ void helper_440_tlbwe(CPUPPCState *env, uint32_t word, =
target_ulong entry,
         qemu_log_mask(CPU_LOG_MMU, "%s: invalidate old TLB %d start "
                       TARGET_FMT_lx " end " TARGET_FMT_lx "\n", __func__,
                       (int)entry, tlb->EPN, tlb->EPN + tlb->size);
-        ppcemb_tlb_flush(env_cpu(env), tlb);
+        env->tlb_need_flush |=3D TLB_NEED_LOCAL_FLUSH;
     }
=20
     switch (word) {

