Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EE45C3DA59
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 09:45:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVpb9-0000Tt-0e; Mon, 22 Jul 2024 05:44:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sVpb7-0000SM-NI
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 05:44:49 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sVpb5-0003TU-Vf
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 05:44:49 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5854ac817afso2396585a12.2
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 02:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721641486; x=1722246286; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CRGVza52LbAbO38WHL/QhboDgGFEkYSCn52ypTfv2rY=;
 b=fJkhX09QoTsSQJntGsVVqxyNdUNBdDITLyldhp4sBqnb2RsyhdDXrm1Xg5Z59CBTDO
 TrHWmv/pdfj0gUUxm0uMAeU69UvswYcsenGp4NTdKRIYUyFHrcp5S0lLnrf1U4tutrzO
 06AuceT0DFQDXyrWQjZMRbqnhEho77ssPDUtB8aMPyd1U9OW5S+RD0htir7VUfxOl6/7
 FpbCsjtsrFkiFq6xze81k6hqlwSYo477uhD8BMmS0Kc4Alv+GrJGEWXR9UIEa56OIGAx
 qLtuyHVWhcLjxZLHyHpIeolDAdLBqZEzw5S9SBcQng2bBq1dlt5wAUFZ80qa3f4UD5fX
 nYSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721641486; x=1722246286;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CRGVza52LbAbO38WHL/QhboDgGFEkYSCn52ypTfv2rY=;
 b=CfZDGZu16K/rmRC+d5lMEpXaSDvmlx2+wGqFK0kfIuacJJAU06Td7uOnqf9R1H3+og
 oE6WFfTDc8fvsVICG8EL5G3JaoeO9mvMBea9TWX0XBqsYb34RMWc6KkLbvTrUgAVG50j
 vDWV2pJwc9wlimGj6PssG5LcSVnQUWVix6wSjWuFX7nhebLnYe3bj7b0vv4YwZzbNBQi
 Xq7T7Gn6dt+XKEtOfzRL7KNY1No2MJ8F8F5GQNCeaqyN3XOFd3fhYhfkwiDUXKuTJ9GP
 Rn0258oIsslR6Ogl/l06+JKGtSUMtPAOaEtpVZVgyNKkDBiIVLu/n14Y+gDCkD+rykwb
 i8eA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW4ERyqPZ1TtFa5H848tAl1M8CE3n3Jdf4uAYMECqtxPZ9SmUegA6u7maBJVAL60qNNLum0wz6EFzC1lAKgoSvSAeOR1RE=
X-Gm-Message-State: AOJu0Yx0nnN/Vt3WmS9kTxMWvRRcCwm1xNTwuqBWfrvRlmSvXmh0oZXe
 6x/7fJQGx4i5L32985+DAf5uvWYA7+T/mGn6LNDFGXJoUy+u+qHtlV/yIBhxJn5ncC61iFEQ3QQ
 2AoWM3crZCly0OC/ui/Ade3TnUrNEY6Eo1iJZyPNBGzO3OcS4
X-Google-Smtp-Source: AGHT+IHwN2x4+T6SDtREkhRedColiALFEMEqKApKiNrn7a31Sld3F586uXqOx4iiVPrbjHOsEyIKQYJ0WDtXardECCY=
X-Received: by 2002:a50:d794:0:b0:5a1:6198:10ba with SMTP id
 4fb4d7f45d1cf-5a47b5bc28emr4142841a12.32.1721641481300; Mon, 22 Jul 2024
 02:44:41 -0700 (PDT)
MIME-Version: 1.0
References: <172158154072.9480.4077116485578955977-0@git.sr.ht>
 <4100ce91-e4e0-426a-8098-93cd29e634ec@linaro.org>
In-Reply-To: <4100ce91-e4e0-426a-8098-93cd29e634ec@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 22 Jul 2024 10:44:30 +0100
Message-ID: <CAFEAcA_A57pCQEHi_oSMvngQggfcbW9pR9+qkyQm49NQiVREnQ@mail.gmail.com>
Subject: Re: [PATCH qemu] [hw/char/bcm2835_aux] Fix receive FIFO filling up
 (raspi3)
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: "~fvanhovell" <frederik@fvhovell.nl>, qemu-trivial@nongnu.org, 
 Cryptjar <cryptjar@junk.studio>, QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x530.google.com
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

[Added missing cc of qemu-devel]

On Mon, 22 Jul 2024 at 07:33, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> On 21/7/24 18:13, ~fvanhovell wrote:
> > From: Frederik van H=C3=B6vell <frederik@fvhovell.nl>
> >
> > When a bare-metal application on the raspi3 board reads the
> > AUX_MU_STAT_REG MMIO register while the device's buffer is
> > at full receive FIFO capacity
> > (i.e. `s->read_count =3D=3D BCM2835_AUX_RX_FIFO_LEN`) the
> > assertion `assert(s->read_count < BCM2835_AUX_RX_FIFO_LEN)`
> > fails.
> >
>
> Reported-by: Cryptjar <cryptjar@junk.studio>
> Suggested-by: Cryptjar <cryptjar@junk.studio>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>
> > Resolves: https://gitlab.com/qemu-project/qemu/-/issues/459
> > Signed-off-by: Frederik van H=C3=B6vell <frederik@fvhovell.nl>
> > ---
> >   hw/char/bcm2835_aux.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/hw/char/bcm2835_aux.c b/hw/char/bcm2835_aux.c
> > index 83990e20f7..fca2f27a55 100644
> > --- a/hw/char/bcm2835_aux.c
> > +++ b/hw/char/bcm2835_aux.c
> > @@ -138,7 +138,7 @@ static uint64_t bcm2835_aux_read(void *opaque, hwad=
dr offset, unsigned size)
> >           res =3D 0x30e; /* space in the output buffer, empty tx fifo, =
idle tx/rx */
> >           if (s->read_count > 0) {
> >               res |=3D 0x1; /* data in input buffer */
> > -            assert(s->read_count < BCM2835_AUX_RX_FIFO_LEN);
> > +            assert(s->read_count <=3D BCM2835_AUX_RX_FIFO_LEN);
> >               res |=3D ((uint32_t)s->read_count) << 16; /* rx fifo fill=
 level */
> >           }
> >           return res;
>

thanks
-- PMM

