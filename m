Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB758C30653
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 07:50:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPHDX-0003z1-FS; Thu, 04 Jul 2024 03:49:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sPHDS-0003xu-DR; Thu, 04 Jul 2024 03:49:18 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sPHDQ-0007ES-Kq; Thu, 04 Jul 2024 03:49:18 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1f9ffd24262so2034545ad.0; 
 Thu, 04 Jul 2024 00:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720079354; x=1720684154; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KAzDNf9DWGbJubzE9VzLF12FDRQ16GG1jmbaSAmlVOg=;
 b=RTXZ4dJ8L7qeggh7FL57IPPchn88l7fd9dDwWqd697MAcod6uHBZTwRLvGt+8fRejp
 BqOikjQwZUPLz/WcTp9Og3TFcHRKVWRiOshZKJHD9MTpoixfm6qgnOuDnLbItzkVBaOS
 z17IAGoydjwmkfwo1yM5s6vWQ5Q2Ofcj3t1yMKCvtIuQmoPCVoFkqLWuS3jETqg//Cs9
 lxZPGKi4u3vHOlE1bki68BIxUy8CvxJLAd0g4p04GVGrXWh67w0lUUoyxoa2dPWVeZfm
 38M8MS7kshjYg9UKtAhE64CNJz+kdtMVV5FN6xdFvkTwORZTm+CBJz9cl1F1NCnquffb
 aDAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720079354; x=1720684154;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=KAzDNf9DWGbJubzE9VzLF12FDRQ16GG1jmbaSAmlVOg=;
 b=EbTp72FUjNDaOW80W6AQb5ddsRd5pXLEwWw7zGEufl0TNL+M9SOByDWxlww98yu2A3
 t0U0Ig6xovyQ7K7QV/sgayZ9/hhXXE7C/1tiePUyUHZddktmYjC+rcVsTfrdbHzN0NQg
 65LSlCxKg3DGOKNZd/8aERVNBDiDzUwnJqIBevh/ZZbj8m/jdGasf3ekxpnC0J764owm
 jpNNN6CRBpMwdqrZEjkJn1L2LD49x++HhLMa/FvzsZgcprPhhwut3oGvYNSkDb1GKhpF
 iI6Vhc0b8eouEY22QRAGtLU4c2IfNpMJ8xTCUILQWbOozqle+JPCUdHmP8wraqRsylL6
 74FA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUdhO9/Nc7Zh1/cKAA/IwUEUHYL2ORA7wDDmLBO8+rLI30BsoFi6pqkUpSLeAo39osvMJWoHgXmrNNEjTsIMS2/fqYs+PtlMkDaKtCstNWVFsEkck++9ze6kB8=
X-Gm-Message-State: AOJu0YxWg3sK9xiMbEkpR946TJRQqWLMB2WXR8Y4hwM0R6GteWnEmWxL
 kIA/OZv1AGAse8oJWbkxIWD43UWofe3dcR9DBE26gJQmAbzqTTeu
X-Google-Smtp-Source: AGHT+IFr56Ih2qyzCEu3iMlommcnK+yaG0mZhMHrIA9PTNSm9C7Z4FKgtawFIzXcF/qFkY8xI+UkNw==
X-Received: by 2002:a17:902:ecc6:b0:1fb:2eb3:7874 with SMTP id
 d9443c01a7336-1fb33e58856mr8311935ad.28.1720079354467; 
 Thu, 04 Jul 2024 00:49:14 -0700 (PDT)
Received: from localhost ([1.146.24.72]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fac1535d37sm116919865ad.171.2024.07.04.00.49.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Jul 2024 00:49:14 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 04 Jul 2024 17:49:08 +1000
Message-Id: <D2GL8O0BR8KC.STO51QHTZ6D5@gmail.com>
Cc: <balaton@eik.bme.hu>, <danielhb413@gmail.com>
Subject: Re: [PATCH v2 7/7] target/ppc: redue code duplication across
 Power9/10 init code
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Harsh Prateek Bora" <harshpb@linux.ibm.com>, <qemu-ppc@nongnu.org>,
 <qemu-devel@nongnu.org>
X-Mailer: aerc 0.17.0
References: <20240523051412.226970-1-harshpb@linux.ibm.com>
 <20240523051412.226970-8-harshpb@linux.ibm.com>
In-Reply-To: <20240523051412.226970-8-harshpb@linux.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x631.google.com
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

On Thu May 23, 2024 at 3:14 PM AEST, Harsh Prateek Bora wrote:
> Power9/10 initialization code consists of a lot of logical OR of
> various flag bits as supported by respective Power platform during its
> initialization, most of which is duplicated and only selected bits are
> added or removed as needed with each new platform support being added.
> Remove the duplicate code and share using common macros.

This an the previous patch are fiddly to verify but good cleanups I
think. Couple of small things.

>
> Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
> ---
>  target/ppc/cpu_init.h |  77 ++++++++++++++++++++++++++
>  target/ppc/cpu_init.c | 123 ++++++------------------------------------
>  2 files changed, 92 insertions(+), 108 deletions(-)
>  create mode 100644 target/ppc/cpu_init.h
>
> diff --git a/target/ppc/cpu_init.h b/target/ppc/cpu_init.h
> new file mode 100644
> index 0000000000..53909987b0
> --- /dev/null
> +++ b/target/ppc/cpu_init.h
> @@ -0,0 +1,77 @@

This should have a SPDX license tag I guess.

I suppose doing a new header for it is the way to go. That cpu_init.c
file is enormous...

> +#ifndef TARGET_PPC_CPU_INIT_H
> +#define TARGET_PPC_CPU_INIT_H
> +
> +#define POWERPC_FAMILY_POWER9_INSNS_FLAGS                           \
> +    PPC_INSNS_BASE | PPC_ISEL | PPC_STRING | PPC_MFTB |             \
> +    PPC_FLOAT | PPC_FLOAT_FSEL | PPC_FLOAT_FRES |                   \
> +    PPC_FLOAT_FSQRT | PPC_FLOAT_FRSQRTE | PPC_FLOAT_FRSQRTES |      \
> +    PPC_FLOAT_STFIWX | PPC_FLOAT_EXT |PPC_CACHE | PPC_CACHE_ICBI |  \
> +    PPC_CACHE_DCBZ | PPC_MEM_SYNC | PPC_MEM_EIEIO | PPC_MEM_TLBIE | \
> +    PPC_MEM_TLBSYNC | PPC_64B | PPC_64H | PPC_64BX | PPC_ALTIVEC |  \
> +    PPC_SEGMENT_64B | PPC_SLBI | PPC_POPCNTB | PPC_POPCNTWD |       \
> +    PPC_CILDST
> +
> +#define POWERPC_FAMILY_POWER9_INSNS_FLAGS2_COMMON                   \
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
> +#define POWERPC_POWER10_PCC_MSR_MASK \
> +    POWERPC_POWER9_COMMON_PCC_MSR_MASK
> +#define POWERPC_POWER9_PCC_PCR_MASK \
> +    PCR_COMPAT_2_05 | PCR_COMPAT_2_06 | PCR_COMPAT_2_07
> +#define POWERPC_POWER10_PCC_PCR_MASK \
> +    POWERPC_POWER9_PCC_PCR_MASK | PCR_COMPAT_3_00
> +#define POWERPC_POWER9_PCC_PCR_SUPPORTED \
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
> +    POWERPC_FLAG_VRE | POWERPC_FLAG_SE | POWERPC_FLAG_BE |              =
\
> +    POWERPC_FLAG_PMM | POWERPC_FLAG_BUS_CLK | POWERPC_FLAG_CFAR |       =
\
> +    POWERPC_FLAG_VSX | POWERPC_FLAG_SCV
> +
> +#define POWERPC_POWER9_PCC_FLAGS  \
> +    POWERPC_POWER9_PCC_FLAGS_COMMON | POWERPC_FLAG_TM
> +#define POWERPC_POWER10_PCC_FLAGS POWERPC_POWER9_PCC_FLAGS_COMMON

I can't tell if it would be better to add all the POWER9 defines then
all the POWER10 defines or interleave like this. I guess this is okay.

[snip]

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

I would add POWER10 defines for all of them even the ones that are
the same, because if you're adding or changing flags around, you then
just have one place to go to which is the cpu_init.h file.

Thanks,
Nick

