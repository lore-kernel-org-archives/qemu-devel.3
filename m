Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE4ACC02194
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 18:27:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg6b5-00019T-8q; Thu, 06 Feb 2025 13:27:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tg6b3-00018v-Be
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 13:27:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tg6b1-00011m-QN
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 13:27:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738866447;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1Tf0PLSlRzchwCQav+NNO3Tn8pSn6RVnflJVUhvKZHc=;
 b=VKwB407QYYWysXsoVazfQWNR/IJKIc3Sy62YjiBXjNhQPaE/xmeN5sba8oGU5PSLxLVDgE
 L5CqexoRM7CZQ1gjf5iZLoi2u6GOP86Jqrxk54ewexAyz1QvzmqPtiQL2aCKzWi6Y0bfdj
 yIZo9v+/MmzCbs0qeKaam3tzpqSoXqM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-214-xR2LCKqpMTOUoU4TOOL7VA-1; Thu, 06 Feb 2025 13:27:24 -0500
X-MC-Unique: xR2LCKqpMTOUoU4TOOL7VA-1
X-Mimecast-MFC-AGG-ID: xR2LCKqpMTOUoU4TOOL7VA
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4359206e1e4so10561755e9.2
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 10:27:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738866442; x=1739471242;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1Tf0PLSlRzchwCQav+NNO3Tn8pSn6RVnflJVUhvKZHc=;
 b=cVcfoDBJsLNeaEYk7Ch3GNuir59R+eBBtjXa7etQsqugq5/CJ9stURtq0iuVMYqbG8
 s4KxXaeHTW1EM4lb/B/y+VfL3+1CV2ivu0zqaQqHJP71Ld77R0J3QxdReMDCN0klju6p
 3sFJ1AwMiHnv3RtZdQIf5ZkEmL+XgWAo+CbFcdICSMKw1oF3uBwhDVYl0OaM2/5UkEYA
 VMSjXWACEMnMJ66of2EhMagD0/T8WK09MnF1d8bf2OJD6R8HumqRbQl/PgO/U+zPmdM7
 UGP6N2zRqMBwuZU25/XENH3+J9oVgtrCXCHuRfkjKGVLAo8b2u20DCb/y2bm4bjXvKvC
 eu4g==
X-Gm-Message-State: AOJu0Yw93h3DhDFytrxWwI0WcjXoj54cE7TRIGc0u+ppNbrY1IvhxGAn
 y4oYZ0SSu+S8gsLt9UdFMsR7EBMQp7M2b0DDOrtxlebawOslXwGe6hVoHkMrgWkYErW4SZcq0OQ
 Ri8aU+o3QThskVF1Q+6q8RVyoTlHUzPO33AeEPt10ThBFqGV9pzDQISXXOSiDgyp55mOlJV5dlh
 hM0qfPqryn/xclrEisvP1Wrx0OugGurqFqJ5bQv/E=
X-Gm-Gg: ASbGncsUKWoqpY4ISEI4FHJTKnLdUB/Ro3PpOfW94KCpesAgswn98EJB/FOb71kg2Jj
 w1maOSlux4XpA3ZfBvEtQ5jaxb50E0NaqIa8sdhmshVRZNWDLljf4lKNPAPx2oJfgerSKfvKJnN
 Z6XU08wdmLxbw3Ww4lD7ObjZU6bdqKn2MXEgBxlWAzhlEBclsvUyYwm3D/OF2sEtgWpbQfFKSqP
 U7jVku67pcfIb4kltKuckJgvtX5ayXU3nystW1TzWDw9u1UAk+VjUhe7tK9vwXJxzTWEy++mNDd
 CxU2VgY=
X-Received: by 2002:a7b:c319:0:b0:434:f586:7520 with SMTP id
 5b1f17b1804b1-43924a27e47mr4460165e9.6.1738866442365; 
 Thu, 06 Feb 2025 10:27:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEFv0yp6Pc/17tva9qeYrjmWryHjjb8YNY48mesuOMfENJWxQ+RpIT6xhMdNRBcgzkuWqpZJw==
X-Received: by 2002:a7b:c319:0:b0:434:f586:7520 with SMTP id
 5b1f17b1804b1-43924a27e47mr4459935e9.6.1738866441856; 
 Thu, 06 Feb 2025 10:27:21 -0800 (PST)
Received: from [192.168.1.84] ([93.56.163.127])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4391da9656fsm28597865e9.3.2025.02.06.10.27.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2025 10:27:20 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: alistair.francis@wdc.com
Subject: [PATCH 04/22] target/riscv: merge riscv_cpu_class_init with the
 class_base function
Date: Thu,  6 Feb 2025 19:26:52 +0100
Message-ID: <20250206182711.2420505-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250206182711.2420505-1-pbonzini@redhat.com>
References: <20250206182711.2420505-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Since all TYPE_RISCV_CPU subclasses support a class_data of type
RISCVCPUDef, process it even before calling the .class_init function
for the subclasses.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/riscv/cpu.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 803b2a7c3f4..baf4dd017b2 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -2961,15 +2961,18 @@ static void riscv_cpu_class_base_init(ObjectClass *c, void *data)
     } else {
         mcc->def = g_new0(RISCVCPUDef, 1);
     }
-}
 
-static void riscv_cpu_class_init(ObjectClass *c, void *data)
-{
-    RISCVCPUClass *mcc = RISCV_CPU_CLASS(c);
-    RISCVCPUDef *def = data;
+    if (data) {
+        RISCVCPUDef *def = data;
+        if (def->misa_mxl_max) {
+            assert(def->misa_mxl_max <= MXL_RV128);
+            mcc->def->misa_mxl_max = def->misa_mxl_max;
+        }
+    }
 
-    mcc->def->misa_mxl_max = def->misa_mxl_max;
-    riscv_cpu_validate_misa_mxl(mcc);
+    if (!object_class_is_abstract(c)) {
+        riscv_cpu_validate_misa_mxl(mcc);
+    }
 }
 
 static void riscv_isa_string_ext(RISCVCPU *cpu, char **isa_str,
@@ -3069,7 +3072,6 @@ void riscv_isa_write_fdt(RISCVCPU *cpu, void *fdt, char *nodename)
         .name = (type_name),                                \
         .parent = TYPE_RISCV_DYNAMIC_CPU,                   \
         .instance_init = (initfn),                          \
-        .class_init = riscv_cpu_class_init,                 \
         .class_data = &((RISCVCPUDef) {                     \
              .misa_mxl_max = (misa_mxl_max_),               \
         }),                                                 \
@@ -3080,7 +3082,6 @@ void riscv_isa_write_fdt(RISCVCPU *cpu, void *fdt, char *nodename)
         .name = (type_name),                                \
         .parent = TYPE_RISCV_VENDOR_CPU,                    \
         .instance_init = (initfn),                          \
-        .class_init = riscv_cpu_class_init,                 \
         .class_data = &((RISCVCPUDef) {                     \
              .misa_mxl_max = (misa_mxl_max_),               \
         }),                                                 \
@@ -3091,7 +3092,6 @@ void riscv_isa_write_fdt(RISCVCPU *cpu, void *fdt, char *nodename)
         .name = (type_name),                                \
         .parent = TYPE_RISCV_BARE_CPU,                      \
         .instance_init = (initfn),                          \
-        .class_init = riscv_cpu_class_init,                 \
         .class_data = &((RISCVCPUDef) {                     \
              .misa_mxl_max = (misa_mxl_max_),               \
         }),                                                 \
@@ -3102,7 +3102,6 @@ void riscv_isa_write_fdt(RISCVCPU *cpu, void *fdt, char *nodename)
         .name = (type_name),                                \
         .parent = TYPE_RISCV_BARE_CPU,                      \
         .instance_init = (initfn),                          \
-        .class_init = riscv_cpu_class_init,                 \
         .class_data = &((RISCVCPUDef) {                     \
              .misa_mxl_max = (misa_mxl_max_),               \
         }),                                                 \
-- 
2.48.1


