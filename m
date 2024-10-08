Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91330CED270
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 06:48:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sy40h-0006DI-QU; Tue, 08 Oct 2024 02:47:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sy40f-0006CW-MQ; Tue, 08 Oct 2024 02:47:53 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sy40d-0005yD-3C; Tue, 08 Oct 2024 02:47:53 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-20c593d6b1cso2050875ad.0; 
 Mon, 07 Oct 2024 23:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728370069; x=1728974869; darn=nongnu.org;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/W2Zkhpu/QIPajJ/gedFfX8uIFQ7xTXaB1Yn2cDr9Zs=;
 b=keSQXYG5hQaIVDOvfLOGJnKwetIzviVwxIrddGP+Flh94uUEWw8bvO1aVZH5feVZvq
 kCp2NPyzQ2cMJB906wRcJ8YNwdEseNafuM2Uo2fuzVR1SYDjVqqQ1Y+P8Ti+Zpi9UqAD
 RDjpLqxz3PZWNJof/4DAbt+F9Q/VHdRg8AclL7OZ6RzC9khTI/AJ/km4rRiF6fwLQ/pH
 iBJTxhiBi/Xy47MXGCyiKYMSszykQJNVZElpMclU/b+Y371HBgfPu3O1fH93m0SNPN59
 Y5y3n2YacWNzsNH+l5VkRw1icj7NpO0zF3vSrJFrQExsBeVTb1xNJ4P/qFkWWycQTBOI
 1XlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728370069; x=1728974869;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=/W2Zkhpu/QIPajJ/gedFfX8uIFQ7xTXaB1Yn2cDr9Zs=;
 b=T7xJxIzqMWWRtJa+9rvpGsjm68K69gJcfTnI7jUPwQQH9SAuNTG84RFWR0fK0KVvKm
 JRNrLSB5LOybuRt2kRZ9Mu3WKmf+v9pIlXtI08TVFYZJn6jzTKESLctKJOHkDxmrvSAN
 TJkWSdnNq+ZUMbTlHys548eUSRisR+frQeg7vfDEgP4mIdE6RDK011ISm9ElWWM/qCqT
 cMK1UXEGMZlEu7XU94m5wG+usPqu5HZXHN5abrcs+GT8ulSvIJCfVWQoZVeEYTnK7j/d
 ve0J2IJE1vt433Y1nz/RM/uYeRr68ahMaxElAPGhIo4GTZ0P8xhz8skw8Ued8JZuIrSw
 5CTQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUm3gixHhEXOrGja4KxTq6bSA39ctqzFacvHsDwuSFLbmcf5GD+6FQ962zsEf7Dgt0sHni/KrRtp7qW@nongnu.org,
 AJvYcCV389bfUuyI5Vx7ViaowDQlwmAZMxHblkDzYNt1L6UXtQtcZDfLeee+CEmIUL9TeLfmz1X5Sm6DME8=@nongnu.org
X-Gm-Message-State: AOJu0Yz3UFuUbU5aB+5bCzV1SLIwfSvP2fg/tos/URGz0atiw/3zf9F2
 MkCLI0Hy1XPnrILhtJ5GgND55BeaHciORlJ/8dSH5trifWgJz0gn
X-Google-Smtp-Source: AGHT+IF0W1U3HpMbOCfggD9rrXf8BOpPt14tqZmrA+v1pdxL6omiyLiSDVef/ia13pud+nyPCGrWmw==
X-Received: by 2002:a17:902:e846:b0:206:aac4:b844 with SMTP id
 d9443c01a7336-20bfdf64fc2mr252666805ad.6.1728370069079; 
 Mon, 07 Oct 2024 23:47:49 -0700 (PDT)
Received: from localhost ([118.210.103.101]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20c1396ee3dsm49500955ad.226.2024.10.07.23.47.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Oct 2024 23:47:48 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 08 Oct 2024 16:47:44 +1000
Message-Id: <D4Q81Y6IIR8P.USV803J6NZL5@gmail.com>
Subject: Re: [PATCH v3 05/10] target/ppc: optimize p9 exception handling
 routines for lpcr
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Harsh Prateek Bora" <harshpb@linux.ibm.com>, <qemu-ppc@nongnu.org>,
 <qemu-devel@nongnu.org>
Cc: <balaton@eik.bme.hu>, <danielhb413@gmail.com>
X-Mailer: aerc 0.18.2
References: <20240913041337.912876-1-harshpb@linux.ibm.com>
 <20240913041337.912876-6-harshpb@linux.ibm.com>
In-Reply-To: <20240913041337.912876-6-harshpb@linux.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x631.google.com
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

On Fri Sep 13, 2024 at 2:13 PM AEST, Harsh Prateek Bora wrote:
> Like pending_interrupts, env->spr[SPR_LPCR] is being used at multiple
> places across p9 exception handlers. Pass the value during entry and
> avoid multiple indirect accesses.

Could this be merged with patch 4 to do pending_interrupts and lpcr
at once, to match p7 and p8? Otherwise,

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

Thanks,
Nick

>
> Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
> ---
>  target/ppc/excp_helper.c | 33 ++++++++++++++++++---------------
>  1 file changed, 18 insertions(+), 15 deletions(-)
>
> diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
> index 31c1653e2b..c7641898ca 100644
> --- a/target/ppc/excp_helper.c
> +++ b/target/ppc/excp_helper.c
> @@ -1873,13 +1873,14 @@ static int p8_next_unmasked_interrupt(CPUPPCState=
 *env)
>       PPC_INTERRUPT_PIT | PPC_INTERRUPT_THERM)
> =20
>  static int p9_interrupt_powersave(CPUPPCState *env,
> -                                  uint32_t pending_interrupts)
> +                                  uint32_t pending_interrupts,
> +                                  target_ulong lpcr)
>  {
> =20
>      /* External Exception */
>      if ((pending_interrupts & PPC_INTERRUPT_EXT) &&
> -        (env->spr[SPR_LPCR] & LPCR_EEE)) {
> -        bool heic =3D !!(env->spr[SPR_LPCR] & LPCR_HEIC);
> +        (lpcr & LPCR_EEE)) {
> +        bool heic =3D !!(lpcr & LPCR_HEIC);
>          if (!heic || !FIELD_EX64_HV(env->msr) ||
>              FIELD_EX64(env->msr, MSR, PR)) {
>              return PPC_INTERRUPT_EXT;
> @@ -1887,11 +1888,11 @@ static int p9_interrupt_powersave(CPUPPCState *en=
v,
>      }
>      /* Decrementer Exception */
>      if ((pending_interrupts & PPC_INTERRUPT_DECR) &&
> -        (env->spr[SPR_LPCR] & LPCR_DEE)) {
> +        (lpcr & LPCR_DEE)) {
>          return PPC_INTERRUPT_DECR;
>      }
>      /* Machine Check or Hypervisor Maintenance Exception */
> -    if (env->spr[SPR_LPCR] & LPCR_OEE) {
> +    if (lpcr & LPCR_OEE) {
>          if (pending_interrupts & PPC_INTERRUPT_MCK) {
>              return PPC_INTERRUPT_MCK;
>          }
> @@ -1901,17 +1902,17 @@ static int p9_interrupt_powersave(CPUPPCState *en=
v,
>      }
>      /* Privileged Doorbell Exception */
>      if ((pending_interrupts & PPC_INTERRUPT_DOORBELL) &&
> -        (env->spr[SPR_LPCR] & LPCR_PDEE)) {
> +        (lpcr & LPCR_PDEE)) {
>          return PPC_INTERRUPT_DOORBELL;
>      }
>      /* Hypervisor Doorbell Exception */
>      if ((pending_interrupts & PPC_INTERRUPT_HDOORBELL) &&
> -        (env->spr[SPR_LPCR] & LPCR_HDEE)) {
> +        (lpcr & LPCR_HDEE)) {
>          return PPC_INTERRUPT_HDOORBELL;
>      }
>      /* Hypervisor virtualization exception */
>      if ((pending_interrupts & PPC_INTERRUPT_HVIRT) &&
> -        (env->spr[SPR_LPCR] & LPCR_HVEE)) {
> +        (lpcr & LPCR_HVEE)) {
>          return PPC_INTERRUPT_HVIRT;
>      }
>      if (pending_interrupts & PPC_INTERRUPT_RESET) {
> @@ -1921,7 +1922,8 @@ static int p9_interrupt_powersave(CPUPPCState *env,
>  }
> =20
>  static int p9_next_unmasked_interrupt(CPUPPCState *env,
> -                                      uint32_t pending_interrupts)
> +                                      uint32_t pending_interrupts,
> +                                      target_ulong lpcr)
>  {
>      CPUState *cs =3D env_cpu(env);
> =20
> @@ -1936,7 +1938,7 @@ static int p9_next_unmasked_interrupt(CPUPPCState *=
env,
>               * When PSSCR[EC] is set, LPCR[PECE] controls which interrup=
ts can
>               * wakeup the processor
>               */
> -            return p9_interrupt_powersave(env, pending_interrupts);
> +            return p9_interrupt_powersave(env, pending_interrupts, lpcr)=
;
>          } else {
>              /*
>               * When it's clear, any system-caused exception exits power-=
saving
> @@ -1954,7 +1956,7 @@ static int p9_next_unmasked_interrupt(CPUPPCState *=
env,
>      /* Hypervisor decrementer exception */
>      if (pending_interrupts & PPC_INTERRUPT_HDECR) {
>          /* LPCR will be clear when not supported so this will work */
> -        bool hdice =3D !!(env->spr[SPR_LPCR] & LPCR_HDICE);
> +        bool hdice =3D !!(lpcr & LPCR_HDICE);
>          if ((msr_ee || !FIELD_EX64_HV(env->msr)) && hdice) {
>              /* HDEC clears on delivery */
>              return PPC_INTERRUPT_HDECR;
> @@ -1964,7 +1966,7 @@ static int p9_next_unmasked_interrupt(CPUPPCState *=
env,
>      /* Hypervisor virtualization interrupt */
>      if (pending_interrupts & PPC_INTERRUPT_HVIRT) {
>          /* LPCR will be clear when not supported so this will work */
> -        bool hvice =3D !!(env->spr[SPR_LPCR] & LPCR_HVICE);
> +        bool hvice =3D !!(lpcr & LPCR_HVICE);
>          if ((msr_ee || !FIELD_EX64_HV(env->msr)) && hvice) {
>              return PPC_INTERRUPT_HVIRT;
>          }
> @@ -1972,8 +1974,8 @@ static int p9_next_unmasked_interrupt(CPUPPCState *=
env,
> =20
>      /* External interrupt can ignore MSR:EE under some circumstances */
>      if (pending_interrupts & PPC_INTERRUPT_EXT) {
> -        bool lpes0 =3D !!(env->spr[SPR_LPCR] & LPCR_LPES0);
> -        bool heic =3D !!(env->spr[SPR_LPCR] & LPCR_HEIC);
> +        bool lpes0 =3D !!(lpcr & LPCR_LPES0);
> +        bool heic =3D !!(lpcr & LPCR_HEIC);
>          /* HEIC blocks delivery to the hypervisor */
>          if ((msr_ee && !(heic && FIELD_EX64_HV(env->msr) &&
>              !FIELD_EX64(env->msr, MSR, PR))) ||
> @@ -2023,7 +2025,8 @@ static int ppc_next_unmasked_interrupt(CPUPPCState =
*env)
>      case POWERPC_EXCP_POWER9:
>      case POWERPC_EXCP_POWER10:
>      case POWERPC_EXCP_POWER11:
> -        return p9_next_unmasked_interrupt(env, env->pending_interrupts);
> +        return p9_next_unmasked_interrupt(env, env->pending_interrupts,
> +			                  env->spr[SPR_LPCR]);
>      default:
>          break;
>      }


