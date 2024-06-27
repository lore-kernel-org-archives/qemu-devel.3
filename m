Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01BC6C41513
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 16:49:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMsI8-0008Sd-Jr; Thu, 27 Jun 2024 12:48:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMsHL-0006qk-0P
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 12:47:33 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMsHI-0000Yh-3L
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 12:47:21 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-42566fb8302so5765925e9.0
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 09:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719506838; x=1720111638; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z4eT6ls1VgCOfFdDFeq72C/Jkjo1k0Xm3Q4yUyOE478=;
 b=DXHVP3NNIZ6JVrujgShShAYqOYN5JsXQgW9DCwVHbHFbnRn03inFi4KFxHI0iYkLOm
 qXZ3LernGLuteXuvRQpMnIGQZltNmGtvTw1g0SG4h4hgZxfSdWBN+waJSA7NEQPHra2F
 HdZO4ycqcc78VzTqoqqRtk1/2GdSINGqFSxVMKphiiYbXkAJZKnTly09P5AU0jTS0Kv0
 5hslJM3OoeQGXsUMwWJyvk0bZxIllUL1lFlOIIwIqkTxDwnqMJuERNS3LiWJi3lXNgXU
 ZrZ6jsOzemeMS5HV++8QsCKk8sM0c8WbCRQ8/WHG4vfilZr76QuH+rCmvzmHkL6JZXUI
 q9hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719506838; x=1720111638;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z4eT6ls1VgCOfFdDFeq72C/Jkjo1k0Xm3Q4yUyOE478=;
 b=Lh3vQpPRCTRDeyOTcwb3K33Y8YrdBx3QLBKBwTJaa62MmCcemt12doLSxtboGxriVQ
 L/fr38RMqUGfdiGekWFOEpJrcGG2WI4d3zoALJmZphCmvwexXuP4DDUXtvH7PrBT7Myj
 mEcn1RfIy5/WlELPFroQxmMRXn3EW66jk5WR70pWZsqPpoJXi/CNiVzSECauqFFfOVqr
 gRtopLVpBUBRe7EjgrpT7kgx81Kxu2bqFJRA2I44ZvVAsCwOhF3BHdjILvi/PzlltdYZ
 2zhwcY13055LW9WcrJPk/NqY2roeYIrA/xQBhcj/YxwVplbi3S787aeMIft0lCS7rvOC
 uLnw==
X-Gm-Message-State: AOJu0YwQUJZVWOGs2ShF3qUhBqe2ABvhlecmnzvxtdN5EuTkC2CbuyQq
 zerxhlTIU8bPJAczLYzrYGb4G/nJufkzd3HR2M9+zNVhqqDWUgQzqpuoG3/GOwZZs7FfvcrRQoQ
 TU6M=
X-Google-Smtp-Source: AGHT+IHd4zCcS3nCQASqfZh1q7Jo09zcvgQ3qWWsGjiMANaolcKnlCA1FqeP8s8xUiSlfBh4QOCwew==
X-Received: by 2002:a05:600c:4c22:b0:424:ac9c:71f9 with SMTP id
 5b1f17b1804b1-424ac9c7bdcmr38538235e9.39.1719506838266; 
 Thu, 27 Jun 2024 09:47:18 -0700 (PDT)
Received: from localhost.localdomain (33.red-95-127-46.staticip.rima-tde.net.
 [95.127.46.33]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3674358548csm2458704f8f.64.2024.06.27.09.47.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 27 Jun 2024 09:47:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Sai Pavan Boddu <sai.pavan.boddu@amd.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Joel Stanley <joel@jms.id.au>, Luc Michel <luc.michel@amd.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH 21/21] hw/sd/sdcard: Add spi_cmd_CRC_ON_OFF handler (CMD59)
Date: Thu, 27 Jun 2024 18:43:44 +0200
Message-ID: <20240627164345.82192-22-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240627164345.82192-1-philmd@linaro.org>
References: <20240627164345.82192-1-philmd@linaro.org>
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
 hw/sd/sd.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index b3b4cd5a3a..2f853a89d1 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1666,6 +1666,12 @@ static sd_rsp_type_t spi_cmd_READ_OCR(SDState *sd, SDRequest req)
     return sd_r3;
 }
 
+/* CMD59 */
+static sd_rsp_type_t spi_cmd_CRC_ON_OFF(SDState *sd, SDRequest req)
+{
+    return sd_r1;
+}
+
 static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
 {
     uint64_t addr;
@@ -1753,10 +1759,6 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
     case 26:  /* CMD26:  PROGRAM_CID */
         return sd_cmd_to_receivingdata(sd, req, 0, sizeof(sd->cid));
 
-    /* Application specific commands (Class 8) */
-    case 59:    /* CMD59:   CRC_ON_OFF (SPI) */
-        return sd_r1;
-
     default:
         qemu_log_mask(LOG_GUEST_ERROR, "SD: Unknown CMD%i\n", req.cmd);
         return sd_illegal;
@@ -2325,6 +2327,7 @@ static const SDProto sd_proto_spi = {
         [56] = {8,  sd_spi, "GEN_CMD", sd_cmd_GEN_CMD},
         [57] = {10, sd_spi, "DIRECT_SECURE_WRITE", sd_cmd_optional},
         [58] = {0,  sd_spi, "READ_OCR", spi_cmd_READ_OCR},
+        [59] = {0,  sd_spi, "CRC_ON_OFF", spi_cmd_CRC_ON_OFF},
     },
     .acmd = {
         [41] = {8,  sd_spi, "SEND_OP_COND", spi_cmd_SEND_OP_COND},
-- 
2.41.0


