Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 915DFC2BBCA
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 07:12:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN5j5-0005vw-Vu; Fri, 28 Jun 2024 03:08:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5iy-0005kq-9i
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:08:48 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5iv-0004Sb-AD
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:08:47 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-42565cdf99cso3129315e9.3
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 00:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719558523; x=1720163323; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=HYHB8+xaBcVQbVKgp+p9kpTdDb0kmp4G0ZMulayNcv0=;
 b=wDY4IrsYyPo/ipwhh25uCdAgg1pBE5hrx+pZGDh/hSBo/ZM6tlmbWIq/OSndt+zo1w
 V+LU10A4TPgzRXFBD1sfg3pp5MAAxK/4XxVRD1O7RkcdB7zMc5kRqG265Z0oFMamRulv
 qNUFDgBAnYk8YkigUGs8OARepKUMgbvj8UV/ukptEiVFJE1zz+NttO3oEZnEHNFJB2G7
 KyaXvz0t9v/LdveLKhjoJqmhqlve2HcUAq8fFHeuUnDVJQkXTwx8TEuwqmOs2Zk4f++c
 oXo87IGZ88D6Vqh0Qg97VJ9xGtOwZ23lKNNSc1Bfi1of00XwEdtrSJ3U9HfzrtxHBMVx
 oKUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719558523; x=1720163323;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HYHB8+xaBcVQbVKgp+p9kpTdDb0kmp4G0ZMulayNcv0=;
 b=L3+GavpEo5UV/4DEtY6oStTnOcQzGxtziLWJiI9wbJUDbeNA3bnkJsEuV7sXPa+dmi
 aEBB2RsNc6ZqlbKSKgsxWNt1WJ2YGZWRmx6FABvXvTTZprOAgnSHMBFLwYxxewb6w4Bw
 2QJxo9pk5N7QXu0Fea8kTDM6wIB+Ww2BkoO4CwwWKth31JpqyJGIz6eZyMikOucaY/LS
 KUCFAW6oKXfaszVRSax5g8BZprEjUhDguucsmbm6SxHDK7UG0AF8P0SdJzMquwPOpaVa
 bEPHogNI4bccGqvbqCRsq3y59mv7ozkx9y44gyZTwkq4HHl2Loz7XTxehnfwE0iFJQhH
 51YA==
X-Gm-Message-State: AOJu0Yw6nN3+8Rv7XNSD9zD8RuNlZZRa6swUros5iQgi5TCkRMTKW5Cu
 M4iNi5q9e1nKJI/GQXO8NfN5LxpraG+WFH/C57KNciOdSPUvXAby2EMmWFYAagtZqNFbhuUgQPM
 GjL8=
X-Google-Smtp-Source: AGHT+IEfYNhvLtb6FZ+nTKbR1j1RK+i2k8wrSsV3moyyHLTxUfKNF6NxILZ9eB5LUx+DbPbckk512Q==
X-Received: by 2002:a05:600c:511e:b0:424:a587:4392 with SMTP id
 5b1f17b1804b1-424a5874419mr76692675e9.18.1719558522777; 
 Fri, 28 Jun 2024 00:08:42 -0700 (PDT)
Received: from m1x-phil.lan (cho94-h02-176-184-4-239.dsl.sta.abo.bbox.fr.
 [176.184.4.239]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256af3cf9bsm21895665e9.8.2024.06.28.00.08.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 28 Jun 2024 00:08:42 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH v42 63/98] hw/sd/sdcard: Add sd_cmd_LOCK_UNLOCK handler (CMD42)
Date: Fri, 28 Jun 2024 09:01:39 +0200
Message-ID: <20240628070216.92609-64-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240628070216.92609-1-philmd@linaro.org>
References: <20240628070216.92609-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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
 hw/sd/sd.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 17fec612eb..4d78ac5b59 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -245,7 +245,6 @@ static const char *sd_cmd_name(SDState *sd, uint8_t cmd)
                                             [25]    = "WRITE_MULTIPLE_BLOCK",
         [26]    = "MANUF_RSVD",
         [40]    = "DPS_spec",
-        [42]    = "LOCK_UNLOCK",
         [54]    = "SDIO_RSVD",              [55]    = "APP_CMD",
         [56]    = "GEN_CMD",
         [60]    = "MANUF_RSVD",             [61]    = "MANUF_RSVD",
@@ -1619,6 +1618,12 @@ static sd_rsp_type_t sd_cmd_ERASE(SDState *sd, SDRequest req)
     return sd_r1b;
 }
 
+/* CMD42 */
+static sd_rsp_type_t sd_cmd_LOCK_UNLOCK(SDState *sd, SDRequest req)
+{
+    return sd_cmd_to_receivingdata(sd, req, 0, 0);
+}
+
 static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
 {
     uint16_t rca;
@@ -1707,10 +1712,6 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
     case 26:  /* CMD26:  PROGRAM_CID */
         return sd_cmd_to_receivingdata(sd, req, 0, sizeof(sd->cid));
 
-    /* Lock card commands (Class 7) */
-    case 42:  /* CMD42:  LOCK_UNLOCK */
-        return sd_cmd_to_receivingdata(sd, req, 0, 0);
-
     /* Application specific commands (Class 8) */
     case 55:  /* CMD55:  APP_CMD */
         rca = sd_req_get_rca(sd, req);
@@ -2316,6 +2317,7 @@ static const SDProto sd_proto_spi = {
         [36] = {10, sd_spi, "SEND_PSI", sd_cmd_optional},
         [37] = {10, sd_spi, "CONTROL_ASSD_SYSTEM", sd_cmd_optional},
         [38] = {5,  sd_spi, "ERASE", sd_cmd_ERASE},
+        [42] = {7,  sd_spi, "LOCK_UNLOCK", sd_cmd_LOCK_UNLOCK},
         [50] = {10, sd_spi, "DIRECT_SECURE_READ", sd_cmd_optional},
         [52] = {9,  sd_spi, "IO_RW_DIRECT", sd_cmd_optional},
         [53] = {9,  sd_spi, "IO_RW_EXTENDED", sd_cmd_optional},
@@ -2360,6 +2362,7 @@ static const SDProto sd_proto_sd = {
         [36] = {10, sd_adtc, "SEND_PSI", sd_cmd_optional},
         [37] = {10, sd_ac,   "CONTROL_ASSD_SYSTEM", sd_cmd_optional},
         [38] = {5,  sd_ac,   "ERASE", sd_cmd_ERASE},
+        [42] = {7,  sd_adtc, "LOCK_UNLOCK", sd_cmd_LOCK_UNLOCK},
         [43] = {1,  sd_ac,   "Q_MANAGEMENT", sd_cmd_optional},
         [44] = {1,  sd_ac,   "Q_TASK_INFO_A", sd_cmd_optional},
         [45] = {1,  sd_ac,   "Q_TASK_INFO_B", sd_cmd_optional},
-- 
2.41.0


