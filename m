Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 004F6C83F21
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 23:29:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubSIM-0002eb-Ub; Mon, 14 Jul 2025 19:09:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubSHE-00069c-DB
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 19:08:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubSHC-0005dm-9J
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 19:08:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752534481;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xk9frtw4E7yOISGuoGDzjA1OizOnzV8VR73+E5OqM0w=;
 b=SDg9pFz0u9vkC0BE2mFTv3y6/DexY7zdarIeyZtG7g0DvesTCOgV8k1mFVR+jgbL5QAqfh
 7XOoVwAf8rsTFYqw4osjtiEACO1eS5woozoddZNCR9XNPOR9Y2Oo7OczU+akWGE2HD3zsI
 tyRhsmZh2HD+OOUOvvzNLl0ije4kbh0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-466-X523O4J_NAiWP9dFmCAU8w-1; Mon, 14 Jul 2025 19:08:00 -0400
X-MC-Unique: X523O4J_NAiWP9dFmCAU8w-1
X-Mimecast-MFC-AGG-ID: X523O4J_NAiWP9dFmCAU8w_1752534479
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3a4f8192e2cso2713147f8f.3
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 16:08:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752534479; x=1753139279;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xk9frtw4E7yOISGuoGDzjA1OizOnzV8VR73+E5OqM0w=;
 b=Gq7aeaYbi/hB5E9jWz++/8IDU++4BKhThYwnsJ53Bk2kSGXP0jDDF/9uIyeWTyh4Od
 3a2E4skyxtn8tgQkr9Ou3ALwuZJdkiPbBDi/PvuI6n01XSUs6jVsdt23gOIhqoKLoa2n
 FtttTD0BB9GGhyQoWU5p4apdhoHYU5DARIGOnESbP4Qpm81pnF3dFJBriHxUdrzvZpV5
 WQQe9tAZpFKOsXrIpLud4yQs29WNWrPLYFkAWeOLxjnvWf1Se13LqlHbhB1Ks3WiIaJG
 sans8MfmxysgtVpyuHlzlzCiKaELPX3aMsuaU5BHGTKJMmnaOVjoSl1Os+JJs8ZIa52l
 +trw==
X-Gm-Message-State: AOJu0YzNFhdcb1+rwh29xcw1ebXOxHPCF6PaQ/kDpj2aPS36aikDe5Vc
 gtmopVniU2mhQ8Zv1S+skFhL9uc3cNPYtLZcDyQgAWLcz/C6TdfGblIeQwyLFFEh0helRNuaSJP
 HJ86IfP5VfU/nyXlbAR7k1Z+wjP53u25ceV1kXSD+EJvtmLs8Uq6H2r+H2elUO6Ao0Vp3RsBV80
 9FpGY/2r486Sh6SJPYJ8yWcjKsTq0l7n2/rg==
X-Gm-Gg: ASbGncuRgrqBrncRGlpHBB3Uzw7UWv4miqukwrFrwxMTl5e4tH4+Y3ScgJf5DW+v/g5
 NakaOdtEmrOtzjPFBwz/xGHzbOMaVIoYbudI2sI96omDGFJkj/KW3wOPMWFpGeBTY84ZGcAjBFT
 t2S5AOysOwZ+OmCmXNq956irJgaT1OmLB4I4t6Cq1b9C7fbsZE0iEHn/8PLpGM65UqdgK1Fayru
 kbik0rnOgbr+T/pmoY6XhuPDqEIEwo716edeGB6rVynG2ZIfueFpR6RqpcGWM7jH5FfHPDi2RrL
 VUrgO3ZF4OjBLxjJPoG+aczxX7z4PbcX
X-Received: by 2002:a05:6000:4389:b0:3b3:9c85:6b17 with SMTP id
 ffacd0b85a97d-3b5f2dfd8c0mr10430325f8f.34.1752534478836; 
 Mon, 14 Jul 2025 16:07:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFFbMrBFuQ03LH212VroaJbgOLNKTIAVsJmeSymGBKRazZ8RvYU7P4DlT+HnQc4Qzf6/ZzbOw==
X-Received: by 2002:a05:6000:4389:b0:3b3:9c85:6b17 with SMTP id
 ffacd0b85a97d-3b5f2dfd8c0mr10430303f8f.34.1752534478281; 
 Mon, 14 Jul 2025 16:07:58 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-456101b616csm72731345e9.4.2025.07.14.16.07.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 16:07:57 -0700 (PDT)
Date: Mon, 14 Jul 2025 19:07:55 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 40/97] qemu/target-info: Factor target_arch() out
Message-ID: <777aa9af48426cf40f6262a3fca2b3c67a916b14.1752534227.git.mst@redhat.com>
References: <cover.1752534227.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1752534227.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

To keep "qemu/target-info.h" self-contained to native
types, declare target_arch() -- which returns a QAPI
type -- in "qemu/target-info-qapi.h".

No logical change.

Keeping native types in "qemu/target-info.h" is necessary
to keep building tests such tests/tcg/plugins/mem.c, as
per the comment added in commit ecbcc9ead2f ("tests/tcg:
add a system test to check memory instrumentation"):

/*
 * plugins should not include anything from QEMU aside from the
 * API header. However as this is a test plugin to exercise the
 * internals of QEMU and we want to avoid needless code duplication we
 * do so here. bswap.h is pretty self-contained although it needs a
 * few things provided by compiler.h.
 */

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <20250708215320.70426-3-philmd@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/qemu/target-info-qapi.h | 21 +++++++++++++++++++++
 include/qemu/target-info.h      |  2 +-
 hw/core/machine-qmp-cmds.c      |  8 +++-----
 target-info.c                   |  8 ++++++++
 4 files changed, 33 insertions(+), 6 deletions(-)
 create mode 100644 include/qemu/target-info-qapi.h

diff --git a/include/qemu/target-info-qapi.h b/include/qemu/target-info-qapi.h
new file mode 100644
index 0000000000..a337c867bf
--- /dev/null
+++ b/include/qemu/target-info-qapi.h
@@ -0,0 +1,21 @@
+/*
+ * QEMU target info API (returning QAPI types)
+ *
+ *  Copyright (c) Linaro
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef QEMU_TARGET_INFO_EXTRA_H
+#define QEMU_TARGET_INFO_EXTRA_H
+
+#include "qapi/qapi-types-machine.h"
+
+/**
+ * target_arch:
+ *
+ * Returns: QAPI SysEmuTarget enum (e.g. SYS_EMU_TARGET_X86_64).
+ */
+SysEmuTarget target_arch(void);
+
+#endif
diff --git a/include/qemu/target-info.h b/include/qemu/target-info.h
index 850a2958b9..dde0e7d968 100644
--- a/include/qemu/target-info.h
+++ b/include/qemu/target-info.h
@@ -1,5 +1,5 @@
 /*
- * QEMU target info API
+ * QEMU target info API (returning native types)
  *
  *  Copyright (c) Linaro
  *
diff --git a/hw/core/machine-qmp-cmds.c b/hw/core/machine-qmp-cmds.c
index d82043e1c6..cd98daedd1 100644
--- a/hw/core/machine-qmp-cmds.c
+++ b/hw/core/machine-qmp-cmds.c
@@ -19,7 +19,7 @@
 #include "qapi/qobject-input-visitor.h"
 #include "qapi/type-helpers.h"
 #include "qemu/uuid.h"
-#include "qemu/target-info.h"
+#include "qemu/target-info-qapi.h"
 #include "qom/qom-qobject.h"
 #include "system/hostmem.h"
 #include "system/hw_accel.h"
@@ -37,8 +37,7 @@ CpuInfoFastList *qmp_query_cpus_fast(Error **errp)
     MachineState *ms = MACHINE(qdev_get_machine());
     MachineClass *mc = MACHINE_GET_CLASS(ms);
     CpuInfoFastList *head = NULL, **tail = &head;
-    SysEmuTarget target = qapi_enum_parse(&SysEmuTarget_lookup, target_name(),
-                                          -1, &error_abort);
+    SysEmuTarget target = target_arch();
     CPUState *cpu;
 
     CPU_FOREACH(cpu) {
@@ -139,8 +138,7 @@ QemuTargetInfo *qmp_query_target(Error **errp)
 {
     QemuTargetInfo *info = g_malloc0(sizeof(*info));
 
-    info->arch = qapi_enum_parse(&SysEmuTarget_lookup, target_name(), -1,
-                                 &error_abort);
+    info->arch = target_arch();
 
     return info;
 }
diff --git a/target-info.c b/target-info.c
index 16fdca7aaa..9ebabec988 100644
--- a/target-info.c
+++ b/target-info.c
@@ -8,7 +8,9 @@
 
 #include "qemu/osdep.h"
 #include "qemu/target-info.h"
+#include "qemu/target-info-qapi.h"
 #include "qemu/target-info-impl.h"
+#include "qapi/error.h"
 
 const char *target_name(void)
 {
@@ -20,6 +22,12 @@ unsigned target_long_bits(void)
     return target_info()->long_bits;
 }
 
+SysEmuTarget target_arch(void)
+{
+    return qapi_enum_parse(&SysEmuTarget_lookup, target_name(), -1,
+                           &error_abort);
+}
+
 const char *target_cpu_type(void)
 {
     return target_info()->cpu_type;
-- 
MST


