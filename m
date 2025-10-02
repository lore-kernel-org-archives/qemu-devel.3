Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 092F8CCD182
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 17:20:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4Mvw-0001Ij-3C; Thu, 02 Oct 2025 13:17:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v4MvW-00012g-P0
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 13:17:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v4MvM-0005sc-2C
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 13:17:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759425414;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xo7/waLBB+eaxCnywl7D9abhJb3gDRPAUFE9UsF2G9Q=;
 b=JBNXtkZ0SiLP0cBttUQjbTsnQO6b1lox779T67lukgALjnF4Fnl5KVL2gb+DEMDgzzJLac
 Svb6FVybryBCDXH+37xX4eqB8CVfNKvWMCyGGSAGfQBV7Q2sObba/zpoaH+U9S6BTL9k6M
 I69hmErsDwPe8FYkrRYhK6rDlKcD/CY=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-390-jUg_GH8sMJCWDLarebZ2PA-1; Thu, 02 Oct 2025 13:16:53 -0400
X-MC-Unique: jUg_GH8sMJCWDLarebZ2PA-1
X-Mimecast-MFC-AGG-ID: jUg_GH8sMJCWDLarebZ2PA_1759425412
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-b04a8ae1409so154862466b.2
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 10:16:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759425411; x=1760030211;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xo7/waLBB+eaxCnywl7D9abhJb3gDRPAUFE9UsF2G9Q=;
 b=vKjATBjWanUO5SSAYdHYvFYQNQ/4RTMwqauXWpSZ4wcl86zxv/giRsXykVjPcb0b+m
 ypE4ys/X0dBKT0wFi6UwQ+MSthT7WsDARmfCQ+rwJASCnpdeGnKZQ7yQmseUNnz7UzKB
 NLdA7CkmYTKQC28iFBYcPXmxGDhQ1mYDyrIAa80cJiabVLf5r1yCSFb5gZY+G4I8Ho3l
 ZQjRU3iIwUQ3s+yUIEN0YcfTo9aTVVgzaYQrDR+6PdXLSiK4kn/j6PsBO2OjRNx81EbC
 bqt/f2chrMILuB5hVpiWMXf0JtWWIcKBlmy0l4/gwOXJyQfoZ6oX1KRBF0qJtws5ulyg
 bKwQ==
X-Gm-Message-State: AOJu0YxGrQ4qqDJlOccUuoMic9T08lRfAQDHAcuJu2lrTI22I8MRCx4X
 UgQ3caFoZdeqg2JqtZb9D6m4Cn4qUu1EfxYH8ZZsTBScvLgLgq8tgeuVjopbeNHm5bgcIYZz7jn
 mMihnoG0588l2VSrga4hmXoBkdE+E8n5m+J+4S/E29ieqhph31LFV2PXy2DZl+DKq2qVPG+EjqS
 7S8PIWQ3ixzS5euub8nWA/Syw7/CZGWphrJIbU0iOj
X-Gm-Gg: ASbGnct3d41ysbyD+j696fXRHEPKvHYtEXGsHXZ5DTj7/pcL4o3fkinrvyMXESlsI40
 /AWB6ml0nCzrkvON5H+2jHpbP027YPSgWqc0QcP7Khe01eAe3MDuVPB+iVvrTtjOQn8TpQdKtrc
 W6Rl3ojbdgya+gc9hvKCjokGinafmv5P5hYC95ibloXS3FwB9zuPUOVb6t25tYpjggDFzbLvHDK
 PEcT39d+s28xR3svlF+0s2ZN8/COXCkbdwTumkpjKsj0lAiEO1Qg8f8Y1A0Q4SywclchXmFcYvp
 8hwXnMeNwIjYORl24s736XO+GMGM2iTNgwmh5t85TUJuYxoxK1/wq/1be2qCzfCGk8N1mnVRl5M
 2TtdEs/2fxC9KHq27zWhCwtsd2B20m5lvAIBjkNXzAbSBTciH
X-Received: by 2002:a17:907:7213:b0:b0b:f228:25a with SMTP id
 a640c23a62f3a-b49c449b9bdmr20771266b.64.1759425411102; 
 Thu, 02 Oct 2025 10:16:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHL7XO6APmH1KKpcwuiDsFrhG9lCEZnTSQYXxO/Kcf5x1vM8VezzT+NA+3gcpGLtzfJe/3E0g==
X-Received: by 2002:a17:907:7213:b0:b0b:f228:25a with SMTP id
 a640c23a62f3a-b49c449b9bdmr20765866b.64.1759425410436; 
 Thu, 02 Oct 2025 10:16:50 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.91.106])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b48652a9ea1sm246020966b.16.2025.10.02.10.16.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Oct 2025 10:16:47 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, magnus.kulke@linux.microsoft.com, wei.liu@kernel.org,
 Praveen K Paladugu <prapal@microsoft.com>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>
Subject: [PATCH 24/27] qapi/accel: Allow to query mshv capabilities
Date: Thu,  2 Oct 2025 19:15:33 +0200
Message-ID: <20251002171536.1460049-25-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251002171536.1460049-1-pbonzini@redhat.com>
References: <20251002171536.1460049-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.451,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Praveen K Paladugu <prapal@microsoft.com>

Allow to query mshv capabilities via query-mshv QMP and info mshv HMP commands.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
Acked-by: Dr. David Alan Gilbert <dave@treblig.org>
Link: https://lore.kernel.org/r/20250916164847.77883-25-magnuskulke@linux.microsoft.com
[Fix "since" version. - Paolo]
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 qapi/accelerator.json      | 29 +++++++++++++++++++++++++++++
 include/monitor/hmp.h      |  1 +
 include/system/hw_accel.h  |  1 +
 hw/core/machine-hmp-cmds.c | 15 +++++++++++++++
 hw/core/machine-qmp-cmds.c | 14 ++++++++++++++
 hmp-commands-info.hx       | 13 +++++++++++++
 6 files changed, 73 insertions(+)

diff --git a/qapi/accelerator.json b/qapi/accelerator.json
index fb28c8d920a..664e0272465 100644
--- a/qapi/accelerator.json
+++ b/qapi/accelerator.json
@@ -54,3 +54,32 @@
 { 'command': 'x-accel-stats',
   'returns': 'HumanReadableText',
   'features': [ 'unstable' ] }
+
+##
+# @MshvInfo:
+#
+# Information about support for MSHV acceleration
+#
+# @enabled: true if MSHV acceleration is active
+#
+# @present: true if MSHV acceleration is built into this executable
+#
+# Since: 10.2.0
+##
+{ 'struct': 'MshvInfo', 'data': {'enabled': 'bool', 'present': 'bool'} }
+
+##
+# @query-mshv:
+#
+# Return information about MSHV acceleration
+#
+# Returns: @MshvInfo
+#
+# Since: 10.0.92
+#
+# .. qmp-example::
+#
+#     -> { "execute": "query-mshv" }
+#     <- { "return": { "enabled": true, "present": true } }
+##
+{ 'command': 'query-mshv', 'returns': 'MshvInfo' }
diff --git a/include/monitor/hmp.h b/include/monitor/hmp.h
index ae116d9804a..31bd812e5f4 100644
--- a/include/monitor/hmp.h
+++ b/include/monitor/hmp.h
@@ -24,6 +24,7 @@ strList *hmp_split_at_comma(const char *str);
 void hmp_info_name(Monitor *mon, const QDict *qdict);
 void hmp_info_version(Monitor *mon, const QDict *qdict);
 void hmp_info_kvm(Monitor *mon, const QDict *qdict);
+void hmp_info_mshv(Monitor *mon, const QDict *qdict);
 void hmp_info_status(Monitor *mon, const QDict *qdict);
 void hmp_info_uuid(Monitor *mon, const QDict *qdict);
 void hmp_info_chardev(Monitor *mon, const QDict *qdict);
diff --git a/include/system/hw_accel.h b/include/system/hw_accel.h
index fa9228d5d2d..55497edc293 100644
--- a/include/system/hw_accel.h
+++ b/include/system/hw_accel.h
@@ -14,6 +14,7 @@
 #include "hw/core/cpu.h"
 #include "system/kvm.h"
 #include "system/hvf.h"
+#include "system/mshv.h"
 #include "system/whpx.h"
 #include "system/nvmm.h"
 
diff --git a/hw/core/machine-hmp-cmds.c b/hw/core/machine-hmp-cmds.c
index 3a612e2232d..682ed9f49b8 100644
--- a/hw/core/machine-hmp-cmds.c
+++ b/hw/core/machine-hmp-cmds.c
@@ -163,6 +163,21 @@ void hmp_info_kvm(Monitor *mon, const QDict *qdict)
     qapi_free_KvmInfo(info);
 }
 
+void hmp_info_mshv(Monitor *mon, const QDict *qdict)
+{
+    MshvInfo *info;
+
+    info = qmp_query_mshv(NULL);
+    monitor_printf(mon, "mshv support: ");
+    if (info->present) {
+        monitor_printf(mon, "%s\n", info->enabled ? "enabled" : "disabled");
+    } else {
+        monitor_printf(mon, "not compiled\n");
+    }
+
+    qapi_free_MshvInfo(info);
+}
+
 void hmp_info_uuid(Monitor *mon, const QDict *qdict)
 {
     UuidInfo *info;
diff --git a/hw/core/machine-qmp-cmds.c b/hw/core/machine-qmp-cmds.c
index 6aca1a626e6..e24bf0d97bf 100644
--- a/hw/core/machine-qmp-cmds.c
+++ b/hw/core/machine-qmp-cmds.c
@@ -28,6 +28,20 @@
 #include "system/runstate.h"
 #include "system/system.h"
 #include "hw/s390x/storage-keys.h"
+#include <sys/stat.h>
+
+/*
+ * QMP query for MSHV
+ */
+MshvInfo *qmp_query_mshv(Error **errp)
+{
+    MshvInfo *info = g_malloc0(sizeof(*info));
+
+    info->enabled = mshv_enabled();
+    info->present = accel_find("mshv");
+
+    return info;
+}
 
 /*
  * fast means: we NEVER interrupt vCPU threads to retrieve
diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
index 6142f60e7b1..eaaa880c1b3 100644
--- a/hmp-commands-info.hx
+++ b/hmp-commands-info.hx
@@ -307,6 +307,19 @@ SRST
     Show KVM information.
 ERST
 
+    {
+        .name       = "mshv",
+        .args_type  = "",
+        .params     = "",
+        .help       = "show MSHV information",
+        .cmd        = hmp_info_mshv,
+    },
+
+SRST
+  ``info mshv``
+    Show MSHV information.
+ERST
+
     {
         .name       = "numa",
         .args_type  = "",
-- 
2.51.0


