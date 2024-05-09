Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45D0AC10F1A
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2024 05:54:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4wj9-0004Nk-8E; Thu, 09 May 2024 01:53:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s4wj7-0004LV-Tw; Thu, 09 May 2024 01:53:57 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s4wj6-0000NI-1U; Thu, 09 May 2024 01:53:57 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1edfc57ac0cso3612195ad.3; 
 Wed, 08 May 2024 22:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715234032; x=1715838832; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pbcTmQEl8eT2YSFfhtVpXRl/f6DtUmWWjA7373ukXXA=;
 b=ejdnBC9jNg9ix8gEllCjkszd3jQF5g4OtRR0thptXl9z/yMwd6X+29s3+IMcp75etf
 YYE2jB72DauEaeqw+V0ZpWcBqgM1Ql+i7bPEfC08ymiGZjz4AyTTq1SCdgJqNsvK4QxE
 SVYPdR+A+yaa2Budb+ehlEFn9SSNmXWpoTuAmA+ITsOlc99qIHeRTuPw/FnLeYJus4Ri
 ast+T9y2BID6PUSyBSCjbJxY6JbY0SIYBwp/t8GCNJ01IlFSuyEhDQ+BQKYpm0iUxEse
 DXtVLOQixy21w5J019qt18QFj3+9SPpBDbubcAEqtJN6JjNzDoJOsgMVq+t0VSE3JbJ2
 XFfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715234032; x=1715838832;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=pbcTmQEl8eT2YSFfhtVpXRl/f6DtUmWWjA7373ukXXA=;
 b=WU6YgEAp7GDdnaZvf7yyz4le1njGtovKueRd1eaf/j0cVx6A5Ng1DwmDlgnxhdKUhA
 LaNU+0UrHjAzlR1U8kUfCLufedRqFbFgky8qp597AqXMGBgS42yXqHHgIqh67ugFXOIz
 o/N7SjeaVkJxFmIkdBoYoqv6qpMun/uNGtYpRp4psa0DEiYwfzssmSN0RBvP7mvODCtR
 f20sC6ls0+XxH06fiQ2RnxssK6Mv1S1BCCMplsCqAOARnUlmpnP4XZV+JjqCvpC674tC
 lRdNQ0taKqZUZGuK8wXgAzizhZuseEDnbey96DfjAGWPe19pkyKh1dinvprLYzEKUie9
 gg8g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXhW60db2oeDANYjSNeTg1og1kFD3aAQsEyDVX9ZVnZ+e2HNsNhBLhRgZf+z7AxrsKAlZeASR0opr9p/1xNL032OVot
X-Gm-Message-State: AOJu0Yys0K0zXDIKPD+QTyuaE18+2y4KqkLTS+t7yY1yTiMDAtYP4jsk
 RAhoTOLKKkQ+9l/E2Bz56ywhHbVs8mhUJSiAoRZbj63+mt/56Z27/C5U9w==
X-Google-Smtp-Source: AGHT+IGbc6DtemzySid5rJjw1f5kN9ZYXMjv+sxGmZO8kWaRGMSKzkSGjVcpDM08+Xv8TqXp1yjNFA==
X-Received: by 2002:a17:902:848e:b0:1ec:3ae4:cfe9 with SMTP id
 d9443c01a7336-1eeb0697e47mr42489615ad.33.1715234032113; 
 Wed, 08 May 2024 22:53:52 -0700 (PDT)
Received: from localhost (220-245-239-57.tpgi.com.au. [220.245.239.57])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1ef0b9d1807sm5469875ad.59.2024.05.08.22.53.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 May 2024 22:53:51 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 09 May 2024 15:53:47 +1000
Message-Id: <D14VPU4PT8Q4.3U8CM56ADMAZO@gmail.com>
Cc: <qemu-devel@nongnu.org>, <qemu-ppc@nongnu.org>, "Daniel Henrique
 Barboza" <danielhb413@gmail.com>
Subject: Re: [PATCH v3 26/33] target/ppc/mmu_common.c: Simplify
 ppc_booke_xlate() part 1
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "BALATON Zoltan" <balaton@eik.bme.hu>
X-Mailer: aerc 0.17.0
References: <cover.1715125376.git.balaton@eik.bme.hu>
 <5074c129ebfea0e1dfc22ef4691d8b62038d59b2.1715125376.git.balaton@eik.bme.hu>
 <D14AJB3VXJL0.18D5ZU7FZFOLN@gmail.com>
 <8ea53cfc-963f-000c-f5dc-d6bd61db3fbb@eik.bme.hu>
In-Reply-To: <8ea53cfc-963f-000c-f5dc-d6bd61db3fbb@eik.bme.hu>
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x634.google.com
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

On Thu May 9, 2024 at 1:25 AM AEST, BALATON Zoltan wrote:
> On Wed, 8 May 2024, Nicholas Piggin wrote:
> > On Wed May 8, 2024 at 10:15 AM AEST, BALATON Zoltan wrote:
> >> Move setting error_code that appears in every case out in front and
> >> hoist the common fall through case for BOOKE206 as well which allows
> >> removing the nested switches.
> >>
> >
> > Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
> >
> >> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> >> ---
> >>  target/ppc/mmu_common.c | 41 ++++++++++++----------------------------=
-
> >>  1 file changed, 12 insertions(+), 29 deletions(-)
> >>
> >> diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
> >> index 788e2bebd5..c725a7932f 100644
> >> --- a/target/ppc/mmu_common.c
> >> +++ b/target/ppc/mmu_common.c
> >> @@ -1205,58 +1205,41 @@ static bool ppc_booke_xlate(PowerPCCPU *cpu, v=
addr eaddr,
> >>      }
> >>
> >>      log_cpu_state_mask(CPU_LOG_MMU, cs, 0);
> >> +    env->error_code =3D 0;
> >> +    if (ret =3D=3D -1) {
> >> +        if (env->mmu_model =3D=3D POWERPC_MMU_BOOKE206) {
> >> +            booke206_update_mas_tlb_miss(env, eaddr, access_type, mmu=
_idx);
> >> +        }
> >> +    }
> >>      if (access_type =3D=3D MMU_INST_FETCH) {
> >>          switch (ret) {
> >>          case -1:
> >>              /* No matches in page tables or TLB */
> >> -            switch (env->mmu_model) {
> >> -            case POWERPC_MMU_BOOKE206:
> >> -                booke206_update_mas_tlb_miss(env, eaddr, access_type,=
 mmu_idx);
> >> -                /* fall through */
> >> -            case POWERPC_MMU_BOOKE:
> >> -                cs->exception_index =3D POWERPC_EXCP_ITLB;
> >> -                env->error_code =3D 0;
> >> -                env->spr[SPR_BOOKE_DEAR] =3D eaddr;
> >> -                env->spr[SPR_BOOKE_ESR] =3D mmubooke206_esr(mmu_idx, =
access_type);
> >> -                break;
> >> -            default:
> >> -                g_assert_not_reached();
> >> -            }
> >> +            cs->exception_index =3D POWERPC_EXCP_ITLB;
> >> +            env->spr[SPR_BOOKE_DEAR] =3D eaddr;
> >> +            env->spr[SPR_BOOKE_ESR] =3D mmubooke206_esr(mmu_idx, acce=
ss_type);
> >>              break;
> >>          case -2:
> >>              /* Access rights violation */
> >>              cs->exception_index =3D POWERPC_EXCP_ISI;
> >> -            env->error_code =3D 0;
> >>              break;
> >>          case -3:
> >>              /* No execute protection violation */
> >>              cs->exception_index =3D POWERPC_EXCP_ISI;
> >>              env->spr[SPR_BOOKE_ESR] =3D 0;
> >
> > I don't know BookE well but AFAIKS it says ESR if not set explicitly
> > is generally cleared to 0 by interrupts which I guess is the case here.
> > I don't see why the same would not apply to the -2 case either. That
> > would reduce special cases.
> >
> > Although that's a behaviour change. It's possible current beahviour is
> > deliberate or matches some particular CPU. Not something for this
> > series.
>
> I don't know what the correct behaviour should be so I just tried to keep=
=20
> what was there. After this clean it should be simpler to find out and=20
> correct this later.

Right. Keeping exact behaviour is the right thing to do for such a
series, so it's good you have been doing it. It was just an offhand
comment because the special case annoyed me :)

Thanks,
Nick

