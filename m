Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0B47CD5BB6
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2024 12:07:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smBFo-0001UH-OE; Thu, 05 Sep 2024 08:06:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1smBFn-0001Sm-79
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 08:06:23 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1smBFl-0005dr-Iz
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 08:06:22 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5c3d87dd4c3so84987a12.3
 for <qemu-devel@nongnu.org>; Thu, 05 Sep 2024 05:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725537977; x=1726142777; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+mcNceJvk1zALDkqACdXnBSGvNBQ2uKqYYEnQOzlNC4=;
 b=ZoPk6zfkqoNm03I1xXZmojkIA/Wwcn+MMT3eMnjidPP1HGaeSCGcQ0BPrCz4rXBQaa
 /4N1qL2kIY+yszPvvsJDqVvWPNXu2z5qOrZeIO0pmmmwSHN21eMrlcJs2uJVVzhZ65wG
 YCai/CJYPIl1LkKmOdd6a3PD4dyVSmrqE73OBiNwv9M7i5sFthi3UkNmpp6Rk2ts7GXL
 NszLbr3z77gDTyl6GT56pK1nDIlQDBMh+6+0YrpDuQDsWm0L9gyr9ZYWpUsnXb89DNHT
 jEV+6qiPy33PSOXrnu8aD820CW8W4kovs1zR6GJM4ht/TPq5vmnhPEUYxGEqEknlPBqG
 p0Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725537977; x=1726142777;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+mcNceJvk1zALDkqACdXnBSGvNBQ2uKqYYEnQOzlNC4=;
 b=NoA/Xr5dfnLxmZFWZ0V7uDg2Ymp3WFArHVSJYLKnop0794mKYYkE5ZVXJQWMCGAXak
 mSgnVrjizbHlEc1ZyZueI1svplE/pqwa17AqfAsGyxzrSfdpRW9X6GFSaoz8S9tiRKIU
 IYnEOe4/gOZElftrz413xg+pEwoV4YXAlmxWgO2iMfifmK7Jzv/aUfsl9lsgKxDyh32z
 QIY6vzQNfxgBIG6UxlLDU4Fz34zCv2oTLgZDftf/DDDB39QkPnQbOPLEWnoTcMZoeHnd
 kUzAsuYty6x2DGdIfRltJfNvtS94dr5IpjtXmkFdmc41DECNImKbDuPpM3V1fhCZURhY
 d6UQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUhbCQMawxeHrFaUbXZD667oIomB5iO+GRGFz5SkhcxoQvirciTT96nG5XL/LVItPgT3W+G3bQnIEgw@nongnu.org
X-Gm-Message-State: AOJu0YzCDik3QOT2mBZWRxyQ2yNqbFzatWQwDdle9xZSoGShnsv0Jfwt
 /YsUTjECL8gWycy9OIKi8QPxdSJiC+JoPohATcQ+AtMUUZ6EiUoaSLCHi+fIO/y2wxSISEgifoO
 iP4cfrPJbuySEol+kQpObTJ1oQXZ/+yLlZ5SNZpgVTwHIi7mX
X-Google-Smtp-Source: AGHT+IGdmcLyKgvuRzNCg4QqdmOaIvDbVcGQw6HYE9H04cy39Mm2Gq/dO2kVooQOXkxOXhGoLiVlxT+ck6OoWLT8MBA=
X-Received: by 2002:a05:6402:1ed3:b0:5c2:5d34:a45a with SMTP id
 4fb4d7f45d1cf-5c3cd773f0bmr2232843a12.2.1725537977288; Thu, 05 Sep 2024
 05:06:17 -0700 (PDT)
MIME-Version: 1.0
References: <20240903160751.4100218-1-peter.maydell@linaro.org>
 <762867ba-8980-44f6-a9a6-5e766bc6a60b@redhat.com>
 <CAFEAcA-uTqq9Ke4pS59aQ_9t7KObRxff8DN_rY-2JkfSCQkASQ@mail.gmail.com>
 <CABgObfY--e1h=fEC=7TxA9eaHog1N4V4+3oEm+W_RSKEEUSU4w@mail.gmail.com>
In-Reply-To: <CABgObfY--e1h=fEC=7TxA9eaHog1N4V4+3oEm+W_RSKEEUSU4w@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Sep 2024 13:06:06 +0100
Message-ID: <CAFEAcA_TJ9A1MTOXhrwAHf7+g1bj0sg5utTHxnzCKF70TkC2Wg@mail.gmail.com>
Subject: Re: [PATCH for-9.2 00/53] arm: Drop deprecated boards
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
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

On Tue, 3 Sept 2024 at 18:15, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On Tue, Sep 3, 2024 at 7:04=E2=80=AFPM Peter Maydell <peter.maydell@linar=
o.org> wrote:
> > The PXA display device doesn't pass anything through to the guest,
> > by the way -- it just draws the pixels in the guest framebuffer
> > in a different place in the UI window. As the FIXME comment in
> > pxa2xx_lcd.c notes, this should really have been done in common
> > code, not in a specific display driver.
>
> spitz also passes it through SPITZ_GPIO_SWB ("Tablet mode"), though
> it's incomplete because it should have treated 180 the same as 0.

Whoops, yes -- by the time I got to grepping the sources for
uses of the graphic_rotate variable I'd already deleted
the spitz.c source file, so I missed that :-)

> > As we both note, the UI input layer part *is* generic code so it
> > will do the rotation regardless of whether the display device is
> > also rotating the guest output. But that seems to me more of
> > an accident than an intentional feature.
>
> Yes, it is, though it *is* working. On the other hand I doubt anyone
> is using it. Since we have in the past removed single options like
> -alt-grab, whoever needs it can resurrect the code from git and add
> the options to -display. They can also add rotation of the output as a
> separate knob from rotation of the input.

Yeah, I agree. I'll reroll this particular patch separately
from the rest and include a paragraph for removed-features.rst
specifically documenting that -portrait and -rotate have gone
away and why.

thanks
-- PMM

