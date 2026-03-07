Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABC2EF513F1
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2026 15:38:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vytj5-0007eS-L5; Sat, 07 Mar 2026 10:37:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth+qemu@posteo.eu>)
 id 1vytgT-0007JJ-Cs
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 10:35:17 -0500
Received: from mout02.posteo.de ([185.67.36.66])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth+qemu@posteo.eu>)
 id 1vytgR-0001Q0-5l
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 10:35:17 -0500
Received: from submission (posteo.de [185.67.36.169]) 
 by mout02.posteo.de (Postfix) with ESMTPS id AF76A240101
 for <qemu-devel@nongnu.org>; Sat,  7 Mar 2026 16:35:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.eu; s=2017;
 t=1772897710; bh=Ddg+UTE+HfUx+bWQrGtqBGnFkrQpiH+jalmKAsRRhZI=;
 h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
 Content-Transfer-Encoding:From;
 b=WGqjRVY19CvHq923gdMR3poBEU4rJJivtT0XAti7WKKJlVpafFv+W3mxo/2WB8equ
 f8awhkdA0RkOaCohy0BBLh11/nSH+u44shIRzkIPzMAYEbpOvCmOBsqVQqZtDfFDGD
 A+/xkYDB/OvRE8iXvkTS/SPWc+6hL4Hf1Iel5DyNtdJEb4pSd3/RsE+S8c46IZeXYR
 syeiSC/Dr3lVE/BcLqihujFJwKOaWQwDuTBEdW9DeIo+SDBIW7dlG8gbRpWzaJakbV
 kH0KXFgqwQi9rr+pc4kyYmbEMpiBXZePl5QaTN6xxC+j0YxiH1J//BHcKHeq8HKnS/
 jx26ho3yf8p2g==
Received: from customer (localhost [127.0.0.1])
 by submission (posteo.de) with ESMTPSA id 4fSnQj2Y20z6tsf;
 Sat,  7 Mar 2026 16:35:09 +0100 (CET)
Date: Sat, 07 Mar 2026 15:35:10 +0000
From: Thomas Huth <th.huth+qemu@posteo.eu>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH] hw/m68k/mcf_intc: Use qdev input gpios for input IRQs
Message-ID: <20260307163508.44aa50f5@tpx1>
In-Reply-To: <20260306190425.3047580-1-peter.maydell@linaro.org>
References: <20260306190425.3047580-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=185.67.36.66; envelope-from=th.huth+qemu@posteo.eu;
 helo=mout02.posteo.de
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 07 Mar 2026 10:37:56 -0500
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

Am Fri,  6 Mar 2026 19:04:25 +0000
schrieb Peter Maydell <peter.maydell@linaro.org>:

> The m68k mcf_intc interrupt controller currently implements its
> inbound IRQ lines by calling qemu_allocate_irqs() in mcf_intc_init().
> This results in leaks like this:
> 
> Direct leak of 2944 byte(s) in 46 object(s) allocated from:
>     #0 0x5cf95ec15323 in malloc (/home/pm215/qemu/build/san/qemu-system-m68k+0xf9e323) (BuildId: 18d55ef8ea9856e68ee30802078af5050b8b06c5)
>     #1 0x7637c65c5ac9 in g_malloc (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x62ac9) (BuildId: 116e142b9b52c8a4dfd403e759e71ab8f95d8bb3)
>     #2 0x5cf95f6b2f27 in object_new_with_type /home/pm215/qemu/build/san/../../qom/object.c:767:15
>     #3 0x5cf95f6aa62e in qemu_allocate_irq /home/pm215/qemu/build/san/../../hw/core/irq.c:91:25
>     #4 0x5cf95f6aa62e in qemu_extend_irqs /home/pm215/qemu/build/san/../../hw/core/irq.c:79:16
>     #5 0x5cf95f5f6d99 in mcf5208evb_init /home/pm215/qemu/build/san/../../hw/m68k/mcf5208.c:310:11
> 
> This isn't an important leak, as it is memory we allocate once at
> QEMU startup and that has to stay live for the lifetime of the
> system.  However it does point at a code improvement.
> 
> Modernise this to have the device itself create inbound GPIOs with
> qdev_init_gpio_in() that the board can then refer to and wire up
> individually.
> 
> As the device is used in only a single board, we can update device
> and board in a single patch rather than having to try to figure out
> some way to change the API more piecemeal.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> there's quite a bit more in this board which could be
> modernised, but I stuck to just the thing getting reported
> as a memory leak...
> ---
>  hw/m68k/mcf5208.c     | 24 +++++++++++-------------
>  hw/m68k/mcf_intc.c    |  8 +++-----
>  include/hw/m68k/mcf.h |  5 ++---
>  3 files changed, 16 insertions(+), 21 deletions(-)

Reviewed-by: Thomas Huth <th.huth+qemu@posteo.eu>


