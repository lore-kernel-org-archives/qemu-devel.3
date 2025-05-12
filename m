Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BCADC3ABC3
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 10:00:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEPri-0000Fp-2B; Mon, 12 May 2025 05:54:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uEPrN-0007su-4U
 for qemu-devel@nongnu.org; Mon, 12 May 2025 05:54:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uEPrK-0000k5-Rw
 for qemu-devel@nongnu.org; Mon, 12 May 2025 05:54:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747043646;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zhymbRVB3Q0GrIq4WSaCe8vcQBs/Nkuk4gkret9oojU=;
 b=AUmVd4g8ovK0yW/CcR9otZzeWHaleoD106MitELycoHPZFI4KESvD0a4C0cpcP4mrzjjaA
 UudhR6+VTLZrw05RaGpAFUPVMWCimjq3PVWgZJ0vt94GulxLcU6+PsBKGntmzNC2bHUGrW
 ZSeQQAMcpIW88eUp7ViHYeSPOMtNOYg=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-246-qckKMpVQOdismdC80z_AdQ-1; Mon, 12 May 2025 05:54:05 -0400
X-MC-Unique: qckKMpVQOdismdC80z_AdQ-1
X-Mimecast-MFC-AGG-ID: qckKMpVQOdismdC80z_AdQ_1747043644
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-acb98b5b0bdso441467766b.1
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 02:54:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747043643; x=1747648443;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zhymbRVB3Q0GrIq4WSaCe8vcQBs/Nkuk4gkret9oojU=;
 b=OnxsHGP5w5csA4VGTERV+HlnP7a7i1HjBPc4IXRS8aHgSRZ8xPEgSlm7zR5+aHJiVQ
 Iy5TVKa/y3rV6hIIFZHZJOIdRa1iVEx3rSlRtrUvoU7c25mSXBVwbD4yAn+nRZrONkC2
 7AdMkpWz+s22F16xvu3BL6WyDnuj6ALso8AB9abicAXXEYr18YgQsp2wyVvkntcIqgHV
 vmjKsH27DoPzmMQ0hyt4xl878jBlAiwmb8tjZN8bH1Aaf9IzYAWpdM9g1WiASQf667Xo
 9uo7FxGGqp8COZETjCrRU7WXRn3oUIjPORJsoVOwszmVV/jGXqImbxtHLwwRmCmTxgg8
 h92A==
X-Gm-Message-State: AOJu0YzekoqjIuwmVyxuZ8pZIZ6mURGNcPTCRzuJTqlaisJFqD28ZPdq
 fIcsX69e3s2FXHQFlJkizlGzsqpo4K9XuELJMFRHlaYmLhHP7VjyVOQVNXDwrjgzcFobjngXq84
 3DG6AnsTuwKljLq0C5U8FQvqWAtrLmyWU+Egu1q2xIYx6x5tLGQJSFrkpcaRKhLhSH0YvfuqWC/
 g3Ibp4MN/4IVz3e+tn3u51amhjVJLe7MqeW5Nz
X-Gm-Gg: ASbGnctXKSgpu3iBqMncwXUGU7qu9hEiUmIgTWg97fs8g6mAXz5++L5NcAS6UvBRQk8
 KPITn49OfzABNZgTRbDpxDE3qK1PLwIoJghfra7kY0uFwMyL8iD6EpoAJrrKTJFvTyeUOtNjq37
 PJ/DHGrbM19FGXnVCpSiMDIdLg8EvTfSEid34VkKrQupj5j8WslXxoSL7TOjmFvfX0v9dq5T6ON
 uSnXW+akxU3fsA5pca2cUcWgzC/WMBZ1VDbobLaRaAepdxu4uQJ/uKcBB3NGprz8Y9HFoDJvV1b
 8MBAeAcFL1Cr65klPr1z5lmZwCZwWejbvC/RMy9yK+szLoo=
X-Received: by 2002:a17:907:c316:b0:ad2:e683:a773 with SMTP id
 a640c23a62f3a-ad2e683b1bcmr175822466b.55.1747043642955; 
 Mon, 12 May 2025 02:54:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFNDbZfkcvcMoHdoumjx0sMhU9P0WdL9brtyVzmcScBfo6626rqqqlSjiJsqBZvleDABGEUZQ==
X-Received: by 2002:a17:907:c316:b0:ad2:e683:a773 with SMTP id
 a640c23a62f3a-ad2e683b1bcmr175820766b.55.1747043642464; 
 Mon, 12 May 2025 02:54:02 -0700 (PDT)
Received: from [192.168.122.1] (93-40-56-213.ip37.fastwebnet.it.
 [93.40.56.213]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad220ff9389sm541554166b.89.2025.05.12.02.54.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 May 2025 02:54:01 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: dbarboza@ventanamicro.com, alistair23@gmail.com,
 richard.henderson@linaro.org
Subject: [PATCH 17/26] target/riscv: convert ibex CPU models to RISCVCPUDef
Date: Mon, 12 May 2025 11:52:17 +0200
Message-ID: <20250512095226.93621-18-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250512095226.93621-1-pbonzini@redhat.com>
References: <20250512095226.93621-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/riscv/cpu.c | 39 ++++++++++++++++-----------------------
 1 file changed, 16 insertions(+), 23 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index aea5d7d197e..661b2384d82 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -690,28 +690,6 @@ static void rv32_sifive_u_cpu_init(Object *obj)
     cpu->cfg.mmu = true;
     cpu->cfg.pmp = true;
 }
-
-static void rv32_ibex_cpu_init(Object *obj)
-{
-    CPURISCVState *env = &RISCV_CPU(obj)->env;
-    RISCVCPU *cpu = RISCV_CPU(obj);
-
-    riscv_cpu_set_misa_ext(env, RVI | RVM | RVC | RVU);
-    env->priv_ver = PRIV_VERSION_1_12_0;
-#ifndef CONFIG_USER_ONLY
-    set_satp_mode_max_supported(cpu, VM_1_10_MBARE);
-#endif
-    /* inherited from parent obj via riscv_cpu_init() */
-    cpu->cfg.ext_zifencei = true;
-    cpu->cfg.ext_zicsr = true;
-    cpu->cfg.pmp = true;
-    cpu->cfg.ext_smepmp = true;
-
-    cpu->cfg.ext_zba = true;
-    cpu->cfg.ext_zbb = true;
-    cpu->cfg.ext_zbc = true;
-    cpu->cfg.ext_zbs = true;
-}
 #endif
 
 static ObjectClass *riscv_cpu_class_by_name(const char *cpu_model)
@@ -3169,7 +3147,22 @@ static const TypeInfo riscv_cpu_type_infos[] = {
         .misa_mxl_max = MXL_RV32,
     ),
 
-    DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_IBEX,       MXL_RV32,  rv32_ibex_cpu_init),
+    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_IBEX, TYPE_RISCV_VENDOR_CPU,
+        .misa_mxl_max = MXL_RV32,
+        .misa_ext = RVI | RVM | RVC | RVU,
+        .priv_spec = PRIV_VERSION_1_12_0,
+        .cfg.max_satp_mode = VM_1_10_MBARE,
+        .cfg.ext_zifencei = true,
+        .cfg.ext_zicsr = true,
+        .cfg.pmp = true,
+        .cfg.ext_smepmp = true,
+
+        .cfg.ext_zba = true,
+        .cfg.ext_zbb = true,
+        .cfg.ext_zbc = true,
+        .cfg.ext_zbs = true
+    ),
+
     DEFINE_RISCV_CPU(TYPE_RISCV_CPU_SIFIVE_E31, TYPE_RISCV_CPU_SIFIVE_E,
         .misa_mxl_max = MXL_RV32
     ),
-- 
2.49.0


