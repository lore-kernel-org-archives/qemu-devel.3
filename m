Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC278C2BBCA
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 07:09:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN5if-0005AA-99; Fri, 28 Jun 2024 03:08:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5iX-0004W2-TL
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:08:22 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5iV-0004Oa-JP
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:08:21 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4255fa23f7bso2463835e9.2
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 00:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719558497; x=1720163297; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=e77sqfrLYi9SLwpkQhHOa0XqG0+lUrwsgw9mW5fMvkQ=;
 b=r1pZeVsdLEnbf+OsYvCtFvw8TkEJKTI+in9OZNfapSp77NvSvOe02Wi2fuWMTIWRWj
 HoY6oJGHO3lrlLq7TKmDilBN8225JgxJ3+CXa6q6qkCfo/diWX1ZULDEAKClE4AM3y9s
 irYdVzzOZaHO/uxhfrkK4NvRdUcTfydP/hifLnSgU8CLzFMp94l8w/ZdFr6ogrO73KSW
 iq9sSmPs3BqY2q7uFeq8whTDDDAdtTjqGZ98SzaMXMAcoUCz4EpSrAlP/vtgB7d/8rzV
 R8O4ZG4Yaa4kwSWOSdSu51seDUXR70Ka27djn2WvOja/d0b76oMysdzaw6B6Xt+DqtmV
 2DKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719558497; x=1720163297;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e77sqfrLYi9SLwpkQhHOa0XqG0+lUrwsgw9mW5fMvkQ=;
 b=SbK4bNPUxTL1hO+/NMgx+HWeCyZrEW1o4h+HDGkTNMcasrkuX5rnEugU+MEFMXQcbi
 n0m3b19+UQ8v/ycvUM0zdbLSZFZr41+sgdYEsk8sKarh4/36/lPvl/dw2mFdTQeIXmTZ
 K9KSfD2jbPDbZPZf2a0+OXxHIlAweAcoCP+r/Oo54cuMtS4EONqknU4ECxhpSO7vKhyB
 odN4gamPSyglbXSjlJhqhoHG1X80f5vPJuyMujBtP05Ke5SBGBo/WHapDiLwOOoGgj2N
 gXNSlZ1zgui2ViKEuDQiDILBUVEfoRZ8ccUxAHVAKKDlmdbdK5xzNsoYREvwYBjFvezh
 kzBw==
X-Gm-Message-State: AOJu0Yy9wFwCxJHnb/uCkjctB2EOWlq4qbDNx3XY3a8pvk+lXVNucsS6
 UdKbw9K3DBvKwMf0ZcxLbMSfq8AsWqC5bV4DzVg8xniuoQBnpwyQgDJeg/sW90MQVdTc3OqNv45
 UoSA=
X-Google-Smtp-Source: AGHT+IER3bfElNR4onGXvjiVO9ZK7vZg02JX+18Qcz1iNF6MODeDObyRSICjZThmfIIRYK8KQUQFmA==
X-Received: by 2002:a05:600c:a:b0:424:ad14:6b79 with SMTP id
 5b1f17b1804b1-424ad146e41mr45810345e9.8.1719558497356; 
 Fri, 28 Jun 2024 00:08:17 -0700 (PDT)
Received: from m1x-phil.lan (cho94-h02-176-184-4-239.dsl.sta.abo.bbox.fr.
 [176.184.4.239]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a0fb97esm1328884f8f.89.2024.06.28.00.08.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 28 Jun 2024 00:08:16 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH v42 58/98] hw/sd/sdcard: Add sd_cmd_PROGRAM_CSD handler (CMD27)
Date: Fri, 28 Jun 2024 09:01:34 +0200
Message-ID: <20240628070216.92609-59-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240628070216.92609-1-philmd@linaro.org>
References: <20240628070216.92609-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sd.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 4650d20ee7..9d33113f11 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -243,7 +243,7 @@ static const char *sd_cmd_name(SDState *sd, uint8_t cmd)
         [18]    = "READ_MULTIPLE_BLOCK",
                                             [21]    = "DPS_spec",
                                             [25]    = "WRITE_MULTIPLE_BLOCK",
-        [26]    = "MANUF_RSVD",             [27]    = "PROGRAM_CSD",
+        [26]    = "MANUF_RSVD",
         [28]    = "SET_WRITE_PROT",         [29]    = "CLR_WRITE_PROT",
         [30]    = "SEND_WRITE_PROT",
         [32]    = "ERASE_WR_BLK_START",     [33]    = "ERASE_WR_BLK_END",
@@ -1514,6 +1514,12 @@ static sd_rsp_type_t sd_cmd_WRITE_SINGLE_BLOCK(SDState *sd, SDRequest req)
     return sd_cmd_to_receivingdata(sd, req, addr, sd->blk_len);
 }
 
+/* CMD27 */
+static sd_rsp_type_t sd_cmd_PROGRAM_CSD(SDState *sd, SDRequest req)
+{
+    return sd_cmd_to_receivingdata(sd, req, 0, sizeof(sd->csd));
+}
+
 static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
 {
     uint16_t rca;
@@ -1603,9 +1609,6 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
     case 26:  /* CMD26:  PROGRAM_CID */
         return sd_cmd_to_receivingdata(sd, req, 0, sizeof(sd->cid));
 
-    case 27:  /* CMD27:  PROGRAM_CSD */
-        return sd_cmd_to_receivingdata(sd, req, 0, sizeof(sd->csd));
-
     /* Write protection (Class 6) */
     case 28:  /* CMD28:  SET_WRITE_PROT */
         if (sd->size > SDSC_MAX_CAPACITY) {
@@ -2310,6 +2313,7 @@ static const SDProto sd_proto_spi = {
         [16] = {2,  sd_spi, "SET_BLOCKLEN", sd_cmd_SET_BLOCKLEN},
         [17] = {2,  sd_spi, "READ_SINGLE_BLOCK", sd_cmd_READ_SINGLE_BLOCK},
         [24] = {4,  sd_spi, "WRITE_SINGLE_BLOCK", sd_cmd_WRITE_SINGLE_BLOCK},
+        [27] = {4,  sd_spi, "PROGRAM_CSD", sd_cmd_PROGRAM_CSD},
         [34] = {10, sd_spi, "READ_SEC_CMD", sd_cmd_optional},
         [35] = {10, sd_spi, "WRITE_SEC_CMD", sd_cmd_optional},
         [36] = {10, sd_spi, "SEND_PSI", sd_cmd_optional},
@@ -2347,6 +2351,7 @@ static const SDProto sd_proto_sd = {
         [20] = {2,  sd_ac,   "SPEED_CLASS_CONTROL", sd_cmd_optional},
         [23] = {2,  sd_ac,   "SET_BLOCK_COUNT", sd_cmd_SET_BLOCK_COUNT},
         [24] = {4,  sd_adtc, "WRITE_SINGLE_BLOCK", sd_cmd_WRITE_SINGLE_BLOCK},
+        [27] = {4,  sd_adtc, "PROGRAM_CSD", sd_cmd_PROGRAM_CSD},
         [34] = {10, sd_adtc, "READ_SEC_CMD", sd_cmd_optional},
         [35] = {10, sd_adtc, "WRITE_SEC_CMD", sd_cmd_optional},
         [36] = {10, sd_adtc, "SEND_PSI", sd_cmd_optional},
-- 
2.41.0


