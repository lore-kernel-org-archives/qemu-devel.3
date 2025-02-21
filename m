Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55DCFC021AA
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 13:25:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlT17-0002VG-Bg; Fri, 21 Feb 2025 08:24:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tlT15-0002V7-Qu
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 08:24:31 -0500
Received: from mail-yw1-x112c.google.com ([2607:f8b0:4864:20::112c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tlT14-0007gd-3W
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 08:24:31 -0500
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-6f768e9be1aso30420097b3.0
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2025 05:24:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740144268; x=1740749068; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=uu6Lp4kiIoyqmJmuFijocKRYlLPlS2tnHKEGFnEON4c=;
 b=ySMGYod1TGkZyMHPPLOLSHTP0PU+WZ0SbgRcKznl+wXxRuQkftuaB0teoetH1J+F1c
 +6deow5Fq3sUbrwq9kr23ertJo+LIPuvEDpxq3ljoC5vxeNglRMWGosBQikWUQgF0AC2
 75RZlo1xfJcYUZFj7ougz9VfV1fch1cn++8VjlV/c3GMr7ICzWcv5SVQD248jMZdkv+e
 LpARfJ6vObwwxROMSJ3flnQ0X+59x2MOKIMti9RZsglIqSYJOmlxSYffqHtA5hjWGVQW
 05MhJhTAMlbBniQzhGA1bD9wYLpMP8+TzTtcxJuGQGpwD/pQLVEPulVTUIM3CanK+4ul
 VW+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740144268; x=1740749068;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uu6Lp4kiIoyqmJmuFijocKRYlLPlS2tnHKEGFnEON4c=;
 b=iDgJAwzgc7owwajPH5Vvq1TEVk5ojg/+d7N8UMaCFtYxd1EO9IswHAJo4Bqb+utQQn
 OdRLSnWwe0gsfoTGiP+n/Pd2sq4brHTBrXE09jeMVj12dzYNFHdSGAlmlf4iB7/HZ2E2
 pSBr65vIeUXkRiUU3VLmLLzqfyGB8bNIrk1O8bMjiN8P2n4tBprA3Op/Zu8pmXIrZCuG
 f6HuT0ZG2Ah63UGUtzyzt9xlV3yWG1jiimmFMbi6rz4ZlSL3XP2KxL+ke4nsFqEgNEQb
 g9ruuxKqPi8r0LbLKF40/Z4dkuwt14gjtBPmwoXaHgAoLST2ohDZuMhjnSWMWHtyxZm5
 yJOA==
X-Gm-Message-State: AOJu0YzoCe7w65ooy4pqqA2mx4YosL0rivqe+hmcbX3NGpqtZwjoiBL4
 gddzzPTHhTO3lk4Q60UcdjeaBKfw4g1V1FwDFKb9pRv/zjw+3NTBPVR9IUiMr4RMHzGuYne4CNj
 qoywqrrpJaKu6zAS0s1jBcMj8c5gowyJzuzq8Fg==
X-Gm-Gg: ASbGnctR0aJ7svbTJTt+b2C9ZBNU3jgk4aJ7SBolkk/EIgxFWvp8u61JaFx2TBxraP0
 m+tDUfs11aHoV+EdZC+is5EtmZ+gF0YyPMjNHOAUdCgPIy1a6L9zeHuQmnba76DBisPMMRvnMvs
 lJy2BdTBCd
X-Google-Smtp-Source: AGHT+IHMYPuDlYUxocSoUw91chXzlH/5vKyOkgVovai4vZOUGaz3S3q6Jwzs4Q9PmNcjf6PdPoQ5as+Ovl62mhGdpHg=
X-Received: by 2002:a05:6902:706:b0:e58:55be:b0ae with SMTP id
 3f1490d57ef6-e5e191bb850mr6261353276.14.1740144268555; Fri, 21 Feb 2025
 05:24:28 -0800 (PST)
MIME-Version: 1.0
References: <CAFEAcA-u+TMgQV8G8LvQixE95BGhfN5hyYdxcZTnxu5StVBKRw@mail.gmail.com>
 <014caf20-41d1-437b-bd0a-6ef263a709d1@redhat.com>
 <9e010d8e-314e-432e-83e4-81be91d43538@redhat.com>
In-Reply-To: <9e010d8e-314e-432e-83e4-81be91d43538@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 21 Feb 2025 13:24:17 +0000
X-Gm-Features: AWEUYZlGfx3GDc7nggC2EAoTr2GDr2VHRb9iQIz2q74eRVssHajeSR9jDz2I2Qc
Message-ID: <CAFEAcA8dtX1iGpoAUTF+Jd2a_qpPrKt4Qqkp+rPAdz8S_6O04A@mail.gmail.com>
Subject: Re: debugging functional tests that only fail in 'make
 check-functional'
To: Thomas Huth <thuth@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 "Daniel P. Berrange" <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112c.google.com
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

On Fri, 21 Feb 2025 at 13:08, Thomas Huth <thuth@redhat.com> wrote:
>
> On 21/02/2025 13.54, Thomas Huth wrote:
> > diff --git a/tests/functional/test_arm_sx1.py b/tests/functional/
> > test_arm_sx1.py
> > --- a/tests/functional/test_arm_sx1.py
> > +++ b/tests/functional/test_arm_sx1.py
> > @@ -43,7 +43,8 @@ def test_arm_sx1_initrd(self):
> >           self.vm.add_args('-append', f'kunit.enable=0 rdinit=/sbin/init
> > {self.CONSOLE_ARGS}')
> >           self.vm.add_args('-no-reboot')
> >           self.launch_kernel(zimage_path,
> > -                           initrd=initrd_path)
> > +                           initrd=initrd_path,
> > +                           wait_for='Boot successful')
> >           self.vm.wait(timeout=60)
>
> Actually, thinking about this twice, this might even be a valid fix for your
> problem. Without waiting for a a string that signals a successful boot, the
> test was just firing up the guest kernel and then waiting for 60 seconds for
> the guest kernel to boot up and shut down again. If the boot is delayed for
> some reasons, these 60 seconds might still not be enough. So if we wait for
> a successful boot first before starting with the timeout, the 60 seconds
> afterwards should be enough for a successful shut down, I guess?

Doesn't that just shuffle the timeouts around? If it
takes ages for the "boot" part then it will hit the timeout in
the meson.build file.

I'm trying with just bumping all the per-test timeouts
in the sx1 test to 120s.

-- PMM

