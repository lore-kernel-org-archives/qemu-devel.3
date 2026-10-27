Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC98606A31B
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 14:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AHOi4O4I
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLiDS-0008AA-6K; Tue, 27 Oct 2026 10:31:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcelomanzo@gmail.com>)
 id 1xLiCm-0007LV-Pi
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 10:31:27 -0400
Received: from mail-qk1-x733.google.com ([2607:f8b0:4864:20::733])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcelomanzo@gmail.com>)
 id 1xLiCk-0005DJ-WB
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 10:31:12 -0400
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-943e8d35f74so162483585a.0
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 07:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793111470; x=1793716270; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BTLX4E/wXPnRsvyWK12SwwoqMi9TXZxhEIuvci+/7pM=;
 b=AHOi4O4I2N7RjRIQrz0kXjYItwZOtVaJjaTZalnsQcXTdpMogQfK2UY/ZdQr8gmX8F
 95dPxCvJgqwfZQ09lytwcg5rz5ptZlCeM4Di77/oCaxyzzKXuWcKgCtjmW+6lt50Jhas
 cRBrQNecqm3E33T25NHMSNpT7bIDIlZhvMFNInjGEx189mjWeouT4TAmIqHtOw1U6hdi
 vPPdXw/NSf2oJNhytxiRixk30hZ56uFkqlu0C30y9KrSvDDwInktGy7Hh7HsovrYf4zp
 nsJ/7nT2E13RvP3znOeP57DS7GRH9MWauFso2YvP8caQYYrncdpoyOcF5viJGMt2oAKH
 INUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793111470; x=1793716270;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=BTLX4E/wXPnRsvyWK12SwwoqMi9TXZxhEIuvci+/7pM=;
 b=bmMEVs6NExocx6/UHMHuJQcARRZrGV9gzGNle+7O7KCseAuVs0APx8xbBPxHzvUWvY
 g33fzDqdXAT0kBWJQtf2hSsiBJaJe+tXaeTLeOegmueBsyqd/D7x5NN1fm+u6LiBCQ2Q
 zDIBkf1reJ3d6lCTjoJrFvKeqYsnmJek6Tf9cIbyiiJNJdem6XQQ3SburDOwCNp98CSw
 ltWOa8vcErKviwpnV1ovhp5FxLHsaq11VSLjTVNSSuVmOSpQwZwpWOZsUBEdn2lfqi7J
 WhnIo+he/HFylZRfcqVfA4Z1aXrGqeLqIE4JOEabDmgFCr5Yxp3X5T1iiU33rDgCdBqI
 swWw==
X-Gm-Message-State: AFq9FYK4Iyo5/WQYyEutY3EZPNosFtoJpOQRvR08xabo2hWzOJtFGSsb
 xBrKCniNqAJ8HnAbe1U70t8ekv57rH2CGWRFdXNz9GlpJE1Bhz8r64AXZO3J8et6
X-Gm-Gg: AYBFou2ksrjLfW2w7aRfsNMqofNFQ9Bp6ItD3N5Va3JaeYauUzJEEHJcbsS2qDE+E8q
 SEsG15uD30h3r1hvjpdug5NS0u8mtXw4rDpkyJcqf0jno7Iau16sgdU6X7G+ivIGKrzzW0G0Hgj
 jo8Go3d5u5zpUWYBBWs7OR3qWwNETgzLFo+PPsp4dWhWDfMeCTzpHYSz+sVaW89Ug/jLW/Ikdka
 NrGkZz2+Y1mz4RnbaCGdgeJwhfay9Vvr4JGlp8CL8fG3prJU9YKK2liy2GiYFsrKBvf7qI/insd
 cU5VV6FVgiaR7whBnXaUQ1Q/OmJ/P0hsOI7mcuWLG38/6Fq5cX4PK48SzjnvnX1V8d0Bu0vU9Y0
 PxstxhKA/lczC6sTsPs7rpIeGvp/Zn+oCJREfA3kiDOxrTn5lUHlT75dx3HCYhVrM9/2E76bkhZ
 IBt3Q0FcY20yK1+q0yth9I/bhzbmdoq2DZx4PBazenMgJq2Kq+5CC3Um+A63WtqV50E/ntQ6z6F
 HZptwCfxFb/PGYVW+ngymHsuxbjlLR3c2yMxWsQG2VGGDXkcVNofGl7ALEctH1htCdcG03k+yi3
 jJaPjNL8UbUGUn73zs+RCiqqM6c3GAxqnhBY+FzH91tK3vV0ByQ4
X-Received: by 2002:a05:620a:40cb:b0:93e:c12c:f11b with SMTP id
 af79cd13be357-940ef94ce57mr1490721885a.71.1793111469824; 
 Tue, 27 Oct 2026 07:31:09 -0700 (PDT)
Received: from localhost.localdomain ([2606:6d00:159:2900:9872:3600:589:5f3a])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-940f0a78c06sm986400885a.35.2026.10.27.07.31.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 27 Oct 2026 07:31:05 -0700 (PDT)
From: Marcelo Manzo <marcelomanzo@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, philmd@oss.qualcomm.com,
 Marcelo Manzo <marcelomanzo@gmail.com>
Subject: [PATCH v6 17/17] tests/functional/aarch64: add raspi4b GENET
 networking test
Date: Tue, 27 Oct 2026 10:30:36 -0400
Message-ID: <20261027143036.44973-18-marcelomanzo@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261027143036.44973-1-marcelomanzo@gmail.com>
References: <20261027143036.44973-1-marcelomanzo@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::733;
 envelope-from=marcelomanzo@gmail.com; helo=mail-qk1-x733.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add test_arm_raspi4_genet, exercising the raspi4b GENET controller
end to end: boot with a -nic bcm2838-genet device attached, confirm
the guest driver probes it ("GENET 5.0 EPHY" in the kernel log),
reach a shell, and confirm the link actually comes up
("ip link show eth0" reports LOWER_UP) rather than just that the
device exists.

Verified locally against this series with the exact kernel/initrd
assets this file already pins (raspberrypi-kernel_1.20230106-1 /
groeck linux-build-test rootfs). The link only comes up because the
MDIO patch handles the PHY autonegotiation-restart request (BMCR
ANRESTART) correctly; without that the link never comes up and this
test would hang at the "ip link show eth0" step, so it also serves
as a regression test for it.

Signed-off-by: Marcelo Manzo <marcelomanzo@gmail.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/functional/aarch64/test_raspi4.py | 31 +++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/tests/functional/aarch64/test_raspi4.py b/tests/functional/aarch64/test_raspi4.py
index bacecbbe9c..748837d818 100755
--- a/tests/functional/aarch64/test_raspi4.py
+++ b/tests/functional/aarch64/test_raspi4.py
@@ -109,5 +109,36 @@ def test_arm_raspi4_initrd(self):
         #self.vm.wait()
 
 
+    def test_arm_raspi4_genet(self):
+        self.require_netdev('user')
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
2.55.0


