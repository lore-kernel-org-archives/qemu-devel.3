Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23F9AC54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 12:24:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk1Aa-0003uz-RV; Tue, 12 Mar 2024 08:23:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rk1AZ-0003sU-GC; Tue, 12 Mar 2024 08:23:47 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rk1AO-0004Yp-W3; Tue, 12 Mar 2024 08:23:47 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1dd8f7d50c6so16368335ad.0; 
 Tue, 12 Mar 2024 05:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710246215; x=1710851015; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eOwBjIoPf8a3gPHNEik66ToFv+JsOFqB582RHvGaCzY=;
 b=MDXGt9NA1qaof69eMTyRvC9J4J560BpmvO79yaDldhv+u/WJhwQiwfq6ceeSKSoJ/j
 z8dVMzCmKMxXmx4nk3bLArif2QFS54HBQidQEZUkvpbhk7cUInzvhWXVbXUNMpVGl5oX
 bOplnP/v3JrNWNufcs5UrEtZOlV4dSQa3HoZ1f0P9oBIYRU42kjEqiUnqdoDmqYROcdc
 rAOCeOJy+eFdrwPR54aQcnpTVsFfJrc7lXpBms6PxlwqxbauOTuQIuC1F5yOKPXcr/vc
 I3J2qdr4Ix74vX8iI6prmOHbj4cyLIshSORK+QbXnzq7xvn47B79VOUG5xW2k2ZnzTUG
 oNfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710246215; x=1710851015;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=eOwBjIoPf8a3gPHNEik66ToFv+JsOFqB582RHvGaCzY=;
 b=R+gFx5rF8XarukXwJDYLM2yCwZk1iXgc5Pb5pYpdrDxg4cP5+z4FnMRj2dLimooFz1
 ng0fu1zlwW7ix3P6vInnrhcWwtTf0anLoTo/kO+adzxnp6j+AblJNFCrutYN+FUsfVHN
 W7pUSrrgcJPQtLSeJNJluhoOInK2Z98zzupVcRgIprh+BO5+yS4gKoQJdsc7ZrfBN7kv
 8THkFds7Iu+/LGekgEh4rEUqKp4zTXf3u5WiaGaqNG8nnCUwkpEJQzpYz64O3ezQ6+eF
 sw1C/TcWyeJoeUBApH+9Qed7LCuuaNPz/ra4+5Y0qw3tEimtQk/8BiwYSregM60402NX
 bADg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWdQ0V+3NWNy2Z77sfufnRu32MuWmF8hZDgaobEZAnPmEtpJVS5vAzZvPojprjd52RJvp1n31FaM04ZPV6cCWAa7MFbmi0=
X-Gm-Message-State: AOJu0Yz+Bdoy6sxVV/b3i9PmOSj8VLnTkEWyEHZd1JRJJWZhIz15OTyl
 q3sMZRt5qyNxk0+EnXXsKp032fIPc5XnN2eGXNW8Yrbgyl6SEVxQ
X-Google-Smtp-Source: AGHT+IFWAgjxdgotTgxM0NhE6l2T6LY0xcQUw4MQ5qSIPXw5hfeajVG2N2p3iUPDKqU34vYMSjQP5A==
X-Received: by 2002:a17:902:f24b:b0:1dd:63db:b35f with SMTP id
 j11-20020a170902f24b00b001dd63dbb35fmr8822522plc.33.1710246214986; 
 Tue, 12 Mar 2024 05:23:34 -0700 (PDT)
Received: from localhost ([118.208.155.46]) by smtp.gmail.com with ESMTPSA id
 m14-20020a63ed4e000000b005dc816b2369sm6063148pgk.28.2024.03.12.05.23.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Mar 2024 05:23:34 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 12 Mar 2024 22:23:29 +1000
Message-Id: <CZRROM5LFA0B.37MT31NHNJPRL@wheely>
Cc: <qemu-ppc@nongnu.org>, <qemu-devel@nongnu.org>,
 <atrajeev@linux.vnet.ibm.com>, <kjain@linux.ibm.com>
Subject: Re: [PATCH] target/ppc: Add power10 pmu SPRs
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Madhavan Srinivasan" <maddy@linux.ibm.com>, <danielhb413@gmail.com>,
 <clg@kaod.org>
X-Mailer: aerc 0.15.2
References: <20240219103924.445857-1-maddy@linux.ibm.com>
In-Reply-To: <20240219103924.445857-1-maddy@linux.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x631.google.com
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

On Mon Feb 19, 2024 at 8:39 PM AEST, Madhavan Srinivasan wrote:
> Currently in tcg mode, when reading from power10 pmu spr like MMCR3,
> qemu logs this message (when starting qemu with -d guest_errors)
>
> 	Trying to read invalid spr 754 (0x2f2) at 0000000030056bb0
>
> This is becuase, no read/write call-backs are registered for
> these SPRs. Add support to register generic read/write
> functions to these power10 pmu sprs to fix it.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

>
> Signed-off-by: Madhavan Srinivasan <maddy@linux.ibm.com>
> ---
>  target/ppc/cpu.h      |  6 ++++++
>  target/ppc/cpu_init.c | 34 ++++++++++++++++++++++++++++++++++
>  2 files changed, 40 insertions(+)
>
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index a44de22ca4..e5d0c8a5ee 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -1933,6 +1933,12 @@ void ppc_compat_add_property(Object *obj, const ch=
ar *name,
>  #define SPR_BOOKE_TLB2CFG     (0x2B2)
>  #define SPR_BOOKE_TLB3CFG     (0x2B3)
>  #define SPR_BOOKE_EPR         (0x2BE)
> +#define SPR_POWER_USIER2      (0x2E0)
> +#define SPR_POWER_USIER3      (0x2E1)
> +#define SPR_POWER_UMMCR3      (0x2E2)
> +#define SPR_POWER_SIER2       (0x2F0)
> +#define SPR_POWER_SIER3       (0x2F1)
> +#define SPR_POWER_MMCR3       (0x2F2)
>  #define SPR_PERF0             (0x300)
>  #define SPR_RCPU_MI_RBA0      (0x300)
>  #define SPR_MPC_MI_CTR        (0x300)
> diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
> index 9931372a08..d64da75a61 100644
> --- a/target/ppc/cpu_init.c
> +++ b/target/ppc/cpu_init.c
> @@ -5308,6 +5308,38 @@ static void register_power8_pmu_user_sprs(CPUPPCSt=
ate *env)
>                   0x00000000);
>  }
> =20
> +static void register_power10_pmu_sup_sprs(CPUPPCState *env)
> +{
> +    spr_register_kvm(env, SPR_POWER_MMCR3, "MMCR3",
> +                     SPR_NOACCESS, SPR_NOACCESS,
> +                     &spr_read_generic, &spr_write_generic,
> +                     KVM_REG_PPC_MMCR3, 0x00000000);
> +    spr_register_kvm(env, SPR_POWER_SIER2, "SIER2",
> +                     SPR_NOACCESS, SPR_NOACCESS,
> +                     &spr_read_generic, &spr_write_generic,
> +                     KVM_REG_PPC_SIER2, 0x00000000);
> +    spr_register_kvm(env, SPR_POWER_SIER3, "SIER3",
> +                     SPR_NOACCESS, SPR_NOACCESS,
> +                     &spr_read_generic, &spr_write_generic,
> +                     KVM_REG_PPC_SIER3, 0x00000000);
> +}
> +
> +static void register_power10_pmu_user_sprs(CPUPPCState *env)
> +{
> +    spr_register(env, SPR_POWER_UMMCR3, "UMMCR3",
> +                 &spr_read_generic, &spr_write_generic,
> +                 &spr_read_generic, &spr_write_generic,
> +                 0x00000000);
> +    spr_register(env, SPR_POWER_USIER2, "USIER2",
> +                 &spr_read_generic, SPR_NOACCESS,
> +                 &spr_read_generic, &spr_write_generic,
> +                 0x00000000);
> +    spr_register(env, SPR_POWER_USIER3, "USIER3",
> +                 &spr_read_generic, SPR_NOACCESS,
> +                 &spr_read_generic, &spr_write_generic,
> +                 0x00000000);
> +}
> +
>  static void register_power5p_ear_sprs(CPUPPCState *env)
>  {
>      /* External access control */
> @@ -6505,6 +6537,8 @@ static void init_proc_POWER10(CPUPPCState *env)
>      register_power9_mmu_sprs(env);
>      register_power10_hash_sprs(env);
>      register_power10_dexcr_sprs(env);
> +    register_power10_pmu_sup_sprs(env);
> +    register_power10_pmu_user_sprs(env);
> =20
>      /* FIXME: Filter fields properly based on privilege level */
>      spr_register_kvm_hv(env, SPR_PSSCR, "PSSCR", NULL, NULL, NULL, NULL,


