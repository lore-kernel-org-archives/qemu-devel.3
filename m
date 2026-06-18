Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAF4ECD98ED
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 08:44:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wa8MC-0003Kp-Qa; Thu, 18 Jun 2026 04:44:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1wa8M8-0003K1-R8
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 04:44:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1wa8M6-0007WT-Vl
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 04:44:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781772248;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=eW1aQ6d+d/YjuMOtUGsQVyMATqTCGa+bJywT3OB5bJ4=;
 b=ZiR6FaL5JHwLSM3+r+pjXQEz0MXOtGDd6Rxw1cbWywbIjNlS5R/6PzHQkaPiPM46nkgbkf
 wTPALNJjCCPu/9xbCPoQCdVfc4oo/rZoQiSLed8yebOIV5QjSseYpWdcfdVSU2nIweRq/4
 Mn6GqC3KehZGpvKQrtAaesn30j+L0qk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-whQCnSyMM1CBSe6RxRizSA-1; Thu, 18 Jun 2026 04:44:06 -0400
X-MC-Unique: whQCnSyMM1CBSe6RxRizSA-1
X-Mimecast-MFC-AGG-ID: whQCnSyMM1CBSe6RxRizSA_1781772245
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-490c840efe6so16182625e9.1
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 01:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781772245; x=1782377045; darn=nongnu.org;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=eW1aQ6d+d/YjuMOtUGsQVyMATqTCGa+bJywT3OB5bJ4=;
 b=CUUBrmsYZH6CU+Vm/R6mYFfguA4kaDEVLYw4ONSP14iRrzNd44+mrVp2oDUBnolOdm
 mv2R02djCowysvxdQ8qWqaugHX/buMyPDZThhe7PvahQakkc0CX1/jWkRGI8NQJhBoFq
 Q9FLn/wBRX7ctMKyyz9QXMDGDuCqBhdwsAL1McQOpUu71wjpwhh80uaLVUVLIu3+LEjO
 oigdvXTl2agHi9jxgLj9YoChvqGvGFmQtFb8AgdxccbRWeq77IWIlgNFO3mELYTrVL8a
 DieM8SHGJCwKlHVSd09WMIpTx2fKoKpKpQeeTti8ig444F5OHkj9cGC1Wxecn+L/F5Vi
 j3lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781772245; x=1782377045;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eW1aQ6d+d/YjuMOtUGsQVyMATqTCGa+bJywT3OB5bJ4=;
 b=fiGPN8nGCvR21QtYkP0gF4NzUq6DE40IdZKu16mmkRe4NT8cFDf6fmMWueDOZo/p8Q
 XQ7r9eLTA4XfZeA3ZK/fCDBGRANqJYuIB9dCn2HBzDXx5Ix8Q7URZmKItXSYBUaLjhaj
 O8wuR5lDLkOCvC+BSHPs4i+CDaOZw38hPc7s4ohQhUQenBW35FJn3T3iii9pWTvVxHlV
 xe3XblyFD1HNUry4+4jmxQJ5M4xZ+mUR9P+13mVk3FUY2grRHai/ms8L4otXt8vldzzA
 b5bzazxNZDSAdiv6IB3vq1uzbobUr9pT/XsULPfCfES7np+YslSoggSzu5PRWvQwOMgd
 eYpQ==
X-Gm-Message-State: AOJu0YzLv6G750FWiSNjLDzLPeNFyVqjXYtqy4TLZUGMW58GfL/zhGGC
 G4oiiYTE3D3dmO8aBq7AWUYjy+DKxc+Fk2RqggPd1EBqqn4WiJ/3x6XSSE0e7o9X72GSVedRfFg
 Je+fIKFgHgOGerso+pC17lDBNMRsId1reCxE2Dfx1WwXQFbmc5wq+T7Jt
X-Gm-Gg: Acq92OH8Vr73r5jNvbrxUnyI8CS+trAkeBNs9kAr9TXw2ck7ob8ZcUwhtilXGHC5BiF
 cCqA/cPnP7xe/713YHyljhaDVoIszsAsxRO8gIzdHIMB+vPZaYMRFsdUZLSnY96cNo5iHR1Zchy
 qGaOE5oVilOGXlsNPNPfTKu0MFOzK9dYdJRWDftVI1yQVF9MBGUBnAqad+MIIQQBvqnN2K4nprh
 Nc2HPVTp2S9Rf0X0QmEZzwcSZb8ocJfU6ZPddK7L36WcfNKSV3rPUyipVWLdhCX5yY9e3uIoYUj
 xINCZsL/mI/UV9q7QVSJVc79zvvZFLXhrQMJLJko2fSfkCxICFEiqbxQtfSy8CTEU96eGY352EI
 NezZGbhOfA9D6xWRgj5isLlpyXPUnx/8HdWtYaW9CPviL5zlJ0q+2fTpT5eKvjGLgHV3nnVgPCs
 RBD2H7eQ==
X-Received: by 2002:a05:600c:5492:b0:490:b4a8:e031 with SMTP id
 5b1f17b1804b1-49238154445mr40495485e9.4.1781772245322; 
 Thu, 18 Jun 2026 01:44:05 -0700 (PDT)
X-Received: by 2002:a05:600c:5492:b0:490:b4a8:e031 with SMTP id
 5b1f17b1804b1-49238154445mr40495125e9.4.1781772244906; 
 Thu, 18 Jun 2026 01:44:04 -0700 (PDT)
Received: from lleonard-thinkpadx1carbongen13.rmtit.csb ([176.206.21.116])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49230a58becsm218217365e9.7.2026.06.18.01.44.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jun 2026 01:44:04 -0700 (PDT)
From: Luigi Leonardi <leonardi@redhat.com>
Date: Thu, 18 Jun 2026 10:44:02 +0200
Subject: [PATCH v2] igvm: Report error on missing parameter area in
 directive handlers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260618-igvm_error-v2-1-2b03f4790e4f@redhat.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/23MQQ7CIBCF4as0sxYDNGLrynuYxiAM7SxamqEhm
 oa7i127/F/yvh0SMmGCW7MDY6ZEcamhTw24yS4jCvK1QUttpFFS0JjnJzJHFg477F4aw1Ui1MP
 KGOh9YI+h9kRpi/w57Kx+618mK6HEpfeqba3pgw53Rj/Z7eziDEMp5QtbnR0ZpQAAAA==
X-Change-ID: 20260610-igvm_error-ce8e8b2ef70e
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, Ani Sinha <anisinha@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Oliver Steffen <osteffen@redhat.com>, Luigi Leonardi <leonardi@redhat.com>
X-Mailer: b4 0.14.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=leonardi@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Parameter areas are how an IGVM file tells QEMU to allocate buffers
for runtime information the guest needs — VP count, memory map,
MADT and so on. Usage directives reference a parameter area by index
to tell QEMU where to write each piece of data. If the index doesn't
match any declared parameter area, the data has nowhere to go and
should be treated as an error.

The directive handlers that look up a parameter area all return 0
(success) when `qigvm_find_param_entry()` can't find it. Therefore,
the load succeeds but the guest never gets the expected parameters.

Note that the IGVM library already validates parameter area indices
when the file is loaded, so this path should only be reachable with
a malformed file that bypassed library validation. This is defensive
programming against that case.

Report the error with error_setg() and return -1 instead.

Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
---
Changes in v2:
- Moved error_setg to qigvm_find_param_entry [Gerd]
- Rebased to latest upstream
- Link to v1: https://lore.kernel.org/qemu-devel/20260610-igvm_error-v1-1-59d133a69f2f@redhat.com
---
 backends/igvm.c                | 26 ++++++++++++++++----------
 include/system/igvm-internal.h |  3 ++-
 target/i386/igvm.c             |  5 +++--
 3 files changed, 21 insertions(+), 13 deletions(-)

diff --git a/backends/igvm.c b/backends/igvm.c
index 3f4b97a5d4..a5a2a4eccc 100644
--- a/backends/igvm.c
+++ b/backends/igvm.c
@@ -81,7 +81,8 @@ struct QEMU_PACKED sev_id_authentication {
 #define IGVM_SEV_ID_BLOCK_VERSION 1
 
 QIgvmParameterData*
-qigvm_find_param_entry(QIgvm *igvm, uint32_t parameter_area_index)
+qigvm_find_param_entry(QIgvm *igvm, uint32_t parameter_area_index,
+                       Error **errp)
 {
     QIgvmParameterData *param_entry;
     QTAILQ_FOREACH(param_entry, &igvm->parameter_data, next)
@@ -90,7 +91,8 @@ qigvm_find_param_entry(QIgvm *igvm, uint32_t parameter_area_index)
             return param_entry;
         }
     }
-    warn_report("IGVM: No parameter area for index %u", parameter_area_index);
+    error_setg(errp, "IGVM: parameter area index %u not found",
+                   parameter_area_index);
     return NULL;
 }
 
@@ -528,9 +530,10 @@ static int qigvm_directive_parameter_insert(QIgvm *ctx,
         return 0;
     }
 
-    param_entry = qigvm_find_param_entry(ctx, param->parameter_area_index);
+    param_entry = qigvm_find_param_entry(ctx,
+                                         param->parameter_area_index, errp);
     if (param_entry == NULL) {
-        return 0;
+        return -1;
     }
 
     region = qigvm_prepare_memory(ctx, param->gpa, param_entry->size,
@@ -601,9 +604,10 @@ static int qigvm_directive_memory_map(QIgvm *ctx, const uint8_t *header_data,
     }
 
     /* Find the parameter area that should hold the memory map */
-    param_entry = qigvm_find_param_entry(ctx, param->parameter_area_index);
+    param_entry = qigvm_find_param_entry(ctx,
+                                         param->parameter_area_index, errp);
     if (param_entry == NULL) {
-        return 0;
+        return -1;
     }
 
     max_entry_count = param_entry->size / sizeof(IGVM_VHS_MEMORY_MAP_ENTRY);
@@ -660,9 +664,10 @@ static int qigvm_directive_vp_count(QIgvm *ctx, const uint8_t *header_data,
     uint32_t *vp_count;
     CPUState *cpu;
 
-    param_entry = qigvm_find_param_entry(ctx, param->parameter_area_index);
+    param_entry = qigvm_find_param_entry(ctx,
+                                         param->parameter_area_index, errp);
     if (param_entry == NULL) {
-        return 0;
+        return -1;
     }
 
     vp_count = (uint32_t *)(param_entry->data + param->byte_offset);
@@ -683,9 +688,10 @@ static int qigvm_directive_environment_info(QIgvm *ctx,
     QIgvmParameterData *param_entry;
     IgvmEnvironmentInfo *environmental_state;
 
-    param_entry = qigvm_find_param_entry(ctx, param->parameter_area_index);
+    param_entry = qigvm_find_param_entry(ctx,
+                                         param->parameter_area_index, errp);
     if (param_entry == NULL) {
-        return 0;
+        return -1;
     }
 
     environmental_state =
diff --git a/include/system/igvm-internal.h b/include/system/igvm-internal.h
index 7f131c4d03..7eb3792ed8 100644
--- a/include/system/igvm-internal.h
+++ b/include/system/igvm-internal.h
@@ -72,6 +72,7 @@ struct QIgvm {
 IgvmHandle qigvm_file_init(char *filename, Error **errp);
 
 QIgvmParameterData*
-qigvm_find_param_entry(QIgvm *igvm, uint32_t parameter_area_index);
+qigvm_find_param_entry(QIgvm *igvm, uint32_t parameter_area_index,
+                       Error **errp);
 
 #endif
diff --git a/target/i386/igvm.c b/target/i386/igvm.c
index f41b498b89..ad9bf87761 100644
--- a/target/i386/igvm.c
+++ b/target/i386/igvm.c
@@ -191,9 +191,10 @@ int qigvm_directive_madt(QIgvm *ctx, const uint8_t *header_data, Error **errp)
     int result = 0;
 
     /* Find the parameter area that should hold the MADT data */
-    param_entry = qigvm_find_param_entry(ctx, param->parameter_area_index);
+    param_entry = qigvm_find_param_entry(ctx,
+                                         param->parameter_area_index, errp);
     if (param_entry == NULL) {
-        return 0;
+        return -1;
     }
 
     GArray *madt = acpi_build_madt_standalone(ctx->machine_state);

---
base-commit: c7cf7c810153d6f5f31aa2d5c0dee9087f6b4dff
change-id: 20260610-igvm_error-ce8e8b2ef70e

Best regards,
-- 
Luigi Leonardi <leonardi@redhat.com>


