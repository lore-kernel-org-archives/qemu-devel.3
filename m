Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10426107BCF4
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 10:32:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2oBp-0001Tj-CB; Wed, 18 Mar 2026 06:31:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w2oBe-0001QI-Ti
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 06:31:40 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w2oBa-0001dn-4f
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 06:31:37 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4852e9ca034so60450055e9.2
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2026 03:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773829892; x=1774434692; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9m3lV3ME2W//2gUlABuyu3FspRWa1EzICjXujSbCOe0=;
 b=ffNd3l6oxlbluOwjjk1qNv+4gy+aC/be3kuupvXakeC8JM6zrCVzgB0xGyW18luFLo
 G/8D+uFo982ndiRiviLYFtCB1jqNCbr72AuMoJeoH3e6/QfTF833lsrllqVWTo4uK4qA
 d/bdc/gpA9Xe19m9V0gA24FGK3mQOSwHlMJgquAnxlDDu0+ID7Q7uH4qk5phJLrTqtHN
 dFQhY2KBwBQd5Rfpl3uHfxdT160BN9/DeCX5elCcwokaRGykkxRSKfG6Qpihlp8tYP8s
 +AOG13lH37gh7zFuJkOfx7YStWW2DiUYqpiiqfH/1TmXU7UUxiXtqg7uIei6kdWgx7WS
 RI0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773829892; x=1774434692;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9m3lV3ME2W//2gUlABuyu3FspRWa1EzICjXujSbCOe0=;
 b=NAM5T5Azj+mfw/EHLFtblOXKPzYvGyC8uRejPHCDr4CJyTarYudtbq90u9QBBDkwlC
 IkpC5OLAvhgreaI4Se6TFlDv3bNLf9W+wtkKI1MQzO1bTLk3q3amgj82WKreq2AU0AtM
 IvpsZS80Wmc83iAG/lYRKGyL4jZPvMd38zPbVBh9OvIXMy/vPuOv6FwJu6h8L9SSFW7F
 mEoyYP/eKDilElChsSXx393uOa5L0Upulo8nh5HPC7OLmNftO1JI/j9xQaThZ/xJBcXD
 AeJ8loP6wVNwVjdZ3vDc/P9l7zg5zumjSSiecYiYBz1QoUb7VRLubuvBkLf/phLKm7ue
 Agkg==
X-Gm-Message-State: AOJu0YybUQhDOyZbTtzS5UuBnP15Yhls6cCWb065G4bvhxP+K4q4ewFg
 n6YB6MS57Opr/SV7v6OTlqmZNmxTHWdWEE7LGAUkvTs1aoySgqiJXcBEgzphoTlOgl8IK6x0ZZg
 4fpEzqE8=
X-Gm-Gg: ATEYQzwqxxHIpYiFCfqdlu2TIfdXpoBSNpr5ymYjG0gfZRrefOkfYCwYMH2VnJQWUiu
 VjzJMboTYu5lK+Sbb6Uyp8b15GGziiDU7E4Aixo3WL9cqyucZpiLsx+TEQ05TxVqYNsgQBfTZ7q
 z5h4dCiVb7LHv9LHdtRWWk0RT4gatPGIizKGT/kGqFO298z+vV+bau2eGa0M9v0xM2HFCXD9/L9
 rsca5b9WuS4p95+2bZMSLT8byUX7MxRvptaXa1VX2XGNugvSDdY931N0DoySQVVsbWcxL1/WTpz
 gCEEc1s15seZs++e7mkusvYZqU9N/GaTYHrFXiZ1t9z/36LFnIDwVGcaaCFkT1paZKa+kRbpTc7
 AzTMBwgdTAMbJf9+JiAdgwahn3c8eGgR30aRg697ugYWDIFKJK29cU5hd92oOsqCjxzVSorhTx1
 264SRqlAXqDp50URxTG1NkBCJAyqfLGrxC/AkBZVENGBc2E6zpkVReDzFfuOykegbNy3WilZzw
X-Received: by 2002:a05:600c:4e49:b0:485:4136:99a8 with SMTP id
 5b1f17b1804b1-486f4441072mr40432815e9.22.1773829892293; 
 Wed, 18 Mar 2026 03:31:32 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4856ea8fad1sm236021045e9.1.2026.03.18.03.31.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 18 Mar 2026 03:31:31 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Weiwei Li <liwei1518@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Warner Losh <imp@bsdimp.com>, =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20P=C3=A9trot?=
 <frederic.petrot@univ-grenoble-alpes.fr>, 
 Vijai Kumar K <vijai@behindbytes.com>, Anton Johansson <anjo@rev.ng>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-riscv@nongnu.org,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-arm@nongnu.org
Subject: [PATCH-for-11.1 01/16] hw/riscv: Mark RISC-V specific peripherals as
 little-endian
Date: Wed, 18 Mar 2026 11:31:06 +0100
Message-ID: <20260318103122.97244-2-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260318103122.97244-1-philmd@linaro.org>
References: <20260318103122.97244-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

These devices are only used by the RISC-V targets, which are
only built as little-endian. Therefore the DEVICE_NATIVE_ENDIAN
definition expand to DEVICE_LITTLE_ENDIAN (besides, the
DEVICE_BIG_ENDIAN case isn't tested). Simplify directly
using DEVICE_LITTLE_ENDIAN.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/char/ibex_uart.c     | 2 +-
 hw/char/shakti_uart.c   | 2 +-
 hw/char/sifive_uart.c   | 2 +-
 hw/misc/sifive_e_aon.c  | 2 +-
 hw/misc/sifive_e_prci.c | 2 +-
 hw/misc/sifive_u_otp.c  | 2 +-
 hw/misc/sifive_u_prci.c | 2 +-
 hw/riscv/riscv-iommu.c  | 2 +-
 hw/sd/cadence_sdhci.c   | 2 +-
 hw/timer/ibex_timer.c   | 2 +-
 hw/timer/sifive_pwm.c   | 2 +-
 11 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/hw/char/ibex_uart.c b/hw/char/ibex_uart.c
index 127d219df3c..26ed1aea140 100644
--- a/hw/char/ibex_uart.c
+++ b/hw/char/ibex_uart.c
@@ -470,7 +470,7 @@ static void fifo_trigger_update(void *opaque)
 static const MemoryRegionOps ibex_uart_ops = {
     .read = ibex_uart_read,
     .write = ibex_uart_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_LITTLE_ENDIAN,
     .impl.min_access_size = 4,
     .impl.max_access_size = 4,
 };
diff --git a/hw/char/shakti_uart.c b/hw/char/shakti_uart.c
index 2d1bc9cb8e2..d38920a03a0 100644
--- a/hw/char/shakti_uart.c
+++ b/hw/char/shakti_uart.c
@@ -103,7 +103,7 @@ static void shakti_uart_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps shakti_uart_ops = {
     .read = shakti_uart_read,
     .write = shakti_uart_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_LITTLE_ENDIAN,
     .impl = {.min_access_size = 1, .max_access_size = 4},
     .valid = {.min_access_size = 1, .max_access_size = 4},
 };
diff --git a/hw/char/sifive_uart.c b/hw/char/sifive_uart.c
index af17cf9a6ce..4e31842df5c 100644
--- a/hw/char/sifive_uart.c
+++ b/hw/char/sifive_uart.c
@@ -206,7 +206,7 @@ static void fifo_trigger_update(void *opaque)
 static const MemoryRegionOps sifive_uart_ops = {
     .read = sifive_uart_read,
     .write = sifive_uart_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_LITTLE_ENDIAN,
     .valid = {
         .min_access_size = 4,
         .max_access_size = 4
diff --git a/hw/misc/sifive_e_aon.c b/hw/misc/sifive_e_aon.c
index e78f4f56725..ff2a7c18235 100644
--- a/hw/misc/sifive_e_aon.c
+++ b/hw/misc/sifive_e_aon.c
@@ -250,7 +250,7 @@ sifive_e_aon_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps sifive_e_aon_ops = {
     .read = sifive_e_aon_read,
     .write = sifive_e_aon_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_LITTLE_ENDIAN,
     .impl = {
         .min_access_size = 4,
         .max_access_size = 4
diff --git a/hw/misc/sifive_e_prci.c b/hw/misc/sifive_e_prci.c
index 400664aabae..a4a60e7b406 100644
--- a/hw/misc/sifive_e_prci.c
+++ b/hw/misc/sifive_e_prci.c
@@ -75,7 +75,7 @@ static void sifive_e_prci_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps sifive_e_prci_ops = {
     .read = sifive_e_prci_read,
     .write = sifive_e_prci_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_LITTLE_ENDIAN,
     .valid = {
         .min_access_size = 4,
         .max_access_size = 4
diff --git a/hw/misc/sifive_u_otp.c b/hw/misc/sifive_u_otp.c
index 7205374bc39..cececd4f7a8 100644
--- a/hw/misc/sifive_u_otp.c
+++ b/hw/misc/sifive_u_otp.c
@@ -187,7 +187,7 @@ static void sifive_u_otp_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps sifive_u_otp_ops = {
     .read = sifive_u_otp_read,
     .write = sifive_u_otp_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_LITTLE_ENDIAN,
     .valid = {
         .min_access_size = 4,
         .max_access_size = 4
diff --git a/hw/misc/sifive_u_prci.c b/hw/misc/sifive_u_prci.c
index f51588623ab..4674d5925ea 100644
--- a/hw/misc/sifive_u_prci.c
+++ b/hw/misc/sifive_u_prci.c
@@ -112,7 +112,7 @@ static void sifive_u_prci_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps sifive_u_prci_ops = {
     .read = sifive_u_prci_read,
     .write = sifive_u_prci_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_LITTLE_ENDIAN,
     .valid = {
         .min_access_size = 4,
         .max_access_size = 4
diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index 98345b1280b..ef5d7df2385 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -2375,7 +2375,7 @@ static MemTxResult riscv_iommu_mmio_read(void *opaque, hwaddr addr,
 static const MemoryRegionOps riscv_iommu_mmio_ops = {
     .read_with_attrs = riscv_iommu_mmio_read,
     .write_with_attrs = riscv_iommu_mmio_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_LITTLE_ENDIAN,
     .impl = {
         .min_access_size = 4,
         .max_access_size = 8,
diff --git a/hw/sd/cadence_sdhci.c b/hw/sd/cadence_sdhci.c
index d576855a1a8..8476baf67fb 100644
--- a/hw/sd/cadence_sdhci.c
+++ b/hw/sd/cadence_sdhci.c
@@ -122,7 +122,7 @@ static void cadence_sdhci_write(void *opaque, hwaddr addr, uint64_t val,
 static const MemoryRegionOps cadence_sdhci_ops = {
     .read = cadence_sdhci_read,
     .write = cadence_sdhci_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_LITTLE_ENDIAN,
     .impl = {
         .min_access_size = 4,
         .max_access_size = 4,
diff --git a/hw/timer/ibex_timer.c b/hw/timer/ibex_timer.c
index ee186521893..0f12531934d 100644
--- a/hw/timer/ibex_timer.c
+++ b/hw/timer/ibex_timer.c
@@ -234,7 +234,7 @@ static void ibex_timer_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps ibex_timer_ops = {
     .read = ibex_timer_read,
     .write = ibex_timer_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_LITTLE_ENDIAN,
     .impl.min_access_size = 4,
     .impl.max_access_size = 4,
 };
diff --git a/hw/timer/sifive_pwm.c b/hw/timer/sifive_pwm.c
index 780eaa50799..4f4f566cd4b 100644
--- a/hw/timer/sifive_pwm.c
+++ b/hw/timer/sifive_pwm.c
@@ -388,7 +388,7 @@ static void sifive_pwm_reset(DeviceState *dev)
 static const MemoryRegionOps sifive_pwm_ops = {
     .read = sifive_pwm_read,
     .write = sifive_pwm_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
 static const VMStateDescription vmstate_sifive_pwm = {
-- 
2.53.0


