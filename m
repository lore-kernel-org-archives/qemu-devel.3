Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61256C54E64
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 11:47:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1roimQ-0007Sa-Dp; Mon, 25 Mar 2024 07:46:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1roimM-0007Lu-1c
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 07:46:14 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1roimK-0003jW-Fo
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 07:46:13 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-56bf63af770so858880a12.3
 for <qemu-devel@nongnu.org>; Mon, 25 Mar 2024 04:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711367168; x=1711971968; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=pOhG+I6FhU8/RyL1wJisRPG0LbRYcv2DN6Dp50wSRHw=;
 b=a4qPPMnuymnF9V2VrasDfBWBDpOPnZduV24qzuaxUYhYIgvGluyUP+ynZOKHs5Yk7v
 F0yVzta9vdt/vaRIoxdApbg7R1o/DoKo87i5kC6896IVxjv/ahcG5BPUp9nKWKE/+igV
 aDL83ZdaBhHfGs0PYYs0YfIqM6dlDxrwrJuRQIIeEuJaXcKai+OjvvoJAFudO+S+dQVW
 8xNEJ0p3tcNTSAtgS+UIqtHv5tBKfASXCNisXdBGL5ysvd1w+7xiWiAU9Pnff5q6amd7
 fapHW1AtdD0846W/kYsY2gXcHrfgIsNArfwPX87KjDqPJFGdtWo5moRqBwiJSNw2JngI
 3dlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711367168; x=1711971968;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pOhG+I6FhU8/RyL1wJisRPG0LbRYcv2DN6Dp50wSRHw=;
 b=nH7rl8fx0sv83IaINZT7RBO5wU4+sm1nhOL1EiYBrc5cWenKxctSZg4Uj4PeHyXFp5
 b7n3yb5P2g2Q7LR4RWnNILvoHiYFEalDVdrV1PKv0jTToil4SG4kUl587w6Zm/1pnAq9
 BXx3++/mPfHekGZ5I1f10/zRuA+f+9tf68XDR86uoF1Gho+S2lHK9JQ1cHuVYA1BUl66
 8/Rw2EGSuby46YAVn/vzAzVHUFq2yQ8P2ATBitLv6zk4ZF0vRL9Lm//TeVfXP/Fe+bzf
 cAgL+L2BhaaFOG+p+48UgoF64vhQc5DDPRDmj42LGac1GGZBb82aj2yInwY6nKVXRNvp
 zStA==
X-Gm-Message-State: AOJu0Yx80F0rcCGe7kXeDIBpuv5Jw8BNvIn9DJZwa9g2uK2+bODj/sXj
 VQuqK6OQ73vkD4mldsdqiv/4lY4tXYr+pcDaeJ2oFT8MI0r0pjgTk+Q8wmoZy3/0nOJqFOanYbQ
 oy7PJqqZnIIZMCBe7Mq/5pZ8D6VKcXYdzOacEIg==
X-Google-Smtp-Source: AGHT+IHH8kz4sUcGPj5+Rix2zCwAZ4AvBmplr9wSLE0tDJKCEXujL90NxBieN2laIPIznmF+aYYEa9kQSemA90OzAxE=
X-Received: by 2002:a50:a6d0:0:b0:56c:18b4:d2ab with SMTP id
 f16-20020a50a6d0000000b0056c18b4d2abmr930172edc.42.1711367168428; Mon, 25 Mar
 2024 04:46:08 -0700 (PDT)
MIME-Version: 1.0
References: <20240223154211.1001692-1-npiggin@gmail.com>
 <20240223154211.1001692-9-npiggin@gmail.com>
In-Reply-To: <20240223154211.1001692-9-npiggin@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 25 Mar 2024 11:45:56 +0000
Message-ID: <CAFEAcA_5OJ9X8QKoxZdNAOtmtg9otvLLCx5n7wchNE3wuHOT+A@mail.gmail.com>
Subject: Re: [PULL 08/47] tests/avocado: ppc add hypervisor tests
To: Nicholas Piggin <npiggin@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, 
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x529.google.com
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

On Fri, 23 Feb 2024 at 16:00, Nicholas Piggin <npiggin@gmail.com> wrote:
>
> The powernv and pseries machines both provide hypervisor facilities
> that are supported by KVM. This is a large and complicated set of
> features that don't get much system-level testing in ppc tests.
>
> Add a new test case for these which runs QEMU KVM inside the target.
> This downloads an Alpine VM image, boots it and downloads and installs
> the qemu package, then boots a virtual machine under it, re-using the
> original Alpine VM image.
>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

This breaks running "make check-avocado" for ppc targets
if the host system doesn't have 'xorriso':

 (177/300) tests/avocado/ppc_hv_tests.py:HypervisorTest.test_hv_pseries:
ERROR: [Errno 2] No such file or directory: 'xorriso' (0.14 s)

Missing prerequisites should trigger the test to SKIP, not ERROR.

Bug filed with the avocado logfile details etc:
https://gitlab.com/qemu-project/qemu/-/issues/2246

thanks
-- PMM

