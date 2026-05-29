Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C832CD6E43
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 11:07:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSv2g-0007Hx-R8; Fri, 29 May 2026 07:06:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jic23@kernel.org>)
 id 1wSv2e-0007HA-LL; Fri, 29 May 2026 07:06:16 -0400
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jic23@kernel.org>)
 id 1wSv2c-0005au-P7; Fri, 29 May 2026 07:06:16 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2898E404F2;
 Fri, 29 May 2026 11:06:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF2D21F00893;
 Fri, 29 May 2026 11:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780052771;
 bh=Q9AUF7L2yHF3DZR6jprKlAO6Mro0ThDf+QYDpnxQTG4=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=BlWRXiCHlnYnEUKBYUGuaoCm1UyZH6X0nBoOCYmR7IG71jJ6QTGyLN6awMUVJ9CA+
 Duhg+DLsGWqned1gGqLcVBeR3lo/DjF+RtIxq6bkhjwMr2xfGpUvaOVeDMFyQw1X4C
 TuMfk4Gus0opor6wWOxEk/EguCMBxjq3IV8GbuS1D/gqrP1cKMiB2Pv7KhMofhKL6N
 kSOyPlvY6zC3FQqLZvZPCAmlQjhC3i9tbOHwhWfeOATHsNNhBvKCt9vtMFWWZKakxd
 8iYtvs8EQ7t/PuayKrbkLGnYo6GQMOGWrkIeXj8jZXrWJ/Bkhw7Fuw0A0xSJa1ZdTh
 nek6xB9j0XIdA==
Date: Fri, 29 May 2026 12:06:00 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "Jian Zhang" <zhangjian.3032@bytedance.com>
Cc: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>, "Peter Maydell"
 <peter.maydell@linaro.org>, "Steven Lee" <steven_lee@aspeedtech.com>, "Troy
 Lee" <leetroy@gmail.com>, "Jamin Lin" <jamin_lin@aspeedtech.com>, "Andrew
 Jeffery" <andrew@codeconstruct.com.au>, "Joel Stanley" <joel@jms.id.au>,
 "Paolo Bonzini" <pbonzini@redhat.com>, <qemu-devel@nongnu.org>,
 <qemu-arm@nongnu.org>, "Jeremy Kerr" <jk@codeconstruct.com.au>, "Matt
 Johnston" <matt@codeconstruct.com.au>, Klaus Jensen <its@irrelevant.dk>
Subject: Re: [PATCH v1 0/2] hw: introduce a lightweight MCTP-over-I2C responder
Message-ID: <20260529120600.19bc7aa9@jic23-huawei>
In-Reply-To: <20260408085941.3837334-1-zhangjian.3032@bytedance.com>
References: <20260408085941.3837334-1-zhangjian.3032@bytedance.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=172.234.252.31; envelope-from=jic23@kernel.org;
 helo=sea.source.kernel.org
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed,  8 Apr 2026 16:59:39 +0800
"Jian Zhang" <zhangjian.3032@bytedance.com> wrote:

> Hi,
> 
> MCTP (Management Component Transport Protocol) is a DMTF-defined
> management transport protocol commonly used between BMCs and managed
> components.
> 
> This series adds a lightweight MCTP implementation to QEMU. To keep the
> scope small and make the first step easier to review, the current series
> focuses only on the SMBus/I2C transport layer.
> 
> Patch 1 introduces a minimal MCTP-over-I2C responder core together with
> a simple NCSI-related extension built on top of it. Patch 2 wires the
> device into the ASPEED AST2600 EVB machine for initial testing.
> 
> The goal of this series is not to implement a full MCTP stack, but to
> provide a small and practical foundation for simple emulation use cases.
> 
> This is my first submission to the QEMU upstream community, so any
> comments, suggestions, or corrections would be valuable.
Hi.

There have been a couple of tries at mctp emulation before
in qemu and I'm maintaining (currently out of tree) emulation of
CXL fmapi over mctp over usb.  I dropped an equivalent using i2c from
the CXL tree because it relied on the aspeed i2c controller and we only
cared about server level systems (x86 and arm64) where that was an odd
thing to hack in :)

https://gitlab.com/jic23/qemu/-/commit/d4c8c25d90253349ba8808a57a2991e6f784930d
has the usb device.

I went monolothic with the design this time around because there wasn't a lot
of sharing with the prior i2c mctp stack as the mctp transport independent
stuff was too small + that series (see below) wasn't going anywhere.

Prior to that there was nvme-mi and code more similar to what you have

https://lore.kernel.org/qemu-devel/20230914-nmi-i2c-v6-0-11bbb4f74d18@samsung.com/
Would be good to know how this differs. IIRC that project stalled on getting
tests in place rather than any fundamental problems.

It might be better to focus on building on top of that earlier work than
spinning something new.


> 
> mctp spec[0]: https://www.dmtf.org/sites/default/files/standards/documents/DSP0236_1.3.1.pdf
> mctp i2c binding[1]: https://www.dmtf.org/sites/default/files/standards/documents/DSP0237_1.2.0.pdf
> ncsi spec[2]: https://www.dmtf.org/sites/default/files/standards/documents/DSP0222_1.2.0.pdf
> 
> Jian Zhang (2):
>   hw/misc: introduce mctp I2C responder and NCSI support
>   hw/arm/aspeed: add mctp responder device for test
> 
>  MAINTAINERS                          |   2 +
>  hw/arm/aspeed_ast2600_evb.c          |  14 +
>  hw/misc/Kconfig                      |   5 +
>  hw/misc/mctp-i2c-responder-ncsi.c    | 777 +++++++++++++++++++++++++++
>  hw/misc/mctp-i2c-responder.c         | 694 ++++++++++++++++++++++++
>  hw/misc/meson.build                  |   5 +
>  include/hw/misc/mctp-i2c-responder.h | 116 ++++
>  7 files changed, 1613 insertions(+)
>  create mode 100644 hw/misc/mctp-i2c-responder-ncsi.c
>  create mode 100644 hw/misc/mctp-i2c-responder.c
>  create mode 100644 include/hw/misc/mctp-i2c-responder.h
> 


