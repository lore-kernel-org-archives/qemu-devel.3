Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 160BAC02199
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 18:28:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg6be-00021u-BE; Thu, 06 Feb 2025 13:28:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tg6ba-0001ro-08
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 13:28:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tg6bY-0001WR-Gx
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 13:28:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738866479;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k3S3yGqQ9QU2FGjgCTSwMFrG+Hoe0VCtezT6QvrKUI0=;
 b=a+Gp1uLjnAMdQ0PVpT4plKrUKCCsewuc4Y2vCnIg4kV9tIfEDIUSmHk5I7v02CyGtXbI8g
 WM9yKuzTgF8ELsm5QAU1TA8qICoE04Vdhxx8CaCotoOj7P6FkpDMEgAi1WL5pnWu1ks/k7
 bZRoYWu/pXEpWzwdU4nr5Syo1kZS1T0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-CB_kVQvcNj67eRzuHCQSPg-1; Thu, 06 Feb 2025 13:27:58 -0500
X-MC-Unique: CB_kVQvcNj67eRzuHCQSPg-1
X-Mimecast-MFC-AGG-ID: CB_kVQvcNj67eRzuHCQSPg
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-38dc6aad9f8so151889f8f.1
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 10:27:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738866477; x=1739471277;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k3S3yGqQ9QU2FGjgCTSwMFrG+Hoe0VCtezT6QvrKUI0=;
 b=Ay4RgRT58AICrgHu167ee+S76bWhtEr5CPvCNa2QW2KksAGSU5+gKQi+KDGbL9bLk7
 Fg5fMvXuVxbecbs+2YFMkwVfuyMKCfkgXfr9/7xuOWAkocvapsZL/ToP3KXNhmuSzz10
 6j4uKRlUcv7iWqlOxjGYF+D1FOq5dG+yJVgHaFDStSBa2zVn92cPZsU6sz0LzH+guCxS
 nycA6sNivGX4YZH2V9WGkdTn043g/HpFV3dOpVMA+eyoeOSmUPBO0bbQGd5+2cXNwSkk
 rsc3QAcPrrYbMQBY5H3LMVgUC0P4gYbWSF+E1I7fx6orcBpFAbNo2e9dzE9tlYilRWC/
 fAOA==
X-Gm-Message-State: AOJu0YzKLj06ISkW+03BvK/4qDRB6Yha3fWVBqBhGPwA6J1x2g0i/++8
 XSDWiUSCR53BL7c3bBia1ufanHiaRZww07oj/QIR8uyDF3vRmi3xQ6LjPNo0aj70sUK220rt8K2
 8ktJGu8q4ygqMzftwBbNbod3pAjKe1mOhTcc7tdcTbhwIc2WRFMXhpLKSNhhZo2xos1BWoawyzN
 rBb8BpAvvW0fTQ/45CMn9Us/Dw3VfGzttvKaWyquc=
X-Gm-Gg: ASbGnctOxZHj2CqYOHslcj9RTOCQ44FKqR8yVqpKC+d5mhUobxfzgNMoVSr+TbDzRU2
 K7lvd704tFCohtkq16aFZpEpAfjAfj5ES7SGxHZ3zZXA87y+ZhV+BPg+5U9/MwuM79NGizPbIgH
 eUAFx8eVziXnBGVf/cpHslDrlgovj0nD19OncXKIJjxL+AEGAx5vycwCM6SVKmxp8YhMST5okNF
 NMGhcmfICBphPobcLylG3ULy2C4AEvZv7csaaQ192itDla+6eHMZJ6dkiY1drK1X/LZbjhWQ8Ax
 goxN0ac=
X-Received: by 2002:a5d:47af:0:b0:38d:ae4e:2267 with SMTP id
 ffacd0b85a97d-38dbb27096fmr3006874f8f.11.1738866476790; 
 Thu, 06 Feb 2025 10:27:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEP6/F6a3Hjl9MhhgsQNY7MLJAsWPe2v+xT1+JOn352HAZLFbCqaanUixJhqh2peDJGMQAZqw==
X-Received: by 2002:a5d:47af:0:b0:38d:ae4e:2267 with SMTP id
 ffacd0b85a97d-38dbb27096fmr3006857f8f.11.1738866476451; 
 Thu, 06 Feb 2025 10:27:56 -0800 (PST)
Received: from [192.168.1.84] ([93.56.163.127])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dbdd35e88sm2316112f8f.26.2025.02.06.10.27.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2025 10:27:55 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: alistair.francis@wdc.com
Subject: [PATCH 20/22] target/riscv: convert Xiangshan Nanhu to RISCVCPUDef
Date: Thu,  6 Feb 2025 19:27:08 +0100
Message-ID: <20250206182711.2420505-21-pbonzini@redhat.com>
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
 target/riscv/cpu.c | 67 ++++++++++++++++------------------------------
 1 file changed, 23 insertions(+), 44 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 7ebf007c129..b0a28c065e1 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -484,38 +484,6 @@ static void riscv_register_custom_csrs(RISCVCPU *cpu, RISCVCSR *csr_list)
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
@@ -2774,16 +2742,6 @@ void riscv_isa_write_fdt(RISCVCPU *cpu, void *fdt, char *nodename)
 }
 #endif
 
-#define DEFINE_VENDOR_CPU(type_name, misa_mxl_max_, initfn) \
-    {                                                       \
-        .name = (type_name),                                \
-        .parent = TYPE_RISCV_VENDOR_CPU,                    \
-        .instance_init = (initfn),                          \
-        .class_data = &((RISCVCPUDef) {                     \
-             .misa_mxl_max = (misa_mxl_max_),               \
-        }),                                                 \
-    }
-
 #define DEFINE_ABSTRACT_RISCV_CPU(type_name, parent_type_name, ...)    \
     {                                                       \
         .name = (type_name),                                \
@@ -3085,8 +3043,29 @@ static const TypeInfo riscv_cpu_type_infos[] = {
         .satp_mode64 = VM_1_10_SV48,
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
+        .satp_mode64 = VM_1_10_SV39,
+    ),
+
 #ifdef CONFIG_TCG
     DEFINE_RISCV_CPU(TYPE_RISCV_CPU_BASE128, TYPE_RISCV_DYNAMIC_CPU,
         .satp_mode64 = VM_1_10_SV57,
-- 
2.48.1


