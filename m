Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04CCFF459F7
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 16:23:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBEe1-0000ic-8m; Fri, 10 Apr 2026 12:23:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <development@knutsson.it>)
 id 1wBDd5-0008Om-AA
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 11:18:43 -0400
Received: from mailrelay-egress7.pub.mailoutpod2-cph3.one.com
 ([2a02:2350:5:406::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <development@knutsson.it>)
 id 1wBDcw-0006Pr-Kf
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 11:18:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1775834307;
 x=1776439107; d=knutsson.it; s=rsa2;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
 from; bh=9+u8wqmbr1lAl61+IwU3J6uiEbgb7m00kIJ24uR++gs=;
 b=jehan3Id+NbO4+sfJj/7V11mj5clhotLuGF8HUfhEPdqHx27eM6Lu6lxgVe/yIUoChHr/JUJgVd8n
 PgAaKFgJLD8iRBd7gBaCG03YM18hbVwHdeTaRfCTGgbesFb+qPxqNB3hu+pn4N2kj+BtqnBk0sj8Vz
 8dEs/I5u0kybzTIHu+9co0X0UkbsAVMH6hUP+4+MA6GsWGGqzD7D70G/P6Ns5bxtgIeCsAQ7eF1Mvy
 MXExiEikYxr3Ckh8HhKWOzMhoYFC/7PDPFacc1L44YV7/Xubu4KpDwdf6K4rppn01eYyK5VGpWgRPK
 1wtcz08QpRQP0Lqn5udi17NUdv861rA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1775834307;
 x=1776439107; d=knutsson.it; s=ed2;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
 from; bh=9+u8wqmbr1lAl61+IwU3J6uiEbgb7m00kIJ24uR++gs=;
 b=AGzRB8VrAtExaeNLi9O0TJPIBt+kiXIi51JahUtYy/Z/70rF4wdMPIg4Fg23F6oB7okACwXbCt/xv
 cHBANJ8Ag==
X-HalOne-ID: 85c30dd3-34f0-11f1-a888-4f541c8bf1cc
Received: from critbfk-Desktop.int.essentialive.dk
 (0x573e6412.static.cust.fastspeed.dk [87.62.100.18])
 by mailrelay3.pub.mailoutpod2-cph3.one.com (Halon) with ESMTPSA
 id 85c30dd3-34f0-11f1-a888-4f541c8bf1cc;
 Fri, 10 Apr 2026 15:18:27 +0000 (UTC)
From: Brian Knutsson <development@knutsson.it>
To: qemu-devel@nongnu.org
Cc: Knutsson Development <development@knutsson.it>
Subject: [PATCH] monitor: fix missing spaces in screendump help text
Date: Fri, 10 Apr 2026 17:18:18 +0200
Message-ID: <20260410151818.817298-1-development@knutsson.it>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:2350:5:406::1;
 envelope-from=development@knutsson.it;
 helo=mailrelay-egress7.pub.mailoutpod2-cph3.one.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 10 Apr 2026 12:23:43 -0400
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

From: Knutsson Development <development@knutsson.it>

Signed-off-by: Knutsson Development <development@knutsson.it>
---
 hmp-commands.hx | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hmp-commands.hx b/hmp-commands.hx
index 5cc4788f12..b6f3b8a796 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -257,8 +257,8 @@ ERST
         .name       = "screendump",
         .args_type  = "filename:F,format:-fs,device:s?,head:i?",
         .params     = "filename [-f format] [device [head]]",
-        .help       = "save screen from head 'head' of display device 'device'"
-                      "in specified format 'format' as image 'filename'."
+        .help       = "save screen from head 'head' of display device 'device' "
+                      "in specified format 'format' as image 'filename'. "
                       "Currently only 'png' and 'ppm' formats are supported.",
          .cmd        = hmp_screendump,
         .coroutine  = true,
-- 
2.48.1


