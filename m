Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3116C021AF
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 16:58:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkQvK-0006hQ-Q7; Tue, 18 Feb 2025 11:58:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tkQvD-0006fc-P3
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 11:58:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tkQvC-0004Os-By
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 11:58:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739897889;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z8ooKt04z4ZxLXGWsR/viFFWg0Qk4K6VF5CCyLFYCUQ=;
 b=Nf0KcxQDebGZWrTJtkjRL8X72AhJ8JtjJHvniIibNUXCOjWkxuCxjIlvkyPzOlCDH15OIu
 rw8dkuOmgKfWl2WaBHhp6e3YswmQWcxY9ooEOPiQMLud5tY0aN8FC2EDHjrMjETXdXokOC
 a7KP09psVnvFkOfjm2w1XXXEmeFKooI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-94-iweiuHgmNR-aoTGkD5JTMA-1; Tue, 18 Feb 2025 11:58:08 -0500
X-MC-Unique: iweiuHgmNR-aoTGkD5JTMA-1
X-Mimecast-MFC-AGG-ID: iweiuHgmNR-aoTGkD5JTMA_1739897887
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43947a0919aso47147525e9.0
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2025 08:58:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739897886; x=1740502686;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z8ooKt04z4ZxLXGWsR/viFFWg0Qk4K6VF5CCyLFYCUQ=;
 b=H5+QBfjuVyTVmXHBSgHLeYVCGLqA6dolzk1k7NLZFgbcsQE567ZRuUNiBvyKcqeZhA
 fUqhLnno5ixvcm9NOPwkPfB68r+bUapjU/EWIoVCHHwHpUzI81zal5Eh0h7BTy560rC1
 dqZCgrxl2VTt/pJhL/zxDQhBnMH7xar/H+AXQwoilQDsu52YOohmjYrLEcspzMMYpbG3
 zvE6EMQ+SnwDiRNWpx8Du4TrV5MxQNLvAzB7ceA7z2UqBdAv33ELsxt2UYEc7j2JKQL7
 TMw/XsTsG6dZ6qwQItwH9O06MPfN110qMX+Ztdc4n4si+YpCcQD4NFVTNh6xeNsM/E3K
 0I/Q==
X-Gm-Message-State: AOJu0YwIInp9luTkKEtFC1muZi5hkFshPif8KqTj0YSLJhStL07u6fSv
 HpepR5sXxHx72pRiZwN78ZMUnDKkVPGkEW103IUzs7QxT2r2ega98m0Njg8aiRnyOeger5xfYTk
 VOXTlDnof4J12WlUrSgydrcwa0pQjoii/7AYhG8gRkBHRPsucmVAHwA4FTIvbs1gyQu+ShrVNWd
 P3mHj5S39LCuUcwtJjjY18qIBsd77zVbMDq/SFkgs=
X-Gm-Gg: ASbGncuUiH3LHyLEVdcHLwNK4FZFHj2QOAG+CTcSkaR0i/4Mo3kMjAMZvyA3nE9/ytC
 SfL20rNXpFjTMUQFCy1H4zSyPW3Z5iyYxvC6SHj9SUkqoVQo78mQe+OPJb4HlW9LNDm/K1OGg5I
 cd5xVQ4Mj2ghAeuZfT2fFJuYSFJVFxnHAQWY06n6/TUCb2f3H9ISgLi3yENKEhJUJ96t2ZSB154
 99YgRNVROqcG/XmbDtWJ4ZXsmAElP9LxkRpepXshh/F826pVakv6xRz5mCrJG1Z7d/XHf56+gut
 z6h0MNs6L1o=
X-Received: by 2002:a05:600c:3151:b0:439:94f8:fc79 with SMTP id
 5b1f17b1804b1-43994f8ff8amr43241085e9.0.1739897886535; 
 Tue, 18 Feb 2025 08:58:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG6ew07qNpMw7anK7VSYWZS4aOV9frfzDHS1EHc3araPK0lbx+ORmHeS3BCQINYWtXc9N481Q==
X-Received: by 2002:a05:600c:3151:b0:439:94f8:fc79 with SMTP id
 5b1f17b1804b1-43994f8ff8amr43240715e9.0.1739897886060; 
 Tue, 18 Feb 2025 08:58:06 -0800 (PST)
Received: from [192.168.10.48] ([176.206.122.109])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f259d5eeesm15689490f8f.63.2025.02.18.08.58.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Feb 2025 08:58:03 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH 4/7] target/riscv: cpu: store max SATP mode as a single integer
Date: Tue, 18 Feb 2025 17:57:54 +0100
Message-ID: <20250218165757.554178-5-pbonzini@redhat.com>
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

The maximum available SATP mode implies all the shorter virtual address sizes.
Store it in RISCVCPUConfig and avoid recomputing it via satp_mode_max_from_map.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/riscv/cpu_cfg.h     |  1 +
 target/riscv/cpu.c         | 11 +++++------
 target/riscv/tcg/tcg-cpu.c |  3 ++-
 3 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index b410b1e6038..28d8de978fa 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -192,6 +192,7 @@ struct RISCVCPUConfig {
     bool short_isa_string;
 
 #ifndef CONFIG_USER_ONLY
+    int8_t max_satp_mode;
     RISCVSATPMap satp_mode;
 #endif
 };
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 7950b6447f8..2d06543217a 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -444,6 +444,7 @@ static void set_satp_mode_max_supported(RISCVCPU *cpu,
     }
 
     assert(cpu->cfg.satp_mode.supported & (1 << satp_mode));
+    cpu->cfg.max_satp_mode = satp_mode;
 }
 
 /* Set the satp mode to the max supported */
@@ -1177,16 +1178,13 @@ static void riscv_cpu_disas_set_info(CPUState *s, disassemble_info *info)
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
@@ -1215,10 +1213,10 @@ static void riscv_cpu_satp_mode_finalize(RISCVCPU *cpu, Error **errp)
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
 
@@ -1477,6 +1475,7 @@ static void riscv_cpu_init(Object *obj)
     cpu->cfg.cbom_blocksize = 64;
     cpu->cfg.cbop_blocksize = 64;
     cpu->cfg.cboz_blocksize = 64;
+    cpu->cfg.max_satp_mode = -1;
     cpu->env.vext_ver = VEXT_VERSION_1_00_0;
 }
 
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 0a137281de1..a9f59a67e00 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -693,8 +693,9 @@ static bool riscv_cpu_validate_profile_satp(RISCVCPU *cpu,
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
2.48.1


