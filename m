Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16C6CC3DA63
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 05:23:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sW7yu-0006uA-If; Tue, 23 Jul 2024 01:22:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sW7yr-0006t9-BL; Tue, 23 Jul 2024 01:22:33 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sW7yo-0005rM-5e; Tue, 23 Jul 2024 01:22:33 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-2cb4c584029so2704567a91.3; 
 Mon, 22 Jul 2024 22:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721712147; x=1722316947; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=prRHyE+hpd7TRrywu6pxp4Cv5famAeRg1i9MKrr73BA=;
 b=HTGJZNXSFQGy2XvOF/eo4rDzIhK1sS8wPEpAbDoR23z/+c6skq9nnm5AYcvECFnU1g
 gUqo37znhwmEgGi83202oNE+KLgI2aowTsSQ3RJSCP1W6F2HcIyl+9FVdToZanULu1aQ
 qz7kdFrjs41kYM3j1D3rmlKa48SZb4E949XHlayT4kJASBhG4drxEYaCI4G88ro7w/na
 6c0waRds2jEEXqRMDroOVUT0P3JkUz0lVSEyFw/sEMGkAme7d8IvT0mriUeNTl9Vu7gZ
 FQD+WwTQl7hplq5+Iz8JHR00GbxwsXBUAi3zd1kAKMW5hV03glE/1j95r8gVqRmGrOuh
 BbLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721712147; x=1722316947;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=prRHyE+hpd7TRrywu6pxp4Cv5famAeRg1i9MKrr73BA=;
 b=dP7aztZ8ALsFIJ16BAZGGN89tBILOh2I05keVH03YUOcFxB4+8JPgjqq4yqjssxtW0
 goDkL4W07g47v7Wu+JWDrLgTXpml0W9ET0NoUsoXH67BBl7He72DNVB26wLvwzBT4ffV
 ceEOB73SPlwSRloQ3Ld6+swcBNA4afVpjsgiNRwDloF46Deo4XReqhU9CXt+ayfJKu2z
 fiwF/hdfMd17VOLaJNBJox4hrV7EteCRY+0P8E6yfvm3EHmQObGMPdLj++2l4HhgtWyu
 WfWL7T+UP3a/Hx8C8rYxVGDSSoLsv7Vdza1uYeT8rCPJk0ZCFnh2n2Ku1X9oov8x2sjX
 sKcQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVUzUrdtXPueNjL0Geufnde0Hr/DuyODniYFpX5LbOtjBS0HdwuwtwKkKRgun+H4tJyljYOkFDMJGn+/U0KhL/L4id9
X-Gm-Message-State: AOJu0YzC2rTdFj6k4gxZw5/HQxycq3vfUEJ2fuoJOES4o5YDYnZxfm4n
 3w7P87iHFQYHzFu1wEWSc7CC386j1LomBXYG6HsHccZvC7wBToqj
X-Google-Smtp-Source: AGHT+IHd1BPsFExwJOzGWK6N7tNOhtSg6F+BXwYn4g9x/GM3Y2no9ezSbakw9lXohWX46zi2kWGSBA==
X-Received: by 2002:a17:90b:1b01:b0:2cb:4b08:1bbe with SMTP id
 98e67ed59e1d1-2cd274a8b78mr5342471a91.30.1721712147433; 
 Mon, 22 Jul 2024 22:22:27 -0700 (PDT)
Received: from localhost ([203.220.44.216]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ccf7c7244esm8206834a91.29.2024.07.22.22.22.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jul 2024 22:22:27 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 23 Jul 2024 15:22:22 +1000
Message-Id: <D2WO0N28SBFF.DGV2VYFLHR8K@gmail.com>
Cc: <qemu-devel@nongnu.org>, <qemu-ppc@nongnu.org>
Subject: Re: [PATCH v5 1/5] target/ppc: reduce code duplication across
 Power9/10 init code
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Aditya Gupta" <adityag@linux.ibm.com>, "Mahesh J Salgaonkar"
 <mahesh@linux.ibm.com>, "Madhavan Srinivasan" <maddy@linux.ibm.com>,
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, "Harsh Prateek Bora"
 <harshpb@linux.ibm.com>
X-Mailer: aerc 0.18.0
References: <20240606121657.254308-1-adityag@linux.ibm.com>
 <20240606121657.254308-2-adityag@linux.ibm.com>
In-Reply-To: <20240606121657.254308-2-adityag@linux.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x1032.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UPPERCASE_50_75=0.008 autolearn=no autolearn_force=no
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

On Thu Jun 6, 2024 at 10:16 PM AEST, Aditya Gupta wrote:
> From: Harsh Prateek Bora <harshpb@linux.ibm.com>
>
> Power9/10 initialization code consists of a lot of logical OR of
> various flag bits as supported by respective Power platform during its
> initialization, most of which is duplicated and only selected bits are
> added or removed as needed with each new platform support being added.
> Remove the duplicate code and share using common macros.
>
> Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
> ---
>  target/ppc/cpu_init.c | 124 +++++-------------------------------------
>  target/ppc/cpu_init.h |  78 ++++++++++++++++++++++++++
>  2 files changed, 93 insertions(+), 109 deletions(-)
>  create mode 100644 target/ppc/cpu_init.h
>
> diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
> index 01e358a4a5ac..3d8a112935ae 100644
> --- a/target/ppc/cpu_init.c
> +++ b/target/ppc/cpu_init.c
> @@ -51,6 +51,7 @@
>  #include "kvm_ppc.h"
>  #endif
> =20
> +#include "cpu_init.h"
>  /* #define PPC_DEBUG_SPR */
>  /* #define USE_APPLE_GDB */
> =20
> @@ -6508,58 +6509,15 @@ POWERPC_FAMILY(POWER9)(ObjectClass *oc, void *dat=
a)
>      dc->fw_name =3D "PowerPC,POWER9";
>      dc->desc =3D "POWER9";
>      pcc->pvr_match =3D ppc_pvr_match_power9;
> -    pcc->pcr_mask =3D PCR_COMPAT_2_05 | PCR_COMPAT_2_06 | PCR_COMPAT_2_0=
7;
> -    pcc->pcr_supported =3D PCR_COMPAT_3_00 | PCR_COMPAT_2_07 | PCR_COMPA=
T_2_06 |
> -                         PCR_COMPAT_2_05;
> +    pcc->pcr_mask =3D POWERPC_POWER9_PCC_PCR_MASK;
> +    pcc->pcr_supported =3D POWERPC_POWER9_PCC_PCR_SUPPORTED;
>      pcc->init_proc =3D init_proc_POWER9;
>      pcc->check_pow =3D check_pow_nocheck;
>      pcc->check_attn =3D check_attn_hid0_power9;
> -    pcc->insns_flags =3D PPC_INSNS_BASE | PPC_ISEL | PPC_STRING | PPC_MF=
TB |
> -                       PPC_FLOAT | PPC_FLOAT_FSEL | PPC_FLOAT_FRES |
> -                       PPC_FLOAT_FSQRT | PPC_FLOAT_FRSQRTE |
> -                       PPC_FLOAT_FRSQRTES |
> -                       PPC_FLOAT_STFIWX |
> -                       PPC_FLOAT_EXT |
> -                       PPC_CACHE | PPC_CACHE_ICBI | PPC_CACHE_DCBZ |
> -                       PPC_MEM_SYNC | PPC_MEM_EIEIO |
> -                       PPC_MEM_TLBIE | PPC_MEM_TLBSYNC |
> -                       PPC_64B | PPC_64H | PPC_64BX | PPC_ALTIVEC |
> -                       PPC_SEGMENT_64B | PPC_SLBI |
> -                       PPC_POPCNTB | PPC_POPCNTWD |
> -                       PPC_CILDST;
> -    pcc->insns_flags2 =3D PPC2_VSX | PPC2_VSX207 | PPC2_DFP | PPC2_DBRX =
|
> -                        PPC2_PERM_ISA206 | PPC2_DIVE_ISA206 |
> -                        PPC2_ATOMIC_ISA206 | PPC2_FP_CVT_ISA206 |
> -                        PPC2_FP_TST_ISA206 | PPC2_BCTAR_ISA207 |
> -                        PPC2_LSQ_ISA207 | PPC2_ALTIVEC_207 |
> -                        PPC2_ISA205 | PPC2_ISA207S | PPC2_FP_CVT_S64 |
> -                        PPC2_TM | PPC2_ISA300 | PPC2_PRCNTL | PPC2_MEM_L=
WSYNC |
> -                        PPC2_BCDA_ISA206;
> -    pcc->msr_mask =3D (1ull << MSR_SF) |
> -                    (1ull << MSR_HV) |
> -                    (1ull << MSR_TM) |
> -                    (1ull << MSR_VR) |
> -                    (1ull << MSR_VSX) |
> -                    (1ull << MSR_EE) |
> -                    (1ull << MSR_PR) |
> -                    (1ull << MSR_FP) |
> -                    (1ull << MSR_ME) |
> -                    (1ull << MSR_FE0) |
> -                    (1ull << MSR_SE) |
> -                    (1ull << MSR_DE) |
> -                    (1ull << MSR_FE1) |
> -                    (1ull << MSR_IR) |
> -                    (1ull << MSR_DR) |
> -                    (1ull << MSR_PMM) |
> -                    (1ull << MSR_RI) |
> -                    (1ull << MSR_LE);
> -    pcc->lpcr_mask =3D LPCR_VPM1 | LPCR_ISL | LPCR_KBV | LPCR_DPFD |
> -        (LPCR_PECE_U_MASK & LPCR_HVEE) | LPCR_ILE | LPCR_AIL |
> -        LPCR_UPRT | LPCR_EVIRT | LPCR_ONL | LPCR_HR | LPCR_LD |
> -        (LPCR_PECE_L_MASK & (LPCR_PDEE | LPCR_HDEE | LPCR_EEE |
> -                             LPCR_DEE | LPCR_OEE))
> -        | LPCR_MER | LPCR_GTSE | LPCR_TC |
> -        LPCR_HEIC | LPCR_LPES0 | LPCR_HVICE | LPCR_HDICE;
> +    pcc->insns_flags =3D POWERPC_FAMILY_POWER9_INSNS_FLAGS;
> +    pcc->insns_flags2 =3D POWERPC_FAMILY_POWER9_INSNS_FLAGS2;
> +    pcc->msr_mask =3D POWERPC_POWER9_PCC_MSR_MASK;
> +    pcc->lpcr_mask =3D POWERPC_POWER9_PCC_LPCR_MASK;
>      pcc->lpcr_pm =3D LPCR_PDEE | LPCR_HDEE | LPCR_EEE | LPCR_DEE | LPCR_=
OEE;
>      pcc->mmu_model =3D POWERPC_MMU_3_00;
>  #if !defined(CONFIG_USER_ONLY)
> @@ -6572,10 +6530,7 @@ POWERPC_FAMILY(POWER9)(ObjectClass *oc, void *data=
)
>      pcc->excp_model =3D POWERPC_EXCP_POWER9;
>      pcc->bus_model =3D PPC_FLAGS_INPUT_POWER9;
>      pcc->bfd_mach =3D bfd_mach_ppc64;
> -    pcc->flags =3D POWERPC_FLAG_VRE | POWERPC_FLAG_SE |
> -                 POWERPC_FLAG_BE | POWERPC_FLAG_PMM |
> -                 POWERPC_FLAG_BUS_CLK | POWERPC_FLAG_CFAR |
> -                 POWERPC_FLAG_VSX | POWERPC_FLAG_TM | POWERPC_FLAG_SCV;
> +    pcc->flags =3D POWERPC_POWER9_PCC_FLAGS;
>      pcc->l1_dcache_size =3D 0x8000;
>      pcc->l1_icache_size =3D 0x8000;
>  }
> @@ -6688,60 +6643,15 @@ POWERPC_FAMILY(POWER10)(ObjectClass *oc, void *da=
ta)
>      dc->fw_name =3D "PowerPC,POWER10";
>      dc->desc =3D "POWER10";
>      pcc->pvr_match =3D ppc_pvr_match_power10;
> -    pcc->pcr_mask =3D PCR_COMPAT_2_05 | PCR_COMPAT_2_06 | PCR_COMPAT_2_0=
7 |
> -                    PCR_COMPAT_3_00;
> -    pcc->pcr_supported =3D PCR_COMPAT_3_10 | PCR_COMPAT_3_00 | PCR_COMPA=
T_2_07 |
> -                         PCR_COMPAT_2_06 | PCR_COMPAT_2_05;
> +    pcc->pcr_mask =3D POWERPC_POWER10_PCC_PCR_MASK;
> +    pcc->pcr_supported =3D POWERPC_POWER10_PCC_PCR_SUPPORTED;
>      pcc->init_proc =3D init_proc_POWER10;
>      pcc->check_pow =3D check_pow_nocheck;
>      pcc->check_attn =3D check_attn_hid0_power9;
> -    pcc->insns_flags =3D PPC_INSNS_BASE | PPC_ISEL | PPC_STRING | PPC_MF=
TB |
> -                       PPC_FLOAT | PPC_FLOAT_FSEL | PPC_FLOAT_FRES |
> -                       PPC_FLOAT_FSQRT | PPC_FLOAT_FRSQRTE |
> -                       PPC_FLOAT_FRSQRTES |
> -                       PPC_FLOAT_STFIWX |
> -                       PPC_FLOAT_EXT |
> -                       PPC_CACHE | PPC_CACHE_ICBI | PPC_CACHE_DCBZ |
> -                       PPC_MEM_SYNC | PPC_MEM_EIEIO |
> -                       PPC_MEM_TLBIE | PPC_MEM_TLBSYNC |
> -                       PPC_64B | PPC_64H | PPC_64BX | PPC_ALTIVEC |
> -                       PPC_SEGMENT_64B | PPC_SLBI |
> -                       PPC_POPCNTB | PPC_POPCNTWD |
> -                       PPC_CILDST;
> -    pcc->insns_flags2 =3D PPC2_VSX | PPC2_VSX207 | PPC2_DFP | PPC2_DBRX =
|
> -                        PPC2_PERM_ISA206 | PPC2_DIVE_ISA206 |
> -                        PPC2_ATOMIC_ISA206 | PPC2_FP_CVT_ISA206 |
> -                        PPC2_FP_TST_ISA206 | PPC2_BCTAR_ISA207 |
> -                        PPC2_LSQ_ISA207 | PPC2_ALTIVEC_207 |
> -                        PPC2_ISA205 | PPC2_ISA207S | PPC2_FP_CVT_S64 |
> -                        PPC2_ISA300 | PPC2_PRCNTL | PPC2_ISA310 |
> -                        PPC2_MEM_LWSYNC | PPC2_BCDA_ISA206;
> -    pcc->msr_mask =3D (1ull << MSR_SF) |
> -                    (1ull << MSR_HV) |
> -                    (1ull << MSR_VR) |
> -                    (1ull << MSR_VSX) |
> -                    (1ull << MSR_EE) |
> -                    (1ull << MSR_PR) |
> -                    (1ull << MSR_FP) |
> -                    (1ull << MSR_ME) |
> -                    (1ull << MSR_FE0) |
> -                    (1ull << MSR_SE) |
> -                    (1ull << MSR_DE) |
> -                    (1ull << MSR_FE1) |
> -                    (1ull << MSR_IR) |
> -                    (1ull << MSR_DR) |
> -                    (1ull << MSR_PMM) |
> -                    (1ull << MSR_RI) |
> -                    (1ull << MSR_LE);
> -    pcc->lpcr_mask =3D LPCR_VPM1 | LPCR_ISL | LPCR_KBV | LPCR_DPFD |
> -        (LPCR_PECE_U_MASK & LPCR_HVEE) | LPCR_ILE | LPCR_AIL |
> -        LPCR_UPRT | LPCR_EVIRT | LPCR_ONL | LPCR_HR | LPCR_LD |
> -        (LPCR_PECE_L_MASK & (LPCR_PDEE | LPCR_HDEE | LPCR_EEE |
> -                             LPCR_DEE | LPCR_OEE))
> -        | LPCR_MER | LPCR_GTSE | LPCR_TC |
> -        LPCR_HEIC | LPCR_LPES0 | LPCR_HVICE | LPCR_HDICE;
> -    /* DD2 adds an extra HAIL bit */
> -    pcc->lpcr_mask |=3D LPCR_HAIL;
> +    pcc->insns_flags =3D POWERPC_FAMILY_POWER9_INSNS_FLAGS; /* same as P=
9 */
> +    pcc->insns_flags2 =3D POWERPC_FAMILY_POWER10_INSNS_FLAGS2;
> +    pcc->msr_mask =3D POWERPC_POWER10_PCC_MSR_MASK;
> +    pcc->lpcr_mask =3D POWERPC_POWER10_PCC_LPCR_MASK;
> =20
>      pcc->lpcr_pm =3D LPCR_PDEE | LPCR_HDEE | LPCR_EEE | LPCR_DEE | LPCR_=
OEE;
>      pcc->mmu_model =3D POWERPC_MMU_3_00;
> @@ -6754,11 +6664,7 @@ POWERPC_FAMILY(POWER10)(ObjectClass *oc, void *dat=
a)
>      pcc->excp_model =3D POWERPC_EXCP_POWER10;
>      pcc->bus_model =3D PPC_FLAGS_INPUT_POWER9;
>      pcc->bfd_mach =3D bfd_mach_ppc64;
> -    pcc->flags =3D POWERPC_FLAG_VRE | POWERPC_FLAG_SE |
> -                 POWERPC_FLAG_BE | POWERPC_FLAG_PMM |
> -                 POWERPC_FLAG_BUS_CLK | POWERPC_FLAG_CFAR |
> -                 POWERPC_FLAG_VSX | POWERPC_FLAG_SCV |
> -                 POWERPC_FLAG_BHRB;
> +    pcc->flags =3D POWERPC_POWER10_PCC_FLAGS;
>      pcc->l1_dcache_size =3D 0x8000;
>      pcc->l1_icache_size =3D 0x8000;
>  }
> diff --git a/target/ppc/cpu_init.h b/target/ppc/cpu_init.h
> new file mode 100644
> index 000000000000..e04be6a655d8
> --- /dev/null
> +++ b/target/ppc/cpu_init.h
> @@ -0,0 +1,78 @@
> +#ifndef TARGET_PPC_CPU_INIT_H
> +#define TARGET_PPC_CPU_INIT_H
> +
> +#define POWERPC_FAMILY_POWER9_INSNS_FLAGS                           \

I would call this PPC_INSNS_FLAGS_POWER9

> +    PPC_INSNS_BASE | PPC_ISEL | PPC_STRING | PPC_MFTB |             \
> +    PPC_FLOAT | PPC_FLOAT_FSEL | PPC_FLOAT_FRES |                   \
> +    PPC_FLOAT_FSQRT | PPC_FLOAT_FRSQRTE | PPC_FLOAT_FRSQRTES |      \
> +    PPC_FLOAT_STFIWX | PPC_FLOAT_EXT |PPC_CACHE | PPC_CACHE_ICBI |  \
> +    PPC_CACHE_DCBZ | PPC_MEM_SYNC | PPC_MEM_EIEIO | PPC_MEM_TLBIE | \
> +    PPC_MEM_TLBSYNC | PPC_64B | PPC_64H | PPC_64BX | PPC_ALTIVEC |  \
> +    PPC_SEGMENT_64B | PPC_SLBI | PPC_POPCNTB | PPC_POPCNTWD |       \
> +    PPC_CILDST

Add this here

#define PPC_INSNS_FLAGS_POWER10 PPC_INSNS_FLAGS_POWER9

> +
> +#define POWERPC_FAMILY_POWER9_INSNS_FLAGS2_COMMON                   \

Suggest some other name change -=20

           PPC_INSNS_FLAGS2_POWER_COMMON

> +    PPC2_VSX | PPC2_VSX207 | PPC2_DFP | PPC2_DBRX |                 \
> +    PPC2_PERM_ISA206 | PPC2_DIVE_ISA206 | PPC2_ATOMIC_ISA206 |      \
> +    PPC2_FP_CVT_ISA206 | PPC2_FP_TST_ISA206 | PPC2_BCTAR_ISA207 |   \
> +    PPC2_LSQ_ISA207 | PPC2_ALTIVEC_207 | PPC2_ISA205 |              \
> +    PPC2_ISA207S | PPC2_FP_CVT_S64 | PPC2_ISA300 | PPC2_PRCNTL |    \
> +    PPC2_MEM_LWSYNC | PPC2_BCDA_ISA206
> +
> +#define POWERPC_FAMILY_POWER9_INSNS_FLAGS2                          \
> +    POWERPC_FAMILY_POWER9_INSNS_FLAGS2_COMMON | PPC2_TM
> +#define POWERPC_FAMILY_POWER10_INSNS_FLAGS2                         \
> +    POWERPC_FAMILY_POWER9_INSNS_FLAGS2_COMMON | PPC2_ISA310
> +
> +#define POWERPC_POWER9_COMMON_PCC_MSR_MASK \

PPC_MSR_MASK_POWER_COMMON

> +    (1ull << MSR_SF) |                     \
> +    (1ull << MSR_HV) |                     \
> +    (1ull << MSR_VR) |                     \
> +    (1ull << MSR_VSX) |                    \
> +    (1ull << MSR_EE) |                     \
> +    (1ull << MSR_PR) |                     \
> +    (1ull << MSR_FP) |                     \
> +    (1ull << MSR_ME) |                     \
> +    (1ull << MSR_FE0) |                    \
> +    (1ull << MSR_SE) |                     \
> +    (1ull << MSR_DE) |                     \
> +    (1ull << MSR_FE1) |                    \
> +    (1ull << MSR_IR) |                     \
> +    (1ull << MSR_DR) |                     \
> +    (1ull << MSR_PMM) |                    \
> +    (1ull << MSR_RI) |                     \
> +    (1ull << MSR_LE)
> +
> +#define POWERPC_POWER9_PCC_MSR_MASK \
> +    POWERPC_POWER9_COMMON_PCC_MSR_MASK | (1ull << MSR_TM)

PPC_MSR_MASK_POWER9

> +#define POWERPC_POWER10_PCC_MSR_MASK \
> +    POWERPC_POWER9_COMMON_PCC_MSR_MASK
> +#define POWERPC_POWER9_PCC_PCR_MASK \

PPC_PCR_MASK_POWER9

> +    PCR_COMPAT_2_05 | PCR_COMPAT_2_06 | PCR_COMPAT_2_07
> +#define POWERPC_POWER10_PCC_PCR_MASK \
> +    POWERPC_POWER9_PCC_PCR_MASK | PCR_COMPAT_3_00
> +#define POWERPC_POWER9_PCC_PCR_SUPPORTED \

PPC_PCR_SUPPORED_POWER9

etc

> +    PCR_COMPAT_3_00 | PCR_COMPAT_2_07 | PCR_COMPAT_2_06 | PCR_COMPAT_2_0=
5
> +#define POWERPC_POWER10_PCC_PCR_SUPPORTED \
> +    POWERPC_POWER9_PCC_PCR_SUPPORTED | PCR_COMPAT_3_10
> +#define POWERPC_POWER9_PCC_LPCR_MASK                                    =
    \
> +    LPCR_VPM1 | LPCR_ISL | LPCR_KBV | LPCR_DPFD |                       =
    \
> +    (LPCR_PECE_U_MASK & LPCR_HVEE) | LPCR_ILE | LPCR_AIL |              =
    \
> +    LPCR_UPRT | LPCR_EVIRT | LPCR_ONL | LPCR_HR | LPCR_LD |             =
    \
> +    (LPCR_PECE_L_MASK & (LPCR_PDEE|LPCR_HDEE|LPCR_EEE|LPCR_DEE|LPCR_OEE)=
) | \
> +    LPCR_MER | LPCR_GTSE | LPCR_TC | LPCR_HEIC | LPCR_LPES0 | LPCR_HVICE=
 |  \
> +    LPCR_HDICE
> +/* DD2 adds an extra HAIL bit */
> +#define POWERPC_POWER10_PCC_LPCR_MASK \
> +    POWERPC_POWER9_PCC_LPCR_MASK | LPCR_HAIL
> +#define POWERPC_POWER9_PCC_FLAGS_COMMON                                 =
\

POWERPC_FLAG_POWER9

> +    POWERPC_FLAG_VRE | POWERPC_FLAG_SE | POWERPC_FLAG_BE |              =
\
> +    POWERPC_FLAG_PMM | POWERPC_FLAG_BUS_CLK | POWERPC_FLAG_CFAR |       =
\
> +    POWERPC_FLAG_VSX | POWERPC_FLAG_SCV
> +
> +#define POWERPC_POWER9_PCC_FLAGS  \
> +    POWERPC_POWER9_PCC_FLAGS_COMMON | POWERPC_FLAG_TM
> +#define POWERPC_POWER10_PCC_FLAGS \
> +    POWERPC_POWER9_PCC_FLAGS_COMMON | POWERPC_FLAG_BHRB
> +
> +#endif /* TARGET_PPC_CPU_INIT_H */


