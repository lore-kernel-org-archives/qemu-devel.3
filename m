Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 923B2C25B5C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 11:46:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3wmq-0002BI-0z; Mon, 06 May 2024 07:45:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1s3wmU-0001q2-Rb
 for qemu-devel@nongnu.org; Mon, 06 May 2024 07:45:29 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1s3wmT-0001vE-0a
 for qemu-devel@nongnu.org; Mon, 06 May 2024 07:45:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=f5kowjNmM1V5Tw1z4x5IIe927kwIc/2zGVQMsZgVWG0=; b=vnISCjbuclUVCrzuPgfCO+xolc
 T0vgyR1B7O1aeZy3mCaXE+evDfMBgIYGiLV6bhgrx0sX9PcMKT1Dh8IBy9yefSfqzJPByGkMuqC44
 lw3vK2SF4SaPm1FvlIg3As0tPuTi6BvQyUyVqnJxeMv04ppqIVWlxgS1sRCqJcjU0eEoAawwc9ny6
 OLgNL0NG99/2YaTKU6td22VDJwqeLxOKN5R+hK8F+kCLKpkEvJ3Uvbz8iJvOO0AfQ6ItsOcA7Eoye
 WopxzVliKHU5eXqezSYhsstpJ972BGyZLnl1/O+h1Zr5S/FXjuOSLmeIDRiyvL6nirGKuTYLSH9w7
 TOhWa0c8n+bIvuPunvG1h0o6EsUUzP2/A+0+rJ/nVIH8ZhfbCty/5Qhg+7sF2+jkvycGkFb+6+295
 kKMasWs/mFTUj3fuEXmyXpeb3bplt4eUKaDgv9X9KOxItiLXk7BUkfzX//2NFhx9KxLJo6/pmNu5h
 3z2H6jOVgZM7vNMAyil94v36l6duLQ1bULGzdVoVez5CU5uMX1IhfLIuDe04/ZxbvrNcqisPa5voA
 6Yec2z0DBQVvhryiXQNpnOCX9S1boNSOToaNI+4bHZdX1+HBrYEbMBhSLOAsb8xdMxBL8vxQu2HRm
 ILqKBlKCZSWqI0pdUXG7mAlmQkj3dl2hv06ReWTbs=;
Received: from [2a00:23c4:8bb4:4000:b60d:a162:d698:c802]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1s3wlK-0005pA-IZ; Mon, 06 May 2024 12:44:10 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: qemu-devel@nongnu.org,
	richard.henderson@linaro.org
Date: Mon,  6 May 2024 12:44:42 +0100
Message-Id: <20240506114451.331311-4-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240506114451.331311-1-mark.cave-ayland@ilande.co.uk>
References: <20240506114451.331311-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb4:4000:b60d:a162:d698:c802
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PULL 03/12] docs/system/target-sparc: Improve the Sparc documentation
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

From: Thomas Huth <thuth@redhat.com>

Add some words about how to enable or disable boolean features,
and remove the note about a Linux kernel being available on the
QEMU website (they have been removed long ago already), and the
note about NetBSD and OpenBSD still having issues (they should
work fine nowadays).

Fixes: https://gitlab.com/qemu-project/qemu/-/issues/2141
Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240419084812.504779-4-thuth@redhat.com>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 docs/system/target-sparc.rst | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/docs/system/target-sparc.rst b/docs/system/target-sparc.rst
index 9ec8c90c14..4116cac493 100644
--- a/docs/system/target-sparc.rst
+++ b/docs/system/target-sparc.rst
@@ -27,6 +27,11 @@ architecture machines:
 The emulation is somewhat complete. SMP up to 16 CPUs is supported, but
 Linux limits the number of usable CPUs to 4.
 
+The list of available CPUs can be viewed by starting QEMU with ``-cpu help``.
+Optional boolean features can be added with a "+" in front of the feature name,
+or disabled with a "-" in front of the name, for example
+``-cpu TI-SuperSparc-II,+float128``.
+
 QEMU emulates the following sun4m peripherals:
 
 -  IOMMU
@@ -55,8 +60,5 @@ OpenBIOS is a free (GPL v2) portable firmware implementation. The goal
 is to implement a 100% IEEE 1275-1994 (referred to as Open Firmware)
 compliant firmware.
 
-A sample Linux 2.6 series kernel and ram disk image are available on the
-QEMU web site. There are still issues with NetBSD and OpenBSD, but most
-kernel versions work. Please note that currently older Solaris kernels
-don't work probably due to interface issues between OpenBIOS and
-Solaris.
+Please note that currently older Solaris kernels don't work; this is probably
+due to interface issues between OpenBIOS and Solaris.
-- 
2.39.2


