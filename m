Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 831C8C36005
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 07:42:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9J1V-0006IF-1Z; Mon, 28 Apr 2025 03:35:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u9J1C-0005rm-I9
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 03:35:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u9J1A-00019V-TG
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 03:35:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745825706;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tf6Wtd7Zeg686LjseDJ7I7VG+SHXJ9oiE4YrRyhx9/Y=;
 b=VptWn7Wx586UQQlxxRB9diS0PcFDF+q+9qnhSEnf3pH0gI+i4vXciUsH2zCJLdk0q9Faj6
 R8y9RvG7pYvhEeEYGocxcdFcQdvmK8Yxa8qptfOSTfvu8jMmgWOlMsmn5ZYV/DsDJg72jI
 VimEsxf0+WEvQG0Nuk/05n5xJx62r2I=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-427-wBeNztlGMrW2rW3vLid-KQ-1; Mon, 28 Apr 2025 03:35:04 -0400
X-MC-Unique: wBeNztlGMrW2rW3vLid-KQ-1
X-Mimecast-MFC-AGG-ID: wBeNztlGMrW2rW3vLid-KQ_1745825703
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-39c1b1c0969so2714317f8f.1
 for <qemu-devel@nongnu.org>; Mon, 28 Apr 2025 00:35:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745825702; x=1746430502;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tf6Wtd7Zeg686LjseDJ7I7VG+SHXJ9oiE4YrRyhx9/Y=;
 b=Pa+HOx/9UK7QYXB1vqinN2wP2lDv+nAfjDhqNRaCWS0XfLZJvTD9VhfwWm41QvWg3o
 746JbaTX3QwL5nueJ2S2/RFncky3fJZJIM5laBhlxOfGV1avKNjEQv19+HhwaPezbDqt
 5Wj+xF3EdVdALYMA6R8mQk+H0OHvVYaOP1f0cwito8ZPpzpSe8EL2lZX6su7s6A68cHn
 pHKxaSxuX51HZQ499BN8vSSYiLh8OMiPn4Cmt79LKaAnB/DRTxWSFbFtgZbIYD7NEQkq
 R9sefrqFH81lyAkLjs5wMxSgnIrBUOklQMn93xLGjmr9nukOQVaN8khYnvl5TAMPweeP
 KxWw==
X-Gm-Message-State: AOJu0YzriIEqaBPDfj8dTT+p0W5A2ctDgBqiZ5i1VNefSTWm/FSng1WL
 WSLos2I5bbsFFugR6ekUqlXFPcwRx5K0mQhrspHgyZLK/SX5VtkDsKb+xjCPwXs/34kJjvYbpS5
 /6uhTeF7luJfEGTOJmhAoiOBUUcweXCey90REUuRjbgiU+ouKGKRILNw6uEg2SOM5V7rWHde6og
 FrcFK0Nzm9iW4Tn5JMoOtoG1vBzeJjoaJljRpC
X-Gm-Gg: ASbGnct9bZCX/Kg2gtm8CkgMxBEKCkdSfef+X658qxGVjdWoZy6Uu9qQF1ba+U8ERK6
 toDpyFC/MbxPMkML+QmzxJOPf1eqWF+7ZL0kArCyuiOzEOlG+Fz4DEsWsAWgPjEAFyta17+3H2g
 IQWcNIvFfnO5dYVoox4NJgTBdbP1i1Z0+zQznRXwm2dlfB/lotEux4inKiGbA20OTf2e5rZxzS8
 aHOjt5NE+Qr6YXqu90TNPelVgSydAzqnUfgoiCJtKXgtEC/pbSKeUinPKcobkSeYzp/j9FNuhz8
 rn4IagLnJC+aZ1M=
X-Received: by 2002:a05:6000:2905:b0:390:e7c1:59c4 with SMTP id
 ffacd0b85a97d-3a07aa690bamr5589045f8f.13.1745825702586; 
 Mon, 28 Apr 2025 00:35:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHoZYpKyKXQO3ty2aokjOl7KorbPq4HOTB0XCyztA4KbJ3SdqYEe7/rZvcEi3+Qk6VkATTIqA==
X-Received: by 2002:a05:6000:2905:b0:390:e7c1:59c4 with SMTP id
 ffacd0b85a97d-3a07aa690bamr5589005f8f.13.1745825702027; 
 Mon, 28 Apr 2025 00:35:02 -0700 (PDT)
Received: from [192.168.122.1] ([151.95.54.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073cbedb9sm10138452f8f.44.2025.04.28.00.34.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Apr 2025 00:35:00 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: alistair.francis@wdc.com,
	dbarboza@ventanamicro.com
Subject: [PATCH 07/26] target/riscv: introduce RISCVCPUDef
Date: Mon, 28 Apr 2025 09:34:22 +0200
Message-ID: <20250428073442.315770-8-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250428073442.315770-1-pbonzini@redhat.com>
References: <20250428073442.315770-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.492,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/riscv/cpu.h |  4 ++++
 target/riscv/cpu.c | 27 ++++++++++++++++++---------
 2 files changed, 22 insertions(+), 9 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 97dc3ba7811..62e303f0635 100644
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
index ab6ee39d304..f30cf1b532b 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -3074,8 +3074,9 @@ static void riscv_cpu_common_class_init(ObjectClass *c, const void *data)
 static void riscv_cpu_class_init(ObjectClass *c, const void *data)
 {
     RISCVCPUClass *mcc = RISCV_CPU_CLASS(c);
+    const RISCVCPUDef *def = data;
 
-    mcc->misa_mxl_max = (RISCVMXL)GPOINTER_TO_UINT(data);
+    mcc->misa_mxl_max = def->misa_mxl_max;
     riscv_cpu_validate_misa_mxl(mcc);
 }
 
@@ -3171,40 +3172,48 @@ void riscv_isa_write_fdt(RISCVCPU *cpu, void *fdt, char *nodename)
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
+        .class_data = &((const RISCVCPUDef) {               \
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
+        .class_data = &((const RISCVCPUDef) {               \
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
+        .class_data = &((const RISCVCPUDef) {               \
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
+        .class_data = &((const RISCVCPUDef) {               \
+             .misa_mxl_max = (misa_mxl_max_),               \
+        }),                                                 \
     }
 
 static const TypeInfo riscv_cpu_type_infos[] = {
-- 
2.49.0


