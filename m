Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9581DC41513
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 07:15:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN5lq-0004DF-09; Fri, 28 Jun 2024 03:11:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5lj-0003x0-9N
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:11:39 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5le-0004xh-PA
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:11:36 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4248ea53493so1787455e9.3
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 00:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719558692; x=1720163492; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=cc2phwHICPbHNDUMxZA6a+9UcWAynLl1hqKHKReAlY0=;
 b=Szb2It4pksVK/1SYB6AxRhN1oymqeuzwCqLIBfqZxi8eUCdWF+FAQTBwnUgRKIxGKC
 cNdH3/dxx0wrRnajRfdAJ1W4JVp734Qu9LB0UcZiLsfmolucVdkWM6Yv4Ash2QM8Bsfj
 DG4P4EG/mLIKMQ5FjOgV5sPUAh31+t9IBJxrNBqTNkGFhjf2dRbwiDYHFhm4rkxM8plI
 OnEfoHdmRb3KbmmOTPhHNv91lVNtINodMg4K6G5ivUdAhg6hU0BQiP+lyMx3rz3E0Jbo
 rWP32HVUr2p2/Zfix0rtOqrpNpXDsosI9PFPQ3i0m7qpdE7Rvz4CXgGnNbmCjZRLbIc2
 zn9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719558692; x=1720163492;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cc2phwHICPbHNDUMxZA6a+9UcWAynLl1hqKHKReAlY0=;
 b=NjrUivHNw4aVSCRe8irlxysUhvLEA9MFiYpx757zZlWiFh6P7F2DlOqPP1RMGniCSA
 LlkyW55gQwzlajUhBe5SKr442TOL9YM3H4aphGQUnZarOX9VWRsj7zlqVCENp4/LsDbx
 b9eUV+fMnloaMInt3BbbSwtNX0CYRBRZesPGNxe3kj0hZQa0gHWTG3K/XHG4L+4NrtEO
 G0ez8+jbAfkG8ttyUr7DBQJmy1L+q/+O3VR/HxwlH9Nw293acUYTjwQ/ByDYgccN6Dbc
 0N3klRONLgnvRlEq4doTc54hIbHphRpxSSDrcoJcESoSBY+VOxCDsVnjqi9Znb7TQIpx
 GseA==
X-Gm-Message-State: AOJu0YyyS81o0Jj3fSBNHOlzvTCBJAPuC0ohaT5iEU1pgocgicynLb6H
 GqMCDo2Gr/h+XOLyAypP5GwuaC5VWDi+TW+t9xtgSdQyVLfeZIaAQCs9CeepQ/YfD6mfGb6Brs8
 d40Q=
X-Google-Smtp-Source: AGHT+IHRznLxNvZlJvM5i3RYv1l/et1Jz+rZKnzzAVYZZn679jMEi/FugLM+rpVZ2IZRQGDWHqYqDA==
X-Received: by 2002:a05:600c:470d:b0:422:7eca:db41 with SMTP id
 5b1f17b1804b1-4248cc18101mr123694015e9.2.1719558692742; 
 Fri, 28 Jun 2024 00:11:32 -0700 (PDT)
Received: from m1x-phil.lan (cho94-h02-176-184-4-239.dsl.sta.abo.bbox.fr.
 [176.184.4.239]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a0e16a8sm1343948f8f.64.2024.06.28.00.11.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 28 Jun 2024 00:11:31 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [RFC PATCH v42 96/98] hw/sd/sdcard: Support boot area in emmc image
Date: Fri, 28 Jun 2024 09:02:12 +0200
Message-ID: <20240628070216.92609-97-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240628070216.92609-1-philmd@linaro.org>
References: <20240628070216.92609-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

From: Joel Stanley <joel@jms.id.au>

This assumes a specially constructed image:

  dd if=/dev/zero of=mmc-bootarea.img count=2 bs=1M
  dd if=u-boot-spl.bin of=mmc-bootarea.img conv=notrunc
  dd if=u-boot.bin of=mmc-bootarea.img conv=notrunc count=64 bs=1K
  cat mmc-bootarea.img obmc-phosphor-image.wic > mmc.img
  truncate --size 16GB mmc.img
  truncate --size 128MB mmc-bootarea.img

For now this still requires a mtd image to load the SPL:

  qemu-system-arm -M tacoma-bmc -nographic \
   -global driver=sd-card,property=emmc,value=true \
   -drive file=mmc.img,if=sd,index=2 \
   -drive file=mmc-bootarea.img,if=mtd,format=raw

Signed-off-by: Joel Stanley <joel@jms.id.au>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/sd/sd.h |  1 +
 hw/sd/sd.c         | 39 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/include/hw/sd/sd.h b/include/hw/sd/sd.h
index d35a839f5e..07435d2e17 100644
--- a/include/hw/sd/sd.h
+++ b/include/hw/sd/sd.h
@@ -132,6 +132,7 @@ struct SDCardClass {
     bool (*get_readonly)(SDState *sd);
     void (*set_cid)(SDState *sd);
     void (*set_csd)(SDState *sd, uint64_t size);
+    uint32_t (*bootpart_offset)(SDState *sd);
 
     const struct SDProto *proto;
 };
diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index e7d8b9c0fb..2d49be61f6 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -783,6 +783,12 @@ static inline uint64_t sd_addr_to_wpnum(uint64_t addr)
     return addr >> (HWBLOCK_SHIFT + SECTOR_SHIFT + WPGROUP_SHIFT);
 }
 
+
+static unsigned sd_boot_capacity_bytes(SDState *sd)
+{
+    return sd->ext_csd[EXT_CSD_BOOT_MULT] << 17;
+}
+
 static void sd_reset(DeviceState *dev)
 {
     SDState *sd = SD_CARD(dev);
@@ -984,9 +990,40 @@ void sd_set_cb(SDState *sd, qemu_irq readonly, qemu_irq insert)
     qemu_set_irq(insert, sd->blk ? blk_is_inserted(sd->blk) : 0);
 }
 
+/*
+ * This requires a disk image that has two boot partitions inserted at the
+ * beginning of it. The size of the boot partitions are configured in the
+ * ext_csd structure, which is hardcoded in qemu. They are currently set to
+ * 1MB each.
+ */
+static uint32_t sd_emmc_bootpart_offset(SDState *sd)
+{
+    unsigned int access = sd->ext_csd[EXT_CSD_PART_CONFIG] &
+        EXT_CSD_PART_CONFIG_ACC_MASK;
+    unsigned int boot_capacity = sd_boot_capacity_bytes(sd);
+
+    switch (access) {
+    case EXT_CSD_PART_CONFIG_ACC_DEFAULT:
+        return boot_capacity * 2;
+    case EXT_CSD_PART_CONFIG_ACC_BOOT0:
+        return 0;
+    case EXT_CSD_PART_CONFIG_ACC_BOOT0 + 1:
+        return boot_capacity * 1;
+    default:
+         g_assert_not_reached();
+    }
+}
+
+static uint32_t sd_bootpart_offset(SDState *sd)
+{
+    SDCardClass *sc = SD_CARD_GET_CLASS(sd);
+    return sc->bootpart_offset ? sc->bootpart_offset(sd) : 0;
+}
+
 static void sd_blk_read(SDState *sd, uint64_t addr, uint32_t len)
 {
     trace_sdcard_read_block(addr, len);
+    addr += sd_bootpart_offset(sd);
     if (!sd->blk || blk_pread(sd->blk, addr, len, sd->data, 0) < 0) {
         fprintf(stderr, "sd_blk_read: read error on host side\n");
     }
@@ -995,6 +1032,7 @@ static void sd_blk_read(SDState *sd, uint64_t addr, uint32_t len)
 static void sd_blk_write(SDState *sd, uint64_t addr, uint32_t len)
 {
     trace_sdcard_write_block(addr, len);
+    addr += sd_bootpart_offset(sd);
     if (!sd->blk || blk_pwrite(sd->blk, addr, len, sd->data, 0) < 0) {
         fprintf(stderr, "sd_blk_write: write error on host side\n");
     }
@@ -2833,6 +2871,7 @@ static void emmc_class_init(ObjectClass *klass, void *data)
     dc->realize = emmc_realize;
     sc->proto = &sd_proto_emmc;
     sc->set_csd = sd_emmc_set_csd;
+    sc->bootpart_offset = sd_emmc_bootpart_offset;
 }
 
 static const TypeInfo sd_types[] = {
-- 
2.41.0


