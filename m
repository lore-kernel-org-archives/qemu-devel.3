Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9AA9D13560
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Oct 2024 14:10:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t53xe-0003ZE-4e; Sun, 27 Oct 2024 10:09:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1t53xb-0003Y5-Jg
 for qemu-devel@nongnu.org; Sun, 27 Oct 2024 10:09:39 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1t53xa-0002iY-3K
 for qemu-devel@nongnu.org; Sun, 27 Oct 2024 10:09:39 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a9a2209bd7fso500718666b.2
 for <qemu-devel@nongnu.org>; Sun, 27 Oct 2024 07:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730038175; x=1730642975; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tafb9JrDk4Kgk4MLsXqL9Q3xzWZS9w7X4hXZttU68mw=;
 b=V0qrYR22pmyIYmoiigLZDg3EmUdHgC/x8NRKEqQ+X6x5BQDMcIvhgP4z6Ll28H6ZXc
 DIPxcZQ7uDozho42vgOFs3I3PM5RGTpHmGkgIq3nxWkhQ0qYOJR9ui7otjWPcSVSRVKY
 GwqCos44kGqyhIeSkQD5uJg1TBSM2f92dwGOwBD0TBGeRCSQ2nzTQ9r3k6JCEF8zGoWF
 Wt+/29s3yKmJ5OIHnrWBOzTpCbIqHWQ7394c2c1ii7DIVB2ofb7EuVoS/Z5BKIMbE173
 YqmEklZgmKMsrt707Ceyol97Seqkv9TUx6yFMgvcsuoDs6+1Gc5/a5k2itHY92f5Q8XK
 g5FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730038175; x=1730642975;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tafb9JrDk4Kgk4MLsXqL9Q3xzWZS9w7X4hXZttU68mw=;
 b=XfuX4AJIXgGP/IDUS5Vqul5Qji7RWijIKk4XHb+97UNNThCwJNAhaxDtekMnVr6YSX
 g1cFmqFGbt2MnqchEQDIQY2sa3+PyUnm84cZA0l1cAuTnaODPAF0cjS+kHgOyU1hMrKO
 XL1RtqhTdQL6QKTM6OEEHJJW5MbmknCCUqEXpUPwEBkOlQSTLL7vAE5iohZVWcNiI1lf
 bQ/uvMNGrTjjXiTbpEfYh38Z7YUv1i7KMpGvd4vzB6r6PTGTIlcZeAffu2Q5hNq5Y9E8
 yAx140xr+4QxLY8Zdm4sWzIrlaV8E9cka71mhhKeQPTz70V5fiZvc+km+xqf78me51Je
 VR4Q==
X-Gm-Message-State: AOJu0YwdnCSLqmBPrGUFlBoOdlI4iKGDf95gsKjYMNyqcK9Gh7kV7kU0
 eSACCmBKytpfxBjW9ZMMbCuSRc04l3SB03Go84sxWPUAztuqZpzLvPBSRDzDHka3+nWC1q5VVMd
 V26PENS4qYHwPyKNo9AbqPN4BH364lQMpotiD6oKzYv6yh1kJudqkRQ==
X-Google-Smtp-Source: AGHT+IFpfHLD55+U5W/3DY2C6lAeGtP+51NJBZV/jH/F2VTvc4pV0evD7fjDMQJjQr3r6cZ6fkUwuGTWrlJ/V1kov+Y=
X-Received: by 2002:a17:907:94c4:b0:a99:fc9a:5363 with SMTP id
 a640c23a62f3a-a9de5c919e4mr511244066b.9.1730038174732; Sun, 27 Oct 2024
 07:09:34 -0700 (PDT)
MIME-Version: 1.0
References: <20241025094248.152556-1-pbonzini@redhat.com>
 <m0e19.8g754qmy2u4@linaro.org>
 <e9094b82-8a23-45dc-b172-53d31abd9b32@redhat.com>
In-Reply-To: <e9094b82-8a23-45dc-b172-53d31abd9b32@redhat.com>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Sun, 27 Oct 2024 16:09:08 +0200
Message-ID: <CAAjaMXZ0b61GWgNtHeJJuykh1X_JRUVLWoKMYPPgxBpHL=uBQg@mail.gmail.com>
Subject: Re: [PATCH] rust: do not always select X_PL011_RUST
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x629.google.com
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

On Sun, Oct 27, 2024 at 3:15=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com>=
 wrote:
>
> On 10/27/24 10:49, Manos Pitsidianakis wrote:
> > On Fri, 25 Oct 2024 12:42, Paolo Bonzini <pbonzini@redhat.com> wrote:
> >> Right now the Rust pl011 device is included in all QEMU system
> >> emulator binaries if --enable-rust is passed.  This is not needed
> >> since the board logic in hw/arm/Kconfig will pick it.
> >>
> >> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> >> ---
> >> rust/hw/char/Kconfig | 1 -
> >> 1 file changed, 1 deletion(-)
> >>
> >> diff --git a/rust/hw/char/Kconfig b/rust/hw/char/Kconfig
> >> index a1732a9e97f..5fe800c4806 100644
> >> --- a/rust/hw/char/Kconfig
> >> +++ b/rust/hw/char/Kconfig
> >> @@ -1,3 +1,2 @@
> >> config X_PL011_RUST
> >>      bool
> >> -    default y if HAVE_RUST
> >> --
> >> 2.47.0
> >
> > (Do I need someone else reviewing this before picking this up in my
> > tree?)
> >
> > Acked-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
>
> Oh, I wasn't aware that you were setting up a Rust tree, since you had
> asked me to include the first round of patches.  Generally "acked-by"
> means that you are *not* going to include it in your pull requests but
> are delegating this to someone else; which would work for me because I
> have this patch included in my next pull request, which I plan on
> sending out tomorrow.
>
> Paolo
>

I wasn't in the MAINTAINERS list before that, thus had no tree for
pull requests, that's why. But yes you can pick this one sure.

