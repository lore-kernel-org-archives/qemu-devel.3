Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06200C3601E
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Apr 2025 07:05:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u1K2f-0002vZ-6A; Sun, 06 Apr 2025 03:03:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u1K2C-0002s2-IV
 for qemu-devel@nongnu.org; Sun, 06 Apr 2025 03:03:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u1K2A-0001zB-Vv
 for qemu-devel@nongnu.org; Sun, 06 Apr 2025 03:03:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743922989;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ysz62fbRufT/XOeR6qnurUZtHJqYFJXyahD0QK9tMuU=;
 b=Z2VqlaJuLTWnM30tsGoGubk5je3q//50ShE9CUnvMgKpIaGpfZKe78tVV5vYTuGndNEK9g
 uhxVP5lzxggQk3xaZASK7mgdcOVOQj6n0kZ+IyFxVqFIs0rIhTu9fSUIo9pbJ3r5dU3kuR
 134vN411BNpMnGaXQSANif0t9YZYRZg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-696-yXBkU759OiqhxVUpbzLVkw-1; Sun, 06 Apr 2025 03:03:08 -0400
X-MC-Unique: yXBkU759OiqhxVUpbzLVkw-1
X-Mimecast-MFC-AGG-ID: yXBkU759OiqhxVUpbzLVkw_1743922987
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-39134c762ebso1549924f8f.0
 for <qemu-devel@nongnu.org>; Sun, 06 Apr 2025 00:03:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743922986; x=1744527786;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ysz62fbRufT/XOeR6qnurUZtHJqYFJXyahD0QK9tMuU=;
 b=F03XEZQUOHdCLiQ9XTr0RF1otYUuijk8L16GEnDGgsfj6Ni8LkCs0VyohzuQ/3VFhV
 aohDhwa5oUnPujNq9tb+FsiCW7f269e+AyzygdoWZs9ZiKbCqkIl4knm6PyNfZUVMaim
 igp7ixH+ldSLCSc3kzTWwFXE/alMjdQsNRNGebvZh00d7qlRiTIuh98GQeiCZ2Ep3NeM
 JXomMAQ3iaHdRNdpTLExidymtIBGcFeAV8gnmpy+jagvpkVC4owkoLxlZORuzAU37id4
 nTqWRLL2tsbHt1Jo0ao9zAlelHvBpKw1S5jgjys4ixV7e5pGGeceTd3rJZGUIu8Aqntm
 8F7A==
X-Gm-Message-State: AOJu0YzWIPBSh40I3Gx3fI+QeP+LVBhFH+K038Js4yUk2m8jsIW6rD/4
 iK7uOnaqcMrMXBZeiYtOePFhw7zxUYxbtFkzyjGm7qOi2kuz8Q6Ryj846/rWb64ybFBK4XKIJyt
 nHXGz2gwnIfe1PAkSAyzN2u5ZCFs4AB1peFjgvubonBsPArEEQUJ9Fzgx7Qu+3fdMuTtZ3mixbT
 pM6oRYv+IMN5Wc3/3vgSF8gTDX3xfi5vSF+4pW
X-Gm-Gg: ASbGncsZFvaxJNCvrSO5hPOCQ9taeY+ehaL7Dzf+lyMUG/tXjg5rGxSFOYTQ6cnGCGK
 +scCFUy61xo9DEm3CoodtaB5dWYA1hMtrE4JrxwT4iHelkzPnQQ+iawnQWJ4fGzWRhHFjaUkyxp
 kTJyxtTkpqK7UamtAMLk6DyvEOb74vUxZzPFuLddZPmTHYiSL0R2xM00XrDNp6Hi1DQsYJecPha
 9siEDgBbJczaJ91cDkOUSiHif/pwafMW0OVlvTf9zBpvFsU0cEIsc8TUtvNu+ZKlbND8WFKpVdf
 oCdfiaqMZHGi0RMLZQ==
X-Received: by 2002:a5d:5f8a:0:b0:399:7f2b:8531 with SMTP id
 ffacd0b85a97d-39d6fce113emr3438579f8f.38.1743922986242; 
 Sun, 06 Apr 2025 00:03:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHj4iv7fJ3TDEwZp9OloQnAFJHikLOKH1nXa95FX6VULPTUN9BP8gRPATR8AMRluqVY3bOH0A==
X-Received: by 2002:a5d:5f8a:0:b0:399:7f2b:8531 with SMTP id
 ffacd0b85a97d-39d6fce113emr3438557f8f.38.1743922985864; 
 Sun, 06 Apr 2025 00:03:05 -0700 (PDT)
Received: from [192.168.122.1] ([151.95.96.77])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec34a8d67sm92351475e9.12.2025.04.06.00.03.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Apr 2025 00:03:03 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH 03/27] target/riscv: cpu: store max SATP mode as a single
 integer
Date: Sun,  6 Apr 2025 09:02:30 +0200
Message-ID: <20250406070254.274797-4-pbonzini@redhat.com>
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

The maximum available SATP mode implies all the shorter virtual address sizes.
Store it in RISCVCPUConfig and avoid recomputing it via satp_mode_max_from_map.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/riscv/cpu_cfg.h     |  1 +
 target/riscv/cpu.c         | 14 ++++++++------
 target/riscv/tcg/tcg-cpu.c |  3 ++-
 3 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index 8a843482cc6..1678a16accb 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -197,6 +197,7 @@ struct RISCVCPUConfig {
     bool short_isa_string;
 
 #ifndef CONFIG_USER_ONLY
+    int8_t max_satp_mode;
     RISCVSATPMap satp_mode;
 #endif
 };
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index fffd263a799..4dcab156948 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -447,6 +447,7 @@ static void set_satp_mode_max_supported(RISCVCPU *cpu,
     }
 
     assert(cpu->cfg.satp_mode.supported & (1 << satp_mode));
+    cpu->cfg.max_satp_mode = satp_mode;
 }
 
 /* Set the satp mode to the max supported */
@@ -1180,16 +1181,13 @@ static void riscv_cpu_disas_set_info(CPUState *s, disassemble_info *info)
 static void riscv_cpu_satp_mode_finalize(RISCVCPU *cpu, Error **errp)
 {
     bool rv32 = riscv_cpu_is_32bit(cpu);
-    uint8_t satp_mode_map_max, satp_mode_supported_max;
+    uint8_t satp_mode_map_max;
 
     /* The CPU wants the OS to decide which satp mode to use */
     if (cpu->cfg.satp_mode.supported == 0) {
         return;
     }
 
-    satp_mode_supported_max =
-                    satp_mode_max_from_map(cpu->cfg.satp_mode.supported);
-
     if (cpu->cfg.satp_mode.map == 0) {
         if (cpu->cfg.satp_mode.init == 0) {
             /* If unset by the user, we fallback to the default satp mode. */
@@ -1218,10 +1216,10 @@ static void riscv_cpu_satp_mode_finalize(RISCVCPU *cpu, Error **errp)
     satp_mode_map_max = satp_mode_max_from_map(cpu->cfg.satp_mode.map);
 
     /* Make sure the user asked for a supported configuration (HW and qemu) */
-    if (satp_mode_map_max > satp_mode_supported_max) {
+    if (satp_mode_map_max > cpu->cfg.max_satp_mode) {
         error_setg(errp, "satp_mode %s is higher than hw max capability %s",
                    satp_mode_str(satp_mode_map_max, rv32),
-                   satp_mode_str(satp_mode_supported_max, rv32));
+                   satp_mode_str(cpu->cfg.max_satp_mode, rv32));
         return;
     }
 
@@ -1481,6 +1479,10 @@ static void riscv_cpu_init(Object *obj)
     cpu->cfg.cbop_blocksize = 64;
     cpu->cfg.cboz_blocksize = 64;
     cpu->env.vext_ver = VEXT_VERSION_1_00_0;
+
+#ifndef CONFIG_USER_ONLY
+    cpu->cfg.max_satp_mode = -1;
+#endif /* CONFIG_USER_ONLY */
 }
 
 static void riscv_bare_cpu_init(Object *obj)
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 5aef9eef366..2f93e2dd285 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -706,8 +706,9 @@ static bool riscv_cpu_validate_profile_satp(RISCVCPU *cpu,
                                             RISCVCPUProfile *profile,
                                             bool send_warn)
 {
-    int satp_max = satp_mode_max_from_map(cpu->cfg.satp_mode.supported);
+    int satp_max = cpu->cfg.max_satp_mode;
 
+    assert(satp_max >= 0);
     if (profile->satp_mode > satp_max) {
         if (send_warn) {
             bool is_32bit = riscv_cpu_is_32bit(cpu);
-- 
2.49.0


