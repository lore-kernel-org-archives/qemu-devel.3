Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE654C3DA41
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 15:27:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRCkS-0007bF-Uu; Tue, 09 Jul 2024 11:27:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sRCkR-0007Qr-8E
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 11:27:19 -0400
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sRCkO-0006O7-Fv
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 11:27:18 -0400
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-52eafa1717bso2595088e87.2
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2024 08:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720538834; x=1721143634; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W7BjhCdKxXxM0Spf2aaSee+AlxJ5nkV7EMWxkmbyq9c=;
 b=KH5yDK8P4TtEwzPeQg1xdJ15AtIvVWK2QpUHpoKXViQ1qNr4r5TRGGhnCFFR2aC2qU
 YzbnXbWokvz9AXx9WXnzxNI2TgUm9QLAjvh5HBduMXpONGISVsJKQGsFBcUTGvRtoSUt
 cmKztsPpMJnKmULfFO8tLxAK9xCRW7JUPkRj/CzPmNtZTQvs8idAs2/IpjJ5jDhZ06CA
 5R+V6iJo2gaq4TzOCo02z6ABKt1sPn+5PoFRthjaZKybV3jq0bu1kzqEbDnx3cO9//IL
 S1MasNQKb9MuYN2OWcTk2kxrCqMSljJBSQXTRbdXHcGfTXb7tii5AeUG0mR/TQLareD0
 IpLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720538834; x=1721143634;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W7BjhCdKxXxM0Spf2aaSee+AlxJ5nkV7EMWxkmbyq9c=;
 b=QHPsLgyFJstP6x2NxCQPVs6LrMaYZ5X6JUljVAM/WieXKd18rH+3nYquRdIX3seY1/
 hBejY/jkPZXajF+8IzAvOoynk1MBczQT9ZFP6I58OaUUPU0ql22em2wXfvk934c/A7N3
 EhulL98T2dL/GA3HNRKvtSuVT3aKOu60sX7p7w2XgDFr4hVMP5Xh9OqnFK2gCe3ddOZ/
 C5aL/fdAltJDu549ulL26+93NNUt7N8YaAl00VQ3pUBHePOc/VcaCOK6P/e1FXbtKzGR
 vhViHQe4Fx9LGuKPvFiE6DmB5+JSlobZkIoO5qGJ8WiJIqx9PnH3rAPFSlRElLqwt1wN
 dU+A==
X-Gm-Message-State: AOJu0Yyg3KC9zr3G6CNzFFV/6MpBdYhBuuilKhM2+xhDmR2+FdOG0fLc
 IMJPasuhyoiB1yzkESDbv8MLq02b2+4ApCY0LC4ZUrLX3L0nhZeSKvEKPTHkS77rqq2Yix030tU
 P
X-Google-Smtp-Source: AGHT+IG2JdSJwJpl6rQjS4UrGHmRlkAZPwbxo01ivO7OMi3t1029qfANIs7r9YNAE/YSMA0eqCU3Kg==
X-Received: by 2002:a05:651c:198b:b0:2ed:5c34:4082 with SMTP id
 38308e7fff4ca-2eeb30ba0abmr27934141fa.8.1720538834345; 
 Tue, 09 Jul 2024 08:27:14 -0700 (PDT)
Received: from m1x-phil.lan (vau06-h02-176-184-43-20.dsl.sta.abo.bbox.fr.
 [176.184.43.20]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4264a2fc9desm215676235e9.45.2024.07.09.08.27.12
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 09 Jul 2024 08:27:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, qemu-block@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Bin Meng <bmeng.cn@gmail.com>, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>
Subject: [PATCH v47 12/19] hw/sd/sdcard: Simplify EXT_CSD values for spec v4.3
Date: Tue,  9 Jul 2024 17:25:49 +0200
Message-ID: <20240709152556.52896-13-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240709152556.52896-1-philmd@linaro.org>
References: <20240709152556.52896-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x133.google.com
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

- Set some keys to not defined / implemented:
  . EXT_CSD_HPI_FEATURES
  . EXT_CSD_BKOPS_SUPPORT
  . EXT_CSD_SEC_FEATURE_SUPPORT
  . EXT_CSD_ERASE_TIMEOUT_MULT
  . EXT_CSD_PART_SWITCH_TIME
  . EXT_CSD_OUT_OF_INTERRUPT_TIME

- Simplify:
  . EXT_CSD_ACC_SIZE (6 -> 1)
      16KB of super_page_size -> 512B (BDRV_SECTOR_SIZE)
  . EXT_CSD_HC_ERASE_GRP_SIZE (4 -> 1)
  . EXT_CSD_HC_WP_GRP_SIZE (4 -> 1)
  . EXT_CSD_S_C_VCC[Q] (8 -> 1)
  . EXT_CSD_S_A_TIMEOUT (17 -> 1)
  . EXT_CSD_CARD_TYPE (7 -> 3)
      Dual data rate -> High-Speed mode

- Update:
  . EXT_CSD_CARD_TYPE (7 -> 3)
      High-Speed MultiMediaCard @ 26MHz & 52MHz
  . Performances (0xa -> 0x46)
      Class B at 3MB/s. -> Class J at 21MB/s
  . EXT_CSD_REV (5 -> 3)
      Rev 1.5 (spec v4.41) -> Rev 1.3 (spec v4.3)

- Use load/store API to set EXT_CSD_SEC_CNT

- Remove R/W keys, normally zeroed at reset
  . EXT_CSD_BOOT_INFO

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sd.c | 50 ++++++++++++++++++--------------------------------
 1 file changed, 18 insertions(+), 32 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index df0e2345c0..2a687977d1 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -484,43 +484,29 @@ static void mmc_set_ext_csd(SDState *sd, uint64_t size)
 
     memset(sd->ext_csd, 0, sizeof(sd->ext_csd));
 
+    /* Properties segment (RO) */
     sd->ext_csd[EXT_CSD_S_CMD_SET] = 0b1; /* supported command sets */
-    sd->ext_csd[EXT_CSD_HPI_FEATURES] = 0x3; /* HPI features  */
-    sd->ext_csd[EXT_CSD_BKOPS_SUPPORT] = 0x1; /* Background operations */
-    sd->ext_csd[241] = 0xA; /* 1st initialization time after partitioning */
-    sd->ext_csd[EXT_CSD_TRIM_MULT] = 0x1; /* Trim multiplier */
-    sd->ext_csd[EXT_CSD_SEC_FEATURE_SUPPORT] = 0x15; /* Secure feature */
-    sd->ext_csd[EXT_CSD_BOOT_INFO] = 0x7; /* Boot information */
+    sd->ext_csd[EXT_CSD_BOOT_INFO] = 0x0; /* Boot information */
                                      /* Boot partition size. 128KB unit */
     sd->ext_csd[EXT_CSD_BOOT_MULT] = sd->boot_part_size / (128 * KiB);
-    sd->ext_csd[EXT_CSD_ACC_SIZE] = 0x6; /* Access size */
-    sd->ext_csd[EXT_CSD_HC_ERASE_GRP_SIZE] = 0x4; /* HC Erase unit size */
+    sd->ext_csd[EXT_CSD_ACC_SIZE] = 0x1; /* Access size */
+    sd->ext_csd[EXT_CSD_HC_ERASE_GRP_SIZE] = 0x01; /* HC Erase unit size */
     sd->ext_csd[EXT_CSD_ERASE_TIMEOUT_MULT] = 0x01; /* HC erase timeout */
     sd->ext_csd[EXT_CSD_REL_WR_SEC_C] = 0x1; /* Reliable write sector count */
-    sd->ext_csd[EXT_CSD_HC_WP_GRP_SIZE] = 0x4; /* HC write protect group size */
-    sd->ext_csd[EXT_CSD_S_C_VCC] = 0x8; /* Sleep current VCC  */
-    sd->ext_csd[EXT_CSD_S_C_VCCQ] = 0x7; /* Sleep current VCCQ */
-    sd->ext_csd[EXT_CSD_S_A_TIMEOUT] = 0x11; /* Sleep/Awake timeout */
-    sd->ext_csd[215] = (sectcount >> 24) & 0xff; /* Sector count */
-    sd->ext_csd[214] = (sectcount >> 16) & 0xff; /* ... */
-    sd->ext_csd[213] = (sectcount >> 8) & 0xff;  /* ... */
-    sd->ext_csd[EXT_CSD_SEC_CNT] = (sectcount & 0xff);       /* ... */
-    sd->ext_csd[210] = 0xa; /* Min write perf for 8bit@52Mhz */
-    sd->ext_csd[209] = 0xa; /* Min read perf for 8bit@52Mhz  */
-    sd->ext_csd[208] = 0xa; /* Min write perf for 4bit@52Mhz */
-    sd->ext_csd[207] = 0xa; /* Min read perf for 4bit@52Mhz */
-    sd->ext_csd[206] = 0xa; /* Min write perf for 4bit@26Mhz */
-    sd->ext_csd[205] = 0xa; /* Min read perf for 4bit@26Mhz */
-    sd->ext_csd[EXT_CSD_PART_SWITCH_TIME] = 0x1;
-    sd->ext_csd[EXT_CSD_OUT_OF_INTERRUPT_TIME] = 0x1;
-    sd->ext_csd[EXT_CSD_CARD_TYPE] = 0x7;
-    sd->ext_csd[EXT_CSD_STRUCTURE] = 0x2;
-    sd->ext_csd[EXT_CSD_REV] = 0x5;
-    sd->ext_csd[EXT_CSD_RPMB_MULT] = 0x1; /* RPMB size */
-    sd->ext_csd[EXT_CSD_PARTITION_SUPPORT] = 0x3;
-    sd->ext_csd[159] = 0x00; /* Max enhanced area size */
-    sd->ext_csd[158] = 0x00; /* ... */
-    sd->ext_csd[157] = 0xEC; /* ... */
+    sd->ext_csd[EXT_CSD_HC_WP_GRP_SIZE] = 0x01; /* HC write protect group size */
+    sd->ext_csd[EXT_CSD_S_C_VCC] = 0x01; /* Sleep current VCC  */
+    sd->ext_csd[EXT_CSD_S_C_VCCQ] = 0x01; /* Sleep current VCCQ */
+    sd->ext_csd[EXT_CSD_S_A_TIMEOUT] = 0x01; /* Sleep/Awake timeout */
+    stl_le_p(&sd->ext_csd[EXT_CSD_SEC_CNT], sectcount); /* Sector count */
+    sd->ext_csd[210] = 0x46; /* Min write perf for 8bit@52Mhz */
+    sd->ext_csd[209] = 0x46; /* Min read perf for 8bit@52Mhz  */
+    sd->ext_csd[208] = 0x46; /* Min write perf for 4bit@52Mhz */
+    sd->ext_csd[207] = 0x46; /* Min read perf for 4bit@52Mhz */
+    sd->ext_csd[206] = 0x46; /* Min write perf for 4bit@26Mhz */
+    sd->ext_csd[205] = 0x46; /* Min read perf for 4bit@26Mhz */
+    sd->ext_csd[EXT_CSD_CARD_TYPE] = 0b11;
+    sd->ext_csd[EXT_CSD_STRUCTURE] = 2;
+    sd->ext_csd[EXT_CSD_REV] = 3;
 }
 
 static void emmc_set_csd(SDState *sd, uint64_t size)
-- 
2.41.0


