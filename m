Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9FA5C27C4F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 16:07:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJbJb-00031f-QA; Tue, 18 Jun 2024 12:04:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJbJa-0002rQ-Da
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 12:04:10 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJbJY-0007EI-M5
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 12:04:10 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a63359aaacaso885654966b.1
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 09:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718726647; x=1719331447; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZUJRlw74V6bj0hWvpTvL5p3m//nV/ZZAuP7J5GTceY8=;
 b=PSHsmvlNo3hQRASdIc6zbwDSrs7eYHXnyMQIYJeZULFlGgX3aCMS7pPbM8wiOgS1Ol
 cBLdmVMKal7iKnk6CODTzDzF/FH1jg5WIukK3iDCMcleq9ZhXG/ZqANZ/LnaRrGCyZbn
 Zz3fuXO1wXSLAKB3vMoZjE2zxvZKwcxzPzctkH7LtgDgo7qU0QFF1820lDy+Wy00fGXt
 cDbq7iwlCnxnybbEndpKZFUl3mz4+CHZSM/5jOLkh3Wvg/8u//giTo8vsFvnetQVTUEW
 stFZV2XEhj+ljEAmqfUsgAXbY6Q/SGAOaI7W0l4hlP/I1tRPpUgpJzzd7qU20X0aKM2a
 SnRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718726647; x=1719331447;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZUJRlw74V6bj0hWvpTvL5p3m//nV/ZZAuP7J5GTceY8=;
 b=tGYsnjfRzIgl6W0kUHqXA33ydHaxwNw6H9N1Ls3KEM3pc8/T78vvT/wZgGWJWlH2ty
 D8+RtYecrWhcy4S/KUfDnzBy400HwteFGsKQbcA3iglanEHZAdLjeipu+sahrmrPai5X
 SucAJ2k7eeqQ/4TlcE0mmSGHdaE5533CwJY7UBdf778mz7rInpmzh+S/XSq/eEeQy/pz
 aP/aHDZXmvKpxaDDjTCq9s+PxFRdrhdkMRFFehNv6y3WijqpBnczBmYhPVkFJg3/JEKh
 MG9M1RlntZKf3wr8sUYTzoGwERrPJVB3Qd5WJV7wv7+WzDskPZKkX08MCuHu5E0u256o
 L/KQ==
X-Gm-Message-State: AOJu0YzIi68M46CKEaWsY2eJAssqsmSSjC3aBIBgbql6bLHly9zAlEzG
 2MKvU/C7mHlWkItPK9AYVJ80SyAksQvbvYs/G15Fa+Bd+kOUFlUUiNAjtgy9XnQNhvtknNZv2Ll
 a
X-Google-Smtp-Source: AGHT+IGFuR/tWexYuFHAhcP8RX+CEyGYW9ui2zbQucFoY+0ZjfEoOByyjnHs165AMqr8qlE3XrUYmA==
X-Received: by 2002:a17:906:d791:b0:a68:bae4:d66f with SMTP id
 a640c23a62f3a-a6f60d29797mr891500666b.30.1718726647042; 
 Tue, 18 Jun 2024 09:04:07 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.212.55])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f56db6dfesm624700466b.87.2024.06.18.09.04.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 18 Jun 2024 09:04:05 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PULL 35/76] hw/ppc: Avoid using Monitor in xive_eas_pic_print_info()
Date: Tue, 18 Jun 2024 17:59:57 +0200
Message-ID: <20240618160039.36108-36-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240618160039.36108-1-philmd@linaro.org>
References: <20240618160039.36108-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Replace Monitor API by HumanReadableText one.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Message-Id: <20240610062105.49848-12-philmd@linaro.org>
---
 include/hw/ppc/xive_regs.h |  2 +-
 hw/intc/pnv_xive.c         | 10 +++++-----
 hw/intc/xive.c             | 12 ++++++------
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/include/hw/ppc/xive_regs.h b/include/hw/ppc/xive_regs.h
index 51e9a2152e..dd4a76bcf0 100644
--- a/include/hw/ppc/xive_regs.h
+++ b/include/hw/ppc/xive_regs.h
@@ -167,7 +167,7 @@ typedef struct XiveEAS {
 #define xive_eas_is_valid(eas)   (be64_to_cpu((eas)->w) & EAS_VALID)
 #define xive_eas_is_masked(eas)  (be64_to_cpu((eas)->w) & EAS_MASKED)
 
-void xive_eas_pic_print_info(XiveEAS *eas, uint32_t lisn, Monitor *mon);
+void xive_eas_pic_print_info(XiveEAS *eas, uint32_t lisn, GString *buf);
 
 static inline uint64_t xive_get_field64(uint64_t mask, uint64_t word)
 {
diff --git a/hw/intc/pnv_xive.c b/hw/intc/pnv_xive.c
index 520d7e0acd..c377823522 100644
--- a/hw/intc/pnv_xive.c
+++ b/hw/intc/pnv_xive.c
@@ -1864,19 +1864,19 @@ void pnv_xive_pic_print_info(PnvXive *xive, Monitor *mon)
     g_string_append_printf(buf, "XIVE[%x] #%d Source %08x .. %08x\n",
                            chip_id, blk, srcno0, srcno0 + nr_ipis - 1);
     xive_source_pic_print_info(&xive->ipi_source, srcno0, buf);
-    info = human_readable_text_from_str(buf);
-    monitor_puts(mon, info->human_readable_text);
 
-    monitor_printf(mon, "XIVE[%x] #%d EAT %08x .. %08x\n", chip_id, blk,
-                   srcno0, srcno0 + nr_ipis - 1);
+    g_string_append_printf(buf, "XIVE[%x] #%d EAT %08x .. %08x\n",
+                           chip_id, blk, srcno0, srcno0 + nr_ipis - 1);
     for (i = 0; i < nr_ipis; i++) {
         if (xive_router_get_eas(xrtr, blk, i, &eas)) {
             break;
         }
         if (!xive_eas_is_masked(&eas)) {
-            xive_eas_pic_print_info(&eas, i, mon);
+            xive_eas_pic_print_info(&eas, i, buf);
         }
     }
+    info = human_readable_text_from_str(buf);
+    monitor_puts(mon, info->human_readable_text);
 
     monitor_printf(mon, "XIVE[%x] #%d ENDT\n", chip_id, blk);
     i = 0;
diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 1adb0439c5..b2203b721b 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -1921,17 +1921,17 @@ static const TypeInfo xive_router_info = {
     }
 };
 
-void xive_eas_pic_print_info(XiveEAS *eas, uint32_t lisn, Monitor *mon)
+void xive_eas_pic_print_info(XiveEAS *eas, uint32_t lisn, GString *buf)
 {
     if (!xive_eas_is_valid(eas)) {
         return;
     }
 
-    monitor_printf(mon, "  %08x %s end:%02x/%04x data:%08x\n",
-                   lisn, xive_eas_is_masked(eas) ? "M" : " ",
-                   (uint8_t)  xive_get_field64(EAS_END_BLOCK, eas->w),
-                   (uint32_t) xive_get_field64(EAS_END_INDEX, eas->w),
-                   (uint32_t) xive_get_field64(EAS_END_DATA, eas->w));
+    g_string_append_printf(buf, "  %08x %s end:%02x/%04x data:%08x\n",
+                           lisn, xive_eas_is_masked(eas) ? "M" : " ",
+                           (uint8_t)  xive_get_field64(EAS_END_BLOCK, eas->w),
+                           (uint32_t) xive_get_field64(EAS_END_INDEX, eas->w),
+                           (uint32_t) xive_get_field64(EAS_END_DATA, eas->w));
 }
 
 /*
-- 
2.41.0


