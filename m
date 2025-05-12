Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 644F3C3ABC3
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 09:58:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEPsg-0002Em-R2; Mon, 12 May 2025 05:55:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uEPs3-0001cY-Nd
 for qemu-devel@nongnu.org; Mon, 12 May 2025 05:54:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uEPs1-0000n3-48
 for qemu-devel@nongnu.org; Mon, 12 May 2025 05:54:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747043688;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jdaC8CylyRYZPT4hMii7mRMfkhJIDtIRNdk7B/XN+Ec=;
 b=azU9RxkFK5wJMkYLRGdFyDmMemC9yblQKQQDR4eCrwm8D8KCX9mieu2l84lM0/tbmRiqR6
 Ugiq3DQXE3LUJADg5trMK2LpMHlY78Fzr9aGfYtuThsE/kpjPpzMfNchUlBmFj7A1Z0ib/
 frQWOke5Zt4MNUjdZy/0c11Ns2AAcKs=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-671-DJAGUQ0mPf6WH7T8dg0BMg-1; Mon, 12 May 2025 05:54:45 -0400
X-MC-Unique: DJAGUQ0mPf6WH7T8dg0BMg-1
X-Mimecast-MFC-AGG-ID: DJAGUQ0mPf6WH7T8dg0BMg_1747043684
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-ad225698c20so252515566b.3
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 02:54:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747043684; x=1747648484;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jdaC8CylyRYZPT4hMii7mRMfkhJIDtIRNdk7B/XN+Ec=;
 b=r3xtiwaAUwoKvxmKAL4IkXdsbeGM7VVyiDllPnrSoIOlBmgMmSV+vrkAkv7HvvzCka
 5+x872s1sAFZGgV/mm5/PZXmbiQpPbrxun80v2n7v12VekRyXoEdEi28S2aTmxDxv8Eb
 65cUyhr4PaYoVsab6sX/F7baLZZw9tTnE0owxrv9MuSLxWk5JM6g8zYo+hDpeYW9jcIL
 2X2AvC5Tvpyb+rZ658I2xhCZYTK5vT4DRj5a/S/vfxNFL13sb99PiBjz8g/TazHotdYz
 WY3nwJ9J4D0chTNyIsSbsZpDfDYbLurf+cE86kTmIhZpW+2ukXH+JpvIM9f+qogua9xm
 IdVA==
X-Gm-Message-State: AOJu0YzXFwOmeLRRPzkncAFk2ClGN8KWmxNJY077vAow/lDmjiEalXGS
 Uij0lQE8xpfqt++WnH+/xRiGYrwAcBp5UMI19E8pLA63XpfZkNiZKBCC3sy+Qx45e6NRKoRPgrk
 0HeBU/buSlZrBidDMbO+fMynebfx/aN2fg6mQB0AY/y38VsdHgqFH8jugX8YJYp0cYSlSfm2bpT
 uu8zc5nJn9XmjF3UhTtBXpeuvStC6Lj0E/YSKB
X-Gm-Gg: ASbGncsdyEjsqU94M9m/Ep56FuntEocEOBenDaa5Sf0uwieKr7eRhtaPL4dJjZL1VS6
 +yyV0o+BDHPG67jWQcfAYrzSDjMd9cpTSlyrzAa8FQgFnwK/NhJkMBek/5p96pPo1Zh/Ndpm4X6
 YEQPKkOf+rV1nKzp9BcwIYx07ME2XzMiEsfywrT/oNNzxG0y/bW2fLWBECmSYj8FbO49+DPLnBm
 4PbGEuaC4ltB82gXet0YBfXM9Z/SHsFRcc3zt7qXDtZKYebfKoinVf4l3Y5/Olsyu/+mianfBSK
 O6DkWpMe6+9XHBfiGDXZgVbzLTGeEuAFEOP6X0PIX3hNhkg=
X-Received: by 2002:a17:906:750:b0:ad2:2146:3b89 with SMTP id
 a640c23a62f3a-ad2214645f4mr821347866b.47.1747043684078; 
 Mon, 12 May 2025 02:54:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHvNtg/4ti+qx2Kv7i5DJIy0ZCh7nbE3vgqk6Hx9fnYp9yEElSb97Qw7oAiDkcRBhqoKIXm0Q==
X-Received: by 2002:a17:906:750:b0:ad2:2146:3b89 with SMTP id
 a640c23a62f3a-ad2214645f4mr821346066b.47.1747043683637; 
 Mon, 12 May 2025 02:54:43 -0700 (PDT)
Received: from [192.168.122.1] (93-40-56-213.ip37.fastwebnet.it.
 [93.40.56.213]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad2231ac35bsm526198266b.34.2025.05.12.02.54.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 May 2025 02:54:43 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: dbarboza@ventanamicro.com, alistair23@gmail.com,
 richard.henderson@linaro.org
Subject: [PATCH 23/26] target/riscv: convert Ventana V1 to RISCVCPUDef
Date: Mon, 12 May 2025 11:52:23 +0200
Message-ID: <20250512095226.93621-24-pbonzini@redhat.com>
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/riscv/cpu.c | 75 ++++++++++++++++++++++------------------------
 1 file changed, 35 insertions(+), 40 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 18b60428d14..c884e09d869 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -499,45 +499,6 @@ static void riscv_register_custom_csrs(RISCVCPU *cpu, const RISCVCSR *csr_list)
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
@@ -3207,7 +3168,41 @@ static const TypeInfo riscv_cpu_type_infos[] = {
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


