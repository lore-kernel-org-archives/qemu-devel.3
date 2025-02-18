Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99DB3C021AA
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 16:59:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkQvS-0006jC-T5; Tue, 18 Feb 2025 11:58:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tkQvO-0006i0-Bi
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 11:58:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tkQvL-0004PY-MK
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 11:58:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739897899;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Bsqu6W5hn4SF/GbqmTZ4LIKsH1qUWmkq2zvD+TiQOg4=;
 b=IWoJavINhPK1qzhHKgbxogdj5VNapeJcSKq4Drr++diq3GQFiS4rga7NfMkvrXWr1JrRVm
 vng1hshhkV31QZ/rBgSYMVhOw+6h+gyIGinJycg6T15GzfxnG1jivL8m2+rC3G15tDztdV
 lIy4ONCvkafzA/D7zyD96bWCr/2pmdQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-580-wFs0hw3PMzCAqqwmLBw0Lg-1; Tue, 18 Feb 2025 11:58:11 -0500
X-MC-Unique: wFs0hw3PMzCAqqwmLBw0Lg-1
X-Mimecast-MFC-AGG-ID: wFs0hw3PMzCAqqwmLBw0Lg_1739897890
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-38f4e6e004fso1741701f8f.1
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2025 08:58:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739897890; x=1740502690;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Bsqu6W5hn4SF/GbqmTZ4LIKsH1qUWmkq2zvD+TiQOg4=;
 b=vtZ0PEdZFmdZMmj0a+HYL+Nm1Hiu/OjYNocm9+7JZFrGPkLxKjPwVlFBqvksz/kyr2
 pLHRVdaczHw/F6yedLjEyB72aWwtGyFgXf2C3Qwwn76ZnOez+MY6HTE88nzGuodLBxJN
 ZPF6x7JTy27hCIqnWEyE8OgJcEm9+2NJCyWFYsTI/Iw70jFYZw2knCMe51yv2LQPKGtO
 aRJnjw0GDa2mx5R31DXe54m1FZGrgGwAUy89vT4sznCgWidslBqQ/yI7tSc8/eMgzxhB
 mjBaQ85lhAVYRPniYK60nDyIhmDXTmYTN917pFoQL65IQJKEm6KBgHAYE2uAbHX6ZXvr
 eF+w==
X-Gm-Message-State: AOJu0Yxt/V4vEz64cm5frw0HfGM5nrfwZD2S62615n3VX3Vow2xVvPSV
 nFkIgbfhMOqqOVuM9ZpelnuYTmEXk4KNdMPw/+Xu79BEskniU2aRfY04WRJw2hR+QrH089oxfOh
 OqusqEY3f77DpHBSVH24TdiPAonkrp/pqiJbjiyQMJWLqFusqi5SUfxSJkFEDxI+9ok2sCpeKaK
 vaoGjzB3m9ERazwo0CxzdFEW0QVecGrCcLUoiHhRg=
X-Gm-Gg: ASbGncvdXAyk/iz7facNNSa4RU/FbtJhrkFdHpqRUj/qFqv0Sv1Ycw7qTli5m3o8P1v
 M/UBuYSSDiON3hTNN77Rj1ZfmrCQhZsFOA3oW73noK3AVaQ82+bMK6kRdiQD0iHA42jxnCJCJRf
 g5KP+NQ6EUgXRM2csYCz0UUUItfIXiVJw12Q7U1YLm//z1y3AhAyVVXO4e5bg7H2kT+dTnPsgdL
 JBjiUr7+by/BgEhGJma5zysxaPo30s+0euZqxgiKpbWYZSijAjDy3WG8rbbbnexCAxH7TYugeEy
 O0XlNO7ek0s=
X-Received: by 2002:adf:e647:0:b0:38d:ba09:86b5 with SMTP id
 ffacd0b85a97d-38f587e6476mr117582f8f.52.1739897889808; 
 Tue, 18 Feb 2025 08:58:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEhNqyAHLCyaP44VNuQi++D1i2lKZrouhYVe4Hda1XO6kOLpX5cqJNDzRdGuK58kyOSkZNkbQ==
X-Received: by 2002:adf:e647:0:b0:38d:ba09:86b5 with SMTP id
 ffacd0b85a97d-38f587e6476mr117561f8f.52.1739897889351; 
 Tue, 18 Feb 2025 08:58:09 -0800 (PST)
Received: from [192.168.10.48] ([176.206.122.109])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f25a0fe5esm15660220f8f.99.2025.02.18.08.58.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Feb 2025 08:58:08 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH 6/7] target/riscv: remove supported from RISCVSATPMap
Date: Tue, 18 Feb 2025 17:57:56 +0100
Message-ID: <20250218165757.554178-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250218165757.554178-1-pbonzini@redhat.com>
References: <20250218165757.554178-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.423,
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

"supported" can be computed on the fly based on the max_satp_mode.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/riscv/cpu_cfg.h |  4 +---
 target/riscv/cpu.c     | 34 ++++++++++++++++++++++++----------
 2 files changed, 25 insertions(+), 13 deletions(-)

diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index 28d8de978fa..1d7fff8decd 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -29,11 +29,9 @@
  *
  * init is a 16-bit bitmap used to make sure the user selected a correct
  * configuration as per the specification.
- *
- * supported is a 16-bit bitmap used to reflect the hw capabilities.
  */
 typedef struct {
-    uint16_t map, init, supported;
+    uint16_t map, init;
 } RISCVSATPMap;
 
 struct RISCVCPUConfig {
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index ce71ee95a52..86a048b62c5 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -437,14 +437,27 @@ static void set_satp_mode_max_supported(RISCVCPU *cpu,
     bool rv32 = riscv_cpu_mxl(&cpu->env) == MXL_RV32;
     const bool *valid_vm = rv32 ? valid_vm_1_10_32 : valid_vm_1_10_64;
 
-    for (int i = 0; i <= satp_mode; ++i) {
-        if (valid_vm[i]) {
-            cpu->cfg.satp_mode.supported |= (1 << i);
-        }
+    assert(valid_vm[satp_mode]);
+    cpu->cfg.max_satp_mode = satp_mode;
+}
+
+static bool get_satp_mode_supported(RISCVCPU *cpu, uint16_t *supported)
+{
+    bool rv32 = riscv_cpu_is_32bit(cpu);
+    const bool *valid_vm = rv32 ? valid_vm_1_10_32 : valid_vm_1_10_64;
+    int satp_mode = cpu->cfg.max_satp_mode;
+
+    if (satp_mode == -1) {
+        return false;
     }
 
-    assert(cpu->cfg.satp_mode.supported & (1 << satp_mode));
-    cpu->cfg.max_satp_mode = satp_mode;
+    *supported = 0;
+    for (int i = 0; i <= satp_mode; ++i) {
+        if (valid_vm[i]) {
+            *supported |= (1 << i);
+        }
+    }
+    return true;
 }
 
 /* Set the satp mode to the max supported */
@@ -1176,9 +1189,10 @@ static void riscv_cpu_disas_set_info(CPUState *s, disassemble_info *info)
 static void riscv_cpu_satp_mode_finalize(RISCVCPU *cpu, Error **errp)
 {
     bool rv32 = riscv_cpu_is_32bit(cpu);
+    uint16_t supported;
     uint8_t satp_mode_map_max;
 
-    if (cpu->cfg.max_satp_mode == -1) {
+    if (!get_satp_mode_supported(cpu, &supported)) {
         /* The CPU wants the hypervisor to decide which satp mode to allow */
         return;
     }
@@ -1195,9 +1209,9 @@ static void riscv_cpu_satp_mode_finalize(RISCVCPU *cpu, Error **errp)
              */
             for (int i = 1; i < 16; ++i) {
                 if ((cpu->cfg.satp_mode.init & (1 << i)) &&
-                    (cpu->cfg.satp_mode.supported & (1 << i))) {
+                    supported & (1 << i)) {
                     for (int j = i - 1; j >= 0; --j) {
-                        if (cpu->cfg.satp_mode.supported & (1 << j)) {
+                        if (supported & (1 << j)) {
                             cpu->cfg.max_satp_mode = j;
                             return;
                         }
@@ -1226,7 +1240,7 @@ static void riscv_cpu_satp_mode_finalize(RISCVCPU *cpu, Error **errp)
         for (int i = satp_mode_map_max - 1; i >= 0; --i) {
             if (!(cpu->cfg.satp_mode.map & (1 << i)) &&
                 (cpu->cfg.satp_mode.init & (1 << i)) &&
-                (cpu->cfg.satp_mode.supported & (1 << i))) {
+                (supported & (1 << i))) {
                 error_setg(errp, "cannot disable %s satp mode if %s "
                            "is enabled", satp_mode_str(i, false),
                            satp_mode_str(satp_mode_map_max, false));
-- 
2.48.1


