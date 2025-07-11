Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96ADAC83F1A
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 11:07:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaBaW-0002SB-KX; Fri, 11 Jul 2025 07:06:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jackson88044@gmail.com>)
 id 1uaBaM-0002E9-46
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 07:06:34 -0400
Received: from mail-qt1-x829.google.com ([2607:f8b0:4864:20::829])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jackson88044@gmail.com>)
 id 1uaBaJ-0004Nr-Mm
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 07:06:33 -0400
Received: by mail-qt1-x829.google.com with SMTP id
 d75a77b69052e-4a77ffcb795so18838441cf.0
 for <qemu-devel@nongnu.org>; Fri, 11 Jul 2025 04:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1752231990; x=1752836790; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QK7ZBGorHLhIyTs2rJDI93LSJl/08P3418JQkaYc7QQ=;
 b=O4rc98G3+2mbWAD7nhr0Q2/cdnpKPhWYm9q6WE7ua3agDIFaUq6VgGLI5F9Ejx7IFq
 TVupdGKtbFmf8QTzbea2uxIRxJO9EAWwxKIeP63hG1S/7HAtbzrqXNR/y0Ckef4abhIb
 nuEa9Ph0is67AYy6YaM9wYD8fwvew6LzGrXPX63ken2OAel2V9EnqKCq68mxwmIYCOXk
 6LZlDQupBO8f2aiUdCJlZyWUEA9F939Z5y4WhamP8BDp8JWa3Pynaik+O9y11sPe1Jam
 u04l/RjVuMCzHkW6EoPeLE+HgwV4+mqMfr48uk8bWKQBlu0kpV1VEZwIeD3fQjiFUbnp
 SwhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752231990; x=1752836790;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QK7ZBGorHLhIyTs2rJDI93LSJl/08P3418JQkaYc7QQ=;
 b=e+V1QER/Bk8/gIO9e4VXigEI1koTdE1wzJHkuzeZZf7ZKYNwvHpaKKPIQd2pw80eZa
 w23b06I+0AItZhfCN4ClW/M/b27qJ6AzE6IhMfyFXnFdw8S31xIVDg93LFZZkE/YF1BF
 5EAgLoR+Ps2hVPmVv+FCDTarP0ZPKHWKQYMpm4VH5wbUlvvMH1PjB3BWX3avZSd8heHC
 BykNpmG6kUkuxExAkWL0oc7XUQwzQMg0k9YvsXhM55HNnXfNjTlN1khaW7+igT9/Zgbf
 MM2wGlBJIO5FtoT9qoGV1MB4LyrxyKSFNow7R5jNAeMVAkLTJL9bpm60FYlZC/3rhZmW
 GVLA==
X-Gm-Message-State: AOJu0YyZ/WRshZcL2OfJac9sGJSclZQ4B4gN8miIV/trIVIccsQ9eJqs
 rXGg+Ov+XzPji+Qy0USjMJFxHoZXjn+ZhE3LdE4GGhwmM5tAcrfZOVVSkfVrfQ==
X-Gm-Gg: ASbGnct9B3cKgzH923p/IW6gc1IoxcRJKn7oviizoYdlDQx/HqTMEZQTav8OYirREG0
 hCrivA7rupU4rNKodUWln+4EGmdgZGdKikpTT9xBh8oGhiLiajr/RtI54u+A8ug7UICDDu07NQ3
 12BAnSFA35Tz4hfZ6eJm0lKQTA2QC1iWcjL8SeRRl3kqDIrXyegG0LS/YXKWrB/bLA0/Oh3Pp4v
 ZmtH/VCCU9Ys2Wok65RmUZAH4R4Uldo7IKcAKIhDqUtUSX7ifEUBU0NUt+6PNBazVTW3xzmMsEA
 IirMz8r5eKgJ5+Mqao8Q5X5Xo6IKQ2j5mq6+DXcIBgWmbEXgmR7wG4DZKE5flMiGr4mWh+VeqBD
 49fJ2zTyBIyCj1A+iLf3+rwlaZrAzFrLE3iXgAN1n3FHLUAc=
X-Google-Smtp-Source: AGHT+IGYf1g/M3BK410EMxC2LLUqSo2To99dH4gGVJ10rVdJnmIZrH9Npv+2160WF6ilOlvt0shxyQ==
X-Received: by 2002:a05:622a:1206:b0:4a7:a8a:eed with SMTP id
 d75a77b69052e-4aaaf25fec7mr29354541cf.39.1752231990220; 
 Fri, 11 Jul 2025 04:06:30 -0700 (PDT)
Received: from user-jcksn.mynetworksettings.com
 ([2600:4040:b51f:a700:9684:12c5:c8ed:6d59])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4a9edcafb3csm20238471cf.34.2025.07.11.04.06.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Jul 2025 04:06:29 -0700 (PDT)
From: Jackson Donaldson <jackson88044@gmail.com>
X-Google-Original-From: Jackson Donaldson <jcksn@duck.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
	Thomas Huth <thuth@redhat.com>
Subject: [PATCH v2 2/2] tests/functional: Add a test for the MAX78000 arm
 machine
Date: Fri, 11 Jul 2025 07:06:26 -0400
Message-Id: <20250711110626.624534-3-jcksn@duck.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250711110626.624534-1-jcksn@duck.com>
References: <20250711110626.624534-1-jcksn@duck.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::829;
 envelope-from=jackson88044@gmail.com; helo=mail-qt1-x829.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Runs a binary from the max78000test repo used in
developing the qemu implementation of the max78000
to verify that the machine and implemented devices
generally still work.

Signed-off-by: Jackson Donaldson <jcksn@duck.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 tests/functional/meson.build              |  1 +
 tests/functional/test_arm_max78000fthr.py | 48 +++++++++++++++++++++++
 2 files changed, 49 insertions(+)
 create mode 100755 tests/functional/test_arm_max78000fthr.py

diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index e9f19d54a2..f837c6ddb1 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -131,6 +131,7 @@ tests_arm_system_thorough = [
   'arm_cubieboard',
   'arm_emcraft_sf2',
   'arm_integratorcp',
+  'arm_max78000fthr',
   'arm_microbit',
   'arm_orangepi',
   'arm_quanta_gsj',
diff --git a/tests/functional/test_arm_max78000fthr.py b/tests/functional/test_arm_max78000fthr.py
new file mode 100755
index 0000000000..a82980b0f7
--- /dev/null
+++ b/tests/functional/test_arm_max78000fthr.py
@@ -0,0 +1,48 @@
+#!/usr/bin/env python3
+#
+# Functional test that checks the max78000fthr machine.
+# Tests ICC, GCR, TRNG, AES, and UART
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+from qemu_test import QemuSystemTest, Asset, exec_command_and_wait_for_pattern
+from qemu_test import wait_for_console_pattern
+
+
+class Max78000Machine(QemuSystemTest):
+
+    ASSET_FW = Asset(
+        'https://github.com/JacksonDonaldson/max78000Test/raw/main/build/max78000.bin',
+        '86940b4bf60931bc6a8aa5db4b9f7f3cf8f64dbbd7ac534647980e536cf3adf7')
+
+    def test_fthr(self):
+        self.set_machine('max78000fthr')
+        fw_path = self.ASSET_FW.fetch()
+        self.vm.set_console()
+        self.vm.add_args('-kernel', fw_path)
+        self.vm.add_args('-device', "loader,file=" + fw_path + ",addr=0x10000000")
+        self.vm.launch()
+
+        wait_for_console_pattern(self, 'started')
+
+        # i -> prints instruction cache values
+        exec_command_and_wait_for_pattern(self, 'i', 'CTRL: 00010001')
+
+        # r -> gcr resets the machine
+        exec_command_and_wait_for_pattern(self, 'r', 'started')
+
+        # z -> sets some memory, then has gcr zero it
+        exec_command_and_wait_for_pattern(self, 'z', 'initial value: 12345678')
+        wait_for_console_pattern(self, "after memz: 00000000")
+
+        # t -> runs trng
+        exec_command_and_wait_for_pattern(self, 't', 'random data:')
+
+        # a -> runs aes
+        exec_command_and_wait_for_pattern(self, 'a',
+                'encrypted to : a47ca9dd e0df4c86 a070af6e 91710dec')
+        wait_for_console_pattern(self,
+                'encrypted to : cab7a28e bf456751 9049fcea 8960494b')
+
+if __name__ == '__main__':
+    QemuSystemTest.main()
-- 
2.34.1


