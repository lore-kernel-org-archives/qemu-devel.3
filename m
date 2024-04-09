Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EC69CD1284
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 13:39:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruBg4-0005oy-3a; Tue, 09 Apr 2024 09:38:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ruBfz-0005oO-NH
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 09:38:15 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ruBfy-0008BX-4z
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 09:38:15 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-41650de9e1eso14848675e9.1
 for <qemu-devel@nongnu.org>; Tue, 09 Apr 2024 06:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712669892; x=1713274692; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KAapXbhkxXAWLitGi+5BQpI72nNXkUVLPYf/0C/E6HQ=;
 b=n581zRiOarV2TtBXaGMEYw1lRkKApyaC0WlSBzkPBp1ksPIMc8sMUSLqnOffmqCKTD
 fVgA5zTMBLX4WY0/4gyl80v1gASPQjpAszlJ1a+3Sk9DL/PDAIRVO9Z+1qZCUYt5ziT1
 Yy/q/vq79wxkrcyPaXYWHNHfcFnO2JrEpTo+/C4vMoBgH+U+UuLp+qLr9un30YGdp0rQ
 4P7zs06GBU1XF1Ck6NU2lTFXV1JE7WKITzaWvPAb9TDAmOQazJwlo+fsLV+uUXNSeezE
 u1VCA7FTCI8RURXF1xj76FMZwtigWsHc5GkUu1TUCuaEbYARJ98JEPGL9etDxcnnBIwB
 Sm6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712669892; x=1713274692;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KAapXbhkxXAWLitGi+5BQpI72nNXkUVLPYf/0C/E6HQ=;
 b=VE8uFBa57P15G1ahGw1JENj/tttdPiTY5HQPzJS7AH1713Bq18MqcXPROVUMPEZuxc
 GhH3h8GAzMPZ7NwmURD+B9WcqWRJvjcW/Oz6UKt48hIExTyySOyQTLcq58ubYcZLYd16
 3lpYjb65jOHlbv0170xc5HXGJuNWwSFjAIHmJLOWe/aluQXZc6Igqt+BW4DHL59T7Fkf
 AkTqySWeUeeV5//ZIDU0UuViSFiWQkJZblNlOl6XnPX2yMn9lNzj/E12Dov95bfNbjeg
 eaVve5mhC3UejEhQ1DuO9+HSmv9eJWzQ9Jb3GdjQKkTrylJB7hisdvRNwB6Lka0c/KIM
 xsmw==
X-Gm-Message-State: AOJu0YxHefTWrUPHPI+5ehnhAciwxCKHtpHIdZTF81EgIbJNhLABI1Ny
 p0NuEyI172YVGcoe06yQLjumQUbbRAoKqrYw/Xquh6nf7vHb6auROFWNgDYtreYsRbejYMckHz8
 kn1bsRttHS9z76kz8ujg9OK9R45SKyMZbunaBMut8AK7WCRJg
X-Google-Smtp-Source: AGHT+IHSht7OpBjcMvVk1N9lwBF3Or2JGRPYo0beplCPpxJbXtYl0N6uHNdDb6quO9qBudKxK10e0Zqk94JwuV5NgP0=
X-Received: by 2002:a05:600c:3594:b0:416:3deb:e3ef with SMTP id
 p20-20020a05600c359400b004163debe3efmr2397064wmq.1.1712669892511; Tue, 09 Apr
 2024 06:38:12 -0700 (PDT)
MIME-Version: 1.0
References: <20240409115301.21829-1-abelova@astralinux.ru>
 <CAFEAcA_W4qr6EPhOu-s_+d_V+MfADzddKNwd_gUzBTbajQ+xvg@mail.gmail.com>
 <5263ef36-0b82-48fe-a351-b557ead15b01@astralinux.ru>
In-Reply-To: <5263ef36-0b82-48fe-a351-b557ead15b01@astralinux.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 9 Apr 2024 14:38:00 +0100
Message-ID: <CAFEAcA9LTLjMtEtCfqnR8_-WSdo2ZZCb28C-roRXgcv+ULa3ww@mail.gmail.com>
Subject: Re: [PATCH] hw/dma: prevent overflow in soc_dma_set_request
To: Anastasia Belova <abelova@astralinux.ru>
Cc: qemu-devel@nongnu.org, Andrzej Zaborowski <balrogg@gmail.com>,
 sdl.qemu@linuxtesting.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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

On Tue, 9 Apr 2024 at 14:32, Anastasia Belova <abelova@astralinux.ru> wrote=
:
>
>
>
> 09/04/24 15:02, Peter Maydell =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > On Tue, 9 Apr 2024 at 12:54, Anastasia Belova <abelova@astralinux.ru> w=
rote:
> >> ch->num can reach values up to 31. Add casting to
> >> a larger type before performing left shift to
> >> prevent integer overflow.
> > If ch->num can only reach up to 31, then 1 << ch->num
> > is fine, because QEMU can assume that integers are 32 bits,
> > and we compile with -fwrapv so there isn't a problem with
> > shifting into the sign bit.
>
> Right, thanks for your comments.
> I didn't know about this flag before. It became more clear for me now.

Yep; if you're using a static analyser you probably want to
configure it to accept the behaviours that are
undefined-in-standard-C and which get defined behaviour
with -fwrapv.

This code is definitely a bit dubious, though, because
ch_enable_mask is a uint64_t, so the intention was clearly
to allow up to 64 channels. So I think we should take this
patch anyway, with a slightly adjusted commit message.

All the soc_dma.c code will probably be removed in the
9.2 release, because it's only used by the OMAP board models
which we've just deprecated, so it doesn't seem worth spending
too much time on cleaning up the code, but in this case you've
already written the patch.

I'll put this patch on my list to apply after we've made the
9.0 release and restarted development for 9.1.

thanks
-- PMM

