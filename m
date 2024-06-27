Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0877C2BD09
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 16:48:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMsI6-0007yj-HJ; Thu, 27 Jun 2024 12:48:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMsHF-0006gb-9t
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 12:47:22 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMsH8-0000Xo-NO
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 12:47:15 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4249196a361so37213685e9.0
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 09:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719506828; x=1720111628; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K1hpuhYvD8c8zKzHH2qCf+bpB7ESZQppXpuiPvi8zTE=;
 b=ZnQ+IFg3GeNE8erzfV7DiEE2v0aN3sBsZwqF4cGyJn6ZsFmPjiX3fL4YmWNNSWlIKm
 P5nuUUjzE9eQeujs70fENyW0LmqS9ImQx92U5Jdh2scUUsUxpFIfYGJ76c/1lyYLZsCP
 v4gYh2xBEfP6gORTPmS9VZE9qbWpKYUJNd3DXHGUG6dAbihI+GPHFjy/P7ZBFTKhZ0RE
 7tWHA3jRQaLBo17Ek5x6X6QV7CToNo6RqYvOdojZFUw4s7ib72opbQCsF+fcpYzQlC+r
 u0PgImbC8j/VgZXhgPnyiTz/NSvalMyB/6BDGasjJZiKKHbJ+WCWBC1zxcLd66tDxk8o
 Uh8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719506828; x=1720111628;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K1hpuhYvD8c8zKzHH2qCf+bpB7ESZQppXpuiPvi8zTE=;
 b=RSsSWhaetPl9aziCu5IMIX+choDym8FKXahD04Ordhi42LqgjsDpDBOskV0h1uwvYK
 cNKFAarXxct9K925/rZ8GN0z5QelEbnjFQnGvlLxkrcbskCtklROSwilN0PmR5OVTs0r
 UvVKoMygIpBxHjeQ1n63fhcy2OyOItudl8aZwloU6JjPW1DFQxq5nTn/wBR9h45BC5tD
 uXltjKhphXCCh0kVl+XZZQ95xRhc+85l4i4/kOaJhlFHUM6ynj2Xfj9dahVRXb8BgHpJ
 8dgVjFEo5SSfVlDFYcAGUy+HYPt6uNKUpdncMEtnG6M3x3Y8PF9mhu49zzUrk0Nmt7gL
 Jj8g==
X-Gm-Message-State: AOJu0Yx37ODj8ttjsP48GotJpRxRxLLsGF6VxFhcSfEHZKJtwtAilea3
 FhE68neTu2tZsLlvWBL7HI/1jZOOscQZ3WNBSKQa7jjpkhb7zGtvFpitPtZgEUm0+ih/BAr30oH
 AD/w=
X-Google-Smtp-Source: AGHT+IEP9ur16EZTFoNUvm+v/TfEIC6mNdrcuCyDDHVI6ZJnAbamqIQf4OdyLdiJOfGN7PbUXOGAYg==
X-Received: by 2002:a05:600c:35c1:b0:425:678b:901d with SMTP id
 5b1f17b1804b1-425678b923bmr10365825e9.21.1719506828603; 
 Thu, 27 Jun 2024 09:47:08 -0700 (PDT)
Received: from localhost.localdomain (33.red-95-127-46.staticip.rima-tde.net.
 [95.127.46.33]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42564b63ed6sm36993885e9.13.2024.06.27.09.47.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 27 Jun 2024 09:47:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Sai Pavan Boddu <sai.pavan.boddu@amd.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Joel Stanley <joel@jms.id.au>, Luc Michel <luc.michel@amd.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH 20/21] hw/sd/sdcard: Add spi_cmd_READ_OCR handler (CMD58)
Date: Thu, 27 Jun 2024 18:43:43 +0200
Message-ID: <20240627164345.82192-21-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240627164345.82192-1-philmd@linaro.org>
References: <20240627164345.82192-1-philmd@linaro.org>
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
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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
 hw/sd/sd.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 50cee5ac40..b3b4cd5a3a 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1660,6 +1660,12 @@ static sd_rsp_type_t sd_cmd_GEN_CMD(SDState *sd, SDRequest req)
     }
 }
 
+/* CMD58 */
+static sd_rsp_type_t spi_cmd_READ_OCR(SDState *sd, SDRequest req)
+{
+    return sd_r3;
+}
+
 static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
 {
     uint64_t addr;
@@ -1748,9 +1754,6 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
         return sd_cmd_to_receivingdata(sd, req, 0, sizeof(sd->cid));
 
     /* Application specific commands (Class 8) */
-    case 58:    /* CMD58:   READ_OCR (SPI) */
-        return sd_r3;
-
     case 59:    /* CMD59:   CRC_ON_OFF (SPI) */
         return sd_r1;
 
@@ -2321,6 +2324,7 @@ static const SDProto sd_proto_spi = {
         [55] = {8,  sd_spi, "APP_CMD", sd_cmd_APP_CMD},
         [56] = {8,  sd_spi, "GEN_CMD", sd_cmd_GEN_CMD},
         [57] = {10, sd_spi, "DIRECT_SECURE_WRITE", sd_cmd_optional},
+        [58] = {0,  sd_spi, "READ_OCR", spi_cmd_READ_OCR},
     },
     .acmd = {
         [41] = {8,  sd_spi, "SEND_OP_COND", spi_cmd_SEND_OP_COND},
-- 
2.41.0


