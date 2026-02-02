Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC926E7FDF5
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 22:09:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vn25o-0004oB-Re; Mon, 02 Feb 2026 17:08:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vn25m-0004mY-3I; Mon, 02 Feb 2026 17:08:22 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vn25k-0002ZL-Ju; Mon, 02 Feb 2026 17:08:21 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 100EC1852B1;
 Tue, 03 Feb 2026 01:07:34 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id DEBBE35B3C4;
 Tue, 03 Feb 2026 01:08:15 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Ed Tanous <etanous@nvidia.com>, Patrick Williams <patrick@stwcx.xyz>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.2.1 04/56] tests/functional: Fix URL of gb200nvl-bmc image
Date: Tue,  3 Feb 2026 01:07:09 +0300
Message-ID: <20260202220805.945271-4-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.2.1-20260202173336@cover.tls.msk.ru>
References: <qemu-stable-10.2.1-20260202173336@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Cédric Le Goater <clg@redhat.com>

Commit [1] moved the FW image of the gb200nvl-bmc machine and broke
the associated functional test. Fix that.

[1] https://github.com/legoater/qemu-aspeed-boot/commit/52451b2472eeb40aa97e131aeea327e9d4a8a78a

Cc: Ed Tanous <etanous@nvidia.com>
Cc: Patrick Williams <patrick@stwcx.xyz>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Link: https://lore.kernel.org/qemu-devel/20251222073351.166720-1-clg@redhat.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
(cherry picked from commit 75bcfb98a13d14beb2ea95fb3c51da01c7102325)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/tests/functional/arm/test_aspeed_gb200nvl_bmc.py b/tests/functional/arm/test_aspeed_gb200nvl_bmc.py
index 8e8e3f05c1..e5f2dce0f5 100755
--- a/tests/functional/arm/test_aspeed_gb200nvl_bmc.py
+++ b/tests/functional/arm/test_aspeed_gb200nvl_bmc.py
@@ -11,7 +11,7 @@
 class GB200Machine(AspeedTest):
 
     ASSET_GB200_FLASH = Asset(
-        'https://github.com/legoater/qemu-aspeed-boot/raw/refs/heads/master/images/gb200nvl-obmc/obmc-phosphor-image-gb200nvl-obmc-20250702182348.static.mtd.xz',
+        'https://github.com/legoater/qemu-aspeed-boot/raw/refs/heads/master/images/gb200nvl-bmc/openbmc-20250702182348/obmc-phosphor-image-gb200nvl-obmc-20250702182348.static.mtd.xz',
         'b84819317cb3dc762895ad507705978ef000bfc77c50c33a63bdd37921db0dbc')
 
     def test_arm_aspeed_gb200_openbmc(self):
-- 
2.47.3


