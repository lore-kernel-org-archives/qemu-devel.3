Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86B24C02194
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 18:28:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg6bV-0001nr-Cn; Thu, 06 Feb 2025 13:27:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tg6bT-0001j4-PP
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 13:27:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tg6bS-0001H7-AI
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 13:27:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738866473;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c2S1as4YXy95cFcQ6YBPnTB/vNXzAgi97rZfPSkkbmU=;
 b=FR/60JKmtShRBbZU6yks7PgQg4m8R+SNoCIiMpS97VggqG5Q8LpKxU1BmC5J0TrumOzmAf
 T8r65CPGpu6MJ3bYbIWCitmiCv2iDWWXz0jTpYX4Lq2G/lWbogCmgp5BHkc5XUvAWcIGiu
 gOU76I7MXE6YBIbGNRiu4TTFuOIG9Hk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-150-Xa31aoSKMf28X9Z5I2drag-1; Thu, 06 Feb 2025 13:27:52 -0500
X-MC-Unique: Xa31aoSKMf28X9Z5I2drag-1
X-Mimecast-MFC-AGG-ID: Xa31aoSKMf28X9Z5I2drag
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-38db560edc3so597134f8f.3
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 10:27:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738866470; x=1739471270;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c2S1as4YXy95cFcQ6YBPnTB/vNXzAgi97rZfPSkkbmU=;
 b=qIjQ7cyxUKoXp0bOmLXEpLbMpLx2J392p+T3QF7V+53gcxwv4sdtNURoFNYM2qo1LU
 xksFaeWBqXg0Mu9AUNsIN8xhwy7bLsabKQeIq5j7ew8ZKXnnJ24+s7PJn/pDc2Pc0xT2
 zLp7EGuzB0gaYBK2FjyD02xnCULx42VGT9o6ZA+1FMjk9/cEnkKCPLnjh/Ab+NYG68J3
 rWavU8aRjKKpJk2q+tbzJTyzWIg6OEoI9tnlhK27N1hXY0eMECR6GmOdtYCmMc+YlziQ
 6F4CWJSSJqxz6VrGJZgPNVjELzQcd/N2Z0qMMGyun/7wOZ1Re7rR2qli2V1eyHv2Vmph
 iHRQ==
X-Gm-Message-State: AOJu0Yxu5baGJX4LvYi+fCSBzDlIz1EVto0hzmsVrdT9w0g7+Udp2ni9
 Sz0ChzX8fM4gbQ1KskbGCvcn14L2xd+7p4C7WC0dmh02mGouf4TGel7dufpInFZs8HCDAhso/QX
 UeF6I9IjVmNxAFzbbLaV5u+nSTqzqZzpeVWZlAmfxGGMz9+7YO4bZzxh96ylo7GeGlFOD3rRlQ5
 rcU5jHmYPeN7OQk6OWopk6KoYa5QQC2aodEyJFzUw=
X-Gm-Gg: ASbGnctH62YBI4RszkrILSkyynsLGsWpO3hupdzZpiB0FLrJFAIQmcyfW9FRTTuceGg
 ozRh5OekctOAzqcNZOtDM6IyERD2GhhtAXDfiiUz6Epb5aw4W5c51+w88Y32imKRvn0gdOQ0zCq
 pAIzQv82KwWgNC/BZAzAaj67mXZCgp+9EuUlMpUxNmP1TAQY4ut4RYSUep+7M85MrmrIeEt4a8K
 eIsvEUscAS7YCHV9inW0sSrhV5MjZAWfDeKqieoEORKmr+13QUGz54BQTpLpJI9eBAq7opMLBYM
 RnwRwzQ=
X-Received: by 2002:a5d:47af:0:b0:38b:ed7b:f77d with SMTP id
 ffacd0b85a97d-38dc937c3b9mr11946f8f.52.1738866470637; 
 Thu, 06 Feb 2025 10:27:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEsjsJTh/Iz9hNgXFuEgV4OZ4I2YwkRxO3Jlome3/VDG5bv/JzkTp715EB8pMFvYX/D80hUFA==
X-Received: by 2002:a5d:47af:0:b0:38b:ed7b:f77d with SMTP id
 ffacd0b85a97d-38dc937c3b9mr11927f8f.52.1738866470176; 
 Thu, 06 Feb 2025 10:27:50 -0800 (PST)
Received: from [192.168.1.84] ([93.56.163.127])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dbdd1bde0sm2354889f8f.9.2025.02.06.10.27.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2025 10:27:49 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: alistair.francis@wdc.com
Subject: [PATCH 17/22] target/riscv: convert TT C906 to RISCVCPUDef
Date: Thu,  6 Feb 2025 19:27:05 +0100
Message-ID: <20250206182711.2420505-18-pbonzini@redhat.com>
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/riscv/cpu.c | 61 +++++++++++++++++++++-------------------------
 1 file changed, 28 insertions(+), 33 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 6c898cef625..b0bc5e4503f 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -485,38 +485,6 @@ static void riscv_register_custom_csrs(RISCVCPU *cpu, RISCVCSR *csr_list)
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
@@ -3099,7 +3067,34 @@ static const TypeInfo riscv_cpu_type_infos[] = {
         .misa_mxl_max = MXL_RV64
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
+        .satp_mode64 = VM_1_10_SV39,
+#ifndef CONFIG_USER_ONLY
+        .custom_csrs = th_csr_list,
+#endif
+    ),
+
     DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_TT_ASCALON, MXL_RV64,  rv64_tt_ascalon_cpu_init),
     DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_VEYRON_V1,  MXL_RV64,  rv64_veyron_v1_cpu_init),
     DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_XIANGSHAN_NANHU,
-- 
2.48.1


