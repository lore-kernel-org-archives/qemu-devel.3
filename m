Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 960D2C369D9
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 07:40:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9J2o-00084o-Py; Mon, 28 Apr 2025 03:36:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u9J1q-0006bc-10
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 03:35:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u9J1o-0001H3-Bo
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 03:35:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745825747;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HhmUn9wdp9vjEChMz+hNf0LJg0lhr85WLZA+vnVIVCo=;
 b=I12owuE/5qrvHRcQRtuX/HcGenoHM6BLYgAxKxT2ezJw+sgcggCe4UWh9kMiiPVh1ngeUg
 qRUinbzdm3EbbDu9f2FGsb3LKxETKYIP9H/8XgQfql6hqbxkeTi7HzVk+CSxy10PQATSW5
 Gkm2RhGRrwWIX+zs5AsuwoEQhDAyHR0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-quuiq-HzP-CzKLTe2e-sYg-1; Mon, 28 Apr 2025 03:35:45 -0400
X-MC-Unique: quuiq-HzP-CzKLTe2e-sYg-1
X-Mimecast-MFC-AGG-ID: quuiq-HzP-CzKLTe2e-sYg_1745825744
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43f251dc364so23551575e9.2
 for <qemu-devel@nongnu.org>; Mon, 28 Apr 2025 00:35:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745825744; x=1746430544;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HhmUn9wdp9vjEChMz+hNf0LJg0lhr85WLZA+vnVIVCo=;
 b=NsJFd6+IVaf+Z4LDVALK7gVlMdfNbBK0LYYUNh0NgVfg66P9pXVreh//SmhE9ohTf5
 pUh4JTajRvhvqxa+30OWAYAShO/5gXJbIxHpUIxZFLoAtzvImOoX/EUuMsmY2qfFCRGO
 uTI1t5+L+FkbW0dzUz02dEyaGO2ajr7GcgJhQ7EUwnKCsKsG2kSZxdNU1P6Qi6X+uFXM
 qbPfMxoEQV6m9C+p2ulhmbng0lcySCK8t3twn5BKP7EX9XR7VTSkYsMz839Qnjx1At3Q
 W3jHvXUQaEuJP8sqxoSCPjSA/w1UWRepk13WbgE9uhDhaqLyiEYGldjcJ1xXkA2aBLcb
 pj0Q==
X-Gm-Message-State: AOJu0YxOuyosUFkWgV4VYtPJbuJwnTc5RUpp0PeWihWGrprk5Y4syl7c
 gpz5c2l8FRJAvWzE1BBUe1rM9KdTXDC0wm0rFTewwL6nldvIYwR8TecwHZ2vZkgPWzGNUlSamHL
 mJBMOsqCIPe6UT1ujDf3pfiq1nClzZOOOvjMdQ+dTD7uNA6xChBoHAFklnUuEwHRa8TZhwein9B
 tgrYSvREO1vHS+5dX0+BMb8dKZZRvajQPMKgXh
X-Gm-Gg: ASbGncv7mrtbUzonFcOhdGPSuCcv61Jayc5eZ8482R1L9ZqsxjBOd5wFNPyoTvBSkxB
 kMD/LnHlf+fombaiDQQFuzgZkVPeJ8N7SbVeAyKqWyCUu5xBKCwB8/sdLrWsQcRqZG0jlTcqTL7
 pI9jgpBK2tZ4NH+g5BgWQlvT084I/wL7mnxLOQD/Dq9QtCn0bpmsB/z8CJO8YGBdedel9cuHwIU
 GnzJvoOlYY8Z5kOulFF4gDHAA1/LMfcWj3uM+gN0GVNz2Sm3FkEcwcELjL6rBYpKakMz3ptHlwM
 UQ6mZCNNWGMWZ14=
X-Received: by 2002:a05:600c:34ca:b0:43e:a7c9:8d2b with SMTP id
 5b1f17b1804b1-440a66aaf1bmr84849005e9.24.1745825743785; 
 Mon, 28 Apr 2025 00:35:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEP8WblTwwTZbG1Miq+fD+3ircDLvms5Xj+7/Oy8ykj+yt//6iHA+re8BkYzwsCophV7N2mlQ==
X-Received: by 2002:a05:600c:34ca:b0:43e:a7c9:8d2b with SMTP id
 5b1f17b1804b1-440a66aaf1bmr84848705e9.24.1745825743316; 
 Mon, 28 Apr 2025 00:35:43 -0700 (PDT)
Received: from [192.168.122.1] ([151.95.54.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4409d29ba34sm152102445e9.5.2025.04.28.00.35.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Apr 2025 00:35:42 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: alistair.francis@wdc.com,
	dbarboza@ventanamicro.com
Subject: [PATCH 24/26] target/riscv: convert Ventana V1 to RISCVCPUDef
Date: Mon, 28 Apr 2025 09:34:39 +0200
Message-ID: <20250428073442.315770-25-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250428073442.315770-1-pbonzini@redhat.com>
References: <20250428073442.315770-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
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
 target/riscv/cpu.c | 75 ++++++++++++++++++++++------------------------
 1 file changed, 35 insertions(+), 40 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 20a68ba43c4..6cdb92c8a4c 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -500,45 +500,6 @@ static void riscv_register_custom_csrs(RISCVCPU *cpu, const RISCVCSR *csr_list)
 #endif
 
 #if defined(TARGET_RISCV64)
-static void rv64_veyron_v1_cpu_init(Object *obj)
-{
-    CPURISCVState *env = &RISCV_CPU(obj)->env;
-    RISCVCPU *cpu = RISCV_CPU(obj);
-
-    riscv_cpu_set_misa_ext(env, RVG | RVC | RVS | RVU | RVH);
-    env->priv_ver = PRIV_VERSION_1_12_0;
-
-    /* Enable ISA extensions */
-    cpu->cfg.mmu = true;
-    cpu->cfg.ext_zifencei = true;
-    cpu->cfg.ext_zicsr = true;
-    cpu->cfg.pmp = true;
-    cpu->cfg.ext_zicbom = true;
-    cpu->cfg.cbom_blocksize = 64;
-    cpu->cfg.cboz_blocksize = 64;
-    cpu->cfg.ext_zicboz = true;
-    cpu->cfg.ext_smaia = true;
-    cpu->cfg.ext_ssaia = true;
-    cpu->cfg.ext_sscofpmf = true;
-    cpu->cfg.ext_sstc = true;
-    cpu->cfg.ext_svinval = true;
-    cpu->cfg.ext_svnapot = true;
-    cpu->cfg.ext_svpbmt = true;
-    cpu->cfg.ext_smstateen = true;
-    cpu->cfg.ext_zba = true;
-    cpu->cfg.ext_zbb = true;
-    cpu->cfg.ext_zbc = true;
-    cpu->cfg.ext_zbs = true;
-    cpu->cfg.ext_XVentanaCondOps = true;
-
-    cpu->cfg.mvendorid = VEYRON_V1_MVENDORID;
-    cpu->cfg.marchid = VEYRON_V1_MARCHID;
-    cpu->cfg.mimpid = VEYRON_V1_MIMPID;
-
-#ifndef CONFIG_USER_ONLY
-    set_satp_mode_max_supported(cpu, VM_1_10_SV48);
-#endif
-}
 
 static void rv64_xiangshan_nanhu_cpu_init(Object *obj)
 {
@@ -3208,7 +3169,41 @@ static const TypeInfo riscv_cpu_type_infos[] = {
         .cfg.max_satp_mode = VM_1_10_SV57,
     ),
 
-    DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_VEYRON_V1,  MXL_RV64,  rv64_veyron_v1_cpu_init),
+    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_VEYRON_V1, TYPE_RISCV_VENDOR_CPU,
+        .misa_mxl_max = MXL_RV64,
+        .misa_ext = RVG | RVC | RVS | RVU | RVH,
+        .priv_spec = PRIV_VERSION_1_12_0,
+
+        /* ISA extensions */
+        .cfg.mmu = true,
+        .cfg.ext_zifencei = true,
+        .cfg.ext_zicsr = true,
+        .cfg.pmp = true,
+        .cfg.ext_zicbom = true,
+        .cfg.cbom_blocksize = 64,
+        .cfg.cboz_blocksize = 64,
+        .cfg.ext_zicboz = true,
+        .cfg.ext_smaia = true,
+        .cfg.ext_ssaia = true,
+        .cfg.ext_sscofpmf = true,
+        .cfg.ext_sstc = true,
+        .cfg.ext_svinval = true,
+        .cfg.ext_svnapot = true,
+        .cfg.ext_svpbmt = true,
+        .cfg.ext_smstateen = true,
+        .cfg.ext_zba = true,
+        .cfg.ext_zbb = true,
+        .cfg.ext_zbc = true,
+        .cfg.ext_zbs = true,
+        .cfg.ext_XVentanaCondOps = true,
+
+        .cfg.mvendorid = VEYRON_V1_MVENDORID,
+        .cfg.marchid = VEYRON_V1_MARCHID,
+        .cfg.mimpid = VEYRON_V1_MIMPID,
+
+        .cfg.max_satp_mode = VM_1_10_SV48,
+    ),
+
     DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_XIANGSHAN_NANHU,
                                                  MXL_RV64, rv64_xiangshan_nanhu_cpu_init),
 #if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
-- 
2.49.0


