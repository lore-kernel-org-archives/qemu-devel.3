Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D166C021B8
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2025 11:53:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnFyh-0002h3-4A; Wed, 26 Feb 2025 06:53:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tnFyf-0002gG-8L
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 06:53:25 -0500
Received: from mail-yb1-xb2e.google.com ([2607:f8b0:4864:20::b2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tnFyd-0005nK-75
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 06:53:24 -0500
Received: by mail-yb1-xb2e.google.com with SMTP id
 3f1490d57ef6-e461015fbd4so4945735276.2
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2025 03:53:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740570802; x=1741175602; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YqPvyMOeEHsZyMMg3Pi86QbyPypugS3EcHBB4E9kGas=;
 b=S2BI3dk1agpo5OjK0NKPAhgNNKNgVJRC7jYMKLV5A2/qd723h1S21b+LHF8cBu1gnB
 08EFWaalj7Q6zdW416nsKD62BfRWfrZfUtRr2cfWmmaEP4DL4+a4ICqgQDZwkaEvTszg
 LygEOBmGL0YqSwJGkHrNHhx1chqX/TAb08+PR4oa7SNzwn7bc0AdQNUnzImaaiqn3eYV
 7Epfc41bEBgif2HpstIBvh7wmub1nh2HR/zeqLrjpkOTEowvdZB8KQ2fM1wKuo9AJGV8
 YXhnVKDd32dt9Wjkah6fW3V60nJheMPU2PlyjY2Ifa3OKPd9VXbvRRmLrYHtF4KZTxT1
 tl8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740570802; x=1741175602;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YqPvyMOeEHsZyMMg3Pi86QbyPypugS3EcHBB4E9kGas=;
 b=fK5GTXmo1kQ9vPW+OWAPxQM2YCJ1DwGPn2Ex3fgGyzELE7hDNvx5mfBMG+g7VNJ7/f
 UD9PXaoappW0lIXPVE6ZXPrjGrvRE1GgxwZLpvJdWefK9OanWaTtNHQXpnNpl/48fPJQ
 px7SGPMY6jKEqYTrlUhO02pEymLKZub530YHSBOcL/4VWSlspvzROHSpN5/dZ65zabGD
 yvyjRayG1EhDYKYzVaZ7YC7CpLUESGdMxzghoD7+CmYZO3KpOhAzVJ57Osijde9eehX6
 Bue2aGdZeuljadK7KPY8KtwIuqrzoCes0hST0mXsc3rjE13+SfS2zAJVCwXMXo4QSQVy
 krxg==
X-Gm-Message-State: AOJu0Yzvgx6pmoJQx8446YuLHbspmLAUdQLAEl1gqwnBG1y7+qcdjpOv
 Irscj0LXO6q+kiOISsFR9IpBl0GCHU72Nhw3ycTosbEKYXzUrfElVbL5xbzS1FWUdc1Xw56V85b
 aEKcp7a5Lm2fTZ0PN+IfBbinoP62XAo9khEgmtA==
X-Gm-Gg: ASbGncsVVrjQ3Y1H3+9dOPjt3M5nLdNMs7gjSHflSB3//08IZbSJ8GvxXGXJWE9OlTZ
 gSRW5rbwoLxUQTdyqjrj2NJZ5pDhW0/AdpJFyJzfeSJ+kOqSPDjbUnlfN1PXe9qVyqH3KgbUJnT
 0LpdkD9xNQ
X-Google-Smtp-Source: AGHT+IGy+UXcal8ZXjpa8MD6RSenG93ffo/wbBulvx1ukDv1elVjK4YLxtoyLzITFnAssg380Uy310kYr5tT9qKPfo0=
X-Received: by 2002:a05:6902:a81:b0:e5b:1710:d3d0 with SMTP id
 3f1490d57ef6-e607a5693f4mr5117458276.43.1740570801872; Wed, 26 Feb 2025
 03:53:21 -0800 (PST)
MIME-Version: 1.0
References: <20250223114708.1780-1-shentey@gmail.com>
 <20250223114708.1780-5-shentey@gmail.com>
 <CAFEAcA_XJfAVEe3cgHiXgcewTL3kF3SEevrnMh-Edvfk56G6sQ@mail.gmail.com>
 <CAFEAcA9e5FBrKLZrKRsw=wPThbwx3+gyVt9rv4_vx9OKfZ8qiQ@mail.gmail.com>
 <3AC73313-B9B5-423D-9E01-189E9010556C@gmail.com>
In-Reply-To: <3AC73313-B9B5-423D-9E01-189E9010556C@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 26 Feb 2025 11:53:10 +0000
X-Gm-Features: AWEUYZkZzCodTHS8hKuXsa_I_7_0oaMVEPbahytCXcKZsaBFJBK-yr9rSvlk3uk
Message-ID: <CAFEAcA83wAdgkaFL5oOvVNuWYYFW=ffgsqKF8OcDQh49XDryNA@mail.gmail.com>
Subject: Re: [PATCH v2 04/18] hw/arm: Add i.MX 8M Plus EVK board
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-arm@nongnu.org, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Laurent Vivier <lvivier@redhat.com>, Andrey Smirnov <andrew.smirnov@gmail.com>,
 Fabiano Rosas <farosas@suse.de>, Alistair Francis <alistair@alistair23.me>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2e.google.com
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

On Wed, 26 Feb 2025 at 06:36, Bernhard Beschow <shentey@gmail.com> wrote:
>
>
>
> Am 25. Februar 2025 17:00:53 UTC schrieb Peter Maydell <peter.maydell@lin=
aro.org>:
> >On Tue, 25 Feb 2025 at 15:42, Peter Maydell <peter.maydell@linaro.org> w=
rote:
> >> The C compiler for the OpenSUSE CI job doesn't seem to like this:
> >> https://gitlab.com/pm215/qemu/-/jobs/9239416833
> >>
> >> ../hw/arm/fsl-imx8mp.c: In function =E2=80=98fsl_imx8mp_realize=E2=80=
=99:
> >> ../hw/arm/fsl-imx8mp.c:382:15: error: initializer element is not const=
ant
> >>              { fsl_imx8mp_memmap[FSL_IMX8MP_UART1].addr, FSL_IMX8MP_UA=
RT1_IRQ },
> >>                ^~~~~~~~~~~~~~~~~
> >> ../hw/arm/fsl-imx8mp.c:382:15: note: (near initialization for
> >> =E2=80=98serial_table[0].addr=E2=80=99)
> >> ../hw/arm/fsl-imx8mp.c:383:15: error: initializer element is not const=
ant
> >>              { fsl_imx8mp_memmap[FSL_IMX8MP_UART2].addr, FSL_IMX8MP_UA=
RT2_IRQ },
> >>                ^~~~~~~~~~~~~~~~~
> >>
> >> This is (gcc 7.5.0 "cc (SUSE Linux) 7.5.0") apparently. That's
> >> a pretty old compiler, only just within the bounds of our
> >> version requirements (which are 7.4 or better), so I'm guessing
> >> it's just not as smart about figuring out that the
> >> initializer here really is a constant value.
> >>
> >> I'll fix this up by dropping the "const" from the serial_table[]
> >> etc definitions.
> >
> >More specifically, you have to drop 'static const', leaving just 'struct=
'.
> >Minimal repro: https://godbolt.org/z/5css4hv67
>
> I haven't checked, but this might be caused by the multiplications (... *=
 KiB)

The godbolt repro case just uses plain constant values in the memmap
array, so it's not the multiplication that's at fault.

-- PMM

