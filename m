Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C425CD343A
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2024 14:36:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slUdU-0003a7-2B; Tue, 03 Sep 2024 10:36:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1slUdS-0003ZL-FO
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 10:35:58 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1slUdQ-00042a-R0
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 10:35:58 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-42bb81e795bso44486235e9.1
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2024 07:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725374155; x=1725978955; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=vvTFKjkeH7vpHb4iuRT03tIFxEtrLKBKwsGS/P4sub4=;
 b=Pn6NqatGeOZZTm4+YAu3eq1yVCpI+5Nw70LN4oI6OZfFAcObEf6P0M1MBwRWSHtdx0
 NV5fkHpe2NiHldTfYLfvCpXennsgGhhRmEeN7ifOpqI+7Fc74G6V9k05+qS2H6gM7keu
 wmauu3Nunp3ETnKDPTrJ5gtnvJdUFuWcQ93dTBoiWlP31MxJG6q5d0cOSnT7CJqLGfAT
 tpiaSkPlqK4ZtiMj+B5ozrv9ZKBlurKq+tt+uDIt7Hy7n9oJGt9X4N3l3vExmTJhHt4r
 H3py97BqPIQi18RGeDc1WIA6inBn1flc2B0YtOcISf97FEQ7/HTf8oktzj5kiXqgVcQh
 PvbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725374155; x=1725978955;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vvTFKjkeH7vpHb4iuRT03tIFxEtrLKBKwsGS/P4sub4=;
 b=o5Fv6RTGALmsGrenBdFdSJ606VgGj8q2y6i48EgLZiiykwq4iSOgZcXGU5r8cOYPtF
 jRQlgpwbjqUzbY8nZtVQ/mxTC25GdWwHgPPKd8/UCpelrzXDWhwdt3t6W1RkbkvNsymR
 9iWvBwr6C6PFNdE+8EyBrPh9qyFag/tGGQ3TNQNSh5jbbA4fjUd6/lt2GaC+rUrCpcr5
 x33UIvQ2aFrCobJQwiL0rF5zWhDdjH2Em43hIObNlX8qWQbqneXb5AVdYa3p8ZC3tOVH
 NvPhJzpXcZC3u+4edrPBOWNWn3KZLfKAdYRVyxxMO5lSt0c9aoxB/Ow4VS4PORzmLHcf
 hIWw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWUVBdQv1fJ/1vGv2pZDrOF2cuapDRZMKkZ8kV6kiL3KJw4+ArZ7beaCdkxB8ikGHLFY2bAcO+dL7pb@nongnu.org
X-Gm-Message-State: AOJu0YwsZxZ6dR+OG1OSECb1ahUJssVoecvnWLxfZQN3KG+zctBnqb5f
 7uDnntgan2U9BJWN0f9QTvUDq1HNaLeL0vJdhVQIp1A394LMOC/zF8An85vjQWs=
X-Google-Smtp-Source: AGHT+IGhD6WqYlyGyB46ep1WtKF7Mkw/dxNBTrJfZZWnSzVFemQH99N1OfG21UnvbM3jprQ50AH0Yg==
X-Received: by 2002:adf:eace:0:b0:374:c324:eab5 with SMTP id
 ffacd0b85a97d-374c324eb64mr5766805f8f.41.1725374154662; 
 Tue, 03 Sep 2024 07:35:54 -0700 (PDT)
Received: from localhost.localdomain ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42bb37f7849sm179802065e9.7.2024.09.03.07.35.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 03 Sep 2024 07:35:54 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Thomas Huth <thuth@redhat.com>,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] tests/functional/test_vnc: Reduce raciness in
 find_free_ports()
Date: Tue,  3 Sep 2024 16:35:53 +0200
Message-ID: <20240903143553.16877-1-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Pass the port range as argument. In order to reduce races
when looking for free ports, use a per-target per-process
base port (based on the target built-in hash).

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
Based-on: <20240830133841.142644-33-thuth@redhat.com>
---
 tests/functional/test_vnc.py | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/tests/functional/test_vnc.py b/tests/functional/test_vnc.py
index b769d3b268..508db0709d 100755
--- a/tests/functional/test_vnc.py
+++ b/tests/functional/test_vnc.py
@@ -10,6 +10,7 @@
 # This work is licensed under the terms of the GNU GPL, version 2 or
 # later.  See the COPYING file in the top-level directory.
 
+import os
 import socket
 from typing import List
 
@@ -18,7 +19,6 @@
 
 VNC_ADDR = '127.0.0.1'
 VNC_PORT_START = 32768
-VNC_PORT_END = VNC_PORT_START + 1024
 
 
 def check_bind(port: int) -> bool:
@@ -41,9 +41,10 @@ def check_connect(port: int) -> bool:
     return True
 
 
-def find_free_ports(count: int) -> List[int]:
+# warning, racy function
+def find_free_ports(portrange, count: int) -> List[int]:
     result = []
-    for port in range(VNC_PORT_START, VNC_PORT_END):
+    for port in portrange:
         if check_bind(port):
             result.append(port)
             if len(result) >= count:
@@ -91,7 +92,10 @@ def test_change_password(self):
                     password='new_password')
 
     def test_change_listen(self):
-        a, b, c = find_free_ports(3)
+        per_arch_port_base = abs((os.getpid() + hash(self.arch)) % (10 ** 4))
+        port_start = VNC_PORT_START + per_arch_port_base
+        port_stop = port_start + 100
+        a, b, c = find_free_ports(range(port_start, port_stop), 3)
         self.assertFalse(check_connect(a))
         self.assertFalse(check_connect(b))
         self.assertFalse(check_connect(c))
-- 
2.45.2


