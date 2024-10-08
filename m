Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CC94CED270
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 06:50:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sy43P-0000AB-BK; Tue, 08 Oct 2024 02:50:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sy43K-0008P3-2w; Tue, 08 Oct 2024 02:50:40 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sy43I-0006R8-BW; Tue, 08 Oct 2024 02:50:37 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-20b7a4336easo38744025ad.3; 
 Mon, 07 Oct 2024 23:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728370234; x=1728975034; darn=nongnu.org;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TEABRXBOncnxF6j2IinF2gXc0DZNRsdjm/W1FMle5a4=;
 b=HOi2ESTnaGyoE0YjNXE8vi/osCJafAigYEt1604DDiF7EOFGIakYpmBnMyGYE77Wa3
 8Q+QX/u5WGknI+hiOxHyGpfT2fxqFm3VQPlB5NyQMRClJdHsoWxm/ifljqEHxPtOEz16
 SvztrF8Z84WlevKyKKW0lyJi+ADrUqzutE4pQGoG8VsfA/QI1lNWJwCrYvil2atTnIdG
 7LpGryB/QJs2q9N4TgbRoYRr9YlF77ZTniSg4T7LHs4NgjYDX/tNg3XOIIdPYLEyyWXt
 HCY+J8H5BGlkZc/gVDKKD1HucipNoMCM66TVyuZzGnMn1LsCMw3SihCAaTkDeect+CmS
 Gj4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728370234; x=1728975034;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=TEABRXBOncnxF6j2IinF2gXc0DZNRsdjm/W1FMle5a4=;
 b=ahZ31B+uRqTo07YE0bJhPlHmqkMrOgOd85OSLzUdBemGrEhMmdEV+mTZi36X+972gy
 cF3E6u0JgMfbRCyGr8EmjcyBA1Vy419mNElMzvZ5vyvnFBvoYGagj7/VkiWngUpNWwAC
 dTCZQ9pjVI54bHN5dZXENCxPxNm8ztpjvxBiE6djYTkVwkQe6dNcD93lrxhsy7+B/mX3
 7CRUvfUAvTciUR6DN94dE/b80zYWwuqd0nwp7shjEcXJqyyP2c1cpUxew+Wown2De7o7
 g6ii4+W1ah+6TYZVZQqGbm9DDe//OnaZq6yAh6Kdh0auSXmPw2AvYbXS/7xx8Y2G2Iec
 AHEg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7E7JcR91imrRNQ6v5mqF0gwfvZhg9QpnQbde5COZCOQv0sQydmX/6pDmpHKseTY/1/7zhpye2e4uq@nongnu.org,
 AJvYcCWg0KQvKY3iJQdAOjPa3wJ1rIs8Y01p1/8bI+kxsOpJ9fgXvwJoGPvC1bJgsjiN85byggp2aSXIMYc=@nongnu.org
X-Gm-Message-State: AOJu0YxIp4cx7xn0EZ9PC7TcJnQqQnX7qjGn1bqz93eVooUikpKDfJ8F
 ye8sbJXopHk7bvVh0WjZCJOZa5c9NHQShz0hxJ4UG1M0GX7e7b/v
X-Google-Smtp-Source: AGHT+IH4Y+x46bw7HSOBFc2Tq3qWg8yGAAx8JIKlHoj97MjhdESrRYaAc63AvaBhbyK2uOhLRPKNEQ==
X-Received: by 2002:a17:90a:71c8:b0:2d8:ea11:1c68 with SMTP id
 98e67ed59e1d1-2e1e635434cmr16364774a91.31.1728370234530; 
 Mon, 07 Oct 2024 23:50:34 -0700 (PDT)
Received: from localhost ([118.210.103.101]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e1e86a96e3sm8423920a91.49.2024.10.07.23.50.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Oct 2024 23:50:34 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 08 Oct 2024 16:50:30 +1000
Message-Id: <D4Q842CHNY4T.3V3CG4KQFZF9Y@gmail.com>
Subject: Re: [PATCH v3 08/10] target/ppc: optimize p7 exception handling
 routines
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Harsh Prateek Bora" <harshpb@linux.ibm.com>, <qemu-ppc@nongnu.org>,
 <qemu-devel@nongnu.org>
Cc: <balaton@eik.bme.hu>, <danielhb413@gmail.com>
X-Mailer: aerc 0.18.2
References: <20240913041337.912876-1-harshpb@linux.ibm.com>
 <20240913041337.912876-9-harshpb@linux.ibm.com>
In-Reply-To: <20240913041337.912876-9-harshpb@linux.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62d.google.com
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
> Like p8 and p9, simplifying p7 exception handling rotuines to avoid
> un-necessary multiple indirect accesses to env->pending_interrupts and
> env->spr[SPR_LPCR].

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

>
> Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
> ---
>  target/ppc/excp_helper.c | 46 ++++++++++++++++++++++------------------
>  1 file changed, 25 insertions(+), 21 deletions(-)
>
> diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
> index c0828aac88..d0e0f609a0 100644
> --- a/target/ppc/excp_helper.c
> +++ b/target/ppc/excp_helper.c
> @@ -1683,51 +1683,54 @@ void ppc_cpu_do_interrupt(CPUState *cs)
>       PPC_INTERRUPT_PIT | PPC_INTERRUPT_DOORBELL | PPC_INTERRUPT_HDOORBEL=
L | \
>       PPC_INTERRUPT_THERM | PPC_INTERRUPT_EBB)
> =20
> -static int p7_interrupt_powersave(CPUPPCState *env)
> +static int p7_interrupt_powersave(uint32_t pending_interrupts,
> +                                  target_ulong lpcr)
>  {
> -    if ((env->pending_interrupts & PPC_INTERRUPT_EXT) &&
> -        (env->spr[SPR_LPCR] & LPCR_P7_PECE0)) {
> +    if ((pending_interrupts & PPC_INTERRUPT_EXT) &&
> +        (lpcr & LPCR_P7_PECE0)) {
>          return PPC_INTERRUPT_EXT;
>      }
> -    if ((env->pending_interrupts & PPC_INTERRUPT_DECR) &&
> -        (env->spr[SPR_LPCR] & LPCR_P7_PECE1)) {
> +    if ((pending_interrupts & PPC_INTERRUPT_DECR) &&
> +        (lpcr & LPCR_P7_PECE1)) {
>          return PPC_INTERRUPT_DECR;
>      }
> -    if ((env->pending_interrupts & PPC_INTERRUPT_MCK) &&
> -        (env->spr[SPR_LPCR] & LPCR_P7_PECE2)) {
> +    if ((pending_interrupts & PPC_INTERRUPT_MCK) &&
> +        (lpcr & LPCR_P7_PECE2)) {
>          return PPC_INTERRUPT_MCK;
>      }
> -    if ((env->pending_interrupts & PPC_INTERRUPT_HMI) &&
> -        (env->spr[SPR_LPCR] & LPCR_P7_PECE2)) {
> +    if ((pending_interrupts & PPC_INTERRUPT_HMI) &&
> +        (lpcr & LPCR_P7_PECE2)) {
>          return PPC_INTERRUPT_HMI;
>      }
> -    if (env->pending_interrupts & PPC_INTERRUPT_RESET) {
> +    if (pending_interrupts & PPC_INTERRUPT_RESET) {
>          return PPC_INTERRUPT_RESET;
>      }
>      return 0;
>  }
> =20
> -static int p7_next_unmasked_interrupt(CPUPPCState *env)
> +static int p7_next_unmasked_interrupt(CPUPPCState *env,
> +                                      uint32_t pending_interrupts,
> +                                      target_ulong lpcr)
>  {
>      CPUState *cs =3D env_cpu(env);
> =20
>      /* Ignore MSR[EE] when coming out of some power management states */
>      bool msr_ee =3D FIELD_EX64(env->msr, MSR, EE) || env->resume_as_sres=
et;
> =20
> -    assert((env->pending_interrupts & P7_UNUSED_INTERRUPTS) =3D=3D 0);
> +    assert((pending_interrupts & P7_UNUSED_INTERRUPTS) =3D=3D 0);
> =20
>      if (cs->halted) {
>          /* LPCR[PECE] controls which interrupts can exit power-saving mo=
de */
> -        return p7_interrupt_powersave(env);
> +        return p7_interrupt_powersave(pending_interrupts, lpcr);
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
> @@ -1737,9 +1740,9 @@ static int p7_next_unmasked_interrupt(CPUPPCState *=
env)
>      }
> =20
>      /* External interrupt can ignore MSR:EE under some circumstances */
> -    if (env->pending_interrupts & PPC_INTERRUPT_EXT) {
> -        bool lpes0 =3D !!(env->spr[SPR_LPCR] & LPCR_LPES0);
> -        bool heic =3D !!(env->spr[SPR_LPCR] & LPCR_HEIC);
> +    if (pending_interrupts & PPC_INTERRUPT_EXT) {
> +        bool lpes0 =3D !!(lpcr & LPCR_LPES0);
> +        bool heic =3D !!(lpcr & LPCR_HEIC);
>          /* HEIC blocks delivery to the hypervisor */
>          if ((msr_ee && !(heic && FIELD_EX64_HV(env->msr) &&
>              !FIELD_EX64(env->msr, MSR, PR))) ||
> @@ -1749,10 +1752,10 @@ static int p7_next_unmasked_interrupt(CPUPPCState=
 *env)
>      }
>      if (msr_ee !=3D 0) {
>          /* Decrementer exception */
> -        if (env->pending_interrupts & PPC_INTERRUPT_DECR) {
> +        if (pending_interrupts & PPC_INTERRUPT_DECR) {
>              return PPC_INTERRUPT_DECR;
>          }
> -        if (env->pending_interrupts & PPC_INTERRUPT_PERFM) {
> +        if (pending_interrupts & PPC_INTERRUPT_PERFM) {
>              return PPC_INTERRUPT_PERFM;
>          }
>      }
> @@ -2022,7 +2025,8 @@ static int ppc_next_unmasked_interrupt(CPUPPCState =
*env)
>  #ifdef TARGET_PPC64
>      switch (env->excp_model) {
>      case POWERPC_EXCP_POWER7:
> -        return p7_next_unmasked_interrupt(env);
> +        return p7_next_unmasked_interrupt(env, env->pending_interrupts,
> +                                          env->spr[SPR_LPCR]);
>      case POWERPC_EXCP_POWER8:
>          return p8_next_unmasked_interrupt(env, env->pending_interrupts,
>                                            env->spr[SPR_LPCR]);


