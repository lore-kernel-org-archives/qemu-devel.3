Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4677C44501
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2026 15:36:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wk1f5-00034K-Lu; Wed, 15 Jul 2026 11:36:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wk1f4-00033y-KM
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 11:36:38 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wk1f2-0002qF-SB
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 11:36:38 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-493ae59eca6so12623635e9.1
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2026 08:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784129795; x=1784734595; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=avRHC4AG41F/EwiHdr3hdBwvoWPx2cKKYKi5s+hwVro=;
 b=r0VWWWF5LNnI5TavuFPy6QtqZC1lblgcPWPsZGKZnpUCGqJAD+xNeowbNzs7Pm+T/c
 Zj11yY2LT0s98xyr+M/QCK4VRTwRhp6UUhv09uNF6qYHHhpTJLS1acaLX/ObM5lqdPxi
 3KR4PSLZV8pzA73BGdiFblUrr1m9LCSJrHwJU+UGY8qkJubApYiZkTmMjWM5e12zAI95
 0YFQzg00Pd67p8P3BIKW1JExpYzk8X8xarLb1qHdBjfrHLy9qj6ZzxBmB4G7jjMsF6Rl
 Zc8/3GwQW8FmSH7IPk7b4BE7fY3cU4aC4YbR8K7gdQG1O1IhCJe3Ovh8d0Nzyqto1wQI
 i+Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784129795; x=1784734595;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=avRHC4AG41F/EwiHdr3hdBwvoWPx2cKKYKi5s+hwVro=;
 b=UI27mwASE2pfdwXc+/SqVStEeRQngEfI1ks6J5gLJEfOstjkxwN/7oeAVlGqHbplIS
 MA5R2Rg4K8t6w4mJaYZ2tXmnJHLATUYcOSiTC2xrVdlwtkW2phWTBBKOZ23TF1RKZbqK
 oi4y7/W/ETGgx7SVZuYy4MXQvGpIJVNjdM2S9N7v8C0jYWHmcuEZkEqzeRfx87+IyqCt
 c0LjzlC7qy3oVSLCgG/NmUxHPw1SExrnuuk+ekQUENRPV0NfvUCniVbZcOJa+z6Ge7NX
 ppR8bpFun25viHbhi4/0npLnzznqXl+f2JMP0IKSk9O2PwX2bVq+dz4Wxv3jzMa/ijG0
 aRbw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpqLsde1LM+MZOsWtAhuMkG3dERR6+XRsADpPnSUSIqY3tEaCNQkiVtgh8HKQz9wKf8FGiTEaroCZwD@nongnu.org
X-Gm-Message-State: AOJu0YwDCFYiSU9T4LvEAgbqyNmoW5//gA4oYAunQDTER06n6o2DGDVd
 cfu0aRzFYHpC7cQoNOLE4cLWHtE8YE0KGnLKiScRWQNwdHrfJ8tgEuqTcMvj4+jNfDU=
X-Gm-Gg: AfdE7cnYsw9k9keffrN2HZ5yCLfDqtABFi5GmXd0uekc3oS77MiPeVWYsCHapXI2agb
 y5EFY5BjpHQgT0tAy1Twh/yn4nWpDlo81o9Fqef00gDPMlb5rNgKNBho1wZyVMQULwM5cIp2Qeb
 bDx9TlR4tOyi3//M3AcEwRCR8CTTsr2cnca5FZxB+10psSz51OXjlwmmQPC7DIScFI7cq6Tl+R7
 uGhWRWxB2ZycdOptSISRZ5mJcAAxmt3LBjuYHcdIT4i5l8Y9jalsNp5BEzcytVWImOzoVP6k3oN
 HMmK4yLUrk3Jhc+GX+qByTGFRrGIKULw+Hm1jg/v96Alm4MUIpUBElIcp0b6KFWIsdufMFymDCL
 O2N9si3E0Y6GL+x7LxDlOmIsjI9LhHv+UllNiFWmnOZkwSOjRC+cOsSYGU9UQ74qXaZTOrTLFkd
 n0TOG3jAenn//8
X-Received: by 2002:a05:600c:2244:b0:495:3fe1:4ce4 with SMTP id
 5b1f17b1804b1-4953fe16503mr11210595e9.26.1784129794658; 
 Wed, 15 Jul 2026 08:36:34 -0700 (PDT)
Received: from draig.lan ([185.124.0.114]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4950a32a2casm230476735e9.12.2026.07.15.08.36.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2026 08:36:33 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id CD63B5F892;
 Wed, 15 Jul 2026 16:36:32 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: Ilya Leoshkevich <iii@linux.ibm.com>,  qemu-devel@nongnu.org,  Brian
 Cain <brian.cain@oss.qualcomm.com>,  Peter Maydell
 <peter.maydell@linaro.org>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@oss.qualcomm.com>,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>, Thomas Huth <thuth@redhat.com>,  Richard Henderson
 <richard.henderson@linaro.org>,  Manos Pitsidianakis
 <manos.pitsidianakis@linaro.org>,  Laurent Vivier <laurent@vivier.eu>,
 Paolo Bonzini <pbonzini@redhat.com>,  Gustavo Romero
 <gustavo.romero@linaro.org>,  Helge Deller <deller@gmx.de>
Subject: Re: [PATCH v5 81/98] tests/tcg/s390x: add float reference files
In-Reply-To: <e29c4eaf-b429-4566-a598-9cc18a8d1cee@oss.qualcomm.com> (Pierrick
 Bouvier's message of "Tue, 14 Jul 2026 08:37:14 -0700")
References: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
 <20260710214343.2065491-82-pierrick.bouvier@oss.qualcomm.com>
 <6738c88e-235f-4912-84a0-fe3acfe50c06@linux.ibm.com>
 <e29c4eaf-b429-4566-a598-9cc18a8d1cee@oss.qualcomm.com>
User-Agent: mu4e 1.14.3-pre1; emacs 30.1
Date: Wed, 15 Jul 2026 16:36:32 +0100
Message-ID: <871pd4i7sv.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:

> On 7/14/2026 3:47 AM, Ilya Leoshkevich wrote:
>>=20
>>=20
>> On 7/10/26 23:43, Pierrick Bouvier wrote:
>>> Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>>> ---
>>> =C2=A0 tests/tcg/s390x/float_convd.ref | 988 ++++++++++++++++++++++++++=
++++++
>>> =C2=A0 tests/tcg/s390x/float_convs.ref | 748 ++++++++++++++++++++++++
>>> =C2=A0 tests/tcg/s390x/float_madds.ref | 768 +++++++++++++++++++++++++
>>> =C2=A0 3 files changed, 2504 insertions(+)
>>> =C2=A0 create mode 100644 tests/tcg/s390x/float_convd.ref
>>> =C2=A0 create mode 100644 tests/tcg/s390x/float_convs.ref
>>> =C2=A0 create mode 100644 tests/tcg/s390x/float_madds.ref
>> Would it be possible to add an explanation to the commit message why
>> this is needed now and wasn't needed before?
>
> Before the series, we had only some arch that had those files. I have no
> clue why to be very honest, out of "people forgot to add them".

It was totally that - generally because we didn't have access to
reference hardware at the time.

>
> Makefiles were "smart" and skipped the output compare when such files
> were not available. This results in arch being very inconsistent with
> some providing all files, some providing no files, and some providing
> some files. There was even one case of a misnamed file that result in a
> skipped check.
>
> For consistency, the current series adds all missing reference files for
> all arch, and make their presence mandatory.
>
> Does it look like a good reason to you?
>
> Regards,
> Pierrick

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

