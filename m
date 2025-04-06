Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54CCEC3600C
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Apr 2025 07:04:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u1K36-0003JX-E5; Sun, 06 Apr 2025 03:04:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u1K33-00039R-9t
 for qemu-devel@nongnu.org; Sun, 06 Apr 2025 03:04:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u1K31-00024u-NL
 for qemu-devel@nongnu.org; Sun, 06 Apr 2025 03:04:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743923043;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hnB/7oHKhjrWW1LvrsVYrICtjlf3gZsGBwtDi4qUkDw=;
 b=HfMMfXlPIrnCGCVJfIVAfMUxgOv/pI0d9nC8zLgDHNFNe0dAqnuX1M0xBoU1gC8fMZb825
 V3o6mdjPXvmLXa/PDazPpLUxg0v6WL/XpQIGvV13KNULjx7itp31GkGQmOR11m5tubhwSL
 6seIUHGXTYJhe7CY6rrYfiCZf9BiYkI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-444-ubDGmiiOO6i-2Edna3ROzg-1; Sun, 06 Apr 2025 03:04:00 -0400
X-MC-Unique: ubDGmiiOO6i-2Edna3ROzg-1
X-Mimecast-MFC-AGG-ID: ubDGmiiOO6i-2Edna3ROzg_1743923039
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43ea256f039so27361235e9.0
 for <qemu-devel@nongnu.org>; Sun, 06 Apr 2025 00:04:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743923039; x=1744527839;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hnB/7oHKhjrWW1LvrsVYrICtjlf3gZsGBwtDi4qUkDw=;
 b=MB162m4BimsZ+rhPHBSxDZ2hN/e3DGX2NYTHad0m6yL+ZsmgQyM+xftDQ1jNDXxpzN
 OBCdKz7EYpIwempX+6bLspZkTkmNYUxplm+6lCeKn+aDXgMI7Os+MM/X+ebXtT6cKuyx
 VGREvzHHFObRzmBpVtTKC9t5vuNxaXI7J2glAolxLk18sb5ZUn4SSotdq7Ikm4f4kPui
 JO8APjh4Fk6NxhoTUNFMfqV2HgsC5Y9brwVV9PMrNQnvij+fCEFqv9arWZ1vkukQVxIN
 0l1z+TpdfKhNJHGTb180QLSXeabRq2B4Ylt+690xLpIy1aaA2S1hi6lU/JtcQjTrIbtv
 rsrQ==
X-Gm-Message-State: AOJu0Yw9rEk7wIH21ewjjsOZ84zVrhXRoLpWP2IfXiecuOsclU0EJnYS
 rFsZqnF6A1348TvJj8MOM4CN9O7LBGYK4tGBQ/FzvEqB217T94MCom32npWh32UsRlSi5EKfeCx
 ZR7r8jcFVO6QUqRasXisvHfD0eFVhS0v/Kb4LvXOFcXPAS3jF6x4jftgBb76C4TAvcLu1YMkyrb
 i3qB5FzZHFBuBBTb3QkUTUn7zoLCwAYet1t9KS
X-Gm-Gg: ASbGnctprR3aybxLN07ut/DLwuLDW/i4Ie0O1UiFwzDNEpS2DJxkoojY9FIv1xuJlM8
 AbYz7qzIqtDs69Rpvn/srKZ+Qqz8JtyVedyC3A8EtxnaN7BJdgJKLMloKED7pf8bfOIcNExn4Gj
 kG3vvmqgnx8EQcWRRYIO/h60pn1B2zzIvHGTeeboBOpuOXX0PoO2hBEkhmrMXKrC5+idGOl1Z1Y
 RuDzlxchZ0GRH/nKy92FJ1fMroWUplCpFLrsCCmpzfk3Gf+ruh6BXHUkaTppl0iFg2x5obYryhj
 DULwkVt7s7OcmBq4sg==
X-Received: by 2002:a05:600c:4e09:b0:43d:83a:417d with SMTP id
 5b1f17b1804b1-43ed0bf6c17mr70142695e9.12.1743923038727; 
 Sun, 06 Apr 2025 00:03:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEynUmv2qTZPR4YetbzrZYn4JL2XTaqNZes3T4Jj8UyNpBGc7IJXC5ZDasO0lREKzrV2OwaZg==
X-Received: by 2002:a05:600c:4e09:b0:43d:83a:417d with SMTP id
 5b1f17b1804b1-43ed0bf6c17mr70142365e9.12.1743923038299; 
 Sun, 06 Apr 2025 00:03:58 -0700 (PDT)
Received: from [192.168.122.1] ([151.95.96.77])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c30096ed7sm8457743f8f.8.2025.04.06.00.03.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Apr 2025 00:03:57 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com
Subject: [PATCH 25/27] target/riscv: convert Ventana V1 to RISCVCPUDef
Date: Sun,  6 Apr 2025 09:02:52 +0200
Message-ID: <20250406070254.274797-26-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250406070254.274797-1-pbonzini@redhat.com>
References: <20250406070254.274797-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.359,
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/riscv/cpu.c | 75 ++++++++++++++++++++++------------------------
 1 file changed, 35 insertions(+), 40 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 616d89be17e..4e4d8ddf5a2 100644
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
@@ -3211,7 +3172,41 @@ static const TypeInfo riscv_cpu_type_infos[] = {
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
 #ifdef CONFIG_TCG
-- 
2.49.0


