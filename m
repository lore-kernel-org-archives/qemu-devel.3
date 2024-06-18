Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51A4EC27C4F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 16:12:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJbKt-0006JK-QA; Tue, 18 Jun 2024 12:05:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJbKt-0006J8-4H
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 12:05:31 -0400
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJbKr-0007g8-E7
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 12:05:30 -0400
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-52c8c0d73d3so5900272e87.1
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 09:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718726727; x=1719331527; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XaPptVDdD74GAIoHXJ+it7pWAc5JUuZ8+jYkYbmUa/U=;
 b=QUaobIrPXC7yonNGOiXVcQR+iLCxnB3jXVz0NYzXKym8+t4IG/cWBmqOfETvlqSN5q
 vovA+9GmuI0GclnEH3b4zJYFZI9lYeOMT4NI+7OMqsu2DVuO+X423dBoIKi8ZHm+iP/0
 RgIKpJbPx79n+E1L4oGLz/pF2HLzDgdsRaRggsTfuZJZm/2B9I7FOGhtwVPj9QoJR3z0
 BnbuF3qG7ii+jTdTSuirLmoZKiDvlNmSRj0S8cq6lJgfzbJ9kFuzS7E7iFvq8mHm+QEt
 s2wx2U5Fl23iiR0a9XechiaMB6eY5qEY4MweGCrU5IT7f8oXkWtpzVI/HPo/e8cNHhs4
 NWGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718726727; x=1719331527;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XaPptVDdD74GAIoHXJ+it7pWAc5JUuZ8+jYkYbmUa/U=;
 b=D7WuKHG+Kh4Ddg7kdH8rICxtlno94KJBCJgje9jbJnp+htHEQoS9GX35eK+Qu/JlGc
 mrp88wtwE/ZEcSdAujcg25CBrPHyj6sB1cbrGKxg3+UBqiLSfVNxRcif0AvpKYA+pZeW
 7cNrgHFnp8t3PGu43WUHmzrGgTXJLudHBzVV6ctnwlxhALoft/WyITjdjEJmXb7IFcX+
 u+Ap4UN7UxNpEGWUJNSZ9nmkxZfcPW5/iVZccSihXd4A1+t3CgoDjqL4M3no+98Wwnc8
 OaLc9vT2R8MiWQc1ZL9ipejaZ5SS2Lc1C5aoSHEHorw8FqKeavPJPpSR8p2lPCHNGRSq
 7lmQ==
X-Gm-Message-State: AOJu0YyZOHQ4oD8iSY8tTgyA+b3HJ6gAk6n9QZ0n/w+GH+iv6CArHVo6
 mVLm9pfMlF3NgOZnytw3Aw8EbSs64FdibLviFKG5dF26EPV6xSBZvx8XOv5gRPsREYYZfogDbG1
 M
X-Google-Smtp-Source: AGHT+IEr7l+ZTzem3avoRO16PC+EhmooQHCk6H7XfvGMt4np0OlJ738ocgmmj0kf5zeCHthzeqX1gA==
X-Received: by 2002:a05:6512:3d04:b0:52b:c262:99b3 with SMTP id
 2adb3069b0e04-52ccaa5693emr40607e87.11.1718726726214; 
 Tue, 18 Jun 2024 09:05:26 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.212.55])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-422870e986asm233047535e9.27.2024.06.18.09.05.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 18 Jun 2024 09:05:25 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PULL 49/76] hw/ppc: Avoid using Monitor in
 pnv_chip_power9_pic_print_info_child()
Date: Tue, 18 Jun 2024 18:00:11 +0200
Message-ID: <20240618160039.36108-50-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240618160039.36108-1-philmd@linaro.org>
References: <20240618160039.36108-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12c.google.com
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
Message-Id: <20240610062105.49848-26-philmd@linaro.org>
---
 hw/ppc/pnv.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 5b9dbff754..9039c1777a 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -789,18 +789,14 @@ static void pnv_chip_power8_pic_print_info(PnvChip *chip, Monitor *mon)
 
 static int pnv_chip_power9_pic_print_info_child(Object *child, void *opaque)
 {
-    Monitor *mon = opaque;
+    GString *buf = opaque;
     PnvPHB *phb =  (PnvPHB *) object_dynamic_cast(child, TYPE_PNV_PHB);
-    g_autoptr(GString) buf = g_string_new("");
-    g_autoptr(HumanReadableText) info = NULL;
 
     if (!phb) {
         return 0;
     }
 
     pnv_phb4_pic_print_info(PNV_PHB4(phb->backend), buf);
-    info = human_readable_text_from_str(buf);
-    monitor_puts(mon, info->human_readable_text);
 
     return 0;
 }
@@ -813,12 +809,11 @@ static void pnv_chip_power9_pic_print_info(PnvChip *chip, Monitor *mon)
 
     pnv_xive_pic_print_info(&chip9->xive, buf);
     pnv_psi_pic_print_info(&chip9->psi, buf);
+    object_child_foreach_recursive(OBJECT(chip),
+                         pnv_chip_power9_pic_print_info_child, buf);
 
     info = human_readable_text_from_str(buf);
     monitor_puts(mon, info->human_readable_text);
-
-    object_child_foreach_recursive(OBJECT(chip),
-                         pnv_chip_power9_pic_print_info_child, mon);
 }
 
 static uint64_t pnv_chip_power8_xscom_core_base(PnvChip *chip,
@@ -865,13 +860,12 @@ static void pnv_chip_power10_pic_print_info(PnvChip *chip, Monitor *mon)
     g_autoptr(HumanReadableText) info = NULL;
 
     pnv_xive2_pic_print_info(&chip10->xive, buf);
-
     pnv_psi_pic_print_info(&chip10->psi, buf);
+    object_child_foreach_recursive(OBJECT(chip),
+                         pnv_chip_power9_pic_print_info_child, buf);
+
     info = human_readable_text_from_str(buf);
     monitor_puts(mon, info->human_readable_text);
-
-    object_child_foreach_recursive(OBJECT(chip),
-                         pnv_chip_power9_pic_print_info_child, mon);
 }
 
 /* Always give the first 1GB to chip 0 else we won't boot */
-- 
2.41.0


