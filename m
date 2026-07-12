Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01C71C44501
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jul 2026 04:20:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wilgF-0008S6-2E; Sun, 12 Jul 2026 00:20:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wilfn-0008Gi-VE; Sun, 12 Jul 2026 00:20:15 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wilfl-0006zi-Tv; Sun, 12 Jul 2026 00:20:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1783829781; bh=X2ep3Dgk2ND6fHIDdJKHfl3xtB71BL6tY0g4Gj3tTTQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=QtiPxGHRSPF/tJE5a0KMTjmPwsrjYgM4sUVK6MP4LLmMwicgbAYMP3ugQdpzwdF3l
 h4eoY88eX0OmrHe/1rwDAxIEXIjfNEn/EB8VvKI4PHYHUTS/NV3Sl5tmWlNn5NuRIt
 81yiEI2An45vmpvHH7g2CYfxtijHxEIbY/jZk8REZY/AemCD6IHmAN9bG+aHxm+I02
 SiFYRfpzxwwsk5ykaK9G2UyrPpZzZzGRTjBVPRcR2gAbB4zFGpzWfFLofDhRDvgdu7
 HOATUW27QxMo2d7NUM8J1IjJbgI99CFheNvexC3kTcGwgIA1mwLv+0/bBJLjOA4xC9
 nf5yfW9pTQS5A==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id B15171C0C06;
 Sun, 12 Jul 2026 07:16:21 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id E42343EB966;
 Sun, 12 Jul 2026 07:16:31 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 7A1001340F; Sun, 12 Jul 2026 07:16:31 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Eric Farman <farman@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.12 43/75] s390x/css: limit number of CHPIDs in
 description
Date: Sun, 12 Jul 2026 07:15:01 +0300
Message-ID: <20260712041539.108341-43-mjt@tls.msk.ru>
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

From: Eric Farman <farman@linux.ibm.com>

virtio-ccw uses a single virtual CHPID for all devices and
device-types, but vfio-ccw (passthrough) shares real CHPID
information with the guest. A sufficiently large passthrough
configuration would exceed the defined response payload.

Fix this by limiting the number of CHPID descriptions that
are returned based on the given response format.

Cc: qemu-stable@nongnu.org
Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Signed-off-by: Eric Farman <farman@linux.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Message-ID: <20260707070728.147203-6-borntraeger@linux.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
(cherry picked from commit 22f2da06a8b291c975a7caf05dbd3b180c856741)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/s390x/css.c b/hw/s390x/css.c
index 738800c98df..38d2d90028c 100644
--- a/hw/s390x/css.c
+++ b/hw/s390x/css.c
@@ -1900,6 +1900,7 @@ int css_collect_chp_desc(int m, uint8_t cssid, uint8_t f_chpid, uint8_t l_chpid,
     int i, desc_size;
     uint32_t words[8];
     uint32_t chpid_type_word;
+    uint32_t max_chpids, chpid_count = 0;
     CssImage *css;
 
     if (!m && !cssid) {
@@ -1910,9 +1911,25 @@ int css_collect_chp_desc(int m, uint8_t cssid, uint8_t f_chpid, uint8_t l_chpid,
     if (!css) {
         return 0;
     }
+
+    if (rfmt == 0) {
+        max_chpids = 256;
+    } else if (rfmt == 1) {
+        max_chpids = 127;
+    } else {
+        /* Should be rejected by caller */
+        return 0;
+    }
+
     desc_size = 0;
     for (i = f_chpid; i <= l_chpid; i++) {
         if (css->chpids[i].in_use) {
+            /* Limit number of CHPIDs sent back */
+            if (chpid_count == max_chpids) {
+                break;
+            }
+
+            chpid_count++;
             chpid_type_word = 0x80000000 | (css->chpids[i].type << 8) | i;
             if (rfmt == 0) {
                 words[0] = cpu_to_be32(chpid_type_word);
-- 
2.47.3


