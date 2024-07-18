Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69271C3DA63
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 02:14:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUGd6-0004O6-Oa; Wed, 17 Jul 2024 22:12:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sUGcc-0001Vd-BH
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 22:11:55 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sUGcY-0003fg-Nr
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 22:11:53 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1fbc3a9d23bso2490445ad.1
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2024 19:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721268708; x=1721873508; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pAgirqH2Ot9O6D3Yz4SqckgbcQJk1Uq7k4mObStrXEM=;
 b=KkZ2kKZmexEEr0Apy1+DIekjzYF6x3Pao63zgScd6Zjw5LSMz1/KchZ+srF6iefcFV
 JMLeEpLEhK+h/dFqDradjKpU9tCt9DPiRCgexz1BNWgvh6Uo06CoLw4apEDR2urmMzea
 iIGHB0mPj+7LE3L304qLsAfzUpaiL8o1KPkBJGqr3p/5ngMxD6yZ6eeYhkUDkFl4CNXz
 XuK1rBpgGd4B/rvjCVxm0M2JnNaiB/P13rWgP41LAjh7B5D0U/6d/1UmDNgtFv0OgCuD
 eHcSoGNweN/0NWCq3XR7lNorxtWCHQEksIgLVA6J2VK6e/OH2o1kCek5lzTOGnHZglh6
 mZmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721268708; x=1721873508;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pAgirqH2Ot9O6D3Yz4SqckgbcQJk1Uq7k4mObStrXEM=;
 b=KCV0NEUbriGjJDNRigl7uZhMLM11iHSGKp9mutHd2rbua4OeGdBQ9fcnpzzM8Bo+bV
 D/P/XZxzuJuMEqe6NifNqW8zp/N467OayUkbMR0meqjkehtJzc+2ZIZimNNHnFggimqR
 lu+KHdY+SsoSCw5n6ihx1wDqi9fSv/iRi5TAySOQ+BHk6JoKXshPrxaZ8cVKFYB5b95v
 utmeUK6TLxfKV1tOfGiflrUMvaUcdZb3SV+I0D+5RF6o6zsi2A5G5fPvKCbQC+xhJUyH
 qwbi493Z6hU/oWMDysuGqpFZXiwTfLGyXA4uRaXQUgm31FimtyhmM5HT7D+xhgV+ydQ/
 utAQ==
X-Gm-Message-State: AOJu0Yx5oCQaz8i6vgXEXs119TwTR8txaqRHEgXo3hlEmuxs7lP0YMYg
 QPLyJQ/J8tNavr7XIMFjdfpToCkk9ZMEQYmkM7jzV/RvZmyT2Awy/SNNzTy4
X-Google-Smtp-Source: AGHT+IHFrcc/nip3JPuvUYqLiqX8ceMXpcYcPcSjcHJUNYereqBFz9jjFnEY7FIvD0rQXGUQep413Q==
X-Received: by 2002:a17:902:ecd0:b0:1fb:64da:b135 with SMTP id
 d9443c01a7336-1fc4e67c521mr32525255ad.42.1721268707582; 
 Wed, 17 Jul 2024 19:11:47 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fc0bba949bsm81999385ad.69.2024.07.17.19.11.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jul 2024 19:11:46 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Yu-Ming Chang <yumin686@andestech.com>,
 Alvin Chang <alvinga@andestech.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 28/30] target/riscv: raise an exception when CSRRS/CSRRC writes
 a read-only CSR
Date: Thu, 18 Jul 2024 12:10:10 +1000
Message-ID: <20240718021012.2057986-29-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240718021012.2057986-1-alistair.francis@wdc.com>
References: <20240718021012.2057986-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62e.google.com
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

From: Yu-Ming Chang <yumin686@andestech.com>

Both CSRRS and CSRRC always read the addressed CSR and cause any read side
effects regardless of rs1 and rd fields. Note that if rs1 specifies a register
holding a zero value other than x0, the instruction will still attempt to write
the unmodified value back to the CSR and will cause any attendant side effects.

So if CSRRS or CSRRC tries to write a read-only CSR with rs1 which specifies
a register holding a zero value, an illegal instruction exception should be
raised.

Signed-off-by: Yu-Ming Chang <yumin686@andestech.com>
Signed-off-by: Alvin Chang <alvinga@andestech.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <172100444279.18077.6893072378718059541-0@git.sr.ht>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h       |  4 +++
 target/riscv/csr.c       | 57 ++++++++++++++++++++++++++++++++++++----
 target/riscv/op_helper.c |  6 ++---
 3 files changed, 58 insertions(+), 9 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 093c86b8b9..1619c3acb6 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -751,6 +751,8 @@ void cpu_get_tb_cpu_state(CPURISCVState *env, vaddr *pc,
 void riscv_cpu_update_mask(CPURISCVState *env);
 bool riscv_cpu_is_32bit(RISCVCPU *cpu);
 
+RISCVException riscv_csrr(CPURISCVState *env, int csrno,
+                          target_ulong *ret_value);
 RISCVException riscv_csrrw(CPURISCVState *env, int csrno,
                            target_ulong *ret_value,
                            target_ulong new_value, target_ulong write_mask);
@@ -783,6 +785,8 @@ typedef RISCVException (*riscv_csr_op_fn)(CPURISCVState *env, int csrno,
                                           target_ulong new_value,
                                           target_ulong write_mask);
 
+RISCVException riscv_csrr_i128(CPURISCVState *env, int csrno,
+                               Int128 *ret_value);
 RISCVException riscv_csrrw_i128(CPURISCVState *env, int csrno,
                                 Int128 *ret_value,
                                 Int128 new_value, Int128 write_mask);
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 781ef27eba..ea3560342c 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -4624,7 +4624,7 @@ static RISCVException rmw_seed(CPURISCVState *env, int csrno,
 
 static inline RISCVException riscv_csrrw_check(CPURISCVState *env,
                                                int csrno,
-                                               bool write_mask)
+                                               bool write)
 {
     /* check privileges and return RISCV_EXCP_ILLEGAL_INST if check fails */
     bool read_only = get_field(csrno, 0xC00) == 3;
@@ -4646,7 +4646,7 @@ static inline RISCVException riscv_csrrw_check(CPURISCVState *env,
     }
 
     /* read / write check */
-    if (write_mask && read_only) {
+    if (write && read_only) {
         return RISCV_EXCP_ILLEGAL_INST;
     }
 
@@ -4733,11 +4733,22 @@ static RISCVException riscv_csrrw_do64(CPURISCVState *env, int csrno,
     return RISCV_EXCP_NONE;
 }
 
+RISCVException riscv_csrr(CPURISCVState *env, int csrno,
+                           target_ulong *ret_value)
+{
+    RISCVException ret = riscv_csrrw_check(env, csrno, false);
+    if (ret != RISCV_EXCP_NONE) {
+        return ret;
+    }
+
+    return riscv_csrrw_do64(env, csrno, ret_value, 0, 0);
+}
+
 RISCVException riscv_csrrw(CPURISCVState *env, int csrno,
                            target_ulong *ret_value,
                            target_ulong new_value, target_ulong write_mask)
 {
-    RISCVException ret = riscv_csrrw_check(env, csrno, write_mask);
+    RISCVException ret = riscv_csrrw_check(env, csrno, true);
     if (ret != RISCV_EXCP_NONE) {
         return ret;
     }
@@ -4785,13 +4796,45 @@ static RISCVException riscv_csrrw_do128(CPURISCVState *env, int csrno,
     return RISCV_EXCP_NONE;
 }
 
+RISCVException riscv_csrr_i128(CPURISCVState *env, int csrno,
+                               Int128 *ret_value)
+{
+    RISCVException ret;
+
+    ret = riscv_csrrw_check(env, csrno, false);
+    if (ret != RISCV_EXCP_NONE) {
+        return ret;
+    }
+
+    if (csr_ops[csrno].read128) {
+        return riscv_csrrw_do128(env, csrno, ret_value,
+                                 int128_zero(), int128_zero());
+    }
+
+    /*
+     * Fall back to 64-bit version for now, if the 128-bit alternative isn't
+     * at all defined.
+     * Note, some CSRs don't need to extend to MXLEN (64 upper bits non
+     * significant), for those, this fallback is correctly handling the
+     * accesses
+     */
+    target_ulong old_value;
+    ret = riscv_csrrw_do64(env, csrno, &old_value,
+                           (target_ulong)0,
+                           (target_ulong)0);
+    if (ret == RISCV_EXCP_NONE && ret_value) {
+        *ret_value = int128_make64(old_value);
+    }
+    return ret;
+}
+
 RISCVException riscv_csrrw_i128(CPURISCVState *env, int csrno,
                                 Int128 *ret_value,
                                 Int128 new_value, Int128 write_mask)
 {
     RISCVException ret;
 
-    ret = riscv_csrrw_check(env, csrno, int128_nz(write_mask));
+    ret = riscv_csrrw_check(env, csrno, true);
     if (ret != RISCV_EXCP_NONE) {
         return ret;
     }
@@ -4830,7 +4873,11 @@ RISCVException riscv_csrrw_debug(CPURISCVState *env, int csrno,
 #if !defined(CONFIG_USER_ONLY)
     env->debugger = true;
 #endif
-    ret = riscv_csrrw(env, csrno, ret_value, new_value, write_mask);
+    if (!write_mask) {
+        ret = riscv_csrr(env, csrno, ret_value);
+    } else {
+        ret = riscv_csrrw(env, csrno, ret_value, new_value, write_mask);
+    }
 #if !defined(CONFIG_USER_ONLY)
     env->debugger = false;
 #endif
diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index ec1408ba0f..25a5263573 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -51,7 +51,7 @@ target_ulong helper_csrr(CPURISCVState *env, int csr)
     }
 
     target_ulong val = 0;
-    RISCVException ret = riscv_csrrw(env, csr, &val, 0, 0);
+    RISCVException ret = riscv_csrr(env, csr, &val);
 
     if (ret != RISCV_EXCP_NONE) {
         riscv_raise_exception(env, ret, GETPC());
@@ -84,9 +84,7 @@ target_ulong helper_csrrw(CPURISCVState *env, int csr,
 target_ulong helper_csrr_i128(CPURISCVState *env, int csr)
 {
     Int128 rv = int128_zero();
-    RISCVException ret = riscv_csrrw_i128(env, csr, &rv,
-                                          int128_zero(),
-                                          int128_zero());
+    RISCVException ret = riscv_csrr_i128(env, csr, &rv);
 
     if (ret != RISCV_EXCP_NONE) {
         riscv_raise_exception(env, ret, GETPC());
-- 
2.45.2


