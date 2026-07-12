Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1AE0C43458
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jul 2026 04:18:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wildg-0004Cx-Cv; Sun, 12 Jul 2026 00:18:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wildY-000470-0A; Sun, 12 Jul 2026 00:17:52 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wildV-0006UH-V9; Sun, 12 Jul 2026 00:17:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1783829781; bh=yirnsgBYBP+P5LTosEOX+6NsSsAkf1u82Z1cRgXB6/w=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=JCLjtJPtP0bQYM2EAvFxGxOYVliVTFoJg5qPMrf3ZTZQSOU3IvIKtBl5fCe/mpxL4
 ruhqwqSQ8ubh3AQ/QtI5iDcbWHKHtCc6LeyzCEbpNU71kXdUzdRAm9/evIcTcCCiNQ
 uwk6+GlQf9EYkFvA7cx7miSRUQjKWyFE7UEKc+kfnDeoomuz8EBk00D3973+ZGicpl
 3i4DcaZmSfCrwZCJ8+ad7XISEzJI/hYyUNQMcm/KsVAu0S+UZY9CiVHNLIL5YkPGpO
 y5T2RezdNTfP6Qmr2gsFdDtaCAzIgtRsAvC7Fjut5xgJRvAAq/sHOJZHnG6Y+B7fkQ
 4K3DRmZVZ9UaA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 2A7991C0BF0;
 Sun, 12 Jul 2026 07:16:21 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 5B8F13EB950;
 Sun, 12 Jul 2026 07:16:31 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 45E55133E3; Sun, 12 Jul 2026 07:16:31 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.12 21/75] tests/9p: increase P9_MAX_SIZE for test client
Date: Sun, 12 Jul 2026 07:14:39 +0300
Message-ID: <20260712041539.108341-21-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.12-20260712071526@cover.tls.msk.ru>
References: <qemu-stable-10.0.12-20260712071526@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_MSPIKE_H2=0.001,
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

From: Christian Schoenebeck <qemu_oss@crudebyte.com>

Increase the maximum 9P message size ('msize') of 9p test client from
4k to 32k to support larger messages.

This is needed for the xattr tests being added with the subsequent
patches which are going to transmit xattrs of size 8k. It would have
also been possible to send them in multiple chunks, however let's not
overcomplicate things.

This new msize is still reasonable small compared to common msize
values on production systems.

Link: https://lore.kernel.org/qemu-devel/2dcb1243c80ea97d085af5171785850cf012be36.1781361555.git.qemu_oss@crudebyte.com
Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
(cherry picked from commit df88255543667e7f14ac34d97e0ced142af18bdf)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/tests/qtest/libqos/virtio-9p-client.h b/tests/qtest/libqos/virtio-9p-client.h
index aa7276d2c3a..cbd298cc401 100644
--- a/tests/qtest/libqos/virtio-9p-client.h
+++ b/tests/qtest/libqos/virtio-9p-client.h
@@ -21,7 +21,8 @@
 #include "qgraph.h"
 #include "tests/qtest/libqtest-single.h"
 
-#define P9_MAX_SIZE 4096 /* Max size of a T-message or R-message */
+/* Max size of a T-message or R-message */
+#define P9_MAX_SIZE (32 * 1024)
 
 typedef struct {
     QTestState *qts;
-- 
2.47.3


