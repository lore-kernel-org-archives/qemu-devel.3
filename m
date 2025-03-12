Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D7E2C28B28
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Mar 2025 13:43:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsMMk-0005xj-4r; Wed, 12 Mar 2025 09:43:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tsMMi-0005vs-Mv
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 09:43:20 -0400
Received: from mail-yb1-xb2f.google.com ([2607:f8b0:4864:20::b2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tsMMg-000524-Q2
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 09:43:20 -0400
Received: by mail-yb1-xb2f.google.com with SMTP id
 3f1490d57ef6-e60aef2711fso4763865276.2
 for <qemu-devel@nongnu.org>; Wed, 12 Mar 2025 06:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741786994; x=1742391794; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B6dROiPUNZWhicmkCPPShDnnfHLxkNZUqm/D63ZAtY4=;
 b=u/a9magQQ+z1Aq8Aw/DjEDG/4A3GQnXxy2FYYUUCayV077md9Q9ANBjcGpQp+zMdDk
 zpTJuu6d/hiHSl9VkGkFKJ6PYYlZIr7gyD9LaetC3Cyst2ueJB2Qg2WSEkxWTRW8rfZV
 ZOt+P3v/UGKJZ94TMsDiPOEW93thLQQUngBIa6PefsKhlNH05i0TRHB9GvS6HzSyXQ16
 HiXMPz2fscrtJWiHBcB5D0qqGl7JDQkgNJHeEILW995cUhlObJiaLKkfRkMmiS7dKghG
 EIhQyjGoPKYkp9wHElYOaoc/uPktvxe2FIOSfakwWhlGeoWv7zR5a7xWJkg3m76sovHo
 CPdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741786994; x=1742391794;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B6dROiPUNZWhicmkCPPShDnnfHLxkNZUqm/D63ZAtY4=;
 b=WifSiPrXbOR9xhTI6TjbOct6GCLgShQt/FyenMErXfzrnyo6lHwkop0y1OnNQQgmkN
 tsb668NBwYPO1JPc4FigglqiLeylSQX82i3KRhcYmTwftv14n8pI0p728DhIbMlEOV1B
 zql7hR2gjqvx5rvKfE9QEsMpPtL7TboPJJeofKIGVAg20Ja17aRzLXO/zIs6FshYioWH
 4c1bonzSDBNUgDkD9iISzigXwRFBvDlhSZZm7OuqSQJaznAWFydR5bKNYmeITDsSnu3i
 7g05KU4rmhUSxIplBLrzjeKGFjCvf2zZ5Ei4uN9t606x4eSQPmb49DCfIcv9d6WEu4GW
 xdSw==
X-Gm-Message-State: AOJu0Yxn6WNsdpkLpaSWAprnlGFRsWhTX3c7QQI1M8WFSC1Ft8aLVa4q
 1E9EJyPR3ppboCOMxFekSEF6R4Xfr76kEYn/8QHkpDjQrrbiAYusQBG1Rxdc+icvOu8cfLjGgv/
 UMmmw4iOcPAzZX00VezCld8dRAUSVaP/rIuWGEg==
X-Gm-Gg: ASbGnctSJKHHvmUhfy1pHJzc6ONHTsjQ0HGyjBE6yl7rEPNSMdPWWfh/TDIlk0vZRZG
 Ng/BIXj+/PdxK9IoOT693fGMO5lNTix76uioPlLJ90/xHE6x53CAla2ygJoNtvXgPhS01yKCdFP
 dxzZRGGl02s+ozQkyE8pWK/s7nG/M=
X-Google-Smtp-Source: AGHT+IGZQvKC2A/fHVzIsfJcKAa0+i1O9swvBXw9TerntndeH3eGqQRk7+OBUDn9VjxkCPk09K1D9djb8XEq3SV+l+A=
X-Received: by 2002:a05:6902:124c:b0:e61:1d97:20e1 with SMTP id
 3f1490d57ef6-e635c1d6444mr28404755276.34.1741786994291; Wed, 12 Mar 2025
 06:43:14 -0700 (PDT)
MIME-Version: 1.0
References: <20250311153717.206129-1-pbonzini@redhat.com>
 <CAFEAcA-TVaickhbxJ6d4Sc_Wi8HUuzKCaJTGHrNY6X3FcGvrfg@mail.gmail.com>
In-Reply-To: <CAFEAcA-TVaickhbxJ6d4Sc_Wi8HUuzKCaJTGHrNY6X3FcGvrfg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 12 Mar 2025 13:43:03 +0000
X-Gm-Features: AQ5f1JpY68AQ5qqZYPvGkJw7fWDNmmKMF8ww1ke3yJTSvcUVfWUmVZ2Paha9Vmo
Message-ID: <CAFEAcA_+v5ntUx5ByXQP0hRo5AHiEbDUxkdUW2+FGNURZFsqNg@mail.gmail.com>
Subject: Re: [PATCH] Revert "hw/char/pl011: Warn when using disabled receiver"
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2f.google.com
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

On Wed, 12 Mar 2025 at 13:36, Peter Maydell <peter.maydell@linaro.org> wrot=
e:
>
> On Tue, 11 Mar 2025 at 15:37, Paolo Bonzini <pbonzini@redhat.com> wrote:
> >
> > The guest does not control whether characters are sent on the UART.
> > Sending them before the guest happens to boot will now result in a
> > "guest error" log entry that is only because of timing, even if the
> > guest _would_ later setup the receiver correctly.
> >
> > This reverts commit abf2b6a028670bd2890bb3aee7e103fe53e4b0df, apart
> > from adding the comment.
> >
> > Cc: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> > Cc: Peter Maydell <peter.maydell@linaro.org>
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > ---
> >  hw/char/pl011.c | 12 ++----------
> >  1 file changed, 2 insertions(+), 10 deletions(-)
> >
> > diff --git a/hw/char/pl011.c b/hw/char/pl011.c
> > index 23a9db8c57c..efca8baecd7 100644
> > --- a/hw/char/pl011.c
> > +++ b/hw/char/pl011.c
> > @@ -85,7 +85,6 @@ DeviceState *pl011_create(hwaddr addr, qemu_irq irq, =
Chardev *chr)
> >  #define CR_OUT1     (1 << 12)
> >  #define CR_RTS      (1 << 11)
> >  #define CR_DTR      (1 << 10)
> > -#define CR_RXE      (1 << 9)
> >  #define CR_TXE      (1 << 8)
> >  #define CR_LBE      (1 << 7)
> >  #define CR_UARTEN   (1 << 0)
> > @@ -490,16 +489,9 @@ static int pl011_can_receive(void *opaque)
> >      unsigned fifo_depth =3D pl011_get_fifo_depth(s);
> >      unsigned fifo_available =3D fifo_depth - s->read_count;
> >
> > -    if (!(s->cr & CR_UARTEN)) {
> > -        qemu_log_mask(LOG_GUEST_ERROR,
> > -                      "PL011 receiving data on disabled UART\n");
> > -    }
> > -    if (!(s->cr & CR_RXE)) {
> > -        qemu_log_mask(LOG_GUEST_ERROR,
> > -                      "PL011 receiving data on disabled RX UART\n");
> > -    }
> > +    /* Should check enable and return 0? */
>
> We decided deliberately not to check the enable and return 0
> here, as described in the commit message of abf2b6a028670bd:
> we think there's too likely to be existing works-on-QEMU code
> out there that doesn't ever set the enable bits.
>
> Otherwise, yes, agreed with the revert.

Oh, and I just realized that the right place to diagnose
"guest didn't enable the UART" would be when it reads/writes
the data register while the enable bits are clear.

-- PMM

