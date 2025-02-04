Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D0ECC02194
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 18:31:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfNgG-0000wf-F2; Tue, 04 Feb 2025 13:29:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tfNgA-0000f7-FC
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 13:29:46 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tfNg8-00052X-FO
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 13:29:46 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4363ae65100so70383585e9.0
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2025 10:29:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738693780; x=1739298580; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4aC2ap/lG5aepYBxnBeqfmcNSow0ZaEbYXj6+8sjwn0=;
 b=n57ph8DLgLLgyq8Iw9YGtl7g3eZhRQJmCD7K1MCv1YQtia2ny//kmjyyiLDUWIs1WH
 1o5M7+nBs0A93utB8bfyVa/XOwAO/UVrVW9IwZBsBPZFlnxXa1W6Q0ljQIHIFNWUf+qS
 GKipALFNVsMeUwBeJvH+sKjG4WfuaFpzXqcRo/Fzh1mYnt/xUJy1L2orPI0ouraS55Ny
 /qkg4tIeCoHGf4D69/DbxIcY9DeEZKsSvpqKJ/x//iC0Kj87sYgNDjRZzFcR46lemXyX
 MHzZ0VAts7yrsk77Hr2je5uiEZlkGigpJpA9qrRydFJlhBTGYcyYHd7gyUFy7JjNXIvT
 +B8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738693780; x=1739298580;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4aC2ap/lG5aepYBxnBeqfmcNSow0ZaEbYXj6+8sjwn0=;
 b=uQX/WN3yoTZW1ABsnskY6bQdCP6Gs8OC/Ln8lqynQ38+AozkacWLXp9A5+rx4m8b4m
 gaJC40qq+aJWWPvOLKaIPoo64z9nPVXJrB3ya4SyGP006hk/DI0rTDe13sooMyxw2jZV
 WEyrk9b3bzUAk08eVUDWnJ/7avDYSTGispNQBtftuoI6A2QOnfDScaOvUAGO5sWUxTwF
 XFsaGHAmGS9TW8SWySIZfhGF/b9ydKHVeiUs1SUIfQzYNDX6DnRwzg6puSZ+3m0A4V14
 RyS1xKXHitHzwZNJoCW3wpLJBSnVd4QdF4gOP8EwK5RsNiCjQgU8KVhCSAtRV+YH+Kb3
 5V6A==
X-Gm-Message-State: AOJu0Yz/OJMRzrXe+Xdhk8LTwrgSR6M04hVnwKZLHeowzizirPFN9506
 4CF7RorLMsbPMhUkkADHqNmmnK2lL/XC0CcQZ7F0cmAe8Q/kj/h3LUTSJQkNQe1XSlCXbS3QV8z
 JHxo=
X-Gm-Gg: ASbGncvIi76/jwQLSNbrI45xhgb/dAxb/F/gkwR0uuBUsTfF9/AkqMRnPPdMpyFTEwG
 3L09XbX0wKTUuhx1pHCUSxyA48Iw4o8bdeH2tv4iHNV6kTCGx1PYTu21eTPUanHFBfkx7ez4Y/w
 DbcW9mgk5f4FjzkMLfpnG0/ds8fFx7WtAPHhOrrqWdchOz3gevLx4VYHPQj4/5iohyL08jfa7oq
 /fpEFSxuVrCLnMmojWVUjNjz7JGt3Y8aq5Ogb3yP64eKWeHtrR9rJq37VGfbxtgWsGASoXP81iJ
 NWphp4RSIJBQ2NwrOwM9d9UmzGvGXGzpdFUMVD5MxtWqGXpWGJg6HhN+/ty0JiMMkA==
X-Google-Smtp-Source: AGHT+IG/E9Q+Gi7WzrXBuMR76dKMZbSeQcI8aQXe0D9LcVIFOj5jGRiZNBd3m0VYQZ4DKt9dc8emBQ==
X-Received: by 2002:a05:600c:3488:b0:434:f5c0:329f with SMTP id
 5b1f17b1804b1-438dc3cb2a8mr304005545e9.14.1738693780102; 
 Tue, 04 Feb 2025 10:29:40 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438e245f492sm196719305e9.38.2025.02.04.10.29.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 04 Feb 2025 10:29:39 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-arm@nongnu.org, qemu-riscv@nongnu.org, qemu-s390x@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 7/7] hw/boards: Ensure machine setting auto_create_sdcard
 expose a SD Bus
Date: Tue,  4 Feb 2025 19:29:03 +0100
Message-ID: <20250204182903.59200-8-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250204182903.59200-1-philmd@linaro.org>
References: <20250204182903.59200-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

Using the auto_create_sdcard feature without SD Bus is irrelevant.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 system/vl.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/system/vl.c b/system/vl.c
index 5ff461ea4ca..dd8053e1e79 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -53,6 +53,7 @@
 #include "hw/usb.h"
 #include "hw/isa/isa.h"
 #include "hw/scsi/scsi.h"
+#include "hw/sd/sd.h"
 #include "hw/display/vga.h"
 #include "hw/firmware/smbios.h"
 #include "hw/acpi/acpi.h"
@@ -2661,12 +2662,19 @@ static void qemu_init_displays(void)
 
 static void qemu_init_board(void)
 {
+    MachineClass *machine_class = MACHINE_GET_CLASS(current_machine);
+
     /* process plugin before CPUs are created, but once -smp has been parsed */
     qemu_plugin_load_list(&plugin_list, &error_fatal);
 
     /* From here on we enter MACHINE_PHASE_INITIALIZED.  */
     machine_run_board_init(current_machine, mem_path, &error_fatal);
 
+    if (machine_class->auto_create_sdcard) {
+        /* Ensure there is a SD bus available to create SD card on */
+        assert(object_resolve_path_type("", TYPE_SD_BUS, NULL));
+    }
+
     drive_check_orphaned();
 
     realtime_init();
-- 
2.47.1


