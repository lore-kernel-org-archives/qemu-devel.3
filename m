Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61B06CCA464
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 18:16:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHPvI-00012X-FQ; Thu, 15 Oct 2026 14:11:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcelomanzo@gmail.com>)
 id 1xHPvF-0000sl-Oe
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 14:11:21 -0400
Received: from mail-qv1-xf2d.google.com ([2607:f8b0:4864:20::f2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcelomanzo@gmail.com>)
 id 1xHPvC-0001PC-IR
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 14:11:21 -0400
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-917a64f28d0so2791696d6.0
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 11:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792087877; x=1792692677; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NtyH1JrbjE6E6ExgzJYIuvOowriA6YLfrM9Heqe8B7Q=;
 b=bcuuuSncitbJl/kug2/GR6na8UCzCwOM6rxAHmDv4AMUukNr0kRDsGfJYOVoHKgRo4
 UhnI+qgWy1309OcY8LOByu0f6o1gvVZrRFHslTKbLdaa2li6M2/JfiRHB62qrTXg/1OI
 uJUBG91D/rxWcIsipc5M+anDiGGdTeva+VX73Xo8w9qMci7atXssfwKrKhUJTA0wOnE5
 C2ta0+oZyDUD2I/2FfnCVn0HIaMoJXC5tarq1oD5CIfErKT8aAODyg1uiKrFBkjIT+z9
 KO1JPaCeLRdbAlozxbno7j7TnqWNpZ6Kker1tRtcMsdLzpVEeywXZgMBac868WBLPZRJ
 gj+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792087877; x=1792692677;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=NtyH1JrbjE6E6ExgzJYIuvOowriA6YLfrM9Heqe8B7Q=;
 b=yA80t2yhlDj8IEkujmHCFM9DjW0VGUFZSp5Bh110YFuQ7CKna642z/nPY/D6Vjm/Lp
 wcmmkVfZDJULB/0/oNNPJVkdq0jjPXOEFtu6rmJeK64DZRlPr5xsDEH05XbBa0wTHPpv
 u/sPJQTyej8RTU/ZDOh68OA/QiE/1PqR/LgbGmKs9J1ghFpI4VeyEz06sBfUt7/QU9IO
 V7TeHl+NEC1atMCtQcuXNCgURJgyG4oD9PxQRCrHTp0kWhvvtYXUebt+VcqoZKRYQ3HY
 8s3NWevKR24H/wRjLqmWjkNLDBQC1k+gCbquRDLH/IEjYEWPQYDdX31Y0GW0rYQ4dyi+
 bx9Q==
X-Gm-Message-State: AFq9FYIS27C6fPRx7rbEHX2AOkZtOVJxqi7x7o1q0+lJETcb9Ys9KI3M
 vza22ChOOtq3f3Qm/xLa8o+tX/NJbDprvnpk/qpVGcxx3pGEU9Px8M26uuAQclPH
X-Gm-Gg: AYBFou3tzwLBNfXl9Taq/5rzv0HjVCqKog0vHCrPS8gFtWfasUm+KYNl8GK54V3+k58
 M28OTEGhN0WhIwmo19b5agFgNyGogTRXOcpACmGzj62vZRghha3ZRSdot9+/i7U2pmzEVMXfo7M
 gOulxNYAN4ZzVC7lP7jfVr0wSJ5q4KHlFhKLa0aEwapzpkJ4SfQ+4qToJyPe6fZ5nMB0cSq/wrM
 fcAN4Lvs2d6EAYHE8N1ZnjPNO88QB5JEmYzZjDeKMC5MS5lGMFoZJcAlGX7Qp5FueJLSDICovJR
 3h8u01OwcSWd2v3qtJWplPhicKDjhC1QR2i2Xmk05lWyqxBxy/rttI9BcpQj772dgRHsruKpLFy
 CWd4qfKHk4UChiaTki9qzAW4ZS8YLOeto5lpMz54ynDOipyx4Lfa572TtHnfv8U/siEyCx0bzZr
 gXPb+qYzcw2ixI//IU2G6eZ9fFFxvDaYv2adZXQJr7ECTfXL0gkHKChd6WJaEhvkr0QHxmr55vD
 2VJY0/fSq4HwYXg0vEcmGYr00fDsVy1KxaUeVjHvt5jFxP++m1RS5x0jHqfDGvUssk3pA==
X-Received: by 2002:a05:6214:628:b0:914:40f4:d4b9 with SMTP id
 6a1803df08f44-91bc91d3159mr15796716d6.12.1792087877520; 
 Thu, 15 Oct 2026 11:11:17 -0700 (PDT)
Received: from localhost.localdomain ([2606:6d00:159:2900:919:5388:4e10:5949])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91bcba45dffsm1816206d6.12.2026.10.15.11.11.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 15 Oct 2026 11:11:17 -0700 (PDT)
From: Marcelo Manzo <marcelomanzo@gmail.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Marcelo Manzo <marcelomanzo@gmail.com>
Subject: [PATCH v2 5/5] tests/functional/aarch64: add raspi4b RNG200/thermal
 test
Date: Thu, 15 Oct 2026 14:11:11 -0400
Message-ID: <20261015181111.60491-6-marcelomanzo@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261015181111.60491-1-marcelomanzo@gmail.com>
References: <20261015181111.60491-1-marcelomanzo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2d;
 envelope-from=marcelomanzo@gmail.com; helo=mail-qv1-xf2d.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Extend test_arm_raspi4_initrd to exercise the RNG200 and thermal
sensor devices added in this series: confirm the RNG200 driver probes
it ("hwrng registered" in the kernel log), then once at a shell
confirm the thermal zone reports the expected fixed reading and that
/dev/hwrng actually yields data rather than just existing.

These checks go into the existing initrd boot test rather than a new
test, to avoid spending test time booting the same kernel again.

Verified locally against this series with the exact kernel/initrd
assets this file already pins.

Signed-off-by: Marcelo Manzo <marcelomanzo@gmail.com>
---
 tests/functional/aarch64/test_raspi4.py | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tests/functional/aarch64/test_raspi4.py b/tests/functional/aarch64/test_raspi4.py
index bacecbbe9c..c61014b5fa 100755
--- a/tests/functional/aarch64/test_raspi4.py
+++ b/tests/functional/aarch64/test_raspi4.py
@@ -80,6 +80,8 @@ def test_arm_raspi4_initrd(self):
         #                '-device', 'qemu-xhci,bus=pcie.1,id=xhci',
         #                '-device', 'usb-kbd,bus=xhci.0',
         self.vm.launch()
+        self.wait_for_console_pattern(
+            'iproc-rng200 fe104000.rng: hwrng registered')
         self.wait_for_console_pattern('Boot successful.')
 
         exec_command_and_wait_for_pattern(self, 'cat /proc/cpuinfo',
@@ -103,6 +105,11 @@ def test_arm_raspi4_initrd(self):
                            'memory node above the 1 GiB peripheral hole '
                            'is probably not being added' % mem_total_kb)
 
+        exec_command_and_wait_for_pattern(
+            self, 'cat /sys/devices/virtual/thermal/thermal_zone0/temp',
+            '25310')
+        exec_command_and_wait_for_pattern(self, 'head -c 8 /dev/hwrng | xxd',
+                                                '00000000:')
         exec_command_and_wait_for_pattern(self, 'halt', 'reboot: System halted')
         # TODO: Raspberry Pi4 doesn't shut down properly with recent kernels
         # Wait for VM to shut down gracefully
-- 
2.55.0


