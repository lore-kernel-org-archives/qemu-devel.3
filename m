Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2A86C10F1A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 12:16:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4Jjl-0002fd-Eu; Tue, 07 May 2024 08:16:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s4Jjh-0002UL-9N; Tue, 07 May 2024 08:15:57 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s4Jje-0001AA-1u; Tue, 07 May 2024 08:15:57 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1ee12baa01cso15404615ad.0; 
 Tue, 07 May 2024 05:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715084151; x=1715688951; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J5kOGEZOH3kr5i5gRHOIyLGZC9Gv4+bB/EqJKIONsXo=;
 b=epoHi/z2y5mk0P7PMI/edmtoZe9ULZ+XkiHzot7XiA0FSZIeRhDgJDy4bzZzntXhzp
 uiYaMscSxzgTQA+3mEKNDdWV3IbJTq4p/UhRKVA92McaAj5NP1I8J9AejjQlE2Jirb6c
 HcNj+V3DaHJZlQvGjKPgOk5miVgdEqzw9zaFDWHtMhYoT+bxSmiqf3le2269Cn6eUhMd
 OyOYe3QZLBpd4uJLnFDwEXYDcE2+Lu3W51fChQON4Wo2vP1yDS3Bj271ICc1xi4uMR+s
 ivK/++NxiITW09A81WsdyBzDLOltVE1/0gA38+4MWWEd57U5dVlrUyzgvKOdvYIyb+Qi
 Wt4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715084151; x=1715688951;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=J5kOGEZOH3kr5i5gRHOIyLGZC9Gv4+bB/EqJKIONsXo=;
 b=M9kbL4DoG+ByD1Dz9nPhiQIeN7a0fvg8vh/wXY3m/p/pAnZPL7hlmllicIzJIpJaVb
 w5JNQNxxWLYwXXxRbDq6AKdd5Aq8aYJKCB2MVWFjCg9LBDUca3bsH6lIpTL5A2DKU3Mw
 pcOJv5SufQbLdonBMo08bEX1maPOUjhka//5giK+UC2tljGwccI0ApNZ/qcc3Uqf+AZ6
 vuDns0MuUnh7sLR6guuAW1yabWwLiTXj1awiiqjREkcasMPZ0bqBexvCqyt99joc9t3Q
 6XlmLktdwRewVJo5GTkb2I09GHaC+8mp/5kGuCbIb8XDF0LQ4615vJuZlLMTkW34LdXl
 0Osw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYAB1QdJsBQuUKii/rvTdrfvOuINgQltNult/BG8auCaw+/RuNhBoUXt0SynOijxsVo6a3mvfBpdH1iA8QArVmZJOthFjK7thE0dMk9/Ltvl1dFrYvoM6qz2g=
X-Gm-Message-State: AOJu0Yx0mf2eYowx2NVJv9Wds4ZQoqT0QzCCimTY4e/EzKHgbggM7zhh
 /zjIjvMyUykz9ie/tMD7Dfpo6lGEuN4gwfbnsuz5/FCaKuFBnBpwv1llIg==
X-Google-Smtp-Source: AGHT+IHGwe8boBTZqZ5RXe2A7AaKmBF3BZvlLew0yZXlMUWS995yiGp3pJ3oaTtIW8fOQqVXSPYfqQ==
X-Received: by 2002:a17:902:c948:b0:1eb:61a4:a2bc with SMTP id
 i8-20020a170902c94800b001eb61a4a2bcmr16736004pla.43.1715084151537; 
 Tue, 07 May 2024 05:15:51 -0700 (PDT)
Received: from localhost (220-245-239-57.tpgi.com.au. [220.245.239.57])
 by smtp.gmail.com with ESMTPSA id
 kj6-20020a17090306c600b001ec48815491sm9910848plb.101.2024.05.07.05.15.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 May 2024 05:15:51 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 07 May 2024 22:15:46 +1000
Message-Id: <D13EL7XP1XVE.2NI5UGPDDEX8N@gmail.com>
Cc: "Daniel Henrique Barboza" <danielhb413@gmail.com>
Subject: Re: [PATCH v2 25/28] target/ppc/mmu_common.c: Simplify
 ppc_booke_xlate()
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, <qemu-devel@nongnu.org>,
 <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.17.0
References: <cover.1714606359.git.balaton@eik.bme.hu>
 <b3caa952ce91c07bcc958a3662349418c5716673.1714606359.git.balaton@eik.bme.hu>
In-Reply-To: <b3caa952ce91c07bcc958a3662349418c5716673.1714606359.git.balaton@eik.bme.hu>
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x629.google.com
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

Will review this if we can get -4 case removed...

Don't know if I'm too keen on doing the fetch branch first
and asymmetric (if vs switch) checking of ret in the fetch
vs data cases. I think with -4 case removed things will
look much nicer.

Thanks,
Nick

On Thu May 2, 2024 at 9:43 AM AEST, BALATON Zoltan wrote:
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>  target/ppc/mmu_common.c | 147 +++++++++++++++-------------------------
>  1 file changed, 56 insertions(+), 91 deletions(-)
>
> diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
> index d61c41d8c9..b76611da80 100644
> --- a/target/ppc/mmu_common.c
> +++ b/target/ppc/mmu_common.c
> @@ -1261,106 +1261,71 @@ static bool ppc_booke_xlate(PowerPCCPU *cpu, vad=
dr eaddr,
>      }
> =20
>      log_cpu_state_mask(CPU_LOG_MMU, cs, 0);
> +    env->error_code =3D 0;
> +    if (env->mmu_model =3D=3D POWERPC_MMU_BOOKE206 && ret =3D=3D -1) {
> +        booke206_update_mas_tlb_miss(env, eaddr, access_type, mmu_idx);
> +    }
>      if (access_type =3D=3D MMU_INST_FETCH) {
> -        switch (ret) {
> -        case -1:
> +        if (ret =3D=3D -1) {
>              /* No matches in page tables or TLB */
> -            switch (env->mmu_model) {
> -            case POWERPC_MMU_BOOKE206:
> -                booke206_update_mas_tlb_miss(env, eaddr, access_type, mm=
u_idx);
> -                /* fall through */
> -            case POWERPC_MMU_BOOKE:
> -                cs->exception_index =3D POWERPC_EXCP_ITLB;
> -                env->error_code =3D 0;
> -                env->spr[SPR_BOOKE_DEAR] =3D eaddr;
> -                env->spr[SPR_BOOKE_ESR] =3D mmubooke206_esr(mmu_idx, acc=
ess_type);
> -                break;
> -            default:
> -                g_assert_not_reached();
> -            }
> -            break;
> -        case -2:
> -            /* Access rights violation */
> -            cs->exception_index =3D POWERPC_EXCP_ISI;
> -            env->error_code =3D 0;
> -            break;
> -        case -3:
> -            /* No execute protection violation */
> -            cs->exception_index =3D POWERPC_EXCP_ISI;
> -            env->spr[SPR_BOOKE_ESR] =3D 0;
> -            env->error_code =3D 0;
> -            break;
> -        case -4:
> -            /* Direct store exception */
> -            /* No code fetch is allowed in direct-store areas */
> +            cs->exception_index =3D POWERPC_EXCP_ITLB;
> +            env->spr[SPR_BOOKE_DEAR] =3D eaddr;
> +            env->spr[SPR_BOOKE_ESR] =3D mmubooke206_esr(mmu_idx, access_=
type);
> +        } else {
>              cs->exception_index =3D POWERPC_EXCP_ISI;
> -            env->error_code =3D 0;
> -            break;
> -        }
> -    } else {
> -        switch (ret) {
> -        case -1:
> -            /* No matches in page tables or TLB */
> -            switch (env->mmu_model) {
> -            case POWERPC_MMU_BOOKE206:
> -                booke206_update_mas_tlb_miss(env, eaddr, access_type, mm=
u_idx);
> -                /* fall through */
> -            case POWERPC_MMU_BOOKE:
> -                cs->exception_index =3D POWERPC_EXCP_DTLB;
> -                env->error_code =3D 0;
> -                env->spr[SPR_BOOKE_DEAR] =3D eaddr;
> -                env->spr[SPR_BOOKE_ESR] =3D mmubooke206_esr(mmu_idx, acc=
ess_type);
> -                break;
> -            default:
> -                g_assert_not_reached();
> +            if (ret =3D=3D -3) {
> +                /* No execute protection violation */
> +                env->spr[SPR_BOOKE_ESR] =3D 0;
>              }
> +        }
> +        return false;
> +    }
> +
> +    switch (ret) {
> +    case -1:
> +        /* No matches in page tables or TLB */
> +        cs->exception_index =3D POWERPC_EXCP_DTLB;
> +        env->spr[SPR_BOOKE_DEAR] =3D eaddr;
> +        env->spr[SPR_BOOKE_ESR] =3D mmubooke206_esr(mmu_idx, access_type=
);
> +        break;
> +    case -2:
> +        /* Access rights violation */
> +        cs->exception_index =3D POWERPC_EXCP_DSI;
> +        env->spr[SPR_BOOKE_DEAR] =3D eaddr;
> +        env->spr[SPR_BOOKE_ESR] =3D mmubooke206_esr(mmu_idx, access_type=
);
> +        break;
> +    case -4:
> +        /* Direct store exception */
> +        env->spr[SPR_DAR] =3D eaddr;
> +        switch (env->access_type) {
> +        case ACCESS_FLOAT:
> +            /* Floating point load/store */
> +            cs->exception_index =3D POWERPC_EXCP_ALIGN;
> +            env->error_code =3D POWERPC_EXCP_ALIGN_FP;
>              break;
> -        case -2:
> -            /* Access rights violation */
> +        case ACCESS_RES:
> +            /* lwarx, ldarx or stwcx. */
>              cs->exception_index =3D POWERPC_EXCP_DSI;
> -            env->error_code =3D 0;
> -            env->spr[SPR_BOOKE_DEAR] =3D eaddr;
> -            env->spr[SPR_BOOKE_ESR] =3D mmubooke206_esr(mmu_idx, access_=
type);
> +            if (access_type =3D=3D MMU_DATA_STORE) {
> +                env->spr[SPR_DSISR] =3D 0x06000000;
> +            } else {
> +                env->spr[SPR_DSISR] =3D 0x04000000;
> +            }
>              break;
> -        case -4:
> -            /* Direct store exception */
> -            switch (env->access_type) {
> -            case ACCESS_FLOAT:
> -                /* Floating point load/store */
> -                cs->exception_index =3D POWERPC_EXCP_ALIGN;
> -                env->error_code =3D POWERPC_EXCP_ALIGN_FP;
> -                env->spr[SPR_DAR] =3D eaddr;
> -                break;
> -            case ACCESS_RES:
> -                /* lwarx, ldarx or stwcx. */
> -                cs->exception_index =3D POWERPC_EXCP_DSI;
> -                env->error_code =3D 0;
> -                env->spr[SPR_DAR] =3D eaddr;
> -                if (access_type =3D=3D MMU_DATA_STORE) {
> -                    env->spr[SPR_DSISR] =3D 0x06000000;
> -                } else {
> -                    env->spr[SPR_DSISR] =3D 0x04000000;
> -                }
> -                break;
> -            case ACCESS_EXT:
> -                /* eciwx or ecowx */
> -                cs->exception_index =3D POWERPC_EXCP_DSI;
> -                env->error_code =3D 0;
> -                env->spr[SPR_DAR] =3D eaddr;
> -                if (access_type =3D=3D MMU_DATA_STORE) {
> -                    env->spr[SPR_DSISR] =3D 0x06100000;
> -                } else {
> -                    env->spr[SPR_DSISR] =3D 0x04100000;
> -                }
> -                break;
> -            default:
> -                printf("DSI: invalid exception (%d)\n", ret);
> -                cs->exception_index =3D POWERPC_EXCP_PROGRAM;
> -                env->error_code =3D POWERPC_EXCP_INVAL | POWERPC_EXCP_IN=
VAL_INVAL;
> -                env->spr[SPR_DAR] =3D eaddr;
> -                break;
> +        case ACCESS_EXT:
> +            /* eciwx or ecowx */
> +            cs->exception_index =3D POWERPC_EXCP_DSI;
> +            if (access_type =3D=3D MMU_DATA_STORE) {
> +                env->spr[SPR_DSISR] =3D 0x06100000;
> +            } else {
> +                env->spr[SPR_DSISR] =3D 0x04100000;
>              }
>              break;
> +        default:
> +            printf("DSI: invalid exception (%d)\n", ret);
> +            cs->exception_index =3D POWERPC_EXCP_PROGRAM;
> +            env->error_code =3D POWERPC_EXCP_INVAL | POWERPC_EXCP_INVAL_=
INVAL;
> +            break;
>          }
>      }
>      return false;


