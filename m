Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C0C5C3600C
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Apr 2025 07:04:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u1K2Z-0002v0-OX; Sun, 06 Apr 2025 03:03:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u1K2K-0002st-GD
 for qemu-devel@nongnu.org; Sun, 06 Apr 2025 03:03:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u1K2H-0001zj-GO
 for qemu-devel@nongnu.org; Sun, 06 Apr 2025 03:03:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743922996;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+WdTxFjUbX62A8mRZlfK7g0Egk03LYO9MpT2gfO3yCY=;
 b=fnha1tnsEoGnOxMrxIfD9MDAINIpPJw2XEK2T1KbYELs1dis0jZFSAZQcvmlQuctG1PsIb
 xoM9kPGthGSUf16VXxdM0xuw0tZRa/khB4wpi49hbxU6aLL8xbzn4MELxcfQeWlcoK1ev7
 YkscSwv408/zsC8PXhjXjN2G1eXApt8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-166-uxaJ0J5RPVSatU4HDQSXhA-1; Sun, 06 Apr 2025 03:03:14 -0400
X-MC-Unique: uxaJ0J5RPVSatU4HDQSXhA-1
X-Mimecast-MFC-AGG-ID: uxaJ0J5RPVSatU4HDQSXhA_1743922993
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-39c1b1c0969so2828584f8f.1
 for <qemu-devel@nongnu.org>; Sun, 06 Apr 2025 00:03:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743922992; x=1744527792;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+WdTxFjUbX62A8mRZlfK7g0Egk03LYO9MpT2gfO3yCY=;
 b=e8SzFcWdUu38a6Buex2XtWaWvqY768hBhiOot/FeiJViLYZRmbj5gDCg/FXvWavBeV
 OMaHWtJBiOG3UlMyj/F01ytpM0L0ccsaEEnXQAJAdqmD0DPTbQdhjsELSkIzno5x04NQ
 WAzBaEp3i15DXsdFISrWKYUXcA7LBhMoU7A2L3Ryb/SI29Yqm7I0fLIFhEiCqUW/BkZh
 1nGQmLq7pfNymoAwEY6gIUYGLUQLLG1nF8D91OcRragfOtfuZ0erKqfsxBcq6oX4DJ66
 Tdnq/Za34cY3aRxi5Han7HRDkucVpeWjJMC+aNEED91O9D+FFiXuwF1pg9C+tmLmgY/y
 qE5Q==
X-Gm-Message-State: AOJu0YyCRAvEv8xIE0AAlWRX4mtGoWvHZ7orudUVnO2jFQp/1JDEFC8m
 Jm/kGysCn2mS3e0dfga4ZzBkHuBFBl/wn0XlYnxLZlrFewwmbpuEpeoRAbr/hQ1i7uM4x33xUcU
 gb1ZerdVYTC104PYXigSOfczt3kVr630NKThdC6vKuTy7WQrFVtj9dbLq6UDQ0NyJENhYCrykZf
 zuV8wM72RV2xB9nsCNT2SDYTWTQ89T5wCGQ9rm
X-Gm-Gg: ASbGncs6LIFzWbnfaGcjNDY6mF8AYgAPhgFD6Q/Fv6JIeZilIIrNhNrKqGTsY6TenDP
 hNO7ZUHt+FS32qU56o72LfY4A1jwBfrFWKu+GcjzJOPCW60Tr/rWNowjJV3MO3aWgv1OZ9c4kO/
 gbf6vgFMIAt0/rnUWf+++DpTsXe9xEmn5fkeanLSgTx82DS4S0MLmzDq8OYh3PWuQwEn/RuLBdO
 cxIE0dShB6OVEZPTBkUTg6OoMqXr6hNJzalJ3ZepppMPUv8bh85uy0v30jstu7B2XOTxmsKUBbb
 +ZrS8EeE+6J/qvk4EQ==
X-Received: by 2002:a05:6000:2410:b0:391:2e7:67ff with SMTP id
 ffacd0b85a97d-39cb36b2972mr7396311f8f.10.1743922991762; 
 Sun, 06 Apr 2025 00:03:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEXXt37PYg0YTuKjU25RAS0cAEd2Qurb1huHyZsg0uFVnQRoaO9PXN1oLdl024c2ug6Bu8DaQ==
X-Received: by 2002:a05:6000:2410:b0:391:2e7:67ff with SMTP id
 ffacd0b85a97d-39cb36b2972mr7396283f8f.10.1743922991327; 
 Sun, 06 Apr 2025 00:03:11 -0700 (PDT)
Received: from [192.168.122.1] ([151.95.96.77])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c3020d98bsm8685703f8f.76.2025.04.06.00.03.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Apr 2025 00:03:08 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH 05/27] target/riscv: remove supported from RISCVSATPMap
Date: Sun,  6 Apr 2025 09:02:32 +0200
Message-ID: <20250406070254.274797-6-pbonzini@redhat.com>
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

"supported" can be computed on the fly based on the max_satp_mode.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/riscv/cpu_cfg.h |  4 +---
 target/riscv/cpu.c     | 34 ++++++++++++++++++++++++----------
 2 files changed, 25 insertions(+), 13 deletions(-)

diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index 1678a16accb..4a6f0d76522 100644
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
index edb2509345d..7df3e8b7cd5 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -440,14 +440,27 @@ static void set_satp_mode_max_supported(RISCVCPU *cpu,
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
@@ -1179,9 +1192,10 @@ static void riscv_cpu_disas_set_info(CPUState *s, disassemble_info *info)
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
@@ -1198,9 +1212,9 @@ static void riscv_cpu_satp_mode_finalize(RISCVCPU *cpu, Error **errp)
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
@@ -1229,7 +1243,7 @@ static void riscv_cpu_satp_mode_finalize(RISCVCPU *cpu, Error **errp)
         for (int i = satp_mode_map_max - 1; i >= 0; --i) {
             if (!(cpu->cfg.satp_mode.map & (1 << i)) &&
                 (cpu->cfg.satp_mode.init & (1 << i)) &&
-                (cpu->cfg.satp_mode.supported & (1 << i))) {
+                (supported & (1 << i))) {
                 error_setg(errp, "cannot disable %s satp mode if %s "
                            "is enabled", satp_mode_str(i, false),
                            satp_mode_str(satp_mode_map_max, false));
-- 
2.49.0


