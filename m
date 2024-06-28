Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDF05C3064D
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 07:18:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN5jS-0006VM-1l; Fri, 28 Jun 2024 03:09:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5jJ-0006L8-MI
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:09:12 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5jH-0004Ub-FI
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:09:09 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-42566fb8302so2506675e9.0
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 00:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719558543; x=1720163343; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Z4eT6ls1VgCOfFdDFeq72C/Jkjo1k0Xm3Q4yUyOE478=;
 b=BixIGmhEcBTlBj3jz+uh91vv/znbeC8eK2knbgu59sDV3mfUO9P2GAJdegX2A6G3nr
 cCRg+n79GzEydLofoEbjnA2T2UIxp4huW5kFUsffyMGWv+TLK17UPf7AC1pqNXMnt2c6
 U9PnmItbaFipV8GKRc7+C+e2xGvffsngUs+SraZHLcRy+fMcWcawb1c5/7N6FfucL4eq
 MGXr3xJ6HA4keveeqMYpiihTriMFsE3Nz/74GcfaFCKK6ToCvJJXl2jVYCYWGg73/K/8
 LIU/4eMTiA8s2JsCe4ekKx8H1AMdkoyEIEKvuiMW0+9fae/5m6NKdP0UDx1WgYt8wHpN
 H5zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719558543; x=1720163343;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z4eT6ls1VgCOfFdDFeq72C/Jkjo1k0Xm3Q4yUyOE478=;
 b=PM+Xt7YLtlpTsoQsWzkkdl+A+HsRS/zfIJyqxM240TPRL+BUZ7v7ZcPFBPYIL+olGR
 QsGmpT+dhodMPQ9p2bYJijXSCeATuZxt5ySzSTeg28Y/cu9wksLVmZx8pu/PcF5SPZ4/
 lsptewXss36ewwWEjjyJAZnnJra3xVc6UawY9R8y3SS2+XHniejVj70VzxQTRg9rlCes
 DZPWyK+coDZwmYhioY5YQh+AErknSiG/Ln3iabMCwh41SBpQG40lnN0/7YhOjqcYBXvA
 /vrZBvOfmY5NB2qhx18hkprQkCe/VSh7X/g7MCI9fvDXRjwqNzIoMBC4cJAOZ+jffuFs
 CqDQ==
X-Gm-Message-State: AOJu0YyktcAJNoMKiYx35jrR0exXYTfx/jNfXHYBKTJlyCCq9SSQenZH
 rTEqJqoVBYq/nMs7waRGV7r/HSqVr87dJ6v/Ra4g0x26r6B/GuCc6km46BdCiKvT/9rr8U2cZFG
 4eo8=
X-Google-Smtp-Source: AGHT+IFQhbUHzCGKeLL46uXlNah2b2+FK3sUAWlGSTkPFgG2+ihF1wZnVEUOCE4mftYZ/qZEl8JiNg==
X-Received: by 2002:a05:600c:35c1:b0:425:6726:ab25 with SMTP id
 5b1f17b1804b1-4256726ae12mr22849835e9.4.1719558543442; 
 Fri, 28 Jun 2024 00:09:03 -0700 (PDT)
Received: from m1x-phil.lan (cho94-h02-176-184-4-239.dsl.sta.abo.bbox.fr.
 [176.184.4.239]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256b097b77sm20856555e9.33.2024.06.28.00.09.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 28 Jun 2024 00:09:03 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH v42 67/98] hw/sd/sdcard: Add spi_cmd_CRC_ON_OFF handler (CMD59)
Date: Fri, 28 Jun 2024 09:01:43 +0200
Message-ID: <20240628070216.92609-68-philmd@linaro.org>
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


