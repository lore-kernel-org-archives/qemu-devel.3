Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50158606A323
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 04:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=spacecubics-com.20260707.gappssmtp.com header.i=@spacecubics-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=IpgL6uiU
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWnFC-0002TY-Ms; Thu, 26 Nov 2026 23:07:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maxz@spacecubics.com>)
 id 1xWlTb-0001qK-0c
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 21:14:16 -0500
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <maxz@spacecubics.com>)
 id 1xWlTZ-0001I9-32
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 21:14:14 -0500
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-cd61cef87f1so3481189a12.0
 for <qemu-devel@nongnu.org>; Thu, 26 Nov 2026 18:14:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=spacecubics-com.20260707.gappssmtp.com; s=20260707; t=1795745652;
 x=1796350452; darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5aDdp7tVxVsin29xlNHo3SxIMh3/Gnj6XKXn/kVM3sI=;
 b=IpgL6uiUR0/JeRGTZpMi/Qik7sOaOR55T47eWHN2fNOwWZ4PSCT33wL9dL/YYnge/v
 Cinv3THnEcuU+8PIUE+h7PI9WkB7301J9LKU6XiVCIl1/gvYA48K2dJjCHYuYQOkSfZN
 XfdPTsd5YLnEH7llvdZigByF5QVtkGRJnHbAjEz7kwzNWFwn8ZEOPeT6FlXb4Jy3f+34
 x+zJdwfPkK5bQ6GHxxP6T//ySonG1CQKL9E/Lo9j34Zwxuyd+thumjRfL1unnJBAFWMt
 dZzrzhOib5pfT68gSlzXpEJpasDf8gz9jMOet8bZYsCvvOegD2GECesm4O5uI2Ho410v
 iPYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795745652; x=1796350452;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5aDdp7tVxVsin29xlNHo3SxIMh3/Gnj6XKXn/kVM3sI=;
 b=M371DQKMZuYyI/Wz1HfBG8rxdbxKJnzoQfnpipRzU42jawo06/NwwwSZ4l8NwEgQ3m
 fXPJFilMRlgnKU5PwxAtkmLnJZBRm/CmIsoA41SXmxj00es+yRs6W9uwnmhMCVjqTuX7
 UFJZAwcaacpUFSXqX1pSl5u1tFeKHgG/2g1LTAYRSmeil2yaxOnn2Q0b6h8/+lMlIJHb
 s7oI+TDNwcZTbVnQCPQ3yWVf4+jQKmBXM8mPnejeLval7G71jkU9IyYI6YjVbaG/E/GI
 DPTOF8Xku1DkEekX4++GFk0xmdPyPdVbOMXsMmmUy5YQZ67n7Ph+CaNaBh8SCVl5UTWh
 9bGQ==
X-Gm-Message-State: APuU4Z9XBbq53+ajffbp0ZUJLPv784tgbiOZghGjVaPovTTePCfg9dI4
 b4mVvp0ZZKQgfmbj1GKGICjdQgF3hsPBDu2MJJgdayCB+XpXjQFGdP2t2rNJseu5DWQ=
X-Gm-Gg: AZFdTZcYgHHThMwZ9mKeZUBoKhma0zE/k1+Ms+5/FjxFE5uWKANMauGkVreGXdVzhrZ
 JQ5Xx7dgMbixS5jGc2/crScwbER0W2AY0fKb13NFTMvUAmpo2YbKntJyD2Wzvb0LzemU9v/F0Ni
 4EsdYMGrsPHsHXcRS5EEyG4uuQXGNAo3X4Uy8t5/v7WV+Ok6b/gDCYsSYJTtNiy4LIZJzmfXV3J
 qoQQin75iQ8FeaMhE0Yt0UJ/Oobzl3HAUZdwHFGqaN2LNyLpshKwTlDRQVEcphYvP3Puku0b4C5
 PqMUAH+adhL+S9fp5CTdMuwIGP795xfiE7MUKCyhJxkQ8fbAU7jqBPmoEJoWAKQE8cVGW8twvrk
 MwdrG9uqsvRv30qJtFkXWz8xx2X64f5Bll5P1ip1D016tsFyWLalQ6O9dlaiR8X1tzQ7dKeZQRM
 dWXwyqaiL7S61udFiw2x1leX/a56xNRGTMo8i73KzmAHAdCf0/gSFreoG0zedB1ow0l73JLtoHm
 KH0Wgl8JPmZwbDAaatNYVr7dj/167rM8OJUg5/ncl26OPfOQcXZQ5T50dn2ssoHk1s/Kn2Cnr2R
 eOLSRrw79ovrxSheprkI0fpe3nzrkfRNEW7vuQSbz+XoQvnH3Z091iWS4l3xeEVQ6w==
X-Received: by 2002:a17:90b:3b8f:b0:3b3:b36e:8c3d with SMTP id
 98e67ed59e1d1-3b41cb466f4mr20517311a91.62.1795745651737; 
 Thu, 26 Nov 2026 18:14:11 -0800 (PST)
Received: from [127.0.0.2] (182-166-200-88f1.hyg1.eonet.ne.jp.
 [182.166.200.88]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b53479b149sm1368372a91.6.2026.11.26.18.14.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 18:14:11 -0800 (PST)
From: Maximilian Zimmermann <maxz@spacecubics.com>
Date: Fri, 27 Nov 2026 11:13:36 +0900
Subject: [PATCH 3/3] tests/functional/arm: Add SC-OBC Module A1 test
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261127-add-scobc-a1-board-v1-3-b572280dcde1@spacecubics.com>
References: <20261127-add-scobc-a1-board-v1-0-b572280dcde1@spacecubics.com>
In-Reply-To: <20261127-add-scobc-a1-board-v1-0-b572280dcde1@spacecubics.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org, 
 Maximilian Zimmermann <maxz@spacecubics.com>
X-Mailer: b4 0.15.2
Received-SPF: none client-ip=2607:f8b0:4864:20::532;
 envelope-from=maxz@spacecubics.com; helo=mail-pg1-x532.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 26 Nov 2026 23:07:08 -0500
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add a functional test for the scobc-a1 machine, so that regressions in
the board or its console UART are caught.

The test boots the Zephyr v4.5.0 hello_world sample built for the
scobc_a1 board directly into HRMEM and waits for the boot banner and the
greeting on the console UART.

Signed-off-by: Maximilian Zimmermann <maxz@spacecubics.com>
---
 MAINTAINERS                           |  1 +
 tests/functional/arm/meson.build      |  1 +
 tests/functional/arm/test_scobc_a1.py | 30 ++++++++++++++++++++++++++++++
 3 files changed, 32 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index bc02f6e1be..3bea382cf4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1104,6 +1104,7 @@ L: qemu-arm@nongnu.org
 S: Maintained
 F: hw/arm/scobc_a1.c
 F: docs/system/arm/scobc-a1.rst
+F: tests/functional/arm/test_scobc_a1.py
 
 Stellaris
 M: Peter Maydell <peter.maydell@linaro.org>
diff --git a/tests/functional/arm/meson.build b/tests/functional/arm/meson.build
index 72c7afc84a..88e567e90e 100644
--- a/tests/functional/arm/meson.build
+++ b/tests/functional/arm/meson.build
@@ -70,6 +70,7 @@ tests_arm_system_thorough = [
   'realview',
   'replay',
   'sabrelite',
+  'scobc_a1',
   'smdkc210',
   'stellaris',
   'sx1',
diff --git a/tests/functional/arm/test_scobc_a1.py b/tests/functional/arm/test_scobc_a1.py
new file mode 100755
index 0000000000..41d18cfef0
--- /dev/null
+++ b/tests/functional/arm/test_scobc_a1.py
@@ -0,0 +1,30 @@
+#!/usr/bin/env python3
+#
+# Functional test that boots Zephyr on the Space Cubics SC-OBC Module A1
+#
+# Copyright (c) 2026 Space Cubics Inc.
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+from qemu_test import QemuSystemTest, Asset, wait_for_console_pattern
+
+
+class ScobcA1Machine(QemuSystemTest):
+
+    ASSET_HELLO_WORLD = Asset(
+        'https://downloads.spacecubics.com/development/scobc-a1/qemu/'
+        'zephyr-v4.5.0-hello_world.elf',
+        '1578aebe742e4b3fc10af22994de4cd7feda3b54be19486a2efe42c099734c60')
+
+    def test_scobc_a1_hello_world(self):
+        self.set_machine('scobc-a1')
+        kernel_path = self.ASSET_HELLO_WORLD.fetch()
+        self.vm.set_console()
+        self.vm.add_args('-kernel', kernel_path)
+        self.vm.launch()
+        wait_for_console_pattern(self, '*** Booting Zephyr OS build v4.5.0 ***')
+        wait_for_console_pattern(self, 'Hello World! scobc_a1')
+
+
+if __name__ == '__main__':
+    QemuSystemTest.main()

-- 
2.55.0


