Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67C28CAC5B9
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Sep 2025 09:05:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v2Qqh-00044o-Dj; Sat, 27 Sep 2025 05:04:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1v2QqX-00042n-Bk; Sat, 27 Sep 2025 05:04:02 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1v2QqN-0006pz-Iy; Sat, 27 Sep 2025 05:04:01 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 2E9AA158557;
 Sat, 27 Sep 2025 12:03:02 +0300 (MSK)
Received: from think4mjt.origo (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 0B02B291574;
 Sat, 27 Sep 2025 12:03:05 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.21 02/16] .gitmodules: move u-boot mirrors to
 qemu-project-mirrors
Date: Sat, 27 Sep 2025 12:02:46 +0300
Message-ID: <20250927090304.2901324-2-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-7.2.21-20250927105809@cover.tls.msk.ru>
References: <qemu-stable-7.2.21-20250927105809@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Alex Bennée <alex.bennee@linaro.org>

To continue our GitLab Open Source Program license we need to pass an
automated license check for all repos under qemu-project. While U-Boot
is clearly GPLv2 rather than fight with the automated validation
script just move the mirror across to a separate project.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
Cc: qemu-stable@nongnu.org
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250908141911.2546063-1-alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
(cherry picked from commit a11d1847d5ef8a7db58e6d4e44f36fec708f0981)
(Mjt: adjust context for 7.2.x)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/.gitmodules b/.gitmodules
index 24cffa87d4..570d895aa1 100644
--- a/.gitmodules
+++ b/.gitmodules
@@ -21,7 +21,7 @@
 	url = https://gitlab.com/qemu-project/dtc.git
 [submodule "roms/u-boot"]
 	path = roms/u-boot
-	url = https://gitlab.com/qemu-project/u-boot.git
+	url = https://gitlab.com/qemu-project-mirrors/u-boot.git
 [submodule "roms/skiboot"]
 	path = roms/skiboot
 	url = https://gitlab.com/qemu-project/skiboot.git
@@ -36,7 +36,7 @@
 	url = https://gitlab.com/qemu-project/seabios-hppa.git
 [submodule "roms/u-boot-sam460ex"]
 	path = roms/u-boot-sam460ex
-	url = https://gitlab.com/qemu-project/u-boot-sam460ex.git
+	url = https://gitlab.com/qemu-project-mirrors/u-boot-sam460ex.git
 [submodule "tests/fp/berkeley-testfloat-3"]
 	path = tests/fp/berkeley-testfloat-3
 	url = https://gitlab.com/qemu-project/berkeley-testfloat-3.git
-- 
2.47.3


