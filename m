Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01026C3064D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 16:40:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMsAX-0003C0-T6; Thu, 27 Jun 2024 12:40:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMsAW-0002zC-Cy
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 12:40:20 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMsAU-0007DO-M8
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 12:40:20 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-425680b1d3aso3551465e9.2
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 09:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719506416; x=1720111216; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Kx/xpSwqNNbWf+vNm/3cxS62PiRf/NP5lc+BI6XCrgc=;
 b=whuIXdUYtzldTcgAzi+KNkePEXcQfE4GJenDts2rGSSl31O5O6awObUJMXtt46y74b
 NucmhhPJ8QpBSYnDRMCjNYClXoW0ZHUIoFiKKAZ/QaNs+Ivi4d+dkoks2Nx3S2Wty2tc
 IIXKh2xnOzPakwAG02LVVW684yrrUd7x2FYs1ug+Rta+Lux2UBJZl9iqm92fseS3Kn2Z
 88TNfqjIlTQAPB6Jmx/rY3/UBfp5e0WjAFd63e5f8Dh3inlyERnNDPNjz+CdQSWsitx8
 ZjRTz81BoqOdGlI8wFyNov9ZnnLTNA448BRaPhSextRhz9CdmjlD+/ByNF7rhGt7f/EB
 jjVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719506416; x=1720111216;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Kx/xpSwqNNbWf+vNm/3cxS62PiRf/NP5lc+BI6XCrgc=;
 b=buzaDBFEbF/+iqt+P7awXHmREpQBtV9U6O4Eq0UsGdJg/k5UN8hr/FdbuPknQ+ioof
 UQsIoTuVOoOxC9astcsXBkAOnJIWb7WAXgJngRExpMmw6SW3zZ5MwngVm1RoaEbOuPrB
 DBf7AbIqKNH60HxsCevjtmfBrJUmJHJViyfXuxK+sjudcrVLpKntfhxb1plRV2vH895n
 zKrzp+kf1KW1ZMRk9f7EqrAzNQywgVbEeZGYfwFuKUkahMfatuSAQ2ulo2HXeTfsD8+B
 UFxPOYQE4g7YwrU4hVycbHOtHuDxhNwIHGtOJJZicUNHBJm1t9wNHQVPK82c4quAUiuF
 di9A==
X-Gm-Message-State: AOJu0YyGGQPA6bdxImF50nZZYXbHKXIWjyxzE6+Ux/0EKo2wB+OC4CV3
 eoNG1DNTKhRsqIu73M7Cfuo8Xt+rgMUA7OX78N0m1U9e9rH7E5TGAlMgzWHt2iGzf/5Lb25DCTl
 zWdg=
X-Google-Smtp-Source: AGHT+IG91xcM3GK0FBkwgHVq714GQqaMO/l0IINWenxiAF3IljOSjewlsHO2ZmDIauwms/NSQ/3gng==
X-Received: by 2002:a5d:6489:0:b0:367:277e:bd64 with SMTP id
 ffacd0b85a97d-367277ebe90mr4396390f8f.71.1719506415732; 
 Thu, 27 Jun 2024 09:40:15 -0700 (PDT)
Received: from localhost.localdomain (33.red-95-127-46.staticip.rima-tde.net.
 [95.127.46.33]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3674369ecdesm2403649f8f.108.2024.06.27.09.40.12
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 27 Jun 2024 09:40:15 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Francisco Iglesias <francisco.iglesias@amd.com>, qemu-block@nongnu.org,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, Luc Michel <luc.michel@amd.com>
Subject: [PATCH 08/11] hw/sd/sdcard: Register generic optional handlers (CMD11
 and CMD20)
Date: Thu, 27 Jun 2024 18:38:40 +0200
Message-ID: <20240627163843.81592-9-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240627163843.81592-1-philmd@linaro.org>
References: <20240627163843.81592-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sd.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 097cb0f2e2..74aa38a442 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -243,12 +243,12 @@ static const char *sd_cmd_name(SDState *sd, uint8_t cmd)
                                              [5]    = "IO_SEND_OP_COND",
          [6]    = "SWITCH_FUNC",             [7]    = "SELECT/DESELECT_CARD",
          [8]    = "SEND_IF_COND",            [9]    = "SEND_CSD",
-        [10]    = "SEND_CID",               [11]    = "VOLTAGE_SWITCH",
+        [10]    = "SEND_CID",
         [12]    = "STOP_TRANSMISSION",      [13]    = "SEND_STATUS",
                                             [15]    = "GO_INACTIVE_STATE",
         [16]    = "SET_BLOCKLEN",           [17]    = "READ_SINGLE_BLOCK",
         [18]    = "READ_MULTIPLE_BLOCK",
-        [20]    = "SPEED_CLASS_CONTROL",    [21]    = "DPS_spec",
+                                            [21]    = "DPS_spec",
         [24]    = "WRITE_BLOCK",            [25]    = "WRITE_MULTIPLE_BLOCK",
         [26]    = "MANUF_RSVD",             [27]    = "PROGRAM_CSD",
         [28]    = "SET_WRITE_PROT",         [29]    = "CLR_WRITE_PROT",
@@ -1161,6 +1161,14 @@ static sd_rsp_type_t sd_cmd_unimplemented(SDState *sd, SDRequest req)
     return sd_illegal;
 }
 
+static sd_rsp_type_t sd_cmd_optional(SDState *sd, SDRequest req)
+{
+    qemu_log_mask(LOG_UNIMP, "%s: Optional CMD%i not implemented\n",
+                  sd->proto->name, req.cmd);
+
+    return sd_illegal;
+}
+
 /* Configure fields for following sd_generic_write_byte() calls */
 static sd_rsp_type_t sd_cmd_to_receivingdata(SDState *sd, SDRequest req,
                                              uint64_t start, size_t size)
@@ -2279,7 +2287,9 @@ static const SDProto sd_proto_sd = {
         [2]  = {0,  sd_bcr,  "ALL_SEND_CID", sd_cmd_ALL_SEND_CID},
         [3]  = {0,  sd_bcr,  "SEND_RELATIVE_ADDR", sd_cmd_SEND_RELATIVE_ADDR},
         [4]  = {0,  sd_bc,   "SEND_DSR", sd_cmd_unimplemented},
+        [11] = {0,  sd_ac,   "VOLTAGE_SWITCH", sd_cmd_optional},
         [19] = {2,  sd_adtc, "SEND_TUNING_BLOCK", sd_cmd_SEND_TUNING_BLOCK},
+        [20] = {2,  sd_ac,   "SPEED_CLASS_CONTROL", sd_cmd_optional},
         [23] = {2,  sd_ac,   "SET_BLOCK_COUNT", sd_cmd_SET_BLOCK_COUNT},
     },
 };
-- 
2.41.0


