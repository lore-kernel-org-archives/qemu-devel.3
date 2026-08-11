Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09A2EC5B572
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 14:39:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtnas-00015H-H6; Tue, 11 Aug 2026 10:36:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcelomanzo@gmail.com>)
 id 1wtnaZ-0000NR-Cf
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 10:36:23 -0400
Received: from mail-qv1-xf29.google.com ([2607:f8b0:4864:20::f29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcelomanzo@gmail.com>)
 id 1wtnaX-0001x4-Ja
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 10:36:22 -0400
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-90a6b298887so1159966d6.2
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 07:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786458979; x=1787063779; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KOt2p99qli37aLiRSGWi+DGEsvQgttAGvPBuWfl5IYw=;
 b=Nmyc1qgrEyvhz+Bfto2QFD/vjUDOl0zNgc+qifywD7WIgT41jTSjBDjoE+zNKoyIj9
 IELeOF3sW4QFd2f3dWrzrHdrz/fzo25V5ohqXtsAbXyzcy+1rlM8GrETP2jWw0jruNT/
 DNFeON7cXs0brqxEFycB0EwFhRg8RNql1UUjRHuRtjiRamWBtytjKCnnOSn7Sr2QvATA
 oN385wFRz18ooxSsVNZDY/u9PsVenwKJBcVy5eH3VatiEPH8KMKMl0RD7nM+4fnas4Ii
 Xq3l3Up4/eTaizLYUs9BnrFNZ6M/II2AtLwpGSqZjsPAhjXfLtWLueQMrMSEalaS6oxL
 RzNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786458979; x=1787063779;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=KOt2p99qli37aLiRSGWi+DGEsvQgttAGvPBuWfl5IYw=;
 b=arHIc7dWYQedif+KyINg9K3D7Pvr/dPuIucwvYVlvVjSk5ESPbGjex3jxWKVqCE2k5
 zle0o0wQYjjO7XrhAJLH0hGF+bnd07OnwQ/l5KAwh8U5GWatKXb2woihBF8ilvsg6oor
 Iqtzxz2VYbmLUy1DQP/acCsdTqb1ac89ZOH8JfKZwCV+S9Ya8Emg/RGGCkyGhucJY1NY
 HxmJ5/EPcL1/NB/1hMKzaKTI5D5sJ4/+9jIpLl4ebO1CdP2auVKAw7BQjAlegqA55lDX
 GteMrDajb4Oy0kluSkMq7aDqM1SXgPKihnSZdud3jPP/dXcC/yfQcprK1sgeNGqpeI85
 PAQw==
X-Gm-Message-State: AOJu0YxRFbdssBLbSS3bYnHf7Mwj3pmxwlywXmSLLjv+8cE6VCsWabop
 dZ8x9NpJF1RmHR3fsr26BbwMlhiOnQvq8X+MGpWT2kJWmhpO6o6RfUPXN0Bf/w==
X-Gm-Gg: AR+sD11V4lcC/nDm4nxMlxj7iJIm7cgSzcKOxNBG1L6/jCd5i252Z4aW3KzIQ+uxLVi
 5kC23HvtgnV0aTIK4m6JqcMR8ZVSKl3aEgWTepd36Vcqh9HiwuhzwtL3nyaRslYwopcEMfNJKm7
 f6xOPYYQ6e+SmoKJNkIqTgLxPd/nN2SXA8wUqqUWF2QP4klpxofTw3ThBL9qZUVZt0vcBSRUZze
 ov70D2mxA50Y8/hxSMzvu6Vfo/GexK1/eq5HA4j0MyhvP8lJxMLmRM1uC1Filb/nReaRPLMNJkC
 wYwlBMA1iI5hthmRuQ1TlYiZSi3WEaGy/qBAtpOYoF1D+J9CRsMo0QeyQwIn6UHsDEE81IY+0vE
 xWP9lL8CgiDLRQ+UgK3U3y5AvmfIP8wwCHNZ1mKmRu5zolaNLspUeWLtvamZutnkTjtUpttwzjx
 WIiMZZCreCmx6fx60goWYQmhjdxZuqWPvTgFzQJmmwAqt9vFBvOLeAIMMdcONV3rixiwpHgSL+7
 x3bbHD5pyNubav7mgo=
X-Received: by 2002:a05:6214:493:b0:8ef:aad6:dada with SMTP id
 6a1803df08f44-90a66ea44c6mr32735916d6.20.1786458979436; 
 Tue, 11 Aug 2026 07:36:19 -0700 (PDT)
Received: from localhost.localdomain ([198.16.145.87])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-90a6c26e074sm681286d6.2.2026.08.11.07.36.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 11 Aug 2026 07:36:19 -0700 (PDT)
From: Marcelo Manzo <marcelomanzo@gmail.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Marcelo Manzo <marcelomanzo@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>
Subject: [PATCH v2 19/19] tests/functional/aarch64: add raspi4b GENET
 networking test
Date: Tue, 11 Aug 2026 10:35:56 -0400
Message-ID: <20260811143557.7862-20-marcelomanzo@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260811143557.7862-1-marcelomanzo@gmail.com>
References: <20260811143557.7862-1-marcelomanzo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f29;
 envelope-from=marcelomanzo@gmail.com; helo=mail-qv1-xf29.google.com
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

Add test_arm_raspi4_genet, exercising the raspi4b GENET controller
end to end: boot with a -nic bcm2838-genet device attached, confirm
the guest driver probes it ("GENET 5.0 EPHY" in the kernel log),
reach a shell, and confirm the link actually comes up
("ip link show eth0" reports LOWER_UP) rather than just that the
device exists.

Verified locally against this series with the exact kernel/initrd
assets this file already pins (raspberrypi-kernel_1.20230106-1 /
groeck linux-build-test rootfs): without the "fix PHY
autonegotiation-restart deadlock" patch earlier in this series, the
link never comes up and this test would hang at the "ip link show
eth0" step, so it also serves as a regression test for that fix.

Signed-off-by: Marcelo Manzo <marcelomanzo@gmail.com>
---
 tests/functional/aarch64/test_raspi4.py | 30 +++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/tests/functional/aarch64/test_raspi4.py b/tests/functional/aarch64/test_raspi4.py
index 7a4302b0c5..0e254a2034 100755
--- a/tests/functional/aarch64/test_raspi4.py
+++ b/tests/functional/aarch64/test_raspi4.py
@@ -92,5 +92,35 @@ def test_arm_raspi4_initrd(self):
         #self.vm.wait()
 
 
+    def test_arm_raspi4_genet(self):
+        kernel_path = self.archive_extract(self.ASSET_KERNEL_20190215,
+                                           member='boot/kernel8.img')
+        dtb_path = self.archive_extract(self.ASSET_KERNEL_20190215,
+                                        member='boot/bcm2711-rpi-4-b.dtb')
+        initrd_path = self.uncompress(self.ASSET_INITRD)
+
+        self.set_machine('raspi4b')
+        self.vm.set_console()
+        kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
+                               'earlycon=pl011,mmio32,0xfe201000 ' +
+                               'console=ttyAMA0,115200 ' +
+                               'panic=-1 noreboot ' +
+                               'dwc_otg.fiq_fsm_enable=0')
+        self.vm.add_args('-kernel', kernel_path,
+                         '-dtb', dtb_path,
+                         '-initrd', initrd_path,
+                         '-append', kernel_command_line,
+                         '-no-reboot',
+                         '-nic', 'user,model=bcm2838-genet')
+        self.vm.launch()
+        self.wait_for_console_pattern(
+            'bcmgenet fd580000.ethernet: GENET 5.0 EPHY')
+        self.wait_for_console_pattern('Boot successful.')
+
+        exec_command_and_wait_for_pattern(self, 'ip link show eth0',
+                                                'LOWER_UP')
+        exec_command_and_wait_for_pattern(self, 'halt', 'reboot: System halted')
+
+
 if __name__ == '__main__':
     LinuxKernelTest.main()
-- 
2.47.1


