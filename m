Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89415C87FCD
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2024 17:27:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjiuW-0006TJ-Uh; Thu, 29 Aug 2024 13:26:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sjiuR-0006SO-HZ
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 13:26:13 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sjiuO-0004IL-HC
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 13:26:11 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5c210e23651so1010354a12.3
 for <qemu-devel@nongnu.org>; Thu, 29 Aug 2024 10:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724952366; x=1725557166; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Nw8G2fxey5pXqsJnNfpMwmAaWGRa7VeooNStNunD9v4=;
 b=VVMF4Yz5L7EtRZmLZuR5AhvFHriVgnzjNamgQLCuAhJ0nsOO90Skt50+75jzRy1tSz
 hzj6e/79TaFTojBoh1gE5tlZf+ZvVhKF28tQ/ccR10iVvsEzWBRt5P2iX5e5Jcoa7UzQ
 3q+8bdIEHv9nSS6n5+3NLuUR/V75IXou5CneNxnROpWWKvQIaCLBW/+cNUvx9hUpdrJJ
 QyyE6Ug8Aitjn2ZUFNttg+9eqRqK9btlzB+80rHZ+745AQ25xIw7mn1WoFxFwSdJBiEQ
 JR27twbPsk+1nNXyyXZNnBUpIq4RsvUd1Qf44bRNvwTAS2PEZQGJNzb0flb7YAP8iJmZ
 smdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724952366; x=1725557166;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Nw8G2fxey5pXqsJnNfpMwmAaWGRa7VeooNStNunD9v4=;
 b=kz4rEY7A3i9dgRbiabj7gQlTsn7yDweoJmTPSJflLtflH0h3Jtb4EQiV8xKkEdDPLL
 6HtuT8g78zCAe0oC+iR3ox5IvMlN4bQL2PUrn3CTNX5o7wM2Jr8K3aeHdyUkZBqycKyH
 3HTNDOF3XOJi+251DpwSGbGYpXuWTcvCL1Tqd1IMpyTuLyAemWeUaUJmf1wyzgXIh3lj
 GpR77xhh9WNN5fdrssiCAuA9as25Qjjjh3Tm0tbDAGG72plsRXdim1pReDH51M8+ak2E
 gyWiQ9XesBAZLWt2nJ00XYSfEOUworfk6SVzZMrGsRTldXEGtBhcpARpazsSmJ6QEG28
 Zv0w==
X-Gm-Message-State: AOJu0Yw94PUQwe89XkVPMFOubcdBxnV/wiyB3gKO3RXcd8k4ku/oxwqM
 KMTdlZ1WbnxCAGVVCetqJVM5MKDp//J6q+Gu1tp4xb37zi5jRszUxvP+B1w2qpY7YxbDnJzGBLk
 ww/i1OUE3iWnzFN3yPkiHX+ZvA1lMfle9SKq6Pw==
X-Google-Smtp-Source: AGHT+IHMqPXqkErUAjUBoZvaUhH2KyI4shkOzk+5HVskvLAcUjkln4Jbc3xonknhxGQI9nIsx6cKM8Xp6n6ddLweBSk=
X-Received: by 2002:a05:6402:50d2:b0:5c0:8b17:cefe with SMTP id
 4fb4d7f45d1cf-5c21ed96fbcmr2956929a12.26.1724952366075; Thu, 29 Aug 2024
 10:26:06 -0700 (PDT)
MIME-Version: 1.0
References: <20240305135237.3111642-1-peter.maydell@linaro.org>
 <20240305135237.3111642-18-peter.maydell@linaro.org>
 <241ba192-359c-483c-aeea-1023a47c4e74@tls.msk.ru>
 <CAFEAcA9=ALwWzRn5mitmgEELy07HaGQkesYr=w+D8ceZxg9UQw@mail.gmail.com>
In-Reply-To: <CAFEAcA9=ALwWzRn5mitmgEELy07HaGQkesYr=w+D8ceZxg9UQw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 29 Aug 2024 18:25:54 +0100
Message-ID: <CAFEAcA-zJkODkRYO_Qzi_VtMGTvHTj9qPrSBLKW5hUX9qjXJoQ@mail.gmail.com>
Subject: Re: [PULL 17/20] target/arm: Do memory type alignment check when
 translation disabled
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x535.google.com
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

On Wed, 28 Aug 2024 at 16:51, Peter Maydell <peter.maydell@linaro.org> wrot=
e:
>
> On Wed, 28 Aug 2024 at 08:22, Michael Tokarev <mjt@tls.msk.ru> wrote:
> >
> > 05.03.2024 16:52, Peter Maydell wrote:
> > > From: Richard Henderson <richard.henderson@linaro.org>
> > >
> > > If translation is disabled, the default memory type is Device, which
> > > requires alignment checking.  This is more optimally done early via
> > > the MemOp given to the TCG memory operation.
> > >
> > > Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> > > Reported-by: Idan Horowitz <idan.horowitz@gmail.com>
> > > Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> > > Message-id: 20240301204110.656742-6-richard.henderson@linaro.org
> > > Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1204
> > > Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> > > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> >
> > Hi!
> >
> > Apparently this change also breaks picolibc testsuite (between
> > 8.2 and 9.0, bisect points to this commit).
> >
> > For example:
> >
> > ./qemu-system-arm \
> >    -m 1G \
> >    -chardev stdio,mux=3Don,id=3Dstdio0 \
> >    -semihosting-config enable=3Don,chardev=3Dstdio0,arg=3Dprogram-name =
\
> >    -monitor none \
> >    -serial none \
> >    -machine none,accel=3Dtcg \
> >    -cpu cortex-a8 \
> >    -device loader,file=3D/tmp/picolibc-1.8.6/arm-none-eabi/test/printf_=
scanf_thumb_v7_fp_softfp,cpu-num=3D0 \
> >    -nographic
> >
> > (yes, this testsuite uses qemu-system as a substitute of
> > qemu-user, sort of, (ab)using -device loader)
>
> My immediate guess is that this code won't run on real hardware
> either -- i.e. that is bare-metal code that was only ever tested
> and run on QEMU and was previously relying on the incorrect
> behaviour that we didn't enforce the alignment checks that we're
> supposed to do when the MMU is off.

I had a look at the test binary you kindly provided in
https://gitlab.com/qemu-project/qemu/-/issues/2542
and that confirmed my guess. This binary would never have
worked on real hardware, and it only worked on older QEMU
because we weren't correctly emulating this corner of the
architecture. You need to either use a new enough picolibc
that you can turn on its _PICOCRT_ENABLE_MMU option, or
else make sure everything is built with gcc's -mstrict-align
or similar option to avoid any unaligned loads.

thanks
-- PMM

