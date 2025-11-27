Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 074E3D11183
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Nov 2025 13:24:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vObz5-00054S-5R; Thu, 27 Nov 2025 08:24:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vObz2-000532-Uc
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 08:24:28 -0500
Received: from mail-yw1-x1136.google.com ([2607:f8b0:4864:20::1136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vObyy-0002cB-Nz
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 08:24:28 -0500
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-78a712cfbc0so8876237b3.1
 for <qemu-devel@nongnu.org>; Thu, 27 Nov 2025 05:24:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764249863; x=1764854663; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fww68BlgKLuiG4hzZ5/mwFSk0rD8O5mZcNnmztXJt/Y=;
 b=DSxPKEriLMdDse3RLuvWHooRYkaAmN/Sfay1tAB63WPypRf/H+uan0/z+EyZKgFYJG
 YIkzfHlDWZfy6+g8y3hPHhfnRTcLLUA3E8PV3D9QE6YxxlliJSEgovEWxm3+Lo07hQjN
 PbkzPfXVmMBoQwZC24Jd5O5YQARnXsH6HB8bZcseTS5+6s+fEP2oBFxzCtHljHdVRYFI
 NxTQvFLLuNinlS/4lAtp69ZkVQdwWpdpSqIUGDkAfC+x2jFNaMxzsYmJ2pgGHEo6QuYj
 MT0XJxfFA0vaYJfQYc+hKYZHWMI/EItTKl5iBpS5Oyn/q1MUtsL7eNBE7owirwzplStm
 EkMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764249863; x=1764854663;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fww68BlgKLuiG4hzZ5/mwFSk0rD8O5mZcNnmztXJt/Y=;
 b=pxJ+Qs7n+DqXfJH5qq3NWGQNbY7tn+J6Nsx0oCygSckAHEN4sv/Y1aPep3aU3qujAc
 /E2HFWG3yZ1koH5wRqPUWXp8X2DlgZs0LwH3+fuQd+xIoPnY17F6BeuWVvt8e44sL4m+
 Sze7jCn7thF83xL4vaVQy0XXYfrdUtzJBr9m3ZN9NWKxgES7H88miw2Vv/c1VJwaq3dD
 1IJP6OOSYISaJWiMQrEAxB9lAWib0bXLOAxV1nj3m3wtUy66ETEO0ik2ehkKkC6s2zh5
 aXcrZctDEGwuW3JaeeKK3YTutCRBJFv0EK6rCAuc6yFCbjZkFIfNZj93gzq3jtrsSLCW
 X41w==
X-Gm-Message-State: AOJu0YzW5Or0R8uuc9Av5C57T4cugsHbiYssq4fQMqX8qJElMUQU8K+J
 Z/6Wn1W+z2hu2l7KHq6h4lb7mY5NolnI2fATOtvefny4DtatWAQawVYPh4Ay4ipMg59u9U6/ab4
 NT6wIanS9jtWkZva5ZwolrCy2rhk3LdASbyRn1Rakdg==
X-Gm-Gg: ASbGncsxKEvfiKxQ9GueNJh4+Di7fSB7PH1gZ45c4Gm136mBJ56NNQTGcatFkRQkcNn
 3GLurir7Ay+leF+j46m0roF0MOQ04wRKfFctVHIRL/6J8jxlul1wSEHs57lqd87Pi45f6/iAOVA
 Jv/KxUlI7dgeC3gFKv9Bf+d0rfLh5xV0xNng9C2CrUmKl36206JieDogePN5a2gQkad2m5b/rwR
 npum9Gc3YEeySE93bVKmffLUQY7hKap44DHTFxzG7TNnKOjiT1P+JZebNzybF4FYoOxH9mG
X-Google-Smtp-Source: AGHT+IHgOJfB8Jyp2w01YT0dysBp7VmjFyL2jjEIdMm90LI44WLkxld2asq9+fZKyX/WP377dB77IYsU2yai0JcfMrQ=
X-Received: by 2002:a05:690c:3685:b0:787:f0b2:8dbf with SMTP id
 00721157ae682-78a8b56e3dcmr186141417b3.66.1764249863450; Thu, 27 Nov 2025
 05:24:23 -0800 (PST)
MIME-Version: 1.0
References: <CAFEAcA-hyn0B-yWE1=g4+NN9=NBjWvk-P8qrAk9L4vpAZpUYvQ@mail.gmail.com>
 <20251127001247.1672873-1-navidem@google.com>
 <20251127001247.1672873-3-navidem@google.com>
In-Reply-To: <20251127001247.1672873-3-navidem@google.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 27 Nov 2025 13:24:11 +0000
X-Gm-Features: AWmQ_bmdLf6llnc-Lh-204NRYW5M2NEhZuQeRAMp1v6qHdlsX8EKapE_bsZH_sY
Message-ID: <CAFEAcA8xMr6-GtYe3+CoXr-M_jUoYwjjSWJCtjjKf0j70vQNuA@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] libqos: pci: Require size for legacy I/O port
 mapping
To: Navid Emamdoost <navidem@google.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de, lvivier@redhat.com, 
 pbonzini@redhat.com, zsm@google.com, alxndr@bu.edu, 
 John Snow <jsnow@redhat.com>, "open list:IDE" <qemu-block@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1136.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, 27 Nov 2025 at 00:12, Navid Emamdoost <navidem@google.com> wrote:
>
> The accessor functions for QPCIBar (qpci_io_readb, etc.) perform
> strict bounds checking to ensure memory safety. However, the
> qpci_legacy_iomap function created QPCIBar tokens for legacy I/O
> ports without an associated size, making this safety check impossible.
>
> To fix this, modify the signature of qpci_legacy_iomap to require the
> caller to explicitly provide the size of the legacy I/O region.
>
> Update all existing callers of this function, including the IDE
> (ide-test.c) and TCO watchdog (tco-test.c) test suites, to provide
> the correct, known sizes for the hardware they are testing. This not
> only fixes the test failures but also makes the tests more robust and
> explicit about the I/O regions they interact with.
>
> Signed-off-by: Navid Emamdoost <navidem@google.com>
> ---
>  tests/qtest/ide-test.c   | 2 +-
>  tests/qtest/libqos/pci.c | 4 ++--
>  tests/qtest/libqos/pci.h | 2 +-
>  tests/qtest/tco-test.c   | 2 +-
>  4 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/tests/qtest/ide-test.c b/tests/qtest/ide-test.c
> index ceee444a9e..524458e9f6 100644
> --- a/tests/qtest/ide-test.c
> +++ b/tests/qtest/ide-test.c
> @@ -173,7 +173,7 @@ static QPCIDevice *get_pci_device(QTestState *qts, QPCIBar *bmdma_bar,
>      /* Map bmdma BAR */
>      *bmdma_bar = qpci_iomap(dev, 4, NULL);
>
> -    *ide_bar = qpci_legacy_iomap(dev, IDE_BASE);
> +    *ide_bar = qpci_legacy_iomap(dev, IDE_BASE, 8);

I think we could add a
#define IDE_SIZE 8
after the existing #define of IDE_BASE, and then use that rather
than a plain constant 8 here.

>
>      qpci_device_enable(dev);
> diff --git a/tests/qtest/tco-test.c b/tests/qtest/tco-test.c
> index 20ccefabcb..3af7c14e73 100644
> --- a/tests/qtest/tco-test.c
> +++ b/tests/qtest/tco-test.c
> @@ -77,7 +77,7 @@ static void test_init(TestData *d)
>      /* set Root Complex BAR */
>      qpci_config_writel(d->dev, ICH9_LPC_RCBA, RCBA_BASE_ADDR | 0x1);
>
> -    d->tco_io_bar = qpci_legacy_iomap(d->dev, PM_IO_BASE_ADDR + 0x60);
> +    d->tco_io_bar = qpci_legacy_iomap(d->dev, PM_IO_BASE_ADDR + 0x60, 32);

we already include ich9.h which defines a named constant
for the IO size, so we can use ICH9_PMIO_TCO_LEN here.

thanks
-- PMM

