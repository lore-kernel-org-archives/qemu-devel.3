Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DADFCC02196
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 15:09:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfKXc-0002jm-7m; Tue, 04 Feb 2025 10:08:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tfKXZ-0002dM-K0
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 10:08:41 -0500
Received: from mail-yb1-xb29.google.com ([2607:f8b0:4864:20::b29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tfKXY-0006Bu-6R
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 10:08:41 -0500
Received: by mail-yb1-xb29.google.com with SMTP id
 3f1490d57ef6-e580d6211c8so5764751276.1
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2025 07:08:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738681718; x=1739286518; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x8PytlqhHLULq87UYWJlTlSEDli7Ujv2u27vNHepCtI=;
 b=FQ5NoZexMBH914pE8JeORXrbKboVKak4PTwtZIz558bKZHG9/oHYkHqEEYLHqFvOfP
 bzp5pzOkeMnM845VIELjsvgx/fApsP3+38bLh0kVllWE5pKdzKZ943B0FtsampFxOSUI
 6rTmLZmCwadMCc+9+fsgq3SfYsbara/ZbDXMsa90tg0LYLkxgdN20hR3wzJ2qv0JBIIx
 UuWAqlDyDYS4pOJYzsxJilpf6Pz2omJ1iGQR94R5Lsdifl8s8VFIhHl0RP2KinYwK6aw
 DTOVOJAEzxTqf1H7WejB8Fmansxb51lPjPFR6MZbuL0XiCd46ijZD0d5pA2e5XaMP/2m
 fLPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738681718; x=1739286518;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x8PytlqhHLULq87UYWJlTlSEDli7Ujv2u27vNHepCtI=;
 b=AXEd7chGpH7NYXwxbPKB5hwpW9wBTZQu3il9X7quyz+SievLOcbCga9qOj/+FaAdW/
 tUdBDYI+9XRSVkqEybIVB9es9ka+btUhLNWTmRqv9lHB5lmrhUmkOqJpPu1zQegc33Us
 516MiryA5uwOZmjjtPj9+c/+KBDSc++fKtQlarvwSlW177jQH/w00QRZDCog1Sp8jqdV
 3EQ58SvqZBJlJhcWnFh5nQO2P/XluGPY9W3WimnJstCyIG95ygc6bgw97BlhMbUL5xqk
 w7IDEZt6jqdRZopZ7lIhwE3m/OAeTqxyC4p7adNCpk0hpdQKa9IeVms+EIUVQc8z2iIO
 aGaA==
X-Gm-Message-State: AOJu0YyVQrmA82sk7AebwpocKTZrIHZb57RpSMs+2i5q9RgxTw0Xx5nG
 e1gAXzlBw4cTVJBM0lWg4perY1QTR2e8cGzctqDuFnGdWmG5s+v7Spt0CisJP3y0JlrEel4oSDE
 J4gMoxlA0RTC26WqXsqxK2hdQRbD8v30DS3KKyA==
X-Gm-Gg: ASbGncuw2VrSZr/tjotBndkRG0eSecv0gVLxh1sHJfONDuvflaeFFGQ5eL3BBtL3Vd7
 RmIwPoSscDiqhcZufsUWeWioQ/0BPD3xuwI/IlGiwT1YbO0LNxQ4lHiePNlM3BBxIRyonQqsQqg
 ==
X-Google-Smtp-Source: AGHT+IE7YAOvh2lU0RxDcDVz8ZP2w6hvhd11Qzh95CIurf0+u3yXxCQ4hKnwi1SXjO5BGpTWTIOu0AJ05dG05Bb/lB8=
X-Received: by 2002:a05:6902:2089:b0:e5b:233c:18c with SMTP id
 3f1490d57ef6-e5b233c031cmr9746276.7.1738681718524; Tue, 04 Feb 2025 07:08:38
 -0800 (PST)
MIME-Version: 1.0
References: <20250204002240.97830-1-philmd@linaro.org>
 <20250204002240.97830-6-philmd@linaro.org>
In-Reply-To: <20250204002240.97830-6-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 4 Feb 2025 15:08:27 +0000
X-Gm-Features: AWEUYZmpOc3Td8urmScwPSNFypD6MR5pMwL1WXgOB69yu7GxOK3fEA1V33SZj0E
Message-ID: <CAFEAcA-KzF2iEhxNqvEBkgg6qUrnuBJZR_tEUG8Zu4qrrcdQkA@mail.gmail.com>
Subject: Re: [PATCH v2 05/12] hw/arm/raspi: Consider processor id in types[]
 array
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 BALATON Zoltan <balaton@eik.bme.hu>, Laurent Vivier <lvivier@redhat.com>, 
 Ovchinnikov Vitalii <vitalii.ovchinnikov@auriga.com>,
 Jared Mauch <jared+home@puck.nether.net>, 
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 devel@lists.libvirt.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b29;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb29.google.com
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

On Tue, 4 Feb 2025 at 00:23, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org=
> wrote:
>
> Expand the current type2model array to include the processor id.
>
> Since the BCM2838 is indistinctly used as BCM2711 (within the
> Linux community), add it as alias in RaspiProcessorId.

Can you explain this in more detail? Presumably the hardware
itself has whatever ID it has...

> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

-- PMM

