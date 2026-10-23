Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E624D606A31F
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 14:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DG7tvt5Q
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKFp6-0002DW-8L; Fri, 23 Oct 2026 10:00:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcelomanzo@gmail.com>)
 id 1xKFoC-0000vH-To
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 09:59:49 -0400
Received: from mail-qk1-x72c.google.com ([2607:f8b0:4864:20::72c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcelomanzo@gmail.com>)
 id 1xKFo9-0004tF-Nh
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 09:59:48 -0400
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-93f3c895a0eso71092085a.2
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 06:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792763985; x=1793368785; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BTLX4E/wXPnRsvyWK12SwwoqMi9TXZxhEIuvci+/7pM=;
 b=DG7tvt5QQnNxIW1M7OU2EIp+biLj9F0IKLgX/sPAAlHzn8GiNNKAtl85VwV70sQgcl
 V74/TRr/T/77X1kk+2SnorqQ/iye4RRJhCXxOjeHsFeBmcsl8FhblTy4udofn3t8DKLc
 xEZ9aSLGIKDMv+6dJ+a3V1QdTArhy4Cv49JFvjQ/TC1m4Ah/13ExAKIvX5yCZZOgcOzI
 CkQrZvOIgiQFio8wRdLMuJhj4nd/eUe9eWdB+dYUUkr4c3rUegcfbTsS76Tp8jTHq4GM
 ce/nmrM/y3sLNN9Twn2eUsCd4v1inoegDc/mG/oqeF1jdpN6ODlUEeYJuhFFbQfkg3e6
 K9uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792763985; x=1793368785;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=BTLX4E/wXPnRsvyWK12SwwoqMi9TXZxhEIuvci+/7pM=;
 b=upUu0XeenEJx6ZEHchhvNu/Y1IBbEwYkUSZ2FOq8GNlsmVog7+jJcc0ILaObxPhUu5
 H8hZ3EuxVHo5M6oen40fSJzJujLCzul5HLUV80KQteLdd+7nAbxaXg3jjyCP5Z5MME9p
 SGmZh+4/S4BmVk/us03enPC+UfkMqRAOxGeTttYVQH3Ykk+ehekcJkn3NyPrkN/dCSVD
 pAYDFOJjKa/ySIe9U0yHea2+7sCEoGLcdGB82q16E2Bd6u2jte/fCQkKmWBFafC5UUyf
 hgZYoPoFGgJ0gU9poYOG1AtNJdhZG/xCJUXGDOD2cu62GOFU/c7HPKWA3sCt8+5G1Rr/
 92bQ==
X-Gm-Message-State: AFq9FYLIK+10Sjvoy17aHGQcaDLuQBMpykquB5mep30zy8cWCTQ5FOqV
 N1avoVWXMqEeAqBN6HDxzjNMHOcbdYDU4zq13jU+kHnLEajcShjjergPCIEJ2Hh7
X-Gm-Gg: AYBFou2FMX8rqP5jHnhu131oMUgL/zEGnIiS2j4t7fZ8A7wPDSRqZwAket0KmRzfx2P
 Kig0iD/Vv3wgZNQGiSN5Q6tD1dILSzMw0O58V/NdB5IXACeLEMjwBf0zWhVlQ0f9gYgaOsAhiJW
 25mJC54w/BFXrw3kvpdg63Suv4qUPM+0GzTC6JLrwUlrA+qZh4k6dacxHxI2+wQKljgq5i4oATD
 QVw9/nEh8i5qI5wWrAM7AM7IMibueKWedXUhtNqFAmyzdobth+K/oYyqYBPjTVir3g5z/s3vwC5
 lpqJMiUygDbC03674FU8T05SlbwAdxP60RqcELAjKzj7x8EkJzBJYo9tvBLyhkGwjprbuwGNqqb
 7ddZ71wOgPybyRWi+6zB/53Z/hahTs0VppY56RKnC7QHuDZMM84JS0x3PhicDXzfM1VQQyM9ory
 AY7h0raPBYlm8qV55PKEzE+eHiPkr7l8w+CIxLTY3oWuSQ0bddaHPOJtduVYxIO5RaMYsyytmh2
 3AifL4XrcEyRSmf9d6lnHf6woO8K6kFjzVDVUqaxhlL9WSj9uI6F1bIKjATnTXqMk9rTABYFjYa
 ZXK//lXQcatmQuwfxNzSge5o/qwIkjjjWzpRtTpxBNPZx42YBCuW
X-Received: by 2002:a05:620a:458f:b0:93e:c12c:43fb with SMTP id
 af79cd13be357-93f6f875cefmr463289485a.72.1792763984720; 
 Fri, 23 Oct 2026 06:59:44 -0700 (PDT)
Received: from localhost.localdomain ([2606:6d00:159:2900:450e:e72b:156b:33d1])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-94047811552sm23741285a.18.2026.10.23.06.59.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 23 Oct 2026 06:59:44 -0700 (PDT)
From: Marcelo Manzo <marcelomanzo@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, philmd@oss.qualcomm.com,
 Marcelo Manzo <marcelomanzo@gmail.com>
Subject: [PATCH v5 16/16] tests/functional/aarch64: add raspi4b GENET
 networking test
Date: Fri, 23 Oct 2026 09:59:24 -0400
Message-ID: <20261023135924.64990-18-marcelomanzo@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261023135924.64990-1-marcelomanzo@gmail.com>
References: <20261023135924.64990-1-marcelomanzo@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::72c;
 envelope-from=marcelomanzo@gmail.com; helo=mail-qk1-x72c.google.com
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


