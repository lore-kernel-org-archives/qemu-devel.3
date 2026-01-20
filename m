Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 477C3D2628A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Jan 2026 18:41:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viGfQ-0003VK-GB; Tue, 20 Jan 2026 13:41:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1viGfI-0002tS-HA
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 13:41:20 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1viGfG-0006TB-Os
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 13:41:20 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-432d2c7a8b9so4903757f8f.2
 for <qemu-devel@nongnu.org>; Tue, 20 Jan 2026 10:41:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768934477; x=1769539277; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=2cNvAef1f1a86mPi1RwfvIDzIhMfVvuK1vOhyNdPbjk=;
 b=N1CTsVwfZNgn2PjWDC4H8w8orPrrUSIybnNqiSeI9o1MNvArGYTTP78pydO5hCHS98
 8ckuxvEy6FQCvCil8FGBAdiide7G+ZOAB/zvmL7oN8s5/1J4u4BsLDQjLp6g5O+M3s81
 0eP/Z+TV4iR/X96pDuLcilugsvvwyURIn6WaDb2cR6unOZNbFs17a58OnKqx2W64myV3
 Rc82zRTSiJpnYfx/TkTNwNnFxQ/aBFRIHUOTYa10MYfOAJ5G9sNmUloU6qe+2iXV/SSp
 6HSXLyINgn4q0Ili7UjLotdbYMokmyrMiSIkVu+tjfU8Y6uwWCulRZPGmC40TdKgDerB
 YQgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768934477; x=1769539277;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=2cNvAef1f1a86mPi1RwfvIDzIhMfVvuK1vOhyNdPbjk=;
 b=PC/uBvYuxSBc5VkJXu0fEH0F/Ar5Unuvsjsib50Y1r3/6Yq3TyF4H1w5oVS6AQRBpn
 LYemVCQC9X7sIKAsLoLri5iDdhV+2WhB9zo9fzpEPZBbs6b93XhNUDUe40FaY/yEo8Np
 yrI+p2JIlW2yyq1nLViiTNi0Sp1yv945h819JDNsZEN0JFz8Tdqc7GUwygC5T8WLwqmI
 ttPyPPPh6HXtCEV7MTiR7+v0KoP3pMfPqJ/tPjB4+51FMLBmOyLHBitfC2bw1G3s9lkx
 aRjiTkKStQy7BXlQh8OYRs10tpVsuf/PtcyOhPtcv1fdJIvzvZRlTRIVhrYojVJ3SRgM
 6saA==
X-Gm-Message-State: AOJu0Yw2W9jmhPRHGs63C7bTxgZ7h2wFe5MOKGcslkQMd5/L8sjYT2Bh
 yPt+p6u3hZBmbiBExZ2ALagj+V9p3LnpPDpZaZ+s62LAqFHvJp6GprLiPqEhJuqKBDdb6yxSHwa
 4RYQK0NE=
X-Gm-Gg: AZuq6aJmt2vQ+xSPF+ID1BRrY51lIG2dtfIWVhms7nx/+V4g7YkiGxXNuRpaAa071Pt
 heGxyPLozsb26MHDyg1iEyYr1DuZlUFhjA2D+r7kTgqGRKbKNCqZfDtGsa+rYfmyLNkIWTr9sxr
 /AM9s/auiEgG8F+3OSCHsNdtJdhSd/HA2wrPe7Cen4mvH4i+DmTIPH86/CUfYIhp92m5fHTyUnK
 dwPrTSQ9hm9hnjWrALXnf8Dcx/IP/zxI/BizkbDU+CAb5MX/WRg1odNq5vcbqAlLxiqElVurl4K
 CyF5RxZp/fw/KKTo5p/iWWQCxLq1qgIW2hosDziJoGpOTj6aFRXAx6xYj3tdvNGinQKwJH5WIdr
 qoNdDDlG9ptThRGleZUsxLArmW3m0zOCWlWjoBttFhzms6Z6MF8XNByzFq6smEOVGRmb4wSunTR
 oow9AIT6vvXyA1YXqofwW5/oK+a90vY1gFlENH38iCXbx7m6x+vbem/VETOWE9
X-Received: by 2002:a05:6000:2403:b0:42b:3c25:cd06 with SMTP id
 ffacd0b85a97d-4356a039bd5mr19947198f8f.22.1768934476565; 
 Tue, 20 Jan 2026 10:41:16 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4356992c6f2sm30014190f8f.19.2026.01.20.10.41.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 20 Jan 2026 10:41:15 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 19/29] hw/sd/sdhci: Remove endianness property
Date: Tue, 20 Jan 2026 19:38:52 +0100
Message-ID: <20260120183902.73845-20-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260120183902.73845-1-philmd@linaro.org>
References: <20260120183902.73845-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

From: Bernhard Beschow <shentey@gmail.com>

The endianness property was only explicitly set in the e500 machine which
now instantiates TYPE_FSL_ESDHC_BE. The property could also not be used
meaningfully in a hypothetical, common TYPE_FSL_ESDHC device model since
sdhci_common_realize() would fail in that case or it would need to know
all MMIO implementations upfront. Remove the property in favor of dedicated
device models.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: BALATON Zoltan <balaton@eik.bme.hu>
Message-ID: <20260112145418.220506-12-shentey@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sdhci-internal.h |  1 -
 include/hw/sd/sdhci.h  |  1 -
 hw/sd/sdhci.c          | 35 ++---------------------------------
 3 files changed, 2 insertions(+), 35 deletions(-)

diff --git a/hw/sd/sdhci-internal.h b/hw/sd/sdhci-internal.h
index f24532eed28..50fb746a177 100644
--- a/hw/sd/sdhci-internal.h
+++ b/hw/sd/sdhci-internal.h
@@ -307,7 +307,6 @@ extern const VMStateDescription sdhci_vmstate;
 #define SDHC_CAPAB_REG_DEFAULT 0x057834b4
 
 #define DEFINE_SDHCI_COMMON_PROPERTIES(_state) \
-    DEFINE_PROP_UINT8("endianness", _state, endianness, DEVICE_LITTLE_ENDIAN), \
     DEFINE_PROP_UINT8("sd-spec-version", _state, sd_spec_version, 2), \
     DEFINE_PROP_UINT8("uhs", _state, uhs_mode, UHS_NOT_SUPPORTED), \
     DEFINE_PROP_UINT8("vendor", _state, vendor, SDHCI_VENDOR_NONE), \
diff --git a/include/hw/sd/sdhci.h b/include/hw/sd/sdhci.h
index 32c52c7d0be..51551348cf5 100644
--- a/include/hw/sd/sdhci.h
+++ b/include/hw/sd/sdhci.h
@@ -96,7 +96,6 @@ struct SDHCIState {
     /* Configurable properties */
     bool pending_insert_quirk; /* Quirk for Raspberry Pi card insert int */
     uint32_t quirks;
-    uint8_t endianness;
     uint8_t sd_spec_version;
     uint8_t uhs_mode;
     uint8_t vendor;        /* For vendor specific functionality */
diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 6001b71c61d..eab814096d7 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -1374,7 +1374,7 @@ sdhci_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
                        value >> shift, value >> shift);
 }
 
-static const MemoryRegionOps sdhci_mmio_le_ops = {
+static const MemoryRegionOps sdhci_mmio_ops = {
     .read = sdhci_read,
     .write = sdhci_write,
     .valid = {
@@ -1385,21 +1385,6 @@ static const MemoryRegionOps sdhci_mmio_le_ops = {
     .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
-static const MemoryRegionOps sdhci_mmio_be_ops = {
-    .read = sdhci_read,
-    .write = sdhci_write,
-    .impl = {
-        .min_access_size = 4,
-        .max_access_size = 4,
-    },
-    .valid = {
-        .min_access_size = 1,
-        .max_access_size = 4,
-        .unaligned = false
-    },
-    .endianness = DEVICE_BIG_ENDIAN,
-};
-
 static void sdhci_init_readonly_registers(SDHCIState *s, Error **errp)
 {
     ERRP_GUARD();
@@ -1430,7 +1415,7 @@ void sdhci_initfn(SDHCIState *s)
     s->transfer_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
                                      sdhci_data_transfer, s);
 
-    s->io_ops = &sdhci_mmio_le_ops;
+    s->io_ops = &sdhci_mmio_ops;
 }
 
 void sdhci_uninitfn(SDHCIState *s)
@@ -1446,22 +1431,6 @@ void sdhci_common_realize(SDHCIState *s, Error **errp)
 {
     ERRP_GUARD();
 
-    switch (s->endianness) {
-    case DEVICE_LITTLE_ENDIAN:
-        /* s->io_ops is little endian by default */
-        break;
-    case DEVICE_BIG_ENDIAN:
-        if (s->io_ops != &sdhci_mmio_le_ops) {
-            error_setg(errp, "SD controller doesn't support big endianness");
-            return;
-        }
-        s->io_ops = &sdhci_mmio_be_ops;
-        break;
-    default:
-        error_setg(errp, "Incorrect endianness");
-        return;
-    }
-
     sdhci_init_readonly_registers(s, errp);
     if (*errp) {
         return;
-- 
2.52.0


