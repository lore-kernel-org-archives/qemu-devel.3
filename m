Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E4FEC0219B
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 18:28:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg6az-00018A-Nq; Thu, 06 Feb 2025 13:27:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tg6ax-00017X-PT
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 13:27:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tg6aw-0000z3-3R
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 13:27:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738866441;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JjrCBWCNmpmL3kd1wohdPboFRNnStVvOZdacUSI6T3U=;
 b=iJy1eQYUfNXLw4pcJloKWHkLocNPT3vb1ljDidyBf5wdgREUlIk7gpIVD8t4iBYPlWRIdN
 CInrysjRD/cKCUV1eH9vk5Lah3Z7jQhML+TmQxJ7IieaJEtbsGJL+NxtaX3MZvhhGTa6Us
 CTdoQrukzv1jP+9GwaZ67VVHLDQkKN8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-462-ksB0ogtWNVGzU2u5n_Kthw-1; Thu, 06 Feb 2025 13:27:19 -0500
X-MC-Unique: ksB0ogtWNVGzU2u5n_Kthw-1
X-Mimecast-MFC-AGG-ID: ksB0ogtWNVGzU2u5n_Kthw
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-436379713baso6525375e9.2
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 10:27:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738866438; x=1739471238;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JjrCBWCNmpmL3kd1wohdPboFRNnStVvOZdacUSI6T3U=;
 b=jIFULvw0J3GEUvdULw8glIuV/iXGWD/uKLo7lNilGyShf7jHVe4PzUTTC67pFRnfNt
 VBYYILth1N3czfCBMgEBXcIHVXWOE62wHPzucqe0vkc/NQvHwFLq6GxGDL+0wLtPvlCe
 29Jo4wrauchRJpNLlLo5xF0VWl6XQZtq/tl7CLaXR0ueS6jH2NS00yWg5g4jSf0YQXFU
 MmHKJS8SIR8hZJx5AEM6xXdtsb0ZgAWwQMUJjSx5h41oLlSJvr1eiyMDl1s4lpxffHDn
 XsqwiqJv3j5/UkInD//96fxe+J3DLvUxlLu8AznFBqIN/S0eeXNRI7u9gePsu7R4xjxr
 EfVg==
X-Gm-Message-State: AOJu0YwvFO3SCaF1pK5Ps0uaJIpznCCTciGkjvCuFAVUh9MY+7NMa7UW
 X9q3gPK62zOMoeYrUOnheciZ2MVCAe/bF4IPrdOYcZF9gNGZ9jaO1VWB+TFHlYVFMUUn4TYvaE6
 JMv7K/BTVlTpPtEyeziR0xzZ8mh6Fxz4EBB+qfxmLeqjbxtFW3/WcVKRKzJRc+Q+GDZqsXfvTA0
 GVFEjnpOoPbNKCbvs0xhBizTYkjfcLOgwL66pXo4Y=
X-Gm-Gg: ASbGncukGWo2DYKZIG5gNWRErc6KWKyp1k29D4g0DzRTxen2SXKp5qnC7ZIuEDQowh4
 GSjuxUydw1aXNPD6GaTp0gTl8FY8eM4UcDQFzvr24mASDKBlrpCAJ8u2plc8MIcUK1J3E8YWYg8
 XpfngNhrLKZg7WSk5rmFIi4XppOj1Vtc6RtuSPSjlik56TJg3w/+O8i+Askj1p36Mm7FEcVEYr5
 CfLelFoAN5pvJVABT5oTRRROSp6AA3RzUfAZTlT8LyQU+olOnoRetyNPtiV//aHy/xE6d5rik9t
 /VIdNDE=
X-Received: by 2002:a5d:6485:0:b0:38a:41b6:d685 with SMTP id
 ffacd0b85a97d-38dc8dc2fbemr50544f8f.3.1738866437951; 
 Thu, 06 Feb 2025 10:27:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEXXHhqcteKNnjj7DQCQ4q4JEuDkuctqD2ZKT5HM6GIMMQAy/xgLHbLq6/DmLHdHc9ZD2gMAw==
X-Received: by 2002:a5d:6485:0:b0:38a:41b6:d685 with SMTP id
 ffacd0b85a97d-38dc8dc2fbemr50522f8f.3.1738866437485; 
 Thu, 06 Feb 2025 10:27:17 -0800 (PST)
Received: from [192.168.1.84] ([93.56.163.127])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4390daf3c70sm62509995e9.26.2025.02.06.10.27.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2025 10:27:16 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: alistair.francis@wdc.com
Subject: [PATCH 02/22] target/riscv: introduce RISCVCPUDef
Date: Thu,  6 Feb 2025 19:26:50 +0100
Message-ID: <20250206182711.2420505-3-pbonzini@redhat.com>
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

Start putting all the CPU definitions in a struct.  Later this will replace
instance_init functions with declarative code, for now just remove the
ugly cast of class_data.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/riscv/cpu.h |  4 ++++
 target/riscv/cpu.c | 26 +++++++++++++++++---------
 2 files changed, 21 insertions(+), 9 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 97713681cbe..b2c9302634d 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -517,6 +517,10 @@ struct ArchCPU {
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
index ed9da692030..29cfae38b75 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -2955,7 +2955,7 @@ static void riscv_cpu_class_init(ObjectClass *c, void *data)
 {
     RISCVCPUClass *mcc = RISCV_CPU_CLASS(c);
 
-    mcc->misa_mxl_max = (uint32_t)(uintptr_t)data;
+    mcc->misa_mxl_max = ((RISCVCPUDef *)data)->misa_mxl_max;
     riscv_cpu_validate_misa_mxl(mcc);
 }
 
@@ -3051,40 +3051,48 @@ void riscv_isa_write_fdt(RISCVCPU *cpu, void *fdt, char *nodename)
 }
 #endif
 
-#define DEFINE_DYNAMIC_CPU(type_name, misa_mxl_max, initfn) \
+#define DEFINE_DYNAMIC_CPU(type_name, misa_mxl_max_, initfn) \
     {                                                       \
         .name = (type_name),                                \
         .parent = TYPE_RISCV_DYNAMIC_CPU,                   \
         .instance_init = (initfn),                          \
         .class_init = riscv_cpu_class_init,                 \
-        .class_data = (void *)(misa_mxl_max)                \
+        .class_data = &((RISCVCPUDef) {                     \
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
-        .class_data = (void *)(misa_mxl_max)                \
+        .class_data = &((RISCVCPUDef) {                     \
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
-        .class_data = (void *)(misa_mxl_max)                \
+        .class_data = &((RISCVCPUDef) {                     \
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
-        .class_data = (void *)(misa_mxl_max)                \
+        .class_data = &((RISCVCPUDef) {                     \
+             .misa_mxl_max = (misa_mxl_max_),               \
+        }),                                                 \
     }
 
 static const TypeInfo riscv_cpu_type_infos[] = {
-- 
2.48.1


