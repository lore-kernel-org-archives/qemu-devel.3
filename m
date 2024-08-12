Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9409DC52D7C
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2024 11:11:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdSwH-000299-SA; Mon, 12 Aug 2024 07:10:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sdSwF-00028e-RR
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 07:10:12 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sdSwA-0001ah-MA
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 07:10:11 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5bb8e62570fso5016930a12.1
 for <qemu-devel@nongnu.org>; Mon, 12 Aug 2024 04:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723461003; x=1724065803; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=kuy0zVw59ylEJiKLlPgMZYx9O5PtG1zojvealrxjgh0=;
 b=Z8hEKLUMQbeH45hifvsk0OIwfvlru7A0uCQFM1yZueqTYiZpEXqPwsi/LY652//w7c
 oqsH46bQl71swzqmcwX/qzCeYQ9RLvdRf/B74dGMixswNEm9b3d5qv15xxaa3mPKiY6n
 5mBl69v17ymqOe8KCzDS1prwnua3Wa9GDtvBpD/TcxRWs8sJYfikJeyZM0X76ZgkcbHY
 qAWqBXtOq38FoDd4sGTsfYQPcSAZrKinohopr5X3hgCb4szWUbyupj1+FUFUvztPfdoz
 2fyfsB85+luvqQWgd50La8OSzS1xGR6uGOhX1oSYEHWH1QIZqPbR76N6O3g42D9ZpdDW
 MTqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723461003; x=1724065803;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kuy0zVw59ylEJiKLlPgMZYx9O5PtG1zojvealrxjgh0=;
 b=h33++eBnmEGiCkypejAxyTgQLABgapUHQOQvt2tLbvaIsNXt2CBMuuS3Pb2nge/dXQ
 +nJcrNaoEH+yTm8FBMj4j+OkeAZ4XwKmtGWUGojK/EuK0GT5b9SueBpO1YB+IKZJ38Y8
 Q8KYQ136Jfc/GGl+MolxvHtvbtZX8ciIO0vXqHL2ZC9NuOO4Zg3wgEyBGuqWjTvx73hs
 /5WHv6I/Vg0cJOdbeqV/m8szp7gLyIWw3Cb1DAKlszlNPohQrp++VDwdL49KEOrswsHd
 NavvPvmRix311hpeRf9TooT77iJ2V4j/2WwuA+hgUbWp5818Oz9mkFjShB+6m/NlSQSL
 4PuA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX8J4iiRlgdCjishDlZgdtKYReiKYU1d1+1J0sCdlfHkk9zWrhrmNXTCX2yeDGlKH7B3ergAJKaxs4rJnc/jJePkbYqiTc=
X-Gm-Message-State: AOJu0Ywhq32nrVQM43S/M6a4S6JVt3/GPIHcjRrCn7liZxLJehTaCfv8
 Iq6e0tAwIIbpXpR543qFmx98uIIm9UXR5GYBH7ohcw+FD/fo5BoNfzKJd7LPrqzzWCRRn3yH0xg
 K
X-Google-Smtp-Source: AGHT+IExw6RiioFLNCFLzHCG8gVr8QfqoB6I0S1ejrjpeF+4gl9aajbHuAlSqiFO8GKIu2PYuqhOfA==
X-Received: by 2002:a05:6402:5112:b0:5a1:a469:4d9b with SMTP id
 4fb4d7f45d1cf-5bd0a58d40emr6127386a12.13.1723461002360; 
 Mon, 12 Aug 2024 04:10:02 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5bd1a602d18sm2012684a12.89.2024.08.12.04.10.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Aug 2024 04:10:01 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E903A5F8FE;
 Mon, 12 Aug 2024 12:10:00 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>,  qemu-devel@nongnu.org
Subject: Re: [PULL 09/11] target/arm: add support for PMUv3 64-bit PMCCNTR
 in AArch32 mode
In-Reply-To: <CAFEAcA9nnzwm-OSpiAWTOtf2On27B1Hi2Fr3h=5jSKRPdnnQDQ@mail.gmail.com>
 (Peter Maydell's message of "Mon, 12 Aug 2024 10:39:36 +0100")
References: <20240809180835.1243269-1-peter.maydell@linaro.org>
 <20240809180835.1243269-10-peter.maydell@linaro.org>
 <945e5e14-9a15-4dfc-856f-f3a7d401a5bc@linaro.org>
 <CAFEAcA9nnzwm-OSpiAWTOtf2On27B1Hi2Fr3h=5jSKRPdnnQDQ@mail.gmail.com>
Date: Mon, 12 Aug 2024 12:10:00 +0100
Message-ID: <875xs6atfb.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Peter Maydell <peter.maydell@linaro.org> writes:

> On Sun, 11 Aug 2024 at 22:36, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> On 8/10/24 04:08, Peter Maydell wrote:
>> > From: Alex Richardson <alexrichardson@google.com>
>> > diff --git a/target/arm/helper.c b/target/arm/helper.c
>> > index 8fb4b474e83..94900667c33 100644
>> > --- a/target/arm/helper.c
>> > +++ b/target/arm/helper.c
>> > @@ -5952,6 +5952,12 @@ static const ARMCPRegInfo v8_cp_reginfo[] =3D {
>> >         .access =3D PL1_RW, .accessfn =3D access_trap_aa32s_el1,
>> >         .writefn =3D sdcr_write,
>> >         .fieldoffset =3D offsetoflow32(CPUARMState, cp15.mdcr_el3) },
>> > +    { .name =3D "PMCCNTR", .state =3D ARM_CP_STATE_AA32,
>> > +      .type =3D ARM_CP_ALIAS | ARM_CP_IO | ARM_CP_64BIT,
>> > +      .cp =3D 15, .crm =3D 9, .opc1 =3D 0,
>> > +      .access =3D PL0_RW, .resetvalue =3D 0, .fgt =3D FGT_PMCCNTR_EL0,
>> > +      .readfn =3D pmccntr_read, .writefn =3D pmccntr_write,
>> > +      .accessfn =3D pmreg_access_ccntr },
>> >   };
>> >
>> >   /* These are present only when EL1 supports AArch32 */
>>
>> This fails testing:
>>
>> https://gitlab.com/qemu-project/qemu/-/jobs/7551982466
>>
>> FAIL: duplicate register {'name': 'PMCCNTR', 'regnum': 96} vs {'name': '=
PMCCNTR',
>> 'regnum': 79}
>> FAIL: counted all 219 registers in XML
>> FAIL: PMCCNTR 96 =3D=3D 79 (xml)
>
> Hmm, not sure why that didn't get caught by my local testing
> or by my gitlab run -- does it only get run on an aarch64 host?

It will depend what your local GDB is like - a modern gdb-multiarch
should be fine but we do test for a minimum version to be able to probe
the supported architectures.

> Anyway, the registers do architecturally have the same name
> (they're the same register, just accessible via different
> pathways). What is our practice for this? Do we just give
> one of them a non-standard name?
>
> -- PMM

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

