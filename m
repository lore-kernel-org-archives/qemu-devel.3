Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7DBAC2BBCA
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 06:11:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLzOi-0001Ss-B5; Tue, 25 Jun 2024 02:11:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sLzOg-0001Bx-9G
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 02:11:18 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sLzOd-0005kl-BK
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 02:11:16 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-42122ac2f38so29938225e9.1
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2024 23:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719295873; x=1719900673; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Rg76PJz13yQ4blnaKM+Id2Hp7ZcBNraiQTaF1NSzcFU=;
 b=QOTsUU4VQcBwK7n8esfW1nxdufy5YhdUcB1fc3KlQIUYiGyDyyEWu0eR+JnjpCc60F
 fNWXBp0vFqnS8u2n7PkONOuVTVN4igHPDBiKcsShsRQ3vjKdNmwWEnPq1x7bYQ+wO+nY
 AlFWPLoA8yIrri3q/FugMp5GOgXhuBVA5itRH95NHGv2x4HTLEQq+EJyp0WlNbCVVAIO
 XqoecCWlv8NmO6FSjVkLeyP9QHBS6A3ncefQQoE0KQbiRB/i68tr0XaXl5jZGUR8orM0
 Erom7e3bSm33QQj+I79gQdRrSJ6xjkLWH3oDBqjhqgSdwjFLmYzso6hoeGW4IugimtbW
 J1Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719295873; x=1719900673;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Rg76PJz13yQ4blnaKM+Id2Hp7ZcBNraiQTaF1NSzcFU=;
 b=fSvayi9842VfWLS4RlZwK+QepXIFKroYVPsr5auVIbSSn8Me/qh96VeGcIxAv8zKFv
 32SOyS8p4nx5xE87jV8hEjc8jno4Q4Kur1nKqeEHYHinfwJSA+bCbY2IPSPOHt6INeQ2
 TGZtctX8XeFAUVt5+hg3ozNljrWsOH8PW+Kl/RehBLb0c3vwq2q9gU9lWuyY+wRUbiMV
 vgEL/f/XTJ0J5acYlK9q2qcpm7JnBidwsGB0KxRtdZRPh/9DBJtO5NuflvZX1Jaedb/+
 o+kl/TMH/V/dIzgf+qpc50IxoQtxnBYs6iKRI/9MwB3HHuFfTP5M21r0xPIn0YcS6Lyn
 14qw==
X-Gm-Message-State: AOJu0Ywh5+diO6uPPoqiQ+4CFMbXm8F+zMlWhygLLxBIcmwIVa3YxLVM
 4fWag+JqcpxiVHPWgguRbwT+IdnKSqPfDawaAHwMWIG/MytoVrcek6/Ra2NyphxNS3u3koQUJqN
 E
X-Google-Smtp-Source: AGHT+IGOmRdWsjs5kouN242tEwSKZULjp8WvVNUV7EPm9THpWZ65THgIAidMXcSl2zjyJ6H3LrE+Bw==
X-Received: by 2002:a05:600c:1c03:b0:424:895c:b84b with SMTP id
 5b1f17b1804b1-424895cb8afmr68828375e9.4.1719295873296; 
 Mon, 24 Jun 2024 23:11:13 -0700 (PDT)
Received: from m1x-phil.lan (bd137-h02-176-184-46-22.dsl.sta.abo.bbox.fr.
 [176.184.46.22]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-366388c401asm11961960f8f.45.2024.06.24.23.11.12
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 24 Jun 2024 23:11:12 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 qemu-block@nongnu.org, Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 09/11] hw/sd/sdcard: Convert SD_STATUS to generic_read_byte
 (ACMD13)
Date: Tue, 25 Jun 2024 08:10:13 +0200
Message-ID: <20240625061015.24095-10-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240625061015.24095-1-philmd@linaro.org>
References: <20240625061015.24095-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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
 hw/sd/sd.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index bf78f06b5c..2f00184bb3 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1681,10 +1681,9 @@ static sd_rsp_type_t sd_app_command(SDState *sd,
     case 13:  /* ACMD13: SD_STATUS */
         switch (sd->state) {
         case sd_transfer_state:
-            sd->state = sd_sendingdata_state;
-            sd->data_start = 0;
-            sd->data_offset = 0;
-            return sd_r1;
+            return sd_cmd_to_sendingdata(sd, req, 0,
+                                         sd->sd_status,
+                                         sizeof(sd->sd_status));
 
         default:
             break;
@@ -2114,6 +2113,7 @@ uint8_t sd_read_byte(SDState *sd)
     case 6:  /* CMD6:   SWITCH_FUNCTION */
     case 9:  /* CMD9:   SEND_CSD */
     case 10: /* CMD10:  SEND_CID */
+    case 13: /* ACMD13: SD_STATUS */
     case 17: /* CMD17:  READ_SINGLE_BLOCK */
     case 19: /* CMD19:  SEND_TUNING_BLOCK (SD) */
     case 30: /* CMD30:  SEND_WRITE_PROT */
@@ -2121,13 +2121,6 @@ uint8_t sd_read_byte(SDState *sd)
         sd_generic_read_byte(sd, &ret);
         break;
 
-    case 13:  /* ACMD13: SD_STATUS */
-        ret = sd->sd_status[sd->data_offset ++];
-
-        if (sd->data_offset >= sizeof(sd->sd_status))
-            sd->state = sd_transfer_state;
-        break;
-
     case 18:  /* CMD18:  READ_MULTIPLE_BLOCK */
         if (sd->data_offset == 0) {
             if (!address_in_range(sd, "READ_MULTIPLE_BLOCK",
-- 
2.41.0


