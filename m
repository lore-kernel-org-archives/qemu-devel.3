Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C113C2BD09
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 15:28:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRCkw-0002Pg-Mw; Tue, 09 Jul 2024 11:27:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sRCko-0001ln-1V
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 11:27:42 -0400
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sRCkm-0006V7-3C
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 11:27:41 -0400
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-52eafa1717bso2595561e87.2
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2024 08:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720538858; x=1721143658; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+txOcp3qn5aM6X855Qa2b4pW5/3CYGUDetUe05A68E4=;
 b=kIaWSKI27ipfN2ZrRUnpzR1uxBX14Z8BHEVcoaMRaYzrMps/+T1htjYW5e8VNv2Isv
 0+j/QsuYxg7b8lypSURktaZNCm8QuPsy6adp3WaZ2FlkdzfafFfse7j2YMcVspcqQeTb
 InzMvwrSF0pId9D+rQkYIoZrRnyRAGO7Ew9rB7CVCqfaztoeTNna+inpwUSll6zyKeJM
 hPCsKDbd1szPTSqHHtU0L8kjV7Zf3JB9a2hWIEH/w++dgcjWehusXlhvpULtTCd+xA3D
 AyKCPNY0YXViYM/Hfeiizmvf8S2eLxKN3J4jzAY2xDGw3C7jPc7seChympz+9taebe0o
 89Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720538858; x=1721143658;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+txOcp3qn5aM6X855Qa2b4pW5/3CYGUDetUe05A68E4=;
 b=SVnxI0Od2jcjsIYfpM1jJiM/WcNUjvZ+qOuMPc5scJzam/tnZopmOCE4YXZqBFLDAZ
 MLaeWENSOBR8WkmBLu6XRdPLnhSTKRsGJFJtfyIAsvSGSze2klvWObIJf5ETjqU4AiqT
 Ro+FtUnxPuunnUPXvIZp8ltLy8Nrntlz/1AS9UXTR6xhvvLldVO96yYeNqhjFZn+Xg6A
 CkkZJtA/o6pYhhfPlgWke9Y9cTGpY89iiT272syfqju9NnOwar7v4psqtQ1fG5f0V/GC
 5oSwFoUbKBCju3Kzb63PYpH2wWD2jDLR/S0XDVVqEK/PK4av31rbuvWBR052dUkXxBHb
 ikyg==
X-Gm-Message-State: AOJu0YyhoqzRVzXNwp2BNlprLEE5GyF1nTUK9EyUmf/OkV/yID7UrXGx
 OlwZxjUJI/VBzRnsUN2/1Hp25t6tJd6cTi6dubvnF38jvIZAhOp9lM9C1/pENjf6hlKPAUQjMP4
 F
X-Google-Smtp-Source: AGHT+IEf00K8vhjAGgLsRefidZ9SjQ3R1skJlfVo6uaBUHnnGjKeaIXVIyUq5rnhSpgFzsgMR00CFQ==
X-Received: by 2002:a2e:9495:0:b0:2ee:7b7d:66df with SMTP id
 38308e7fff4ca-2eeb30ba26amr17868591fa.9.1720538857887; 
 Tue, 09 Jul 2024 08:27:37 -0700 (PDT)
Received: from m1x-phil.lan (vau06-h02-176-184-43-20.dsl.sta.abo.bbox.fr.
 [176.184.43.20]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-367cde891a3sm2840837f8f.61.2024.07.09.08.27.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 09 Jul 2024 08:27:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, qemu-block@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Bin Meng <bmeng.cn@gmail.com>, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>
Subject: [Aspeed PATCH v47 16/19] hw/sd/sdcard: Support boot area in emmc image
Date: Tue,  9 Jul 2024 17:25:53 +0200
Message-ID: <20240709152556.52896-17-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240709152556.52896-1-philmd@linaro.org>
References: <20240709152556.52896-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::135;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x135.google.com
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
TODO: Update QEMU command in description
---
 include/hw/sd/sd.h |  1 +
 hw/sd/sd.c         | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+)

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
index c7f8ea11c1..5830725629 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -774,6 +774,13 @@ static uint32_t sd_blk_len(SDState *sd)
     return sd->blk_len;
 }
 
+static uint32_t sd_bootpart_offset(SDState *sd)
+{
+    SDCardClass *sc = SDMMC_COMMON_GET_CLASS(sd);
+
+    return sc->bootpart_offset ? sc->bootpart_offset(sd) : 0;
+}
+
 static uint64_t sd_req_get_address(SDState *sd, SDRequest req)
 {
     uint64_t addr;
@@ -1026,9 +1033,33 @@ void sd_set_cb(SDState *sd, qemu_irq readonly, qemu_irq insert)
     qemu_set_irq(insert, sd->blk ? blk_is_inserted(sd->blk) : 0);
 }
 
+/*
+ * This requires a disk image that has two boot partitions inserted at the
+ * beginning of it. The size of the boot partitions are configured in the
+ * ext_csd structure, which is hardcoded in qemu. They are currently set to
+ * 1MB each.
+ */
+static uint32_t emmc_bootpart_offset(SDState *sd)
+{
+    unsigned int access = sd->ext_csd[EXT_CSD_PART_CONFIG]
+                          & EXT_CSD_PART_CONFIG_ACC_MASK;
+
+    switch (access) {
+    case EXT_CSD_PART_CONFIG_ACC_DEFAULT:
+        return sd->boot_part_size * 2;
+    case EXT_CSD_PART_CONFIG_ACC_BOOT0:
+        return 0;
+    case EXT_CSD_PART_CONFIG_ACC_BOOT0 + 1:
+        return sd->boot_part_size * 1;
+    default:
+         g_assert_not_reached();
+    }
+}
+
 static void sd_blk_read(SDState *sd, uint64_t addr, uint32_t len)
 {
     trace_sdcard_read_block(addr, len);
+    addr += sd_bootpart_offset(sd);
     if (!sd->blk || blk_pread(sd->blk, addr, len, sd->data, 0) < 0) {
         fprintf(stderr, "sd_blk_read: read error on host side\n");
     }
@@ -1037,6 +1068,7 @@ static void sd_blk_read(SDState *sd, uint64_t addr, uint32_t len)
 static void sd_blk_write(SDState *sd, uint64_t addr, uint32_t len)
 {
     trace_sdcard_write_block(addr, len);
+    addr += sd_bootpart_offset(sd);
     if (!sd->blk || blk_pwrite(sd->blk, addr, len, sd->data, 0) < 0) {
         fprintf(stderr, "sd_blk_write: write error on host side\n");
     }
@@ -2871,6 +2903,7 @@ static void emmc_class_init(ObjectClass *klass, void *data)
 
     sc->set_cid = emmc_set_cid;
     sc->set_csd = emmc_set_csd;
+    sc->bootpart_offset = emmc_bootpart_offset;
 }
 
 static const TypeInfo sd_types[] = {
-- 
2.41.0


