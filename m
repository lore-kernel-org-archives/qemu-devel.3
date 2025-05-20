Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 998AEC3ABDD
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 11:08:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHKoG-0002Al-Sg; Tue, 20 May 2025 07:07:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uHKo5-0001f3-QY
 for qemu-devel@nongnu.org; Tue, 20 May 2025 07:06:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uHKo3-0003Oc-QX
 for qemu-devel@nongnu.org; Tue, 20 May 2025 07:06:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747739206;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VaW1FSaFfqqYrc+cQ7/ayUkgedSrm8KzkTTXYcZWKe0=;
 b=hXfgcmERksT3MFE32I6kd+4k+/0UITluUKBxiDYU+PzR1LbgOSNJoMmw0N9HExYEunChGG
 JP+lOWe1C7aVx37wuQKEJ3CmCknwDprua3GNncIcUkq78/N0OjDAixWz+TdMZhkfteJvmP
 DyhFU0YEJcuY22vP3UujXmr+6aHggsY=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-77g1XSJCMKyHPJNLd3OCCQ-1; Tue, 20 May 2025 07:06:45 -0400
X-MC-Unique: 77g1XSJCMKyHPJNLd3OCCQ-1
X-Mimecast-MFC-AGG-ID: 77g1XSJCMKyHPJNLd3OCCQ_1747739205
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-ad53f8a49fdso293595666b.1
 for <qemu-devel@nongnu.org>; Tue, 20 May 2025 04:06:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747739204; x=1748344004;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VaW1FSaFfqqYrc+cQ7/ayUkgedSrm8KzkTTXYcZWKe0=;
 b=EoLzN8y/2SozjZHMWNi6L9jyaThlF7Qe3yfj77uVsJGG1isroCx+RxC0o0ZOc5TGG6
 03U6q7nF8BUby7UEk2cSOs6tUQDYv8c57TfAosAB8ZU6bOXvMx+rydEEtmge4yegvfDr
 LQ7D7NA+xXAgEMqogE4G94L5gXQg5lxjFVZRgUWm57fzHIL9nLt7z5oYWLWeOqUY9aUm
 vfAUGFxHPq0R3x8VsSYcQkDbMGkIqQt39JHRHH9f3rLtjhQnfFB1Gkav0ALKPi9pSbSu
 IQjh1qvXji8KgBGuZTkOGrLmzpSH+cwYZYXhRUfw9mIRoE8fHSQIPCjW6/51M8kRQWdt
 eIvw==
X-Gm-Message-State: AOJu0YwO7JBj8d6nA2EV0zpFBWpncvJV2QDyYdEcxWyaxVnlATGyVeBk
 ojKyKvdtJhKtPWaPCVk7yv4Q4KmghtP6OwBkxS57A0VPWcZt+Au7ICs/vxNk19cXyBJb1ZYHmJ0
 Eb6gP5YKVh5vA2IqtqlLOzQszLUCW2D+ZzqgFeOFY6yA2FWCPSft506XUdzL0nYeeY++vpykwcI
 UGOl9QJA/1dJyoU9byJArka1CQdYqsI0niJL23Fl8A
X-Gm-Gg: ASbGnctYRt70RhW40thAIMeZcAuS1UOPcHhRC2q7zxATkxdX220MkxXPS2nLooHaLzj
 fzZSw4ZIAolANjYuFDkznvPgNRCiDbVmE4pCrYoh7PlPSBAaok767ftJMiQbcQb4K3WvrRysBeN
 Cbytb66Oa0nrpLuRXpzmZaH6Fn1uTIDt5B1V2ZxfN3Dmd7Au4PV59CkgF1Z5MYmfkF+ZVRxzHd7
 yM0sWh4Vls0WRnnaC82C8W3iTJwW8in2aMDAQSDelX07bauL/jwSGWTd6HmIcTGpYy5ecNYg1Mc
 IHfcl6dxaOUSbg==
X-Received: by 2002:a17:906:71cf:b0:ad5:3156:2c04 with SMTP id
 a640c23a62f3a-ad531562ea1mr1169025366b.25.1747739203860; 
 Tue, 20 May 2025 04:06:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFSL0CCgakMFxxaeQx629ZTH0FDVXtLbIXOZQcmbcwouKD6uMoWKz1KtqHC7yK1vW2GaE+T3g==
X-Received: by 2002:a17:906:71cf:b0:ad5:3156:2c04 with SMTP id
 a640c23a62f3a-ad531562ea1mr1169022166b.25.1747739203415; 
 Tue, 20 May 2025 04:06:43 -0700 (PDT)
Received: from [192.168.122.1] ([151.95.46.79])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad52d438086sm708581966b.89.2025.05.20.04.06.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 May 2025 04:06:42 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 32/35] target/riscv: convert Ventana V1 to RISCVCPUDef
Date: Tue, 20 May 2025 13:05:27 +0200
Message-ID: <20250520110530.366202-33-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250520110530.366202-1-pbonzini@redhat.com>
References: <20250520110530.366202-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.487,
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

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/riscv/cpu.c | 75 ++++++++++++++++++++++------------------------
 1 file changed, 35 insertions(+), 40 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 48939adaafe..000fcc6a1d6 100644
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


