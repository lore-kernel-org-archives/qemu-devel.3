Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97ADCE668BC
	for <qemu-devel@archiver.kernel.org>; Sun, 24 Nov 2024 17:09:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFG5o-0003oK-21; Sun, 24 Nov 2024 12:08:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <7017658155c517b9665b75333a97c79aa2d4f3df@kylie.crudebyte.com>)
 id 1tFG5c-0003nI-27; Sun, 24 Nov 2024 12:08:05 -0500
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <7017658155c517b9665b75333a97c79aa2d4f3df@kylie.crudebyte.com>)
 id 1tFG5a-0005I8-OK; Sun, 24 Nov 2024 12:08:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-Id:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=B88aiuakURSSwHg4O7Ir3dYxYVHzQIe08g+J0gXncyE=; b=cKVyV
 d6xjcKdfOTkke6ROc+bab+X+OEQvghR2qkIF0jHBoJSMPxj1sXIBnWnMF0u8HE2UzE+oTPmdemsv0
 dQCeC3q1QOleZ27AP0CBr7b/tXY3q77Zqf1KKddib/wMe+fcD88rOjlkWAMIXzFxHMILNRPQojsve
 OnYrUiF+w6wj+yvUyHPUceyJab8UgNfF7FXnhmlJospAO54Szuciq8cQVIzLMyyB8Nt6VJM9vLc2+
 BXvVhHOGYqOp4DSJBU6OAXhB+KSKVQ8WIrVQ56L2MBLMFSiKof43/JxvcY9sl9R2lz1osyac7qJhz
 79qRPsViD7HiB0c8ATzQo0ryXe53dCRXaIlO13r0f0Y37G94cF+ULTlOrIbCE4OF9LrNwuaqzzXkU
 SaJULCXpCwW9V3rnR0ZpK3xgiEgOiU+49cd84VEV/Gj2e4bNEQiI0LEx/iMTdl2IeLPaZhS/W3Ilp
 OpM+1XPpoTK8sylFO5Kw9e7wmEDG4egNZoQgv5TNAA+qikzJguKMeDGTCbp7UO5ozd8cd0J2aBtQs
 rfZWMHhZa7+Id/GWEXR5MmG4YKDHIvVA+QHh61oLFzL3txGY+oRseWCvkfeBkyS0VCjQKQw9/a629
 wqdUhPQ6Ibxf1PfMRT4gem5GbqB4okRCFkkz6EQl4HKk0FK0pxHTUjLgys0Ifg=;
Message-Id: <7017658155c517b9665b75333a97c79aa2d4f3df.1732465720.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1732465720.git.qemu_oss@crudebyte.com>
References: <cover.1732465720.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Sun, 24 Nov 2024 17:05:32 +0100
Subject: [PATCH 6/6] tests/9p: also check 'Tgetattr' in 'use-after-unlink' test
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
    Greg Kurz <groug@kaod.org>
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=7017658155c517b9665b75333a97c79aa2d4f3df@kylie.crudebyte.com;
 helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This verifies expected behaviour of previous bug fix patch.

Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 tests/qtest/virtio-9p-test.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tests/qtest/virtio-9p-test.c b/tests/qtest/virtio-9p-test.c
index f6d7400a87..ab3a12c816 100644
--- a/tests/qtest/virtio-9p-test.c
+++ b/tests/qtest/virtio-9p-test.c
@@ -702,6 +702,7 @@ static void fs_use_after_unlink(void *obj, void *data,
     g_autofree char *real_file = virtio_9p_test_path("09/doa_file");
     g_autofree char *buf = g_malloc0(write_count);
     struct stat st_file;
+    struct v9fs_attr attr;
     uint32_t fid_file;
     uint32_t count;
 
@@ -725,6 +726,10 @@ static void fs_use_after_unlink(void *obj, void *data,
     tunlinkat({ .client = v9p, .atPath = "09", .name = "doa_file" });
 
     /* file is removed, but we still have it open, so this should succeed */
+    tgetattr({
+        .client = v9p, .fid = fid_file, .request_mask = P9_GETATTR_BASIC,
+        .rgetattr.attr = &attr
+    });
     count = twrite({
         .client = v9p, .fid = fid_file, .offset = 0, .count = write_count,
         .data = buf
-- 
2.39.5


