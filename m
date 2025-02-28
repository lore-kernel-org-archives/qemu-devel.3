Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6683DC19776
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2025 11:43:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnylX-0003SO-HF; Fri, 28 Feb 2025 06:42:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tnylU-0003Re-7m
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 06:42:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tnylR-000532-36
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 06:42:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740742963;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=oa63yGYyVW8rL4hN1YZxArNPZH+VTTv2VB4tKUHwULc=;
 b=Het57Z5z54qbn/kUu3Ehg9ZYC6ex6GBdNdtZgbrkjD6CMj+lEHCrSRJ6nK2r1wUDzv6rEY
 9TLPPALByqUaNfYWkxv5dmub+3Ewqqp5UGuv8cgAIKFoTCHorQYwprWYwrWZC1N9fCrsR2
 9Tc4UTBi6fSmIr74b3+i8rJYNMnF+ME=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-461-0zrr0jgaMW683fIkKKcuDQ-1; Fri, 28 Feb 2025 06:42:41 -0500
X-MC-Unique: 0zrr0jgaMW683fIkKKcuDQ-1
X-Mimecast-MFC-AGG-ID: 0zrr0jgaMW683fIkKKcuDQ_1740742961
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-220cd43c75aso78055725ad.3
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2025 03:42:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740742960; x=1741347760;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oa63yGYyVW8rL4hN1YZxArNPZH+VTTv2VB4tKUHwULc=;
 b=OszHScymec5iF05nC0IWP0fBtCgqBLpX3OWGtZmrGd2cjl0exeY09rx56zE2R6v6Ik
 FSsfFrLv6t8VXkzUuIhu9rAzRFSeakn4tuogYAGZZza6g3e9V92J16Cp8xN00EpLq7VZ
 ZZ4MqmimEMR6asIuZ/UYM17CbvPeL7pkrZewf21WwW+sWt62GPBaO2ChqnrL86JaN/lJ
 Qc6p+8j+9RU4nTehKsa9YdIERAvNqaLWVW9cPUBL/3A47ym8VzpuyOzsDL64qhsOmZwy
 ZexS5k12rQOFY82oWezABBOzQ7zsmKC3bYjwYR1wrszFUeh0/WZP8RNUoI98mUJN2gaS
 fiiA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX+c765bIn1pOUjFsPEbahuQ8Dv3KZYx4MuztJ+5brodvpC6HSL5Zcw+QMCZZ9fCqbay3U+2mDEY7e5@nongnu.org
X-Gm-Message-State: AOJu0Yz1X69KpSeqoaL3lLNIEoLwptT+Y5P2Ocw1wkCBgpeuDuWEA2L1
 13pSLvPEryhWaRul6Tx2pGBQMiMWiYZZATayatawYogi/tNMTq0gAACaTRpF47Pa8Tj2tr5DP3e
 tBdbuvtkTuIlUbDBDFB/0OpxNCrKf2v24EwXuBN2fphbp8B6muaC4qEZ1RqlM
X-Gm-Gg: ASbGncsg29p9O/d4jdyfKzfvJrp8bGwYNE0yMrzoGvZtFQg3YA0CKeblLnMje5erCUz
 Oi8GqtBq/bjv5IdRLBT4xMuShGPSIl5QYjrivDJMjhX89t9JYSpeoL1MMlN5Br+aPthK1BEELRZ
 Z8sqx3RsyHC7k6AzwZ+QjEVjFd4bAH+hwI4ijJy+xGrK6N/ivCm9gQF6c0IJJaIG5y95tWxg+Dt
 z2GgGkVSReeW1NElEhatsl2c0mMLGYVhhe0Z0LByZenPUG+/MyFl/ebw18SDX5lD9gxoifhzD6b
 fWcTreMk95HriymepbW1s7lqrCzu
X-Received: by 2002:a05:6a00:390f:b0:732:a24:7354 with SMTP id
 d2e1a72fcca58-734ac32d058mr5256307b3a.4.1740742959911; 
 Fri, 28 Feb 2025 03:42:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG6+q2kfTlh2qyhTq/lGfGX4Bdp4kJGPsNl5V9yGErS54WAKyo3qA81ZIQmmPQZIlbAFPmVFw==
X-Received: by 2002:a05:6a00:390f:b0:732:a24:7354 with SMTP id
 d2e1a72fcca58-734ac32d058mr5256268b3a.4.1740742959548; 
 Fri, 28 Feb 2025 03:42:39 -0800 (PST)
Received: from localhost.localdomain ([116.73.133.207])
 by smtp.googlemail.com with ESMTPSA id
 d2e1a72fcca58-7349fe51432sm3495819b3a.70.2025.02.28.03.42.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2025 03:42:38 -0800 (PST)
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
Subject: [PATCH v3] hw/i386: introduce x86_firmware_reconfigure api
Date: Fri, 28 Feb 2025 17:12:30 +0530
Message-ID: <20250228114230.306852-1-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
v3 function name change to invalidate_ovmf_parsed_metadata()
v2: Gerd's suggestion to add a new function to set ovmf_flash_parsed to
false added.

diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
index 1eeb58ab37..a9943d95c8 100644
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
+    invalidate_ovmf_parsed_metadata();
+    pc_system_parse_ovmf_flash(ptr, size);
+    x86_firmware_configure_sev(gpa, ptr, size);
+}
diff --git a/hw/i386/pc_sysfw_ovmf-stubs.c b/hw/i386/pc_sysfw_ovmf-stubs.c
index aabe78b271..edf890a525 100644
--- a/hw/i386/pc_sysfw_ovmf-stubs.c
+++ b/hw/i386/pc_sysfw_ovmf-stubs.c
@@ -24,3 +24,8 @@ void pc_system_parse_ovmf_flash(uint8_t *flash_ptr, size_t flash_size)
 {
     g_assert_not_reached();
 }
+
+void invalidate_ovmf_parsed_metadata(void)
+{
+    g_assert_not_reached();
+}
diff --git a/hw/i386/pc_sysfw_ovmf.c b/hw/i386/pc_sysfw_ovmf.c
index 07a4c267fa..3244c17a7d 100644
--- a/hw/i386/pc_sysfw_ovmf.c
+++ b/hw/i386/pc_sysfw_ovmf.c
@@ -36,6 +36,11 @@ static bool ovmf_flash_parsed;
 static uint8_t *ovmf_table;
 static int ovmf_table_len;
 
+void invalidate_ovmf_parsed_metadata(void)
+{
+    ovmf_flash_parsed = false;
+}
+
 void pc_system_parse_ovmf_flash(uint8_t *flash_ptr, size_t flash_size)
 {
     uint8_t *ptr;
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 103b54301f..7b0d0c54f5 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -211,6 +211,7 @@ void pc_system_firmware_init(PCMachineState *pcms, MemoryRegion *rom_memory);
 bool pc_system_ovmf_table_find(const char *entry, uint8_t **data,
                                int *data_len);
 void pc_system_parse_ovmf_flash(uint8_t *flash_ptr, size_t flash_size);
+void invalidate_ovmf_parsed_metadata(void);
 
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


