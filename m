Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E79A8C79F9F
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 11:46:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4dDr-0003K2-0z; Thu, 10 Sep 2026 07:45:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@posteo.eu>) id 1x4dDp-0003Jd-Rc
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 07:45:41 -0400
Received: from mout02.posteo.de ([185.67.36.66])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@posteo.eu>) id 1x4dDn-0000Q8-Oc
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 07:45:41 -0400
Received: from submission (posteo.de [185.67.36.169]) 
 by mout02.posteo.de (Postfix) with ESMTPS id 401C5240103
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 13:45:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.eu;
 s=1984.8680eb; t=1789040738;
 bh=NguyLcYreEQOArbweJkmqLsOnkaEqvk/AwEEX7Eb+co=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
 Content-Transfer-Encoding:From;
 b=ihnZVMDVWVC8aAcKcGF2p1kTCNr+K3uQksTbsHAvIc67fKeVvP027zXZPbE/sXLMr
 AjWOJy3dRqq/NWzluVo+o51duLqHQJlLCkV4llwLnqTuliHw7PY6q+4wsayiK8zGYd
 KkYubtWT1sUjKvXwQ+qCz9mhy8xTlxAZnNJyRZZX2QXV5bDb7yW0PW9CLfJjQhAV+G
 UwqX8hyXZPVsinnHeqhC2lv13cCyfIf67Yz3VXsy8QR1xuL0ks61xD5LPhIHawJLN3
 QxgeSMOeSdLjDoy39qFlBsTvVOzhhNdPjcUecEhcICWwijLoRPjan1lBJXs/+YIic7
 yvbi61m0S/0Mw==
Received: from customer (localhost [127.0.0.1])
 by submission (posteo.de) with ESMTPSA id 4hgbTY1qrLz6tsg;
 Thu, 10 Sep 2026 13:45:37 +0200 (CEST)
From: Thomas Huth <th.huth@posteo.eu>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 2/7] docs/about: Deprecate the 'next-cube' m68k machine
Date: Thu, 10 Sep 2026 11:45:37 +0000
Message-ID: <20260910114522.396396-3-th.huth@posteo.eu>
In-Reply-To: <20260910114522.396396-1-th.huth@posteo.eu>
References: <20260910114522.396396-1-th.huth@posteo.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=185.67.36.66; envelope-from=th.huth@posteo.eu;
 helo=mout02.posteo.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The machine is incomplete since years and we never managed to fully boot
a kernel with it. So it's maybe best if we mark this machine as deprecated
and finally remove it again in case it gets into the way of a code
refactoring or other reasons.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <20260828095241.118458-3-th.huth@posteo.eu>
Signed-off-by: Thomas Huth <th.huth@posteo.eu>
---
 docs/about/deprecated.rst | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 98c32991c9..f20f0976bc 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -249,6 +249,14 @@ was an early implementation of memory encryption support in QEMU, but it has
 been superseded by the more comprehensive ``confidential-guest-support``
 object.
 
+``next-cube`` m68k machine (since 11.2)
+'''''''''''''''''''''''''''''''''''''''
+
+The machine never got fully implemented and can only show the firmware prompt.
+Given the incomplete state and slow progress on improvements, it might get
+removed again without replacement.
+
+
 Backend options
 ---------------
 
-- 
2.55.0


