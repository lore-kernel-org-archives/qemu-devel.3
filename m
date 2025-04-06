Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DC00C3600C
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Apr 2025 07:04:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u1K2Y-0002uh-Uw; Sun, 06 Apr 2025 03:03:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u1K2O-0002t2-7F
 for qemu-devel@nongnu.org; Sun, 06 Apr 2025 03:03:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u1K2M-00020B-Jv
 for qemu-devel@nongnu.org; Sun, 06 Apr 2025 03:03:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743923001;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=47SSQJimXtsrhDyrql9Oh3cQIzOvmVCv/sKosztLX6k=;
 b=c5ZLzASEUj7OTZwAlgOpaRSumUtQny/YCinF12c6QfcYiIzrYQVj0BzsFMLBsvLVicbUaN
 hb0oeeSxxZsizCLx2auaZUWelWGIfi9mb8jWc49LQwpDZnzclNRCiMPpgBvI1/Wl0oYI0d
 3D9ZmBQApcuLKVt8knyLUkcYonFUctM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-573-NTjj6vfsMCqqUvl1H0arSg-1; Sun, 06 Apr 2025 03:03:19 -0400
X-MC-Unique: NTjj6vfsMCqqUvl1H0arSg-1
X-Mimecast-MFC-AGG-ID: NTjj6vfsMCqqUvl1H0arSg_1743922999
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43d0830c3f7so27807955e9.2
 for <qemu-devel@nongnu.org>; Sun, 06 Apr 2025 00:03:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743922998; x=1744527798;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=47SSQJimXtsrhDyrql9Oh3cQIzOvmVCv/sKosztLX6k=;
 b=sPM8QJG/E1UgVyP388oVfjgtC+mg5tDxlDMkxH9qNqTu+JzpJCNcb1BaTmBMVhxf+e
 B97mUm5AmTTQ5wNXhB76qwyFEAT6m3Z80Vqwdhou0d2SyInEaYetIo1BoVY5XfnTDC/X
 J1RY8Qmoc/mn29pPl5bb1Ll0hNSM6DnwWaLTADZAqj7xATge+60hJIpNLS4mRAMSYPM5
 XbM3wces2R46aJjJXZLFU9R+2NK6jR/i1o5gqP0MoOJZPxd18cV3/i2+8oB/E8o7S5Az
 rnwE3+7/Sh4CKFLKehqcAD2ucVfpn25Yc4Daz+CdIk4Nl/TSrOnedwT6lZj0RSZVFbzl
 r9/A==
X-Gm-Message-State: AOJu0YxsTpdBNH0H+KY/CzP24V7S3jKRhIwCxaUVPl8GcswUhCgKjDqh
 i6XWzH+oi9lxYLP8TKTqSmMztBiZg9X95UJf5vMZ0/wfkDwVPEZIHWOiY415mLpZ4Hm46dzChJ+
 jofvOtfVQGWZyiD7v1s1T9lClcd91tlZL5db+7iFjRUyaAx4shSwprli62Vi7RsTniw7vR1cUfO
 u2/TWUo1AZ7aq6/tFNiqhJg2rZhXzS1ja6YdeH
X-Gm-Gg: ASbGncux2xtBsK+Ij7MnQTtoLY08EX8FEJwXgfj8oacudIMYvWQCJtbwKXvQ8gCr1hj
 lUE2UQRfzW9l9aT5usMukN4r1FqEKkwB3t+vZesHtJOVGwnZZSSnODz542zER8WZNrG8e76LLZa
 Yjdv9yK38vWROhNlhxZTv8o+4CLXaZu4B5p0BFaGJDvHprDT3zOFvH9Ctbpru46QeFc1NJGdZxY
 IiTLGWTjnwTSjJ1BreN6rymdpovOgzMEgB7Scg5traf/ZUHdToQcYNExgOeBltR3M44jCj8hk/o
 TMJCbPOYcjpqeyVvFA==
X-Received: by 2002:a05:6000:18af:b0:39c:2669:d7f4 with SMTP id
 ffacd0b85a97d-39d0de67cb4mr6832949f8f.43.1743922998088; 
 Sun, 06 Apr 2025 00:03:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGfWBpyVkuH2NuW7TWacFphfhd6WwMBtBxeCOYx/+kbGeSqwiV1i1p39P0Oceh3iGqDKkqk2Q==
X-Received: by 2002:a05:6000:18af:b0:39c:2669:d7f4 with SMTP id
 ffacd0b85a97d-39d0de67cb4mr6832917f8f.43.1743922997653; 
 Sun, 06 Apr 2025 00:03:17 -0700 (PDT)
Received: from [192.168.122.1] ([151.95.96.77])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c3009674bsm8666911f8f.3.2025.04.06.00.03.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Apr 2025 00:03:15 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com
Subject: [PATCH 07/27] target/riscv: introduce RISCVCPUDef
Date: Sun,  6 Apr 2025 09:02:34 +0200
Message-ID: <20250406070254.274797-8-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250406070254.274797-1-pbonzini@redhat.com>
References: <20250406070254.274797-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.359,
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

Start putting all the CPU definitions in a struct.  Later this will replace
instance_init functions with declarative code, for now just remove the
ugly cast of class_data.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/riscv/cpu.h |  4 ++++
 target/riscv/cpu.c | 27 ++++++++++++++++++---------
 2 files changed, 22 insertions(+), 9 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 7e10c08a771..65c8d6855ec 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -541,6 +541,10 @@ struct ArchCPU {
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
index 9603f8985b3..3bd2bff1328 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -3082,8 +3082,9 @@ static void riscv_cpu_common_class_init(ObjectClass *c, void *data)
 static void riscv_cpu_class_init(ObjectClass *c, void *data)
 {
     RISCVCPUClass *mcc = RISCV_CPU_CLASS(c);
+    const RISCVCPUDef *def = data;
 
-    mcc->misa_mxl_max = (RISCVMXL)GPOINTER_TO_UINT(data);
+    mcc->misa_mxl_max = def->misa_mxl_max;
     riscv_cpu_validate_misa_mxl(mcc);
 }
 
@@ -3179,40 +3180,48 @@ void riscv_isa_write_fdt(RISCVCPU *cpu, void *fdt, char *nodename)
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
+        .class_data = (void*) &((const RISCVCPUDef) {       \
+             .misa_mxl_max = (misa_mxl_max_),               \
+        }),                                                 \
     }
 
-#define DEFINE_VENDOR_CPU(type_name, misa_mxl_max, initfn)  \
+#define DEFINE_VENDOR_CPU(type_name, misa_mxl_max_, initfn) \
     {                                                       \
         .name = (type_name),                                \
         .parent = TYPE_RISCV_VENDOR_CPU,                    \
         .instance_init = (initfn),                          \
         .class_init = riscv_cpu_class_init,                 \
-        .class_data = GUINT_TO_POINTER(misa_mxl_max)        \
+        .class_data = (void*) &((const RISCVCPUDef) {       \
+             .misa_mxl_max = (misa_mxl_max_),               \
+        }),                                                 \
     }
 
-#define DEFINE_BARE_CPU(type_name, misa_mxl_max, initfn)    \
+#define DEFINE_BARE_CPU(type_name, misa_mxl_max_, initfn)   \
     {                                                       \
         .name = (type_name),                                \
         .parent = TYPE_RISCV_BARE_CPU,                      \
         .instance_init = (initfn),                          \
         .class_init = riscv_cpu_class_init,                 \
-        .class_data = GUINT_TO_POINTER(misa_mxl_max)        \
+        .class_data = (void*) &((const RISCVCPUDef) {       \
+             .misa_mxl_max = (misa_mxl_max_),               \
+        }),                                                 \
     }
 
-#define DEFINE_PROFILE_CPU(type_name, misa_mxl_max, initfn) \
+#define DEFINE_PROFILE_CPU(type_name, misa_mxl_max_, initfn) \
     {                                                       \
         .name = (type_name),                                \
         .parent = TYPE_RISCV_BARE_CPU,                      \
         .instance_init = (initfn),                          \
         .class_init = riscv_cpu_class_init,                 \
-        .class_data = GUINT_TO_POINTER(misa_mxl_max)        \
+        .class_data = (void*) &((const RISCVCPUDef) {       \
+             .misa_mxl_max = (misa_mxl_max_),               \
+        }),                                                 \
     }
 
 static const TypeInfo riscv_cpu_type_infos[] = {
-- 
2.49.0


