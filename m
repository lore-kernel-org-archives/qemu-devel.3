Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81782CF6497
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2024 10:49:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svDxQ-0003rR-7L; Mon, 30 Sep 2024 06:48:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1svDxO-0003q7-Qr
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 06:48:46 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1svDxM-0007J7-VZ
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 06:48:46 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5c721803a89so5489296a12.1
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2024 03:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727693323; x=1728298123; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=yW121K7iqKVBU9p/lfgSl+R8CtQoPDe7TXh+4M8KVuw=;
 b=yLiL3DgRmtw9rhaFLyUDp6zdwCiO1vmL7ppgR35O4/ctvzKwGgtHi1+iFGAh/G/MiV
 vIl+4VohYDlHJZfRk1ynjVCVZUF3o4c3J45nQKUQ7USPQg9kk1ZKWRzCzDTIsLjyu0rK
 k0qa3amuQiTurS07kFB/TX/oZorY2m1lEDKA+zRI3LqyadGBjT8J7fFUhI4NXEGZMoQs
 edvNII0WVFg/AgUSjvR4MGwGp8E28d9hJVoA6kkBHnXK8jVuyBMpRl1Aeoe63LGRZlD8
 FVAoZMi/jchOupgAbb66WG9gqesHLtcoXBlTqjbB4A1kvg7FMGKMpDVGwb81S16JUZMK
 r/Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727693323; x=1728298123;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yW121K7iqKVBU9p/lfgSl+R8CtQoPDe7TXh+4M8KVuw=;
 b=FtOuAO1DRxWwgZH4Uf2qGewXSXWj+uadDIY+beTxxx9NqmZdSpyuztO5gh765pR163
 9jyY3ReHpptERm+4gfi+3b20gRaRjbs+TJH12g4wBryAMFH2mx2ElrS49ulr1Bk3otLX
 PSM9M/3SnkKBXJ6A+6clJ3Gujard+tum6khnAdmuvYu5loAm0iXhm4epDVkZM9DboGmV
 PocYoEEhqsE4RdN1lUbIjqY+F0JZySxutdeVOwiG/RAA1cvamSkOwYsg9VZ3nmkpOCSx
 ERBdYfD0OgrGf+yt/kblFbGleFnf6YDjlCHn0ksXJFza378uGHl55vWP5boxSlUt7dkm
 MWjA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUmUNYPf8ep2MEEUH42JaW5ngflgltYJZQtaRJpqau/2/PciFAXOMgw5nDA5aF+I1x8A+8Yq1mVmfhL@nongnu.org
X-Gm-Message-State: AOJu0YyXQ31EbNOg6MzrUTtwoGBAlZkjuwtmAXZLmkdZFX45YH8g/2e9
 unS081LfYzeRACBpmGPixG6hYrIK22gVX8Yf9CMWPB+47/6SYpG2Hp3Sjxvxdqa7Grkke+Lsnmd
 E+H46dJDnwmuvRncVDT0cGes63bgMFV9Za4k5Uw==
X-Google-Smtp-Source: AGHT+IHPUC/m1RVSh9BesYX6DAPM9W+m7BSmHliQjd1Kda6tj5lrYFcFZWBiHUB0iy7xt8x9hsvguGr+XqYjVQfmasg=
X-Received: by 2002:a05:6402:e9e:b0:5c0:c10c:7c1d with SMTP id
 4fb4d7f45d1cf-5c88260359fmr10343066a12.23.1727693322927; Mon, 30 Sep 2024
 03:48:42 -0700 (PDT)
MIME-Version: 1.0
References: <20240924221751.2688389-1-alistair.francis@wdc.com>
 <CAFEAcA9Sb-fpNhm-6DPwss5zMpw=nEp31Wt6q1OA6DqCg3wKEg@mail.gmail.com>
 <13ee9889-b503-45ea-a074-ffafbd052c4e@ventanamicro.com>
 <CAFEAcA_nn2fUyo9Pkd8jW2NG1oJLbAJrfiC7sziuhGthqL3=4Q@mail.gmail.com>
 <096029d7-269c-44f8-88d3-6f0c52af58fa@ventanamicro.com>
In-Reply-To: <096029d7-269c-44f8-88d3-6f0c52af58fa@ventanamicro.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 30 Sep 2024 11:48:31 +0100
Message-ID: <CAFEAcA_ZYghG9QoefNnxGFd4Si=viyCWzTD=z19Hr6s+p5rQ1Q@mail.gmail.com>
Subject: Re: [PULL v2 00/47] riscv-to-apply queue
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: Alistair Francis <alistair23@gmail.com>, qemu-devel@nongnu.org, 
 Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On Sun, 29 Sept 2024 at 21:53, Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
>
>
> On 9/29/24 12:38 PM, Peter Maydell wrote:
> > On Sat, 28 Sept 2024 at 21:40, Daniel Henrique Barboza
> > <dbarboza@ventanamicro.com> wrote:
> >>
> >>
> >>
> >> On 9/28/24 8:34 AM, Peter Maydell wrote:
> >>> The assertion failure is
> >>> ERROR:../tests/qtest/riscv-iommu-test.c:72:test_reg_reset: assertion
> >>> failed (cap & RISCV_IOMMU_CAP_VERSION == 0x10): (0 == 16)
> >>
> >> The root cause is that the qtests I added aren't considering the endianess of the
> >> host. The RISC-V IOMMU is being implemented as LE only and all regs are being
> >> read/written in memory as LE. The qtest read/write helpers must take the qtest
> >> endianess into account. We make this type of handling in other qtest archs like
> >> ppc64.
> >>
> >> I have a fix for the tests but I'm unable to run the ubuntu-22.04-s390x-all-system
> >> job to verify it, even after setting Cirrus like Thomas taught me a week ago. In
> >> fact I have no 'ubuntu-22-*' jobs available to run.
> >
> > It's on the private s390 VM we have, so it's set up only to
> > be available on the main CI run (there's not enough capacity
> > on the machine to do any more than that). If you want to point
> > me at a gitlab branch I can do a quick "make check" on that
> > if you like.
>
> I appreciate it. This is the repo:
>
> https://gitlab.com/danielhb/qemu/-/tree/pull_fix

This doesn't fix the assertion. This is because the test (now) does:

  qpci_memread(&r_iommu->dev, r_iommu->reg_bar, reg_offset,
               &reg, sizeof(reg));

  if (riscv_iommu_qtest_big_endian()) {
      reg = bswap32(reg);
  }

where riscv_iommu_qtest_big_endian() is a wrapper for
qtest_big_endian(). But qtest_big_endian() queries the
endianness of the *guest*, and so for riscv it will
always return false and we will never bswap.

If you need to do swapping inline in a test you can use
  reg = le32_to_cpu(reg);
which swaps an LE value read from the guest to the host
CPU's endianness ordering (and similarly with cpu_to_le32
on the write path).

But it turns out that libqos provides already functions
to read/write 32 and 64 bit values from PCI devices:
   reg = qpci_io_readl(&r_iommu->dev, r_iommu->reg_bar, reg_offset);
which do the byteswap for you.
Similarly qpci_io_writel() etc. (The functions work for
both IO and MEM PCI BARs.)

> If this is enough to fix the tests, I'll amend it in the new IOMMU version.
> If we still failing then I'll need to set this s390 VM.
>
> By the way, if you have any recipe/pointers to set this s390 VM to share,
> that would be great.

It's a VM provided by IBM under their "Community Cloud"
umbrella: https://community.ibm.com/zsystems/l1cc/

thanks
-- PMM

