Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AADCAC19776
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2025 10:32:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnxcG-0003nx-Nh; Fri, 28 Feb 2025 05:29:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tnxbu-0002oV-NZ
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 05:28:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tnxbn-00032G-Cq
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 05:28:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740738515;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=209+ML3a9c9lrFj9Ej0iVjYVHwvM8JVXD538kRh4qPs=;
 b=OIO6R1naZgLU/aNoR33sySsMvgDqw/8P9hTtXez7gLnmWJJLr2I8eNTzwPlLAk4Fm1K1Xe
 jKcHF51XhX/qEVqR/rlmnwY/RBjVJMic/fIo4uJn+lufc83/ycq/b54/5b+HTV4XxYCoyr
 XwX2W9DLHoQGgXL71amFyAorW0ooW7A=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-312-2IE2qgrBO4eyFLruIFXrOQ-1; Fri, 28 Feb 2025 05:28:34 -0500
X-MC-Unique: 2IE2qgrBO4eyFLruIFXrOQ-1
X-Mimecast-MFC-AGG-ID: 2IE2qgrBO4eyFLruIFXrOQ_1740738513
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4398ed35b10so10309375e9.1
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2025 02:28:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740738512; x=1741343312;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=209+ML3a9c9lrFj9Ej0iVjYVHwvM8JVXD538kRh4qPs=;
 b=aDkWBFwrnmPG7hyfpwqhYpJ8TASGN4y6JK8/yp4h7znHaZZYfGZPTVRK+LLO49O0in
 hccpb4AhNsEJWsNPumU8m9hyU1VsacJcScstIlcjuYAvON494ZxQlk5ANK/tJKnrwtAc
 XZL6yBlhhQoLZfXVboxwkz/YMjs2n+8DUs64E8dbYBgeVqskzxtGkj7zhXSIQGB4I3n1
 SYvjiAzOjsqqNcTuU267e0AnsmVLFt2wWPZTiiPH8+vmpUyKcILOpIQYduRqZ8sjgjLr
 ocZXHuOSljy/ls1afkrEGEa2EVcjNAiLih4g2je+44dRwrDDnMbT02y/gs31rzseTGrw
 tueQ==
X-Gm-Message-State: AOJu0YwrsKwBE/kxMLH1wr1anvHfMZy+BTzgSv7IivaC//nybg9x8Wff
 kekXylpDNrXElz4gpyVxVAX2QZra9cU7G8AT5Xcn45QOeLv37Dna9q8u0AYEvAQCkEIDqldahD4
 rS199SN+/Z/snQFW4SAJYis7orQN6zBY7hRyAjdfqdSyfHP0+/yrDeVQkq0TlmUCct9pitygEbR
 0iMsIvNT1m5D5Gg99QeH0GK7/T9lBDDEdU5WIlbAM=
X-Gm-Gg: ASbGncuhwU9qaOP15SYCgE4BTYXhKjt8K50y7igDqqHPW5t3ktLtqBxLXwnJtCeqimp
 PgtXr5v8WvMYCt32vn4lwRuMh3jvSwkmYIAgywu8+uTWqalTa8fGcQrNJ8RIp/knkUR9HltM8gS
 WplAHkub1RgbCTJt1+Li8LtpwbIwLa4N3W4awrLGTf36wZWsIhfSOpwNNkBNi7lq2bUHmjwb+bb
 AThaWxBLf/4OTI4dbu0bv7L/n2F2JEkm0cJXX6UUXZsm3vsgR2hX2vToiPq34pvxq3Fv+XAv6EU
 zcwQGHVvKfpyzAYxZOn5
X-Received: by 2002:a05:600c:4705:b0:439:a138:1d with SMTP id
 5b1f17b1804b1-43ba67606cemr20636515e9.22.1740738512077; 
 Fri, 28 Feb 2025 02:28:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFn4gbkCLGigmJiECiMrG/z+Cu3Ne2uh9eVe8T5hoLCFHCNoNbrZ2dipyRJMv5L56gcOTbJoQ==
X-Received: by 2002:a05:600c:4705:b0:439:a138:1d with SMTP id
 5b1f17b1804b1-43ba67606cemr20636325e9.22.1740738511684; 
 Fri, 28 Feb 2025 02:28:31 -0800 (PST)
Received: from [192.168.10.48] ([151.95.152.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43aba58760bsm81259515e9.38.2025.02.28.02.28.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2025 02:28:29 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: alistair.francis@wdc.com
Subject: [PATCH 19/22] target/riscv: convert TT Ascalon to RISCVCPUDef
Date: Fri, 28 Feb 2025 11:27:43 +0100
Message-ID: <20250228102747.867770-20-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250228102747.867770-1-pbonzini@redhat.com>
References: <20250228102747.867770-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/riscv/cpu.c | 127 +++++++++++++++++++++------------------------
 1 file changed, 60 insertions(+), 67 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index a249e48da6c..52e33905d21 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -537,72 +537,6 @@ static void rv64_veyron_v1_cpu_init(Object *obj)
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
@@ -3094,7 +3028,66 @@ static const TypeInfo riscv_cpu_type_infos[] = {
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
2.48.1


