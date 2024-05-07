Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91C8EC25B4F
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 14:52:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4MAU-0006fD-Un; Tue, 07 May 2024 10:51:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s4MAT-0006d8-AZ
 for qemu-devel@nongnu.org; Tue, 07 May 2024 10:51:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s4MAR-0002qF-KG
 for qemu-devel@nongnu.org; Tue, 07 May 2024 10:51:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715093502;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=D8zg+fYjxjF/4fFgudh8v3MNf2RoV1i12f32O7IqsIs=;
 b=dyvxOcdBck2QcE9U/u8ok1/j1UsRLUWWaJWNDcU6MaSSh8uSoMli8hVlN6DUCZISV4c0EM
 nShXrOmTM1MafryGJUUGaDwkmc2UUg7uztKB43V6JUDI+4qlMJ2YgD8zPdBqZkHaLJ7PKq
 EPooUNIRnWWSUIUNYpwj63mRvqP0zQM=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-330-mvnwBYLQN7iT7bdpG6LaCg-1; Tue, 07 May 2024 10:51:39 -0400
X-MC-Unique: mvnwBYLQN7iT7bdpG6LaCg-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a599dbd2b6aso192988266b.2
 for <qemu-devel@nongnu.org>; Tue, 07 May 2024 07:51:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715093498; x=1715698298;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=D8zg+fYjxjF/4fFgudh8v3MNf2RoV1i12f32O7IqsIs=;
 b=k7FROIBrm1EaumHw0H6MrUhmlXgsp8G2pxMldbIg73rgdHHv8TbLbMNVj7JsoLqTN7
 TMPGTK/ou6tuGwX3OjzBVQ4f+BOiSvL4KghvykIb7YT78X1HeOGyIcjoEnxFKQt6+rSa
 C2ykSYFHGVLPoJ/QZbC4zEnHLSnyDeQ1zdKX0BqzygSzsNCLx4wRsH0VHSRff0daAHSx
 mDK75vrMn89Asa4RdlSbQdHSfsp6rvz+riHp+Z4NfGDq+r0jFjUSKiopEhwbaAM55m1h
 bySY9u2pNG99ujpUY8p/jaA8R9UhgQmUPhogMsp+WHsTsM1nP1sP7XeLWlnqDBEJSxK/
 /8sQ==
X-Gm-Message-State: AOJu0Yx1meppT/D8Y0d4xqDxyK4TInw1+jFhehxnZZdNcLUnmMsiXdbx
 sybv/f0Z64aD68Najdn//trmuD/uvjTfIp9lAJkObzR/33CTmou9jY+ciXfn+SKCslsZFBarjs3
 w99IyQrTaCg61TjVJ6FGTL3iYMVZyTo+tJBLjukA+yxawhqeAKNHlVA9Q9jB8iXkxfP59gS6A/S
 ifxqrjnJ/JUZ1uu+yy06yH0lJESPEMR5N1kLyg
X-Received: by 2002:a17:906:358e:b0:a59:be8a:bd71 with SMTP id
 o14-20020a170906358e00b00a59be8abd71mr4701665ejb.16.1715093498302; 
 Tue, 07 May 2024 07:51:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFK89DUtGjCHOvX21xdcB3N5qwhB4ClJzGC9ZqK6U2UnFW/OaiE1ShATUu2HsSq4AVCgwGwfQ==
X-Received: by 2002:a17:906:358e:b0:a59:be8a:bd71 with SMTP id
 o14-20020a170906358e00b00a59be8abd71mr4701645ejb.16.1715093497925; 
 Tue, 07 May 2024 07:51:37 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 rn9-20020a170906d92900b00a59a229564fsm4564622ejb.108.2024.05.07.07.51.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 May 2024 07:51:37 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] loongarch64: move memory map to boot.c
Date: Tue,  7 May 2024 16:51:35 +0200
Message-ID: <20240507145135.270803-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Ensure that it can be used even if virt.c is not included in the build, as
is the case for --without-default-devices.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/hw/loongarch/boot.h | 10 ++++++++++
 include/hw/loongarch/virt.h | 10 ----------
 hw/loongarch/boot.c         |  3 +++
 hw/loongarch/virt.c         |  3 ---
 .gitlab-ci.d/buildtest.yml  |  2 +-
 5 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/include/hw/loongarch/boot.h b/include/hw/loongarch/boot.h
index 4ebcc89dcf2..b3b870df1f0 100644
--- a/include/hw/loongarch/boot.h
+++ b/include/hw/loongarch/boot.h
@@ -104,6 +104,16 @@ struct loongarch_boot_info {
     uint64_t a0, a1, a2;
 };
 
+extern struct memmap_entry *memmap_table;
+extern unsigned memmap_entries;
+
+struct memmap_entry {
+    uint64_t address;
+    uint64_t length;
+    uint32_t type;
+    uint32_t reserved;
+};
+
 void loongarch_load_kernel(MachineState *ms, struct loongarch_boot_info *info);
 
 #endif /* HW_LOONGARCH_BOOT_H */
diff --git a/include/hw/loongarch/virt.h b/include/hw/loongarch/virt.h
index 4e14bf6060d..fdbd2b146f1 100644
--- a/include/hw/loongarch/virt.h
+++ b/include/hw/loongarch/virt.h
@@ -37,16 +37,6 @@
 
 #define FDT_BASE                0x100000
 
-extern struct memmap_entry *memmap_table;
-extern unsigned memmap_entries;
-
-struct memmap_entry {
-    uint64_t address;
-    uint64_t length;
-    uint32_t type;
-    uint32_t reserved;
-};
-
 struct LoongArchMachineState {
     /*< private >*/
     MachineState parent_obj;
diff --git a/hw/loongarch/boot.c b/hw/loongarch/boot.c
index 7d1630b2e74..03f6301a773 100644
--- a/hw/loongarch/boot.c
+++ b/hw/loongarch/boot.c
@@ -15,6 +15,9 @@
 #include "sysemu/reset.h"
 #include "sysemu/qtest.h"
 
+struct memmap_entry *memmap_table;
+unsigned memmap_entries;
+
 ram_addr_t initrd_offset;
 uint64_t initrd_size;
 
diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index c0999878df6..504e1fb349d 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -516,9 +516,6 @@ static void virt_powerdown_req(Notifier *notifier, void *opaque)
     acpi_send_event(s->acpi_ged, ACPI_POWER_DOWN_STATUS);
 }
 
-struct memmap_entry *memmap_table;
-unsigned memmap_entries;
-
 static void memmap_add_entry(uint64_t address, uint64_t length, uint32_t type)
 {
     /* Ensure there are no duplicate entries. */
diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index e9402a68a79..bab61945643 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -650,7 +650,7 @@ build-tci:
 # Check our reduced build configurations
 # requires libfdt: aarch64, arm, i386, loongarch64, microblaze, microblazeel,
 #   mips64el, or1k, ppc, ppc64, riscv32, riscv64, rx, x86_64
-# does not build without boards: i386, loongarch64, s390x, sh4, sh4eb, x86_64
+# does not build without boards: i386, s390x, sh4, sh4eb, x86_64
 build-without-defaults:
   extends: .native_build_job_template
   needs:
-- 
2.45.0


