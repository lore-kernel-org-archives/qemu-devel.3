Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2956DC27C4F
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Jun 2024 16:55:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNxoi-0005sv-F2; Sun, 30 Jun 2024 12:54:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sNxog-0005sN-Va; Sun, 30 Jun 2024 12:54:18 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sNxof-0005LS-EF; Sun, 30 Jun 2024 12:54:18 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id DE4CA75768;
 Sun, 30 Jun 2024 19:53:20 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id B3430FAD65;
 Sun, 30 Jun 2024 19:53:27 +0300 (MSK)
Received: (nullmailer pid 38234 invoked by uid 1000);
 Sun, 30 Jun 2024 16:53:27 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Hyeongtak Ji <hyeongtak.ji@gmail.com>, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL 11/16] docs/cxl: fix some typos
Date: Sun, 30 Jun 2024 19:53:21 +0300
Message-Id: <20240630165327.38153-12-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240630165327.38153-1-mjt@tls.msk.ru>
References: <20240630165327.38153-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

From: Hyeongtak Ji <hyeongtak.ji@gmail.com>

This patch corrects minor typographical errors to ensure the ASCII art
aligns with the explanations provided.  Specifically, it fixes an
incorrect root port reference and removes redundant words.

Signed-off-by: Hyeongtak Ji <hyeongtak.ji@gmail.com>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 docs/system/devices/cxl.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/docs/system/devices/cxl.rst b/docs/system/devices/cxl.rst
index 10a0e9bc9f..882b036f5e 100644
--- a/docs/system/devices/cxl.rst
+++ b/docs/system/devices/cxl.rst
@@ -218,17 +218,17 @@ Notes:
     A complex configuration here, might be to use the following HDM
     decoders in HB0. HDM0 routes CFMW0 requests to RP0 and hence
     part of CXL Type3 0. HDM1 routes CFMW0 requests from a
-    different region of the CFMW0 PA range to RP2 and hence part
+    different region of the CFMW0 PA range to RP1 and hence part
     of CXL Type 3 1.  HDM2 routes yet another PA range from within
     CFMW0 to be interleaved across RP0 and RP1, providing 2 way
     interleave of part of the memory provided by CXL Type3 0 and
     CXL Type 3 1. HDM3 routes those interleaved accesses from
     CFMW1 that target HB0 to RP 0 and another part of the memory of
     CXL Type 3 0 (as part of a 2 way interleave at the system level
-    across for example CXL Type3 0 and CXL Type3 2.
+    across for example CXL Type3 0 and CXL Type3 2).
     HDM4 is used to enable system wide 4 way interleave across all
     the present CXL type3 devices, by interleaving those (interleaved)
-    requests that HB0 receives from from CFMW1 across RP 0 and
+    requests that HB0 receives from CFMW1 across RP 0 and
     RP 1 and hence to yet more regions of the memory of the
     attached Type3 devices.  Note this is a representative subset
     of the full range of possible HDM decoder configurations in this
-- 
2.39.2


