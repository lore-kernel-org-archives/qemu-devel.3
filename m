Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5EACD2B922
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 13:06:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8JF0-00017L-2M; Tue, 05 Nov 2024 08:05:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t8JEy-000171-SU
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 08:05:01 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t8JEx-0002Bs-4w
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 08:05:00 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4315eac969aso33815775e9.1
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 05:04:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730811897; x=1731416697; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LoKTIjDa3J8vyZOU7wutUHSCN+Guhec+PI65dsartdI=;
 b=vX1D/h4lsgokf2/4ecfj9Qd/Rirc+GF3gGBUvNr8rVpGGpUGq1lcauJ+e3kXm48WJ0
 f47rziE0K4bakHKtFWj2x+vOddgiDUdCbtxz7hfs5Vp8Ro+gTCKr0WAlwbGY8BxXphA6
 oTu1yioWtB9BPOpgZvCxOioEEO1vaaCr3nBE+pegmBK/a/Msd8wtosJcp9vGkDXeIoTB
 Q7IbapxgBCb9ITMD7TdiB35BSjd3jnM+hSYXGFay9WKbPRnQX6i0a8kOTmZWAnBftew4
 148uGW0iCXJr1xp3vRcd4r+Ur5DPT1wUZWVZRV+eJMmyCmFBQykzIpTeayJwEI2XIPYl
 U/JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730811897; x=1731416697;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LoKTIjDa3J8vyZOU7wutUHSCN+Guhec+PI65dsartdI=;
 b=nXYwUWghP/O+sNYSJ7w58JbN0BUL3kObBrK18/y+gwPhdTbwh+VElHynRzofLnuZuk
 XrvaPqxaQbPU4XiX1/MLnbkb//FpX+DSuTORcucfgONibDybHmFI5Q5PM6+vsk9ybZzW
 HD7TB1LgbXlxWXr0qESDmFGD6Ak5i5ItPA15CG7CIbYlNInv6aT7fd+bIlDM3nykJRZj
 KAjzjFwphD/y8nEfX9jfa1rmHHCiuZmzwDuMkqj9Ot2msoHT6QL7FQPBqgdHRJBnOT9x
 NRiBfvoZyQxQ/k4hzRYKx+MawKhx7UYvOeRlxnk4izecjF3soce3+BfkbzUL1gIVnCP9
 OPfw==
X-Gm-Message-State: AOJu0YxLHTymyr4cf7cz9wdRQwQ3cUHeZS3vW0VuErCWG1R6lfCDgGgv
 Y9Ag4jIlr8HUUZKJUUQbrRDQxQNstOZ0bKWUhuc/CTOQb+Mh9YzLR4cRwXNAxnP4lu/9Tbzbr1Y
 5jDc=
X-Google-Smtp-Source: AGHT+IHMG75IgJ3W30Wrb+bRlTmmQ3nd9qq/2bzCUnlhNdzY1PB5IZLXC2a/K1d9WiUKPd3QEhHqcw==
X-Received: by 2002:a05:600c:460f:b0:426:5e32:4857 with SMTP id
 5b1f17b1804b1-4327d840fdemr148920265e9.0.1730811897231; 
 Tue, 05 Nov 2024 05:04:57 -0800 (PST)
Received: from localhost.localdomain (86.red-88-29-160.dynamicip.rima-tde.net.
 [88.29.160.86]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c10e725dsm16182932f8f.56.2024.11.05.05.04.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 05 Nov 2024 05:04:56 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Anton Johansson <anjo@rev.ng>
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>, Thomas Huth <thuth@redhat.com>,
 qemu-arm@nongnu.org, devel@lists.libvirt.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 02/19] hw/microblaze: Deprecate big-endian petalogix-ml605 &
 xlnx-zynqmp-pmu
Date: Tue,  5 Nov 2024 14:04:14 +0100
Message-ID: <20241105130431.22564-3-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241105130431.22564-1-philmd@linaro.org>
References: <20241105130431.22564-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The petalogix-ml605 machine was explicitly added as little-endian only
machine in commit 00914b7d970 ("microblaze: Add PetaLogix ml605 MMU
little-endian ref design"). Mark the big-endian version as deprecated.

When the xlnx-zynqmp-pmu machine's CPU was added in commit 133d23b3ad1
("xlnx-zynqmp-pmu: Add the CPU and memory"), its 'endianness' property
was set to %true, thus wired in little endianness.

Both machine are included in the big-endian system binary, while their
CPU is working in little-endian. Unlikely to work as it. Deprecate now
as broken config so we can remove soon.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 docs/about/deprecated.rst                        | 6 ++++++
 configs/devices/microblaze-softmmu/default.mak   | 2 --
 configs/devices/microblazeel-softmmu/default.mak | 5 ++++-
 hw/microblaze/petalogix_ml605_mmu.c              | 7 ++++++-
 hw/microblaze/xlnx-zynqmp-pmu.c                  | 8 ++++++--
 5 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index ff404d44f85..e1c8829e1a4 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -279,6 +279,12 @@ BMC and a witherspoon like OpenPOWER system. It was used for bring up
 of the AST2600 SoC in labs.  It can be easily replaced by the
 ``rainier-bmc`` machine which is a real product.
 
+Big-Endian variants of MicroBlaze ``petalogix-ml605`` and ``xlnx-zynqmp-pmu`` machines (since 9.2)
+''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
+
+Both ``petalogix-ml605`` and ``xlnx-zynqmp-pmu`` were added for little endian
+CPUs. Big endian support is not tested.
+
 Backend options
 ---------------
 
diff --git a/configs/devices/microblaze-softmmu/default.mak b/configs/devices/microblaze-softmmu/default.mak
index 583e3959bb7..78941064655 100644
--- a/configs/devices/microblaze-softmmu/default.mak
+++ b/configs/devices/microblaze-softmmu/default.mak
@@ -2,5 +2,3 @@
 
 # Boards are selected by default, uncomment to keep out of the build.
 # CONFIG_PETALOGIX_S3ADSP1800=n
-# CONFIG_PETALOGIX_ML605=n
-# CONFIG_XLNX_ZYNQMP_PMU=n
diff --git a/configs/devices/microblazeel-softmmu/default.mak b/configs/devices/microblazeel-softmmu/default.mak
index 29f7f13816c..4c1086435bf 100644
--- a/configs/devices/microblazeel-softmmu/default.mak
+++ b/configs/devices/microblazeel-softmmu/default.mak
@@ -1,3 +1,6 @@
 # Default configuration for microblazeel-softmmu
 
-include ../microblaze-softmmu/default.mak
+# Boards are selected by default, uncomment to keep out of the build.
+# CONFIG_PETALOGIX_S3ADSP1800=n
+# CONFIG_PETALOGIX_ML605=n
+# CONFIG_XLNX_ZYNQMP_PMU=n
diff --git a/hw/microblaze/petalogix_ml605_mmu.c b/hw/microblaze/petalogix_ml605_mmu.c
index df808ac323e..61e47d83988 100644
--- a/hw/microblaze/petalogix_ml605_mmu.c
+++ b/hw/microblaze/petalogix_ml605_mmu.c
@@ -213,7 +213,12 @@ petalogix_ml605_init(MachineState *machine)
 
 static void petalogix_ml605_machine_init(MachineClass *mc)
 {
-    mc->desc = "PetaLogix linux refdesign for xilinx ml605 little endian";
+#if TARGET_BIG_ENDIAN
+    mc->desc = "PetaLogix linux refdesign for xilinx ml605 (big endian)";
+    mc->deprecation_reason = "big endian support is not tested";
+#else
+    mc->desc = "PetaLogix linux refdesign for xilinx ml605 (little endian)";
+#endif
     mc->init = petalogix_ml605_init;
 }
 
diff --git a/hw/microblaze/xlnx-zynqmp-pmu.c b/hw/microblaze/xlnx-zynqmp-pmu.c
index 43608c2dca4..567aad47bfc 100644
--- a/hw/microblaze/xlnx-zynqmp-pmu.c
+++ b/hw/microblaze/xlnx-zynqmp-pmu.c
@@ -181,9 +181,13 @@ static void xlnx_zynqmp_pmu_init(MachineState *machine)
 
 static void xlnx_zynqmp_pmu_machine_init(MachineClass *mc)
 {
-    mc->desc = "Xilinx ZynqMP PMU machine";
+#if TARGET_BIG_ENDIAN
+    mc->desc = "Xilinx ZynqMP PMU machine (big endian)";
+    mc->deprecation_reason = "big endian support is not tested";
+#else
+    mc->desc = "Xilinx ZynqMP PMU machine (little endian)";
+#endif
     mc->init = xlnx_zynqmp_pmu_init;
 }
 
 DEFINE_MACHINE("xlnx-zynqmp-pmu", xlnx_zynqmp_pmu_machine_init)
-
-- 
2.45.2


