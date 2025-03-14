Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FB40C282EC
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Mar 2025 14:45:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tt6HQ-0002Sk-H1; Fri, 14 Mar 2025 10:44:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sjg@chromium.org>) id 1tt6HN-0002JK-ST
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 10:44:54 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sjg@chromium.org>) id 1tt6HJ-00011u-Jo
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 10:44:53 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-ac2bb7ca40bso408473366b.3
 for <qemu-devel@nongnu.org>; Fri, 14 Mar 2025 07:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1741963487; x=1742568287; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=E+mmioR0JlNqITuU0MHSCr02tRyusfA2SU12RVinQJE=;
 b=MW1GjXharW03i3aEo9Bt5sQhmPWC8SvUCWGwOugsN9OYG1Y11IzemkgAC2QJp66jkP
 Vtte3ivdmoQlLLHBXm3lZOL+iLShtrTNbcR82hAvfpoUWfGMP8M4ah6rdVjE544yc4kb
 cdAwIEMqfc8+dNc0V6/WkJED6PirCIwI+o4UQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741963487; x=1742568287;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=E+mmioR0JlNqITuU0MHSCr02tRyusfA2SU12RVinQJE=;
 b=R2ruV6Ey82SjoRSJetjR4QEPfZ92fTHm+MDgyNA+XRcwtDFnzMxjbiPsRsZ0sBLmId
 BWyNrqNwqBCGB+hKaycrr0RXYzjqSictREI2yGbPPlAZLncU4zPKbr2br6Ylsx/g4nzR
 isMxgjd/UTGr37HAAtpFmDbYQFulPpbDZDN9LcaWO55milYjGGFpisoAbWCdcwciCDQ2
 f5RXmXaKSTp2prMK34mpLb6mpCo9hnditKULYidcUvlovGsnBV+z+kSKlnjsVqnU07zB
 0INKa30qaJkuVQVNWUKo/JjGzzWUCE62ah7VOB+EIVnFI4juSIOXArb2rK2C0op3rg8a
 3sXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUoALfApH704Lv5dspAg8z3q7chTAWGRBatsiCy1idzcgnOliNSWH3HtGdKyOyqBQkvidB1yGKI3QBn@nongnu.org
X-Gm-Message-State: AOJu0YwWnYvZjl1RpyJAEDFbzHEi5SsUTOrVOFpLtkDLfgoan/fBuin8
 erzOtvi1YaCApqDfVgX0Zc16S9KE9XPo5sFnmYBOsSkCZJULDzGSBGGcnZmhnatFUSM2AlM2hqw
 JGk3VcKdEhJFKry0ZTc6WhAot9I3f1eGDNHtM
X-Gm-Gg: ASbGncvZcLmrYMRJVuobxAc6cYoF9mU0gEwkkiYaHMbz6zOPd+8Viw6tg0HFKwD1bQF
 xIo9gZNdC1HeXSdj6r1BprSc7jLElh/Zw0lQ22f3A0SHl3WDJBEk821TJy2eMI6XK343hO7ca+b
 XNj6E3SC0cFzgbJdRpyV6j0Oe6j3M0
X-Google-Smtp-Source: AGHT+IFcB66P3WuSLfFUXPdWeMVuD9xRdhZhOB0EEFFUlsycmCKgx2K6QI/lGiEFiUOetV4myECiUCKqshSPlQSkoqs=
X-Received: by 2002:a17:907:d92:b0:ac2:d5e6:dea7 with SMTP id
 a640c23a62f3a-ac33017710cmr345011666b.13.1741963486995; Fri, 14 Mar 2025
 07:44:46 -0700 (PDT)
MIME-Version: 1.0
References: <20250306160428.3041057-1-sjg@chromium.org>
 <20250307142255.GL2640854@bill-the-cat>
In-Reply-To: <20250307142255.GL2640854@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 14 Mar 2025 14:44:35 +0000
X-Gm-Features: AQ5f1Jp-MmYnjUxHsnfWVgj9hifY91XGM0HctUYfs31ZVaqYpc5_gyTiGM0EclQ
Message-ID: <CAFLszTgtYsVQW-kETzUAdvJvAT6fN_53TeoN7o8wu52Ze3u56Q@mail.gmail.com>
Subject: Re: [PATCH v4 00/47] x86: Improve operation under QEMU
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Bin Meng <bmeng.cn@gmail.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Angelo Dureghello <angelo@kernel-space.org>,
 Guillaume La Roque <glaroque@baylibre.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Igor Opaniuk <igor.opaniuk@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Julien Masson <jmasson@baylibre.com>, 
 Julius Lehmann <lehmanju@devpi.de>, Love Kumar <love.kumar@amd.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martyn Welch <martyn.welch@collabora.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Maximilian Brune <maximilian.brune@9elements.com>,
 Moritz Fischer <moritzf@google.com>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Philip Oberfichtner <pro@denx.de>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Richard Weinberger <richard@nod.at>,
 Stephen Warren <swarren@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=sjg@chromium.org; helo=mail-ej1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Hi Tom,

On Fri, 7 Mar 2025 at 14:23, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, Mar 06, 2025 at 09:03:27AM -0700, Simon Glass wrote:
>
> > U-Boot can start and boot an OS in both qemu-x86 and qemu-x86_64 but it
> > is not perfect.
> >
> > With both builds, executing the VESA ROM causes an intermittent hang, at
> > least on some AMD CPUs.
> >
> > With qemu-x86_64 kvm cannot be used since the move to long mode (64-bit)
> > is done in a way that works on real hardware but not with QEMU. This
> > means that performance is 4-5x slower than it could be, at least on my
> > CPU.
> >
> > We can work around the first problem by using Bochs, which is anyway a
> > better choice than VESA for QEMU. The second can be addressed by using
> > the same descriptor across the jump to long mode.
> >
> > With an MTRR fix this allows booting into Ubuntu on qemu-x86_64
> >
> > In v3 some e820 patches are included to make booting reliable and avoid
> > ACPI tables being dropped. Also, several MTTR problems are addressed, to
> > support memory sizes above 4GB reliably.
>
> Do you plan to rebase the prerequisite series' this requires so that it
> can be merged?

Here's my understanding of where things are:

1. You rejected the membuf series and my replies to try to resolve
that haven't gone anywhere yet. So your tree doesn't have any tests
for that code and still has the old naming.

2. I sent the first part of the PXE series so you could apply that.

3. You rejected the second part of this series because it didn't
include support for lwip without cmdline. I offered to handle that
case later but I'm pretty sure you rejected that too.

4. This series is now marked 'changes requested' but the only feedback
I see is in the RFC patch.

Regards,
Simon

