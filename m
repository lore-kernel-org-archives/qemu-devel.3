Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16849C3DA41
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 15:27:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRCjp-0003yD-DD; Tue, 09 Jul 2024 11:26:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sRCje-0003mV-Uc
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 11:26:32 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sRCjc-0006Em-FK
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 11:26:30 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4266eda81c5so12836165e9.0
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2024 08:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720538786; x=1721143586; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=60ugG7sbucLNOSaT9RRMMhTNzSMzLQ61ZmEDNwXQ9Yk=;
 b=J9jg8Rg9JWoABE0qMwy7A+vzGeCVlheESLswLIhW9km776dchOcDogVPSA65ghbV8y
 /ElUvgKR89Xb/LOlDmOS4ueACfzZmHY9d14+eBB7kdNKaHwG5UG8HbJiF4l3nohPFZsc
 EM7YqP/5aVslqGqFWmBOwUi+bDgymJTQeKumiLnkb+Jj9uY5ScFlLbPE7H6H3eB942f2
 fsiPVsCd0f4nGu9tWxwn80l5UFGsgF57EqEHctlhrIefdB/s3BLQuQd2RInSCzWg/+73
 mQPQGn02dE//YOzbnx7genwmgPYQCsRs9kkS5+24JyNAzoVF/FiCepxow6JNjWL3sDLN
 T9Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720538786; x=1721143586;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=60ugG7sbucLNOSaT9RRMMhTNzSMzLQ61ZmEDNwXQ9Yk=;
 b=BBfL9FyCG8iCf70Tops2nFrLNuf//J9kzKk+SKsvWhjC0JT7ARoJppHaJJlBrHOHCy
 lTLjkiPwT+n58CMOl+TNI/+lrKLD/kImmc6llCkJhYP5SRMpHdEmPuwktWbPyC6zXMYz
 YdKzhR5iFNVUJEepHjYZG2pzm6WfWV07/9fnjAcjmnidnURgidnVe/lKU5rmAxl/qmwM
 u9jfwSdtISK5FpDRM09/DRjm0Gk32a4C5E7Gcn8Vtkq1R2Q5z4bynBK9s3kmPNNF500k
 91xWp014dSz6F3DKA9EPAwBo4de3p80E2uhNnTrXWCgoLIx2rD4n6BUSiFFekYR9/q9e
 dvyg==
X-Gm-Message-State: AOJu0YxUjluX76v1NLbbFVmsitxQBP6TXMnhgz6GprtMvzrAnUKCvtmf
 kkypEoDfqdsYAHjfgroI/HscnlnQSSuEF6xQPhh70+MthrQZHyrnzYjWgDkeGd9d0Yd3xr1F4ql
 o
X-Google-Smtp-Source: AGHT+IE+L/Jomaff9uJFwGSRDpVPwqXZ33qbELgWPaNXY8SQEgf8ySkR0STT8Xs+nJbASSge0qPT1g==
X-Received: by 2002:a05:600c:22d4:b0:425:81bd:e5ee with SMTP id
 5b1f17b1804b1-426707d07c5mr25276565e9.16.1720538786629; 
 Tue, 09 Jul 2024 08:26:26 -0700 (PDT)
Received: from m1x-phil.lan (vau06-h02-176-184-43-20.dsl.sta.abo.bbox.fr.
 [176.184.43.20]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427270238a6sm12770615e9.20.2024.07.09.08.26.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 09 Jul 2024 08:26:26 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, qemu-block@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Bin Meng <bmeng.cn@gmail.com>, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>
Subject: [PATCH v47 04/19] hw/sd/sdcard: Implement emmc_set_cid()
Date: Tue,  9 Jul 2024 17:25:41 +0200
Message-ID: <20240709152556.52896-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240709152556.52896-1-philmd@linaro.org>
References: <20240709152556.52896-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

eMMC CID register is slightly different from SD:
- One extra PNM (5 -> 6)
- MDT is only 1 byte (2 -> 1).

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sd.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 097c9cc61f..2d737a836f 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -446,6 +446,23 @@ static void sd_set_cid(SDState *sd)
     sd->cid[15] = (sd_crc7(sd->cid, 15) << 1) | 1;
 }
 
+static void emmc_set_cid(SDState *sd)
+{
+    sd->cid[0] = MID;       /* Fake card manufacturer ID (MID) */
+    sd->cid[1] = 0b01;      /* CBX: BGA */
+    sd->cid[2] = OID[0];    /* OEM/Application ID (OID) */
+    sd->cid[3] = PNM[0];    /* Fake product name (PNM) */
+    sd->cid[4] = PNM[1];
+    sd->cid[5] = PNM[2];
+    sd->cid[6] = PNM[3];
+    sd->cid[7] = PNM[4];
+    sd->cid[8] = PNM[4];
+    sd->cid[9] = PRV;       /* Fake product revision (PRV) */
+    stl_be_p(&sd->cid[10], 0xdeadbeef); /* Fake serial number (PSN) */
+    sd->cid[14] = (MDT_MON << 4) | (MDT_YR - 1997); /* Manufacture date (MDT) */
+    sd->cid[15] = (sd_crc7(sd->cid, 15) << 1) | 1;
+}
+
 /* Card-Specific Data register */
 
 #define HWBLOCK_SHIFT   9        /* 512 bytes */
@@ -2581,6 +2598,8 @@ static void emmc_class_init(ObjectClass *klass, void *data)
     dc->user_creatable = false;
 
     sc->proto = &sd_proto_emmc;
+
+    sc->set_cid = emmc_set_cid;
 }
 
 static const TypeInfo sd_types[] = {
-- 
2.41.0


