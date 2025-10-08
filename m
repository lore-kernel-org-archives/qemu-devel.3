Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66957CCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 21:48:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6bzX-0002Bp-8g; Wed, 08 Oct 2025 17:46:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1v6bzT-0002Bb-3L
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 17:46:31 -0400
Received: from mail-il1-x12e.google.com ([2607:f8b0:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1v6bzN-0005iL-6L
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 17:46:30 -0400
Received: by mail-il1-x12e.google.com with SMTP id
 e9e14a558f8ab-42f90b88beaso1120625ab.3
 for <qemu-devel@nongnu.org>; Wed, 08 Oct 2025 14:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759959980; x=1760564780; darn=nongnu.org;
 h=thread-index:content-language:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=vJ8SfzIdx+SJaHWsgs83MQwO3tWBO/QOE4WeVV6EyqI=;
 b=JSsl0kDRIKhvrfMhnQNOcRF1M3wcf0Ros3/ZeBnx7v4Syt+lerpvt1a3hzpRlwrUlW
 HcFd0u/39j8e8lPc5ISwkbuBDnWu5/o6t6DvuEaEKINtpuKf6ys2lZ8Jr+dXRe0UoPkz
 pmrfM8tMLc0kEx5HCSXmrFFVaYAR4/8Wt+lTLl0CVZ05Bs0sJmIyoN1hCityE1WfnA3b
 8upP2POLsOgZZRweNh7/3/WgsMvXqzcwIFbaAmF2CPAGDZxKg1QcfP9ze8fFy7Iu9gUQ
 vljz0ICoEKYa9k0blsDGFtD6nB/GbixoJgmNEQLxnmlEpA1kOvMdEExvSA7QmjLMLPz7
 HQgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759959980; x=1760564780;
 h=thread-index:content-language:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vJ8SfzIdx+SJaHWsgs83MQwO3tWBO/QOE4WeVV6EyqI=;
 b=obBakn5FsH6wjoMYAi9AszlW5styvTIyWxTxYC9QsxVgAWYCFzZ1hl4xcGdK1WJI/O
 5WsXAnqZz81rloaUQQgqwZyD5uS905c7FD1fZU+FvSi8U50/AkGkKTo0OoWNXGDfLlIX
 2i37iCe5ycP4z2qC+BJ9UiuMZYSVjUjzicATVayVkh/FWUTYgcBeQFtBoO/syZSC4/Xm
 EGtPoNVux9t2WoHt73VL9pcip92vdWtVaZyiIy/UF/EjTbPu6SOyvw6wtXQ30sdfYJQc
 RjKZefb/jnXQB6L2t138kHRw1dLeB9i6jZItYEw3vQ4rxE9skQSZbydtpcLY42P/MG9R
 MyaA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWq15ZUQ6JXv8f7b0QfC6DdbB/cOC+0+sJe912hZzMS1QQQRNGKchtkZbS6Tj3Fz8igntND+XGr9Pur@nongnu.org
X-Gm-Message-State: AOJu0YyTfy2GTeBolpeErARfA1/5z/AiskDVXKK9oCKHqRDuk79Nof7D
 TrE2cfMLZ/SL4DjuxlJONE9zpFI2AxNz6ndD0DcNUpMWzEQObqdl6SSK
X-Gm-Gg: ASbGncvv0yZzibI7cnxNLQQlNPjgEEmZj3CphaNOGkwe7UnxHmLHEx28iDL1zu9sUMj
 dZOd9vjwD49th+VIYgoa78fK9Z/SVdBkr8X4GKoKmwanjQzecp19jS0doRS7Fs1p1boFXaPA28L
 vWABmWrsOLxpz0treycik6/o8YLeZdsBMPa16lw1sgMWmT9Wvqt4XOP0nYRxNZBDMm8dIWRAMBc
 8uWp9kxTTJRihUASux2MZorbxRzLlk4oXQC2P6ufRAaUtCWu4thvbn2ZPZKC9K5q/funemCUBug
 C0/tlROeRERPis+gYn3EuY1o9PH+28DLyxS56fH81Vli641XxRk8f7UrNkO1ww4xX0aiEURHCCH
 V6rLxxwnUui7NsMK0yosf25O+NDfz4S7C8AIjlu8roxC+PyZx32RktTC3Aw8BVHI=
X-Google-Smtp-Source: AGHT+IH3Th2TTcRcBAgT6Kw3pnlgvt/inXMX7pXPivnLrWVm9QvWZKu4iLe9A9aLFFQFn1IsLFpgbg==
X-Received: by 2002:a05:6e02:219d:b0:426:3ab1:74b4 with SMTP id
 e9e14a558f8ab-42f873ebd0fmr41747215ab.19.1759959980178; 
 Wed, 08 Oct 2025 14:46:20 -0700 (PDT)
Received: from DESKTOPUU50BPD ([2601:281:881:bb90:7176:1e71:15fd:4673])
 by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-57b5ebc87b4sm7466642173.43.2025.10.08.14.46.18
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 08 Oct 2025 14:46:19 -0700 (PDT)
From: <ltaylorsimpson@gmail.com>
To: "'Brian Cain'" <brian.cain@oss.qualcomm.com>,
	<qemu-devel@nongnu.org>
Cc: <richard.henderson@linaro.org>, <philmd@linaro.org>,
 <matheus.bernardino@oss.qualcomm.com>, <ale@rev.ng>, <anjo@rev.ng>,
 <marco.liebel@oss.qualcomm.com>, <alex.bennee@linaro.org>,
 <quic_mburton@quicinc.com>, <sid.manning@oss.qualcomm.com>,
 =?UTF-8?Q?'Alex_R=C3=B8nne_Petersen'?= <alex@alexrp.com>,
 "'Laurent Vivier'" <laurent@vivier.eu>
References: <20251008014754.3565553-1-brian.cain@oss.qualcomm.com>
In-Reply-To: <20251008014754.3565553-1-brian.cain@oss.qualcomm.com>
Subject: RE: [PATCH 1/2] linux-user/hexagon: Fix sigcontext
Date: Wed, 8 Oct 2025 15:46:17 -0600
Message-ID: <023e01dc389c$faf84320$f0e8c960$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-us
Thread-Index: AQHus+aLkVWMPesY8ig/bcBi9wF1CLSTzx0Q
Received-SPF: pass client-ip=2607:f8b0:4864:20::12e;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-il1-x12e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



> -----Original Message-----
> From: Brian Cain <brian.cain@oss.qualcomm.com>
> Sent: Tuesday, October 7, 2025 7:48 PM
> To: qemu-devel@nongnu.org
> Cc: brian.cain@oss.qualcomm.com; richard.henderson@linaro.org;
> philmd@linaro.org; matheus.bernardino@oss.qualcomm.com; ale@rev.ng;
> anjo@rev.ng; marco.liebel@oss.qualcomm.com; ltaylorsimpson@gmail.com;
> alex.bennee@linaro.org; quic_mburton@quicinc.com;
> sid.manning@oss.qualcomm.com; Alex R=C3=B8nne Petersen =
<alex@alexrp.com>;
> Laurent Vivier <laurent@vivier.eu>
> Subject: [PATCH 1/2] linux-user/hexagon: Fix sigcontext
>=20
> In order to correspond with the kernel, we've now (1) moved the =
preds[] to
> the right offset and combined the representation as a single ulong =
"p3_0", (2),
> added the cs{0,1} registers, (3) added a pad for 48 words, (4) added =
the user
> regs structure to an 8-byte aligned target_sigcontext structure.

Should you include the other control registers also (e.g., framekey)?  =
Perhaps this is a bug in the kernel as well?

>=20
> Co-authored-by: Alex R=C3=B8nne Petersen <alex@alexrp.com>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  linux-user/hexagon/signal.c | 199 =
++++++++++++++++++++----------------
>  1 file changed, 111 insertions(+), 88 deletions(-)
>=20
> diff --git a/linux-user/hexagon/signal.c b/linux-user/hexagon/signal.c =
index
> 492b51f155..6c3dbf91fa 100644
> --- a/linux-user/hexagon/signal.c
> +++ b/linux-user/hexagon/signal.c
> @@ -23,7 +23,7 @@
>  #include "signal-common.h"
>  #include "linux-user/trace.h"
>=20
> -struct target_sigcontext {
> +struct target_user_regs_struct {
>      target_ulong r0,  r1,  r2,  r3;
>      target_ulong r4,  r5,  r6,  r7;
>      target_ulong r8,  r9, r10, r11;

Consider creating an array for these, then use a for loop below.

> @@ -39,14 +39,21 @@ struct target_sigcontext {
>      target_ulong m0;
>      target_ulong m1;
>      target_ulong usr;
> +    target_ulong p3_0;
>      target_ulong gp;
>      target_ulong ugp;
>      target_ulong pc;
>      target_ulong cause;
>      target_ulong badva;
> -    target_ulong pred[NUM_PREGS];
> +    target_ulong cs0;
> +    target_ulong cs1;
> +    target_ulong pad1;
>  };
>=20
> +struct target_sigcontext {
> +    struct target_user_regs_struct sc_regs; }
> +__attribute__((aligned(8)));
> +
>  struct target_ucontext {
>      unsigned long uc_flags;
>      target_ulong uc_link; /* target pointer */ @@ -76,53 +83,63 @@ =
static
> abi_ulong get_sigframe(struct target_sigaction *ka,
>=20
>  static void setup_sigcontext(struct target_sigcontext *sc, =
CPUHexagonState
> *env)  {
> -    __put_user(env->gpr[HEX_REG_R00], &sc->r0);
> -    __put_user(env->gpr[HEX_REG_R01], &sc->r1);
> -    __put_user(env->gpr[HEX_REG_R02], &sc->r2);
> -    __put_user(env->gpr[HEX_REG_R03], &sc->r3);
> -    __put_user(env->gpr[HEX_REG_R04], &sc->r4);
> -    __put_user(env->gpr[HEX_REG_R05], &sc->r5);
> -    __put_user(env->gpr[HEX_REG_R06], &sc->r6);
> -    __put_user(env->gpr[HEX_REG_R07], &sc->r7);
> -    __put_user(env->gpr[HEX_REG_R08], &sc->r8);
> -    __put_user(env->gpr[HEX_REG_R09], &sc->r9);
> -    __put_user(env->gpr[HEX_REG_R10], &sc->r10);
> -    __put_user(env->gpr[HEX_REG_R11], &sc->r11);
> -    __put_user(env->gpr[HEX_REG_R12], &sc->r12);
> -    __put_user(env->gpr[HEX_REG_R13], &sc->r13);
> -    __put_user(env->gpr[HEX_REG_R14], &sc->r14);
> -    __put_user(env->gpr[HEX_REG_R15], &sc->r15);
> -    __put_user(env->gpr[HEX_REG_R16], &sc->r16);
> -    __put_user(env->gpr[HEX_REG_R17], &sc->r17);
> -    __put_user(env->gpr[HEX_REG_R18], &sc->r18);
> -    __put_user(env->gpr[HEX_REG_R19], &sc->r19);
> -    __put_user(env->gpr[HEX_REG_R20], &sc->r20);
> -    __put_user(env->gpr[HEX_REG_R21], &sc->r21);
> -    __put_user(env->gpr[HEX_REG_R22], &sc->r22);
> -    __put_user(env->gpr[HEX_REG_R23], &sc->r23);
> -    __put_user(env->gpr[HEX_REG_R24], &sc->r24);
> -    __put_user(env->gpr[HEX_REG_R25], &sc->r25);
> -    __put_user(env->gpr[HEX_REG_R26], &sc->r26);
> -    __put_user(env->gpr[HEX_REG_R27], &sc->r27);
> -    __put_user(env->gpr[HEX_REG_R28], &sc->r28);
> -    __put_user(env->gpr[HEX_REG_R29], &sc->r29);
> -    __put_user(env->gpr[HEX_REG_R30], &sc->r30);
> -    __put_user(env->gpr[HEX_REG_R31], &sc->r31);
> -    __put_user(env->gpr[HEX_REG_SA0], &sc->sa0);
> -    __put_user(env->gpr[HEX_REG_LC0], &sc->lc0);
> -    __put_user(env->gpr[HEX_REG_SA1], &sc->sa1);
> -    __put_user(env->gpr[HEX_REG_LC1], &sc->lc1);
> -    __put_user(env->gpr[HEX_REG_M0], &sc->m0);
> -    __put_user(env->gpr[HEX_REG_M1], &sc->m1);
> -    __put_user(env->gpr[HEX_REG_USR], &sc->usr);
> -    __put_user(env->gpr[HEX_REG_GP], &sc->gp);
> -    __put_user(env->gpr[HEX_REG_UGP], &sc->ugp);
> -    __put_user(env->gpr[HEX_REG_PC], &sc->pc);
> +    __put_user(env->gpr[HEX_REG_R00], &sc->sc_regs.r0);
> +    __put_user(env->gpr[HEX_REG_R01], &sc->sc_regs.r1);
> +    __put_user(env->gpr[HEX_REG_R02], &sc->sc_regs.r2);
> +    __put_user(env->gpr[HEX_REG_R03], &sc->sc_regs.r3);
> +    __put_user(env->gpr[HEX_REG_R04], &sc->sc_regs.r4);
> +    __put_user(env->gpr[HEX_REG_R05], &sc->sc_regs.r5);
> +    __put_user(env->gpr[HEX_REG_R06], &sc->sc_regs.r6);
> +    __put_user(env->gpr[HEX_REG_R07], &sc->sc_regs.r7);
> +    __put_user(env->gpr[HEX_REG_R08], &sc->sc_regs.r8);
> +    __put_user(env->gpr[HEX_REG_R09], &sc->sc_regs.r9);
> +    __put_user(env->gpr[HEX_REG_R10], &sc->sc_regs.r10);
> +    __put_user(env->gpr[HEX_REG_R11], &sc->sc_regs.r11);
> +    __put_user(env->gpr[HEX_REG_R12], &sc->sc_regs.r12);
> +    __put_user(env->gpr[HEX_REG_R13], &sc->sc_regs.r13);
> +    __put_user(env->gpr[HEX_REG_R14], &sc->sc_regs.r14);
> +    __put_user(env->gpr[HEX_REG_R15], &sc->sc_regs.r15);
> +    __put_user(env->gpr[HEX_REG_R16], &sc->sc_regs.r16);
> +    __put_user(env->gpr[HEX_REG_R17], &sc->sc_regs.r17);
> +    __put_user(env->gpr[HEX_REG_R18], &sc->sc_regs.r18);
> +    __put_user(env->gpr[HEX_REG_R19], &sc->sc_regs.r19);
> +    __put_user(env->gpr[HEX_REG_R20], &sc->sc_regs.r20);
> +    __put_user(env->gpr[HEX_REG_R21], &sc->sc_regs.r21);
> +    __put_user(env->gpr[HEX_REG_R22], &sc->sc_regs.r22);
> +    __put_user(env->gpr[HEX_REG_R23], &sc->sc_regs.r23);
> +    __put_user(env->gpr[HEX_REG_R24], &sc->sc_regs.r24);
> +    __put_user(env->gpr[HEX_REG_R25], &sc->sc_regs.r25);
> +    __put_user(env->gpr[HEX_REG_R26], &sc->sc_regs.r26);
> +    __put_user(env->gpr[HEX_REG_R27], &sc->sc_regs.r27);
> +    __put_user(env->gpr[HEX_REG_R28], &sc->sc_regs.r28);
> +    __put_user(env->gpr[HEX_REG_R29], &sc->sc_regs.r29);
> +    __put_user(env->gpr[HEX_REG_R30], &sc->sc_regs.r30);
> +    __put_user(env->gpr[HEX_REG_R31], &sc->sc_regs.r31);

Replace the above with a for loop when the GPRs are declared as an =
array.

> +    __put_user(env->gpr[HEX_REG_SA0], &sc->sc_regs.sa0);
> +    __put_user(env->gpr[HEX_REG_LC0], &sc->sc_regs.lc0);
> +    __put_user(env->gpr[HEX_REG_SA1], &sc->sc_regs.sa1);
> +    __put_user(env->gpr[HEX_REG_LC1], &sc->sc_regs.lc1);
> +    __put_user(env->gpr[HEX_REG_M0], &sc->sc_regs.m0);
> +    __put_user(env->gpr[HEX_REG_M1], &sc->sc_regs.m1);
> +    __put_user(env->gpr[HEX_REG_USR], &sc->sc_regs.usr);
> +    __put_user(env->gpr[HEX_REG_GP], &sc->sc_regs.gp);
> +    __put_user(env->gpr[HEX_REG_UGP], &sc->sc_regs.ugp);
> +    __put_user(env->gpr[HEX_REG_PC], &sc->sc_regs.pc);
>=20
> +    /* Consolidate predicates into p3_0 */
> +    target_ulong preds =3D 0;
>      int i;
>      for (i =3D 0; i < NUM_PREGS; i++) {
> -        __put_user(env->pred[i], &(sc->pred[i]));
> +        preds |=3D (env->pred[i] & 0xff) << (i * 8);
>      }
> +    __put_user(preds, &sc->sc_regs.p3_0);
> +
> +    /* Set cause and badva to 0 - these are set by kernel on =
exceptions */
> +    __put_user(0, &sc->sc_regs.cause);
> +    __put_user(0, &sc->sc_regs.badva);

Strange that we have this if they are ignored.  Perhaps it's to match =
the kernel behavior.

> +
> +    __put_user(env->gpr[HEX_REG_CS0], &sc->sc_regs.cs0);
> +    __put_user(env->gpr[HEX_REG_CS1], &sc->sc_regs.cs1);
>  }
>=20
>  static void setup_ucontext(struct target_ucontext *uc, @@ -192,53 =
+209,59
> @@ badframe:
>  static void restore_sigcontext(CPUHexagonState *env,
>                                 struct target_sigcontext *sc)  {
> -    __get_user(env->gpr[HEX_REG_R00], &sc->r0);
> -    __get_user(env->gpr[HEX_REG_R01], &sc->r1);
> -    __get_user(env->gpr[HEX_REG_R02], &sc->r2);
> -    __get_user(env->gpr[HEX_REG_R03], &sc->r3);
> -    __get_user(env->gpr[HEX_REG_R04], &sc->r4);
> -    __get_user(env->gpr[HEX_REG_R05], &sc->r5);
> -    __get_user(env->gpr[HEX_REG_R06], &sc->r6);
> -    __get_user(env->gpr[HEX_REG_R07], &sc->r7);
> -    __get_user(env->gpr[HEX_REG_R08], &sc->r8);
> -    __get_user(env->gpr[HEX_REG_R09], &sc->r9);
> -    __get_user(env->gpr[HEX_REG_R10], &sc->r10);
> -    __get_user(env->gpr[HEX_REG_R11], &sc->r11);
> -    __get_user(env->gpr[HEX_REG_R12], &sc->r12);
> -    __get_user(env->gpr[HEX_REG_R13], &sc->r13);
> -    __get_user(env->gpr[HEX_REG_R14], &sc->r14);
> -    __get_user(env->gpr[HEX_REG_R15], &sc->r15);
> -    __get_user(env->gpr[HEX_REG_R16], &sc->r16);
> -    __get_user(env->gpr[HEX_REG_R17], &sc->r17);
> -    __get_user(env->gpr[HEX_REG_R18], &sc->r18);
> -    __get_user(env->gpr[HEX_REG_R19], &sc->r19);
> -    __get_user(env->gpr[HEX_REG_R20], &sc->r20);
> -    __get_user(env->gpr[HEX_REG_R21], &sc->r21);
> -    __get_user(env->gpr[HEX_REG_R22], &sc->r22);
> -    __get_user(env->gpr[HEX_REG_R23], &sc->r23);
> -    __get_user(env->gpr[HEX_REG_R24], &sc->r24);
> -    __get_user(env->gpr[HEX_REG_R25], &sc->r25);
> -    __get_user(env->gpr[HEX_REG_R26], &sc->r26);
> -    __get_user(env->gpr[HEX_REG_R27], &sc->r27);
> -    __get_user(env->gpr[HEX_REG_R28], &sc->r28);
> -    __get_user(env->gpr[HEX_REG_R29], &sc->r29);
> -    __get_user(env->gpr[HEX_REG_R30], &sc->r30);
> -    __get_user(env->gpr[HEX_REG_R31], &sc->r31);
> -    __get_user(env->gpr[HEX_REG_SA0], &sc->sa0);
> -    __get_user(env->gpr[HEX_REG_LC0], &sc->lc0);
> -    __get_user(env->gpr[HEX_REG_SA1], &sc->sa1);
> -    __get_user(env->gpr[HEX_REG_LC1], &sc->lc1);
> -    __get_user(env->gpr[HEX_REG_M0], &sc->m0);
> -    __get_user(env->gpr[HEX_REG_M1], &sc->m1);
> -    __get_user(env->gpr[HEX_REG_USR], &sc->usr);
> -    __get_user(env->gpr[HEX_REG_GP], &sc->gp);
> -    __get_user(env->gpr[HEX_REG_UGP], &sc->ugp);
> -    __get_user(env->gpr[HEX_REG_PC], &sc->pc);
> +    __get_user(env->gpr[HEX_REG_R00], &sc->sc_regs.r0);
> +    __get_user(env->gpr[HEX_REG_R01], &sc->sc_regs.r1);
> +    __get_user(env->gpr[HEX_REG_R02], &sc->sc_regs.r2);
> +    __get_user(env->gpr[HEX_REG_R03], &sc->sc_regs.r3);
> +    __get_user(env->gpr[HEX_REG_R04], &sc->sc_regs.r4);
> +    __get_user(env->gpr[HEX_REG_R05], &sc->sc_regs.r5);
> +    __get_user(env->gpr[HEX_REG_R06], &sc->sc_regs.r6);
> +    __get_user(env->gpr[HEX_REG_R07], &sc->sc_regs.r7);
> +    __get_user(env->gpr[HEX_REG_R08], &sc->sc_regs.r8);
> +    __get_user(env->gpr[HEX_REG_R09], &sc->sc_regs.r9);
> +    __get_user(env->gpr[HEX_REG_R10], &sc->sc_regs.r10);
> +    __get_user(env->gpr[HEX_REG_R11], &sc->sc_regs.r11);
> +    __get_user(env->gpr[HEX_REG_R12], &sc->sc_regs.r12);
> +    __get_user(env->gpr[HEX_REG_R13], &sc->sc_regs.r13);
> +    __get_user(env->gpr[HEX_REG_R14], &sc->sc_regs.r14);
> +    __get_user(env->gpr[HEX_REG_R15], &sc->sc_regs.r15);
> +    __get_user(env->gpr[HEX_REG_R16], &sc->sc_regs.r16);
> +    __get_user(env->gpr[HEX_REG_R17], &sc->sc_regs.r17);
> +    __get_user(env->gpr[HEX_REG_R18], &sc->sc_regs.r18);
> +    __get_user(env->gpr[HEX_REG_R19], &sc->sc_regs.r19);
> +    __get_user(env->gpr[HEX_REG_R20], &sc->sc_regs.r20);
> +    __get_user(env->gpr[HEX_REG_R21], &sc->sc_regs.r21);
> +    __get_user(env->gpr[HEX_REG_R22], &sc->sc_regs.r22);
> +    __get_user(env->gpr[HEX_REG_R23], &sc->sc_regs.r23);
> +    __get_user(env->gpr[HEX_REG_R24], &sc->sc_regs.r24);
> +    __get_user(env->gpr[HEX_REG_R25], &sc->sc_regs.r25);
> +    __get_user(env->gpr[HEX_REG_R26], &sc->sc_regs.r26);
> +    __get_user(env->gpr[HEX_REG_R27], &sc->sc_regs.r27);
> +    __get_user(env->gpr[HEX_REG_R28], &sc->sc_regs.r28);
> +    __get_user(env->gpr[HEX_REG_R29], &sc->sc_regs.r29);
> +    __get_user(env->gpr[HEX_REG_R30], &sc->sc_regs.r30);
> +    __get_user(env->gpr[HEX_REG_R31], &sc->sc_regs.r31);

Replace the above with a for loop when the GPRs are declared as an =
array.=20

> +    __get_user(env->gpr[HEX_REG_SA0], &sc->sc_regs.sa0);
> +    __get_user(env->gpr[HEX_REG_LC0], &sc->sc_regs.lc0);
> +    __get_user(env->gpr[HEX_REG_SA1], &sc->sc_regs.sa1);
> +    __get_user(env->gpr[HEX_REG_LC1], &sc->sc_regs.lc1);
> +    __get_user(env->gpr[HEX_REG_M0], &sc->sc_regs.m0);
> +    __get_user(env->gpr[HEX_REG_M1], &sc->sc_regs.m1);
> +    __get_user(env->gpr[HEX_REG_USR], &sc->sc_regs.usr);
> +    __get_user(env->gpr[HEX_REG_GP], &sc->sc_regs.gp);
> +    __get_user(env->gpr[HEX_REG_UGP], &sc->sc_regs.ugp);
> +    __get_user(env->gpr[HEX_REG_PC], &sc->sc_regs.pc);
>=20
> +    /* Restore predicates from p3_0 */
> +    target_ulong preds;
> +    __get_user(preds, &sc->sc_regs.p3_0);
>      int i;
>      for (i =3D 0; i < NUM_PREGS; i++) {
> -        __get_user(env->pred[i], &(sc->pred[i]));
> +        env->pred[i] =3D (preds >> (i * 8)) & 0xff;
>      }
> +
> +    __get_user(env->gpr[HEX_REG_CS0], &sc->sc_regs.cs0);
> +    __get_user(env->gpr[HEX_REG_CS1], &sc->sc_regs.cs1);
>  }
>=20
>  static void restore_ucontext(CPUHexagonState *env, struct =
target_ucontext
> *uc)
> --
> 2.34.1



