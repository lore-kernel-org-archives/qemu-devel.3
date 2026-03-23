Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B00EF483CC
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 16:53:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4iWz-0002bJ-68; Mon, 23 Mar 2026 12:53:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w4iWq-00029Y-7s
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 12:53:24 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w4iWo-0000WQ-Dy
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 12:53:23 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-439d8df7620so2876588f8f.0
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2026 09:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774284801; x=1774889601; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=2OS9dwrhVLnfvMFaD7Eherrp2nRjOZpeUcPJ4Mmm4SM=;
 b=AksaxL2NbNoA5YHJNc0uQghfRh1ld8G2ig4CRGnmyV9j3hN9lrvqLubFjJj2JHokZl
 8DNp2fT9gtvF7K6Dravip7NZe3pegRV9GktwuFjkPxPvflJjimb4vdRBamcZrgBCo4Xu
 bl8Em+Y+GKgEJnBXf1R131mqm/AEzdyOuemeIraMK4gC3KhhD8fb0sbzPEbGIce6YSb+
 EGbwFHJYTh/2wWQU9sm5RiEdxj0JY6XFU/Hw1Acsoas9ETGn2L8nMWWgXqV3KBTx/JI/
 hy9cINXc1az3shA+TZWT8qiAP2Pg6NpYcVavAfZolQashuWLDfdRE0tx1RZbyRX7pq+m
 tfvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774284801; x=1774889601;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=2OS9dwrhVLnfvMFaD7Eherrp2nRjOZpeUcPJ4Mmm4SM=;
 b=T7iTcIrGNObWSDEU/EAzfxb0MlGN2yVQAdJXeoGjk50GVaCo3RPPgYyIXiyUa2mqba
 XOn3rB2wglctkqTndIdm0/qfJBOQVRHQw4lzRHaEKe3o8vazrETqfyJpEq2Xe/os33ce
 3DXSrC9Zmaq+PX4lX5RbFAjLJ4WOdv5IBf7++VSHxLZF5asAWnQK5nQCwo3n0u96jXxO
 q7Q0HoOEtv576C3f5jqkOgtkwjYZ4UC2Zy3gYmMgQhV3qBmpoiCRkSm5QuipTlUGjhZl
 uLGx7x2TsLpWKra4y8EYC5bpWNScc4VAFldsKCpEXK1Pof6izRDfmsOF3GNjizBcDNzw
 9iuQ==
X-Gm-Message-State: AOJu0YydTOMVm5+02c4N59s0AjcvnkmUfNzFEwtLUfOSs7AVLFt6zhox
 vizKJ1Geg8miSgCUY7qjufmmScFGmFf44DqFUesl1OJvmx/xNiv/Fyi/BT1ck/2youzcOI4R7qa
 wYnc2v3g=
X-Gm-Gg: ATEYQzxj2li6BVFK6REPW+VPiDoOXXK8ZwMsVhQl7zwrTH3o9woflSyAnrPSyLp7sEE
 3YtOAOGq2MAmWppZ7lLqsGNxCAM8jWs7oVwv5/MCBDoKQZFlNufQ5M0C+2hwWEhuhmttu+sdRQ9
 TtKuVkEsfK7loNRog2ypPki9TUEVwGXPhpHIBWJ/NbK9IVq66zBtedqhWl7w1ymO0PTFQaib9E5
 EWoTHe5awBUMrGVmsgVxFcY+z0uJwmasxmddST73Fr1w3fF3/gKCvgptqYPXTB57JMScifbwYlS
 5C06N+uMEIyf7xPcX12qtERsqJ6jhu9ZxP8bt3fd1xpihx02gSw77GrMpOgUgK+JK0Y6s4/n/2M
 kT/It6S6xTFHe9Z4LUmI7C+efr17Kl/hs1Kv6usaMOys2y7n1tKF5WEsdD3dhJ0P6Uu/oY/SpjF
 e/g//m8CMiaJiVFv4UusG9xCWeSGAyph+2VUeVnbdA8jRgCZM4HDFGm/8f6S2eu+zMwZrfaTp7
X-Received: by 2002:a05:6000:2c0e:b0:439:c279:32df with SMTP id
 ffacd0b85a97d-43b6427feadmr21007083f8f.35.1774284800585; 
 Mon, 23 Mar 2026 09:53:20 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b64717e97sm32692491f8f.35.2026.03.23.09.53.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 23 Mar 2026 09:53:20 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 09/27] hw/i386/pc_sysfw: stub out x86_firmware_configure
Date: Mon, 23 Mar 2026 17:52:00 +0100
Message-ID: <20260323165218.96607-10-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323165218.96607-1-philmd@linaro.org>
References: <20260323165218.96607-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Ani Sinha <anisinha@redhat.com>

x86_firmware_configure requires ovmf support. Add a stub for this function call
for cases where OVMF is not supported.

Reported-by: Michael Tokarev <mjt@tls.msk.ru>
Signed-off-by: Ani Sinha <anisinha@redhat.com>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Tested-by: Michael Tokarev <mjt@tls.msk.ru>
Message-ID: <20260319122137.142178-2-anisinha@redhat.com>
Tested-by: Xudong Hao <xudong.hao@intel.com>
[PMD: Remove "kvm/tdx.h" include line]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/i386/pc_sysfw.c            | 32 --------------------------------
 hw/i386/pc_sysfw_ovmf-stubs.c |  5 +++++
 hw/i386/pc_sysfw_ovmf.c       | 33 +++++++++++++++++++++++++++++++++
 3 files changed, 38 insertions(+), 32 deletions(-)

diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
index d8a86756ca4..1a41a5972bd 100644
--- a/hw/i386/pc_sysfw.c
+++ b/hw/i386/pc_sysfw.c
@@ -37,7 +37,6 @@
 #include "hw/block/flash.h"
 #include "system/kvm.h"
 #include "target/i386/sev.h"
-#include "kvm/tdx.h"
 
 #define FLASH_SECTOR_SIZE 4096
 
@@ -283,34 +282,3 @@ void pc_system_firmware_init(PCMachineState *pcms,
         }
     }
 }
-
-void x86_firmware_configure(hwaddr gpa, void *ptr, int size)
-{
-    int ret;
-
-    /*
-     * OVMF places a GUIDed structures in the flash, so
-     * search for them
-     */
-    pc_system_parse_ovmf_flash(ptr, size);
-
-    if (sev_enabled()) {
-
-        /* Copy the SEV metadata table (if it exists) */
-        pc_system_parse_sev_metadata(ptr, size);
-
-        ret = sev_es_save_reset_vector(ptr, size);
-        if (ret) {
-            error_report("failed to locate and/or save reset vector");
-            exit(1);
-        }
-
-        sev_encrypt_flash(gpa, ptr, size, &error_fatal);
-    } else if (is_tdx_vm()) {
-        ret = tdx_parse_tdvf(ptr, size);
-        if (ret) {
-            error_report("failed to parse TDVF for TDX VM");
-            exit(1);
-        }
-    }
-}
diff --git a/hw/i386/pc_sysfw_ovmf-stubs.c b/hw/i386/pc_sysfw_ovmf-stubs.c
index aabe78b2710..b53906a0521 100644
--- a/hw/i386/pc_sysfw_ovmf-stubs.c
+++ b/hw/i386/pc_sysfw_ovmf-stubs.c
@@ -24,3 +24,8 @@ void pc_system_parse_ovmf_flash(uint8_t *flash_ptr, size_t flash_size)
 {
     g_assert_not_reached();
 }
+
+void x86_firmware_configure(hwaddr gpa, void *ptr, int size)
+{
+    g_assert_not_reached();
+}
diff --git a/hw/i386/pc_sysfw_ovmf.c b/hw/i386/pc_sysfw_ovmf.c
index da947c3ca41..2f7d15c9f3e 100644
--- a/hw/i386/pc_sysfw_ovmf.c
+++ b/hw/i386/pc_sysfw_ovmf.c
@@ -28,6 +28,8 @@
 #include "hw/i386/pc.h"
 #include "exec/target_page.h"
 #include "cpu.h"
+#include "target/i386/sev.h"
+#include "kvm/tdx.h"
 
 #define OVMF_TABLE_FOOTER_GUID "96b582de-1fb2-45f7-baea-a366c55a082d"
 
@@ -160,3 +162,34 @@ bool pc_system_ovmf_table_find(const char *entry, uint8_t **data,
     }
     return false;
 }
+
+void x86_firmware_configure(hwaddr gpa, void *ptr, int size)
+{
+    int ret;
+
+    /*
+     * OVMF places a GUIDed structures in the flash, so
+     * search for them
+     */
+    pc_system_parse_ovmf_flash(ptr, size);
+
+    if (sev_enabled()) {
+
+        /* Copy the SEV metadata table (if it exists) */
+        pc_system_parse_sev_metadata(ptr, size);
+
+        ret = sev_es_save_reset_vector(ptr, size);
+        if (ret) {
+            error_report("failed to locate and/or save reset vector");
+            exit(1);
+        }
+
+        sev_encrypt_flash(gpa, ptr, size, &error_fatal);
+    } else if (is_tdx_vm()) {
+        ret = tdx_parse_tdvf(ptr, size);
+        if (ret) {
+            error_report("failed to parse TDVF for TDX VM");
+            exit(1);
+        }
+    }
+}
-- 
2.53.0


