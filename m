Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7BA6C531CB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 10:41:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmqqm-00034w-TR; Thu, 23 Jul 2026 06:40:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pisa@fel.cvut.cz>) id 1wmqqb-00034Y-3R
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 06:40:13 -0400
Received: from smtpx.feld.cvut.cz ([2001:718:2:1516::210:153]
 helo=smtpx.fel.cvut.cz)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_CHACHA20_POLY1305:256)
 (Exim 4.90_1) (envelope-from <pisa@fel.cvut.cz>) id 1wmqqY-0007Zx-HH
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 06:40:12 -0400
Received: from localhost (unknown [192.168.200.27])
 by smtpx.fel.cvut.cz (Postfix) with ESMTP id BD60D266DE;
 Thu, 23 Jul 2026 12:40:02 +0200 (CEST)
X-Virus-Scanned: IMAP STYX AMAVIS
Received: from smtpx.fel.cvut.cz ([192.168.200.2])
 by localhost (cerokez-250.feld.cvut.cz [192.168.200.27]) (amavis, port 10060)
 with ESMTP id mmaMnOqddThs; Thu, 23 Jul 2026 12:40:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fel.cvut.cz;
 s=felmail; t=1784802935;
 bh=/hvEb1tIm+mOiN6F7dry3Krqr4vFXJRAKDWO/1ziEi0=;
 h=From:To:Subject:Date:Cc:References:In-Reply-To:From;
 b=CRPErIBWdAEbOuGQKYzNWuG2oin+pYY3fkizcu3Hle6/PC34YMxvUze1vQk85MoUj
 raQd5kJ4tVbrDi2qYLOL/Yyd4GrsS+tCj7Kk2C68uoNON83hx9DgfbfcwqQTPFo3YS
 xIZC55OKYjFq5+G3YBItvPQtT6owEk4YJYlLgps2VOtb+5u9LCaY1bdUDkeB0bofeI
 bo/+bzokfgSQq2zdKSMmvRJf9G4Xceusldsj5uitjpjv82qWOsVRV3PEmN9nQ6IxKR
 Im50QLFYDaygisqMYSPy8wN6nEg8l+gFZfJtzdffDQebWWsOXsLPlQj7B4ZV++GLYb
 m5IOxx/EC+S0g==
Received: from [147.32.86.199] (unknown [147.32.86.199])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: pisa)
 by smtpx.fel.cvut.cz (Postfix) with ESMTPSA id 91F2226768;
 Thu, 23 Jul 2026 12:35:34 +0200 (CEST)
From: Pavel Pisa <pisa@fel.cvut.cz>
To: Bernhard Beschow <shentey@gmail.com>
Subject: Re: [PATCH 0/9] FlexCAN fixes for-11.1
Date: Thu, 23 Jul 2026 12:35:34 +0200
User-Agent: KMail/1.9.10
Cc: qemu-devel@nongnu.org, Matyas Bobek <matyas.bobek@gmail.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Jason Wang <jasowangio@gmail.com>,
 Vikram Garhwal <vikram.garhwal@bytedance.com>
References: <20260723070059.6332-1-shentey@gmail.com>
In-Reply-To: <20260723070059.6332-1-shentey@gmail.com>
X-KMail-QuotePrefix: > 
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <202607231235.34073.pisa@fel.cvut.cz>
Received-SPF: pass client-ip=2001:718:2:1516::210:153;
 envelope-from=pisa@fel.cvut.cz; helo=smtpx.fel.cvut.cz
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, NICE_REPLY_A=-2.494, SPF_HELO_NONE=0.001,
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

Hello Bernhard and others,

On Thursday 23 of July 2026 09:00:50 Bernhard Beschow wrote:
> This series attempts to fix the Coveriy issues pointed out by Peter in the
> FlexCAN emulation [1]. In addition, it fixes some reset masks to preserve
> register contents across resets as intended. It also fixes some register
> offsets due to a union being inadvertantly too large; this would affect
> migration if addressed after the release. Last but not least it eliminates
> an unneeded union.
>
> Testing done:
> * `make check`
> * Run `cangen` and `candump` on the host and guest in both directions
>
> [1]
> https://lore.kernel.org/qemu-devel/CAFEAcA-QBiPfgN4YJXD9FQULobpBVNgeJHSqG7E
>qg1CzyKTfaA@mail.gmail.com/
>
> Bernhard Beschow (9):
>   hw/net/can/flexcan: Use mbs[] array for FIFO pop
>   hw/net/flexcan: Drop unused RX FIFO register overlay
>   hw/net/can/flexcan: Fix out-of-bounds access in flexcan_mx_rx()
>   hw/net/can/flexcan: Fix mailbox index calculation in
>     flexcan_mem_write()
>   hw/net/can/flexcan: Fix mailbox index calculation in
>     flexcan_mem_read()
>   hw/net/can/flexcan: Fix mailbox reset mask initialization
>   hw/net/flexcan: Drop oversized 'mb[]' mailbox view
>   hw/net/can/flexcan: Fix RXIMR reset mask
>   hw/net/can/flexcan: Remove RX SMB raw view
>
>  include/hw/net/flexcan.h | 22 +++----------------
>  hw/net/can/flexcan.c     | 47 ++++++++++++++++++++++++----------------
>  2 files changed, 31 insertions(+), 38 deletions(-)

Tested-by: Pavel Pisa <pisa@fel.cvut.cz>

I have tested QEMU mainline with your patches applied
to behave correctly with SableLitte machine emulation
and sending of CAN frames from it and to it from the host
system. You can add my confirmation individual patches
as well if you want.

best wishes,

                Pavel Pisa
    phone:      +420 603531357
    e-mail:     pisa@cmp.felk.cvut.cz
    Department of Control Engineering FEE CVUT
    Karlovo namesti 13, 121 35, Prague 2
    university: http://control.fel.cvut.cz/
    personal:   http://cmp.felk.cvut.cz/~pisa
    social:     https://social.kernel.org/ppisa
    projects:   https://www.openhub.net/accounts/ppisa
    CAN related:http://canbus.pages.fel.cvut.cz/
    RISC-V education: https://comparch.edu.cvut.cz/
    Open Technologies Research Education and Exchange Services
    https://gitlab.fel.cvut.cz/otrees/org/-/wikis/home

