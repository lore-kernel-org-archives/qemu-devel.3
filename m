Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47BB5C54799
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 11:07:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHKnV-0007bM-IE; Tue, 20 May 2025 07:06:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uHKnK-0007RZ-OB
 for qemu-devel@nongnu.org; Tue, 20 May 2025 07:06:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uHKnJ-00033Y-5X
 for qemu-devel@nongnu.org; Tue, 20 May 2025 07:06:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747739160;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kEA8gwAABu9nmeknGeEHK1bKLRjIK+6tDEYM+UBOQHw=;
 b=GJejuWXvQQBnKPXUmvKibw0U7Gy6RMmg/Rsmtf/qb99Q2gAoF4MkTbhjbxh00+I9aQKFPr
 6fAgEnxxSKsOMRhOHEerQRP9or7p/y25yDaOD1fzYdW45lWSfALDotv8zaGv/r+j4N4s0X
 c89Nhnc0EWszUyfuyvrQA7JfqY8PIYk=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-175-jlYsvj8PNjydM_k__wj8nw-1; Tue, 20 May 2025 07:05:59 -0400
X-MC-Unique: jlYsvj8PNjydM_k__wj8nw-1
X-Mimecast-MFC-AGG-ID: jlYsvj8PNjydM_k__wj8nw_1747739158
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-60214f89ce0so366267a12.3
 for <qemu-devel@nongnu.org>; Tue, 20 May 2025 04:05:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747739157; x=1748343957;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kEA8gwAABu9nmeknGeEHK1bKLRjIK+6tDEYM+UBOQHw=;
 b=m1VVCQbA1zQX3S0LZlydChC9jb6cFRtz/ZHPnSqQjaBnQnI177HnKWjVkAhehYe/t3
 7jgcY2hv1k8po5Ti1N9E58iDJJabA3x2xm/GcukX61C7wQQs4peTyq3K5qk/g1K5R0/N
 kMrZ+1nMbx1moqmy5jCO2B00xwb5s4tyTXFu/HvD2pulawKL0P0ShaCl9IFys7xZ5deK
 xDEvevOh0l3pW9ztjgnTXba48w8JUETV0AheX0rCIJpJ5zmC2NnfgJxvAkVTpNO2eV+/
 aJ2xe6p89xQl6JIH1ROz4qlUEpYsiJOZbnCRD6AImvJpHv3oVT8TrLW+lT/gvR0zMvQD
 tFfg==
X-Gm-Message-State: AOJu0Yye0kGc6gbxqcqkV83HbZpDF6ouJ2fVZTjxWjKPhBxf8FmKR1/+
 UPhtqsKOTWBFjizo0cN/t+mq0QrHTQdhCzRSMhZXisp6aJHZN0PaRmRerQNzuvPjN4qeCvuYkyr
 Mldb7fy+R9nzAIXK1b0GDuswpLPBaxcpvQz42ez9JNH4LVo5oOKRZ4tHBSJP7u4u2RxmlgoEjkl
 xXeGUV1lzfF3eqyagPVZvp6sgYT3SBpv8LP+jvYM3V
X-Gm-Gg: ASbGncui5N5tq6JBxUW/9mk5qGz/sweRDxdGODSDpEwU/LpkaSirPZ3+C21EgckrxkR
 U4bmWaB4Tv6GUSijBpIfRzwh2xrwEum4k0Jshh7p/JlUXv0FpjOo5MmtyYTE76vN/+rHzGbtltC
 A7xW4vAAPxDjT2jZJ6yMGfP1BKxvG+6MH7hfHgEnNOQPK5YoChw8qEjEgRYy/I6/soJS4op1dse
 6GAvTp7TVBtOOVtr7AlUPZfs66GCcM8Qi09tA3fyWAPleMafv0C0bdTDNKMTcia2BmCXkAgensQ
 mjN8v2LYa7ZJxg==
X-Received: by 2002:a05:6402:26cd:b0:601:d9f4:eac6 with SMTP id
 4fb4d7f45d1cf-601d9f4eef5mr7385086a12.21.1747739156941; 
 Tue, 20 May 2025 04:05:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IETTXRCwUdIKJvLsbDAW52kqK1Gn+07//37dM5DQzJmY6Sn1AO6XWGNk13vsvYRtfcDCMH3MQ==
X-Received: by 2002:a05:6402:26cd:b0:601:d9f4:eac6 with SMTP id
 4fb4d7f45d1cf-601d9f4eef5mr7385051a12.21.1747739156449; 
 Tue, 20 May 2025 04:05:56 -0700 (PDT)
Received: from [192.168.122.1] ([151.95.46.79])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6005a6dfbc3sm6991310a12.33.2025.05.20.04.05.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 May 2025 04:05:53 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 11/35] target/riscv: cpu: store max SATP mode as a single
 integer
Date: Tue, 20 May 2025 13:05:06 +0200
Message-ID: <20250520110530.366202-12-pbonzini@redhat.com>
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

The maximum available SATP mode implies all the shorter virtual address sizes.
Store it in RISCVCPUConfig and avoid recomputing it via satp_mode_max_from_map.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/riscv/cpu_cfg.h     |  1 +
 target/riscv/cpu.c         | 11 +++++------
 target/riscv/tcg/tcg-cpu.c |  3 ++-
 3 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index cfe371b829d..c8ea5cdc870 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -196,6 +196,7 @@ struct RISCVCPUConfig {
 
     bool short_isa_string;
 
+    int8_t max_satp_mode;
     RISCVSATPMap satp_mode;
 };
 
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 0f7ce5305be..32c283a6628 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -446,6 +446,7 @@ static void set_satp_mode_max_supported(RISCVCPU *cpu,
     }
 
     assert(cpu->cfg.satp_mode.supported & (1 << satp_mode));
+    cpu->cfg.max_satp_mode = satp_mode;
 }
 
 /* Set the satp mode to the max supported */
@@ -1172,16 +1173,13 @@ static void riscv_cpu_disas_set_info(CPUState *s, disassemble_info *info)
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
@@ -1210,10 +1208,10 @@ static void riscv_cpu_satp_mode_finalize(RISCVCPU *cpu, Error **errp)
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
 
@@ -1473,6 +1471,7 @@ static void riscv_cpu_init(Object *obj)
     cpu->cfg.cbop_blocksize = 64;
     cpu->cfg.cboz_blocksize = 64;
     cpu->env.vext_ver = VEXT_VERSION_1_00_0;
+    cpu->cfg.max_satp_mode = -1;
 }
 
 static void riscv_bare_cpu_init(Object *obj)
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 55e00972b79..ab8659f3044 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -816,8 +816,9 @@ static bool riscv_cpu_validate_profile_satp(RISCVCPU *cpu,
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


