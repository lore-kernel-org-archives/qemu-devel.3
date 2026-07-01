Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4311C43602
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 10:21:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wes2G-0002TM-R9; Wed, 01 Jul 2026 06:19:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wes2E-0002KX-W6
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 06:19:15 -0400
Received: from mail-dl1-x1236.google.com ([2607:f8b0:4864:20::1236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wes2D-0004mw-Bf
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 06:19:14 -0400
Received: by mail-dl1-x1236.google.com with SMTP id
 a92af1059eb24-1390f75d8bbso824403c88.0
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2026 03:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782901152; x=1783505952; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4+OwQNthO4GGjeh+jELwW/MnL7i6J35yeuhzee2BgvE=;
 b=YI8y6HXZl9wO192EiS/g/gtQEOAPf1kus4EJpa3Yd6TYd6IF32i8j+zMDadBovjbuC
 ntz3s34//64AvS95t6/4nRKlKi/M86Jz3lcnOtgu+4BczoJcJSzxUSmm8GHkkVs7flPf
 /yziH/YWQ3naQ+qJ0csYsrSQZPC9Vt102YnDszYVSsNElunP40xVm5dLuZutOsuALQol
 so8bzcAu4PksSUPyfvnAjaeLI/8bF0p12bAR66r5KmPayIH8pfaIpMBPfWxO3ZbmRXZl
 z/p5rHrSFZpqfmonSuemzwHHK45YXnRxHfgu+j0gZ+QvxjdQgeaaB8hO+I718KaLhyTM
 vNTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782901152; x=1783505952;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4+OwQNthO4GGjeh+jELwW/MnL7i6J35yeuhzee2BgvE=;
 b=lT+EbX89jp080RjGPWPYaZMn+xKXZKvxKncRmOw+6smT6F9F38RW7wilJ7GmldNeB0
 QJdgyWnuE+9FSk4xKbI7eUA/+ZslePGML3IAQLoqaY3oLTzp61Cbx5PuEpMtfQyjTPS+
 pBCCA4gjPpUoYdk9qp62hQzLmAOlNh52x45wPaHOLnfivzYWVRJd9Ta0UYK1xwu+0FZf
 jz9nvxuWynFhBuE4NY/qiPTsxBLvlICv/XjaNh173RGlLrk8JJ2QHwsV/e5Y4lClcdYR
 pFCUcG7AR2gLkZiKFOAL/Wteew21vWgFNQCPg6k5Baz8ZlFYH6ImBj8wGL3sSLUr6u5S
 Lfhw==
X-Gm-Message-State: AOJu0YwJv99EfCdIs6IYbO78Q0T52alCkyTUAq8bqr9UN+CrWHG0v8qx
 hjBbAfj3frnCnZrW98GBbZBdE6j57+6Kgdp2K/Vmd+0EAykxHT3xMCvJ1mubTw==
X-Gm-Gg: AfdE7cn9TfFjt1MDhmYQvKYLar4kJuoenegIA81TMoY5cymTWGdOopS3eEHTZo98TDz
 EDinryO7jIoDsLZzpnkYc7fW/EUSeiItUTsoyCMDlXckdjaJJ7rjv6yOmXOBptphFD3zmgjTXk/
 wV4fPgkfVjvW1jN0UzGINLvm/FVZJEqbOoXlbrGJQQ8sOe7lElzjGElGcIUZPWtoJa0YFIeAU2W
 xp0rtD3DDmsHgJ516LgbTfBslxAcCDxGrU9ECB52m4zt0RN2OnfL1UnJk39adsNQe4SU/q/e1Jk
 +QEUoZYu4RVnLqd7BDbPL0hMBFK0y3bYMVPj82VT91348/I8JKqliWU9Qds83cBAguOjvtJYxjS
 w7DsSgAxM6vnjB3rlrzoJmIbOaBh0kh7FZYqnfaAGp8zP2qnTy+gPHOs/vJuXuvQaDW6Nrqtk6s
 N9Q2QjL+GsGFymNahszZn/4NWT00fTBrJ3C5WjD47wKQ==
X-Received: by 2002:a05:7022:238d:b0:139:e497:a805 with SMTP id
 a92af1059eb24-13b36d86482mr1055058c88.10.1782901151854; 
 Wed, 01 Jul 2026 03:19:11 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b2ab2e0e3sm19355047c88.7.2026.07.01.03.19.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 03:19:11 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, SeungJu Cheon <suunj1331@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 21/39] target/riscv: Apply UXL WARL handling to vsstatus
Date: Wed,  1 Jul 2026 20:17:34 +1000
Message-ID: <20260701101752.2522962-22-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260701101752.2522962-1-alistair.francis@wdc.com>
References: <20260701101752.2522962-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1236;
 envelope-from=alistair23@gmail.com; helo=mail-dl1-x1236.google.com
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

From: SeungJu Cheon <suunj1331@gmail.com>

write_mstatus() already handles the reserved UXL value by writing a
legal value instead.

Apply the same handling when writing vsstatus so that reserved UXL
values follow the same WARL behavior.

Factor the common logic into a local helper riscv_write_uxl() and use
it for both mstatus and vsstatus.

Suggested-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Fixes: f310df58bd2 ("target/riscv: Enable uxl field write")
Signed-off-by: SeungJu Cheon <suunj1331@gmail.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Message-ID: <20260625081521.595683-1-suunj1331@gmail.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/csr.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 7fb0ad5bc1..7168a4dc12 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -2021,6 +2021,20 @@ static target_ulong legalize_mpp(CPURISCVState *env, target_ulong old_mpp,
     return val;
 }
 
+static uint64_t riscv_write_uxl(CPURISCVState *env, uint64_t val,
+                                uint64_t field)
+{
+    RISCVMXL xl = riscv_cpu_mxl(env);
+    uint64_t uxl = get_field(val, field);
+
+    if (uxl == MXL_RV128) {
+        uxl = xl == MXL_RV128 ? MXL_RV64 : xl;
+        val = set_field(val, field, uxl);
+    }
+
+    return val;
+}
+
 static RISCVException write_mstatus(CPURISCVState *env, int csrno,
                                     target_ulong val, uintptr_t ra)
 {
@@ -2067,17 +2081,8 @@ static RISCVException write_mstatus(CPURISCVState *env, int csrno,
 
     if (xl != MXL_RV32 || env->debugger) {
         if ((val & MSTATUS64_UXL) != 0) {
-            uint64_t uxl = val & MSTATUS64_UXL >> 32;
             mask |= MSTATUS64_UXL;
-
-            /*
-             * uxl = 3 is reserved so write the current xl instead.
-             * In case xl = MXL_RV128 (3) write MXL_RV64.
-             */
-            if (uxl == 3) {
-                uxl = xl == MXL_RV128 ? MXL_RV64 : xl;
-                val = deposit64(val, 32, 2, uxl);
-            }
+            val = riscv_write_uxl(env, val, MSTATUS64_UXL);
         }
     }
 
@@ -5239,6 +5244,8 @@ static RISCVException write_vsstatus(CPURISCVState *env, int csrno,
     uint64_t mask = (target_ulong)-1;
     if ((val & VSSTATUS64_UXL) == 0) {
         mask &= ~VSSTATUS64_UXL;
+    } else {
+        val = riscv_write_uxl(env, val, VSSTATUS64_UXL);
     }
     if ((env->henvcfg & HENVCFG_DTE)) {
         if ((val & SSTATUS_SDT) != 0) {
-- 
2.54.0


