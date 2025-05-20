Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E61B6C54799
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 11:07:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHKnh-0008Ko-7U; Tue, 20 May 2025 07:06:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uHKnP-0007ZJ-Sg
 for qemu-devel@nongnu.org; Tue, 20 May 2025 07:06:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uHKnN-000369-Rf
 for qemu-devel@nongnu.org; Tue, 20 May 2025 07:06:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747739165;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/Pog9+CcCvTaueB7szePLyjoe1mtNsA/WsjKjKhQNgk=;
 b=JJb3tF090VejuxhR8HZSQTfjd1q87apvh3RBzAGmOXOl5lQg/W+s+wQdz6qG7Wo+SLPpS3
 NpP9F1kCK93GXR6k7I7gdvGtN5UsfNMe+Tp5QGXB2tx0zgASuMImZu0jnbkjTXVMBd9Cnb
 dwcj5Vk40KayCokeg3oO4T/KF6gJkX8=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-55-4sPRAdTvMHWBI00ecb0oRQ-1; Tue, 20 May 2025 07:06:03 -0400
X-MC-Unique: 4sPRAdTvMHWBI00ecb0oRQ-1
X-Mimecast-MFC-AGG-ID: 4sPRAdTvMHWBI00ecb0oRQ_1747739163
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-601c0493731so1265539a12.3
 for <qemu-devel@nongnu.org>; Tue, 20 May 2025 04:06:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747739161; x=1748343961;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/Pog9+CcCvTaueB7szePLyjoe1mtNsA/WsjKjKhQNgk=;
 b=jqrXve/AsilmQ5NWpolEDP0mrJTAJD2hc2RmyHtc1GShI+lCBS83jY3ENHHlPsM0jO
 v9fFOfLh/3ayjIbFy4goeJFzGsPQQMmHT4aujpekPPb/yAj/K1aoWIFyAIaQrFPafL1o
 xY12jgYZV3pNntajDWbgtN7PR+uh+5BbPbhEE72O5GIANQA7yJ7fQTYHlxUkixE6f0Lr
 EkO4wpn9eg2wtftvwvzvkU+lO76NijKz5Dy6G3gnEUSKjCZU3AWBPP4TLNz6x4/Q2ENW
 TUuDK3YgbnwsPsV/jR6B6TXlRKTFySThlzfJUngGMXiYIXf8RpxqxFCUY7Z9r1+rsd6R
 ZF/w==
X-Gm-Message-State: AOJu0YwQxLv3JDkvjwQTQWSF/MGm6fgfIFBW1xmskEcz2b0xqI1t2Yjq
 PL83N7p+7QfsJpcfAKdqHtv+cI/P7G1aZ0RTao6FFJu06orNlZyA5GxdjBv3qA8fqDlm73jbZkQ
 lDBF88JJkCDr1RwkfvB8Axyr5cLOfT+GbtB/y3LS68G45pbMV5j7Y85X0+mH1e7cCTVZalOAaL8
 Ob13eXGlBY+PU7PHGOg827oaPMJ2nn8UaEnSYYKinY
X-Gm-Gg: ASbGncuLy7OCs+74fcrFw1cRyJ9Udk2q9tE9K60BF+z1QZD8ExZHduV/OylwIkdVSmo
 CKvW06QiTP0iSShlWStT6PPMC5nto7xJ8IFGAODdUvHvXPkwei+stbGfOa2rHENAKOsXED/9+CG
 oZXG620vTY+A9nwJcvnSOJsiquNNoQu2jolzCccWRFgSMS7EfVUdr/ZtFKclbGkpACBJG7MVstO
 p6QvAKtqL1ghcw1pYFS/NON6NW3zdVSkM6YXYobF+iMz8au0HBfSWt/UY8yaVjua7C2Y4IR40Wq
 oVwF1+R1sCIf+A==
X-Received: by 2002:a05:6402:2793:b0:601:d77f:47d9 with SMTP id
 4fb4d7f45d1cf-601d77f4b72mr7563494a12.5.1747739161125; 
 Tue, 20 May 2025 04:06:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGHY3dXKMAW8daj6ym23qtWsq2CmUHvMnu4sPPFtmTGcq6JknLcoF1wEsWpS2nnV/b1iSVZhQ==
X-Received: by 2002:a05:6402:2793:b0:601:d77f:47d9 with SMTP id
 4fb4d7f45d1cf-601d77f4b72mr7563465a12.5.1747739160659; 
 Tue, 20 May 2025 04:06:00 -0700 (PDT)
Received: from [192.168.122.1] ([151.95.46.79])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6005a6e6366sm7145203a12.44.2025.05.20.04.06.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 May 2025 04:06:00 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 13/35] target/riscv: remove supported from RISCVSATPMap
Date: Tue, 20 May 2025 13:05:08 +0200
Message-ID: <20250520110530.366202-14-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250520110530.366202-1-pbonzini@redhat.com>
References: <20250520110530.366202-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
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

"supported" can be computed on the fly based on the max_satp_mode.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/riscv/cpu_cfg.h |  4 +---
 target/riscv/cpu.c     | 34 ++++++++++++++++++++++++----------
 2 files changed, 25 insertions(+), 13 deletions(-)

diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index c8ea5cdc870..8b80e03c9ab 100644
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
index 48576bff92c..0326cd8e563 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -439,14 +439,27 @@ static void set_satp_mode_max_supported(RISCVCPU *cpu,
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
@@ -1171,9 +1184,10 @@ static void riscv_cpu_disas_set_info(CPUState *s, disassemble_info *info)
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
@@ -1190,9 +1204,9 @@ static void riscv_cpu_satp_mode_finalize(RISCVCPU *cpu, Error **errp)
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
@@ -1221,7 +1235,7 @@ static void riscv_cpu_satp_mode_finalize(RISCVCPU *cpu, Error **errp)
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


