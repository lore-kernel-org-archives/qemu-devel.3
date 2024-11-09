Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 818AED5E364
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Nov 2024 10:18:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9iXk-0000Vb-IH; Sat, 09 Nov 2024 05:18:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1t9iVg-0005K2-7K; Sat, 09 Nov 2024 05:16:04 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1t9iVe-0007vK-GC; Sat, 09 Nov 2024 05:16:03 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 43232A13F8;
 Sat,  9 Nov 2024 13:13:50 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id E33C8167EE4;
 Sat,  9 Nov 2024 13:14:44 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.8 20/49] tests/qemu-iotests/211.out: Update to expect
 MapEntry 'compressed' field
Date: Sat,  9 Nov 2024 13:14:11 +0300
Message-Id: <20241109101443.312701-20-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-8.2.8-20241109131339@cover.tls.msk.ru>
References: <qemu-stable-8.2.8-20241109131339@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Peter Maydell <peter.maydell@linaro.org>

In commit 52b10c9c0c68e90f in 2023 the QAPI MapEntry struct was
updated to add a 'compressed' field. That commit updated a number
of iotest expected-output files, but missed 211, which is vdi
specific. The result is that
 ./check -vdi
and more specifically
 ./check -vdi 211
fails because the expected and actual output don't match.

Update the reference output.

Cc: qemu-stable@nongnu.org
Fixes: 52b10c9c0c68e90f ("qemu-img: map: report compressed data blocks")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20241008164708.2966400-4-peter.maydell@linaro.org>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
(cherry picked from commit d60bd080e783107cb876a6f16561fe03f9dcbca7)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/tests/qemu-iotests/211.out b/tests/qemu-iotests/211.out
index f02c75409c..ff9f9a6913 100644
--- a/tests/qemu-iotests/211.out
+++ b/tests/qemu-iotests/211.out
@@ -17,7 +17,7 @@ file format: IMGFMT
 virtual size: 128 MiB (134217728 bytes)
 cluster_size: 1048576
 
-[{"data": false, "depth": 0, "length": 134217728, "present": true, "start": 0, "zero": true}]
+[{"compressed": false, "data": false, "depth": 0, "length": 134217728, "present": true, "start": 0, "zero": true}]
 === Successful image creation (explicit defaults) ===
 
 {"execute": "blockdev-create", "arguments": {"job-id": "job0", "options": {"driver": "file", "filename": "TEST_DIR/PID-t.vdi", "size": 0}}}
@@ -35,7 +35,7 @@ file format: IMGFMT
 virtual size: 64 MiB (67108864 bytes)
 cluster_size: 1048576
 
-[{"data": false, "depth": 0, "length": 67108864, "present": true, "start": 0, "zero": true}]
+[{"compressed": false, "data": false, "depth": 0, "length": 67108864, "present": true, "start": 0, "zero": true}]
 === Successful image creation (with non-default options) ===
 
 {"execute": "blockdev-create", "arguments": {"job-id": "job0", "options": {"driver": "file", "filename": "TEST_DIR/PID-t.vdi", "size": 0}}}
@@ -53,7 +53,7 @@ file format: IMGFMT
 virtual size: 32 MiB (33554432 bytes)
 cluster_size: 1048576
 
-[{"data": true, "depth": 0, "length": 3072, "offset": 1024, "present": true, "start": 0, "zero": false}, {"data": true, "depth": 0, "length": 33551360, "offset": 4096, "present": true, "start": 3072, "zero": true}]
+[{"compressed": false, "data": true, "depth": 0, "length": 3072, "offset": 1024, "present": true, "start": 0, "zero": false}, {"compressed": false, "data": true, "depth": 0, "length": 33551360, "offset": 4096, "present": true, "start": 3072, "zero": true}]
 === Invalid BlockdevRef ===
 
 {"execute": "blockdev-create", "arguments": {"job-id": "job0", "options": {"driver": "vdi", "file": "this doesn't exist", "size": 33554432}}}
-- 
2.39.5


