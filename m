Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 584E9D0E6D5
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 09:18:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2oY3-0006v0-A2; Mon, 21 Oct 2024 05:17:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t2oY1-0006uP-Fr
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 05:17:57 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t2oXz-0001In-TH
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 05:17:57 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5c9634c9160so4678483a12.2
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2024 02:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729502273; x=1730107073; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=92cuFzD+3hd3+6TatQY/j5FkSK1hjyM372fU+PFVM+k=;
 b=Jzv1G2ORndTl/oUt6aqsW5l8h4Uw3TTBz1QAoy3cUznseWRelvB7NFqefjeZ1BZvnK
 MeXvz6xPNxuaVzDth7MRhsaFZOUSDQuMcXAMSUWTOugeswAFO5SpYjo61YGF5m/lzGeJ
 mMW0UJYpU2Dd5gcIrmIn6N+GO+s6i/HGiNRHhP4Ufe0LNZHiMMyjCjGCjPYLw614Ob9E
 E9T0l73qaoZsoRjaZRl+F92zAFi2A/RMjSOs5XlrNUBmEXY5tCl74aorCdpKE2i+CvA5
 gYD2VeHmT53E9JOYpuJwmC4sMOeW6DCLpFG0PNFTWhQT06FrCUalAIZQFA4tER3tPT/g
 HSLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729502273; x=1730107073;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=92cuFzD+3hd3+6TatQY/j5FkSK1hjyM372fU+PFVM+k=;
 b=BTDUldq12dKpaq/+T8JwODOqeRjIHE8MxAl21IuCi5E6wGe9qe54Al1cPiRr5Ci1FG
 cqAzbsmHu/MAEueTs+1aNHbaPDbOw34/kUTSpK/8n//6g42A94GIbgWEwOhvxxF+eH0+
 hg16JT4NOr4Q8EkjEpN2jSIBsZEnY53sslHifZWJXy3ftsRquLzdhyMIN5S7fPbAm+Gq
 AJllzIpHnrDS4TevUVDgt0a2OQvLRPSKCtByrKsrJqm3jWQEDfgeE8ObW0cwfnw8vpQK
 BHtLphMsg7/bmLaQbz9DyG1+b70aPbtz1uD+GhLJboSiLF/6B6/OOt8FV9+oywfvCi7e
 d5sg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW0Z2fVemGM47tYlUn9AgyhfU/hJLxBcYV3YiwxcqsdyTBeaib0WfLBZELDV3KyaUf2aXs2gLCEs9dn@nongnu.org
X-Gm-Message-State: AOJu0YyvYhnVbRohGYnRIbRDPm4EWKg2hmhekr01ODQ2oa5gl0NEIznM
 SaNGAqO4VS/jhPrPeoj7xU3d9blLLvwYpO3rV13axZHnBHcX1+9msDo+GAODfbK2kuQGZuYhxgc
 Rej8Qabi8x1xXk8QEyHmpXW/fp2Vk7OC0tmf6quO582nOifrW
X-Google-Smtp-Source: AGHT+IEOfWnZw88qWvcpMpkExuKJgZWd0vKrGUSbBO/SrvUaflIli+WE7HToSAcCCxS1nG/BxifDXxEX/5gDoF3Ib2E=
X-Received: by 2002:a05:6402:5247:b0:5cb:6690:eabb with SMTP id
 4fb4d7f45d1cf-5cb6690eb13mr4179971a12.24.1729502273338; Mon, 21 Oct 2024
 02:17:53 -0700 (PDT)
MIME-Version: 1.0
References: <20241017163247.711244-1-peter.maydell@linaro.org>
 <dcf06645-dac0-4099-8946-38ca9deaeccf@redhat.com>
 <ec2cb5e8-77be-435e-8aa7-4314cf412c4d@redhat.com>
In-Reply-To: <ec2cb5e8-77be-435e-8aa7-4314cf412c4d@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 21 Oct 2024 10:17:41 +0100
Message-ID: <CAFEAcA8MY8DWABNuYuzH57k-nv3J4s0eMR=FuRt1TVd8P2GU2g@mail.gmail.com>
Subject: Re: [PATCH 0/2] arm: Add collie and sx functional tests
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52c.google.com
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

On Mon, 21 Oct 2024 at 09:01, Thomas Huth <thuth@redhat.com> wrote:
>
> On 21/10/2024 09.15, Thomas Huth wrote:
> > On 17/10/2024 18.32, Peter Maydell wrote:
> >> This patchset adds new functional tests for the collie and sx1
> >> boards, which are the only remaining ones that survived the
> >> culling of the OMAP/PXA2xx/strongarm machines.
> >>
> >> For these tests I'm indebted to Guenter Roeck, who has kindly
> >> built and made available the kernel images, rootfs, etc and
> >> documented the commands needed to boot them. All I've done
> >> here is wrap those up into test cases in our testcase
> >> framework by cribbing from some of our existing test code.
> >>
> >> Based-on: 20241017162755.710698-1-peter.maydell@linaro.org
> >> ("hw/sd/omap_mmc: Don't use sd_cmd_type_t")
> >>   -- the sd card test for the sx1 board will not pass without
> >>      that bugfix
> >>
> >> thanks
> >> -- PMM
> >>
> >> Peter Maydell (2):
> >>    tests/functional: Add a functional test for the collie board
> >>    tests/functional: Add a functional test for the sx1 board
> >>
> >>   MAINTAINERS                         |  1 +
> >>   tests/functional/meson.build        |  3 ++
> >>   tests/functional/test_arm_collie.py | 31 +++++++++++++
> >>   tests/functional/test_arm_sx1.py    | 72 +++++++++++++++++++++++++++++
> >>   4 files changed, 107 insertions(+)
> >>   create mode 100755 tests/functional/test_arm_collie.py
> >>   create mode 100755 tests/functional/test_arm_sx1.py
> >
> > Thanks, I'll queue the patches [...]
>
> Unfortunately, the test_arm_sx1.SX1Test.test_arm_sx1_sd test is not working
> for me, it seems to fail the shutdown of the QEMU binary:

The interesting information will be in the guest console
log, which seems to not be in this log. But the first
question is "did you include the omap_mmc fix that the
cover letter and patch description says is a prerequisite"? :-)

thanks
-- PMM

