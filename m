Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11E27CCA470
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 14:19:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v68QN-0005nx-JY; Tue, 07 Oct 2025 10:12:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v68QJ-0005lJ-1X
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 10:12:16 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v68Q5-0002DG-JV
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 10:12:14 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3ee64bc6b85so4910922f8f.3
 for <qemu-devel@nongnu.org>; Tue, 07 Oct 2025 07:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759846316; x=1760451116; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ZqArHpI2jlih5+RRdAFUdHG4iZfC1IUazxJB3VjKmJ8=;
 b=WNUfHiQCaBGjZKTLFpvaHWHvav4LV1HHiZUOpkzykq6aQA/T7HTGQ4/e2CvtQtNCrk
 rIp47mwinPBEhHf+9K0q9rHO46NVQeeiAEibvIE2JPKm6WhaXb1eBWfVmHmh1gJ/mj3p
 LdAvNymJR1pYrIfcgSR3Fwf73tqyuBCsuYlZhsW5e6B6W+r5/MaAJaaInXUIUHVL1A1U
 FC+os9e46OJfSwT3HdEMlnmc8TN6crc3EPxgBIJTYlXHYSsy3UGzxhL999zE/wJHjnhU
 DK32NDzQQozlksws05qcij+1oP3sR28Yhz4elnn5ViczSwohrlNPXBODwtrRb0Cx/pQX
 I8Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759846316; x=1760451116;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZqArHpI2jlih5+RRdAFUdHG4iZfC1IUazxJB3VjKmJ8=;
 b=bZVaLdyu5tZc28aqL02eH52ytUFNZxT3QcP+4d+X2/zedmVKv731XEttyBdGqTGnWq
 C1j2oBF83iMO9xgCWvuXbOcmjKBNb2+wCNdXyuIzDg+l5ZSGxiKQA/mvgCQOnYi4k2TC
 LdraYfQatUbxJJXnBjmtBbUf8gCuYipR0nHLd+w22B4DNgb1xPa3WJP8wK2vXVdXUr1L
 oq8txsRqqUZq8Dky286jgDslP0/y7jZPnkuvN01bhtv4/EUmJUo8U5FcyJ0d1MqYw7l5
 BHaSw17TgEUagysUNtWVG3rM6MU1OnXjA3w2Z8fxNZbabJiMnnGdgPC/rJXlh0FqX0vT
 pAFw==
X-Gm-Message-State: AOJu0YwdHrg+WwnawR08n6j9vQN3uWBhrnyNllfAlCW54KeeqLGOCeL9
 csfdniDUGSXZ59vqANhh+YcEZSkUbMiJBGj0nrzbP3m0YaWvC2q+SKlp9IYkD1xnLHLqxANv34t
 KFb2r
X-Gm-Gg: ASbGncsOWoOtd++iJ/NLOAExBTGqSKsnf3Y+y7SLhAfl9yAzat6FZmiNGyFnKm9LjnO
 W+l34Wh1DnA/2pOtx2Or+Y2Vp7cOv4tE+WsS3VdA8Tpp8WHfyq2ASTCuYThFYWwzRRWMK16bCRM
 5WTdXMAK936zYxsqa4u6yCGO0JM0O12cjUrPsxK/i7CVaauZrOFlG0Aut7LK6aQrLPzDXq3mytl
 aHzuZx5RVzAfk8Y0w9qsQeD77n0uRN3i2FZLV2q3bkS0g7lzuKZXYa/2YsrO0NyV2lAQj6KjcZ1
 Pk41emhaN6BCkrTlDOQO+iYjgTXQuZV69wYoEwKcaIt2p91IvEImCDPxJbOVESiZM0kiE7LSQtW
 6yUmOqRMfXavEKFXdjnMYZ6MGNMNah++0qc8tVM9myp3Ku1siod7rk5cEHhhYgrdvbwQ=
X-Google-Smtp-Source: AGHT+IEQfU6aR2lZ8Uk9ilGj8wDMjctSb03+kgKtIs7zQRsuEHxqn82ykIDR/aJAEMuQ/lgh40fLRA==
X-Received: by 2002:a05:6000:43cc:20b0:425:72a0:a998 with SMTP id
 ffacd0b85a97d-42572a0ae52mr5726270f8f.6.1759846315582; 
 Tue, 07 Oct 2025 07:11:55 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e78c5d290sm167037135e9.0.2025.10.07.07.11.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Oct 2025 07:11:54 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 28/62] hw/arm/xlnx-versal: ocm: refactor creation
Date: Tue,  7 Oct 2025 15:10:48 +0100
Message-ID: <20251007141123.3239867-29-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251007141123.3239867-1-peter.maydell@linaro.org>
References: <20251007141123.3239867-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x434.google.com
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

From: Luc Michel <luc.michel@amd.com>

Refactor the OCM creation using the VersalMap structure.

Signed-off-by: Luc Michel <luc.michel@amd.com>
Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20250926070806.292065-28-luc.michel@amd.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/xlnx-versal.h |  4 ----
 hw/arm/xlnx-versal.c         | 20 ++++++++++++++++----
 2 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/include/hw/arm/xlnx-versal.h b/include/hw/arm/xlnx-versal.h
index 0a91ec7ae36..e1d6e545495 100644
--- a/include/hw/arm/xlnx-versal.h
+++ b/include/hw/arm/xlnx-versal.h
@@ -48,10 +48,6 @@ struct Versal {
         MemoryRegion mr_ddr_ranges[4];
     } noc;
 
-    struct {
-        MemoryRegion mr_ocm;
-    } lpd;
-
     struct {
         uint32_t clk_25mhz;
         uint32_t clk_125mhz;
diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
index e89c66313c1..8aa82ceb839 100644
--- a/hw/arm/xlnx-versal.c
+++ b/hw/arm/xlnx-versal.c
@@ -73,6 +73,11 @@ typedef struct VersalSimplePeriphMap {
     int irq;
 } VersalSimplePeriphMap;
 
+typedef struct VersalMemMap {
+    uint64_t addr;
+    uint64_t size;
+} VersalMemMap;
+
 typedef struct VersalGicMap {
     int version;
     uint64_t dist;
@@ -108,6 +113,8 @@ typedef struct VersalCpuClusterMap {
 } VersalCpuClusterMap;
 
 typedef struct VersalMap {
+    VersalMemMap ocm;
+
     VersalCpuClusterMap apu;
     VersalCpuClusterMap rpu;
 
@@ -207,6 +214,11 @@ typedef struct VersalMap {
 } VersalMap;
 
 static const VersalMap VERSAL_MAP = {
+    .ocm = {
+        .addr = 0xfffc0000,
+        .size = 0x40000,
+    },
+
     .apu = {
         .name = "apu",
         .cpu_model = ARM_CPU_TYPE_NAME("cortex-a72"),
@@ -1608,6 +1620,7 @@ static void versal_realize(DeviceState *dev, Error **errp)
 {
     Versal *s = XLNX_VERSAL_BASE(dev);
     DeviceState *slcr, *ospi;
+    MemoryRegion *ocm;
     Object *container;
     const VersalMap *map = versal_get_map(s);
     size_t i;
@@ -1683,10 +1696,9 @@ static void versal_realize(DeviceState *dev, Error **errp)
     versal_unimp(s);
 
     /* Create the On Chip Memory (OCM).  */
-    memory_region_init_ram(&s->lpd.mr_ocm, OBJECT(s), "ocm",
-                           MM_OCM_SIZE, &error_fatal);
-
-    memory_region_add_subregion_overlap(&s->mr_ps, MM_OCM, &s->lpd.mr_ocm, 0);
+    ocm = g_new(MemoryRegion, 1);
+    memory_region_init_ram(ocm, OBJECT(s), "ocm", map->ocm.size, &error_fatal);
+    memory_region_add_subregion_overlap(&s->mr_ps, map->ocm.addr, ocm, 0);
 }
 
 DeviceState *versal_get_boot_cpu(Versal *s)
-- 
2.43.0


