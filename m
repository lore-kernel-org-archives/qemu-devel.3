Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93C0AC43458
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2026 22:04:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wifna-0000sV-Sw; Sat, 11 Jul 2026 18:03:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wifnY-0000iA-T7; Sat, 11 Jul 2026 18:03:48 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wifnX-0000Bx-5p; Sat, 11 Jul 2026 18:03:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1783807181; bh=YH47+b8fV/DnyDFj9VG/LcIADvM/vUMQPHWHdEi+OYc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=RMdeQM+H7Ip9lUbrsWqrYW0fUECG3xQN5rh1fhI1cZPpBP4DpQcB1CLZqJa9JoZg5
 h09zvirrxhU9+O53HfKIHqHKC3fQrzDyTqFTjAdlNnmyEvFOGwx+H8NMromYyQOO0a
 wccz/+ofjT91nQAwYsAdFgg09sqW7jxRm5MhtiLVm6oMW2rcUdoQT8ZWmusPznfliG
 gno1E75qR+gcEjPe7NsLj2G7l+vtogvXlGYhJH3yzZFWNfVeR6jaUVMBN4PVxUARV5
 qKt1pw2vMbbav4LZwRQxn/vBZZfkuThQZ2tS69EoXvf/zmYLU6k2q4qYwof/1Toqcz
 WcsM9iLTY3/HA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 1BD341C0AB6;
 Sun, 12 Jul 2026 00:59:41 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id C6F9F3EAF41;
 Sun, 12 Jul 2026 00:59:50 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 9E71E13339; Sun, 12 Jul 2026 00:59:50 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Eric Farman <farman@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.3 43/81] s390x/css: limit number of CHPIDs in description
Date: Sun, 12 Jul 2026 00:58:21 +0300
Message-ID: <20260711215904.3757-43-mjt@tls.msk.ru>
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
index 04ce3178a0b..13a0e113703 100644
--- a/hw/s390x/css.c
+++ b/hw/s390x/css.c
@@ -1870,6 +1870,7 @@ int css_collect_chp_desc(int m, uint8_t cssid, uint8_t f_chpid, uint8_t l_chpid,
     int i, desc_size;
     uint32_t words[8];
     uint32_t chpid_type_word;
+    uint32_t max_chpids, chpid_count = 0;
     CssImage *css;
 
     if (!m && !cssid) {
@@ -1880,9 +1881,25 @@ int css_collect_chp_desc(int m, uint8_t cssid, uint8_t f_chpid, uint8_t l_chpid,
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


