Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E051C19776
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2025 10:33:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnxcO-0004fu-3k; Fri, 28 Feb 2025 05:29:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tnxcI-00044Z-Bj
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 05:29:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tnxcG-00034j-GI
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 05:29:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740738550;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=+DMrxXx9yNiHRfE7c15UVqnEBDQXDM3LqZfmLT+HoYc=;
 b=ATnpKHF+6Zj7GkPdWpS6OGlIyNo6QHh3ZLwZpdEWWCLCc0jegs5V4f+XSIjILl3P4t3+w3
 M+rK3APqry4gey3AAD2gL6/q3BiCB1OBBWBGtazsuVYGU46Y77O4+QIteD62LPTkoBYuH4
 rjQ5KMmfgThE75geZQaCLZACNz5ZtLs=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-whlXIjzqMUaG9_eS7J7QgQ-1; Fri, 28 Feb 2025 05:29:06 -0500
X-MC-Unique: whlXIjzqMUaG9_eS7J7QgQ-1
X-Mimecast-MFC-AGG-ID: whlXIjzqMUaG9_eS7J7QgQ_1740738546
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-2fc1e7efdffso6468747a91.0
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2025 02:29:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740738546; x=1741343346;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+DMrxXx9yNiHRfE7c15UVqnEBDQXDM3LqZfmLT+HoYc=;
 b=PwzhdSKTwWxwNaK6zM6W6PncpSGf4FRK9PUli9iMnym7vWUR5M1X1IfC4l8G0KXWDE
 8cgdzW8RiBE6tLiQ98HO0CAXljE5K7qiWZnU/RjEXEXp6Dr/1vhVbg01D7WsZ99bRRCw
 gaASMHhzrfUv0/CGzhpQgql0AKTIzpT4inQuOszZgg1ojuX/69rPMhJzx6akMcNvBEzr
 1PFX8d20rZADVxoJch8vHP45o8Xg1EsNMbOanyU0KeQ0/uaL7c0YmU/cm3M8VlRSoSrQ
 PdWOBZSKk65drO+TPg5YXzhONz7GHiMJyDxqNJ+6cr+YAk6CohD8kV/8ZQ+swH/wTMTD
 ++NQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX5KRvy8pc8u9DFUnfLRqGbysXN10DACYSgUXn9FyKoLIHR8gltx6+1JJhpLSqL6ygGjh2KB8wwn7wz@nongnu.org
X-Gm-Message-State: AOJu0Yw9GLDHUNh+9qcnFGQYVO61KXC2Iczen+iggQm8/I6hALwBJnXO
 gsLoXDqzAJKVHjSzHUPg3dWGRvwPjKfdQla+UCB+an8vKE/9JWUuNfiWU0u0I8L1DVjpD174FHh
 iWantEpvPxProobu2HzdQmLA/OfrSxbnabTWS6I41TwREidWZ9TwX
X-Gm-Gg: ASbGnctng10aY4TL9JuNscYNdeTFhs4h5TB0RV2rNhtvAXKHX896GRmWzpg7qmTOSIr
 +i3VAgJP3FENvUdQtdRv1ABAlICCjuQTDoCjWg9NOMWBpkzVTwJ1um1ufiNf5CXCqguv2YQVoZs
 5uOzwx6+d3EIVFTHtDC8hFmoWFAPITbGl03V1fdzQ/T66WWwBNfg+Nfq6R7/t3foongmLLO+CLT
 YXsj+z+eC18FuIzxNuE1UXrn7H+E6dY1DLwFqR3sAHMchDvaueXN2iO4Lk/aUkWcjwSrjI0FWTq
 nNmkoQhrxgeQm75Z0sEwIA7Mpkug
X-Received: by 2002:a17:90b:2247:b0:2ee:d63f:d77 with SMTP id
 98e67ed59e1d1-2febab402f2mr4802824a91.9.1740738545791; 
 Fri, 28 Feb 2025 02:29:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHWgn6xXCjPuDZeGGum4kHBeelVGPc3XDTaUb7NE/FlgS+PTTfFynarjmdAck9pD0gS1yg22A==
X-Received: by 2002:a17:90b:2247:b0:2ee:d63f:d77 with SMTP id
 98e67ed59e1d1-2febab402f2mr4802781a91.9.1740738545427; 
 Fri, 28 Feb 2025 02:29:05 -0800 (PST)
Received: from localhost.localdomain ([116.73.133.207])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-2fe825bac03sm5550729a91.19.2025.02.28.02.29.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2025 02:29:04 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v2] hw/i386: introduce x86_firmware_reconfigure api
Date: Fri, 28 Feb 2025 15:58:47 +0530
Message-ID: <20250228102848.288918-1-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Normally, there is no need to perform firmware reconfiguration once the
virtual machine has started. Hence, currently ovmf firmware parsing happens only
once. However, if the firmware changes betweeen boots then reconfiguration needs
to happen again. Firmware can change if for example the guest brings its own
firmware bundle and installs it with the help of the hypervisor[1]. Therefore,
this change introduces a new api with which firmware configuration steps can
be forced again.
This is mostly refactoring work. No functional changes. CI pipeline does not
break with this change.

1) https://pretalx.com/kvm-forum-2024/talk/HJSKRQ/

Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 hw/i386/pc_sysfw.c            | 26 ++++++++++++++++++--------
 hw/i386/pc_sysfw_ovmf-stubs.c |  5 +++++
 hw/i386/pc_sysfw_ovmf.c       |  5 +++++
 include/hw/i386/pc.h          |  1 +
 include/hw/i386/x86.h         |  1 +
 5 files changed, 30 insertions(+), 8 deletions(-)

changelog:
v2: Gerd's suggestion to add a new function to set ovmf_flash_parsed to
false added.

diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
index 1eeb58ab37..5645a24816 100644
--- a/hw/i386/pc_sysfw.c
+++ b/hw/i386/pc_sysfw.c
@@ -258,16 +258,9 @@ void pc_system_firmware_init(PCMachineState *pcms,
     pc_system_flash_cleanup_unused(pcms);
 }
 
-void x86_firmware_configure(hwaddr gpa, void *ptr, int size)
+static void x86_firmware_configure_sev(hwaddr gpa, void *ptr, int size)
 {
     int ret;
-
-    /*
-     * OVMF places a GUIDed structures in the flash, so
-     * search for them
-     */
-    pc_system_parse_ovmf_flash(ptr, size);
-
     if (sev_enabled()) {
 
         /* Copy the SEV metadata table (if it exists) */
@@ -282,3 +275,20 @@ void x86_firmware_configure(hwaddr gpa, void *ptr, int size)
         sev_encrypt_flash(gpa, ptr, size, &error_fatal);
     }
 }
+
+void x86_firmware_configure(hwaddr gpa, void *ptr, int size)
+{
+    /*
+     * OVMF places a GUIDed structures in the flash, so
+     * search for them
+     */
+    pc_system_parse_ovmf_flash(ptr, size);
+    x86_firmware_configure_sev(gpa, ptr, size);
+}
+
+void x86_firmware_reconfigure(hwaddr gpa, void *ptr, int size)
+{
+    set_ovmf_flash_parsed_false();
+    pc_system_parse_ovmf_flash(ptr, size);
+    x86_firmware_configure_sev(gpa, ptr, size);
+}
diff --git a/hw/i386/pc_sysfw_ovmf-stubs.c b/hw/i386/pc_sysfw_ovmf-stubs.c
index aabe78b271..782c59f72d 100644
--- a/hw/i386/pc_sysfw_ovmf-stubs.c
+++ b/hw/i386/pc_sysfw_ovmf-stubs.c
@@ -24,3 +24,8 @@ void pc_system_parse_ovmf_flash(uint8_t *flash_ptr, size_t flash_size)
 {
     g_assert_not_reached();
 }
+
+void set_ovmf_flash_parsed_false(void)
+{
+    g_assert_not_reached();
+}
diff --git a/hw/i386/pc_sysfw_ovmf.c b/hw/i386/pc_sysfw_ovmf.c
index 07a4c267fa..61ab1277c0 100644
--- a/hw/i386/pc_sysfw_ovmf.c
+++ b/hw/i386/pc_sysfw_ovmf.c
@@ -36,6 +36,11 @@ static bool ovmf_flash_parsed;
 static uint8_t *ovmf_table;
 static int ovmf_table_len;
 
+void set_ovmf_flash_parsed_false(void)
+{
+    ovmf_flash_parsed = false;
+}
+
 void pc_system_parse_ovmf_flash(uint8_t *flash_ptr, size_t flash_size)
 {
     uint8_t *ptr;
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 103b54301f..c29981e344 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -211,6 +211,7 @@ void pc_system_firmware_init(PCMachineState *pcms, MemoryRegion *rom_memory);
 bool pc_system_ovmf_table_find(const char *entry, uint8_t **data,
                                int *data_len);
 void pc_system_parse_ovmf_flash(uint8_t *flash_ptr, size_t flash_size);
+void set_ovmf_flash_parsed_false(void);
 
 /* sgx.c */
 void pc_machine_init_sgx_epc(PCMachineState *pcms);
diff --git a/include/hw/i386/x86.h b/include/hw/i386/x86.h
index d43cb3908e..18c0d6851a 100644
--- a/include/hw/i386/x86.h
+++ b/include/hw/i386/x86.h
@@ -155,5 +155,6 @@ DeviceState *ioapic_init_secondary(GSIState *gsi_state);
 
 /* pc_sysfw.c */
 void x86_firmware_configure(hwaddr gpa, void *ptr, int size);
+void x86_firmware_reconfigure(hwaddr gpa, void *ptr, int size);
 
 #endif
-- 
2.42.0


