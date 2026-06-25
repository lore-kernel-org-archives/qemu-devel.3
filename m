Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8233CDE000
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 16:53:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcnKJ-0002mG-Rq; Thu, 25 Jun 2026 12:53:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ganeshredcobra@gmail.com>)
 id 1wcnKJ-0002m7-By
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 12:53:19 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ganeshredcobra@gmail.com>)
 id 1wcnKH-0000Ga-OZ
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 12:53:19 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-46def4bd5e8so848203f8f.1
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 09:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782406395; x=1783011195; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=fO3Cn35FAGq4OxW3xFhcxlHnXYwdUUsEApL3fctwFKU=;
 b=D5FBU5zsBJiaeDLjNb5/rw1gR4AG2vAqpJqbM6YxOZx9LkUHkhYMD8RO07V+4P+txy
 7OJMKf60HbcOLoLW4+Ox3sSU9LXdLbVJqU4D8HwosVLqqKJcyHstJa0+tnAy3StOi53B
 SaGrlsHC3cVyvwlIsEnipc5UuDlQd3fgAc48pRTay3T7KgRiDc2LO75Fj/4e+pD8sTCJ
 ufWyZE9DWjma6Yt97oNbNG/qaTP/q+FzlZMqfTHtRfNNMIDn7fafTAoDYzP6FYFfrT0M
 XnzD0icXDouVGASHrs0bMaFbsXZhRwfJiVFiLirxAMc/MjZR5JBkz0R9tP8TRu02tmXy
 w1cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782406395; x=1783011195;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fO3Cn35FAGq4OxW3xFhcxlHnXYwdUUsEApL3fctwFKU=;
 b=ZS5ddqqr8dYx3fHXjDr3VjjCwUjWv5ErcoeJ4YZb3vk7Z0AGE35Vrpqf7D7Q1ImVWJ
 UYV52BaLWnN0aPreGSQ88bRlqkt934V18R7hCG6M5GrxVI2q2lgZ/n+HoQbtZ2avUDuT
 YbZmMaeyifQzUfg82uJ94Mq/SOSyZvquHTyNVfiWTnTw8QlCxVEJFIdHcbEkNRu3aMBy
 J9Q594kJ8n9hoCabzxbmCQkSpmpuWnAQ6b3QZ8XmRHeW92lhEVGNYeI3f6K2865pnXOC
 xZpjNCLZOsG8nXG7/ebxJjkuFtV/KK695rj9z2i2dZA7G4VXgWTMaJM01llLRqEEbfMM
 FJig==
X-Forwarded-Encrypted: i=1;
 AHgh+RoJjde4SJHyznTHZBzROV3gjQEjttoBWuPFyW27UsipOixi6dmwmPNrlU7PggdY0XwJ+/X3o0CH3V5w@nongnu.org
X-Gm-Message-State: AOJu0Yz7dgOszag6qmz9jxvJl2VmBwwiWFfCsjDNP5aPzUWURF3+ug0x
 8IXe0N+W9g4nIqOt7ZIyNW4V4mEL00+ZKTT3Z5DM9sNOBHBpxVQ0nXVXZCsmtQ6rJy4=
X-Gm-Gg: AfdE7cmk5ZKYIXT0F+Przp8z97m+v/Ci/zkg0GL9rZf2atDVYC/UOL/TWhEqVUwUQx0
 FzwaJp02Pk1Ghl6Bf0iQnLCKD8YBkVvbv4WDl5dTubQKhNrauvEyvrYu0MXSxIEQ+pN8WTJR3js
 svIyg8ET2ktHoKvrzo0kbTNNtcyXd+NMGRPFp374l7lLjSwUP4n+P1IYX3nvyhR9CjnGNCDgH4R
 i19N4SrAh+Cr+x1mq79qrZekDO5n8ZrDTap5zn8nXnMyYLLe0nwygPxJ2Fmn5XicQE8I+8dbgjT
 VjeVe+qCTm6gmDPunvTbxemizrNncP7DBX/CyrDSOrvpeP6UdD5vrTG+oCJYiy0hQnYUJ5eePB8
 8zLaHaCZK+tBJ0JHZ77v81AbhF6Y+iVdxynmBZQcXgP7FLgBNvaJzbRfzAVNeL/b1X9XsnuBUAk
 XmpyQBx0nZHqU5yO4mw6o+ChTrh4bMbst2et+J4g==
X-Received: by 2002:a05:6000:24c2:b0:468:9e3c:23aa with SMTP id
 ffacd0b85a97d-46dbf0217c0mr5775164f8f.3.1782406395262; 
 Thu, 25 Jun 2026 09:53:15 -0700 (PDT)
Received: from localhost.localdomain ([86.2.40.231])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46c2279bc77sm16453471f8f.32.2026.06.25.09.53.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 09:53:14 -0700 (PDT)
From: Ganesh Harshan <ganeshredcobra@gmail.com>
To: th.huth+qemu@posteo.eu
Cc: philmd@mailo.com, berrange@redhat.com, qemu-devel@nongnu.org,
 Ganesh Harshan <ganeshredcobra@gmail.com>
Subject: [PATCH] tests/functional: use QMP to query available machines
Date: Thu, 25 Jun 2026 12:53:10 -0400
Message-ID: <20260625165310.54113-1-ganeshredcobra@gmail.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=ganeshredcobra@gmail.com; helo=mail-wr1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Replace parsing of "qemu -M help" in set_machine() with
QMP "query-machines".

The previous approach relied on parsing human-readable CLI
output and substring matching, which is fragile and prone to
incorrect matches. It is also sensitive to output format changes.

Use QMP instead to retrieve structured machine information,
ensuring accurate matching and better maintainability.

Cache the result at the class level to avoid repeated QEMU
startup overhead.

Signed-off-by: Ganesh Harshan <ganeshredcobra@gmail.com>
---
 tests/functional/qemu_test/testcase.py | 32 +++++++++++++++++++++-----
 1 file changed, 26 insertions(+), 6 deletions(-)

diff --git a/tests/functional/qemu_test/testcase.py b/tests/functional/qemu_test/testcase.py
index eaec1bea13..5920d6a784 100644
--- a/tests/functional/qemu_test/testcase.py
+++ b/tests/functional/qemu_test/testcase.py
@@ -314,14 +314,34 @@ def setUp(self):
         console_log.addHandler(self._console_log_fh)
 
     def set_machine(self, machinename):
-        # TODO: We should use QMP to get the list of available machines
-        if not self._machinehelp:
-            self._machinehelp = run(
-                [self.qemu_bin, '-M', 'help'],
-                capture_output=True, check=True, encoding='utf8').stdout
-        if self._machinehelp.find(machinename) < 0:
+        cls = type(self)
+
+        if not hasattr(cls, "_machines"):
+            tmp_vm = QEMUMachine(self.qemu_bin)
+            tmp_vm.set_machine('none')
+
+            try:
+                tmp_vm.launch()
+                resp = tmp_vm.qmp('query-machines')
+
+                machines = resp.get('return', [])
+                cls._machines = [
+                    m.get('name') for m in machines if 'name' in m
+                ]
+
+            finally:
+                try:
+                    tmp_vm.shutdown()
+                except Exception:
+                    pass
+
+        self._machines = cls._machines
+
+        if machinename not in self._machines:
             self.skipTest('no support for machine ' + machinename)
+
         self.machine = machinename
+        self.vm.set_machine(machinename)
 
     def require_accelerator(self, accelerator):
         """
-- 
2.47.3


