Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E4FAC3DA61
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 10:15:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYjsH-0007FG-TR; Tue, 30 Jul 2024 06:14:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sYjsG-0007Ee-3a
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 06:14:32 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sYjsE-0006Mj-9S
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 06:14:31 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5a156556fb4so6823770a12.3
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2024 03:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722334468; x=1722939268; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Au7FtTxGyg1vboFqhb0/PwS5TrSXiXPZjBJyMq9u0kw=;
 b=IDssZp1tzDlhxAQgYdj1f2tisgDIZ22CfngR+Dg0+r+nL9eHN1JDtkFsMoXA3du2Dh
 gED8DsBy5pA+MJ2cmLn9IVXxcrDFQVdrEmbdSsI6ce33bkIBYXoCgo+X7Cu+LA/wOdGK
 R0HGL4kTe6t6OTYl797MMsAl/3Lqlwe2WDXeS+XVD/FtGZM0387zYxoip/qvVtekmPYz
 MqiWP6QQD4OU+IXyCpDFAB+y3e7DXjgK54HaOkD4xibLhn1Lm6sMi9ZYNmaVPKMyZ63N
 eEASbdS8makTV+dsCRzdPF4QRikwL9OCz8D85lvLoxeFL1UkalXYIAAmrH08NvnJf6AV
 ObzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722334468; x=1722939268;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Au7FtTxGyg1vboFqhb0/PwS5TrSXiXPZjBJyMq9u0kw=;
 b=YEBo8aj6HTXnUedyETYQ41g2VCFII64Aia8Y4AZ0arIEQAAxQMth9drb04ovRqrd+v
 k8P33+aZtZ6GhPR2BCpkLc5vCQPz5rmu//WSuBu1uH6cQQidLDcGMuZEvJ7Z1i/7kJcc
 tHOjqPMgSLturoZPmk5ca9ofj1gvtqPPFMULC9xErLmOgw40k4V/BjTi8i/T5yI1N3lh
 PhTPbD+ffixpzi5LxM/NLy1W0QyQf7X2KE3O9VGD8tH1K3rSU0qDuRzVIVPzeP5iYXLf
 TfeDVtezfOFdUqAwhsHR4/wlEmpIbSMwU5hNe1TK2s7xfcr5GhWGSCzFvuqNBEv/hY8S
 n2Jw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWcUH505uxcjRcDJcjbI4aMmDMlxtOkJi/Kc9R5vgM7AxuOjqk7LyBNMYOcWBhZ2S1Lc1NGsGHNpiLI2xHk5tuXzweA4p4=
X-Gm-Message-State: AOJu0YyfL+tmL3G0ZQhlMS4FKnTTiZ2YYVvkEraAquBW3nADvg4ESODg
 iFSg66XkGZi5x6028fgswfQTNBCU/fvb6zL1t0gmkMPrG8M0+KYd+eDMYFVMvxXuXU9Q0zwrLjw
 3UkKvo5roOhacRt4/8tF0J2cy8ZQ/Fscs4r8Dng==
X-Google-Smtp-Source: AGHT+IGR1AX4MaGUVDpWC2/XjNOhuAOHj68B1gY2Z+4G7eEWjG7fCIBW8SafQgsy+LCJ95jYnMDFHeLcrDPFzrgAbCQ=
X-Received: by 2002:a50:d489:0:b0:5a2:1693:1a2f with SMTP id
 4fb4d7f45d1cf-5b0208c2d59mr6606750a12.12.1722334468474; Tue, 30 Jul 2024
 03:14:28 -0700 (PDT)
MIME-Version: 1.0
References: <20240729152714.10225-1-philmd@linaro.org>
 <Zqe2-4B8_qs3Oq0K@redhat.com>
 <d211f9c9-bef6-42b6-8bd8-8ef9cc7d6a29@linaro.org>
In-Reply-To: <d211f9c9-bef6-42b6-8bd8-8ef9cc7d6a29@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 Jul 2024 11:14:16 +0100
Message-ID: <CAFEAcA90cJV4eUktKTC38kTqANHh6Y_g8qp=Dq7+go81yfqMnA@mail.gmail.com>
Subject: Re: [PULL 00/14] Docs / testing patches for 2024-07-29
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x534.google.com
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

On Tue, 30 Jul 2024 at 11:05, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> On 29/7/24 17:36, Daniel P. Berrang=C3=A9 wrote:
> > On Mon, Jul 29, 2024 at 05:27:00PM +0200, Philippe Mathieu-Daud=C3=A9 w=
rote:
>
> >> Thomas Huth (9):
> >>    python: Install pycotap in our venv if necessary
> >>    tests/functional: Add base classes for the upcoming pytest-based te=
sts
> >>    tests/Makefile.include: Increase the level of indentation in the he=
lp
> >>      text
> >>    tests/functional: Prepare the meson build system for the functional
> >>      tests
> >>    tests/functional: Convert simple avocado tests into standalone pyth=
on
> >>      tests
> >>    tests/functional: Convert avocado tests that just need a small
> >>      adjustment
> >>    tests/functional: Convert the x86_cpu_model_versions test
> >>    tests/functional: Convert the riscv_opensbi avocado test into a
> >>      standalone test
> >>    gitlab-ci: Add "check-functional" to the build tests
> >
> > On the avocado review I mentioned that I didn't think we should
> > be rebasing avocado during freeze. By the same token, I'm not
> > convinced we should be introducing a new test framework during
> > the freeze period.  This is alot simpler than avocado, but at
> > the same time this small subset of Thomas' patches isn't really
> > fixing any problem on its own, as avocado still exists in
> > parallel.
>
> - As you noticed, Avocado isn't rebased here
> - The python file added is almost a copy of the avocado base class,
>    already well tested
> - Test are moved from Avocado, so no waste of time running them
>    twice
> - macOS developers can run 178 functional tests. This is the big
>    win and time saver for me.
>
> Do you really see merging these few patches now as being
> counter productive for the community?

I do feel from the discussion in other threads that "what is
the way forward for our currently-in-avocado test cases?" is
currently still an open question, so I tend to agree with Daniel
that it would be better to resolve that question first,
and we don't need to be in a hurry to change things in
our test framework during the freeze period.

thanks
-- PMM

