Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBB47E68952
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 04:01:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6MGK-0007Mj-Gd; Wed, 30 Oct 2024 23:54:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t6MGI-0007M8-5B
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 23:54:18 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t6MGG-0003wY-Df
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 23:54:17 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-20c714cd9c8so5782715ad.0
 for <qemu-devel@nongnu.org>; Wed, 30 Oct 2024 20:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730346855; x=1730951655; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HvHndEIaR1hHXVQ49EQ5dLHaTlYB46mZYAbDe9hCdeQ=;
 b=GzYGZMT4iQd3IgFlGWxGIFUo3rg7wdLI0wioF2oaLHsZXz/paQQSEokKRpMLCEDLU+
 c6cATtsZ2WBxTgFqwcHmNlrTAtoguIdB6Hb6nZuJTSUtOG6mEq7aew/wVPR9yxiKM8c2
 XTAamSNGwy8J81m5rU4ccjreQbUsc93OQmf/TXVTr2MmFZOm3s3JkFzU1FexkyiYzs1B
 6nZC4yBE04GU4MV7TtoY3iwNhUl2O70KhkxQJoIn1TA5VlFWLNAQTsOnv3tAXshtm+3C
 EB9jpkXREnK5x9onloUwqum0ufPbcmh2D2QaR3XlsMWg/E6MDN6zEPoJub3nBeetbBxE
 mp4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730346855; x=1730951655;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HvHndEIaR1hHXVQ49EQ5dLHaTlYB46mZYAbDe9hCdeQ=;
 b=gvQKTlHvPovcIf8DEMXEaWrSaIgeXtPbFfAYl7l54KZx3Ceeml04ByQFH3UjgjIyqQ
 XxUdOHmMp8YvsGXzFuTcJ0mfkp/RLssnAna+2FaueJkcEooZi095wrT9GyyW4ToSkNmL
 +7x4wW3uZisREITxYMpGBBV9G/sLGtQ13qn38N5i91Glyiq5VJ9uH0llxvPZOJbpDwz0
 cwEmOV7BEeORV4CJTTRSeAopg+W+hgvyjoz4TT6Qyor3A/Vvkiqnkz43brZs4iy9Yx7Q
 kPnr/AK1qLWaDNgtKXSb6zEQ+1u+brelUZ1UFG8zbOymfTD+D6+GkFqoKcuNNkeBYAZS
 8XLw==
X-Gm-Message-State: AOJu0Yyk7oHUVdCOsaYw4HnaaSnuBr+Z7RjWKWwN7mh1EHTlw11x4Mnd
 hIcGqdNXIF/V8NJ1MIORc/8PaN7Utyz5uGSHEBrkxd0HWlvWxjBJTRh4YVdE
X-Google-Smtp-Source: AGHT+IF8vguwJRn/S/5S9k7HIqfjJ2ev9JGySXmzlJdP724znFQcnZnIZmbnppDgIKezE5ePOJ45CQ==
X-Received: by 2002:a17:903:41ce:b0:20c:9821:69b6 with SMTP id
 d9443c01a7336-210c6ca1ba9mr238892585ad.58.1730346854836; 
 Wed, 30 Oct 2024 20:54:14 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21105707064sm3022795ad.70.2024.10.30.20.54.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Oct 2024 20:54:14 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Deepak Gupta <debug@rivosinc.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 16/50] target/riscv: expose *envcfg csr and priv to qemu-user
 as well
Date: Thu, 31 Oct 2024 13:52:44 +1000
Message-ID: <20241031035319.731906-17-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241031035319.731906-1-alistair.francis@wdc.com>
References: <20241031035319.731906-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Deepak Gupta <debug@rivosinc.com>

Execution environment config CSR controlling user env and current
privilege state shouldn't be limited to qemu-system only. *envcfg
CSRs control enabling of features in next lesser mode. In some cases
bits *envcfg CSR can be lit up by kernel as part of kernel policy or
software (user app) can choose to opt-in by issuing a system call
(e.g. prctl). In case of qemu-user, it should be no different because
qemu is providing underlying execution environment facility and thus
either should provide some default value in *envcfg CSRs or react to
system calls (prctls) initiated from application. priv is set to PRV_U
and menvcfg/senvcfg set to 0 for qemu-user on reest.

`henvcfg` has been left for qemu-system only because it is not expected
that someone will use qemu-user where application is expected to have
hypervisor underneath which is controlling its execution environment. If
such a need arises then `henvcfg` could be exposed as well.

Relevant discussion:
https://lore.kernel.org/all/CAKmqyKOTVWPFep2msTQVdUmJErkH+bqCcKEQ4hAnyDFPdWKe0Q@mail.gmail.com/

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20241008225010.1861630-2-debug@rivosinc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h | 9 +++++----
 target/riscv/cpu.c | 5 +++++
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index a63a29744c..b7b082833d 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -234,8 +234,12 @@ struct CPUArchState {
     uint32_t elf_flags;
 #endif
 
-#ifndef CONFIG_USER_ONLY
     target_ulong priv;
+    /* CSRs for execution environment configuration */
+    uint64_t menvcfg;
+    target_ulong senvcfg;
+
+#ifndef CONFIG_USER_ONLY
     /* This contains QEMU specific information about the virt state. */
     bool virt_enabled;
     target_ulong geilen;
@@ -445,12 +449,9 @@ struct CPUArchState {
     target_ulong upmmask;
     target_ulong upmbase;
 
-    /* CSRs for execution environment configuration */
-    uint64_t menvcfg;
     uint64_t mstateen[SMSTATEEN_MAX_COUNT];
     uint64_t hstateen[SMSTATEEN_MAX_COUNT];
     uint64_t sstateen[SMSTATEEN_MAX_COUNT];
-    target_ulong senvcfg;
     uint64_t henvcfg;
 #endif
     target_ulong cur_pmmask;
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 2a78cd639b..f0e32c4e6e 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1004,7 +1004,12 @@ static void riscv_cpu_reset_hold(Object *obj, ResetType type)
     }
 
     pmp_unlock_entries(env);
+#else
+    env->priv = PRV_U;
+    env->senvcfg = 0;
+    env->menvcfg = 0;
 #endif
+
     env->xl = riscv_cpu_mxl(env);
     riscv_cpu_update_mask(env);
     cs->exception_index = RISCV_EXCP_NONE;
-- 
2.47.0


