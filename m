Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E46E1C44506
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 18:43:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whtiY-0003EK-8P; Thu, 09 Jul 2026 14:43:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrtc27@jrtc27.com>) id 1whtiT-0003Db-Od
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 14:43:22 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jrtc27@jrtc27.com>) id 1whtiS-0008Cq-2b
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 14:43:21 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-493b779003fso587635e9.3
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 11:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=jrtc27.com; s=gmail.jrtc27.user; t=1783622598; x=1784227398; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=TuvHUcfBP8Wj91c+KUP3SZ34Ru6yihkIh4zI164mLWE=;
 b=JJdk9jsMLCmC1gPpPQu6e6CCADKiFniyB5yHo7cByjAhTCiSU6v5+OO2OjLk0RUDqs
 Lm/Q6nBhLxmAxa40eCu07rgwfysmRsX5/+nxyBwGFpYUtSo02YwxYNkEsEdUCDHcSQRJ
 YzUZ8GuALIwXujZQqI0OBR2xhP354i0rCkOUyuXbuTpvP1pujDrs53AYEPPe9JxoaszQ
 0yrAioG4kbxASC34/2eY/jUx7zvelIAYPxTdHrv8Ym/RFvQbkFJjsDg5w9h9K+91ooTI
 qZe6qjYQ4DoS+WBW2O51+MR8oQb9K41ri1/CNez/a1ToXNNDKVc1vrtzJDPOZwWFYrrd
 gynw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783622598; x=1784227398;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TuvHUcfBP8Wj91c+KUP3SZ34Ru6yihkIh4zI164mLWE=;
 b=o6YEDpNEiKz1KiS58mEAKkB6K2H87OYJynGEVR0/8Eufpw1XfeWmeUTVHV8j1Q2ucF
 a432Cjao2rOcm2ISlHHG7H+MATZ18rXBrIbbPyEXJb7iEyRYAfjicPZKMujmVlMG7ydw
 PmM6HQgVaT84kxUbocaRVbML0XOlAUEdG47mm7blVhMLaoODJliUtJlfdv0WY/Ar0Go/
 IXvL1A6RhAGr/biUe7T+vT4AYvoo6sSmUsES/KqSNbuDuRGcBfD4y6/Kwo43VzSU7xNS
 nhQFugl3hJFmzUqzG/87KoPXOytcGdTQevC9IWvIZUTrQykofhBSpD2uvE/CVb9nqlnl
 XokQ==
X-Gm-Message-State: AOJu0YwaB4pbeTd22APTQe5DNjpruYrBCy+9gvic/5wCf7j9gWB/Mwg0
 WHPkPxILm05S9VLknlgYF6or+q3Td+1nRi+gWOOskMcvjndX/H3CDFMoo7AtGotGKU0=
X-Gm-Gg: AfdE7clbRE+mUXN7MPtAGcx4iDp2BZSYry4SreUroxa8BvKjATmXRAvrQRMz2E3mWyh
 hJptcIgnMYGeCJzCyUqObENxHow/c5ZYPdBsIv1Ms3EOmKJFH02NH6YE1EzeWUi8svELM6mhZF7
 Uv9q2MNUexNmS4NdRFymYY211xATlqHY1HLcIHf5JdNyD8czkzuxOaxZu2tOBe0ff425XhDKliS
 defwg1Xe/iKEgoH0YAbYjtHVfMD0VeVfQQ1eZMQlEc7+8XlJNgDsdljVwNs25+p4pyL0Y+6myga
 EB2cSvWqmSE1bCUDhV4CZ5wn/d94xx3J06f5geIrX1I/FPGex7E3WboNu1q/tffOq0ix1dynUPs
 XKcRge6G75INBoUeXXaS3T0EJ3aq1+m/OCekADkRG23Dtow0DCS0yBMPMO/xoTj0tfymEneqm+0
 WdLxGrgsXVjcd60oMSu38HWy+OOd3w06kEoFs+6AmcpP9DxiHVvf5CV2c4++uLZdlTdR431V+2z
 tC2WFFD1nOUs/uC1Y/tLi+vf/ZbgJxX7A==
X-Received: by 2002:a05:600c:310f:b0:493:d1e0:a4f1 with SMTP id
 5b1f17b1804b1-493e6c05de0mr75949025e9.0.1783622597560; 
 Thu, 09 Jul 2026 11:43:17 -0700 (PDT)
Received: from Jessicas-MacBook-Pro.localdomain (nat-184-161.net.cam.ac.uk.
 [131.111.184.161]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493eb74b3edsm90498585e9.15.2026.07.09.11.43.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 09 Jul 2026 11:43:16 -0700 (PDT)
Received: by Jessicas-MacBook-Pro.localdomain (Postfix, from userid 501)
 id 01C9614898DFD; Thu,  9 Jul 2026 19:43:15 +0100 (BST)
From: Jessica Clarke <jrtc27@jrtc27.com>
To: qemu-devel@nongnu.org
Cc: Jessica Clarke <jrtc27@jrtc27.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH] test-util-filemonitor: Adapt to FreeBSD 15's native inotify
 semantics
Date: Thu,  9 Jul 2026 19:42:27 +0100
Message-ID: <20260709184229.21628-1-jrtc27@jrtc27.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=jrtc27@jrtc27.com; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

FreeBSD 15 introduces a native inotify implementation rather than
requiring use of the kqueue-based libinotify package. This native
implementation does not generate the extra deleted events, so don't
expect them. However, the original implementation did have a bug that
caused IN_IGNORED to never be generated if you did not also watch for
IN_DELETE_SELF, which affects 15.0 and 15.1, but has been fixed and will
no longer apply in 15.2 / 16.0.

Note that the deleted event check is for the userspace version, since
that governs whether libinotify is being used or not, whereas the
ignored event check is both for the userspace version (to check if we're
using the native syscall) and the kernel version (to check if the kernel
has the bug or not).

All __FreeBSD_version values used here correspond to the value in-tree
at the time of the relevant commits. Since neither commit bumped the
value there will be a window of development snapshots between each
commit and the previous bump that will be incorrectly identified here,
but this is the best we can do, and something users of snapshots should
be prepared to deal with.

Signed-off-by: Jessica Clarke <jrtc27@jrtc27.com>
---
 tests/unit/test-util-filemonitor.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/tests/unit/test-util-filemonitor.c b/tests/unit/test-util-filemonitor.c
index 02e67fc96ac..972651dc1e1 100644
--- a/tests/unit/test-util-filemonitor.c
+++ b/tests/unit/test-util-filemonitor.c
@@ -27,6 +27,10 @@
 
 #include <utime.h>
 
+#ifdef __FreeBSD__
+#include <osreldate.h>
+#endif
+
 enum {
     QFILE_MONITOR_TEST_OP_ADD_WATCH,
     QFILE_MONITOR_TEST_OP_DEL_WATCH,
@@ -221,6 +225,24 @@ qemu_file_monitor_test_expect(QFileMonitorTestData *data,
 }
 
 
+static bool
+expect_broken_ignored(void)
+{
+#if defined(__FreeBSD__) && __FreeBSD_version >= 1500051
+    int osreldate;
+
+    osreldate = getosreldate();
+    if (osreldate == -1) {
+        g_printerr("Unable to call getosreldate: %s\n", strerror(errno));
+        abort();
+    }
+    return osreldate < 1501501 || (osreldate >= 1600000 && osreldate < 1600019);
+#else
+    return false;
+#endif
+}
+
+
 static void
 test_file_monitor_events(void)
 {
@@ -360,7 +382,7 @@ test_file_monitor_events(void)
         { .type = QFILE_MONITOR_TEST_OP_EVENT,
           .filesrc = "one.txt", .watchid = &watch4,
           .eventid = QFILE_MONITOR_EVENT_DELETED },
-#ifdef __FreeBSD__
+#if defined(__FreeBSD__) && __FreeBSD_version < 1500051
         { .type = QFILE_MONITOR_TEST_OP_EVENT,
           .filesrc = "two.txt", .watchid = &watch0,
           .eventid = QFILE_MONITOR_EVENT_DELETED },
@@ -539,6 +561,11 @@ test_file_monitor_events(void)
                 g_printerr("Event id=%" PRIx64 " event=%d file=%s\n",
                            *op->watchid, op->eventid, op->filesrc);
             }
+            if (op->eventid == QFILE_MONITOR_EVENT_IGNORED &&
+                expect_broken_ignored()) {
+                g_printerr("Expect ignored event to be broken, skipping\n");
+                break;
+            }
             if (!qemu_file_monitor_test_expect(&data, *op->watchid,
                                                op->eventid, op->filesrc,
                                                op->swapnext))
-- 
2.53.0


