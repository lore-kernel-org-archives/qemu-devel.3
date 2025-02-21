Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59811C021AA
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 13:29:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlT5H-0004KP-88; Fri, 21 Feb 2025 08:28:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tlT58-0004K7-0P
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 08:28:42 -0500
Received: from mail-yb1-xb2b.google.com ([2607:f8b0:4864:20::b2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tlT56-0000fP-4x
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 08:28:41 -0500
Received: by mail-yb1-xb2b.google.com with SMTP id
 3f1490d57ef6-e5dbdbdaeedso2008356276.2
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2025 05:28:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740144518; x=1740749318; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qNazUzTYuP63uEdE3xYhy1j4jImEAhI9k0iJBkQeQY8=;
 b=eEobAyDrZV2o7XOEj5NhwgqmG0wGrRx1qzeeTusoWxCj7Xvbw2od1LkDkj74BN7lOx
 aR9VbyII2FLwqweppjb0sI3fG877E8wbuFYPWDzOaYxOtxrSYe43JybGp+hxfw3rteKw
 ejQFB3ulUuDL99ArXcAqaQ//DulVpfLWHdumJeg7foDHBNvmg1jLq40uQ8Tkcrn8nwMS
 0LfqWzO9H+yTK4Nl9xT0XEQ9sdhEpvkHRztTj2cxR0EerWpODsQJqD08TqysulAQwkEa
 rAnMGwjqW5wN6DaE0YuJCO+GG7+2kljrDHNo8wkwQLeAPXfXy9uij6ZHnbnIzfrCMPPO
 7ATw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740144518; x=1740749318;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qNazUzTYuP63uEdE3xYhy1j4jImEAhI9k0iJBkQeQY8=;
 b=qV3pNVGvSuPrxfuV5lt90PDpAyZ5aYvm5MmuHLeEAWaqbmADB+eBe4krTNxbkeNvmM
 NtnMhkawHrvV29J9sTg9Pgg06BSuvkAyclf6egjrP5/RFV0d98xIJDKCXrhQMpYpU1Lk
 Xu6zPJ82D0xHe7v5vNT8PefonIxXMHweQpkpjq+FPU5pkIeVnsaoYdfJXRuEXB4WXkaJ
 vM6G+dHnthc/dg3CVu4HuAIjIWo/rR1WaJPu2l8kMvqnlfMtx8D2pcSA7Er2A4ZyulIU
 aNXsdHRghPTw/ZsA6mxC7BNiIm4omHt8jXsOum9kLGfJt3/8BPyrBnGB28ByKYkzQ5tP
 LmCA==
X-Gm-Message-State: AOJu0Yyv8wFBEd99f3nRIOi/+bMTcqWpzbp+b9WnEuGge4nHWZx7cfLh
 9a2Xb0jsV3EopEJuoBSbgrn6qBRHyU28uZy4410AT84s3P3GYvKUnmeJBzJQO/al9vD3ttku2Ds
 kmJg3Kq86T8taW8Aty6MO416N8wtrcKiSz6Erglqv/VHOMThW
X-Gm-Gg: ASbGncvVPWD3ATCRJ9xxvoWwPJ2MWHsjBsXcmnrJ9YvahDlr+dMzXDjFoHdcEAC9RBX
 oMRW68x7JF/tVDVRmvutBkCDTl7x018Wxk4fos63WvEyUYFghRb1YH7jes4a6zaAp0YK0pbnGWZ
 gO8hvvuusr
X-Google-Smtp-Source: AGHT+IFGldrOMjVXzD8inMLVomENNi7a5HII/u5OMfo55/XMXaR5tc8rYL+8Yvns71lPvSVZ1jD1a4cYUb6giw/tf4E=
X-Received: by 2002:a05:6902:1546:b0:e58:835:a7b0 with SMTP id
 3f1490d57ef6-e5e2467a886mr2199462276.37.1740144518561; Fri, 21 Feb 2025
 05:28:38 -0800 (PST)
MIME-Version: 1.0
References: <20250217125055.160887-1-peter.maydell@linaro.org>
 <8215abb1-6427-4cf0-8047-4f025e1ac8d5@linaro.org>
In-Reply-To: <8215abb1-6427-4cf0-8047-4f025e1ac8d5@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 21 Feb 2025 13:28:27 +0000
X-Gm-Features: AWEUYZl-U_OJWUT_N7PY15fiPxfpKteuHl9azcPjoU2LOgW3UkqFQyoNaCYpd38
Message-ID: <CAFEAcA98ZTnDywOwOUrv+J2d7aKANPehNFRqAbED3x1USkOGMQ@mail.gmail.com>
Subject: Re: [PATCH 00/10] fpu: Remove remaining target ifdefs and build only
 once
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2b.google.com
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

On Fri, 21 Feb 2025 at 13:05, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> Hi Peter,
>
> On 17/2/25 13:50, Peter Maydell wrote:
>
> > (1) floatx80 behaviours
> >
> > Two QEMU targets implement floatx80: x86 and m68k. (PPC also has one
> > use in the xsrqpxp round-to-80-bit-precision operation, and the
> > Linux-user NWFPE emulation nominally supports it, but these are
> > minor.) x86 and m68k disagree about some of the corner cases of
> > floatx80 where the value has the explicit Integer bit wrongly set.  At
> > the moment the fpu code defaults to "floatx80 behaves like x86", with
> > TARGET_M68K ifdefs to get the other option.
> >
> > The first six patches in this series remove those ifdefs, replacing
> > them with a floatx80_behaviour field in float_status which can have
> > various flags set to select the individual behaviours. The default is
> > "like x86", which allows us to set these only for m68k and not worry
> > about the minor "technically makes some use of floatx80" cases.
>
>
> > Peter Maydell (10):
> >    fpu: Make targets specify floatx80 default Inf at runtime
> >    target/m68k: Avoid using floatx80_infinity global const
> >    target/i386: Avoid using floatx80_infinity global const
>
> Could you add a preparatory patch passing float_status argument
> here? This eases the following patch review.

I could, and in retrospect I agree it would have been a better
division of patches, but both you and RTH have already reviewed
patches 4 and 5 in their current form, so is it worth doing now ?

thanks
-- PMM

