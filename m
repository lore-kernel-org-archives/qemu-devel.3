Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A26B9C10F1A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 12:19:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4Jmw-00050W-9W; Tue, 07 May 2024 08:19:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s4Jlj-0004I1-FF; Tue, 07 May 2024 08:18:11 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s4Jlg-0001VJ-IS; Tue, 07 May 2024 08:18:02 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-53fbf2c42bfso2347583a12.3; 
 Tue, 07 May 2024 05:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715084276; x=1715689076; darn=nongnu.org;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sNav9jDnVxkj1tuQ1/mJWKZNSeCyIz29RX8l+JkSN+g=;
 b=EP19bqJ9yAHFVsAMvQ0TWHcXfh92hVHwXuBIn0LDDbkzWowpUSVrCZWdSMPTyh0z3o
 fT4YtlggycoSDec+c6bG2IFdw2tWJM0tMXbSLAY1mtndbVsPTTviOBDxU/BXrlGridq1
 QbEptURwqkSNLnhW8bmN54hxcjOBFA7SWXilpkkrz6ChYKkaKHrIwxEac0PT1MRfHFIZ
 NkT9xtpC3596H2OYiyGS5SzBZSUNuzDPZHeBTU6Agbinw2vUatrK2IpH/iX+lb1aiIHZ
 ELiJXxI6vvPOjqTBd6rDIc1J7HCv7sZ4uwEoKiQjzinGCoe38j7MvCfD8wgqfD5lqPdg
 RAXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715084276; x=1715689076;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=sNav9jDnVxkj1tuQ1/mJWKZNSeCyIz29RX8l+JkSN+g=;
 b=jgbvcsqTNiIACDFx6z8I+pD3un1asS7G6VYkClny1+W7Ywk59Wv9QHmCT7jkMtxH2A
 5EJO22Trc4sC5+VfMcK2ZuTnJg1fs2IKHLyKUhyVz2W35SF4lhHP7WlgTwfvEkyQrVTc
 OdOeFjuaOp20Bb6hf8CX4KthsKnqerHDr6+sNBhGEoDUE60mQADSwbL/t1JCnv/gzEBW
 nois8JxeXVXV7U4PkjMAjp+JuekVMsnQdAEk4EfPxvr0pyj6rcx9142L0gx4kbFOx9Zu
 ZKLoqQ5bDnxiP8UO8osTPS5QBMRyxqghxploAtdzN1EveiQt9UPYleOvSkQ/006/W2Cq
 kzsg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU6yahCe03URCNvlAf5SXVJZNZf64Mh2jQi/ndEgZfkzpiH42mUR0sDr/XrV/rL/mTMkTpuwWfz1x0wxtWU/rX9l5O01/wDF+o9amBUjK24iYvOb2N7VsMdB/4=
X-Gm-Message-State: AOJu0Yy+w6ci0Y/xj/CTfXkR+AfIgG9o/pLsCRupxaZMtF9AKObFq9NF
 I5r1bXBU17ugQ1XoLq6g+ADzlGCvCkOGohp0o/SdaUeyA4m7bO4b
X-Google-Smtp-Source: AGHT+IFA4oOCoNrtqP67VWmEoeD9tF13JXqBcLmPqX1XoCP/3M5qvxWd1UgLlOowcdrDzVBl1Px38Q==
X-Received: by 2002:a17:90a:f0cd:b0:2a5:8ff:9d1 with SMTP id
 fa13-20020a17090af0cd00b002a508ff09d1mr11687898pjb.14.1715084276431; 
 Tue, 07 May 2024 05:17:56 -0700 (PDT)
Received: from localhost (220-245-239-57.tpgi.com.au. [220.245.239.57])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2b5d50a4a2bsm872020a91.0.2024.05.07.05.17.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 May 2024 05:17:56 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 07 May 2024 22:17:52 +1000
Message-Id: <D13EMTIRPDQJ.2LCAHIOTN0W5N@gmail.com>
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, <qemu-devel@nongnu.org>,
 <qemu-ppc@nongnu.org>
Cc: "Daniel Henrique Barboza" <danielhb413@gmail.com>
Subject: Re: [PATCH v2 26/28] target/ppc/mmu_common.c: Move BookE MMU
 functions together
X-Mailer: aerc 0.17.0
References: <cover.1714606359.git.balaton@eik.bme.hu>
 <d5d70791bdf598cd28ee70fd058f51c257a2b969.1714606359.git.balaton@eik.bme.hu>
In-Reply-To: <d5d70791bdf598cd28ee70fd058f51c257a2b969.1714606359.git.balaton@eik.bme.hu>
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x52a.google.com
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

What do you think about adding mmu-book3e.c instead?

Thanks,
Nick

On Thu May 2, 2024 at 9:43 AM AEST, BALATON Zoltan wrote:
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>  target/ppc/mmu_common.c | 300 ++++++++++++++++++++--------------------
>  1 file changed, 150 insertions(+), 150 deletions(-)
>
> diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
> index b76611da80..204b8af455 100644
> --- a/target/ppc/mmu_common.c
> +++ b/target/ppc/mmu_common.c
> @@ -910,6 +910,156 @@ found_tlb:
>      return ret;
>  }
> =20
> +static void booke206_update_mas_tlb_miss(CPUPPCState *env, target_ulong =
address,
> +                                         MMUAccessType access_type, int =
mmu_idx)
> +{
> +    uint32_t epid;
> +    bool as, pr;
> +    uint32_t missed_tid =3D 0;
> +    bool use_epid =3D mmubooke206_get_as(env, mmu_idx, &epid, &as, &pr);
> +
> +    if (access_type =3D=3D MMU_INST_FETCH) {
> +        as =3D FIELD_EX64(env->msr, MSR, IR);
> +    }
> +    env->spr[SPR_BOOKE_MAS0] =3D env->spr[SPR_BOOKE_MAS4] & MAS4_TLBSELD=
_MASK;
> +    env->spr[SPR_BOOKE_MAS1] =3D env->spr[SPR_BOOKE_MAS4] & MAS4_TSIZED_=
MASK;
> +    env->spr[SPR_BOOKE_MAS2] =3D env->spr[SPR_BOOKE_MAS4] & MAS4_WIMGED_=
MASK;
> +    env->spr[SPR_BOOKE_MAS3] =3D 0;
> +    env->spr[SPR_BOOKE_MAS6] =3D 0;
> +    env->spr[SPR_BOOKE_MAS7] =3D 0;
> +
> +    /* AS */
> +    if (as) {
> +        env->spr[SPR_BOOKE_MAS1] |=3D MAS1_TS;
> +        env->spr[SPR_BOOKE_MAS6] |=3D MAS6_SAS;
> +    }
> +
> +    env->spr[SPR_BOOKE_MAS1] |=3D MAS1_VALID;
> +    env->spr[SPR_BOOKE_MAS2] |=3D address & MAS2_EPN_MASK;
> +
> +    if (!use_epid) {
> +        switch (env->spr[SPR_BOOKE_MAS4] & MAS4_TIDSELD_PIDZ) {
> +        case MAS4_TIDSELD_PID0:
> +            missed_tid =3D env->spr[SPR_BOOKE_PID];
> +            break;
> +        case MAS4_TIDSELD_PID1:
> +            missed_tid =3D env->spr[SPR_BOOKE_PID1];
> +            break;
> +        case MAS4_TIDSELD_PID2:
> +            missed_tid =3D env->spr[SPR_BOOKE_PID2];
> +            break;
> +        }
> +        env->spr[SPR_BOOKE_MAS6] |=3D env->spr[SPR_BOOKE_PID] << 16;
> +    } else {
> +        missed_tid =3D epid;
> +        env->spr[SPR_BOOKE_MAS6] |=3D missed_tid << 16;
> +    }
> +    env->spr[SPR_BOOKE_MAS1] |=3D (missed_tid << MAS1_TID_SHIFT);
> +
> +
> +    /* next victim logic */
> +    env->spr[SPR_BOOKE_MAS0] |=3D env->last_way << MAS0_ESEL_SHIFT;
> +    env->last_way++;
> +    env->last_way &=3D booke206_tlb_ways(env, 0) - 1;
> +    env->spr[SPR_BOOKE_MAS0] |=3D env->last_way << MAS0_NV_SHIFT;
> +}
> +
> +static bool ppc_booke_xlate(PowerPCCPU *cpu, vaddr eaddr,
> +                            MMUAccessType access_type,
> +                            hwaddr *raddrp, int *psizep, int *protp,
> +                            int mmu_idx, bool guest_visible)
> +{
> +    CPUState *cs =3D CPU(cpu);
> +    CPUPPCState *env =3D &cpu->env;
> +    mmu_ctx_t ctx;
> +    int ret;
> +
> +    if (env->mmu_model =3D=3D POWERPC_MMU_BOOKE206) {
> +        ret =3D mmubooke206_get_physical_address(env, &ctx, eaddr, acces=
s_type,
> +                                               mmu_idx);
> +    } else {
> +        ret =3D mmubooke_get_physical_address(env, &ctx, eaddr, access_t=
ype);
> +    }
> +    if (ret =3D=3D 0) {
> +        *raddrp =3D ctx.raddr;
> +        *protp =3D ctx.prot;
> +        *psizep =3D TARGET_PAGE_BITS;
> +        return true;
> +    } else if (!guest_visible) {
> +        return false;
> +    }
> +
> +    log_cpu_state_mask(CPU_LOG_MMU, cs, 0);
> +    env->error_code =3D 0;
> +    if (env->mmu_model =3D=3D POWERPC_MMU_BOOKE206 && ret =3D=3D -1) {
> +        booke206_update_mas_tlb_miss(env, eaddr, access_type, mmu_idx);
> +    }
> +    if (access_type =3D=3D MMU_INST_FETCH) {
> +        if (ret =3D=3D -1) {
> +            /* No matches in page tables or TLB */
> +            cs->exception_index =3D POWERPC_EXCP_ITLB;
> +            env->spr[SPR_BOOKE_DEAR] =3D eaddr;
> +            env->spr[SPR_BOOKE_ESR] =3D mmubooke206_esr(mmu_idx, access_=
type);
> +        } else {
> +            cs->exception_index =3D POWERPC_EXCP_ISI;
> +            if (ret =3D=3D -3) {
> +                /* No execute protection violation */
> +                env->spr[SPR_BOOKE_ESR] =3D 0;
> +            }
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
> +            break;
> +        case ACCESS_RES:
> +            /* lwarx, ldarx or stwcx. */
> +            cs->exception_index =3D POWERPC_EXCP_DSI;
> +            if (access_type =3D=3D MMU_DATA_STORE) {
> +                env->spr[SPR_DSISR] =3D 0x06000000;
> +            } else {
> +                env->spr[SPR_DSISR] =3D 0x04000000;
> +            }
> +            break;
> +        case ACCESS_EXT:
> +            /* eciwx or ecowx */
> +            cs->exception_index =3D POWERPC_EXCP_DSI;
> +            if (access_type =3D=3D MMU_DATA_STORE) {
> +                env->spr[SPR_DSISR] =3D 0x06100000;
> +            } else {
> +                env->spr[SPR_DSISR] =3D 0x04100000;
> +            }
> +            break;
> +        default:
> +            printf("DSI: invalid exception (%d)\n", ret);
> +            cs->exception_index =3D POWERPC_EXCP_PROGRAM;
> +            env->error_code =3D POWERPC_EXCP_INVAL | POWERPC_EXCP_INVAL_=
INVAL;
> +            break;
> +        }
> +    }
> +    return false;
> +}
> +
>  static const char *book3e_tsize_to_str[32] =3D {
>      "1K", "2K", "4K", "8K", "16K", "32K", "64K", "128K", "256K", "512K",
>      "1M", "2M", "4M", "8M", "16M", "32M", "64M", "128M", "256M", "512M",
> @@ -1181,156 +1331,6 @@ static int get_physical_address_wtlb(CPUPPCState =
*env, mmu_ctx_t *ctx,
>      }
>  }
> =20
> -static void booke206_update_mas_tlb_miss(CPUPPCState *env, target_ulong =
address,
> -                                         MMUAccessType access_type, int =
mmu_idx)
> -{
> -    uint32_t epid;
> -    bool as, pr;
> -    uint32_t missed_tid =3D 0;
> -    bool use_epid =3D mmubooke206_get_as(env, mmu_idx, &epid, &as, &pr);
> -
> -    if (access_type =3D=3D MMU_INST_FETCH) {
> -        as =3D FIELD_EX64(env->msr, MSR, IR);
> -    }
> -    env->spr[SPR_BOOKE_MAS0] =3D env->spr[SPR_BOOKE_MAS4] & MAS4_TLBSELD=
_MASK;
> -    env->spr[SPR_BOOKE_MAS1] =3D env->spr[SPR_BOOKE_MAS4] & MAS4_TSIZED_=
MASK;
> -    env->spr[SPR_BOOKE_MAS2] =3D env->spr[SPR_BOOKE_MAS4] & MAS4_WIMGED_=
MASK;
> -    env->spr[SPR_BOOKE_MAS3] =3D 0;
> -    env->spr[SPR_BOOKE_MAS6] =3D 0;
> -    env->spr[SPR_BOOKE_MAS7] =3D 0;
> -
> -    /* AS */
> -    if (as) {
> -        env->spr[SPR_BOOKE_MAS1] |=3D MAS1_TS;
> -        env->spr[SPR_BOOKE_MAS6] |=3D MAS6_SAS;
> -    }
> -
> -    env->spr[SPR_BOOKE_MAS1] |=3D MAS1_VALID;
> -    env->spr[SPR_BOOKE_MAS2] |=3D address & MAS2_EPN_MASK;
> -
> -    if (!use_epid) {
> -        switch (env->spr[SPR_BOOKE_MAS4] & MAS4_TIDSELD_PIDZ) {
> -        case MAS4_TIDSELD_PID0:
> -            missed_tid =3D env->spr[SPR_BOOKE_PID];
> -            break;
> -        case MAS4_TIDSELD_PID1:
> -            missed_tid =3D env->spr[SPR_BOOKE_PID1];
> -            break;
> -        case MAS4_TIDSELD_PID2:
> -            missed_tid =3D env->spr[SPR_BOOKE_PID2];
> -            break;
> -        }
> -        env->spr[SPR_BOOKE_MAS6] |=3D env->spr[SPR_BOOKE_PID] << 16;
> -    } else {
> -        missed_tid =3D epid;
> -        env->spr[SPR_BOOKE_MAS6] |=3D missed_tid << 16;
> -    }
> -    env->spr[SPR_BOOKE_MAS1] |=3D (missed_tid << MAS1_TID_SHIFT);
> -
> -
> -    /* next victim logic */
> -    env->spr[SPR_BOOKE_MAS0] |=3D env->last_way << MAS0_ESEL_SHIFT;
> -    env->last_way++;
> -    env->last_way &=3D booke206_tlb_ways(env, 0) - 1;
> -    env->spr[SPR_BOOKE_MAS0] |=3D env->last_way << MAS0_NV_SHIFT;
> -}
> -
> -static bool ppc_booke_xlate(PowerPCCPU *cpu, vaddr eaddr,
> -                            MMUAccessType access_type,
> -                            hwaddr *raddrp, int *psizep, int *protp,
> -                            int mmu_idx, bool guest_visible)
> -{
> -    CPUState *cs =3D CPU(cpu);
> -    CPUPPCState *env =3D &cpu->env;
> -    mmu_ctx_t ctx;
> -    int ret;
> -
> -    if (env->mmu_model =3D=3D POWERPC_MMU_BOOKE206) {
> -        ret =3D mmubooke206_get_physical_address(env, &ctx, eaddr, acces=
s_type,
> -                                               mmu_idx);
> -    } else {
> -        ret =3D mmubooke_get_physical_address(env, &ctx, eaddr, access_t=
ype);
> -    }
> -    if (ret =3D=3D 0) {
> -        *raddrp =3D ctx.raddr;
> -        *protp =3D ctx.prot;
> -        *psizep =3D TARGET_PAGE_BITS;
> -        return true;
> -    } else if (!guest_visible) {
> -        return false;
> -    }
> -
> -    log_cpu_state_mask(CPU_LOG_MMU, cs, 0);
> -    env->error_code =3D 0;
> -    if (env->mmu_model =3D=3D POWERPC_MMU_BOOKE206 && ret =3D=3D -1) {
> -        booke206_update_mas_tlb_miss(env, eaddr, access_type, mmu_idx);
> -    }
> -    if (access_type =3D=3D MMU_INST_FETCH) {
> -        if (ret =3D=3D -1) {
> -            /* No matches in page tables or TLB */
> -            cs->exception_index =3D POWERPC_EXCP_ITLB;
> -            env->spr[SPR_BOOKE_DEAR] =3D eaddr;
> -            env->spr[SPR_BOOKE_ESR] =3D mmubooke206_esr(mmu_idx, access_=
type);
> -        } else {
> -            cs->exception_index =3D POWERPC_EXCP_ISI;
> -            if (ret =3D=3D -3) {
> -                /* No execute protection violation */
> -                env->spr[SPR_BOOKE_ESR] =3D 0;
> -            }
> -        }
> -        return false;
> -    }
> -
> -    switch (ret) {
> -    case -1:
> -        /* No matches in page tables or TLB */
> -        cs->exception_index =3D POWERPC_EXCP_DTLB;
> -        env->spr[SPR_BOOKE_DEAR] =3D eaddr;
> -        env->spr[SPR_BOOKE_ESR] =3D mmubooke206_esr(mmu_idx, access_type=
);
> -        break;
> -    case -2:
> -        /* Access rights violation */
> -        cs->exception_index =3D POWERPC_EXCP_DSI;
> -        env->spr[SPR_BOOKE_DEAR] =3D eaddr;
> -        env->spr[SPR_BOOKE_ESR] =3D mmubooke206_esr(mmu_idx, access_type=
);
> -        break;
> -    case -4:
> -        /* Direct store exception */
> -        env->spr[SPR_DAR] =3D eaddr;
> -        switch (env->access_type) {
> -        case ACCESS_FLOAT:
> -            /* Floating point load/store */
> -            cs->exception_index =3D POWERPC_EXCP_ALIGN;
> -            env->error_code =3D POWERPC_EXCP_ALIGN_FP;
> -            break;
> -        case ACCESS_RES:
> -            /* lwarx, ldarx or stwcx. */
> -            cs->exception_index =3D POWERPC_EXCP_DSI;
> -            if (access_type =3D=3D MMU_DATA_STORE) {
> -                env->spr[SPR_DSISR] =3D 0x06000000;
> -            } else {
> -                env->spr[SPR_DSISR] =3D 0x04000000;
> -            }
> -            break;
> -        case ACCESS_EXT:
> -            /* eciwx or ecowx */
> -            cs->exception_index =3D POWERPC_EXCP_DSI;
> -            if (access_type =3D=3D MMU_DATA_STORE) {
> -                env->spr[SPR_DSISR] =3D 0x06100000;
> -            } else {
> -                env->spr[SPR_DSISR] =3D 0x04100000;
> -            }
> -            break;
> -        default:
> -            printf("DSI: invalid exception (%d)\n", ret);
> -            cs->exception_index =3D POWERPC_EXCP_PROGRAM;
> -            env->error_code =3D POWERPC_EXCP_INVAL | POWERPC_EXCP_INVAL_=
INVAL;
> -            break;
> -        }
> -    }
> -    return false;
> -}
> -
>  /* Perform address translation */
>  /* TODO: Split this by mmu_model. */
>  static bool ppc_jumbo_xlate(PowerPCCPU *cpu, vaddr eaddr,


