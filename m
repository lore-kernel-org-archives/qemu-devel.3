Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2910EC4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 01:18:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rv5Xy-0004mS-Ir; Thu, 11 Apr 2024 21:17:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bazz1tv2@gmail.com>)
 id 1rv5Xw-0004lQ-E3
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 21:17:40 -0400
Received: from mail-lf1-f48.google.com ([209.85.167.48])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bazz1tv2@gmail.com>)
 id 1rv5Xu-0005DC-GS
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 21:17:40 -0400
Received: by mail-lf1-f48.google.com with SMTP id
 2adb3069b0e04-516d0162fa1so491398e87.3
 for <qemu-devel@nongnu.org>; Thu, 11 Apr 2024 18:17:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712884656; x=1713489456;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=17ygJ6tkBYsUgj5vEOWQcRWOcfaFL3jF+HqFFXQTBzA=;
 b=LUBF0z2X/ikyYOxPds3WwcuXNs02PvLKVHp14TtxOuq7HCckiEnLYg9k1yTaGMnIcf
 KwOcCymIXMLM7NdAZ2+I68IJRgY+XlLGahf9ods/T+H//GMWT+607ErOU55XsK+hjDrY
 uMbMcGoQ7P7qs+Vy1rDbw2195S4rFm2qf1qJ3ZqRZHivnIPqwav8Q/wpXqJJRaXwegxh
 C0O/ylk1L6J401bvZy2Ho906duLbE3NQLZx4tVA1B64M+cA39R3nGMbNWz/p2/1SDox/
 kiqazAIA2r3eE3YRlYzJH82+k6uMvrwxktD0IU99d2/XfNvNhIVM304J/I+zlROyeduP
 rLKA==
X-Gm-Message-State: AOJu0Yyja21jNG4lxxwfZsjvJKt1IUmC5OWW4nf0KZTXLyKgJ3ibG9B8
 e4Mg8BRJi4dPA++aWcFqbR9D0f7OtbBrl4lccDkim2DSKR8Ukg1bdUNn+832hMcypA==
X-Google-Smtp-Source: AGHT+IHmnamYToygu9W8+V0O/34jEAT7fQlV8jPgxBgFin0Ngy9vcZNWH7md1icE8dlzVaZWIQRNug==
X-Received: by 2002:a19:6441:0:b0:517:7a70:47e7 with SMTP id
 b1-20020a196441000000b005177a7047e7mr842266lfj.36.1712884655417; 
 Thu, 11 Apr 2024 18:17:35 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com.
 [209.85.208.173]) by smtp.gmail.com with ESMTPSA id
 q4-20020ac25104000000b00516c247fc40sm359448lfb.222.2024.04.11.18.17.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Apr 2024 18:17:35 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id
 38308e7fff4ca-2d476d7972aso4874861fa.1
 for <qemu-devel@nongnu.org>; Thu, 11 Apr 2024 18:17:35 -0700 (PDT)
X-Received: by 2002:a2e:bc14:0:b0:2d8:6e0b:8166 with SMTP id
 b20-20020a2ebc14000000b002d86e0b8166mr1067328ljf.53.1712884654900; Thu, 11
 Apr 2024 18:17:34 -0700 (PDT)
MIME-Version: 1.0
References: <20240411212936.945-1-bazz@bazz1.com>
 <dfa87b87-8685-46ea-ae5d-3735124fc76a@linaro.org>
In-Reply-To: <dfa87b87-8685-46ea-ae5d-3735124fc76a@linaro.org>
From: M Bazz <bazz@bazz1.com>
Date: Thu, 11 Apr 2024 21:15:57 -0400
X-Gmail-Original-Message-ID: <CAMFqb-anRmzo1HP8Gn2y0eD98+ZsG_a54c_fLMaMc=0AGAz7DA@mail.gmail.com>
Message-ID: <CAMFqb-anRmzo1HP8Gn2y0eD98+ZsG_a54c_fLMaMc=0AGAz7DA@mail.gmail.com>
Subject: Re: [PATCH] target/sparc: resolve ASI_USERTXT correctly
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Artyom Tarasenko <atar4qemu@gmail.com>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=209.85.167.48; envelope-from=bazz1tv2@gmail.com;
 helo=mail-lf1-f48.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.248, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Thu, Apr 11, 2024, 5:55 PM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 4/11/24 14:29, M Bazz wrote:
> > fixes a longstanding bug which causes a "Nonparity Synchronous Error"
> > kernel panic while using a debugger on Solaris / SunOS systems. The panic
> > would occur on the first attempt to single-step the process.
> >
> > The problem stems from an lda instruction on ASI_USERTXT (8). This asi
> > was not being resolved correctly by resolve_asi().
> >
> > Further details can be found in #2281
> >
> > Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2281
> > Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2059
> > Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1609
> > Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1166
> >
> > Signed-off-by: M Bazz <bazz@bazz1.com>
> > ---
> >   target/sparc/translate.c | 2 ++
> >   1 file changed, 2 insertions(+)
> >
> > diff --git a/target/sparc/translate.c b/target/sparc/translate.c
> > index 319934d9bd..1596005e22 100644
> > --- a/target/sparc/translate.c
> > +++ b/target/sparc/translate.c
> > @@ -3,6 +3,7 @@
> >
> >      Copyright (C) 2003 Thomas M. Ogrisegg <tom@fnord.at>
> >      Copyright (C) 2003-2005 Fabrice Bellard
> > +   Copyright (C) 2024 M Bazz <bazz@bazz1.com>
> >
> >      This library is free software; you can redistribute it and/or
> >      modify it under the terms of the GNU Lesser General Public
> > @@ -1159,6 +1160,7 @@ static DisasASI resolve_asi(DisasContext *dc, int asi, MemOp memop)
> >                  || (asi == ASI_USERDATA
> >                      && (dc->def->features & CPU_FEATURE_CASA))) {
> >           switch (asi) {
> > +        case ASI_USERTXT:    /* User text access */
> >           case ASI_USERDATA:   /* User data access */
> >               mem_idx = MMU_USER_IDX;
> >               type = GET_ASI_DIRECT;
>
> I don't believe this is correct, because it operates against the page's "read" permissions
> instead of "execute" permissions.
>
>
> r~

Hi Richard,

Thanks for your guidance. It set me in the right direction. Now I
think I've got the right spot.

function `helper_ld_asi` has a block to help load ASI_KERNELTXT, but the
ASI_USERTXT case defaults to sparc_raise_mmu_fault(); I believe this
is the true culprit
source reference:
https://gitlab.com/qemu-project/qemu/-/blob/master/target/sparc/ldst_helper.c?ref_type=heads#L687

The code for the ASI_KERNELTXT seems generic enough to also use for
ASI_USERTXT verbatim.
See v2 patch below. I've done a `make test` -- all passing (3 skips).
OS boots, and the
debuggers are working without issue. What do you think?

Once we arrive at the right solution, I'll finalize the patch.
-bazz


diff --git a/target/sparc/ldst_helper.c b/target/sparc/ldst_helper.c
index e581bb42ac..4f87e44a93 100644
--- a/target/sparc/ldst_helper.c
+++ b/target/sparc/ldst_helper.c
@@ -684,6 +684,7 @@ uint64_t helper_ld_asi(CPUSPARCState *env,
target_ulong addr,
     case ASI_M_DIAGS:   /* Turbosparc DTLB Diagnostic */
     case ASI_M_IODIAG:  /* Turbosparc IOTLB Diagnostic */
         break;
+    case ASI_USERTXT: /* User code access */
     case ASI_KERNELTXT: /* Supervisor code access */
         oi = make_memop_idx(memop, cpu_mmu_index(env_cpu(env), true));
         switch (size) {
@@ -779,7 +780,6 @@ uint64_t helper_ld_asi(CPUSPARCState *env,
target_ulong addr,
     case 0x4c: /* SuperSPARC MMU Breakpoint Action */
         ret = env->mmubpaction;
         break;
-    case ASI_USERTXT: /* User code access, XXX */
     default:
         sparc_raise_mmu_fault(cs, addr, false, false, asi, size, GETPC());
         ret = 0;

