Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B027C5AD49
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 07:14:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKtwU-0001xc-CI; Fri, 30 May 2025 03:14:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKtwR-0001jO-Gl
 for qemu-devel@nongnu.org; Fri, 30 May 2025 03:14:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKtwP-0006wd-NP
 for qemu-devel@nongnu.org; Fri, 30 May 2025 03:14:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748589249;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zD5uJ8jFUB+v/sY8GNGoG42jUP/hPHeJqHlrZl8Wgb8=;
 b=Am2Q9Ylx63Ar/oNTRdMW0gDbLqtflvKl9jAQZLB5JJsl8CEiQOfA9PJX8xgA/EOC7Tb97Z
 M8ietuPhZS8dkNIeUb61ryNrs3pkpr6RIprBDBSV/YTZOd3vgksHhKzgFVarouq4G9PUAr
 ngaB40sj+6uBerElou3cELpOTzQsi1w=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-416-mrt-k4WvOV-ri5NVayR8eA-1; Fri, 30 May 2025 03:14:07 -0400
X-MC-Unique: mrt-k4WvOV-ri5NVayR8eA-1
X-Mimecast-MFC-AGG-ID: mrt-k4WvOV-ri5NVayR8eA_1748589246
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-602df3e7adcso1875991a12.1
 for <qemu-devel@nongnu.org>; Fri, 30 May 2025 00:14:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748589245; x=1749194045;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zD5uJ8jFUB+v/sY8GNGoG42jUP/hPHeJqHlrZl8Wgb8=;
 b=ZhVuFVZv45Rs/gN/RFszJEyVvMV4SCM6MD2GihgHSV3t/C+Ahnqe1bWtDCxfcUAqr1
 UGse6xM3UaxFwpH6HheP4WkXoGBw0KUQX5FKQGnei48X4u6iFcw0P93nBLhbkABtr1q3
 UZBeozsxLOGo6n2wp7TAejccaYOzX0tQWBaCFxfGmA2Ps7SW9e2Ijfdd0CWqRJ+dKciX
 57mciuv7VYaioPnWTgjchiZRP7JjdJlt+9jue5GJ+e+j7g6PyomgBwUEfMULIFyLBJ3A
 YhHn80aEsz+1PdNJ3LUhfCt1ZbxJ38BYQVzwR6hHXBQwtYxkQQAA0/cCo3BmL3NQcvm/
 SuyA==
X-Gm-Message-State: AOJu0YwILfZmR6knjSxDYcrIIEGZAe9Ef5QEdiky7txLy+dc5jKj5AMz
 RFVxqQk9Cy2/dn5Qb93nAwh9m8gcbkd2sLY7byPJCCjeGY2nVCn0bei6YjnUF/sq8NYYxb10wuc
 uoVqd4FrYvTH4uzOo25zUL8nW3rrFGqvmIQ6qj5OhuI9tLB0kL0fJhIAabiAaqaD4TV462nyzYD
 tFXyMlp+6PiGad+uXCfy3Sixcchc1l1LB7C5f5vZzl
X-Gm-Gg: ASbGncsnzovOeMxx+XwZgHyHCyok6cT4EottYiKy/WAyNoNKeZMnFVr2vcWGX3aG0CE
 HdRFNivqmQFRuXwIASVCRWUvN+ilUEqVuERNDSoaqmwHFSp900KRpHWHwWE895aiVM8KIvYQafw
 vjE0OTaZomxzFSpEZCiyqrdEp6uZ5ZUCsv1r1nf7PrG/s0OFvYmfYobYPALUUCpIrr6KPRZA1Wl
 9mX5KKea3zNO4b0IZPSiqETeOuUII1a8TeiBHFNHsCXdb4YiG/kK0wo0bHEDMlJs1JrS6g2fjEU
 pajHPcPeqUMuAw==
X-Received: by 2002:a05:6402:4408:b0:5fd:1972:7fac with SMTP id
 4fb4d7f45d1cf-6057c1a509bmr1032598a12.3.1748589245305; 
 Fri, 30 May 2025 00:14:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFO1eMPREg3fiDQfV5uOr4zPYxdC4zR10d4Igiom1WhdVHQ6eZmfWaRwi7kAxAx8ZuKdtKMOQ==
X-Received: by 2002:a05:6402:4408:b0:5fd:1972:7fac with SMTP id
 4fb4d7f45d1cf-6057c1a509bmr1032573a12.3.1748589244925; 
 Fri, 30 May 2025 00:14:04 -0700 (PDT)
Received: from [192.168.122.1] ([151.49.64.79])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-60566c74ee7sm1222976a12.47.2025.05.30.00.14.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 May 2025 00:14:03 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 30/77] i386/tdx: Parse TDVF metadata for TDX VM
Date: Fri, 30 May 2025 09:12:00 +0200
Message-ID: <20250530071250.2050910-31-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250530071250.2050910-1-pbonzini@redhat.com>
References: <20250530071250.2050910-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.902,
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

From: Xiaoyao Li <xiaoyao.li@intel.com>

After TDVF is loaded to bios MemoryRegion, it needs parse TDVF metadata.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Acked-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20250508150002.689633-19-xiaoyao.li@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/kvm/tdx.h      | 3 +++
 hw/i386/pc_sysfw.c         | 7 +++++++
 target/i386/kvm/tdx-stub.c | 5 +++++
 target/i386/kvm/tdx.c      | 5 +++++
 4 files changed, 20 insertions(+)

diff --git a/target/i386/kvm/tdx.h b/target/i386/kvm/tdx.h
index b73461b8d8a..28a03c2a7b8 100644
--- a/target/i386/kvm/tdx.h
+++ b/target/i386/kvm/tdx.h
@@ -8,6 +8,7 @@
 #endif
 
 #include "confidential-guest.h"
+#include "hw/i386/tdvf.h"
 
 #define TYPE_TDX_GUEST "tdx-guest"
 #define TDX_GUEST(obj)  OBJECT_CHECK(TdxGuest, (obj), TYPE_TDX_GUEST)
@@ -32,6 +33,7 @@ typedef struct TdxGuest {
     char *mrownerconfig;    /* base64 encoded sha348 digest */
 
     MemoryRegion *tdvf_mr;
+    TdxFirmware tdvf;
 } TdxGuest;
 
 #ifdef CONFIG_TDX
@@ -42,5 +44,6 @@ bool is_tdx_vm(void);
 
 int tdx_pre_create_vcpu(CPUState *cpu, Error **errp);
 void tdx_set_tdvf_region(MemoryRegion *tdvf_mr);
+int tdx_parse_tdvf(void *flash_ptr, int size);
 
 #endif /* QEMU_I386_TDX_H */
diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
index 1eeb58ab37f..821396c16e9 100644
--- a/hw/i386/pc_sysfw.c
+++ b/hw/i386/pc_sysfw.c
@@ -37,6 +37,7 @@
 #include "hw/block/flash.h"
 #include "system/kvm.h"
 #include "target/i386/sev.h"
+#include "kvm/tdx.h"
 
 #define FLASH_SECTOR_SIZE 4096
 
@@ -280,5 +281,11 @@ void x86_firmware_configure(hwaddr gpa, void *ptr, int size)
         }
 
         sev_encrypt_flash(gpa, ptr, size, &error_fatal);
+    } else if (is_tdx_vm()) {
+        ret = tdx_parse_tdvf(ptr, size);
+        if (ret) {
+            error_report("failed to parse TDVF for TDX VM");
+            exit(1);
+        }
     }
 }
diff --git a/target/i386/kvm/tdx-stub.c b/target/i386/kvm/tdx-stub.c
index 2344433594e..7748b6d0a44 100644
--- a/target/i386/kvm/tdx-stub.c
+++ b/target/i386/kvm/tdx-stub.c
@@ -8,3 +8,8 @@ int tdx_pre_create_vcpu(CPUState *cpu, Error **errp)
 {
     return -EINVAL;
 }
+
+int tdx_parse_tdvf(void *flash_ptr, int size)
+{
+    return -EINVAL;
+}
diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index 0f5acbf980b..18beba2f5c3 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -382,6 +382,11 @@ int tdx_pre_create_vcpu(CPUState *cpu, Error **errp)
     return 0;
 }
 
+int tdx_parse_tdvf(void *flash_ptr, int size)
+{
+    return tdvf_parse_metadata(&tdx_guest->tdvf, flash_ptr, size);
+}
+
 static bool tdx_guest_get_sept_ve_disable(Object *obj, Error **errp)
 {
     TdxGuest *tdx = TDX_GUEST(obj);
-- 
2.49.0


