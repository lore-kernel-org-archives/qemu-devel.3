Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40AF3C3DA63
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 05:14:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sW7ql-0006Fb-Ta; Tue, 23 Jul 2024 01:14:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sW7qi-0005y4-VY; Tue, 23 Jul 2024 01:14:09 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sW7qh-0002RO-4U; Tue, 23 Jul 2024 01:14:08 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1fa9ecfb321so2635305ad.0; 
 Mon, 22 Jul 2024 22:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721711644; x=1722316444; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=niSgo5VoLhaPZJ9cwtGBvJU6aDLGjtjdFgObsJgvhg4=;
 b=U+magk4Jvh0pn175SHOGIE6893//tjr0yRDa05624AxXwMLD7ilPuYGaTbqKtJt193
 XaaqmzhZcmfp57UjljQ6vQ7ExHjaVGpxHet339WSPNtyNIJQ9uOuNZtcOy/w3sCZvQue
 xZq1mFkA/4y+Mf/GDDlQ7NyBgWA7aGVM14XByjDFrjrwpRNn9s0xOdRoTBSboNEJnCZM
 Ov3bpMm41K5oUrdAIe+TXXgjvpGbz+fc9doLXptWanR7VSRcC83DenmlAepgfxA3Jaar
 /9+OU8toQTtrxI2SNB8Pnwj74OeFZh1XA8omB5CpthwpitiC16sg9siH4LuMurFNPjCt
 gWMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721711644; x=1722316444;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=niSgo5VoLhaPZJ9cwtGBvJU6aDLGjtjdFgObsJgvhg4=;
 b=p5ImsyXZcDSOGsEJ1tW+6lMPDRInK/tYxibyNyMJ2KG2r4evw6OKxmk8MiFVaAUXoW
 VDiSiF5mqLye0p2ELBWviciOHo8CXAW8SGEQboMr8TlSknUISMD2V4+7Eb3Vwip4jeoE
 OxL8KJZ988ba9bxrsCnUMbcQuElU++glyKGNXxM7rG0VtZ8vSKcQGmEWngbfWcr88sbg
 bKLiKGe8fKnawKF0bEXOTL9GkleA8PLWlSTU4/TjSgimiLe6nAXPuqP0TVpRxm1l3gbz
 LIhefM5sMr+5uQNVYQtXWXCMHDwL55WCbM3oZTrFKW4UtnASVGWGVWjXUCYNm8/+pAXf
 Slyg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWfP0Doadqfiud3Vb+3jYfvpuA+s3Chw8H2x89ki70aeFgoHKJZDCq0K5M9RoLLX7oXXuVCH/DMdsXXWYVfVnL10yx5
X-Gm-Message-State: AOJu0YwdTqRsQ4ZUoNsOHC7wE2DT11LEY2xHuZp0fXbTD5H9HOoWcAem
 zojEORhpU9goDtlwsxw4DFUdGif6pVkgMftkL0PAfdqD4y2/PQr0
X-Google-Smtp-Source: AGHT+IFfdZQuwui7sL37cJsRGn3ZttGRFuqZfZHlaqikkb+4e/1S9bF48tr47owqVsW35M9QGhQNdg==
X-Received: by 2002:a17:902:f98e:b0:1fd:8eaf:eaad with SMTP id
 d9443c01a7336-1fdb5ed751emr11826865ad.32.1721711644325; 
 Mon, 22 Jul 2024 22:14:04 -0700 (PDT)
Received: from localhost ([203.220.44.216]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fd6f457cb2sm64693885ad.238.2024.07.22.22.14.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jul 2024 22:14:04 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 23 Jul 2024 15:13:58 +1000
Message-Id: <D2WNU7STYWG0.326OR9H3OWQHK@gmail.com>
Cc: <qemu-devel@nongnu.org>, <qemu-ppc@nongnu.org>, "Daniel Henrique
 Barboza" <danielhb413@gmail.com>
Subject: Re: [PATCH v5 4/5] target/ppc: Introduce
 'PowerPCCPUClass::logical_pvr'
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Aditya Gupta" <adityag@linux.ibm.com>, "Mahesh J Salgaonkar"
 <mahesh@linux.ibm.com>, "Madhavan Srinivasan" <maddy@linux.ibm.com>,
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, "Harsh Prateek Bora"
 <harshpb@linux.ibm.com>
X-Mailer: aerc 0.18.0
References: <20240606121657.254308-1-adityag@linux.ibm.com>
 <20240606121657.254308-5-adityag@linux.ibm.com>
In-Reply-To: <20240606121657.254308-5-adityag@linux.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62c.google.com
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

On Thu Jun 6, 2024 at 10:16 PM AEST, Aditya Gupta wrote:
> Introduce 'PnvChipClass::logical_pvr' to know corresponding logical PVR
> of a PowerPC CPU.
> This helps to have a one-to-one mapping between PVR and logical PVR for
> a CPU, and used in a later commit to handle cases where PCR of two
> generations of Power chip is same, which causes regressions with compat-m=
ode.

>
> Cc: C=C3=A9dric Le Goater <clg@kaod.org>
> Cc: Daniel Henrique Barboza <danielhb413@gmail.com>
> Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>
> Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>
> Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
> ---
>  target/ppc/cpu.h      | 1 +
>  target/ppc/cpu_init.c | 5 +++++
>  2 files changed, 6 insertions(+)
>
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index 2015e603d4e0..ff43e3645228 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -1504,6 +1504,7 @@ struct PowerPCCPUClass {
>      void (*parent_parse_features)(const char *type, char *str, Error **e=
rrp);
> =20
>      uint32_t pvr;
> +    uint32_t logical_pvr;
>      /*
>       * If @best is false, match if pcc is in the family of pvr
>       * Else match only if pcc is the best match for pvr in this family.

I suppose so. pvr_match() is for hardware PVR, not logical. It's all
quite a maze.

I'll get you to re-post the series with paches 4-5 reordered ahead
of the power11 addition, so you can do the renaming and tweaking :)
Maybe call this 'spapr_logical_pvr' so it's clearly separate from the
other pvr matching.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

> diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
> index 9aa098935d05..50f136cca7f0 100644
> --- a/target/ppc/cpu_init.c
> +++ b/target/ppc/cpu_init.c
> @@ -6152,6 +6152,7 @@ POWERPC_FAMILY(POWER7)(ObjectClass *oc, void *data)
> =20
>      dc->fw_name =3D "PowerPC,POWER7";
>      dc->desc =3D "POWER7";
> +    pcc->logical_pvr =3D CPU_POWERPC_LOGICAL_2_06_PLUS;
>      pcc->pvr_match =3D ppc_pvr_match_power7;
>      pcc->pcr_mask =3D PCR_VEC_DIS | PCR_VSX_DIS | PCR_COMPAT_2_05;
>      pcc->pcr_supported =3D PCR_COMPAT_2_06 | PCR_COMPAT_2_05;
> @@ -6315,6 +6316,7 @@ POWERPC_FAMILY(POWER8)(ObjectClass *oc, void *data)
> =20
>      dc->fw_name =3D "PowerPC,POWER8";
>      dc->desc =3D "POWER8";
> +    pcc->logical_pvr =3D CPU_POWERPC_LOGICAL_2_07;
>      pcc->pvr_match =3D ppc_pvr_match_power8;
>      pcc->pcr_mask =3D PCR_TM_DIS | PCR_COMPAT_2_06 | PCR_COMPAT_2_05;
>      pcc->pcr_supported =3D PCR_COMPAT_2_07 | PCR_COMPAT_2_06 | PCR_COMPA=
T_2_05;
> @@ -6508,6 +6510,7 @@ POWERPC_FAMILY(POWER9)(ObjectClass *oc, void *data)
> =20
>      dc->fw_name =3D "PowerPC,POWER9";
>      dc->desc =3D "POWER9";
> +    pcc->logical_pvr =3D CPU_POWERPC_LOGICAL_3_00;
>      pcc->pvr_match =3D ppc_pvr_match_power9;
>      pcc->pcr_mask =3D POWERPC_POWER9_PCC_PCR_MASK;
>      pcc->pcr_supported =3D POWERPC_POWER9_PCC_PCR_SUPPORTED;
> @@ -6642,6 +6645,7 @@ POWERPC_FAMILY(POWER10)(ObjectClass *oc, void *data=
)
> =20
>      dc->fw_name =3D "PowerPC,POWER10";
>      dc->desc =3D "POWER10";
> +    pcc->logical_pvr =3D CPU_POWERPC_LOGICAL_3_10;
>      pcc->pvr_match =3D ppc_pvr_match_power10;
>      pcc->pcr_mask =3D POWERPC_POWER10_PCC_PCR_MASK;
>      pcc->pcr_supported =3D POWERPC_POWER10_PCC_PCR_SUPPORTED;
> @@ -6696,6 +6700,7 @@ POWERPC_FAMILY(POWER11)(ObjectClass *oc, void *data=
)
> =20
>      dc->fw_name =3D "PowerPC,POWER11";
>      dc->desc =3D "POWER11";
> +    pcc->logical_pvr =3D CPU_POWERPC_LOGICAL_3_10_PLUS;
>      pcc->pvr_match =3D ppc_pvr_match_power11;
>      pcc->pcr_mask =3D POWERPC_POWER10_PCC_PCR_MASK;
>      pcc->pcr_supported =3D POWERPC_POWER10_PCC_PCR_SUPPORTED;


