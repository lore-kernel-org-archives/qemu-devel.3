Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17F80C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 02:57:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi1Pv-0008CK-0R; Thu, 09 Jul 2026 22:56:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wi1Pj-000818-74
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 22:56:31 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wi1Ph-0008OY-DU
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 22:56:30 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-c9cf07d2df6so328573a12.2
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 19:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783652188; x=1784256988; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=pSuW8MjfijZqJWGJeed7hqsn4Ni7xmuv6NtzFEQILRc=;
 b=SzEx7z4hf5JGjij5A0El/TD2vdJB7S/KY6uhG9vUJujeRxP0JGQ1UeOqOPIYyAMeSi
 JpkBqT/G5uwpAzkrLZYdjl766508ZUjSSJtCSOP2qcmAOLL18iX2VEP0dqFqsPrtUArg
 R16BwKKXH7VEvS9qTEBIJxPy/TFtGHM6MSyghj7p8nCMFf2BdFptxZ7uT9yHJFVu7X3l
 wqkSEo4zyMoTkASFVZ55Z4fTAuaqNP9iPJvIpeIcgboDAaBOzDZrSxaX6VyxDJwDswQ+
 XcQd35iyAI8AUg5IbpfUuW3rWTQRUEUUlpsV5DxEwgZY/lBzNowVafJ1zP4PpRGSOfjK
 zG5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783652188; x=1784256988;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pSuW8MjfijZqJWGJeed7hqsn4Ni7xmuv6NtzFEQILRc=;
 b=sUBjGv/q60J00wRhL92meOgKuHXjw3CKtyPZZ3jsApQiEo3ZZ3NXu7XKpLpwC7dGQn
 XCnQd2Z45UbVMbx2SiSe9NhXJ1qJYQUQEpQk4jne+2uzGJFKo+1dIrpuC1KOqazAj+p7
 HlKsL88QAQy6vW3bQVauNUzNPxU7TELpbkId275nMQx8EZHe7VhKFQ2tuYwr7qkoLMvx
 nyppUmq1WPAHZWVk2Y4pW4jdXcoJE1KbuPcLiKU2nkNVxOqiyz8BCbvErmJBISWyD0Yt
 IZnzUVJL3iDGiXwQin2c8Hn/PsT2Prheu1XKVc67T+nxjiwj8gV5ys4O+nb3FgAqcaxx
 Dzpw==
X-Gm-Message-State: AOJu0YzP12e+nIq+oz1xj6knMb1KyeWZX63OM3RMnKgNbDt8kJ2GJsLc
 7xJcMGW1jV3f7VXJLbG7RPt17V1lvpqqhAJjYBVefYTCe+Sxv8i3lbtOrAAEoQ==
X-Gm-Gg: AfdE7ckDVXuSCThQO/RXLa3xQ923QGDiQ3MMcEtAnzYMGbvBqjIjKI6AmObP3xKs8VL
 1QEzl26naHE6li1KI8yQgyRQBBIP9sEr/SLGGmmLEmD+CCd4QXisu5XLnFHqVRYdFW8SMFwsLUC
 7ln+iPsQiYndQdTfnmKaJfBWYTB70kP7EyamCnZhi9wmbO3W/pAVCIfxPchBtWhXhDS80zbajgO
 8OrghYxE29ABcDT7T17BfNdq4CF5/khbbK9alVqlZnReDaP4ZDq3+xtWRIgrOdQNT1aM8CAGaoW
 3t0U4iRtvvCurvLkk60hs+sBhrN7oAzvvC4puH3q6CwRM7h2THW26bdB4/Yjx8sTWC7ldJrPkaz
 xkrvi/zE02Wzsk86oIU7jVR+9ex0iOllZrsO2Y3KcESH2r+8scAD3YQ/M/li+Jzl38V3tZVhUdg
 BLyahp52jCl0qK9dxxajm12qidzRcJgJuLS8Rq4k/8Fw==
X-Received: by 2002:a05:6a21:495:b0:3c0:9c18:d5a2 with SMTP id
 adf61e73a8af0-3c0bd19f15fmr11930909637.63.1783652187511; 
 Thu, 09 Jul 2026 19:56:27 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-ca5af6e04fcsm4576769a12.4.2026.07.09.19.56.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 19:56:26 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 15/40] target/riscv: remove csr.h from kvm-cpu.c
Date: Fri, 10 Jul 2026 12:55:00 +1000
Message-ID: <20260710025525.1704417-16-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260710025525.1704417-1-alistair.francis@wdc.com>
References: <20260710025525.1704417-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x530.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

Move riscv_new_csr_seed from csr.c to cpu.c since this function is
shared with KVM.  With that we can remove the csr.h from kvm-cpu.c.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260703180538.3346781-10-daniel.barboza@oss.qualcomm.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h         |  3 ++-
 target/riscv/csr.h         |  3 ---
 target/riscv/cpu.c         | 30 ++++++++++++++++++++++++++++++
 target/riscv/kvm/kvm-cpu.c |  1 -
 target/riscv/tcg/csr.c     | 29 -----------------------------
 5 files changed, 32 insertions(+), 34 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 18fbd4edb6..a8c7e21bec 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -970,7 +970,8 @@ void riscv_add_satp_mode_properties(Object *obj);
 bool riscv_cpu_accelerator_compatible(RISCVCPU *cpu);
 
 void riscv_cpu_register_gdb_regs_for_features(CPUState *cs);
-
+target_ulong riscv_new_csr_seed(target_ulong new_value,
+                                target_ulong write_mask);
 const char *satp_mode_str(uint8_t satp_mode, bool is_32_bit);
 
 const char *priv_spec_to_str(int priv_version);
diff --git a/target/riscv/csr.h b/target/riscv/csr.h
index 66ec9546ed..53ba3b4a4d 100644
--- a/target/riscv/csr.h
+++ b/target/riscv/csr.h
@@ -12,9 +12,6 @@
 #include "exec/target_long.h"
 #include "cpu_bits.h"
 
-target_ulong riscv_new_csr_seed(target_ulong new_value,
-                                target_ulong write_mask);
-
 RISCVException riscv_csrr(CPURISCVState *env, int csrno,
                           target_ulong *ret_value);
 
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index a2887adf16..ba75c0de39 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -21,6 +21,7 @@
 #include "qemu/qemu-print.h"
 #include "qemu/ctype.h"
 #include "qemu/log.h"
+#include "qemu/guest-random.h"
 #include "cpu.h"
 #include "cpu_vendorid.h"
 #include "target/riscv/csr.h"
@@ -556,6 +557,35 @@ static void riscv_register_custom_csrs(RISCVCPU *cpu, const RISCVCSR *csr_list)
 }
 #endif
 
+/* Used by csr.c and the KVM driver */
+target_ulong riscv_new_csr_seed(target_ulong new_value,
+                                target_ulong write_mask)
+{
+    uint16_t random_v;
+    Error *random_e = NULL;
+    int random_r;
+    target_ulong rval;
+
+    random_r = qemu_guest_getrandom(&random_v, 2, &random_e);
+    if (unlikely(random_r < 0)) {
+        /*
+         * Failed, for unknown reasons in the crypto subsystem.
+         * The best we can do is log the reason and return a
+         * failure indication to the guest.  There is no reason
+         * we know to expect the failure to be transitory, so
+         * indicate DEAD to avoid having the guest spin on WAIT.
+         */
+        qemu_log_mask(LOG_UNIMP, "%s: Crypto failure: %s",
+                      __func__, error_get_pretty(random_e));
+        error_free(random_e);
+        rval = SEED_OPST_DEAD;
+    } else {
+        rval = random_v | SEED_OPST_ES16;
+    }
+
+    return rval;
+}
+
 static ObjectClass *riscv_cpu_class_by_name(const char *cpu_model)
 {
     ObjectClass *oc;
diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 2a5440d584..dfcd6e3c77 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -31,7 +31,6 @@
 #include "system/kvm.h"
 #include "system/kvm_int.h"
 #include "cpu.h"
-#include "target/riscv/csr.h"
 #include "trace.h"
 #include "accel/accel-cpu-target.h"
 #include "hw/pci/pci.h"
diff --git a/target/riscv/tcg/csr.c b/target/riscv/tcg/csr.c
index 36d12b6a51..9c7e9d0e4b 100644
--- a/target/riscv/tcg/csr.c
+++ b/target/riscv/tcg/csr.c
@@ -29,7 +29,6 @@
 #include "exec/icount.h"
 #include "accel/tcg/cpu-loop.h"
 #include "accel/tcg/getpc.h"
-#include "qemu/guest-random.h"
 #include "qapi/error.h"
 #include "tcg/insn-start-words.h"
 #include "internals.h"
@@ -5572,34 +5571,6 @@ static RISCVException write_mnstatus(CPURISCVState *env, int csrno,
 #endif
 
 /* Crypto Extension */
-target_ulong riscv_new_csr_seed(target_ulong new_value,
-                                target_ulong write_mask)
-{
-    uint16_t random_v;
-    Error *random_e = NULL;
-    int random_r;
-    target_ulong rval;
-
-    random_r = qemu_guest_getrandom(&random_v, 2, &random_e);
-    if (unlikely(random_r < 0)) {
-        /*
-         * Failed, for unknown reasons in the crypto subsystem.
-         * The best we can do is log the reason and return a
-         * failure indication to the guest.  There is no reason
-         * we know to expect the failure to be transitory, so
-         * indicate DEAD to avoid having the guest spin on WAIT.
-         */
-        qemu_log_mask(LOG_UNIMP, "%s: Crypto failure: %s",
-                      __func__, error_get_pretty(random_e));
-        error_free(random_e);
-        rval = SEED_OPST_DEAD;
-    } else {
-        rval = random_v | SEED_OPST_ES16;
-    }
-
-    return rval;
-}
-
 static RISCVException rmw_seed(CPURISCVState *env, int csrno,
                                target_ulong *ret_value,
                                target_ulong new_value,
-- 
2.54.0


