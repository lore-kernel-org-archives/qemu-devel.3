Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7C28C2BBCA
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 07:09:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN5g2-0006S3-Gv; Fri, 28 Jun 2024 03:05:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5fg-0005yp-Nv
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:05:26 -0400
Received: from mail-lj1-x22f.google.com ([2a00:1450:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5fe-0001gH-Iq
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:05:24 -0400
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2ebe40673d8so2882421fa.3
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 00:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719558320; x=1720163120; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=dnn8g/1r/IDbgXO0nM+fG6kuhQufIGWzDGBB4WRk/v4=;
 b=PsvxjtiPrNH0Onp7y7vWtIG6aDN/0h4oyHnMTVPNEnuOwOqBspjX8LnQN/TrjD3rQt
 aWfvEXo1MnB0zEt5KyjNCOMz8nmC5aRKHCE8C54x/enAvWYGmOWAz5afZYborj0CN5Pj
 9W6mAZV5Vwb9eumVPgely/VmQqxshbOU3GEMXyJBiGDpcAcnT06svSAvXuTXEBNIjeQz
 kdVofZ6YD4WJsBPEM0IDSTEw+wyw9N9YpYmJF4d92yQqPfeYVyMXGrPmYeJRjQEYDyhV
 G6g48mEVVRb7FWp0D/S332VzBAilVOp/5o+5AK0n7JRgIa2+AJsLNW4nksl9Hz4K4DUA
 mhfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719558320; x=1720163120;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dnn8g/1r/IDbgXO0nM+fG6kuhQufIGWzDGBB4WRk/v4=;
 b=ckVRDOEBheUyzlpyXg7ZZo6Akqr0KpKeGMJjUggFLvzH8NnaBQC6rTo0/D5Riuteb5
 AVZ9fpxZqrJQC8AUH323D/0HW2OxnXKH+ZpOfb4QYHr3cppFyYjhr4M9mtmZpnSvr5Wr
 FQ428WmB4/fhkSPptHLd1J1BGoxsRQwodq4WynAQG0juhdjuXcwjrOTQsNQe+8A+ZnVx
 F0IVwGDueW6769/f6pNDHr+znjmpZEanMcYyRmkwCGd57pRKL2vwsj6sRCogJS5yrCAA
 +tLGI1dfvWG4FGAoxpeCaq3++7+Ox3P254jAd6FVZJRoPvUUkvXJ72bGZqNirTAVqa6Z
 FmfQ==
X-Gm-Message-State: AOJu0YybLAmFFPXJjTg5LilXBQHahWt7N9vckNrjJ2JcvtJm75sK+a8d
 duTEBKZZnSszKiO7T798rTmSFcqwgM6FgbbXWynNDzAHQcV71Y/rbVfLLMv8aWTGux0jHrFi+KX
 sbx8=
X-Google-Smtp-Source: AGHT+IGZb0VvpY2I07c6luZbJ1Vdeh+Lcly1MGCUMGW31qnfMw2/bUKsM+JdYROp3640943K3afZkA==
X-Received: by 2002:a2e:97c7:0:b0:2eb:e787:47ea with SMTP id
 38308e7fff4ca-2ec5b333198mr90628471fa.12.1719558320484; 
 Fri, 28 Jun 2024 00:05:20 -0700 (PDT)
Received: from m1x-phil.lan (cho94-h02-176-184-4-239.dsl.sta.abo.bbox.fr.
 [176.184.4.239]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a1108b0sm1313092f8f.114.2024.06.28.00.05.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 28 Jun 2024 00:05:19 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH v42 29/98] hw/sd/sdcard: Introduce sd_cmd_to_receivingdata /
 sd_generic_write_byte
Date: Fri, 28 Jun 2024 09:01:05 +0200
Message-ID: <20240628070216.92609-30-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240628070216.92609-1-philmd@linaro.org>
References: <20240628070216.92609-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22f;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22f.google.com
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

All commands switching from TRANSFER state to (receiving)DATA
do the same: receive stream of data from the DAT lines. Instead
of duplicating the same code many times, introduce 2 helpers:
- sd_cmd_to_receivingdata() on the I/O line setup the data to
  be received on the data[] buffer,
- sd_generic_write_byte() on the DAT lines to push the data.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sd.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index cd308e9a89..690a3f275e 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1100,6 +1100,22 @@ static sd_rsp_type_t sd_cmd_unimplemented(SDState *sd, SDRequest req)
     return sd_illegal;
 }
 
+/* Configure fields for following sd_generic_write_byte() calls */
+__attribute__((unused))
+static sd_rsp_type_t sd_cmd_to_receivingdata(SDState *sd, SDRequest req,
+                                             uint64_t start, size_t size)
+{
+    if (sd->state != sd_transfer_state) {
+        return sd_invalid_state_for_cmd(sd, req);
+    }
+    sd->state = sd_receivingdata_state;
+    sd->data_start = start;
+    sd->data_offset = 0;
+    /* sd->data[] used as receive buffer */
+    sd->data_size = size ?: sizeof(sd->data);
+    return sd_r1;
+}
+
 /* Configure fields for following sd_generic_read_byte() calls */
 static sd_rsp_type_t sd_cmd_to_sendingdata(SDState *sd, SDRequest req,
                                            uint64_t start,
@@ -1953,6 +1969,19 @@ send_response:
     return rsplen;
 }
 
+/* Return true if buffer is consumed. Configured by sd_cmd_to_receivingdata() */
+__attribute__((unused))
+static bool sd_generic_write_byte(SDState *sd, uint8_t value)
+{
+    sd->data[sd->data_offset] = value;
+
+    if (++sd->data_offset >= sd->data_size) {
+        sd->state = sd_transfer_state;
+        return true;
+    }
+    return false;
+}
+
 /* Return true when buffer is consumed. Configured by sd_cmd_to_sendingdata() */
 static bool sd_generic_read_byte(SDState *sd, uint8_t *value)
 {
-- 
2.41.0


