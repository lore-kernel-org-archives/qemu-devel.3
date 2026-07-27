Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9741CC53209
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 13:54:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woLm6-0001hE-4J; Mon, 27 Jul 2026 09:53:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcelomanzo@gmail.com>)
 id 1woLm1-0001f8-0q
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 09:53:43 -0400
Received: from mail-vs1-xe2e.google.com ([2607:f8b0:4864:20::e2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcelomanzo@gmail.com>)
 id 1woLlw-0005pL-OV
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 09:53:38 -0400
Received: by mail-vs1-xe2e.google.com with SMTP id
 ada2fe7eead31-738bcf9a573so986986137.2
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 06:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785160413; x=1785765213; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=def94g1ZgIpxexyd5K9cV/aLU41QcCQ1hBKGNGZuG60=;
 b=ip316vu3wbUxqEMoEoUBulDikYDTCPXeYgTGr9o4clmTevz/YBWS926P3XA/IGbpMJ
 DjirRfQnXdkBJm7U2IUoBquIyx34talxw64f4ByrOesmmYwQYQ7W7UR5RyGXsqsuwJuS
 idGUt1eiOrf6+fIKz7DcKbaewlJaClkbVxY2KDkvvOOENE4HUmB8CH/HewEDbNijV6ii
 uG/I1e6gfXFdzBA71kT2Z9mvNmPgNaUJeG2kpUlbqavktLD3ONPY4W47+TXEuiBmIe8f
 zyCbRqk2hK1d7klC1Ei/9i2yZSOmy9l1gMql9jH7hE5hmLrejcJ2MSbKNZO3TpZk4lRS
 G6hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785160413; x=1785765213;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=def94g1ZgIpxexyd5K9cV/aLU41QcCQ1hBKGNGZuG60=;
 b=NkTGkYRi28EXvlDPb/xOBRfLEdAcWcqt4XH5tpZJWoLZsHu7mboNpZvY4+FKNz5PMn
 Xum1EiJt4uwGHdiEFdE1kOwTZ7NdW1EzzacRkLlNs+uDZ0zRpjQTmq7QAmuFaaTNS54+
 GV+tnKwQLOoD57V711IxI/xyQ+d9qA69mxflg6g524o9CV8FbBXoKKhZuvLXHj3L0dXV
 yS1BFDNRWSJc9o1/DLjSfv3CuKgzFSKVrusKVLSr8qDw9JdnfUaJBuNCMS75dflhkl45
 EaELMkMIIE2a7yI/ctsZ7m/GofMwGufU+yhiVyjENOHyzzcRf+kHFPAd/RH1SYo3Fscs
 wU4g==
X-Gm-Message-State: AOJu0Yz/ufRYIO59qqo2cVDIFk8ot9BO1qmLBFo/faFSRS3fiChaYXSR
 LwPv4fOLIn/DxczYo9nYL5oo2pWCaDdl2UkHhXt9MuqFwc9dR2HkaTgJWcyTcw==
X-Gm-Gg: AR+sD11EfdmcLYnOMMVdLOWbBclEd5u6tkcH5Av1YLIlzAYlfGrtOG9XGPKNmbUJu5Z
 B03z3uz3pnglr7e9eak4cMUfP+BGhLl2uxbOjasRcgCLeOC2mt8trV98uHGwlwmhJQGnZzoifsP
 pQ8JetemFReCvVJAGFwClQsi8cM2HWw9Wj90EJRowMjzvQSMhWuqQUnmA83guXSQXMuY8NIhX4s
 hNxwOMIg5YX9XEOsLUIQq2WsXJhm5cSHXVrz0sznz5BcjHDfQuEVlYAP+Zqr5wGrCmPRFX8hka9
 x7N8wo1NHD+3RKRptt8ZEH7DKIaawi+k4pD1Md4cadwINcpBq43JQVIB3/8pb+am6GsyZjbANx6
 6ZPVGvwcy/q/xERORpaaQ6DiFKa2dCgn2WfKUHc57AVcM+rhH45fJWdbIyGBK3P8QPk7GEqoVIC
 O0yOPfr8EnQQCjiyUYjpgAHUoZuhuTHtWZ
X-Received: by 2002:a05:6102:5126:b0:745:78d4:4856 with SMTP id
 ada2fe7eead31-7503e472da2mr4029224137.7.1785160412803; 
 Mon, 27 Jul 2026 06:53:32 -0700 (PDT)
Received: from localhost.localdomain ([146.71.8.128])
 by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-97774ce146csm5199734241.7.2026.07.27.06.53.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 27 Jul 2026 06:53:32 -0700 (PDT)
From: Marcelo Manzo <marcelomanzo@gmail.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Marcelo Manzo <marcelomanzo@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>
Subject: [PATCH v2 2/2] tests/functional/aarch64: add raspi4b full-RAM
 regression test
Date: Mon, 27 Jul 2026 09:53:29 -0400
Message-ID: <20260727135329.97190-3-marcelomanzo@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260727135329.97190-1-marcelomanzo@gmail.com>
References: <20260727135329.97190-1-marcelomanzo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::e2e;
 envelope-from=marcelomanzo@gmail.com; helo=mail-vs1-xe2e.google.com
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

Guards against the bug fixed in the previous commit: boots raspi4b's
default 2 GiB configuration and checks that the guest actually sees
close to that (>1.9M kB), not the ~921 MiB the bug left it capped at.
Deliberately checks a threshold rather than the exact byte count of
either figure, since the precise number depends on how this specific
pinned kernel accounts for its own early reservations; the threshold
is comfortably between the two (943524 kB broken, 1905824 kB fixed,
confirmed by hand against this exact kernel/initrd).

Signed-off-by: Marcelo Manzo <marcelomanzo@gmail.com>
---
 tests/functional/aarch64/test_raspi4.py | 51 +++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/tests/functional/aarch64/test_raspi4.py b/tests/functional/aarch64/test_raspi4.py
index 35ba6c24f7..55903e93d3 100755
--- a/tests/functional/aarch64/test_raspi4.py
+++ b/tests/functional/aarch64/test_raspi4.py
@@ -154,6 +154,57 @@ def test_arm_raspi4_rng_thermal(self):
         exec_command_and_wait_for_pattern(self, 'halt', 'reboot: System halted')
 
 
+    def test_arm_raspi4_full_ram(self):
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
+                         '-no-reboot')
+        self.vm.launch()
+        self.wait_for_console_pattern('Boot successful.')
+
+        # raspi4b's default machine RAM is 2 GiB, but raspi4_modify_dtb()
+        # used to compare the wrong field when deciding whether to add a
+        # second memory node above the 1 GiB peripheral hole (it checked
+        # the boot-loader's kernel/initrd-loading RAM budget, which is
+        # itself always capped to at most 1 GiB, rather than the board's
+        # actual total RAM) -- so that second node was never added for any
+        # raspi4b configuration, and the guest never saw more than ~1 GiB
+        # regardless of the machine's nominal RAM size. With the bug,
+        # MemTotal here is 943524 kB; fixed, it is 1905824 kB. Guard
+        # against a regression back to the ~1 GiB figure without hardcoding
+        # the exact byte count of either, which depends on how this
+        # specific pinned kernel accounts for its own reservations.
+        mem_total_kb = None
+        cmd_output = exec_command_and_wait_for_pattern(
+            self, 'cat /proc/meminfo', 'MemAvailable')
+        for line in cmd_output.decode('ascii', errors='replace').splitlines():
+            if line.startswith('MemTotal:'):
+                mem_total_kb = int(line.split()[1])
+                break
+        self.assertIsNotNone(mem_total_kb, 'MemTotal line not found')
+        self.assertGreater(mem_total_kb, 1900000,
+                           'guest RAM (%d kB) is far below the ~1.9 GiB '
+                           'expected for a 2 GiB raspi4b -- the second '
+                           'memory node above the 1 GiB peripheral hole '
+                           'is probably not being added' % mem_total_kb)
+
+        exec_command_and_wait_for_pattern(self, 'halt', 'reboot: System halted')
+
+
     def test_arm_raspi4_pcie(self):
         kernel_path = self.archive_extract(self.ASSET_KERNEL_20190215,
                                            member='boot/kernel8.img')
-- 
2.47.1


