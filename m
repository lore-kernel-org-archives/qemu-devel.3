Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70813C48BC0
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Feb 2024 22:05:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYCV8-0007HV-US; Thu, 08 Feb 2024 17:04:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1rYCV6-0007Go-UJ
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 17:04:08 -0500
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1rYCV5-0005EU-FN
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 17:04:08 -0500
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-5114b2b3b73so404443e87.0
 for <qemu-devel@nongnu.org>; Thu, 08 Feb 2024 14:04:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707429845; x=1708034645; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0461Lk3WojhtHzTq9fxFfcBVmhnoqCjvYfBQDy5dsCI=;
 b=FXAquwsJ3XgkXq91/RIf3UnKjlhwcsddOQiOMfjzd4EEbbLh/I+EgwjdwoZghFTWDh
 tCezqsSSGt5J8ouEWsbfB2oePqNjcJr8DwOHsELllo3gRs4b+HJpHPtR1UDhtMfa+RTX
 v1R8AWmyhuJ5IvzYTm3wW2LLgrw5n/iaW5Z2ahadZEbCEGY3a4vmF0vAcMWm+HyygR6p
 g+ro3ON/cgYkpflv2Lg1cUdcpRIlCGHCxApYkrP7PVC110ugGTvlpnviVKdzgkvFtZJw
 xTUSg9EDIXB70uaSRUWSAcv0yg2Bpzn84RZmyDOSAnsOkwYsvR9+3ZFpo4DK79nKVnMQ
 MDyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707429845; x=1708034645;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0461Lk3WojhtHzTq9fxFfcBVmhnoqCjvYfBQDy5dsCI=;
 b=hFM5vW+j04qSyW2Pr12jcz0+laizlqioNhBfyiA/6XLXe9EGnI/zBBZbQluKdx8aKH
 o+eHSvL1JA/P7qkGjKy+ofCrCGMNTk3XCaZoN1V0K5PeYuvuB5NsTld4pt7M+lELjcFU
 aeNrZ2u+BGVm+XcOYo0poGI1Y3ZWOJxSn7bwwXhA9R7us+5f4hfj9bPBIL0xitCeIfkr
 DiQsqJaI7OQOaWNaoMB/ApP6ip7GHsx3C/0Bs6Hs5m90gVV9ck4hbvVqzk1cM9WrC+qV
 xsOou52xFklTBTnw5jWyKlO/ycUBQRJItGlHjVs97xiQTDx3Zv+AlYm7TvzN9Pi0lLqb
 gF/Q==
X-Gm-Message-State: AOJu0YxnTP9Cd203kvc6cwDGf6YzXtExh/mFDSXRbvOY90DkwZkDUmQ8
 83k0mnjvyp0Y1O0IJLGy+tKxpckDSzx9dTlGLIV9ONKwQXrjS/QqJaHJrlzb
X-Google-Smtp-Source: AGHT+IHv4/p5e0kYcy3x++Ne20LUzycxLgDY/PGpWo3UfT0MAT/+GS/k6BUCbC4ItPDe4oKXTO2A0g==
X-Received: by 2002:a05:6512:2e8:b0:511:5711:4f35 with SMTP id
 m8-20020a05651202e800b0051157114f35mr380000lfq.23.1707429844818; 
 Thu, 08 Feb 2024 14:04:04 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVqW8cBDYNfBT+rbvCVUNgttSyKUoX1SVLMdHgBc+tx7zSlvshO5dIOjhN0Ot/nU9eTCHMXrUBBTha8u/90Hxm3fMnwSeACbyIQKn2Lu5tfV7OhQlAIYZBo2PVqugyvJZh7X6wp/YTmWFonzvg+OfzdpWcdWmL65bdiWPQtrldy7OYIrj2XK4mbOXDpBbnIrIHYjanCB8w+cvsxAAr1cYwzmt6GJWsNJ2beFZaNQS2TBewyT2lv
Received: from archlinux.. (pd95ed842.dip0.t-ipconnect.de. [217.94.216.66])
 by smtp.gmail.com with ESMTPSA id
 ti9-20020a170907c20900b00a3109a492d4sm109753ejc.20.2024.02.08.14.04.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Feb 2024 14:04:03 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Sergio Lopez <slp@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 7/9] hw/i386/pc_sysfw: Inline pc_system_flash_create() and
 remove it
Date: Thu,  8 Feb 2024 23:03:47 +0100
Message-ID: <20240208220349.4948-8-shentey@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240208220349.4948-1-shentey@gmail.com>
References: <20240208220349.4948-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12d;
 envelope-from=shentey@gmail.com; helo=mail-lf1-x12d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

pc_system_flash_create() checked for pcmc->pci_enabled which is redundant since
its caller already checked it. The method can be turned into just two lines, so
inline and remove it.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/i386/pc_sysfw.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
index b4c3833352..2dcaa116ad 100644
--- a/hw/i386/pc_sysfw.c
+++ b/hw/i386/pc_sysfw.c
@@ -91,18 +91,6 @@ static PFlashCFI01 *pc_pflash_create(PCMachineState *pcms,
     return PFLASH_CFI01(dev);
 }
 
-static void pc_system_flash_create(PCMachineState *pcms)
-{
-    PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
-
-    if (pcmc->pci_enabled) {
-        pcms->flash[0] = pc_pflash_create(pcms, "system.flash0",
-                                          "pflash0");
-        pcms->flash[1] = pc_pflash_create(pcms, "system.flash1",
-                                          "pflash1");
-    }
-}
-
 static void pc_system_flash_cleanup_unused(PCMachineState *pcms)
 {
     char *prop_name;
@@ -212,7 +200,8 @@ void pc_system_firmware_init(PCMachineState *pcms,
         return;
     }
 
-    pc_system_flash_create(pcms);
+    pcms->flash[0] = pc_pflash_create(pcms, "system.flash0", "pflash0");
+    pcms->flash[1] = pc_pflash_create(pcms, "system.flash1", "pflash1");
 
     /* Map legacy -drive if=pflash to machine properties */
     for (i = 0; i < ARRAY_SIZE(pcms->flash); i++) {
-- 
2.43.0


