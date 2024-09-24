Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2913CF9C69
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2024 22:20:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stDrl-0004p2-BQ; Tue, 24 Sep 2024 18:18:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1stDrj-0004iq-Gz
 for qemu-devel@nongnu.org; Tue, 24 Sep 2024 18:18:39 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1stDrh-0001ed-SD
 for qemu-devel@nongnu.org; Tue, 24 Sep 2024 18:18:39 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-71923d87be4so4471552b3a.0
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2024 15:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727216316; x=1727821116; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xjMX0n2N8UfEbuXbMv3IJfDU6NZ0SzEy7mgfMIEmHQU=;
 b=JoExYGdBqCnFzxII5SOpuruwiVme6+Jq9I84rWByvNmSGaVm8xRQ+WhVwRYmKCA/lc
 e1pNjMz+jNA07gWlTsfPloDTPkA3ARhUx88JZ0AcNqDUfkxwDvlWPcQnM6gURpmz0Glz
 nCZK2JdZ9WiSR+PBHX8MEL52noNf297x+yo92unPq3juXjT2xWV2aiAB+iaxFbr1XRq8
 o/i/7PjwhW+KElaE3U5IXdleG59fcwbi+0G3bb5pcdmJo2poOFt1mGck3nJOmzbZM1Cl
 4hC7tf/tOy7eNZBDblI2+hLN/PR6F+R01t9BsiSjabWiEJS1zXWcIwnljv3sHY64Crsy
 XbIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727216316; x=1727821116;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xjMX0n2N8UfEbuXbMv3IJfDU6NZ0SzEy7mgfMIEmHQU=;
 b=Yq9Fu6+W9ggRgipclJ+2qLJXj5hm/jvcjR9rXe6vqaxG0cTwtE9jwyNs6fm27HgF/w
 4zG4G5kgaJFB2Q4yPx9DbjRynd8tynda7WGHEiDXtBSjI2MVY7tKBafTedPdBNT5hpvL
 fll/thvTKAywC4ZYUyxOm3qFu5CXkS+BS2LevU4O/fKAqtuotSze5quNtTKAhzwhBFnT
 qDb2EO3bN9T9p7X8QjWautvL+Ah7LZvo3pc+6bW0YMmIVSGjhb9kI+Ug4YNH+KqkzfkU
 a+D2k8zjfcRQmEJLKtyvQi341uxpGcZzOc993euB5Eq/U7uD1N8KtjZ/3K6oROv1L71j
 c2hQ==
X-Gm-Message-State: AOJu0YxMuT+l2t5xgCf35OXXN8ZcZVAnVnFUp3gKVljTFG+2jvBhDiRg
 Nsk+5b4FxUeAfJcV1BupLU8AphBx26UhkL6MmD+y00luZNF8fPOMGvOv8g==
X-Google-Smtp-Source: AGHT+IFy+Ga6+noaJ5Utbls/GemTAu1bX3OArstDmVtya4F6SSPwC3qLFAYUJg3ICipLVtGoW1mO8Q==
X-Received: by 2002:a05:6a00:2e91:b0:714:20a8:d79f with SMTP id
 d2e1a72fcca58-71b0aae9862mr1154008b3a.14.1727216316300; 
 Tue, 24 Sep 2024 15:18:36 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71afc8342easm1665310b3a.11.2024.09.24.15.18.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Sep 2024 15:18:35 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Alvin Chang <alvinga@andestech.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 12/47] target/riscv: Preliminary textra trigger CSR writting
 support
Date: Wed, 25 Sep 2024 08:17:13 +1000
Message-ID: <20240924221751.2688389-13-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20240924221751.2688389-1-alistair.francis@wdc.com>
References: <20240924221751.2688389-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x432.google.com
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

From: Alvin Chang <alvinga@andestech.com>

This commit allows program to write textra trigger CSR for type 2, 3, 6
triggers. In this preliminary patch, the textra.MHVALUE and the
textra.MHSELECT fields are allowed to be configured. Other fields, such
as textra.SBYTEMASK, textra.SVALUE, and textra.SSELECT, are hardwired to
zero for now.

For textra.MHSELECT field, the only legal values are 0 (ignore) and 4
(mcontext). Writing 1~3 into textra.MHSELECT will be changed to 0, and
writing 5~7 into textra.MHSELECT will be changed to 4. This behavior is
aligned to RISC-V SPIKE simulator.

Signed-off-by: Alvin Chang <alvinga@andestech.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20240826024657.262553-2-alvinga@andestech.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_bits.h | 10 ++++++
 target/riscv/debug.c    | 69 +++++++++++++++++++++++++++++++++++++----
 2 files changed, 73 insertions(+), 6 deletions(-)

diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index 32b068f18a..7e3f629356 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -947,6 +947,16 @@ typedef enum RISCVException {
 #define JVT_BASE                           (~0x3F)
 
 /* Debug Sdtrig CSR masks */
+#define TEXTRA32_MHVALUE                   0xFC000000
+#define TEXTRA32_MHSELECT                  0x03800000
+#define TEXTRA32_SBYTEMASK                 0x000C0000
+#define TEXTRA32_SVALUE                    0x0003FFFC
+#define TEXTRA32_SSELECT                   0x00000003
+#define TEXTRA64_MHVALUE                   0xFFF8000000000000ULL
+#define TEXTRA64_MHSELECT                  0x0007000000000000ULL
+#define TEXTRA64_SBYTEMASK                 0x000000F000000000ULL
+#define TEXTRA64_SVALUE                    0x00000003FFFFFFFCULL
+#define TEXTRA64_SSELECT                   0x0000000000000003ULL
 #define MCONTEXT32                         0x0000003F
 #define MCONTEXT64                         0x0000000000001FFFULL
 #define MCONTEXT32_HCONTEXT                0x0000007F
diff --git a/target/riscv/debug.c b/target/riscv/debug.c
index 0b5099ff9a..d6b4a06144 100644
--- a/target/riscv/debug.c
+++ b/target/riscv/debug.c
@@ -217,6 +217,66 @@ static inline void warn_always_zero_bit(target_ulong val, target_ulong mask,
     }
 }
 
+static target_ulong textra_validate(CPURISCVState *env, target_ulong tdata3)
+{
+    target_ulong mhvalue, mhselect;
+    target_ulong mhselect_new;
+    target_ulong textra;
+    const uint32_t mhselect_no_rvh[8] = { 0, 0, 0, 0, 4, 4, 4, 4 };
+
+    switch (riscv_cpu_mxl(env)) {
+    case MXL_RV32:
+        mhvalue  = get_field(tdata3, TEXTRA32_MHVALUE);
+        mhselect = get_field(tdata3, TEXTRA32_MHSELECT);
+        /* Validate unimplemented (always zero) bits */
+        warn_always_zero_bit(tdata3, (target_ulong)TEXTRA32_SBYTEMASK,
+                             "sbytemask");
+        warn_always_zero_bit(tdata3, (target_ulong)TEXTRA32_SVALUE,
+                             "svalue");
+        warn_always_zero_bit(tdata3, (target_ulong)TEXTRA32_SSELECT,
+                             "sselect");
+        break;
+    case MXL_RV64:
+    case MXL_RV128:
+        mhvalue  = get_field(tdata3, TEXTRA64_MHVALUE);
+        mhselect = get_field(tdata3, TEXTRA64_MHSELECT);
+        /* Validate unimplemented (always zero) bits */
+        warn_always_zero_bit(tdata3, (target_ulong)TEXTRA64_SBYTEMASK,
+                             "sbytemask");
+        warn_always_zero_bit(tdata3, (target_ulong)TEXTRA64_SVALUE,
+                             "svalue");
+        warn_always_zero_bit(tdata3, (target_ulong)TEXTRA64_SSELECT,
+                             "sselect");
+        break;
+    default:
+        g_assert_not_reached();
+    }
+
+    /* Validate mhselect. */
+    mhselect_new = mhselect_no_rvh[mhselect];
+    if (mhselect != mhselect_new) {
+        qemu_log_mask(LOG_UNIMP, "mhselect only supports 0 or 4 for now\n");
+    }
+
+    /* Write legal values into textra */
+    textra = 0;
+    switch (riscv_cpu_mxl(env)) {
+    case MXL_RV32:
+        textra = set_field(textra, TEXTRA32_MHVALUE,  mhvalue);
+        textra = set_field(textra, TEXTRA32_MHSELECT, mhselect_new);
+        break;
+    case MXL_RV64:
+    case MXL_RV128:
+        textra = set_field(textra, TEXTRA64_MHVALUE,  mhvalue);
+        textra = set_field(textra, TEXTRA64_MHSELECT, mhselect_new);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+
+    return textra;
+}
+
 static void do_trigger_action(CPURISCVState *env, target_ulong trigger_index)
 {
     trigger_action_t action = get_trigger_action(env, trigger_index);
@@ -441,8 +501,7 @@ static void type2_reg_write(CPURISCVState *env, target_ulong index,
         }
         break;
     case TDATA3:
-        qemu_log_mask(LOG_UNIMP,
-                      "tdata3 is not supported for type 2 trigger\n");
+        env->tdata3[index] = textra_validate(env, val);
         break;
     default:
         g_assert_not_reached();
@@ -558,8 +617,7 @@ static void type6_reg_write(CPURISCVState *env, target_ulong index,
         }
         break;
     case TDATA3:
-        qemu_log_mask(LOG_UNIMP,
-                      "tdata3 is not supported for type 6 trigger\n");
+        env->tdata3[index] = textra_validate(env, val);
         break;
     default:
         g_assert_not_reached();
@@ -741,8 +799,7 @@ static void itrigger_reg_write(CPURISCVState *env, target_ulong index,
                       "tdata2 is not supported for icount trigger\n");
         break;
     case TDATA3:
-        qemu_log_mask(LOG_UNIMP,
-                      "tdata3 is not supported for icount trigger\n");
+        env->tdata3[index] = textra_validate(env, val);
         break;
     default:
         g_assert_not_reached();
-- 
2.46.1


