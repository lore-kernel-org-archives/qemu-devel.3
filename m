Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BBEAC48BF6
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 22:00:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rej0P-0004oy-6x; Mon, 26 Feb 2024 16:59:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1rej0M-0004nX-Ck
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 16:59:22 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1rej0K-0007gn-65
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 16:59:21 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-412a87d5afcso6530755e9.3
 for <qemu-devel@nongnu.org>; Mon, 26 Feb 2024 13:59:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708984757; x=1709589557; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4klEzet8aHWpX9bQlWaepUmSR2xNV2bS+e5k8Ehj/tQ=;
 b=hbTj0JlixwAHTiDytZdy2Q+fgq1pGKqGDAtSxPiPVxArdm18gVNLEDQPDOSGuMy8Ej
 /5R6Hsxppwcs/t5XkVWjD6o1zPqKI760ITDkUZlYouVc5X7ZqXKIHR9gG5CsXmgprxwx
 EKPwdS8u349f1C2q8Dm/hyNa8jLT0B60PWhxIbJnqPigaSLsKJoGye61RH14EjsTDq6F
 HE3g0SHOsqGCYsX0uC30WQq4VFgwhpXxPHVlBpfaY6IhbY2Pz/xh3gohpyu3SWuswSJ8
 12/z32rCsn46JkDhECzdIotk9SrfjWavTWIsEN0wPVBn72xBErdifP2RraMQiNHDKJ2b
 ZR+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708984757; x=1709589557;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4klEzet8aHWpX9bQlWaepUmSR2xNV2bS+e5k8Ehj/tQ=;
 b=fzp9ZeQDUFxz0BCh6DqbtWypOwxoPRHyT4GhBMIERHHGlQXrvtNWujzyIg1kg8Joad
 ZJd9Fv7FiepkJ0yJBGiEGsjUKmwKfPzxjvdQqZW1GNUqh5d9jjLxEyo6DmE6WV0jlByx
 01ZaKEN2xQrhW+/I9FRUgfbkiB6+kYgz2hKnMjFB8SYhd/k0hz22QXwTD2ZB1YLPDlzR
 MgUG8QxA4cQ2PJPxC3DTtXz1o69qCsmrcLrTVYxYI7/sJfXwxtGGkAU9PM0Xwry0KOnp
 ouMLQfTeM5DrwFJlRWXptfweTr42nIGNSazJ4l746neA6yQKxhWC0dToEKE7G1EN7/qv
 rFKw==
X-Gm-Message-State: AOJu0YxMLWgnD8p7h4PWWViPwxv16fRVeeatYiKYTBHcFk7EMQxcGDsv
 X43anI6PHCShkzWbyRr5NaI5CY/03MeL9FFuvdrAMHSooQneVsSYFCyOWxg2
X-Google-Smtp-Source: AGHT+IEAKoiB/SwRzqiWIZzu4KXctDE4U3g4bGT5PFx4HLAKgV2za+crwHUQoQ2ges2LUVUsTSt1Lw==
X-Received: by 2002:a5d:4b4f:0:b0:33d:81ca:532e with SMTP id
 w15-20020a5d4b4f000000b0033d81ca532emr6358708wrs.47.1708984757438; 
 Mon, 26 Feb 2024 13:59:17 -0800 (PST)
Received: from Provence.localdomain
 (dynamic-077-188-008-186.77.188.pool.telefonica.de. [77.188.8.186])
 by smtp.gmail.com with ESMTPSA id
 h4-20020a05600016c400b0033dda0e82e5sm3985753wrf.32.2024.02.26.13.59.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Feb 2024 13:59:17 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 1/2] Revert "hw/i386/pc_sysfw: Inline pc_system_flash_create()
 and remove it"
Date: Mon, 26 Feb 2024 22:59:08 +0100
Message-ID: <20240226215909.30884-2-shentey@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240226215909.30884-1-shentey@gmail.com>
References: <20240226215909.30884-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x32b.google.com
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

Commit 6f6ad2b24582 "hw/i386/pc: Confine system flash handling to pc_sysfw"
causes a regression when specifying the property `-M pflash0` in the PCI PC
machines:
  qemu-system-x86_64: Property 'pc-q35-9.0-machine.pflash0' not found
In order to revert the commit, the commit below must be reverted first.

This reverts commit cb05cc16029bb0a61ac5279ab7b3b90dcf2aa69f.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/i386/pc_sysfw.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
index b02e285579..b9c1eb352d 100644
--- a/hw/i386/pc_sysfw.c
+++ b/hw/i386/pc_sysfw.c
@@ -91,6 +91,18 @@ static PFlashCFI01 *pc_pflash_create(PCMachineState *pcms,
     return PFLASH_CFI01(dev);
 }
 
+static void pc_system_flash_create(PCMachineState *pcms)
+{
+    PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
+
+    if (pcmc->pci_enabled) {
+        pcms->flash[0] = pc_pflash_create(pcms, "system.flash0",
+                                          "pflash0");
+        pcms->flash[1] = pc_pflash_create(pcms, "system.flash1",
+                                          "pflash1");
+    }
+}
+
 static void pc_system_flash_cleanup_unused(PCMachineState *pcms)
 {
     char *prop_name;
@@ -198,8 +210,7 @@ void pc_system_firmware_init(PCMachineState *pcms,
         return;
     }
 
-    pcms->flash[0] = pc_pflash_create(pcms, "system.flash0", "pflash0");
-    pcms->flash[1] = pc_pflash_create(pcms, "system.flash1", "pflash1");
+    pc_system_flash_create(pcms);
 
     /* Map legacy -drive if=pflash to machine properties */
     for (i = 0; i < ARRAY_SIZE(pcms->flash); i++) {
-- 
2.44.0


