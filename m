Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70610C02198
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 13:56:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkO49-0005mH-I9; Tue, 18 Feb 2025 08:55:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tkO46-0005kt-S2
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 08:55:11 -0500
Received: from mail-yw1-x112d.google.com ([2607:f8b0:4864:20::112d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tkO45-0001gL-1u
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 08:55:10 -0500
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-6f972c031efso54095547b3.1
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2025 05:55:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739886907; x=1740491707; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=39fn1BS3vuf40TnRJ0SE8lCne6FUxR6xiuWLRie0Qos=;
 b=bNjaeLvB4PxaLI1f3flawagnnuieDjeeYJdt+cBnVAzqHwKuf9gnny9LZVVf2WMJEW
 lcYkKkHWoWm60fWTAFxacbAEyTtWH+siuf1Al3MgVSsz+i1o7JCK9ngxSwCjYGgKp9BT
 qFCwaDxfZdKu+dPFVgmvtWLugH2fQ/Ftqu9+Qv4MGH/IFhNgM1syZzW1ytGWRokftehS
 obeWGmwNKyw8G+yhRCQggp2knqfAljl529hVw/EwAaemfZMZA4OtUruvM23crtbx3/YI
 MQvPObaHQe6P983Sj9gZuBP5Evp6Fd11LDBuHR5pzH4vd/F0A4tLxyTvo5NOTDQwCBX3
 USyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739886907; x=1740491707;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=39fn1BS3vuf40TnRJ0SE8lCne6FUxR6xiuWLRie0Qos=;
 b=Z16YtDR17SykF19Aw50qI3AmxpIvMVm83vYh1FFB1zdCieqrniCHMZUjEm7k4qQB5W
 sKh+aJYdDXrgGxythy0MlB/hr3K3gf1PQCW9YnjafKNbSZqXqu7IlTukwZBVD+Gh6LRE
 TfJatahBtcKCtgPiflIA29ZJf0a663ENcQnYKEZFvKFocsp2WX6Vpy2quClzullGGJMj
 3H0p8IcYnUF5FFdNc50RfCJk0WaePz3bE7c/RGD4VU/dwCgJ8EXp2fch4Lb9TPqjlF+h
 e2mn3O75CXV4SXKadsyyoQTDcdqIsZ+uVF4rr/weU3CXDRWImhaHyxROh75BLyFbXdfI
 BSGQ==
X-Gm-Message-State: AOJu0YxQNep+gKCgg1/Adh9mlfUYCU6GIroH9llLj2dm8mJqaK9C41RS
 plsmLzNvIRdphnw+Ze+Q6KW2+bNz6gX2QlDvmbLQ1zS4LQ32i2zjH1h1vsvpnoDHoEvxlmriDYt
 e/dVLHvmJzGoxOPMCZjmmzHYcm3dfGZ8Yrra4bA==
X-Gm-Gg: ASbGncsBVXwV7B6RADM/jJ0Ltf/xFr2NbwjC3w/qp1tAdClL53sw9441BFpgDX8e1Le
 COMtI3W9E33Hqh69NuHVveq4/sxdqdrsGqscKUlNEbUmrqSS+riDqjGlj4zgA6V09REDxheFtNg
 ==
X-Google-Smtp-Source: AGHT+IGVCuthWFQAA8eqh0bykJgVjjswKOY+Z0sUC4HSC9ekQacmG8hCajtYaV/IzJ3UQLdLUTaTpYlud97iDLd85Nw=
X-Received: by 2002:a05:6902:c06:b0:e5b:3d71:bff1 with SMTP id
 3f1490d57ef6-e5da9eb14f1mr17190459276.0.1739886907134; Tue, 18 Feb 2025
 05:55:07 -0800 (PST)
MIME-Version: 1.0
References: <20250208163911.54522-1-philmd@linaro.org>
 <CAFEAcA8PYv3-JX66THwj-mDM0es6V5gVVWJsHTqkd9wTEVor4A@mail.gmail.com>
In-Reply-To: <CAFEAcA8PYv3-JX66THwj-mDM0es6V5gVVWJsHTqkd9wTEVor4A@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 18 Feb 2025 13:54:55 +0000
X-Gm-Features: AWEUYZnAZ3KPEu27SvYRa3093KcYYrD48TSXN3xhNyE1aBE_lWOl7Fze5E7ctQE
Message-ID: <CAFEAcA-ioFgThGJ70cyhe7rA0kbnDULsr-BuAqE+3b3TE0BGwg@mail.gmail.com>
Subject: Re: [PATCH v6 0/7] hw/char/pl011: Implement TX (async) FIFO to avoid
 blocking the main loop
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112d.google.com
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

On Mon, 17 Feb 2025 at 14:55, Peter Maydell <peter.maydell@linaro.org> wrot=
e:
>
> On Sat, 8 Feb 2025 at 16:39, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.o=
rg> wrote:
> >
> > Hi,
> >
> > This series add support for (async) FIFO on the transmit path
> > of the PL011 UART.
> >
>
> Applied to target-arm.next, thanks (with a couple of minor
> tweaks to two of the patches).

Unfortunately I seem to get failures in 'make check-functional'
with the last patch of this series applied. This is with a
clang sanitizer build on ubuntu 24.04:
'../../configure' '--cc=3Dclang' '--cxx=3Dclang++' '--enable-ubsan'
'--target-list=3Darm-softmmu,arm-linux-user,aarch64-softmmu,aarch64-linux-u=
ser'

and the tests that fail are:
42/44 qemu:func-thorough+func-aarch64-thorough+thorough /
func-aarch64-aarch64_xlnx_versal     TIMEOUT          90.01s   killed
by signal 15 SIGTERM
43/44 qemu:func-thorough+func-aarch64-thorough+thorough /
func-aarch64-aarch64_raspi4          TIMEOUT         480.01s   killed
by signal 15 SIGTERM
44/44 qemu:func-thorough+func-aarch64-thorough+thorough /
func-aarch64-aarch64_virt            TIMEOUT         720.01s   killed
by signal 15 SIGTERM

Looking at the test logs it looks like the test framework
starts QEMU but there is never any output from the guest
console.

I've dropped the patchset from target-arm.next for the moment.

thanks
-- PMM

