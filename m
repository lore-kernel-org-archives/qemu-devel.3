Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CF4BC3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 09:59:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEPsC-0001Yo-IW; Mon, 12 May 2025 05:55:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uEPry-0001OB-GI
 for qemu-devel@nongnu.org; Mon, 12 May 2025 05:54:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uEPrw-0000mn-Je
 for qemu-devel@nongnu.org; Mon, 12 May 2025 05:54:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747043684;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KJlzhz5dO36OXTaYh7DzN25fe/RsFEswKsqZ/vbJmVM=;
 b=eKJoc/cuoJURgwxorSsyZ3hftdoDllAHUp49929alqw5W/UylwLrt/cZsVR+DnGVKdEuAE
 NRcSLb2XYjPyS+lF5iXOHOAZ12NevOP7nE8w5Q1UbcZE6nRhNI5jHY2PjRi96bxk8QCnrw
 5F7J42u1U81tF21ysfD5HR351Ff3vK8=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-mmXVl7e3OAqFnjHuTpsL2Q-1; Mon, 12 May 2025 05:54:42 -0400
X-MC-Unique: mmXVl7e3OAqFnjHuTpsL2Q-1
X-Mimecast-MFC-AGG-ID: mmXVl7e3OAqFnjHuTpsL2Q_1747043681
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-ad21aba2147so347371566b.3
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 02:54:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747043680; x=1747648480;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KJlzhz5dO36OXTaYh7DzN25fe/RsFEswKsqZ/vbJmVM=;
 b=G7RASrs196KNb0wF33E3oyna+3EJG0cOpTySQgKVxw8Ju2xXNITkoY8XSwghlzac2e
 +HI3HgkwVvq5bg3Mz715GJTfTOBvc/+vbUTMqE4jaVdd2SJxSzyfF6iWuGO9Uhi3DIa9
 wli57+RdgxopTk+p08god8JnZ2MCQtla+f9o2Lv4RkhYcp6a5xArkgHp47dGt34jyKRN
 OiHbQi8q40eEFNGXgt13XDKS300pOdzGZzlqQn24M9CvN7y7p0VUXWLUxzhG3ayjv1Vh
 9ADt4wFSKBU95EINXSmspgjs0GSfsJaioHVk5Kghl39ldDzEgy2YKTDz+8hhz0at+78G
 eF+w==
X-Gm-Message-State: AOJu0YxMj7zk7zS5qqgquXsibCkqrzpezWvv1m77D0yeNV1qDKWWcGra
 F6Rqpap1ATbL3+9MUwNSirVi+m9rtySb+6493hA+EbV8OhmaXp8saU+Eh23iuhJC3zp6KbCuKWO
 aNwemn/9JDynn3y68SrPhyTlof03UnN0CetxEeLWW1iP3DTILXJ+ZMZgx4MwYeFry0NZ5Jps3t9
 BgrQdCrL8ufrT/kARRpYkI2cev9GGYX/AFvBU8
X-Gm-Gg: ASbGncv6JSx8YH6xO4DuHhUJP22EawW9KbOminjGOQ13X4QDDS0RYgvoKHOfxUNFzDw
 E4zlE4idEcYbbPk8gsCvqsmZeZBEUDaySD8tBwrlO2DBBICKTyFFGyJ0WiEEgNgRS8q71EcO4Gw
 RmKe6O2nG6V9NGsfOLkNwdmXpdeFvT/6Zpc0yxlMQTgS0Fp5L2cM1IlicECFQR9Zr/pAW1RILbL
 RCyKbwYjRe19SbrhGrXpHEOSCqbWrpAPFZQsfurAB+ekJ1YXrIuK0yUHpOfwQhebC0Trgb3RE/M
 5X9CHvXgdCrZjq+OmmQSpY0B82b2Q40ARZq7bkf23cSC+Tw=
X-Received: by 2002:a17:907:7da2:b0:acf:b9bd:300b with SMTP id
 a640c23a62f3a-ad218e95dcfmr1098503666b.11.1747043680471; 
 Mon, 12 May 2025 02:54:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHxE/H9RiVWtIXVVwtT+eeFzpI7UHx0S+2islAHR8frRe4nA3j2pXtkcrh0yNTqYBuqXKkOqw==
X-Received: by 2002:a17:907:7da2:b0:acf:b9bd:300b with SMTP id
 a640c23a62f3a-ad218e95dcfmr1098501466b.11.1747043679980; 
 Mon, 12 May 2025 02:54:39 -0700 (PDT)
Received: from [192.168.122.1] (93-40-56-213.ip37.fastwebnet.it.
 [93.40.56.213]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad2197bd432sm586750466b.129.2025.05.12.02.54.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 May 2025 02:54:39 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: dbarboza@ventanamicro.com, alistair23@gmail.com,
 richard.henderson@linaro.org
Subject: [PATCH 22/26] target/riscv: convert TT Ascalon to RISCVCPUDef
Date: Mon, 12 May 2025 11:52:22 +0200
Message-ID: <20250512095226.93621-23-pbonzini@redhat.com>
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
 target/riscv/cpu.c | 127 +++++++++++++++++++++------------------------
 1 file changed, 60 insertions(+), 67 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index dbfd8c7a348..18b60428d14 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -539,72 +539,6 @@ static void rv64_veyron_v1_cpu_init(Object *obj)
 #endif
 }
 
-/* Tenstorrent Ascalon */
-static void rv64_tt_ascalon_cpu_init(Object *obj)
-{
-    CPURISCVState *env = &RISCV_CPU(obj)->env;
-    RISCVCPU *cpu = RISCV_CPU(obj);
-
-    riscv_cpu_set_misa_ext(env, RVG | RVC | RVS | RVU | RVH | RVV);
-    env->priv_ver = PRIV_VERSION_1_13_0;
-
-    /* Enable ISA extensions */
-    cpu->cfg.mmu = true;
-    cpu->cfg.vlenb = 256 >> 3;
-    cpu->cfg.elen = 64;
-    cpu->env.vext_ver = VEXT_VERSION_1_00_0;
-    cpu->cfg.rvv_ma_all_1s = true;
-    cpu->cfg.rvv_ta_all_1s = true;
-    cpu->cfg.misa_w = true;
-    cpu->cfg.pmp = true;
-    cpu->cfg.cbom_blocksize = 64;
-    cpu->cfg.cbop_blocksize = 64;
-    cpu->cfg.cboz_blocksize = 64;
-    cpu->cfg.ext_zic64b = true;
-    cpu->cfg.ext_zicbom = true;
-    cpu->cfg.ext_zicbop = true;
-    cpu->cfg.ext_zicboz = true;
-    cpu->cfg.ext_zicntr = true;
-    cpu->cfg.ext_zicond = true;
-    cpu->cfg.ext_zicsr = true;
-    cpu->cfg.ext_zifencei = true;
-    cpu->cfg.ext_zihintntl = true;
-    cpu->cfg.ext_zihintpause = true;
-    cpu->cfg.ext_zihpm = true;
-    cpu->cfg.ext_zimop = true;
-    cpu->cfg.ext_zawrs = true;
-    cpu->cfg.ext_zfa = true;
-    cpu->cfg.ext_zfbfmin = true;
-    cpu->cfg.ext_zfh = true;
-    cpu->cfg.ext_zfhmin = true;
-    cpu->cfg.ext_zcb = true;
-    cpu->cfg.ext_zcmop = true;
-    cpu->cfg.ext_zba = true;
-    cpu->cfg.ext_zbb = true;
-    cpu->cfg.ext_zbs = true;
-    cpu->cfg.ext_zkt = true;
-    cpu->cfg.ext_zvbb = true;
-    cpu->cfg.ext_zvbc = true;
-    cpu->cfg.ext_zvfbfmin = true;
-    cpu->cfg.ext_zvfbfwma = true;
-    cpu->cfg.ext_zvfh = true;
-    cpu->cfg.ext_zvfhmin = true;
-    cpu->cfg.ext_zvkng = true;
-    cpu->cfg.ext_smaia = true;
-    cpu->cfg.ext_smstateen = true;
-    cpu->cfg.ext_ssaia = true;
-    cpu->cfg.ext_sscofpmf = true;
-    cpu->cfg.ext_sstc = true;
-    cpu->cfg.ext_svade = true;
-    cpu->cfg.ext_svinval = true;
-    cpu->cfg.ext_svnapot = true;
-    cpu->cfg.ext_svpbmt = true;
-
-#ifndef CONFIG_USER_ONLY
-    set_satp_mode_max_supported(cpu, VM_1_10_SV57);
-#endif
-}
-
 static void rv64_xiangshan_nanhu_cpu_init(Object *obj)
 {
     CPURISCVState *env = &RISCV_CPU(obj)->env;
@@ -3213,7 +3147,66 @@ static const TypeInfo riscv_cpu_type_infos[] = {
 #endif
     ),
 
-    DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_TT_ASCALON, MXL_RV64,  rv64_tt_ascalon_cpu_init),
+    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_TT_ASCALON, TYPE_RISCV_VENDOR_CPU,
+        .misa_mxl_max = MXL_RV64,
+        .misa_ext = RVG | RVC | RVS | RVU | RVH | RVV,
+        .priv_spec = PRIV_VERSION_1_13_0,
+        .vext_spec = VEXT_VERSION_1_00_0,
+
+        /* ISA extensions */
+        .cfg.mmu = true,
+        .cfg.vlenb = 256 >> 3,
+        .cfg.elen = 64,
+        .cfg.rvv_ma_all_1s = true,
+        .cfg.rvv_ta_all_1s = true,
+        .cfg.misa_w = true,
+        .cfg.pmp = true,
+        .cfg.cbom_blocksize = 64,
+        .cfg.cbop_blocksize = 64,
+        .cfg.cboz_blocksize = 64,
+        .cfg.ext_zic64b = true,
+        .cfg.ext_zicbom = true,
+        .cfg.ext_zicbop = true,
+        .cfg.ext_zicboz = true,
+        .cfg.ext_zicntr = true,
+        .cfg.ext_zicond = true,
+        .cfg.ext_zicsr = true,
+        .cfg.ext_zifencei = true,
+        .cfg.ext_zihintntl = true,
+        .cfg.ext_zihintpause = true,
+        .cfg.ext_zihpm = true,
+        .cfg.ext_zimop = true,
+        .cfg.ext_zawrs = true,
+        .cfg.ext_zfa = true,
+        .cfg.ext_zfbfmin = true,
+        .cfg.ext_zfh = true,
+        .cfg.ext_zfhmin = true,
+        .cfg.ext_zcb = true,
+        .cfg.ext_zcmop = true,
+        .cfg.ext_zba = true,
+        .cfg.ext_zbb = true,
+        .cfg.ext_zbs = true,
+        .cfg.ext_zkt = true,
+        .cfg.ext_zvbb = true,
+        .cfg.ext_zvbc = true,
+        .cfg.ext_zvfbfmin = true,
+        .cfg.ext_zvfbfwma = true,
+        .cfg.ext_zvfh = true,
+        .cfg.ext_zvfhmin = true,
+        .cfg.ext_zvkng = true,
+        .cfg.ext_smaia = true,
+        .cfg.ext_smstateen = true,
+        .cfg.ext_ssaia = true,
+        .cfg.ext_sscofpmf = true,
+        .cfg.ext_sstc = true,
+        .cfg.ext_svade = true,
+        .cfg.ext_svinval = true,
+        .cfg.ext_svnapot = true,
+        .cfg.ext_svpbmt = true,
+
+        .cfg.max_satp_mode = VM_1_10_SV57,
+    ),
+
     DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_VEYRON_V1,  MXL_RV64,  rv64_veyron_v1_cpu_init),
     DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_XIANGSHAN_NANHU,
                                                  MXL_RV64, rv64_xiangshan_nanhu_cpu_init),
-- 
2.49.0


