Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4AA2C3271F
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 07:41:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPH5L-00051x-Lk; Thu, 04 Jul 2024 03:40:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sPH5H-0004rL-Ql; Thu, 04 Jul 2024 03:40:51 -0400
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sPH5F-00031Z-V1; Thu, 04 Jul 2024 03:40:51 -0400
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-700ca6171f1so152638a34.2; 
 Thu, 04 Jul 2024 00:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720078848; x=1720683648; darn=nongnu.org;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5wNaRZOe8PIC7KdNhlz2ddjH1pWwTvrVtNnTugzExJQ=;
 b=Sn3x4sKb1dX3jyU3wvJxBDo/Br4btM4SZypirREn8jgF/EWQpVqBDCRNSdWIPnOnqz
 jsPOWRp1EeUJABoPK1cstqhuKVj4dMWX/EEYyv9vvIYPi7Ux6dJiT5EKglTKDBYbRpSv
 JJjfC796Ca1ByL9bXa5Hum5AD5y9CvC2ExZ5uFyAL6nW2hx0okcD22S5p0oqXS2CUW6c
 PJ0dNYXQr4MPdVExn0SMJ2SGhKxgpo4Ho8te3wxuksyjqVtYMa57ARMX27FDVdVs5GX/
 Lb5xPtCaw5PHg0GM0RFScDTBggwWePeFFBB9izrALnqdRhUjqgeV/GyOp4z7AP4FJU1C
 X8lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720078848; x=1720683648;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=5wNaRZOe8PIC7KdNhlz2ddjH1pWwTvrVtNnTugzExJQ=;
 b=sdxOYfq4gF7yCsdGPNyhJ9maDtRsT07SA7GIgloTWXWc6fqO3syBfSruPjR0JPFuXJ
 SoaecwQqu1JNvR86UTiQraWbFVm0edTYYTYV6STxpUG32eraUN6MpLJbYFl/z++NJJHZ
 U/tRp3y5QyzHRv6xBU2D21jZhOlsSBmmC9pYIBDjrcze93BaIDVwj1DJIWpCmgSF4arX
 8XU6+J9mYXdXKd+DRzArTv+kOS7w4jf1spa254aUgF6c4Bec1nFoRKuJdmYMXgkttUz3
 miAdXawDi7HR9RIJozAxnq+LAmBk2ysII+zdA6FWLZ3CIHkwBCUC0qopZpO0haZhkjdR
 6w1g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXBhMYfarYm7gdbujQsqFiUKFSkLu13WtPjYYvFkyB3cFVPAsSYEJxR1RV2QmRpcjZ7t6627+eYm45L8+882+LpVy6AcnNhmhTRGNwt4vGoJ0YWOLl3R5PpydQ=
X-Gm-Message-State: AOJu0Ywt0FhmMCnAEpggj45pb4ejXKAFXJZl07KDItaUIH1wUd2/ZAwx
 9pJ1kglzI7JHa5I1X3z6EiUSsaKz2Fn42bRpj8I6gxMXr/mdjvME
X-Google-Smtp-Source: AGHT+IGDnepSBwWaRmdbS2NK+upbN0Bk/aLqZqMMA/Mxewn4GWIsysuSNxvcz5f0lYglkzA753FYzA==
X-Received: by 2002:a05:6358:9386:b0:19f:4ca6:86c8 with SMTP id
 e5c5f4694b2df-1aa98b8185cmr77040555d.6.1720078847589; 
 Thu, 04 Jul 2024 00:40:47 -0700 (PDT)
Received: from localhost ([1.146.24.72]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-72c69b51d3asm9049052a12.14.2024.07.04.00.40.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Jul 2024 00:40:47 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 04 Jul 2024 17:40:42 +1000
Message-Id: <D2GL27DSGRO3.KJZQZPX4OYRR@gmail.com>
Subject: Re: [PATCH v2 4/7] target/ppc: optimize p9 exception handling routines
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Harsh Prateek Bora" <harshpb@linux.ibm.com>, <qemu-ppc@nongnu.org>,
 <qemu-devel@nongnu.org>
Cc: <balaton@eik.bme.hu>, <danielhb413@gmail.com>
X-Mailer: aerc 0.17.0
References: <20240523051412.226970-1-harshpb@linux.ibm.com>
 <20240523051412.226970-5-harshpb@linux.ibm.com>
In-Reply-To: <20240523051412.226970-5-harshpb@linux.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::332;
 envelope-from=npiggin@gmail.com; helo=mail-ot1-x332.google.com
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
> Currently, p9 exception handling has multiple if-condition checks where
> it does an indirect access to pending_interrupts via env. Pass the
> value during entry to avoid multiple indirect accesses.

Does code change? I don't mind, would like all CPU funtions done
the same way if we're going to do this though.

Thanks,
Nick

>
> Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>=20
> ---
>  target/ppc/excp_helper.c | 47 +++++++++++++++++++++-------------------
>  1 file changed, 25 insertions(+), 22 deletions(-)
>
> diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
> index 0712098cf7..704eddac63 100644
> --- a/target/ppc/excp_helper.c
> +++ b/target/ppc/excp_helper.c
> @@ -1842,10 +1842,12 @@ static int p8_next_unmasked_interrupt(CPUPPCState=
 *env)
>       PPC_INTERRUPT_WDT | PPC_INTERRUPT_CDOORBELL | PPC_INTERRUPT_FIT |  =
\
>       PPC_INTERRUPT_PIT | PPC_INTERRUPT_THERM)
> =20
> -static int p9_interrupt_powersave(CPUPPCState *env)
> +static int p9_interrupt_powersave(CPUPPCState *env,
> +                                  uint32_t pending_interrupts)
>  {
> +
>      /* External Exception */
> -    if ((env->pending_interrupts & PPC_INTERRUPT_EXT) &&
> +    if ((pending_interrupts & PPC_INTERRUPT_EXT) &&
>          (env->spr[SPR_LPCR] & LPCR_EEE)) {
>          bool heic =3D !!(env->spr[SPR_LPCR] & LPCR_HEIC);
>          if (!heic || !FIELD_EX64_HV(env->msr) ||
> @@ -1854,48 +1856,49 @@ static int p9_interrupt_powersave(CPUPPCState *en=
v)
>          }
>      }
>      /* Decrementer Exception */
> -    if ((env->pending_interrupts & PPC_INTERRUPT_DECR) &&
> +    if ((pending_interrupts & PPC_INTERRUPT_DECR) &&
>          (env->spr[SPR_LPCR] & LPCR_DEE)) {
>          return PPC_INTERRUPT_DECR;
>      }
>      /* Machine Check or Hypervisor Maintenance Exception */
>      if (env->spr[SPR_LPCR] & LPCR_OEE) {
> -        if (env->pending_interrupts & PPC_INTERRUPT_MCK) {
> +        if (pending_interrupts & PPC_INTERRUPT_MCK) {
>              return PPC_INTERRUPT_MCK;
>          }
> -        if (env->pending_interrupts & PPC_INTERRUPT_HMI) {
> +        if (pending_interrupts & PPC_INTERRUPT_HMI) {
>              return PPC_INTERRUPT_HMI;
>          }
>      }
>      /* Privileged Doorbell Exception */
> -    if ((env->pending_interrupts & PPC_INTERRUPT_DOORBELL) &&
> +    if ((pending_interrupts & PPC_INTERRUPT_DOORBELL) &&
>          (env->spr[SPR_LPCR] & LPCR_PDEE)) {
>          return PPC_INTERRUPT_DOORBELL;
>      }
>      /* Hypervisor Doorbell Exception */
> -    if ((env->pending_interrupts & PPC_INTERRUPT_HDOORBELL) &&
> +    if ((pending_interrupts & PPC_INTERRUPT_HDOORBELL) &&
>          (env->spr[SPR_LPCR] & LPCR_HDEE)) {
>          return PPC_INTERRUPT_HDOORBELL;
>      }
>      /* Hypervisor virtualization exception */
> -    if ((env->pending_interrupts & PPC_INTERRUPT_HVIRT) &&
> +    if ((pending_interrupts & PPC_INTERRUPT_HVIRT) &&
>          (env->spr[SPR_LPCR] & LPCR_HVEE)) {
>          return PPC_INTERRUPT_HVIRT;
>      }
> -    if (env->pending_interrupts & PPC_INTERRUPT_RESET) {
> +    if (pending_interrupts & PPC_INTERRUPT_RESET) {
>          return PPC_INTERRUPT_RESET;
>      }
>      return 0;
>  }
> =20
> -static int p9_next_unmasked_interrupt(CPUPPCState *env)
> +static int p9_next_unmasked_interrupt(CPUPPCState *env,
> +                                      uint32_t pending_interrupts)
>  {
>      CPUState *cs =3D env_cpu(env);
> =20
>      /* Ignore MSR[EE] when coming out of some power management states */
>      bool msr_ee =3D FIELD_EX64(env->msr, MSR, EE) || env->resume_as_sres=
et;
> =20
> -    assert((env->pending_interrupts & P9_UNUSED_INTERRUPTS) =3D=3D 0);
> +    assert((pending_interrupts & P9_UNUSED_INTERRUPTS) =3D=3D 0);
> =20
>      if (cs->halted) {
>          if (env->spr[SPR_PSSCR] & PSSCR_EC) {
> @@ -1903,7 +1906,7 @@ static int p9_next_unmasked_interrupt(CPUPPCState *=
env)
>               * When PSSCR[EC] is set, LPCR[PECE] controls which interrup=
ts can
>               * wakeup the processor
>               */
> -            return p9_interrupt_powersave(env);
> +            return p9_interrupt_powersave(env, pending_interrupts);
>          } else {
>              /*
>               * When it's clear, any system-caused exception exits power-=
saving
> @@ -1914,12 +1917,12 @@ static int p9_next_unmasked_interrupt(CPUPPCState=
 *env)
>      }
> =20
>      /* Machine check exception */
> -    if (env->pending_interrupts & PPC_INTERRUPT_MCK) {
> +    if (pending_interrupts & PPC_INTERRUPT_MCK) {
>          return PPC_INTERRUPT_MCK;
>      }
> =20
>      /* Hypervisor decrementer exception */
> -    if (env->pending_interrupts & PPC_INTERRUPT_HDECR) {
> +    if (pending_interrupts & PPC_INTERRUPT_HDECR) {
>          /* LPCR will be clear when not supported so this will work */
>          bool hdice =3D !!(env->spr[SPR_LPCR] & LPCR_HDICE);
>          if ((msr_ee || !FIELD_EX64_HV(env->msr)) && hdice) {
> @@ -1929,7 +1932,7 @@ static int p9_next_unmasked_interrupt(CPUPPCState *=
env)
>      }
> =20
>      /* Hypervisor virtualization interrupt */
> -    if (env->pending_interrupts & PPC_INTERRUPT_HVIRT) {
> +    if (pending_interrupts & PPC_INTERRUPT_HVIRT) {
>          /* LPCR will be clear when not supported so this will work */
>          bool hvice =3D !!(env->spr[SPR_LPCR] & LPCR_HVICE);
>          if ((msr_ee || !FIELD_EX64_HV(env->msr)) && hvice) {
> @@ -1938,7 +1941,7 @@ static int p9_next_unmasked_interrupt(CPUPPCState *=
env)
>      }
> =20
>      /* External interrupt can ignore MSR:EE under some circumstances */
> -    if (env->pending_interrupts & PPC_INTERRUPT_EXT) {
> +    if (pending_interrupts & PPC_INTERRUPT_EXT) {
>          bool lpes0 =3D !!(env->spr[SPR_LPCR] & LPCR_LPES0);
>          bool heic =3D !!(env->spr[SPR_LPCR] & LPCR_HEIC);
>          /* HEIC blocks delivery to the hypervisor */
> @@ -1950,20 +1953,20 @@ static int p9_next_unmasked_interrupt(CPUPPCState=
 *env)
>      }
>      if (msr_ee !=3D 0) {
>          /* Decrementer exception */
> -        if (env->pending_interrupts & PPC_INTERRUPT_DECR) {
> +        if (pending_interrupts & PPC_INTERRUPT_DECR) {
>              return PPC_INTERRUPT_DECR;
>          }
> -        if (env->pending_interrupts & PPC_INTERRUPT_DOORBELL) {
> +        if (pending_interrupts & PPC_INTERRUPT_DOORBELL) {
>              return PPC_INTERRUPT_DOORBELL;
>          }
> -        if (env->pending_interrupts & PPC_INTERRUPT_HDOORBELL) {
> +        if (pending_interrupts & PPC_INTERRUPT_HDOORBELL) {
>              return PPC_INTERRUPT_HDOORBELL;
>          }
> -        if (env->pending_interrupts & PPC_INTERRUPT_PERFM) {
> +        if (pending_interrupts & PPC_INTERRUPT_PERFM) {
>              return PPC_INTERRUPT_PERFM;
>          }
>          /* EBB exception */
> -        if (env->pending_interrupts & PPC_INTERRUPT_EBB) {
> +        if (pending_interrupts & PPC_INTERRUPT_EBB) {
>              /*
>               * EBB exception must be taken in problem state and
>               * with BESCR_GE set.
> @@ -1989,7 +1992,7 @@ static int ppc_next_unmasked_interrupt(CPUPPCState =
*env)
>          return p8_next_unmasked_interrupt(env);
>      case POWERPC_EXCP_POWER9:
>      case POWERPC_EXCP_POWER10:
> -        return p9_next_unmasked_interrupt(env);
> +        return p9_next_unmasked_interrupt(env, env->pending_interrupts);
>      default:
>          break;
>      }


