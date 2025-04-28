Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C5C0C369D3
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 07:39:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9J1i-0006PJ-1Q; Mon, 28 Apr 2025 03:35:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u9J1e-0006Na-Na
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 03:35:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u9J1c-0001FL-JB
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 03:35:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745825735;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xsM+Trm12xaZVTGaFahBHpS4KkxyAPLPX60F1XPSWYo=;
 b=hbSfIjt2BCRxAQXIlNGbSws7VamQ4tmXQHSwT+FB1pJghDp+7BKUn6y367aB3LPJceQKES
 zOtfl27hrn4VxRi2oJbGVkKMJB5aINQYavYFBaQA9ntaYbXe5W77xP5Rp/5DSv3o219XY/
 xas6CgRcsvZvSWEQBvmG8NspSvQdfBM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-673-dxCzNH3kObeFf3HOgGBRDQ-1; Mon, 28 Apr 2025 03:35:32 -0400
X-MC-Unique: dxCzNH3kObeFf3HOgGBRDQ-1
X-Mimecast-MFC-AGG-ID: dxCzNH3kObeFf3HOgGBRDQ_1745825731
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3912b54611dso2228731f8f.1
 for <qemu-devel@nongnu.org>; Mon, 28 Apr 2025 00:35:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745825730; x=1746430530;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xsM+Trm12xaZVTGaFahBHpS4KkxyAPLPX60F1XPSWYo=;
 b=gXwd3sxKm4paAcRH8pCdLCjyFnuBTanJSAQpCZx3L9+b6jmu896X2cua4e68DqxMGQ
 JGFthXW23pa5b9xoo9IMcxrUPD0XjwwyFUgAmt7SeO7ll2T84QeiN1mopp5KldfYtdfB
 P73RipRh5HaNRRFYV3XVznTsTwxjhnCvshWEGWe8a3QPS0hSb636xYH8G0++/DuN4IrR
 JsrW76MQSk321acBBOQZDa4p7Jbr+wSSKG7xCorAP/e/V20vbUL0dreWNxQqyz6hZwBJ
 pp2q6pJF/IHjp6aQQCuGpc0Wt75RTfaAaIidMo1zaTAndrj2sNLarHVdhwpCMTyLmvdY
 1CaQ==
X-Gm-Message-State: AOJu0Yydcl0xZa0IhaZiQfrPj7TJdKeguhJansH4oTxLr8hFhH1eXYsr
 TFcXtBWSESLK/LTnCXnxJCn5ZbbixR1iNtEo2VRGatZ1mrBo95CaLHr9Z8UG6OGQP7EBg/IIgIp
 WfK9XEBHrXDgU4y6Bqdry6/rb9uQVCZu8FR9AHQglnWtkT7h9CZITrOK56ESIFVx99DGY5IKM5c
 Vxqp642hUXk3qb+ogistl+jIEicWp5iAkk+YDy
X-Gm-Gg: ASbGnctbRNgGliuF/S77H7NahnkbWRiqhpQBfm1Zxd9xbKAErh8xaPwMWBDcYCpiGqV
 DRfDAqjXTXnjZZh2QIdVTHphN2a03OIBGs4dK3qfdJ3+/6TLERKX7Zn3E9bYL9srp8NOAR4euF5
 w6edZqC+jlwKdE7+cnlA4DVzDMhohlcFlUVAPHI4uafmm9hERFvpXEbc6zfzckks0t5Ih07FWu8
 cmURJXFDSKlELp5oUgjqcnD0/t2+9DSCdxDaUgdQ+Bta7utxf/fwMRkjA/eOkoMEU0OwaTA/+sl
 v/QknV5OVXhRcqI=
X-Received: by 2002:a05:6000:1868:b0:39e:e438:8e4b with SMTP id
 ffacd0b85a97d-3a074f792b4mr8154601f8f.50.1745825730499; 
 Mon, 28 Apr 2025 00:35:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFx38+L21r/+GEBmBnJ5X2/aCYEYBoqtF1ct4+8YCieECdi6MZwi9PizceCv0NS3k+90frSNg==
X-Received: by 2002:a05:6000:1868:b0:39e:e438:8e4b with SMTP id
 ffacd0b85a97d-3a074f792b4mr8154573f8f.50.1745825730145; 
 Mon, 28 Apr 2025 00:35:30 -0700 (PDT)
Received: from [192.168.122.1] ([151.95.54.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073ca4f88sm10039766f8f.29.2025.04.28.00.35.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Apr 2025 00:35:29 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: alistair.francis@wdc.com,
	dbarboza@ventanamicro.com
Subject: [PATCH 18/26] target/riscv: convert ibex CPU models to RISCVCPUDef
Date: Mon, 28 Apr 2025 09:34:33 +0200
Message-ID: <20250428073442.315770-19-pbonzini@redhat.com>
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

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/riscv/cpu.c | 39 ++++++++++++++++-----------------------
 1 file changed, 16 insertions(+), 23 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 5b4ffc285da..4f531711655 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -691,28 +691,6 @@ static void rv32_sifive_u_cpu_init(Object *obj)
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
@@ -3170,7 +3148,22 @@ static const TypeInfo riscv_cpu_type_infos[] = {
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


