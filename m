Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43E72D0E6EE
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 10:44:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2ptH-0007eD-BU; Mon, 21 Oct 2024 06:43:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t2ptF-0007di-MB
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 06:43:57 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t2ptD-0003C9-UA
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 06:43:57 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5cb6ca2a776so737573a12.0
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2024 03:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729507434; x=1730112234; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=37o+teMgXK5nVK9AwaJu04IyIsgtDOU2Tc6RrKmSKRI=;
 b=vFCc4P6Lq3b6CP+dA+kCMflcGrbkKZOmOkzE4ApIO+Skit0XNFz8e+pDf26gWoBA7w
 SDyjn5hWAxi69YVJdvfOIViZYZeSsZEdOSd5QMlab1rQJEgBermXUo+tFRQAJUZqPF2D
 8L2LRyy4t+9IeeviV1DNqPJBaw7z3iY2NdIYy2BSFbBQoIi6Tsvsgw0H5UyO549nZKxQ
 yHG1dmPLInFc+tUW4uvyfS5b5G7Xi9txk2dyOw2/nZRPvGIkURXG74yx6KJ8C4hIFrF+
 kikffW1kspmToY7GhXT3mJYjC3CDp8djt6BJaWwuHWDtL6MWV2mYQOXrA/OtuxNXyFWU
 OrUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729507434; x=1730112234;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=37o+teMgXK5nVK9AwaJu04IyIsgtDOU2Tc6RrKmSKRI=;
 b=o8LX7vsE4xPswKqWA/4Ic3fpmGXkAuo59eDxnk2IzkrHgAPEiL1DNcKb+IZtwp/vBx
 s/2V/0Z/c+g9++CopFbk+iQncTeAnU1ofxk/YDXyfnUpmYmh1AdaVL/gvV09hSgBNwr+
 9wAnkc6gs4D3NaMq4xjB+oS/DoU7oPOxlZflvLswvHHAm18az5VGryDcn+/uejkXaQT9
 0xtIRIibtslSnjxecyYPB9wmEIHCWVlYWKxSjlMGpadHPNQ2Lwdprd7wdoKCeMouaqX1
 sgzm4DEu7MSc52fQm1PaWWP5a2rLG6C1xnVlmyWUKduv+QeQ6AyAAfOaHksKnTqCd2DI
 lrzw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWdtEBLZRW4hEeGZKjVmkPqecXZ6HCZs53y8+Hfbtgw4mNE0Dq4SJVR202BWMAfD6EbWi8Or50neREV@nongnu.org
X-Gm-Message-State: AOJu0YweVYynovlN3TUBuH3Go9Y3a88br99hp2pVwG5c+W3SXem94zi0
 Gkx8JJbDP++IB9LcJ8yyXObSPyB9dvZFp66E/sbIVgFdNvpVZ5zPkverKBYyosJMnQXMXUBeHpM
 ev5KDN+3dRDKtxMhoEtWYd10nQ1VDOINeNoUaJA==
X-Google-Smtp-Source: AGHT+IGyVnet55uildmqsNeBSCttB2U4tz8ICFm+J0+MfIRHCz/JRTiXCBZtOb7Nxd+Q+PQMv4gV7NA/ZKAS2tNTilE=
X-Received: by 2002:a05:6402:2088:b0:5c9:57bd:e9d with SMTP id
 4fb4d7f45d1cf-5ca0ac6463fmr9083653a12.19.1729507433896; Mon, 21 Oct 2024
 03:43:53 -0700 (PDT)
MIME-Version: 1.0
References: <20241010173929.3910466-1-tavip@google.com>
 <CAFEAcA9X1bdtxRL9fm_rnw9ezMZSW6HaURfMsA4aLMSHM4fzdw@mail.gmail.com>
 <ZxKHSB8l1HmtxrZ6@redhat.com>
 <CAFEAcA_Q_6Vd00Hyy4cUtMCN9=nX=SxqhRAB6Fhrd5_D_jyD0A@mail.gmail.com>
 <CAGWr4cSfrONXCZd6ZaJ23F-uHBvc6nf9WZw6gmBfuHtyoUZ0VQ@mail.gmail.com>
In-Reply-To: <CAGWr4cSfrONXCZd6ZaJ23F-uHBvc6nf9WZw6gmBfuHtyoUZ0VQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 21 Oct 2024 11:43:41 +0100
Message-ID: <CAFEAcA83La0kXbCKT=wXmme9YH84fsYYvYsKeS5vB1_Tw9Z0eQ@mail.gmail.com>
Subject: Re: [RFC PATCH] cli: add connect-gpios option
To: Octavian Purdila <tavip@google.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 qemu-devel@nongnu.org, pbonzini@redhat.com, eduardo@habkost.net, 
 armbru@redhat.com, =?UTF-8?Q?Phil_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x533.google.com
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

On Fri, 18 Oct 2024 at 19:50, Octavian Purdila <tavip@google.com> wrote:
>
> On Fri, Oct 18, 2024 at 9:09=E2=80=AFAM Peter Maydell <peter.maydell@lina=
ro.org> wrote:
> > At the moment our design is "QEMU command line options are for
> > doing the equivalent of plugging in PCI cards into slots, not
> > for the equivalent of soldering chips onto boards". And in
> > that view of the world "link this gpio line from the tmp105
> > up to the armv7m interrupt controller" is not something to do on
> > the command line, because it's definitely soldering wires.
> > So for current QEMU the answer is "if the AN505 has a tmp105
> > sensor, we should be creating it in the C code for the machine,
> > and if it doesn't then we don't support creating it on the
> > command line".
> >
>
> I should have used a better example, like:
>
> qemu-system-arm \
>   --machine rt595-evk \
>   --device tmp105,bus=3D/flexcomm6-i2c,address=3D0x50 \
>   --connect-gpios in-dev-path=3D/machine/soc/gpio,in-gpio-index=3D22,\
>     out-dev-path=3D/machine/peripheral-anon/device[0]
>
> This enables use-cases like plugging in daughter cards on a board that
> has I2C/SPI/GPIO pins exposed on a header. IMO this is very similar to
> plugging in PCI cards into slots.

So in the current design framework, the way you would model
that kind of daughtercard is that you define a bus type
corresponding to the daughtercard slot. For instance, for the
Arduino Shield daughtercard spec supported by the mps3 boards,
you would define the machine models to implement that
bus (which wraps up i2c, gpio etc), and define some models
of Shield daughtercards. Then users can use "-device tmp105-shield"
on the command line and they don't need to know the internal
details of which IRQ lines on the board are supposed to be used
by the daughterboard, etc. This matches the real world hardware
where the user plugs in a daughterboard rather than soldering
wires directly between components.

Directly exposing to users a "plug GPIO lines together" interface
has some awkward sharp edges:
 * it is effectively making the QOM paths into user-facing APIs,
   which restricts our ability to refactor the implementation
   of the board without breaking existing user command lines.
   (In particular, anything using /machine/peripheral-anon/ is
   extremely vulnerable to changes in the board code.)
 * the user needs to know exactly how the board is wired up,
   including details like what GPIO inputs are free and which
   are used, and how each device orders its GPIO input lines.
 * at the moment there is no guard against trying to plug two
   GPIOs into a single output -- it just won't do the right thing.
   Currently we can say "that's a bug in QEMU C code if we do that",
   but a user-facing interface ought to be more robust.
 * how does this interact with hotpluggable devices? If you
   gpio-connect to a hotpluggable device and then hot-unplug
   it do we refuse the unplug, auto-disconnect the gpios, or
   just crash?

As I say, the "I want to be able to plug devices together on
the command line" usecase is real -- but I think that satisfying
it is something we should do with a coherent approach to the
whole problem, not piecemeal.

thanks
-- PMM

