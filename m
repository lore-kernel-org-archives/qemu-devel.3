Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A42B3C44506
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2026 22:04:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wifl3-0004Je-Hm; Sat, 11 Jul 2026 18:01:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wifl1-00048L-EX; Sat, 11 Jul 2026 18:01:11 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wifkz-0008Gr-EP; Sat, 11 Jul 2026 18:01:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1783807180; bh=zubOijMCLi0QNYNubzThb5FX/Xsi0gKQolCwoOQOe9M=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Wd7ygo2n7wy/++kdlB4Zq82Uz6lK406Fgc6uiTQVt8y539kA1uGVC1L3u/BdiXtbE
 FtyC4Ys/WSAxH9oLUuQti5Nx53O00Fha8Lsh87EBreFH/+tZ111ML1s1SswXO5QoQG
 5F8VRxAgn7elEm4kkVmSYOIx4qrJNIHCTS4PjAev1Dk167nhvdpA5C2ybaxhLdNVt6
 OrQzye55KddXRgyFo26Dx8t95u1Yo2E4cX6JUTZsTFOIttxDIieTfYH0mdSMceiHwS
 C9fLeqEqG0OX1hboGSFnzoEBSjuBdGbaZTnzeXwQfW1o5CoWMTtKRXpf73hUUUh5ol
 zSbUGmR6SEiYA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 8BDD11C0AA0;
 Sun, 12 Jul 2026 00:59:40 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 424CC3EAF2B;
 Sun, 12 Jul 2026 00:59:50 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 670D91330D; Sun, 12 Jul 2026 00:59:50 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.3 21/81] tests/9p: add virtio_9p_add_synth_driver_args()
 test client function
Date: Sun, 12 Jul 2026 00:57:59 +0300
Message-ID: <20260711215904.3757-21-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.3-20260712005649@cover.tls.msk.ru>
References: <qemu-stable-11.0.3-20260712005649@cover.tls.msk.ru>
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

Add virtio_9p_add_synth_driver_args() to allow appending custom
QEMU options for individual 9p synth tests.

Link: https://lore.kernel.org/qemu-devel/7fe3eca5d17292464676b68d0513052564cd432a.1781361555.git.qemu_oss@crudebyte.com
Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
(cherry picked from commit 84525ece6817f4e9760a1d484cab01123a546e92)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/tests/qtest/libqos/virtio-9p.c b/tests/qtest/libqos/virtio-9p.c
index 186fcc1141a..823756de8c4 100644
--- a/tests/qtest/libqos/virtio-9p.c
+++ b/tests/qtest/libqos/virtio-9p.c
@@ -228,6 +228,12 @@ static void regex_replace(GString *haystack, const char *pattern,
     g_string_assign(haystack, s);
 }
 
+void virtio_9p_add_synth_driver_args(GString *cmd_line, const char *args)
+{
+    /* append passed args to '-fsdev ...' group */
+    regex_replace(cmd_line, "(-fsdev \\w[^ ]*)", "\\1,%s", args);
+}
+
 void virtio_9p_assign_local_driver(GString *cmd_line, const char *args)
 {
     g_assert_nonnull(local_test_path);
diff --git a/tests/qtest/libqos/virtio-9p.h b/tests/qtest/libqos/virtio-9p.h
index 480727120ea..e7efeef7a1d 100644
--- a/tests/qtest/libqos/virtio-9p.h
+++ b/tests/qtest/libqos/virtio-9p.h
@@ -44,6 +44,12 @@ struct QVirtio9PDevice {
     QVirtio9P v9p;
 };
 
+/**
+ * Add required test specific args to the QEMU command line for the 9pfs
+ * 'synth' fs driver.
+ */
+void virtio_9p_add_synth_driver_args(GString *cmd_line, const char *args);
+
 /**
  * Creates the directory for the 9pfs 'local' filesystem driver to access.
  */
-- 
2.47.3


