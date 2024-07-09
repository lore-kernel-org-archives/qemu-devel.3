Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3484CC3DA41
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 15:28:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRCkM-0006yl-Ez; Tue, 09 Jul 2024 11:27:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sRCkK-0006qd-Iv
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 11:27:12 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sRCkI-0006NL-46
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 11:27:12 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4266fd395eeso8159295e9.3
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2024 08:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720538828; x=1721143628; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LTBSqa3nL1hHOoyNBKxeti60k1BPrqreQUxbpvz+1nE=;
 b=N8CNDyAFcgQ45r9+QBj7k2dqvsrN+kuHTqe8+15YCI1z9WR1EYB+BZdvdGaaCqcTGj
 2tqQzREcmYEFActSKQU20tN0luQvUS++RU05IQV7LF7xCx9CqJbt1DbT7+0q6VkRPWqs
 reixfUtWIyd1ywdropRJ+fzCp8Sah3Pp7jvbtm119UP6IvNl6JnLnLQIfG7DAH2z//ll
 Ptu+RDG2ZalxAjzd3+mAWTR9EsO+uFROxcYHtUVJKXQVrokRND0WHeTgTtxR2Dj1pqAD
 0F49zlec3thL9653h8zEjFO5uJGqhch30GFj+v2yZGXFdnu+TXi/41n7y+7qPqoeqDeg
 C83w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720538828; x=1721143628;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LTBSqa3nL1hHOoyNBKxeti60k1BPrqreQUxbpvz+1nE=;
 b=M2Bj9p/b1Euu91eUZbCnE1zcqsYj6ArZ1rErDBWudSU3NIlknU1Rna7XgTn+G1KagV
 YRQWnUJzEptkL1Nx59lR2MtHrbq2FTfuTRFjP/lqaIspcfjN8H/vJf6aaBpngvBpgHPM
 Sd6UgdS7Ic2ZWRsOA83uj2nQ7211yVdpDgo9uqwG71WlNE7vkyN/8vxnzEFZxEeI9YZ4
 8vFupZBQA2xR4YuH0KxT9otl5ROqq0gaNpoIZM3QKOzVmsHfmD1G3dLUWEdcDQh5tV91
 EXd68TstMkMHMeQaF+YIzrr1tsCeClD7wbrMFdpOhvLTnDz1h/QOOKF8xn3M3jm1O8gq
 qwYQ==
X-Gm-Message-State: AOJu0YyVCf0F50g6zLsSOsi7zUDsaz/YW19YF720AnLiSQzE138PFWAq
 eSY8U5Gr3bQ9GBQt5xf1x1yFXUClVotmGl6RBWsTqzCpBBWjPM9J6LqDrHfkE6iPzbwagI2B6KH
 o
X-Google-Smtp-Source: AGHT+IETY/ojNE+Ats0xeJpQztD9ec0bbTy3Q7/iwZXwX92zRX6wxnm5MNnf5OOiTjAd8Xlnwv5gdw==
X-Received: by 2002:a05:6000:c01:b0:366:eb00:9ddd with SMTP id
 ffacd0b85a97d-367cea47648mr1739600f8f.8.1720538828514; 
 Tue, 09 Jul 2024 08:27:08 -0700 (PDT)
Received: from m1x-phil.lan (vau06-h02-176-184-43-20.dsl.sta.abo.bbox.fr.
 [176.184.43.20]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-367cdfa0666sm2846473f8f.73.2024.07.09.08.27.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 09 Jul 2024 08:27:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, qemu-block@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Bin Meng <bmeng.cn@gmail.com>, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>
Subject: [PATCH v47 11/19] hw/sd/sdcard: Add eMMC 'boot-size' property
Date: Tue,  9 Jul 2024 17:25:48 +0200
Message-ID: <20240709152556.52896-12-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240709152556.52896-1-philmd@linaro.org>
References: <20240709152556.52896-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

Avoid hardcoding 1MiB boot size in EXT_CSD_BOOT_MULT,
expose it as QOM property.

By default, do not use any size. Board is responsible
to set the boot size property.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sd.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index c809961418..df0e2345c0 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -129,6 +129,7 @@ struct SDState {
     /* Static properties */
 
     uint8_t spec_version;
+    uint64_t boot_part_size;
     BlockBackend *blk;
 
     const SDProto *proto;
@@ -490,7 +491,8 @@ static void mmc_set_ext_csd(SDState *sd, uint64_t size)
     sd->ext_csd[EXT_CSD_TRIM_MULT] = 0x1; /* Trim multiplier */
     sd->ext_csd[EXT_CSD_SEC_FEATURE_SUPPORT] = 0x15; /* Secure feature */
     sd->ext_csd[EXT_CSD_BOOT_INFO] = 0x7; /* Boot information */
-    sd->ext_csd[EXT_CSD_BOOT_MULT] = 0x8; /* Boot partition size. 128KB unit */
+                                     /* Boot partition size. 128KB unit */
+    sd->ext_csd[EXT_CSD_BOOT_MULT] = sd->boot_part_size / (128 * KiB);
     sd->ext_csd[EXT_CSD_ACC_SIZE] = 0x6; /* Access size */
     sd->ext_csd[EXT_CSD_HC_ERASE_GRP_SIZE] = 0x4; /* HC Erase unit size */
     sd->ext_csd[EXT_CSD_ERASE_TIMEOUT_MULT] = 0x01; /* HC erase timeout */
@@ -2693,6 +2695,7 @@ static Property sd_properties[] = {
 };
 
 static Property emmc_properties[] = {
+    DEFINE_PROP_UINT64("boot-size", SDState, boot_part_size, 0),
     DEFINE_PROP_END_OF_LIST()
 };
 
-- 
2.41.0


