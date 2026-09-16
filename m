Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99F8AC88E5C
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 04:38:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6hPF-0000P4-MF; Wed, 16 Sep 2026 00:38:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1x6hOv-0000NJ-AG; Wed, 16 Sep 2026 00:37:41 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1x6hOq-0000AH-Rj; Wed, 16 Sep 2026 00:37:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1789533401; bh=+j9O/7tluwaYInDQcn9Szmr6B2fm4OS9Xch3KBTS+Gs=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=oHF4aHNqr8lgcqcNWa9NxdyZLh9UOvp2G2SBCU8QXjHeOhm5uWkwKNa5xFPeY5pvz
 3WYSLi+8UQPVVvRy/GZXnZcokqoGD/Rj7MpaPId2ZYb6FbijD75P3RDu+Fc2jLH5zF
 5oP8xBSl8OcBOz4YqdgflZMyOqHtnaAKZBNEwvUAXQrRR0mAFVDG4lSGMSQ0Bnvu3S
 rhV4DNuJn8M2nfQ5xVbuK4P4xL+kNmQtvAcMVUokrpZT1r94rGYpS0pCSpBWB6Mp4P
 pT+DN6G/5hdNExof7Ep/XlRdbky2uDN2LEJyOHYHzUNiYvKW5vDakwZvTtrgA4GcGR
 G5KVxAsBH9jLw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id A39731D54AE;
 Wed, 16 Sep 2026 07:36:41 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id B3E5D429869;
 Wed, 16 Sep 2026 07:37:23 +0300 (MSK)
Message-ID: <83d78d2f-f85d-4d6c-b388-9c301fe572e1@tls.msk.ru>
Date: Wed, 16 Sep 2026 07:37:23 +0300
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH] hw/intc/bcm2835_ic: reject out-of-range FIQ source values
To: Bin Guo <guobin@linux.alibaba.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, philmd@mailo.com, farosas@suse.de,
 lvivier@redhat.com, pbonzini@redhat.com, qemu-arm@nongnu.org,
 QEMU Stable <qemu-stable@nongnu.org>
References: <20260831081709.77725-1-guobin@linux.alibaba.com>
Content-Language: en-US, ru-RU
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20260831081709.77725-1-guobin@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 8/31/26 11:17, Bin Guo wrote:
> The FIQ_CONTROL register accepts a 7-bit source selector, but only
> sources 0..71 (64 GPU + 8 ARM IRQs) exist.  Values 96..127 cause
> bcm2835_ic_update() to call extract32(arm_irq_level, start, 1) with
> start >= 32, which trips the assertion in bitops.h and aborts QEMU.
> 
> Reject writes that select a non-existent source and log a guest error,
> so that a malicious or buggy guest cannot kill the emulator.
> 
> Add a qtest that verifies both valid and out-of-range FIQ source
> selections on raspi3b.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4368
> Signed-off-by: Bin Guo <guobin@linux.alibaba.com>
> ---
>   hw/intc/bcm2835_ic.c          | 13 +++++--
>   tests/qtest/bcm2835-ic-test.c | 66 +++++++++++++++++++++++++++++++++++
>   tests/qtest/meson.build       |  2 +-
>   3 files changed, 78 insertions(+), 3 deletions(-)
>   create mode 100644 tests/qtest/bcm2835-ic-test.c

I'm picking this up for currently active stable qemu series.
Please let me know if I shouldn't.

Thanks,

/mjt

