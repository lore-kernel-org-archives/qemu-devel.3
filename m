Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1114C282C5
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2025 10:28:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnxb9-0001wa-Cq; Fri, 28 Feb 2025 05:28:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tnxb8-0001wK-NE
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 05:28:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tnxb6-0002vd-Ta
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 05:28:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740738480;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sVmpYtcqVijX5HvSBrTAWOLU5ZgugiiH2XWrUKMBhbM=;
 b=Qirdcr0CEeTj1M8hJdIHmbPHCQSfnU4bRokbMBP66KSyzxt/7JncC3eL/0wXYGlf6agH9V
 OCqlTD6AyyMSMyf3EfK5d5LeSnq0M7vg/GeR3D/+ezbYC4QZgYRcK1p6T/OPomQeCpMLlO
 R9880KnC1LKbTHmnI8By87RtiPnXXR8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-uRX1ZoFzNwOTn7ifngxhxw-1; Fri, 28 Feb 2025 05:27:58 -0500
X-MC-Unique: uRX1ZoFzNwOTn7ifngxhxw-1
X-Mimecast-MFC-AGG-ID: uRX1ZoFzNwOTn7ifngxhxw_1740738477
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-38f338525e1so790208f8f.3
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2025 02:27:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740738476; x=1741343276;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sVmpYtcqVijX5HvSBrTAWOLU5ZgugiiH2XWrUKMBhbM=;
 b=lxCvi3TtL/3Oh2Ye/5HohVfutQzHhUyqvxboUAFE9bmhyj5q1cvRe5y/OY9IZW3LFS
 zMsD/9bnkLUMax1IUb1GQpXbPTXEhYG1l8gomPgsVBv8nA3R3IDahENmL6EObVKlcqIU
 tHyXzi5zZ2HNJeSDlCE5hAknm1Q+iY4xNOe+zMtT/YtEI1MI4YMRwnhvaFKw3H4aCsPB
 lxDPEsueH1UjgGZjSrhhc98uq4uVCagbT2uLRH2xVRxOi8H5g9TqBe9UjgILm8mMTty8
 4ynqbpK5c6YZ9eNsIzvn7FRN690D14nroqSlnR7L0XbZWcv2gOa5+2ayuvdjHY6/Vg5g
 09Dw==
X-Gm-Message-State: AOJu0YycncIRIp0reZ6VCjisFWmLZ0v27SjXoRlWiQlUFmA0skEEFDQT
 IjGCFMSptg8fCTBBMIk764lWxaMNaVZfP5MCIQAydrlCBl8H4Sy8QZdtjeEOGJSTAugFD12Enia
 ZM/9yveCzWDyLxl41RP+L7kCJ3BuTd0oGlm476xYfB8p6uOvkO32NHym9vnTM/AoK6UpwBqmgqr
 5pwI2WuMrF1qnPlW1eQjwrN3841kl0PxK7d2aDhQA=
X-Gm-Gg: ASbGncuLPptB5v+04hBdxPJCcPZZvedXiaWngMTSi1IaOCdsmsDAswAe+5L48evx1yL
 SKQzBy5WYYQNCbf5+QoUOXLeB22vofc6r5SrK7wf7MC9HsEMvLuTdu6m/SevIoUNfV67lhJLlmc
 VY1DRDWH1ucfDhRfN9fPBd7AXu8pzi6kbGAs64NjyrRRz5p11Zib9diHd/nxBFA+TtS8tk+sTvE
 eU4Ri2G2K+vMXFUEdMb8OS3/2XTPHgjDi3XkKlMVR271UM8QxM9CMajFW3iySX7YAuzGMmJOMSK
 1+g8g/JmMXJFJgrxq++J
X-Received: by 2002:a05:6000:188c:b0:38c:5bfa:a93d with SMTP id
 ffacd0b85a97d-390ec7c8f9fmr1993264f8f.10.1740738475796; 
 Fri, 28 Feb 2025 02:27:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEmPzRrC4Eu/JeflAxHwANSVjvN+wuthq+8q8guWGjZ2C4CAGjh/f/MAaEmvWTpgw+VjURzCA==
X-Received: by 2002:a05:6000:188c:b0:38c:5bfa:a93d with SMTP id
 ffacd0b85a97d-390ec7c8f9fmr1993243f8f.10.1740738475406; 
 Fri, 28 Feb 2025 02:27:55 -0800 (PST)
Received: from [192.168.10.48] ([151.95.152.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e4795d44sm4718395f8f.8.2025.02.28.02.27.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2025 02:27:53 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: alistair.francis@wdc.com
Subject: [PATCH 03/22] target/riscv: introduce RISCVCPUDef
Date: Fri, 28 Feb 2025 11:27:27 +0100
Message-ID: <20250228102747.867770-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250228102747.867770-1-pbonzini@redhat.com>
References: <20250228102747.867770-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
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

Start putting all the CPU definitions in a struct.  Later this will replace
instance_init functions with declarative code, for now just remove the
ugly cast of class_data.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/riscv/cpu.h |  4 ++++
 target/riscv/cpu.c | 27 ++++++++++++++++++---------
 2 files changed, 22 insertions(+), 9 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 3041a4be5c9..743afeb1655 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -531,6 +531,10 @@ struct ArchCPU {
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
index f05b72ac873..a71d806e35f 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -2960,8 +2960,9 @@ static void riscv_cpu_common_class_init(ObjectClass *c, void *data)
 static void riscv_cpu_class_init(ObjectClass *c, void *data)
 {
     RISCVCPUClass *mcc = RISCV_CPU_CLASS(c);
+    const RISCVCPUDef *def = data;
 
-    mcc->misa_mxl_max = (RISCVMXL)GPOINTER_TO_UINT(data);
+    mcc->misa_mxl_max = def->misa_mxl_max;
     riscv_cpu_validate_misa_mxl(mcc);
 }
 
@@ -3057,40 +3058,48 @@ void riscv_isa_write_fdt(RISCVCPU *cpu, void *fdt, char *nodename)
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
2.48.1


