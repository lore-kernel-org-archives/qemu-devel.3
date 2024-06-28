Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD289C2BBCA
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 07:04:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN5en-0002Qe-9Z; Fri, 28 Jun 2024 03:04:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5eg-00024b-Kj
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:04:24 -0400
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5ee-0006oC-Oz
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:04:22 -0400
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-52e764bb3fbso331482e87.3
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 00:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719558258; x=1720163058; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lMFKG2q5UbCp1Dyyq8cGhI62qgCIuzAq7XqP054066E=;
 b=LMKGSIv9Nekb8cxZ4VZ9e/yLypMsrHRkn/89+ZcHumEe2I+4JBA9wUyuh6E+GVksq5
 lBXEL0JGWb8ZDpQXRoyZke9oPVP/APKBr1pE18E4Hc0JHFAHVOp5+Pd2GytfzglrXkEq
 QrjS+uWZPlSGobaCKnpPEpzNQmkYowyTpbBDZBrLd0yr4XY1LfkT4CO1ZjOLASbCUWHc
 zJtgIidz47JqRKII100cqejO0Dd49Oc97SLwHfSv/dFDoyeAAs48QORN55TJhrSoR9Ha
 rOmGni2EVNLCXDQANX898QyV8dokENGKOhez7JsURPXQbnavmCHL9ggUHm6Ebzp4jIxz
 HW1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719558258; x=1720163058;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lMFKG2q5UbCp1Dyyq8cGhI62qgCIuzAq7XqP054066E=;
 b=u/n3E1+uS9+WfOgcuYK9QOj9U2JPxYui+TDpu1yzVFreaYXEkcGB9qdxZjzn/U4d6+
 3LziTROr5O1VU0AgL+Wt5VaoA/iGpa24XEXsymIAGLYvR8Ug/OI0PHtFnIpqbZU5E7Es
 1PTVxG/kTMxh3lxdccwVU0PClfJm55ZWA48U3auzxnXKEvbNAMISTlFYY1JTzqEdzgtR
 /AiGGO3rMgnVIlQJXw7Sm7q5eKHRH9arFYlhmDUaJTOsfAWs7kgDTa/xU/J5WURueK8I
 zPYfdt3Xjkn0KFHYeO4slt8N9cRw+wbZEhyGSFHR98ubkrghuEDoEqPJKI/PIHUtzRjQ
 kDdQ==
X-Gm-Message-State: AOJu0YyxB4WTNGQh6hb5BO0eaPC9/TOXyOmv+t6JCGOJdMj0QM4bLgh7
 pBk+GXH9twDsTHff0dVLsvXmxj5cpEK6rM1jQSKLn5NWjbD4BgIklk6Vq3Ww45wXN8XImPh4ToB
 tBuQ=
X-Google-Smtp-Source: AGHT+IEc1XZUd7IFWvZ4w8buXHBHs7WvLsC7PE75OTgzcD8AG1guvQLml4Ni5P9KZrHdkK6TEHD04Q==
X-Received: by 2002:a05:6512:3988:b0:52c:ea28:8442 with SMTP id
 2adb3069b0e04-52cea288ea1mr10217264e87.20.1719558228488; 
 Fri, 28 Jun 2024 00:03:48 -0700 (PDT)
Received: from m1x-phil.lan (cho94-h02-176-184-4-239.dsl.sta.abo.bbox.fr.
 [176.184.4.239]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256af557fesm21849705e9.11.2024.06.28.00.03.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 28 Jun 2024 00:03:48 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH v42 17/98] hw/sd/sdcard: Introduce definitions for EXT_CSD
 register
Date: Fri, 28 Jun 2024 09:00:53 +0200
Message-ID: <20240628070216.92609-18-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240628070216.92609-1-philmd@linaro.org>
References: <20240628070216.92609-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::130;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x130.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UPPERCASE_50_75=0.008 autolearn=no autolearn_force=no
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

From: Cédric Le Goater <clg@kaod.org>

Signed-off-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sdmmc-internal.h | 97 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 97 insertions(+)

diff --git a/hw/sd/sdmmc-internal.h b/hw/sd/sdmmc-internal.h
index d8bf17d204..306ffa7f53 100644
--- a/hw/sd/sdmmc-internal.h
+++ b/hw/sd/sdmmc-internal.h
@@ -11,6 +11,103 @@
 #ifndef SDMMC_INTERNAL_H
 #define SDMMC_INTERNAL_H
 
+/*
+ * EXT_CSD fields
+ */
+
+#define EXT_CSD_CMDQ_MODE_EN            15      /* R/W */
+#define EXT_CSD_FLUSH_CACHE             32      /* W */
+#define EXT_CSD_CACHE_CTRL              33      /* R/W */
+#define EXT_CSD_POWER_OFF_NOTIFICATION  34      /* R/W */
+#define EXT_CSD_PACKED_FAILURE_INDEX    35      /* RO */
+#define EXT_CSD_PACKED_CMD_STATUS       36      /* RO */
+#define EXT_CSD_EXP_EVENTS_STATUS       54      /* RO, 2 bytes */
+#define EXT_CSD_EXP_EVENTS_CTRL         56      /* R/W, 2 bytes */
+#define EXT_CSD_DATA_SECTOR_SIZE        61      /* R */
+#define EXT_CSD_GP_SIZE_MULT            143     /* R/W */
+#define EXT_CSD_PARTITION_SETTING_COMPLETED 155 /* R/W */
+#define EXT_CSD_PARTITION_ATTRIBUTE     156     /* R/W */
+#define EXT_CSD_PARTITION_SUPPORT       160     /* RO */
+#define EXT_CSD_HPI_MGMT                161     /* R/W */
+#define EXT_CSD_RST_N_FUNCTION          162     /* R/W */
+#define EXT_CSD_BKOPS_EN                163     /* R/W */
+#define EXT_CSD_BKOPS_START             164     /* W */
+#define EXT_CSD_SANITIZE_START          165     /* W */
+#define EXT_CSD_WR_REL_PARAM            166     /* RO */
+#define EXT_CSD_RPMB_MULT               168     /* RO */
+#define EXT_CSD_FW_CONFIG               169     /* R/W */
+#define EXT_CSD_BOOT_WP                 173     /* R/W */
+#define EXT_CSD_ERASE_GROUP_DEF         175     /* R/W */
+#define EXT_CSD_PART_CONFIG             179     /* R/W */
+#define EXT_CSD_ERASED_MEM_CONT         181     /* RO */
+#define EXT_CSD_BUS_WIDTH               183     /* R/W */
+#define EXT_CSD_STROBE_SUPPORT          184     /* RO */
+#define EXT_CSD_HS_TIMING               185     /* R/W */
+#define EXT_CSD_POWER_CLASS             187     /* R/W */
+#define EXT_CSD_REV                     192     /* RO */
+#define EXT_CSD_STRUCTURE               194     /* RO */
+#define EXT_CSD_CARD_TYPE               196     /* RO */
+#define EXT_CSD_DRIVER_STRENGTH         197     /* RO */
+#define EXT_CSD_OUT_OF_INTERRUPT_TIME   198     /* RO */
+#define EXT_CSD_PART_SWITCH_TIME        199     /* RO */
+#define EXT_CSD_PWR_CL_52_195           200     /* RO */
+#define EXT_CSD_PWR_CL_26_195           201     /* RO */
+#define EXT_CSD_PWR_CL_52_360           202     /* RO */
+#define EXT_CSD_PWR_CL_26_360           203     /* RO */
+#define EXT_CSD_SEC_CNT                 212     /* RO, 4 bytes */
+#define EXT_CSD_S_A_TIMEOUT             217     /* RO */
+#define EXT_CSD_S_C_VCCQ                219     /* RO */
+#define EXT_CSD_S_C_VCC                 220     /* RO */
+#define EXT_CSD_REL_WR_SEC_C            222     /* RO */
+#define EXT_CSD_HC_WP_GRP_SIZE          221     /* RO */
+#define EXT_CSD_ERASE_TIMEOUT_MULT      223     /* RO */
+#define EXT_CSD_HC_ERASE_GRP_SIZE       224     /* RO */
+#define EXT_CSD_ACC_SIZE                225     /* RO */
+#define EXT_CSD_BOOT_MULT               226     /* RO */
+#define EXT_CSD_BOOT_INFO               228     /* RO */
+#define EXT_CSD_SEC_TRIM_MULT           229     /* RO */
+#define EXT_CSD_SEC_ERASE_MULT          230     /* RO */
+#define EXT_CSD_SEC_FEATURE_SUPPORT     231     /* RO */
+#define EXT_CSD_TRIM_MULT               232     /* RO */
+#define EXT_CSD_PWR_CL_200_195          236     /* RO */
+#define EXT_CSD_PWR_CL_200_360          237     /* RO */
+#define EXT_CSD_PWR_CL_DDR_52_195       238     /* RO */
+#define EXT_CSD_PWR_CL_DDR_52_360       239     /* RO */
+#define EXT_CSD_BKOPS_STATUS            246     /* RO */
+#define EXT_CSD_POWER_OFF_LONG_TIME     247     /* RO */
+#define EXT_CSD_GENERIC_CMD6_TIME       248     /* RO */
+#define EXT_CSD_CACHE_SIZE              249     /* RO, 4 bytes */
+#define EXT_CSD_PWR_CL_DDR_200_360      253     /* RO */
+#define EXT_CSD_FIRMWARE_VERSION        254     /* RO, 8 bytes */
+#define EXT_CSD_PRE_EOL_INFO            267     /* RO */
+#define EXT_CSD_DEVICE_LIFE_TIME_EST_TYP_A      268     /* RO */
+#define EXT_CSD_DEVICE_LIFE_TIME_EST_TYP_B      269     /* RO */
+#define EXT_CSD_CMDQ_DEPTH              307     /* RO */
+#define EXT_CSD_CMDQ_SUPPORT            308     /* RO */
+#define EXT_CSD_SUPPORTED_MODE          493     /* RO */
+#define EXT_CSD_TAG_UNIT_SIZE           498     /* RO */
+#define EXT_CSD_DATA_TAG_SUPPORT        499     /* RO */
+#define EXT_CSD_MAX_PACKED_WRITES       500     /* RO */
+#define EXT_CSD_MAX_PACKED_READS        501     /* RO */
+#define EXT_CSD_BKOPS_SUPPORT           502     /* RO */
+#define EXT_CSD_HPI_FEATURES            503     /* RO */
+#define EXT_CSD_S_CMD_SET               504     /* RO */
+
+/*
+ * EXT_CSD field definitions
+ */
+
+#define EXT_CSD_WR_REL_PARAM_EN         (1 << 2)
+#define EXT_CSD_WR_REL_PARAM_EN_RPMB_REL_WR     (1 << 4)
+
+#define EXT_CSD_PART_CONFIG_ACC_MASK    (0x7)
+#define EXT_CSD_PART_CONFIG_ACC_DEFAULT (0x0)
+#define EXT_CSD_PART_CONFIG_ACC_BOOT0   (0x1)
+
+#define EXT_CSD_PART_CONFIG_EN_MASK     (0x7 << 3)
+#define EXT_CSD_PART_CONFIG_EN_BOOT0    (0x1 << 3)
+#define EXT_CSD_PART_CONFIG_EN_USER     (0x7 << 3)
+
 #define SDMMC_CMD_MAX 64
 
 /**
-- 
2.41.0


