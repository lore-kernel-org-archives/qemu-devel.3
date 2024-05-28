Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02E4FC25B74
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 02:47:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBmqs-00075l-Qu; Mon, 27 May 2024 22:46:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sBmqF-00062A-CY
 for qemu-devel@nongnu.org; Mon, 27 May 2024 22:45:43 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sBmqD-00045N-Fc
 for qemu-devel@nongnu.org; Mon, 27 May 2024 22:45:35 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-6fbbd937719so241728b3a.0
 for <qemu-devel@nongnu.org>; Mon, 27 May 2024 19:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716864332; x=1717469132; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b2k2JrhvujZewE6TU0J5JDl6R03TzuPE/F+i9deQBKY=;
 b=nhoWgsmRtOrXM0ToJIn6UIrUrqInSIoRfnvFppZZeCVrl/jPNmePGJOWafOgm2SNRe
 77cnFKoZxoe/8GPMxkIcPWyRRQ1jRk3zflUR9YUEpyTyCQg/EUBBObpldLan7SsLa+Mk
 W8vQDVQB0EtGn9vSzgMNVwYGYuGcx2NEyVo0OfBg7FVk/ffzmCo7ez3NO3XaL5O/wOSR
 WuVQ8MZGJXHjshOA4vUpw2IF0U07NeSPWDxPCh65sUf4PyuS0pnSt00oovhBAWzXb+lB
 e4zylc95RcYlGSPVpFjfLXkI/HgWP2gR5e2r+8zdEW1TWdgT3NRMwQyNkl97bayoAwel
 3GSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716864332; x=1717469132;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b2k2JrhvujZewE6TU0J5JDl6R03TzuPE/F+i9deQBKY=;
 b=t+YXusN/yh4TlCmpvb3+qLPHA9rVjV+PvPfZxjRUkD6Wlt4trUDMoqmL9wFCLdqOGs
 wPUvv/zZqvPZLUvSmE7zbovJaW3kUV+y0T/UV5B92ggg7TKnjzladdFmU+EYl4KdhREQ
 fgED6kjHBsIzhjb+BqUUjTA4OFtNIDY0s8JxmJuZq+g1GLzpT+upy+6e9bWFTv702z6U
 cvsIhySZDSR41cl+jCVrAD6Rajcd4+VWe2XcThuUzMMoweQFHgsK+y67uJb+jD770XX3
 doz6EpK+Pn5zrjfjrF36gfZBa/rtdW2fN3eyG8rUiOL2Vc+bVtNMhzTO8t6X+5mGaXSU
 ghsA==
X-Gm-Message-State: AOJu0YxpamDCgY7IxmtSgEkzCfSLTiNs7bmtUXNJy6p5v6kvYXGVuW1S
 wBCyBPvoABA29FY+WUfeq9DC+WY/yeS2eypZI4CL4jO9UvqU5rVukuedhQ==
X-Google-Smtp-Source: AGHT+IHipy1f+6W3GSLixn+9pEXwaqtvUdyqFVajNwwfuW3zR1wnfGlMOVEmG/V2bglD+qPnM+07cg==
X-Received: by 2002:a05:6a20:9d92:b0:1ae:4264:a324 with SMTP id
 adf61e73a8af0-1b212cc77cdmr13293992637.11.1716864331796; 
 Mon, 27 May 2024 19:45:31 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f44c970ca0sm70733225ad.142.2024.05.27.19.45.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 May 2024 19:45:31 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Yu-Ming Chang <yumin686@andestech.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 28/28] target/riscv: raise an exception when CSRRS/CSRRC writes
 a read-only CSR
Date: Tue, 28 May 2024 12:43:28 +1000
Message-ID: <20240528024328.246965-29-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240528024328.246965-1-alistair.francis@wdc.com>
References: <20240528024328.246965-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20240403070823.80897-1-yumin686@andestech.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h       |  4 ++++
 target/riscv/csr.c       | 51 ++++++++++++++++++++++++++++++++++++----
 target/riscv/op_helper.c |  6 ++---
 3 files changed, 53 insertions(+), 8 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 12d8b5344a..1501868008 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -709,6 +709,8 @@ void cpu_get_tb_cpu_state(CPURISCVState *env, vaddr *pc,
 void riscv_cpu_update_mask(CPURISCVState *env);
 bool riscv_cpu_is_32bit(RISCVCPU *cpu);
 
+RISCVException riscv_csrr(CPURISCVState *env, int csrno,
+                          target_ulong *ret_value);
 RISCVException riscv_csrrw(CPURISCVState *env, int csrno,
                            target_ulong *ret_value,
                            target_ulong new_value, target_ulong write_mask);
@@ -741,6 +743,8 @@ typedef RISCVException (*riscv_csr_op_fn)(CPURISCVState *env, int csrno,
                                           target_ulong new_value,
                                           target_ulong write_mask);
 
+RISCVException riscv_csrr_i128(CPURISCVState *env, int csrno,
+                               Int128 *ret_value);
 RISCVException riscv_csrrw_i128(CPURISCVState *env, int csrno,
                                 Int128 *ret_value,
                                 Int128 new_value, Int128 write_mask);
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 58ef7079dc..57f831fedc 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -4322,7 +4322,7 @@ static RISCVException rmw_seed(CPURISCVState *env, int csrno,
 
 static inline RISCVException riscv_csrrw_check(CPURISCVState *env,
                                                int csrno,
-                                               bool write_mask)
+                                               bool write)
 {
     /* check privileges and return RISCV_EXCP_ILLEGAL_INST if check fails */
     bool read_only = get_field(csrno, 0xC00) == 3;
@@ -4344,7 +4344,7 @@ static inline RISCVException riscv_csrrw_check(CPURISCVState *env,
     }
 
     /* read / write check */
-    if (write_mask && read_only) {
+    if (write && read_only) {
         return RISCV_EXCP_ILLEGAL_INST;
     }
 
@@ -4431,11 +4431,22 @@ static RISCVException riscv_csrrw_do64(CPURISCVState *env, int csrno,
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
@@ -4483,13 +4494,45 @@ static RISCVException riscv_csrrw_do128(CPURISCVState *env, int csrno,
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
diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index 2baf5bc3ca..84fb2a35e5 100644
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
2.45.1


