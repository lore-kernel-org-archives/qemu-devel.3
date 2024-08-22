Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A924EC52D7C
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2024 13:29:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sh7rc-0004UJ-VM; Thu, 22 Aug 2024 09:28:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sh7rZ-0004TM-7Q
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 09:28:29 -0400
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sh7rX-0007H4-AU
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 09:28:28 -0400
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2f3b8eb3df5so7533431fa.1
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2024 06:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724333304; x=1724938104; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=iboVwxqYZ7dX7dV1LSG5gTtGmY5fYUoZtXeRX0F1mrU=;
 b=luU1f+sTRSgmHJVcKDb8iweOaONsuLcYgfu5d5oo1AtbaW3X+512bB9Zj5i2ZfNCQM
 I7PIjr3C6Di4SD4qFWDXW8b3JEdfesQ/Pt5PtLdLUyf/nW5W+ydn7EIclwTZYVCUQwlQ
 vyok6pY76PrFQLwDmJAtEuG2jsBpSORqQozDq5adhKdNwGdL9PjWbUittH6Bgjy/FwkR
 e8Xl/iCKaZja9Zh2YF60CTSUvKwFu95lJr0xa1W+9em44xsA5maiwp1KaD1deFBcUarv
 IAdrTczvQF50dvbCKXNUcck0Pvb+jSeVjJibQNUldvdxHwGTPed0qx/bUxNpXm89cuOP
 cAQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724333304; x=1724938104;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iboVwxqYZ7dX7dV1LSG5gTtGmY5fYUoZtXeRX0F1mrU=;
 b=I5Xo81iyqt7Ihii5g9Bou+kiiifokS3iEzv+z6dUXflVgLS1SIjkyL5IbllP1e7VyD
 PwU0XT7cETWPWJqzyYYLJHuIMehprteyRv7XqsVM+Mr/05KyQgE2Zs5uqmHwVXnRsw2K
 flIY9z3IEWaUxWBZkyHY95j5Ap3INlGH6122NkS0KIyRt0w8tyIE5G+9GGtEpKL1wfdC
 D/boJD8s44kfeUsvhdqZVpR5oQm4mnoeBh7TktpaWnuONLvIaH9jbfGcGbFvTMbD1rac
 m/ua3q/LqQ+J87naOitoV3itjbCkKXPsGmk/AqcqxBn3hUgTYvPi9y+VuT+h5KheGWP7
 gj2g==
X-Gm-Message-State: AOJu0YxRCECPqe5iVFNI+f1olUp+qdBw2KtUQ1MuFJul+4vl+ZdOwegK
 T4gVXL14ebBJcAtkOO/6KBs0YF5gPZViS85LWyOZi/3FNjoGoAttr6Rkw/dMMf6qsnRKXQY+0N2
 Dg0siB5LZK/XoRe7Bnj17AFto2PDvHjOJMeBjsA==
X-Google-Smtp-Source: AGHT+IGd6mYXTmEXjHjbmav+rK4ksaa/hz1aHDuPpk5cbm+esmw/5tkOESJ3E6bIbSXKxp4VPfWOK0Z+r4+vxCWpw5A=
X-Received: by 2002:a2e:a549:0:b0:2f3:f49a:c6df with SMTP id
 38308e7fff4ca-2f405eedcf3mr13183331fa.32.1724333303859; Thu, 22 Aug 2024
 06:28:23 -0700 (PDT)
MIME-Version: 1.0
References: <20240817102606.3996242-1-tavip@google.com>
In-Reply-To: <20240817102606.3996242-1-tavip@google.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Aug 2024 14:28:13 +0100
Message-ID: <CAFEAcA8gg1u4_HwG9QOHj4RqfHgNLkT5nHLTFNrcaHdgL+zEPQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 00/23] NXP i.MX RT595, ARM SVD and device model
 unit tests
To: Octavian Purdila <tavip@google.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, stefanst@google.com, 
 pbonzini@redhat.com, thuth@redhat.com, marcandre.lureau@redhat.com, 
 alistair@alistair23.me, berrange@redhat.com, philmd@linaro.org, 
 jsnow@redhat.com, crosa@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::234;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x234.google.com
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

On Sat, 17 Aug 2024 at 11:26, Octavian Purdila <tavip@google.com> wrote:
>
> This patch set adds support for NXP's RT500 MCU [1] and the RT595
> EVK[2]. More RT500 device models will be submitted in future patch sets.
>
> The goal of this first patch set is to provide a minimal set that
> allows running the NXP MCU SDK hello world example[4].
>
> The patch set introduces a (python) tool that generates C header files
> from ARM SVD files[3]. This significantly reduces the effort to write
> a new device model by automatically generating: register definitions
> and layout (including bit fields), register names for easier debugging
> and tracing, reset register values, register write masks, etc.
>
> The generated files are commited and not generated at compile
> time. Build targets are created so that they can be easily regenerated
> if needed.
>
> It also introduces unit tests for device models. To allow accessing
> registers from unit tests a system bus mock is created.
>
> This can potentially introduce maintainance issues, due to mocks or
> unit tests getting outdated when code is refactored. However, I think
> this is not an issue in this case because the APIs we mocked (system
> bus MMIO access) or directly used (irq APIs, chardev APIs, clock tree
> APIs) to interact with device models are stable at this
> point. Anecdotally, our experience seems to confirm this: we only run
> into one (trivially fixed) breaking upstream change (gpio getting
> removed from hwcore) in the last three years.

My main issue with the mocking is that it introduces a
completely different way of testing devices that is
not the same as what we use for any existing device.
QEMU already has too many places where there are multiple
different ways or styles of doing something, so adding a
new one should be a high bar (e.g. "this lets us test XYZ
that would be impossible in the old way") and preferably
also have a transition plan for how we would be
deprecating and dropping the old way of doing things.

So my inclination here is to say "you said that you could
do the testing of this device with qtest, so use qtest".
If we were designing a "test devices" framework from
scratch, using mocks would probably be a strong candidate
for that design, but we aren't starting from scratch.

thanks
-- PMM

