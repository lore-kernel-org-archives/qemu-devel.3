Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7527CD116F6
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Dec 2025 11:53:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQOw7-0003Ap-AR; Tue, 02 Dec 2025 06:52:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <whitebox@nefkom.net>)
 id 1vQOw4-0003AQ-Pi
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 06:52:48 -0500
Received: from mail-out.m-online.net ([212.18.0.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <whitebox@nefkom.net>)
 id 1vQOw2-0002wJ-Ua
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 06:52:48 -0500
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
 by mail-out.m-online.net (Postfix) with ESMTP id 4dLJzs2pZCz1sG7h;
 Tue,  2 Dec 2025 12:52:41 +0100 (CET)
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
 by mail-out.m-online.net (Postfix) with ESMTP id 4dLJzr2V3Qz1sG7Z;
 Tue,  2 Dec 2025 12:52:40 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
 by mail.m-online.net (Postfix) with ESMTP id 4dLJzr0lkSz1qqlW;
 Tue,  2 Dec 2025 12:52:40 +0100 (CET)
X-Virus-Scanned: amavis at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
 by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavis, port 10024)
 with ESMTP id W5oXt_l26s0b; Tue,  2 Dec 2025 12:52:31 +0100 (CET)
X-Auth-Info: HDNZK9ZGnzMVPi8yY6uzIsrzMTo+DEbN+0fZDXYakVTqvpLcr1e+diZ0/SfwLYxf
Received: from igel.home (aftr-82-135-83-114.dynamic.mnet-online.de
 [82.135.83.114])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.mnet-online.de (Postfix) with ESMTPSA;
 Tue,  2 Dec 2025 12:52:31 +0100 (CET)
Received: by igel.home (Postfix, from userid 1000)
 id EAC822C1925; Tue,  2 Dec 2025 12:52:30 +0100 (CET)
From: Andreas Schwab <schwab@linux-m68k.org>
To: Vivian Wang <wangruikang@iscas.ac.cn>
Cc: qemu-devel@nongnu.org,  Laurent Vivier <laurent@vivier.eu>,  Luca
 Bonissi <qemu@bonslack.org>,  Richard Henderson
 <richard.henderson@linaro.org>
Subject: Re: [PATCH] linux-user: Add missing termios baud rates
In-Reply-To: <20251202-linux-user-higher-baud-rates-v1-1-14c49ed2474b@iscas.ac.cn>
 (Vivian Wang's message of "Tue, 02 Dec 2025 13:14:36 +0800")
References: <20251202-linux-user-higher-baud-rates-v1-1-14c49ed2474b@iscas.ac.cn>
Date: Tue, 02 Dec 2025 12:52:30 +0100
Message-ID: <87tsy9m77l.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=212.18.0.10; envelope-from=whitebox@nefkom.net;
 helo=mail-out.m-online.net
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.208, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Dez 02 2025, Vivian Wang wrote:

> The test tst-termios-linux requires termios2, which is provided by [1].
> After that the test failure reported in [2] should be resolved by this
> patch.

I still get a lot of errors with the two patches:

error: ../sysdeps/unix/sysv/linux/tst-termios-linux.c:196: c_ispeed = 75, expected 1200
error: ../sysdeps/unix/sysv/linux/tst-termios-linux.c:269: ospeed 75 ispeed 1200: kernel c_ispeed == 75, expected 1200
error: ../sysdeps/unix/sysv/linux/tst-termios-linux.c:274: ospeed 75 ispeed 1200: kernel CIBAUD = __B0 (000000), expected __B1200 (000011)
error: ../sysdeps/unix/sysv/linux/tst-termios-linux.c:196: c_ispeed = 9600, expected 456789
error: ../sysdeps/unix/sysv/linux/tst-termios-linux.c:269: ospeed 9600 ispeed 456789: kernel c_ispeed == 9600, expected 456789
error: ../sysdeps/unix/sysv/linux/tst-termios-linux.c:274: ospeed 9600 ispeed 456789: kernel CIBAUD = __B0 (000000), expected __BOTHER (010000)
error: ../sysdeps/unix/sysv/linux/tst-termios-linux.c:196: c_ispeed = 54321, expected 1234567890
error: ../sysdeps/unix/sysv/linux/tst-termios-linux.c:269: ospeed 54321 ispeed 1234567890: kernel c_ispeed == 54321, expected 1234567890
error: ../sysdeps/unix/sysv/linux/tst-termios-linux.c:274: ospeed 54321 ispeed 1234567890: kernel CIBAUD = __B0 (000000), expected __BOTHER (010000)
...
error: 8343 test failures

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."

