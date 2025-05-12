Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68E77C3ABCD
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 09:58:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEPrr-0000u0-SI; Mon, 12 May 2025 05:54:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uEPrp-0000i9-D4
 for qemu-devel@nongnu.org; Mon, 12 May 2025 05:54:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uEPrn-0000mF-N8
 for qemu-devel@nongnu.org; Mon, 12 May 2025 05:54:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747043674;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RqplIrCb5EnJ9kAZLfanr+2YlBchWhH8n9WVaqojsA8=;
 b=PHjAY5yEiGLH5VdChdiyw8gh6c2m3LMzuMvnEMXR5UL3qMQgkl8Lnd+Inz/s6Cxy4dpgyr
 iHW5uJ6DroZlQD53HMI69NZ7XYrVBik9xzOJwSikjVE3YNM8ZFyUWQOm2+BK9rykNY4nu/
 4369cQPfDhtMwo4Bz+z7/Dr23wlJc+c=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-468-h6WkjanWPkKY1QFP0c94sA-1; Mon, 12 May 2025 05:54:32 -0400
X-MC-Unique: h6WkjanWPkKY1QFP0c94sA-1
X-Mimecast-MFC-AGG-ID: h6WkjanWPkKY1QFP0c94sA_1747043671
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-5fc8fca20f4so3234007a12.1
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 02:54:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747043671; x=1747648471;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RqplIrCb5EnJ9kAZLfanr+2YlBchWhH8n9WVaqojsA8=;
 b=JHfO+Umey6Bab+fb/0Sa0vM8vKzQi/Il2hpyScoNdtadMmj5aBs2AJSZMza/h7DQFZ
 V/6fTsm+4irsMcAJzi2LJg8ky+dBP181zEWbNOxW9/W+h6j7mdQi+4MVKnlk4NfNzPX+
 cYkzjTK1Gssv5cP2HGKE45z7kYg8hY1EsOArZy99ddvlrW49NIsYqgpaO2CVv+VBayC1
 fx8qvVzZn4USytJ4akfuiiONexeqdQT+Uhy+ypAUvNT1hvus0Ux9x1AvfY5t7ygYgwG8
 jtc/qbzYgJH4DKuQxUWVrdd3UidGZO69Joo9nGvQc0akll4hMPmOhU35heXHTiyMhPPJ
 CDlw==
X-Gm-Message-State: AOJu0YyPe4MQY3F5c3o3gpWbq7FlOdea9i6ToKrCG5QtoBFJgmZv270x
 VuU2Tupb+VzfJI1CFQXcseS8WgOAk0mlm0tHLnQp3RLEUlofX9/zvmkRqqvqgTvfLZ702PNMI9r
 AMLZO20UJOoKdSqD6MRnxz4vrdKjYhNapMg6IUxcFDTaBZZEuzP2EvdswZvjIOO7z1vtnKyF2yV
 pZXs8Toqb2p/uWt/Py9YeSXdU1J/QRLlTJ+3Pd
X-Gm-Gg: ASbGnct2s3XDQ7a3sIVq+WuFhWTqbnLGsIjt/c1qmUa1I6DPYLFZf2IyBtFyzZ8RLkD
 2GGnvEOpm0SRYMUzijZ6jVNlM5wv2OD+pwLzJbZ6Gnw6iTKBSW4scSnWGK4F2mcJgZXgm+uwybf
 8C434ntZ6PDEf+N02gNkkze8pLELf1iCc0hqEhcj/8cp0MCcbRZMJv609MSb4T/PXO9aYWVDSgr
 GneCRjYpQItOheCm+Vpcfsygcn6hmwDgNF2Hm6hTsMTKgtJyAe9CsNh92WszursJ5SjYs/qfRkm
 +K/bwmg3fIETjmm9LuKuZ/75Akd5Vp5n9CYUj69X5PLuOUc=
X-Received: by 2002:a05:6402:210b:b0:5fd:ef5d:cfc9 with SMTP id
 4fb4d7f45d1cf-5fdef5ddccdmr3135315a12.12.1747043670909; 
 Mon, 12 May 2025 02:54:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFuVqVVmUhSECyQHnkZf2vc6YESx3dBLbQA6KCVURpQr74B8m4g29Zf+Uriy0HQ1CB+WgnFYQ==
X-Received: by 2002:a05:6402:210b:b0:5fd:ef5d:cfc9 with SMTP id
 4fb4d7f45d1cf-5fdef5ddccdmr3135290a12.12.1747043670534; 
 Mon, 12 May 2025 02:54:30 -0700 (PDT)
Received: from [192.168.122.1] (93-40-56-213.ip37.fastwebnet.it.
 [93.40.56.213]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5fc9cc4e6ebsm5452677a12.37.2025.05.12.02.54.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 May 2025 02:54:30 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: dbarboza@ventanamicro.com, alistair23@gmail.com,
 richard.henderson@linaro.org
Subject: [PATCH 21/26] target/riscv: convert TT C906 to RISCVCPUDef
Date: Mon, 12 May 2025 11:52:21 +0200
Message-ID: <20250512095226.93621-22-pbonzini@redhat.com>
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
 target/riscv/cpu.c | 61 +++++++++++++++++++++-------------------------
 1 file changed, 28 insertions(+), 33 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index bc45815383d..dbfd8c7a348 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -499,38 +499,6 @@ static void riscv_register_custom_csrs(RISCVCPU *cpu, const RISCVCSR *csr_list)
 #endif
 
 #if defined(TARGET_RISCV64)
-static void rv64_thead_c906_cpu_init(Object *obj)
-{
-    CPURISCVState *env = &RISCV_CPU(obj)->env;
-    RISCVCPU *cpu = RISCV_CPU(obj);
-
-    riscv_cpu_set_misa_ext(env, RVG | RVC | RVS | RVU);
-    env->priv_ver = PRIV_VERSION_1_11_0;
-
-    cpu->cfg.ext_zfa = true;
-    cpu->cfg.ext_zfh = true;
-    cpu->cfg.mmu = true;
-    cpu->cfg.ext_xtheadba = true;
-    cpu->cfg.ext_xtheadbb = true;
-    cpu->cfg.ext_xtheadbs = true;
-    cpu->cfg.ext_xtheadcmo = true;
-    cpu->cfg.ext_xtheadcondmov = true;
-    cpu->cfg.ext_xtheadfmemidx = true;
-    cpu->cfg.ext_xtheadmac = true;
-    cpu->cfg.ext_xtheadmemidx = true;
-    cpu->cfg.ext_xtheadmempair = true;
-    cpu->cfg.ext_xtheadsync = true;
-
-    cpu->cfg.mvendorid = THEAD_VENDOR_ID;
-#ifndef CONFIG_USER_ONLY
-    set_satp_mode_max_supported(cpu, VM_1_10_SV39);
-    riscv_register_custom_csrs(cpu, th_csr_list);
-#endif
-
-    /* inherited from parent obj via riscv_cpu_init() */
-    cpu->cfg.pmp = true;
-}
-
 static void rv64_veyron_v1_cpu_init(Object *obj)
 {
     CPURISCVState *env = &RISCV_CPU(obj)->env;
@@ -3217,7 +3185,34 @@ static const TypeInfo riscv_cpu_type_infos[] = {
         .misa_mxl_max = MXL_RV64,
     ),
 
-    DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_THEAD_C906, MXL_RV64,  rv64_thead_c906_cpu_init),
+    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_THEAD_C906, TYPE_RISCV_VENDOR_CPU,
+        .misa_mxl_max = MXL_RV64,
+        .misa_ext = RVG | RVC | RVS | RVU,
+        .priv_spec = PRIV_VERSION_1_11_0,
+
+        .cfg.ext_zfa = true,
+        .cfg.ext_zfh = true,
+        .cfg.mmu = true,
+        .cfg.ext_xtheadba = true,
+        .cfg.ext_xtheadbb = true,
+        .cfg.ext_xtheadbs = true,
+        .cfg.ext_xtheadcmo = true,
+        .cfg.ext_xtheadcondmov = true,
+        .cfg.ext_xtheadfmemidx = true,
+        .cfg.ext_xtheadmac = true,
+        .cfg.ext_xtheadmemidx = true,
+        .cfg.ext_xtheadmempair = true,
+        .cfg.ext_xtheadsync = true,
+        .cfg.pmp = true,
+
+        .cfg.mvendorid = THEAD_VENDOR_ID,
+
+        .cfg.max_satp_mode = VM_1_10_SV39,
+#ifndef CONFIG_USER_ONLY
+        .custom_csrs = th_csr_list,
+#endif
+    ),
+
     DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_TT_ASCALON, MXL_RV64,  rv64_tt_ascalon_cpu_init),
     DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_VEYRON_V1,  MXL_RV64,  rv64_veyron_v1_cpu_init),
     DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_XIANGSHAN_NANHU,
-- 
2.49.0


