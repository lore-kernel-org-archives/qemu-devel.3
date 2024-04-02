Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49B8ECD1284
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Apr 2024 09:08:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rra6k-000105-6I; Tue, 02 Apr 2024 05:07:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rra6A-0000mT-W2
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 05:06:37 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rra63-0002mU-4k
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 05:06:30 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-56899d9bf52so6222197a12.2
 for <qemu-devel@nongnu.org>; Tue, 02 Apr 2024 02:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712048780; x=1712653580; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Pa1Rw55yfAgpHoj1ZpIG7X1DGaasc1tvcW9Euw01upw=;
 b=N8tp44khPyuGmhNgyL7VKOOiDHudgWaD/gh46joo+9/unPaPGAU4gwVjDY0UMum4Pb
 l0zIbBEc47017oewYh/hCE43H2sONavS78mZtSSQUfAAEeHeM1/C1ykp9p5YIwtEjJSd
 ZAfwnI0KU+OEirMxUJ6BQmrhd0QJ3il4R2h9V8VnizgI2yvRfxOejmniNrKvd0mrfRso
 bp/CrCdH3cJU2NH1F43MOEozAOEl5ZJZbaWJ6aLd5dXYI16GT/lDGpmb37ReHsQCtsun
 9M5ePp8DNpYUyh9GwoqJPBs87zHgI7l5pqY4SUUpvPumIFfbW3sB8B7eUcmh97yrn4Qg
 JOsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712048780; x=1712653580;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Pa1Rw55yfAgpHoj1ZpIG7X1DGaasc1tvcW9Euw01upw=;
 b=OBo68B5EiyZvPXs2QyhRFCza0lLFT+Yq8v8yw5Tgdr6killIVY2buSdeu8aX9KGoFX
 baq2vL4xOezzmDjkK9YXla+AjjIlvX4irk6u2E96Bnz2BUXgcqNAilO89aRSMCwDBXd4
 Z5ylsfREpy1Xa4/Jgp0qVg7m3hAZp6lHxB6LvcYyvbfAzZs87u8zzeeb/5psN7r1N/dA
 wxPs9Q5tpXzThXZR8zISbY7paXY6fOWnYHq/9JQL+/53nPd0LmldUpFM2KKW81KkYg1i
 8b/mjS5ATVUheHoMlETTFcmlmxzG03kDNk7CtN0MjIgjFBiaxvg0gnxhdXM+CkvH964P
 RMMA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWXSYJLxr+7AZU7wnzcEnSqWmI8HwLCyNVWVuwfA7J3LOufEfaQxxc8/kxPXt1fE5V1b1TLpWqkK59EOJSasEfREk8wIro=
X-Gm-Message-State: AOJu0Yxb3nXnlOFzxMpmG3hIwZ+qAvYczzTmPnGY3Z/GEJ5+J6Xl3NvQ
 1dkOiDV0U+6M7OR8Jbfzroz1FF2JGj4Vlk+9HBzi08PCnjC8nSWr6ywzVazoVYMbW7QwR7ANzXV
 m+7ZTqi2bZD29YaiG8+mKEzBd1tYSqk7HOFFZ7w==
X-Google-Smtp-Source: AGHT+IG2aJcVbe7BlY2SBPL4A/ygoAaXeguVaD8JZhkRLY4ROp6ruH/GRmY3aQSlTnlICG4e9QePjSJMo9sfXAz4JbY=
X-Received: by 2002:a05:6402:5112:b0:568:1882:651f with SMTP id
 m18-20020a056402511200b005681882651fmr10271085edd.25.1712048779941; Tue, 02
 Apr 2024 02:06:19 -0700 (PDT)
MIME-Version: 1.0
References: <20240329092747.298259-1-clg@redhat.com>
In-Reply-To: <20240329092747.298259-1-clg@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 2 Apr 2024 10:06:08 +0100
Message-ID: <CAFEAcA-_gaN_3fLYuDpo1ZDBV5vw8FroaHuTuuxrK=o6p74tig@mail.gmail.com>
Subject: Re: [PATCH for-9.0] tests/qtest: Fix STM32L4x5 GPIO test on 32-bit
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Arnaud Minier <arnaud.minier@telecom-paris.fr>, 
 =?UTF-8?B?SW7DqHMgVmFyaG9s?= <ines.varhol@telecom-paris.fr>, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x535.google.com
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

On Fri, 29 Mar 2024 at 09:28, C=C3=A9dric Le Goater <clg@redhat.com> wrote:
>
> The test mangles the GPIO address and the pin number in the
> qtest_add_data_func data parameter. Doing so, it assumes that the host
> pointer size is always 64-bit, which breaks on 32-bit :
>
> ../tests/qtest/stm32l4x5_gpio-test.c: In function =E2=80=98test_gpio_outp=
ut_mode=E2=80=99:
> ../tests/qtest/stm32l4x5_gpio-test.c:272:25: error: cast from pointer to =
integer of different size [-Werror=3Dpointer-to-int-cast]
>   272 |     unsigned int pin =3D ((uint64_t)data) & 0xF;
>       |                         ^
> ../tests/qtest/stm32l4x5_gpio-test.c:273:22: error: cast from pointer to =
integer of different size [-Werror=3Dpointer-to-int-cast]
>   273 |     uint32_t gpio =3D ((uint64_t)data) >> 32;
>       |                      ^
>
> To fix, improve the mangling of the GPIO address and pin number fields
> by using GPIO_SIZE so that the resulting value fits in a 32-bit pointer.
> While at it, include some helpers to hide the details.
>
> Cc: Arnaud Minier <arnaud.minier@telecom-paris.fr>
> Cc: In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>
> Signed-off-by: C=C3=A9dric Le Goater <clg@redhat.com>



Applied to target-arm.next, thanks.

-- PMM

