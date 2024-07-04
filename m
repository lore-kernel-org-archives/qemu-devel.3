Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB4BEC30653
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 07:43:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPH7v-0007la-Cj; Thu, 04 Jul 2024 03:43:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sPH7t-0007j5-PA; Thu, 04 Jul 2024 03:43:33 -0400
Received: from mail-il1-x130.google.com ([2607:f8b0:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sPH7s-0004Zx-1v; Thu, 04 Jul 2024 03:43:33 -0400
Received: by mail-il1-x130.google.com with SMTP id
 e9e14a558f8ab-37636c3872bso1200535ab.3; 
 Thu, 04 Jul 2024 00:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720079010; x=1720683810; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P7YMkWiLEqQxDUxNTr5CjhdBzk3W9kssdu5u86r+0w4=;
 b=T/itb+sS39dJQ64pNSG5fofa9ZUpb89spbC5wNwRVX4s+sU7r0dsokYN/Fhei0IZ7w
 3tPFxQhtA3inDsY5ErrKdwIi5fhL1/bGXUVH6Ps3u94uxWYFG2FpzqNTVEOqI1JqiX4y
 jDuZvKaE5BYibOWA9lRHFpItpVtppJaBagIBY7ZLFkugWI55U5PaxbvAV6/dRRKz2tQh
 QshexG/GuQav/RArk6EpPy+6zxCmOegsxUobOXmiAp8jzuWt7gzJ2Tky/DYfgAni8LVH
 m+DOA8VTX8ml1AOteQ0M6INbwEKqQzoUemXmB7gEWgYNrmFJV1WPlAy86z1T4RN82FtT
 jQpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720079010; x=1720683810;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=P7YMkWiLEqQxDUxNTr5CjhdBzk3W9kssdu5u86r+0w4=;
 b=N2CR7JQv38XMVBO1368Uetz4ESvUPiAacmvUhK9KOlRdlRr2dx0brvfv2QvqCnR2hE
 77u9ALFTP9vsxFdviQoh4XRwO4pSEYzZuF3cE7OhvgCq4J5IOwTaIidWDSs5TxjoQrJu
 8wJD3EoGYY+ZHVFxdNDr8RJVQ2xzsSR1klcKzs7gjGbq7wWODI/DxFITpbEshY2sO2Rg
 dMa6sNRQm14GkY1CH6h3QFmhIBUmeMah5Tt/rmYNm7qJVcRIUngtqQ2PuwigqdaTxsnw
 tYojd8hY6ifh/cYlip/uQLAM178WdQbD6Ywm4AE6wu8Mkxc7yhyBf42YVyZbwFQHCcLV
 L6Pw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWsQDJWZ8DCzmNnR7odnsvn6+LniOBUIH3zX7bkU1jzArwFfTHDY294nlgS0mk4XdUklC71GIR/dM2snmLURFT/UKPT3bMdIHALHNpXDS6gfsTud+LgDwRLByE=
X-Gm-Message-State: AOJu0Yzjeg47y441iv3/WDbUeRMt/Miqg8gAXAlzQbs0O+Rpb1ohssi7
 Mpddkj/q7DqHPcJyQFEwEzGVChhJWx8Vi0arlDggo6mvcawgkEep
X-Google-Smtp-Source: AGHT+IHEFgV0KPcTJGIkp8fiCqAj+SybkUt2vbOO/42eNKqlBGR/I3uYVuIFtNuZPNkkSusNY27xYg==
X-Received: by 2002:a05:6e02:154b:b0:374:9e3e:cdce with SMTP id
 e9e14a558f8ab-3839a7edf09mr11004185ab.22.1720079010206; 
 Thu, 04 Jul 2024 00:43:30 -0700 (PDT)
Received: from localhost ([1.146.24.72]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-72c6c9e0ee3sm9133392a12.60.2024.07.04.00.43.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Jul 2024 00:43:29 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 04 Jul 2024 17:43:24 +1000
Message-Id: <D2GL49UTJNSH.6R2M0BOU01I8@gmail.com>
Cc: <balaton@eik.bme.hu>, <danielhb413@gmail.com>
Subject: Re: [PATCH v2 5/7] target/ppc: optimize p9 exception handling
 routines for lpcr
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Harsh Prateek Bora" <harshpb@linux.ibm.com>, <qemu-ppc@nongnu.org>,
 <qemu-devel@nongnu.org>
X-Mailer: aerc 0.17.0
References: <20240523051412.226970-1-harshpb@linux.ibm.com>
 <20240523051412.226970-6-harshpb@linux.ibm.com>
In-Reply-To: <20240523051412.226970-6-harshpb@linux.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::130;
 envelope-from=npiggin@gmail.com; helo=mail-il1-x130.google.com
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

On Thu May 23, 2024 at 3:14 PM AEST, Harsh Prateek Bora wrote:
> Like pending_interrupts, env->spr[SPR_LPCR] is being used at multiple
> places across p9 exception handlers. Pass the value during entry and
> avoid multiple indirect accesses.

Ditto for this (does it help code, other CPU functions should
be converted similarly).

Thanks,
Nick

>
> Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
> ---
>  target/ppc/excp_helper.c | 33 ++++++++++++++++++---------------
>  1 file changed, 18 insertions(+), 15 deletions(-)
>
> diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
> index 704eddac63..d3db81e6ae 100644
> --- a/target/ppc/excp_helper.c
> +++ b/target/ppc/excp_helper.c
> @@ -1843,13 +1843,14 @@ static int p8_next_unmasked_interrupt(CPUPPCState=
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
> @@ -1857,11 +1858,11 @@ static int p9_interrupt_powersave(CPUPPCState *en=
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
> @@ -1871,17 +1872,17 @@ static int p9_interrupt_powersave(CPUPPCState *en=
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
> @@ -1891,7 +1892,8 @@ static int p9_interrupt_powersave(CPUPPCState *env,
>  }
> =20
>  static int p9_next_unmasked_interrupt(CPUPPCState *env,
> -                                      uint32_t pending_interrupts)
> +                                      uint32_t pending_interrupts,
> +                                      target_ulong lpcr)
>  {
>      CPUState *cs =3D env_cpu(env);
> =20
> @@ -1906,7 +1908,7 @@ static int p9_next_unmasked_interrupt(CPUPPCState *=
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
> @@ -1924,7 +1926,7 @@ static int p9_next_unmasked_interrupt(CPUPPCState *=
env,
>      /* Hypervisor decrementer exception */
>      if (pending_interrupts & PPC_INTERRUPT_HDECR) {
>          /* LPCR will be clear when not supported so this will work */
> -        bool hdice =3D !!(env->spr[SPR_LPCR] & LPCR_HDICE);
> +        bool hdice =3D !!(lpcr & LPCR_HDICE);
>          if ((msr_ee || !FIELD_EX64_HV(env->msr)) && hdice) {
>              /* HDEC clears on delivery */
>              return PPC_INTERRUPT_HDECR;
> @@ -1934,7 +1936,7 @@ static int p9_next_unmasked_interrupt(CPUPPCState *=
env,
>      /* Hypervisor virtualization interrupt */
>      if (pending_interrupts & PPC_INTERRUPT_HVIRT) {
>          /* LPCR will be clear when not supported so this will work */
> -        bool hvice =3D !!(env->spr[SPR_LPCR] & LPCR_HVICE);
> +        bool hvice =3D !!(lpcr & LPCR_HVICE);
>          if ((msr_ee || !FIELD_EX64_HV(env->msr)) && hvice) {
>              return PPC_INTERRUPT_HVIRT;
>          }
> @@ -1942,8 +1944,8 @@ static int p9_next_unmasked_interrupt(CPUPPCState *=
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
> @@ -1992,7 +1994,8 @@ static int ppc_next_unmasked_interrupt(CPUPPCState =
*env)
>          return p8_next_unmasked_interrupt(env);
>      case POWERPC_EXCP_POWER9:
>      case POWERPC_EXCP_POWER10:
> -        return p9_next_unmasked_interrupt(env, env->pending_interrupts);
> +        return p9_next_unmasked_interrupt(env, env->pending_interrupts,
> +                                          env->spr[SPR_LPCR]);
>      default:
>          break;
>      }


