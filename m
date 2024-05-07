Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4807DC10F1A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 10:07:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4Hj0-0004An-GN; Tue, 07 May 2024 06:07:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s4Hiu-0004AH-M7; Tue, 07 May 2024 06:07:02 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s4His-0002i1-EF; Tue, 07 May 2024 06:07:00 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-5d42e7ab8a9so1649426a12.3; 
 Tue, 07 May 2024 03:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715076416; x=1715681216; darn=nongnu.org;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/2iTUP4OVkV3uN8OT7VAGdwOlGyXHZ/jGLlnkqkuQkM=;
 b=E/ahEqlCdlYNISfcTd93GFuzBFUr8nNL7V2ktT01aizWEVQgcjOe+HlXSL7P5vDv8s
 GCWLeslhEIp6lN4s+0DA1LjY3m9qwpAvmGVAJSxkW4TCfrOKejGTduZ2Q0BR8O3mb2oG
 Rpi3oH/ddwpqGvVLrUu/iNgpSeCkau/EviUPJ7sdt4cJU+iUdJuiFLivYdxMxMODNq1b
 gyd0unavz1Gwa8aYGhyK2oV/U4jPqzJxSgsH/p8E4XztOLAl2oroR6fbXspu0bD0bMEV
 HJATSlLzsxBmbTcLHLG1RAhGPLfxhdT9A2heEeBOBsBaupAWpZzvrcj05mrV8DIwx03V
 dfVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715076416; x=1715681216;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=/2iTUP4OVkV3uN8OT7VAGdwOlGyXHZ/jGLlnkqkuQkM=;
 b=iD4TUleRJC1mD/hQEksxFDXhpiSEb9zWBkJgdvtl9hu3SGTEGwBg5Zrm2S1noIuc8C
 VyUpPjO9xXVTCWG9FFoMZpI2TPEQRGH7jfhW2CbmhNZV3UEr5uT41P3gZUJh5Bg+IKkn
 G8Nosq1gsuqQASB+j37d+XzG/lKL5LXhPkJxLrLqB8sCEDES3aRFYU9JEQJRTjEoE/Jf
 7URbfQTA7OsgnewqNTrQZFGnfNWywQiaz+O18P1rr/on99PSRQu04bo5mXH2r6NMgcol
 ymDTEr8UME0Q4kCi/P1Aa1Ovf5GVSmXknZ9Gcu2sqXTHie6Ec44ZNllsJHHlsy59/+Tn
 kN2g==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7jWLHfN3ZTSoBW7zRyIOLdvgPoX78E7rJ2zCLPGBUtqXVfUcY4YMYB7ijioPUtQtVd/7gxAwE+0+M63f3A6dEjswsXDzFGzNlHiowSrXN/jl/6sQgAK3V4HI=
X-Gm-Message-State: AOJu0YxmhYwdGfyqYZC1jUH7Frtn/akuRRRN49qkBLGYHlVxWBgZmQZ8
 u0Un+cZzR7DGyJ3QoKdWUjskTnrHjYrAl1QqQ9mhKFdwlbpUc3+e
X-Google-Smtp-Source: AGHT+IFbwrvCHJCz+fktGucyzHx4BLaoftEMcsK6oumJ5Az6KNdHscJ5SFnSN9ItdrTBZTSP7M7RaA==
X-Received: by 2002:a05:6a20:9e47:b0:1af:9fba:e38f with SMTP id
 mt7-20020a056a209e4700b001af9fbae38fmr6868625pzb.40.1715076416420; 
 Tue, 07 May 2024 03:06:56 -0700 (PDT)
Received: from localhost (220-245-239-57.tpgi.com.au. [220.245.239.57])
 by smtp.gmail.com with ESMTPSA id
 pv7-20020a17090b3c8700b002a5f44353d2sm11626282pjb.7.2024.05.07.03.06.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 May 2024 03:06:55 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 07 May 2024 20:06:51 +1000
Message-Id: <D13BUIBZGA7V.LZW3PXGOLMGJ@gmail.com>
Subject: Re: [PATCH v2 18/28] target/ppc/mmu_common.c: Deindent
 ppc_jumbo_xlate()
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, <qemu-devel@nongnu.org>,
 <qemu-ppc@nongnu.org>
Cc: "Daniel Henrique Barboza" <danielhb413@gmail.com>
X-Mailer: aerc 0.17.0
References: <cover.1714606359.git.balaton@eik.bme.hu>
 <a35ae0f50258d4c4b8b6381bec9933f17105091a.1714606359.git.balaton@eik.bme.hu>
In-Reply-To: <a35ae0f50258d4c4b8b6381bec9933f17105091a.1714606359.git.balaton@eik.bme.hu>
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x52d.google.com
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

On Thu May 2, 2024 at 9:43 AM AEST, BALATON Zoltan wrote:
> Instead of putting a large block of code in an if, invert the
> condition and return early to be able to deindent the code block.
>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>  target/ppc/mmu_common.c | 319 ++++++++++++++++++++--------------------
>  1 file changed, 159 insertions(+), 160 deletions(-)
>
> diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
> index 28847c32f2..2487b4deff 100644
> --- a/target/ppc/mmu_common.c
> +++ b/target/ppc/mmu_common.c
> @@ -1265,187 +1265,186 @@ static bool ppc_jumbo_xlate(PowerPCCPU *cpu, va=
ddr eaddr,
>          *protp =3D ctx.prot;
>          *psizep =3D TARGET_PAGE_BITS;
>          return true;
> +    } else if (!guest_visible) {
> +        return false;
>      }

Acked-by: Nicholas Piggin <npiggin@gmail.com>

> =20
> -    if (guest_visible) {
> -        log_cpu_state_mask(CPU_LOG_MMU, cs, 0);
> -        if (type =3D=3D ACCESS_CODE) {
> -            switch (ret) {
> -            case -1:
> -                /* No matches in page tables or TLB */
> -                switch (env->mmu_model) {
> -                case POWERPC_MMU_SOFT_6xx:
> -                    cs->exception_index =3D POWERPC_EXCP_IFTLB;
> -                    env->error_code =3D 1 << 18;
> -                    env->spr[SPR_IMISS] =3D eaddr;
> -                    env->spr[SPR_ICMP] =3D 0x80000000 | ctx.ptem;
> -                    goto tlb_miss;
> -                case POWERPC_MMU_SOFT_4xx:
> -                    cs->exception_index =3D POWERPC_EXCP_ITLB;
> -                    env->error_code =3D 0;
> -                    env->spr[SPR_40x_DEAR] =3D eaddr;
> -                    env->spr[SPR_40x_ESR] =3D 0x00000000;
> -                    break;
> -                case POWERPC_MMU_BOOKE206:
> -                    booke206_update_mas_tlb_miss(env, eaddr, 2, mmu_idx)=
;
> -                    /* fall through */
> -                case POWERPC_MMU_BOOKE:
> -                    cs->exception_index =3D POWERPC_EXCP_ITLB;
> -                    env->error_code =3D 0;
> -                    env->spr[SPR_BOOKE_DEAR] =3D eaddr;
> -                    env->spr[SPR_BOOKE_ESR] =3D mmubooke206_esr(mmu_idx,=
 MMU_DATA_LOAD);
> -                    break;
> -                case POWERPC_MMU_REAL:
> -                    cpu_abort(cs, "PowerPC in real mode should never rai=
se "
> -                              "any MMU exceptions\n");
> -                default:
> -                    cpu_abort(cs, "Unknown or invalid MMU model\n");
> -                }
> +    log_cpu_state_mask(CPU_LOG_MMU, cs, 0);
> +    if (type =3D=3D ACCESS_CODE) {
> +        switch (ret) {
> +        case -1:
> +            /* No matches in page tables or TLB */
> +            switch (env->mmu_model) {
> +            case POWERPC_MMU_SOFT_6xx:
> +                cs->exception_index =3D POWERPC_EXCP_IFTLB;
> +                env->error_code =3D 1 << 18;
> +                env->spr[SPR_IMISS] =3D eaddr;
> +                env->spr[SPR_ICMP] =3D 0x80000000 | ctx.ptem;
> +                goto tlb_miss;
> +            case POWERPC_MMU_SOFT_4xx:
> +                cs->exception_index =3D POWERPC_EXCP_ITLB;
> +                env->error_code =3D 0;
> +                env->spr[SPR_40x_DEAR] =3D eaddr;
> +                env->spr[SPR_40x_ESR] =3D 0x00000000;
>                  break;
> -            case -2:
> -                /* Access rights violation */
> -                cs->exception_index =3D POWERPC_EXCP_ISI;
> -                if ((env->mmu_model =3D=3D POWERPC_MMU_BOOKE) ||
> -                    (env->mmu_model =3D=3D POWERPC_MMU_BOOKE206)) {
> -                    env->error_code =3D 0;
> -                } else {
> -                    env->error_code =3D 0x08000000;
> -                }
> +            case POWERPC_MMU_BOOKE206:
> +                booke206_update_mas_tlb_miss(env, eaddr, 2, mmu_idx);
> +                /* fall through */
> +            case POWERPC_MMU_BOOKE:
> +                cs->exception_index =3D POWERPC_EXCP_ITLB;
> +                env->error_code =3D 0;
> +                env->spr[SPR_BOOKE_DEAR] =3D eaddr;
> +                env->spr[SPR_BOOKE_ESR] =3D mmubooke206_esr(mmu_idx, MMU=
_DATA_LOAD);
>                  break;
> -            case -3:
> -                /* No execute protection violation */
> -                if ((env->mmu_model =3D=3D POWERPC_MMU_BOOKE) ||
> -                    (env->mmu_model =3D=3D POWERPC_MMU_BOOKE206)) {
> -                    env->spr[SPR_BOOKE_ESR] =3D 0x00000000;
> -                    env->error_code =3D 0;
> +            case POWERPC_MMU_REAL:
> +                cpu_abort(cs, "PowerPC in real mode should never raise "
> +                              "any MMU exceptions\n");
> +            default:
> +                cpu_abort(cs, "Unknown or invalid MMU model\n");
> +            }
> +            break;
> +        case -2:
> +            /* Access rights violation */
> +            cs->exception_index =3D POWERPC_EXCP_ISI;
> +            if ((env->mmu_model =3D=3D POWERPC_MMU_BOOKE) ||
> +                (env->mmu_model =3D=3D POWERPC_MMU_BOOKE206)) {
> +                env->error_code =3D 0;
> +            } else {
> +                env->error_code =3D 0x08000000;
> +            }
> +            break;
> +        case -3:
> +            /* No execute protection violation */
> +            if ((env->mmu_model =3D=3D POWERPC_MMU_BOOKE) ||
> +                (env->mmu_model =3D=3D POWERPC_MMU_BOOKE206)) {
> +                env->spr[SPR_BOOKE_ESR] =3D 0x00000000;
> +                env->error_code =3D 0;
> +            } else {
> +                env->error_code =3D 0x10000000;
> +            }
> +            cs->exception_index =3D POWERPC_EXCP_ISI;
> +            break;
> +        case -4:
> +            /* Direct store exception */
> +            /* No code fetch is allowed in direct-store areas */
> +            cs->exception_index =3D POWERPC_EXCP_ISI;
> +            if ((env->mmu_model =3D=3D POWERPC_MMU_BOOKE) ||
> +                (env->mmu_model =3D=3D POWERPC_MMU_BOOKE206)) {
> +                env->error_code =3D 0;
> +            } else {
> +                env->error_code =3D 0x10000000;
> +            }
> +            break;
> +        }
> +    } else {
> +        switch (ret) {
> +        case -1:
> +            /* No matches in page tables or TLB */
> +            switch (env->mmu_model) {
> +            case POWERPC_MMU_SOFT_6xx:
> +                if (access_type =3D=3D MMU_DATA_STORE) {
> +                    cs->exception_index =3D POWERPC_EXCP_DSTLB;
> +                    env->error_code =3D 1 << 16;
>                  } else {
> -                    env->error_code =3D 0x10000000;
> +                    cs->exception_index =3D POWERPC_EXCP_DLTLB;
> +                    env->error_code =3D 0;
>                  }
> -                cs->exception_index =3D POWERPC_EXCP_ISI;
> +                env->spr[SPR_DMISS] =3D eaddr;
> +                env->spr[SPR_DCMP] =3D 0x80000000 | ctx.ptem;
> +            tlb_miss:
> +                env->error_code |=3D ctx.key << 19;
> +                env->spr[SPR_HASH1] =3D ppc_hash32_hpt_base(cpu) +
> +                  get_pteg_offset32(cpu, ctx.hash[0]);
> +                env->spr[SPR_HASH2] =3D ppc_hash32_hpt_base(cpu) +
> +                  get_pteg_offset32(cpu, ctx.hash[1]);
>                  break;
> -            case -4:
> -                /* Direct store exception */
> -                /* No code fetch is allowed in direct-store areas */
> -                cs->exception_index =3D POWERPC_EXCP_ISI;
> -                if ((env->mmu_model =3D=3D POWERPC_MMU_BOOKE) ||
> -                    (env->mmu_model =3D=3D POWERPC_MMU_BOOKE206)) {
> -                    env->error_code =3D 0;
> +            case POWERPC_MMU_SOFT_4xx:
> +                cs->exception_index =3D POWERPC_EXCP_DTLB;
> +                env->error_code =3D 0;
> +                env->spr[SPR_40x_DEAR] =3D eaddr;
> +                if (access_type =3D=3D MMU_DATA_STORE) {
> +                    env->spr[SPR_40x_ESR] =3D 0x00800000;
>                  } else {
> -                    env->error_code =3D 0x10000000;
> +                    env->spr[SPR_40x_ESR] =3D 0x00000000;
>                  }
>                  break;
> -            }
> -        } else {
> -            switch (ret) {
> -            case -1:
> -                /* No matches in page tables or TLB */
> -                switch (env->mmu_model) {
> -                case POWERPC_MMU_SOFT_6xx:
> -                    if (access_type =3D=3D MMU_DATA_STORE) {
> -                        cs->exception_index =3D POWERPC_EXCP_DSTLB;
> -                        env->error_code =3D 1 << 16;
> -                    } else {
> -                        cs->exception_index =3D POWERPC_EXCP_DLTLB;
> -                        env->error_code =3D 0;
> -                    }
> -                    env->spr[SPR_DMISS] =3D eaddr;
> -                    env->spr[SPR_DCMP] =3D 0x80000000 | ctx.ptem;
> -                tlb_miss:
> -                    env->error_code |=3D ctx.key << 19;
> -                    env->spr[SPR_HASH1] =3D ppc_hash32_hpt_base(cpu) +
> -                        get_pteg_offset32(cpu, ctx.hash[0]);
> -                    env->spr[SPR_HASH2] =3D ppc_hash32_hpt_base(cpu) +
> -                        get_pteg_offset32(cpu, ctx.hash[1]);
> -                    break;
> -                case POWERPC_MMU_SOFT_4xx:
> -                    cs->exception_index =3D POWERPC_EXCP_DTLB;
> -                    env->error_code =3D 0;
> -                    env->spr[SPR_40x_DEAR] =3D eaddr;
> -                    if (access_type =3D=3D MMU_DATA_STORE) {
> -                        env->spr[SPR_40x_ESR] =3D 0x00800000;
> -                    } else {
> -                        env->spr[SPR_40x_ESR] =3D 0x00000000;
> -                    }
> -                    break;
> -                case POWERPC_MMU_BOOKE206:
> -                    booke206_update_mas_tlb_miss(env, eaddr, access_type=
, mmu_idx);
> -                    /* fall through */
> -                case POWERPC_MMU_BOOKE:
> -                    cs->exception_index =3D POWERPC_EXCP_DTLB;
> -                    env->error_code =3D 0;
> -                    env->spr[SPR_BOOKE_DEAR] =3D eaddr;
> -                    env->spr[SPR_BOOKE_ESR] =3D mmubooke206_esr(mmu_idx,=
 access_type);
> -                    break;
> -                case POWERPC_MMU_REAL:
> -                    cpu_abort(cs, "PowerPC in real mode should never rai=
se "
> +            case POWERPC_MMU_BOOKE206:
> +                booke206_update_mas_tlb_miss(env, eaddr, access_type, mm=
u_idx);
> +                /* fall through */
> +            case POWERPC_MMU_BOOKE:
> +                cs->exception_index =3D POWERPC_EXCP_DTLB;
> +                env->error_code =3D 0;
> +                env->spr[SPR_BOOKE_DEAR] =3D eaddr;
> +                env->spr[SPR_BOOKE_ESR] =3D mmubooke206_esr(mmu_idx, acc=
ess_type);
> +                break;
> +            case POWERPC_MMU_REAL:
> +                cpu_abort(cs, "PowerPC in real mode should never raise "
>                                "any MMU exceptions\n");
> -                default:
> -                    cpu_abort(cs, "Unknown or invalid MMU model\n");
> +            default:
> +                cpu_abort(cs, "Unknown or invalid MMU model\n");
> +            }
> +            break;
> +        case -2:
> +            /* Access rights violation */
> +            cs->exception_index =3D POWERPC_EXCP_DSI;
> +            env->error_code =3D 0;
> +            if (env->mmu_model =3D=3D POWERPC_MMU_SOFT_4xx) {
> +                env->spr[SPR_40x_DEAR] =3D eaddr;
> +                if (access_type =3D=3D MMU_DATA_STORE) {
> +                    env->spr[SPR_40x_ESR] |=3D 0x00800000;
>                  }
> +            } else if ((env->mmu_model =3D=3D POWERPC_MMU_BOOKE) ||
> +                       (env->mmu_model =3D=3D POWERPC_MMU_BOOKE206)) {
> +                env->spr[SPR_BOOKE_DEAR] =3D eaddr;
> +                env->spr[SPR_BOOKE_ESR] =3D mmubooke206_esr(mmu_idx, acc=
ess_type);
> +            } else {
> +                env->spr[SPR_DAR] =3D eaddr;
> +                if (access_type =3D=3D MMU_DATA_STORE) {
> +                    env->spr[SPR_DSISR] =3D 0x0A000000;
> +                } else {
> +                    env->spr[SPR_DSISR] =3D 0x08000000;
> +                }
> +            }
> +            break;
> +        case -4:
> +            /* Direct store exception */
> +            switch (type) {
> +            case ACCESS_FLOAT:
> +                /* Floating point load/store */
> +                cs->exception_index =3D POWERPC_EXCP_ALIGN;
> +                env->error_code =3D POWERPC_EXCP_ALIGN_FP;
> +                env->spr[SPR_DAR] =3D eaddr;
>                  break;
> -            case -2:
> -                /* Access rights violation */
> +            case ACCESS_RES:
> +                /* lwarx, ldarx or stwcx. */
>                  cs->exception_index =3D POWERPC_EXCP_DSI;
>                  env->error_code =3D 0;
> -                if (env->mmu_model =3D=3D POWERPC_MMU_SOFT_4xx) {
> -                    env->spr[SPR_40x_DEAR] =3D eaddr;
> -                    if (access_type =3D=3D MMU_DATA_STORE) {
> -                        env->spr[SPR_40x_ESR] |=3D 0x00800000;
> -                    }
> -                } else if ((env->mmu_model =3D=3D POWERPC_MMU_BOOKE) ||
> -                           (env->mmu_model =3D=3D POWERPC_MMU_BOOKE206))=
 {
> -                    env->spr[SPR_BOOKE_DEAR] =3D eaddr;
> -                    env->spr[SPR_BOOKE_ESR] =3D mmubooke206_esr(mmu_idx,=
 access_type);
> +                env->spr[SPR_DAR] =3D eaddr;
> +                if (access_type =3D=3D MMU_DATA_STORE) {
> +                    env->spr[SPR_DSISR] =3D 0x06000000;
>                  } else {
> -                    env->spr[SPR_DAR] =3D eaddr;
> -                    if (access_type =3D=3D MMU_DATA_STORE) {
> -                        env->spr[SPR_DSISR] =3D 0x0A000000;
> -                    } else {
> -                        env->spr[SPR_DSISR] =3D 0x08000000;
> -                    }
> +                    env->spr[SPR_DSISR] =3D 0x04000000;
>                  }
>                  break;
> -            case -4:
> -                /* Direct store exception */
> -                switch (type) {
> -                case ACCESS_FLOAT:
> -                    /* Floating point load/store */
> -                    cs->exception_index =3D POWERPC_EXCP_ALIGN;
> -                    env->error_code =3D POWERPC_EXCP_ALIGN_FP;
> -                    env->spr[SPR_DAR] =3D eaddr;
> -                    break;
> -                case ACCESS_RES:
> -                    /* lwarx, ldarx or stwcx. */
> -                    cs->exception_index =3D POWERPC_EXCP_DSI;
> -                    env->error_code =3D 0;
> -                    env->spr[SPR_DAR] =3D eaddr;
> -                    if (access_type =3D=3D MMU_DATA_STORE) {
> -                        env->spr[SPR_DSISR] =3D 0x06000000;
> -                    } else {
> -                        env->spr[SPR_DSISR] =3D 0x04000000;
> -                    }
> -                    break;
> -                case ACCESS_EXT:
> -                    /* eciwx or ecowx */
> -                    cs->exception_index =3D POWERPC_EXCP_DSI;
> -                    env->error_code =3D 0;
> -                    env->spr[SPR_DAR] =3D eaddr;
> -                    if (access_type =3D=3D MMU_DATA_STORE) {
> -                        env->spr[SPR_DSISR] =3D 0x06100000;
> -                    } else {
> -                        env->spr[SPR_DSISR] =3D 0x04100000;
> -                    }
> -                    break;
> -                default:
> -                    printf("DSI: invalid exception (%d)\n", ret);
> -                    cs->exception_index =3D POWERPC_EXCP_PROGRAM;
> -                    env->error_code =3D
> -                        POWERPC_EXCP_INVAL | POWERPC_EXCP_INVAL_INVAL;
> -                    env->spr[SPR_DAR] =3D eaddr;
> -                    break;
> +            case ACCESS_EXT:
> +                /* eciwx or ecowx */
> +                cs->exception_index =3D POWERPC_EXCP_DSI;
> +                env->error_code =3D 0;
> +                env->spr[SPR_DAR] =3D eaddr;
> +                if (access_type =3D=3D MMU_DATA_STORE) {
> +                    env->spr[SPR_DSISR] =3D 0x06100000;
> +                } else {
> +                    env->spr[SPR_DSISR] =3D 0x04100000;
>                  }
>                  break;
> +            default:
> +                printf("DSI: invalid exception (%d)\n", ret);
> +                cs->exception_index =3D POWERPC_EXCP_PROGRAM;
> +                env->error_code =3D POWERPC_EXCP_INVAL | POWERPC_EXCP_IN=
VAL_INVAL;
> +                env->spr[SPR_DAR] =3D eaddr;
> +                break;
>              }
> +            break;
>          }
>      }
>      return false;


