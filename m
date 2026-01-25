Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 033FBD7237B
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Jan 2026 22:15:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vk8Np-0006WW-H4; Sun, 25 Jan 2026 17:15:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vk8Nn-0006Vd-R7
 for qemu-devel@nongnu.org; Sun, 25 Jan 2026 17:14:59 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vk8Nm-0004BZ-35
 for qemu-devel@nongnu.org; Sun, 25 Jan 2026 17:14:59 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id EAE025969F2;
 Sun, 25 Jan 2026 23:14:54 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id dMnqtDSBaP6l; Sun, 25 Jan 2026 23:14:52 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 996625969F1; Sun, 25 Jan 2026 23:14:52 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 93CC45969F0;
 Sun, 25 Jan 2026 23:14:52 +0100 (CET)
Date: Sun, 25 Jan 2026 23:14:52 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: orion cai <orion@orions-MacBook-Air.local>
cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v2 0/2] Fix integer overflow in RTL8139 rx buffer handling
In-Reply-To: <20260125133335.F176349BB78@orions-MacBook-Air.local>
Message-ID: <508a4710-4d2c-59a0-b7b0-fdbc0a7dfcda@eik.bme.hu>
References: <20260125133335.F176349BB78@orions-MacBook-Air.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

On Sun, 25 Jan 2026, orion cai wrote:
> From bee06612dae03a07dd5a9fa407d3a834fad4c635 Mon Sep 17 00:00:00 2001
> From: Orion <orionhubble@163.com>
> Date: Sun, 25 Jan 2026 21:30:22 +0800
> Subject: [PATCH v2 0/2] Fix integer overflow in RTL8139 rx buffer handling
>
> This series fixes an integer overflow vulnerability in the RTL8139

It's not a series but a single patch, cover letter not needed but if you 
have cover it should be separate message with patch being a reply to it 
not in one message.

> network device emulation that could allow a malicious guest to
> bypass DMA bounds checks.
>
> The vulnerability occurs in rtl8139_write_buffer() when RxBufAddr
> accumulates to a high value after receiving many packets. The bounds
> check using addition (RxBufAddr + size) can overflow, bypassing the
> check.

v2 should not be against v1 but against QEMU master as if v1 never 
happened.

Regards,
BALATON Zoltan

