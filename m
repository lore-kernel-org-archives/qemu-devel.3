Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7091C3064D
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 14:52:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sM7W8-0002sW-BR; Tue, 25 Jun 2024 10:51:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lists@philjordan.eu>)
 id 1sM7W6-0002sO-Cm
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 10:51:30 -0400
Received: from mail-lj1-x22c.google.com ([2a00:1450:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lists@philjordan.eu>)
 id 1sM7W4-0002r7-5j
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 10:51:30 -0400
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2ec52fbb50bso35465581fa.2
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2024 07:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1719327085; x=1719931885;
 darn=nongnu.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4P75rDyTSplQeLAXdN/mqNMm+RR7OzIGar44BqAtbzo=;
 b=aLgTVilDotrZCyW8C23bzn4gIpkQj4Up/ijSwlsrz5SU6h4kTM8vFFOk6tQA1wWfxv
 rv/HtMsLuVNPPr4AKuVLA4TJWjYHuzGQMYfLwvmCEoMBylI9664Rnn45F8B5SuPUceBc
 UvcaO7qjp5L/+SAm3GUO40r1U/F0m9s5P0K7Kt+MJopyNWdEPLhS+1xZ3NAY1fmg4m+4
 PQw+mssup0/HRLZ4ub7+LSe/8fFUrGouUoSYVCW9iyLj+wlZIzU+cxV73ae6Ybkbpfi+
 B2W4R3glWif+WVE9pqCeiXBKc57Gu9bfraWdfTuFL0IwCyvB/qpI/aSZvTjHUmWP+Y6P
 Np1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719327085; x=1719931885;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4P75rDyTSplQeLAXdN/mqNMm+RR7OzIGar44BqAtbzo=;
 b=Hxgc0B0ABIqL2RcJtYrjp7L+Lvho0beceoZ+A6JwgxbsKM+w/EIsr99Ul2OuiQPhi7
 9BN8xRdYSvpR/z0kGLS0YLOY1A2tfm5t1NFvhWLjhURGAr3N8opGxK4go9XLm1/TUvUu
 NoEWddTZEqyc03gpQ4tRcB2+aBsgdU+w57oCSmad1MDzGrZICFiAjgvFb4pG1ixU2g8W
 tkZe5nEq6aMR3zBd1e0gTPNpBuIvf1f4Z+MAbcC2mn7SVMrfnQWlBlchfJJksNATMmp2
 QSt/mprpm0TcCs1P9ytiz0i+XA+C/uD6Wo8pl0i2+Stqd1iAGQd1qPlZkOBGfoX40Ul1
 RR0g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWUf/UQOcYnhOeCXmZOPrOGChEdwjUB1zE9xjFcTYf690DCbe4iTUtY58DQ8WB0wUMd6F8bnf75MZO0RKuySyZvNRZsiwc=
X-Gm-Message-State: AOJu0Yyn8zsRcL5lDz0aHmN3GN3wK/prs1ufR0tFNfKobi0ZGNOMZzhl
 AXoAAYf89JBG0Y3IUv/v4wZREE6oMfv/gBZtMWKIHlgDh2kyIZ4CJfzcBroOysHTLoZJnhsM4T+
 P1WSjn5aKgjoA2RdYwNSZ1kZe3Xej0dLpxPk2
X-Google-Smtp-Source: AGHT+IGRtSx3pIKqHOd3bi60PRofm16doUjFvyEZIOgUThGgXb0BpOViTy8YyeIDkzrYznUTsp5k5lwELt4ki/V2bSI=
X-Received: by 2002:a2e:998b:0:b0:2ec:59d8:a7e9 with SMTP id
 38308e7fff4ca-2ec5b3e35b1mr44979031fa.52.1719327084575; Tue, 25 Jun 2024
 07:51:24 -0700 (PDT)
MIME-Version: 1.0
References: <20240318-cursor-v1-0-0bbe6c382217@daynix.com>
 <20240318-cursor-v1-1-0bbe6c382217@daynix.com>
In-Reply-To: <20240318-cursor-v1-1-0bbe6c382217@daynix.com>
From: Phil Dennis-Jordan <lists@philjordan.eu>
Date: Tue, 25 Jun 2024 16:51:12 +0200
Message-ID: <CAGCz3vufEYgFYMUx+d2pvW-E-z3Wpar=tr79hfHTjGsXJj+n+g@mail.gmail.com>
Subject: Re: [PATCH 1/2] ui/cocoa: Add cursor composition
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>, 
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: neutral client-ip=2a00:1450:4864:20::22c;
 envelope-from=lists@philjordan.eu; helo=mail-lj1-x22c.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NEUTRAL=0.779 autolearn=no autolearn_force=no
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

On Mon, 18 Mar 2024 at 08:59, Akihiko Odaki <akihiko.odaki@daynix.com> wrot=
e:
> The common pattern to implement accelerated cursor composition is to
> replace the cursor and warp it so that the replaced cursor is shown at
> the correct position on the guest display. Unfortunately, ui/cocoa
> cannot do the same because warping the cursor position interfers with
> the mouse input so it uses CALayer instead; although it is not
> specialized for cursor composition, it still can compose images with
> hardware acceleration.

As discussed in another thread, this limitation doesn't apply when
using absolute pointer input. I much prefer "native" cursor rendering,
especially in the absolute pointer case, but this is definitely an
improvement over no cursor support at all.

Perhaps some others can chip in with preferences on the way forward.

> @@ -313,6 +318,11 @@ @interface QemuCocoaView : NSView
>      BOOL isMouseGrabbed;
>      BOOL isAbsoluteEnabled;
>      CFMachPortRef eventsTap;
> +    CALayer *cursorLayer;
> +    QEMUCursor *cursor;

As far as I can see, these can leak on dealloc.

> +    int mouseX;
> +    int mouseY;
> +    int mouseOn;

Any reason not to use a boolean type (bool or BOOL) for this?

> +- (void)setCursor:(QEMUCursor *)given_cursor
> +{
> [=E2=80=A6]
> +    image =3D CGImageCreate(
> +        cursor->width, //width
> +        cursor->height, //height
> +        8, //bitsPerComponent
> +        32, //bitsPerPixel
> +        cursor->width * 4, //bytesPerRow
> +        CGColorSpaceCreateWithName(kCGColorSpaceSRGB), //colorspace

This leaks the colour space object; CGImageCreate unfortunately does
not consume the reference.

> +        kCGBitmapByteOrder32Little | kCGImageAlphaFirst, //bitmapInfo
> +        provider, //provider
> +        NULL, //decode
> +        0, //interpolate
> +        kCGRenderingIntentDefault //intent
> +    );
> +
> +    CGDataProviderRelease(provider);
> +    [CATransaction begin];
> +    [CATransaction setDisableActions:YES];
> +    [cursorLayer setBounds:bounds];
> +    [cursorLayer setContents:(id)image];
> +    [CATransaction commit];
> +    CGImageRelease(image);
> +}

This method also runs on for quite a bit. I'd prefer some parts broken
out into a helper function or two.

