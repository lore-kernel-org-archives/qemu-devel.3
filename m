Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BE9AC3ABBC
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 09:54:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEPrC-0007e9-SU; Mon, 12 May 2025 05:53:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uEPqr-0007ac-RV
 for qemu-devel@nongnu.org; Mon, 12 May 2025 05:53:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uEPqp-0000gh-LN
 for qemu-devel@nongnu.org; Mon, 12 May 2025 05:53:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747043615;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mCH29pN/IXGN1aigqVDTaDRuiQNFdOSj1tXV11jbN+Q=;
 b=K0zXM8qz3zc5p3BNoaldo8yOIxEDpAXaMtbueVpRTIoIDeGq51kyDr1T4upHIW3dB8PTMr
 8hgl/L3ZX82kKmF8d1sgfAw8JrvY2zqlkX0ejH6nHwSo19HIF0DHGxOsdceTSdqUjmfctN
 pYWH9tjAgUQMo1b98Jd37sskKO9P8Ws=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-13-0lgCyxaMPja-eLNEJxSlfw-1; Mon, 12 May 2025 05:53:33 -0400
X-MC-Unique: 0lgCyxaMPja-eLNEJxSlfw-1
X-Mimecast-MFC-AGG-ID: 0lgCyxaMPja-eLNEJxSlfw_1747043612
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-5fc013fb4easo4620827a12.0
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 02:53:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747043611; x=1747648411;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mCH29pN/IXGN1aigqVDTaDRuiQNFdOSj1tXV11jbN+Q=;
 b=tIpmgfFPWkR3YQbT34hPQaR/6CpYUCZgeDAjilqg9EEXFhZzNQB9IqvJxD7pwGtG5C
 5Uu9PKnHDEM975BQMxow1BjZBNPHgerB0+sVwKwA/c/qfZYGl0Iw9ANyzZQ/TTehE0AF
 Qh7s38UmdrlUkuSNaoC75T/CJspZf/xzwIOn0AGpmG/Romnn1NsZ4nk7oBSqvU1G0njz
 bK4ys9Y33RZKykVr9F9vB06bGshJvJETaQadp7gMWqQk3FE0kjcY2Q8rwB0Hvs2ae9Oi
 eEaDHXcBibn0KH1Pt/JEg2bUfJS8qDz26ZiuniJr8/EuoAUGHBbpzzhM6lQfGBVDpPQY
 4q5Q==
X-Gm-Message-State: AOJu0YyE/LPHKbNit9AW+BMpvMuh11oxobrqeMmYpZC2X+OpXFvI2XTa
 9w3kWOyZHLJOwDP30TmUF6SGzrPeD+F7UUknroLjft/wnmDCJtU0m4VQY0u5tTfBld+637XKNgu
 TOB5iiJLgKSX2BUaqvYPkmyUyN+Nr0xLx3ufS8Gb+PBdkodsy1G7KXzOhbjGyM3IZ4jc5wtQ7UA
 Kwp7VOnCk6v4/bXtSoRUnQ8++HDila5n+sOpgi
X-Gm-Gg: ASbGncv/esDJOn1raQUPOOXD1v4WGglFuP2W9V2g8bK4cx+0MESJM955p5mf8CK/+vr
 DtobHDski2DzCNTIf0Qs2L+7fYddRCTsXHNo9hV4OX9IAQJCYr+xH3X/k5/CWyGSrgAfHyKoo+m
 sKlKrtPQgHPSPDKvHtK+QfpVOsz+YRBJETXMons3GIRZe+P90WmRdIX8RjznRCRXLad4z6iXw1C
 3S8rJtnOdUvc1FEw9E/7YmBTzrlJELBPtAM1+/sFHpqrPFjugIt4895Lum7LqFY5YUy2+RUot5/
 qV656+LfLzzGkAr0l76WFTLqGudB6T1UbX3K8lfR+pfWCSU=
X-Received: by 2002:a05:6402:40c5:b0:5fc:b8ab:a17d with SMTP id
 4fb4d7f45d1cf-5fcb8aba41cmr7483436a12.21.1747043610157; 
 Mon, 12 May 2025 02:53:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE8W0SBNoJJCmEPq4sLU6nt3vazVjhvXu9TdiylV9qbrXRKEoieeuEEMZarI2vItbFLDOeuCA==
X-Received: by 2002:a05:6402:40c5:b0:5fc:b8ab:a17d with SMTP id
 4fb4d7f45d1cf-5fcb8aba41cmr7483099a12.21.1747043606232; 
 Mon, 12 May 2025 02:53:26 -0700 (PDT)
Received: from [192.168.122.1] (93-40-56-213.ip37.fastwebnet.it.
 [93.40.56.213]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5fc9cc26e3dsm5504392a12.27.2025.05.12.02.53.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 May 2025 02:53:25 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: dbarboza@ventanamicro.com, alistair23@gmail.com,
 richard.henderson@linaro.org
Subject: [PATCH 06/26] target/riscv: introduce RISCVCPUDef
Date: Mon, 12 May 2025 11:52:06 +0200
Message-ID: <20250512095226.93621-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250512095226.93621-1-pbonzini@redhat.com>
References: <20250512095226.93621-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.587,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

Start putting all the CPU definitions in a struct.  Later this will replace
instance_init functions with declarative code, for now just remove the
ugly cast of class_data.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/riscv/cpu.h |  4 ++++
 target/riscv/cpu.c | 27 ++++++++++++++++++---------
 2 files changed, 22 insertions(+), 9 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 8b23aa27740..511fc25adc0 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -537,6 +537,10 @@ struct ArchCPU {
     const GPtrArray *decoders;
 };
 
+typedef struct RISCVCPUDef {
+    RISCVMXL misa_mxl_max;  /* max mxl for this cpu */
+} RISCVCPUDef;
+
 /**
  * RISCVCPUClass:
  * @parent_realize: The parent class' realize handler.
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 54a996c2927..c163b2b24a2 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -3073,8 +3073,9 @@ static void riscv_cpu_common_class_init(ObjectClass *c, const void *data)
 static void riscv_cpu_class_init(ObjectClass *c, const void *data)
 {
     RISCVCPUClass *mcc = RISCV_CPU_CLASS(c);
+    const RISCVCPUDef *def = data;
 
-    mcc->misa_mxl_max = (RISCVMXL)GPOINTER_TO_UINT(data);
+    mcc->misa_mxl_max = def->misa_mxl_max;
     riscv_cpu_validate_misa_mxl(mcc);
 }
 
@@ -3170,40 +3171,48 @@ void riscv_isa_write_fdt(RISCVCPU *cpu, void *fdt, char *nodename)
 }
 #endif
 
-#define DEFINE_DYNAMIC_CPU(type_name, misa_mxl_max, initfn) \
+#define DEFINE_DYNAMIC_CPU(type_name, misa_mxl_max_, initfn) \
     {                                                       \
         .name = (type_name),                                \
         .parent = TYPE_RISCV_DYNAMIC_CPU,                   \
         .instance_init = (initfn),                          \
         .class_init = riscv_cpu_class_init,                 \
-        .class_data = GUINT_TO_POINTER(misa_mxl_max)        \
+        .class_data = &(const RISCVCPUDef) {                \
+             .misa_mxl_max = (misa_mxl_max_),               \
+        },                                                  \
     }
 
-#define DEFINE_VENDOR_CPU(type_name, misa_mxl_max, initfn)  \
+#define DEFINE_VENDOR_CPU(type_name, misa_mxl_max_, initfn) \
     {                                                       \
         .name = (type_name),                                \
         .parent = TYPE_RISCV_VENDOR_CPU,                    \
         .instance_init = (initfn),                          \
         .class_init = riscv_cpu_class_init,                 \
-        .class_data = GUINT_TO_POINTER(misa_mxl_max)        \
+        .class_data = &(const RISCVCPUDef) {                \
+             .misa_mxl_max = (misa_mxl_max_),               \
+        },                                                  \
     }
 
-#define DEFINE_BARE_CPU(type_name, misa_mxl_max, initfn)    \
+#define DEFINE_BARE_CPU(type_name, misa_mxl_max_, initfn)   \
     {                                                       \
         .name = (type_name),                                \
         .parent = TYPE_RISCV_BARE_CPU,                      \
         .instance_init = (initfn),                          \
         .class_init = riscv_cpu_class_init,                 \
-        .class_data = GUINT_TO_POINTER(misa_mxl_max)        \
+        .class_data = &(const RISCVCPUDef) {                \
+             .misa_mxl_max = (misa_mxl_max_),               \
+        },                                                  \
     }
 
-#define DEFINE_PROFILE_CPU(type_name, misa_mxl_max, initfn) \
+#define DEFINE_PROFILE_CPU(type_name, misa_mxl_max_, initfn) \
     {                                                       \
         .name = (type_name),                                \
         .parent = TYPE_RISCV_BARE_CPU,                      \
         .instance_init = (initfn),                          \
         .class_init = riscv_cpu_class_init,                 \
-        .class_data = GUINT_TO_POINTER(misa_mxl_max)        \
+        .class_data = &(const RISCVCPUDef) {                \
+             .misa_mxl_max = (misa_mxl_max_),               \
+        },                                                  \
     }
 
 static const TypeInfo riscv_cpu_type_infos[] = {
-- 
2.49.0


