Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C2B1C04FFE
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 12:55:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4gp5-00081e-AJ; Wed, 08 May 2024 08:55:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s4gp4-0007zL-5b; Wed, 08 May 2024 08:55:02 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s4gox-0002eA-6M; Wed, 08 May 2024 08:55:01 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-2b4a7671abaso2955419a91.0; 
 Wed, 08 May 2024 05:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715172893; x=1715777693; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x22OY0CdU4vXaLJgtfBbfBxu69h616NKYbyMEyzgPBE=;
 b=fJrBIfeprZne8JMhZ1xPgpn+RvxuRir8O++F3EmjXsYR40zddmxo7Wb8uFJbvZrycC
 qX45W+BCGkcm1jGqPIKHzTFBT/5SuDIPX/51FKYbTlKd8bizU15b3c1Wx6Zzbj7B3epT
 6EhwXLJ2J/A+KH98dSgzDedG7CxXDsEo090vMa8GSwinQhLSW6N/trr2Lj3mIhrPF0yP
 ec3hYqMS+0S6Y01FfQECf1vvUcZpu/ZnbcR9p/ijXgN1vDk9/QPxCGgIP3Pyw4RattEk
 gTOBeubOwrRXTLUlG1TFciWl5QoV1N0ICERmOlZnb6VB460uvchcq+tSUmMulD9jx+in
 ukpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715172893; x=1715777693;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=x22OY0CdU4vXaLJgtfBbfBxu69h616NKYbyMEyzgPBE=;
 b=nx+SoXFwok5cxgis75B/c763e93Zh0SYaR/pzNKVyA9g59culZWoa7r9l/thVetnlI
 XRmBzJ7JQ5WFmuul0cxnfIdlp8m8hndklmd6Ml6H0GwCSHQT1xMhU3gIdpFSELgI+B8D
 9+2tNLEWPygE96tyaHVzecbMCzai6YaCxchl4VLXw3XFEbBT5lZyxXqUYpHhNELhnUdZ
 u1AXwjSqYZlNMcUltDlW1ofAIu7VcnWV+HEHKkX45wmfVozK9YkJRRHIMWDRVuZIgxoY
 vowGYdCoH/KsDfBk5fxcn5+sceB7Y3EtvcTPa2qRqeTo1t2rNV3qlhARYk8XEFWo7EDa
 GbpA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWyNbXCQb0+oeiXZ6g9YSe4/SsmktX84E11ZFHQUCBq45gDuSiqM5722enNBkzCEQuV+aZ/ACZEyDPg5BwtrjwLtLBQ
X-Gm-Message-State: AOJu0YzKffnRmdHOBqMG9Whsakq1kJkLGPEkKdcb0NIRxjQMLaUhP6tM
 YgcSlFRQ00MbXryorrdUs+pfmahNeT/DfPC4GHMNvFgE/+8KdLA9
X-Google-Smtp-Source: AGHT+IEtCw7C+Wfu6apjMsWyPHE7zRSQvr7oKYdfy6r8qThhE1ZoyhvWhTfQEzUrCOQx8PrN7RfO/w==
X-Received: by 2002:a17:90a:f289:b0:2b1:a632:60f6 with SMTP id
 98e67ed59e1d1-2b616beb346mr2330615a91.44.1715172893104; 
 Wed, 08 May 2024 05:54:53 -0700 (PDT)
Received: from localhost ([1.146.8.34]) by smtp.gmail.com with ESMTPSA id
 dt15-20020a17090afa4f00b002b57ccdf929sm1359872pjb.1.2024.05.08.05.54.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 May 2024 05:54:52 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 08 May 2024 22:54:47 +1000
Message-Id: <D14A1N415IER.161PBQJVFBY8L@gmail.com>
Cc: <qemu-devel@nongnu.org>, <qemu-ppc@nongnu.org>, "Daniel Henrique
 Barboza" <danielhb413@gmail.com>
Subject: Re: [PATCH v2 24/28] target/ppc/mmu_common.c: Remove BookE handling
 from get_physical_address_wtlb()
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "BALATON Zoltan" <balaton@eik.bme.hu>
X-Mailer: aerc 0.17.0
References: <cover.1714606359.git.balaton@eik.bme.hu>
 <cd05e33ea86d301cf64aa3925a6302b92249ee3c.1714606359.git.balaton@eik.bme.hu>
 <D13EDO9E2R7L.E6416WEFSMYL@gmail.com>
 <alpine.LMD.2.03.2405080129400.14319@eik.bme.hu>
In-Reply-To: <alpine.LMD.2.03.2405080129400.14319@eik.bme.hu>
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x102e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Wed May 8, 2024 at 9:40 AM AEST, BALATON Zoltan wrote:
> On Tue, 7 May 2024, Nicholas Piggin wrote:
> > On Thu May 2, 2024 at 9:43 AM AEST, BALATON Zoltan wrote:
> >> This function is no longer called for BookE MMU model so remove parts
> >> related to it. This has uncovered a few may be used uninitialised
> >> warnings that are also fixed.
> >>
> >> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> >> ---
> >>  target/ppc/mmu_common.c | 25 +++++--------------------
> >>  1 file changed, 5 insertions(+), 20 deletions(-)
> >>
> >> diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
> >> index a1f98f8de4..d61c41d8c9 100644
> >> --- a/target/ppc/mmu_common.c
> >> +++ b/target/ppc/mmu_common.c
> >> @@ -684,12 +684,10 @@ static int mmubooke_get_physical_address(CPUPPCS=
tate *env, mmu_ctx_t *ctx,
> >>          ret =3D mmubooke_check_tlb(env, tlb, &raddr, &ctx->prot, addr=
ess,
> >>                                   access_type, i);
> >>          if (ret !=3D -1) {
> >> -            if (ret >=3D 0) {
> >> -                ctx->raddr =3D raddr;
> >> -            }
> >>              break;
> >>          }
> >>      }
> >> +    ctx->raddr =3D raddr;
> >>      qemu_log_mask(CPU_LOG_MMU,
> >>                    "%s: access %s " TARGET_FMT_lx " =3D> " HWADDR_FMT_=
plx
> >>                    " %d %d\n", __func__, ret < 0 ? "refused" : "grante=
d",
> >> @@ -897,9 +895,6 @@ static int mmubooke206_get_physical_address(CPUPPC=
State *env, mmu_ctx_t *ctx,
> >>              ret =3D mmubooke206_check_tlb(env, tlb, &raddr, &ctx->pro=
t, address,
> >>                                          access_type, mmu_idx);
> >>              if (ret !=3D -1) {
> >> -                if (ret >=3D 0) {
> >> -                    ctx->raddr =3D raddr;
> >> -                }
> >>                  goto found_tlb;
> >>              }
> >>          }
> >> @@ -907,6 +902,7 @@ static int mmubooke206_get_physical_address(CPUPPC=
State *env, mmu_ctx_t *ctx,
> >>
> >>  found_tlb:
> >>
> >> +    ctx->raddr =3D raddr;
> >
> > Not sure about the uninitialized warnings here either, caller probably
> > should not be using ctx->raddr unless we returned 0...
> >
> >>      qemu_log_mask(CPU_LOG_MMU, "%s: access %s " TARGET_FMT_lx " =3D> =
"
> >>                    HWADDR_FMT_plx " %d %d\n", __func__,
> >>                    ret < 0 ? "refused" : "granted", address, raddr,
> >> @@ -1163,20 +1159,9 @@ static int get_physical_address_wtlb(CPUPPCStat=
e *env, mmu_ctx_t *ctx,
> >>                                       MMUAccessType access_type, int t=
ype,
> >>                                       int mmu_idx)
> >>  {
> >> -    bool real_mode;
> >> -
> >> -    if (env->mmu_model =3D=3D POWERPC_MMU_BOOKE) {
> >> -        return mmubooke_get_physical_address(env, ctx, eaddr, access_=
type);
> >> -    } else if (env->mmu_model =3D=3D POWERPC_MMU_BOOKE206) {
> >> -        return mmubooke206_get_physical_address(env, ctx, eaddr, acce=
ss_type,
> >> -                                                mmu_idx);
> >> -    }
> >
> > This could just go in the previous patch when you split booke xlate?
>
> Removing this uncovers the warnings so I keep it here to separate it from=
=20
> the previous change. I gave up on trying to resolve these warnings and=20
> untangle the embedded functions from mmu_ctx_t which would be needed to=
=20
> move these booke functions out from this file. The other problem is that=
=20
> these booke get_physical_address functions and mmu40x_get_physical_addres=
s=20
> all use ppcemb_tlb_check which then needs to be in the same file and=20
> static to be inlined and not run too slow but 40x is still in jumbo_xlate=
=20
> so I just leave it for now and may return to it later or let somebody els=
e=20
> continue from here. I think this series moves forward enough for now and =
I=20
> don't have more time now.

If you can't easily drop the path or solve the problem okay, just put
a comment or something on the zeroing and I'll take a closer look
when I merge.

>
> >> -
> >> -    real_mode =3D (type =3D=3D ACCESS_CODE) ? !FIELD_EX64(env->msr, M=
SR, IR)
> >> -                                      : !FIELD_EX64(env->msr, MSR, DR=
);
> >> -    if (real_mode && (env->mmu_model =3D=3D POWERPC_MMU_SOFT_6xx ||
> >> -                      env->mmu_model =3D=3D POWERPC_MMU_SOFT_4xx ||
> >> -                      env->mmu_model =3D=3D POWERPC_MMU_REAL)) {
> >> +    bool real_mode =3D (type =3D=3D ACCESS_CODE) ? !FIELD_EX64(env->m=
sr, MSR, IR)
> >> +                                           : !FIELD_EX64(env->msr, MS=
R, DR);
> >> +    if (real_mode) {
> >>          memset(ctx, 0, sizeof(*ctx));
> >>          ctx->raddr =3D eaddr;
> >>          ctx->prot =3D PAGE_READ | PAGE_WRITE | PAGE_EXEC;
> >
> > This still changes beahviour of MPC8xx MMU doesn't it? It's supposed
> > to abort always.
>
> I don't think it can get here because there's still an abort case in=20
> ppc_tlb_invalidate_all() which is called from ppc_cpu_reset_hold() so it=
=20
> will likely crash before it could call anything here. But if you think=20
> it's necessary I could add a case for it in ppc_xlate() maybe.

I would rather not change it here. You can remove it with another patch.

Thanks,
Nick

