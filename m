Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E59C0C61DC4
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 16:58:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzGwo-0006Ur-JG; Wed, 26 Aug 2026 12:57:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wzGwn-0006Ts-Ch
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 12:57:57 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wzGwl-000351-IV
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 12:57:57 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-c25099bb1fbso159293466b.3
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 09:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1787763474; x=1788368274; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=63p1kaAssd8j2xjruwrsiB3eUjoODKFeBod8GoDopGA=;
 b=Ce8Ssu0xpfM9x++LtHJF0Cn/wkB1moW6j4UeXg18OZplyoA/WoCRW+8BS32IX2ZB06
 RmUHkYDHyVUIjOfzKpq8D+slRNwQ9fhTDvvWRGdPRnF9pP3jHBZdBkUxe3P4GInwQDxY
 nBg2scKmJVrIUlCg4NI7Gq+u+vNgjSwnzFko5l4XhN+UG67wVB6hEtX/tqDT0Op0B08k
 MSzMr88zB0JyJ2PfRptVH0my89VK4a0n6VltFh5L6tqg9zMOem6BRqPLgSJvJ4nk2j4N
 HBD4UhP7+ITMJOGiKp4wEIwmkSPV648brGWP8dpXSj3XOrIw3p3eY7vYe/nI+ntlsN43
 NeDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787763474; x=1788368274;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=63p1kaAssd8j2xjruwrsiB3eUjoODKFeBod8GoDopGA=;
 b=pwQdfGCyquA6BKiepJ1dfVy99Jx4/z5lJsDPVQYjrwKtRIv3kMrYIgyAsAe+wU6eMl
 ePSoY5HjGNKMybX+AgvH50hz65Wl0UQD+xlldcwr2Epd64KjA/IQdx0nzH3a52cUVmvm
 A58mIYm8ZZ/sBjnz3jMJEyHFvhEEE/QEZ+I+WwtTQhoVOW6AewoTrsFsPqFl8czghOzD
 KUx9lXBk2Wq6pqKG+7b1HLnNrVGZzDZ7UG5xWkbDJzRhuLT5KzIWGU+USNAN6ck2kcXR
 mNkwdSjJP6j+pZYMp03XEuWKEqfY6+NIOI3ixGoGnAT3v1cREwyGN4tzkQay8B/0JdId
 Ysog==
X-Gm-Message-State: AFuF++njtC0Xutc0wTz4jeFxZNCk8nO5ylHYejXdzmUZ+O/F6WWkqE0E
 x7AmbvJ4ZfYxNHw0vGfrt0mS3F4LJD41whtYa4ne9ez8Vawrn7r1NXH/SrKoWUY1R9Xx9OBD1Gi
 yPHvF
X-Gm-Gg: AR+sD13D795TKBX/MoAXfErVVZnA2bIzm9rKpfOnqiQj/ubvb8+xmB4h2XawnHUmYId
 GRvNpdDuys8pr4cgUumMAuDrTXyrPR3RmynG/Bt5KooO7qDwBguzehZfb4v5H6O1MeBlFB+9e0u
 lBdJTLOrNW/tGUnfDegN+8kFK2Cf8yp9OqZzZHs8oZqNvAL0vSD4Ruvjc2OkTxtmzvgeUmLuEuf
 RWACaYlHWGQ3tuexGTKhwaSJLUqYkB9LSJcB/hviLWTHysIjwv/bvMAR0JtIiwLdl9UzffCpAYP
 +L1j963Rf1ktczGX8WN6u4q7Q5vncQgg5R4TYYFzHpHiHXwi3j+r5bTf5cju0p6Kp/T75QSSBPy
 b7IYjN8kwogAD+UeYUPa1/V+sx3W9W0+FnZZxKZBmjTmfhwHnIdg10HHrKkc9TbiOEu8r3PE1sE
 2s+jJNAsdTPXl8E22Qw64edGdhk1oRG+R6NvUmOXAqVUwzlINOgaKwOxbA
X-Received: by 2002:a17:907:ea8e:b0:c24:d914:6d64 with SMTP id
 a640c23a62f3a-c250c32cb23mr1054856066b.23.1787763474169; 
 Wed, 26 Aug 2026 09:57:54 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:8a5:68e8:91b1:8a17])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c250a88ac46sm650557766b.29.2026.08.26.09.57.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 09:57:53 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PATCH 3/5] iotests/nbd-commands: exercise the simple and structured
 reply modes
Date: Wed, 26 Aug 2026 18:57:45 +0200
Message-ID: <20260826165747.3768674-4-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260826165747.3768674-1-den@openvz.org>
References: <20260826165747.3768674-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=den@openvz.org; helo=mail-ej1-x62a.google.com
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

From: Denis V. Lunev <den@openvz.org>

Every NBD request the iotests send arrives in NBD_MODE_EXTENDED, so
the server paths kept for older clients are never taken. Instrumenting
nbd_co_receive_request() over the whole auto group and every test that
touches NBD gives mode 4 for all of them, which leaves
nbd_co_send_simple_reply() and the compact header handling dead under
test. A regression there would only show against a third party client.

libnbd can negotiate down, so run the same command set three times,
once per mode, and assert the mode that was actually reached. Block
status is limited to the two modes that can negotiate a meta context.

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Eric Blake <eblake@redhat.com>
CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 tests/qemu-iotests/tests/nbd-commands     | 28 +++++++++++++++++++++++
 tests/qemu-iotests/tests/nbd-commands.out |  4 ++--
 2 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/tests/qemu-iotests/tests/nbd-commands b/tests/qemu-iotests/tests/nbd-commands
index d2715b59a1..f0b40feb6b 100755
--- a/tests/qemu-iotests/tests/nbd-commands
+++ b/tests/qemu-iotests/tests/nbd-commands
@@ -113,6 +113,34 @@ class TestNbdCommands(iotests.QMPTestCase):
         self.assertEqual(self.top_extents(), [(0, size, 0)])
         qemu_io('-c', f'read -P {pattern} 0 {size}', top)
 
+    def check_commands(self, structured, extended):
+        with self.open_nbd(structured, extended) as h:
+            self.assertEqual(h.pread(4096, 4096), bytes([pattern]) * 4096)
+
+            h.cache(size, 0)
+
+            h.pwrite(b'x' * 4096, 4096)
+            h.flush()
+            self.assertEqual(h.pread(4096, 4096), b'x' * 4096)
+
+            h.zero(4096, 8192)
+            self.assertEqual(h.pread(4096, 8192), bytes(4096))
+
+            h.trim(4096, 16384)
+
+            if structured:
+                self.assertEqual(self.allocation_depth(h),
+                                 [(size, DEPTH_LOCAL)])
+
+    def test_commands_simple_replies(self):
+        self.check_commands(structured=False, extended=False)
+
+    def test_commands_structured_replies(self):
+        self.check_commands(structured=True, extended=False)
+
+    def test_commands_extended_headers(self):
+        self.check_commands(structured=True, extended=True)
+
     def test_cache_past_end_of_export(self):
         with self.open_nbd() as h:
             self.assertRaises(nbd.Error, h.cache, size + 1, 0)
diff --git a/tests/qemu-iotests/tests/nbd-commands.out b/tests/qemu-iotests/tests/nbd-commands.out
index 8d7e996700..3f8a935a08 100644
--- a/tests/qemu-iotests/tests/nbd-commands.out
+++ b/tests/qemu-iotests/tests/nbd-commands.out
@@ -1,5 +1,5 @@
-...
+......
 ----------------------------------------------------------------------
-Ran 3 tests
+Ran 6 tests
 
 OK
-- 
2.53.0


