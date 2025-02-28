Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD984C282C5
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2025 10:33:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnxcH-0003w5-Ro; Fri, 28 Feb 2025 05:29:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tnxbw-0002ox-Vb
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 05:28:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tnxbu-00032X-2c
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 05:28:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740738520;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7yfjbR9oGuTI5/RRen+n0jUAT9k7ki6hdfIxD7kuYKU=;
 b=bUBKepry/I4pZsgi9szJyFct7UDz0AXvoB6fA0SPVI4sG0VNBPtSBOCZ9Tc2sV5mA9liSb
 wn24Ly0iGYQB44l5n2oM815dWG4lwMq0J5RdrWv3J1Pu7DeCHtxwefvfPrkmvEqf3ZTq4E
 ni63g58HGetFAxD9GsZQdJ+RlIxIF3c=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-500-APcKyIdaOcCJfU0p1-UiuA-1; Fri, 28 Feb 2025 05:28:39 -0500
X-MC-Unique: APcKyIdaOcCJfU0p1-UiuA-1
X-Mimecast-MFC-AGG-ID: APcKyIdaOcCJfU0p1-UiuA_1740738518
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43947979ce8so8375165e9.0
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2025 02:28:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740738516; x=1741343316;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7yfjbR9oGuTI5/RRen+n0jUAT9k7ki6hdfIxD7kuYKU=;
 b=OscJ798Ge7OjhHS+CJNHLs80hmLylw9Ba7p2NbbM6beoufGeGJpQmgyWelxZImpya2
 NcT2ubQdWkiB6F6rrSDzXNJ5QPjxi9/c5WQBLiOxsVtXS8vgnYZXxWUrA/e8jVAKRUK+
 oNsAewjgyqhD0bTK6Q4T73iOfidwc98Am88wRUBrJcZ6Nkp3dvJmqcQ1V/yWDkKgRMjI
 SoIX6EHJTYIBYIoFttUvTAg59q/423GtozroOMt8xpXtx3ePiinRZX3AYU0H+knw0pcV
 SxsjVKJdNdzGEuJLrT+kw7E/+DxBSt5Ytd1mh55lGIXUE60PNOL32rzWzbijxPWhyuIE
 A/Gw==
X-Gm-Message-State: AOJu0Yyp2EBwlhUiW5Sqz4iqqCrD0V3m4D8UKGuxcCKixQNNo3j4lDxg
 ZxgVo9kOv7jG+zpp+yeKxd9FV+PrZNKT3rB6cKXl23kYWdWLQw409/2q6grYmMvDRTbCQK+S/F5
 7kGdT93+H7D1VGIvMltuWjRKmKe9a+NAKet/bOvIFeu80p8/xiwoqTYhvdmKg2BGIOZsLeUUMce
 Mc97nEl4raizwBPBzwpsr7xO5TsRnDsesMSo/q37g=
X-Gm-Gg: ASbGnctCgRlwnNuAmEzRbuNrCeTwIoGsihMzzhG3gGAdOeDpeSBLC4fI2Tyx11id+IJ
 gnd18DabRH5D0YaPNq41Vnwov9sWYjJBeWleMRRVV2dVbuyt8MqUN/OGvFY/C9OzJ4QbpjI+4Kf
 F/w/LgSgCUJ4tm6KrsGkRTh8mrACVxOq9LNLiu2DTf8IHjMXeDs8Y52CeZUR6XCxxvBx/DiaOEU
 k/dnnrO0f1Xhzhp3ORPdgjKAa+RoyOo1QOktXtNLwxPLEOd/8PsUC/zGcPaLi3JsLUbFMNKmGyX
 msirtWK9IpTfkGjVnEO1
X-Received: by 2002:a05:600c:3c9c:b0:439:9d75:9e7d with SMTP id
 5b1f17b1804b1-43ba6758319mr19501105e9.22.1740738516631; 
 Fri, 28 Feb 2025 02:28:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHLhgZnGQ7VEp0QjZy863iMHWHP4HcEC5aCXJYiHUHM289FUwD+IYxkmlmBuI+wHq9JWAb1fw==
X-Received: by 2002:a05:600c:3c9c:b0:439:9d75:9e7d with SMTP id
 5b1f17b1804b1-43ba6758319mr19500875e9.22.1740738516171; 
 Fri, 28 Feb 2025 02:28:36 -0800 (PST)
Received: from [192.168.10.48] ([151.95.152.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e4844514sm4801433f8f.76.2025.02.28.02.28.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2025 02:28:34 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: alistair.francis@wdc.com
Subject: [PATCH 21/22] target/riscv: convert Xiangshan Nanhu to RISCVCPUDef
Date: Fri, 28 Feb 2025 11:27:45 +0100
Message-ID: <20250228102747.867770-22-pbonzini@redhat.com>
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
 target/riscv/cpu.c | 77 ++++++++++++++--------------------------------
 1 file changed, 23 insertions(+), 54 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index a6c97a43799..ceda1a6e630 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -438,16 +438,6 @@ const char *satp_mode_str(uint8_t satp_mode, bool is_32_bit)
     g_assert_not_reached();
 }
 
-static void set_satp_mode_max_supported(RISCVCPU *cpu,
-                                        int satp_mode)
-{
-    bool rv32 = riscv_cpu_mxl(&cpu->env) == MXL_RV32;
-    const bool *valid_vm = rv32 ? valid_vm_1_10_32 : valid_vm_1_10_64;
-
-    assert(valid_vm[satp_mode]);
-    cpu->cfg.max_satp_mode = satp_mode;
-}
-
 static bool get_satp_mode_supported(RISCVCPU *cpu, uint16_t *supported)
 {
     bool rv32 = riscv_cpu_is_32bit(cpu);
@@ -496,38 +486,6 @@ static void riscv_register_custom_csrs(RISCVCPU *cpu, const RISCVCSR *csr_list)
 }
 #endif
 
-#if defined(TARGET_RISCV64)
-
-static void rv64_xiangshan_nanhu_cpu_init(Object *obj)
-{
-    CPURISCVState *env = &RISCV_CPU(obj)->env;
-    RISCVCPU *cpu = RISCV_CPU(obj);
-
-    riscv_cpu_set_misa_ext(env, RVG | RVC | RVB | RVS | RVU);
-    env->priv_ver = PRIV_VERSION_1_12_0;
-
-    /* Enable ISA extensions */
-    cpu->cfg.ext_zbc = true;
-    cpu->cfg.ext_zbkb = true;
-    cpu->cfg.ext_zbkc = true;
-    cpu->cfg.ext_zbkx = true;
-    cpu->cfg.ext_zknd = true;
-    cpu->cfg.ext_zkne = true;
-    cpu->cfg.ext_zknh = true;
-    cpu->cfg.ext_zksed = true;
-    cpu->cfg.ext_zksh = true;
-    cpu->cfg.ext_svinval = true;
-
-    cpu->cfg.mmu = true;
-    cpu->cfg.pmp = true;
-
-#ifndef CONFIG_USER_ONLY
-    set_satp_mode_max_supported(cpu, VM_1_10_SV39);
-#endif
-}
-
-#endif /* !TARGET_RISCV64 */
-
 static ObjectClass *riscv_cpu_class_by_name(const char *cpu_model)
 {
     ObjectClass *oc;
@@ -2777,16 +2735,6 @@ void riscv_isa_write_fdt(RISCVCPU *cpu, void *fdt, char *nodename)
 }
 #endif
 
-#define DEFINE_VENDOR_CPU(type_name, misa_mxl_max_, initfn) \
-    {                                                       \
-        .name = (type_name),                                \
-        .parent = TYPE_RISCV_VENDOR_CPU,                    \
-        .instance_init = (initfn),                          \
-        .class_data = (void*) &((const RISCVCPUDef) {       \
-             .misa_mxl_max = (misa_mxl_max_),               \
-        }),                                                 \
-    }
-
 #define DEFINE_ABSTRACT_RISCV_CPU(type_name, parent_type_name, ...) \
     {                                                       \
         .name = (type_name),                                \
@@ -3084,8 +3032,29 @@ static const TypeInfo riscv_cpu_type_infos[] = {
         .cfg.max_satp_mode = VM_1_10_SV48,
     ),
 
-    DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_XIANGSHAN_NANHU,
-                                                 MXL_RV64, rv64_xiangshan_nanhu_cpu_init),
+    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_XIANGSHAN_NANHU, TYPE_RISCV_VENDOR_CPU,
+        .misa_mxl_max = MXL_RV64,
+        .misa_ext = RVG | RVC | RVB | RVS | RVU,
+        .priv_spec = PRIV_VERSION_1_12_0,
+
+        /* ISA extensions */
+        .cfg.ext_zbc = true,
+        .cfg.ext_zbkb = true,
+        .cfg.ext_zbkc = true,
+        .cfg.ext_zbkx = true,
+        .cfg.ext_zknd = true,
+        .cfg.ext_zkne = true,
+        .cfg.ext_zknh = true,
+        .cfg.ext_zksed = true,
+        .cfg.ext_zksh = true,
+        .cfg.ext_svinval = true,
+
+        .cfg.mmu = true,
+        .cfg.pmp = true,
+
+        .cfg.max_satp_mode = VM_1_10_SV39,
+    ),
+
 #ifdef CONFIG_TCG
     DEFINE_RISCV_CPU(TYPE_RISCV_CPU_BASE128, TYPE_RISCV_DYNAMIC_CPU,
         .cfg.max_satp_mode = VM_1_10_SV57,
-- 
2.48.1


