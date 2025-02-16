Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9910FC021A6
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2025 00:03:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjS6L-0007fR-PL; Sat, 15 Feb 2025 19:01:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjS68-0007by-KZ
 for qemu-devel@nongnu.org; Sat, 15 Feb 2025 19:01:26 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjS62-0006Fv-Pu
 for qemu-devel@nongnu.org; Sat, 15 Feb 2025 19:01:22 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-220c92c857aso51555325ad.0
 for <qemu-devel@nongnu.org>; Sat, 15 Feb 2025 16:01:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739664076; x=1740268876; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MkSZ1z/mYS0WLY38Nj4nOWztbQOUR5F30WqULi7ciuM=;
 b=LEo8SR4pzxdc1x7ebYDX+LtSHcspcWV/tZOa1bTTmzbvUgDkP/7yUQpK+GfK1fm3RK
 Voo6db6Bh1M3v9im9mNk1TSE/9zAb8GA4CTg4wJL6ruTWKXlxMBRHFHVG2Ar3QjN9hYi
 EY8/rI3JFfwghFispupcuHEMOZ7J+ntAR1IkrAEuuN284/94N6lq78y5UrvOCm305FGl
 lUnBR8RfMRWDtbDHvIT/XeVD3Dw/Ti8C9U5TezMxrU2WwdSszV/O4WEJnPRojefuNybC
 UDP04EmZWIKkDMEx+ZmfOssuBqf/XgPOpIkUEWbPeFMCxszOCVVaPbJdNJJB9z6lMHYk
 8Iiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739664076; x=1740268876;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MkSZ1z/mYS0WLY38Nj4nOWztbQOUR5F30WqULi7ciuM=;
 b=wACLadwcTCiYSCEwVUfV19ETWNNc3Lj8wqaOOpeVcYcClUkY0PfGPSkEl+eDMfZNGl
 U7lhmrY3ZK+UTJcqBfdSSPsYtlwCCMQZFZXDxK4961mSSYk9tMb4DVXtDoEesIy4K0mA
 jIkmD6CV8LFJ66YTKGqa/tRY3uZRPe6ov2Xv7ybRE1KvybYIRINXHuzh5Cz4yuY8Aw0f
 JoJxqhZ09yT+rXDbelOttCsj62FjYJefR5hipZVv24CFHZYzQbRCGmTzL0ykhCRsJo6J
 BMV4d/POhqda2Cw0U8/Dfp2q/Km+Pxy038YRWBd0SeVh19XB7SnIAwd0uNuxrXB0Ho+t
 OvhA==
X-Gm-Message-State: AOJu0YyqZWlh/7S6qbxkK50YrSC18W7KxewFJGm8EnEww5cftgqBT7q/
 LJ+JzFAmKeinbuskp3vJxf8EoxSW+7uB8tTwqsBKkQRRnzUJGSq4OFf4pi4ZLv6pP5Q7P/bfqiG
 3
X-Gm-Gg: ASbGncslBLXfS/VSyqfw36VraIV0CqGS1qQ1/pKbH4IIYvlW0Ea1iC/J5QNzkxSd7lD
 xfOdHFoLdNh8LNDlBEP9TLqWFP/vnOAA3/HyKhJ/mCZXqaLnvpQttrQYUTntZFhsM2MdAmYXOCG
 Oby5Li5qpf14uCaVuts1MXpgZfa1c8yGAVBfK/D1aG/T2nSWqURirNbk24PIYt+VdLj0JHk5I68
 17rGwVDMY3JTFSy7uy7hRfdhYtymJfF7edq2aY/nL/h4twKykQkrVa37PcZWJpS/Cl9hOpzbxxo
 dWLQsbstk1oKrL77cIGRj1mkTF/m6K91HJo9bMY7ecsSouA=
X-Google-Smtp-Source: AGHT+IFJ95ZEV3qp3XQ8P9Bt/ySbbFZzYjIlkCrcGY2z/MpAups+vGfPGpuCgZZntv+64bjK+cJwJg==
X-Received: by 2002:a17:902:f64f:b0:215:6c5f:d142 with SMTP id
 d9443c01a7336-2210460c80dmr60409995ad.20.1739664075872; 
 Sat, 15 Feb 2025 16:01:15 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d5366729sm48960315ad.79.2025.02.15.16.01.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Feb 2025 16:01:15 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 06/24] tcg/i386: Drop addrhi from prepare_host_addr
Date: Sat, 15 Feb 2025 16:00:50 -0800
Message-ID: <20250216000109.2606518-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216000109.2606518-1-richard.henderson@linaro.org>
References: <20250216000109.2606518-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

The guest address will now always fit in one register.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/i386/tcg-target.c.inc | 56 ++++++++++++++-------------------------
 1 file changed, 20 insertions(+), 36 deletions(-)

diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index ca6e8abc57..b33fe7fe23 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -2169,8 +2169,7 @@ static inline int setup_guest_base_seg(void)
  * is required and fill in @h with the host address for the fast path.
  */
 static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
-                                           TCGReg addrlo, TCGReg addrhi,
-                                           MemOpIdx oi, bool is_ld)
+                                           TCGReg addr, MemOpIdx oi, bool is_ld)
 {
     TCGLabelQemuLdst *ldst = NULL;
     MemOp opc = get_memop(oi);
@@ -2184,7 +2183,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
     } else {
         *h = x86_guest_base;
     }
-    h->base = addrlo;
+    h->base = addr;
     h->aa = atom_and_align_for_opc(s, opc, MO_ATOM_IFALIGN, s_bits == MO_128);
     a_mask = (1 << h->aa.align) - 1;
 
@@ -2202,8 +2201,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
         ldst = new_ldst_label(s);
         ldst->is_ld = is_ld;
         ldst->oi = oi;
-        ldst->addrlo_reg = addrlo;
-        ldst->addrhi_reg = addrhi;
+        ldst->addrlo_reg = addr;
 
         if (TCG_TARGET_REG_BITS == 64) {
             ttype = s->addr_type;
@@ -2217,7 +2215,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
             }
         }
 
-        tcg_out_mov(s, tlbtype, TCG_REG_L0, addrlo);
+        tcg_out_mov(s, tlbtype, TCG_REG_L0, addr);
         tcg_out_shifti(s, SHIFT_SHR + tlbrexw, TCG_REG_L0,
                        s->page_bits - CPU_TLB_ENTRY_BITS);
 
@@ -2233,10 +2231,10 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
          * check that we don't cross pages for the complete access.
          */
         if (a_mask >= s_mask) {
-            tcg_out_mov(s, ttype, TCG_REG_L1, addrlo);
+            tcg_out_mov(s, ttype, TCG_REG_L1, addr);
         } else {
             tcg_out_modrm_offset(s, OPC_LEA + trexw, TCG_REG_L1,
-                                 addrlo, s_mask - a_mask);
+                                 addr, s_mask - a_mask);
         }
         tlb_mask = s->page_mask | a_mask;
         tgen_arithi(s, ARITH_AND + trexw, TCG_REG_L1, tlb_mask, 0);
@@ -2250,17 +2248,6 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
         ldst->label_ptr[0] = s->code_ptr;
         s->code_ptr += 4;
 
-        if (TCG_TARGET_REG_BITS == 32 && s->addr_type == TCG_TYPE_I64) {
-            /* cmp 4(TCG_REG_L0), addrhi */
-            tcg_out_modrm_offset(s, OPC_CMP_GvEv, addrhi,
-                                 TCG_REG_L0, cmp_ofs + 4);
-
-            /* jne slow_path */
-            tcg_out_opc(s, OPC_JCC_long + JCC_JNE, 0, 0, 0);
-            ldst->label_ptr[1] = s->code_ptr;
-            s->code_ptr += 4;
-        }
-
         /* TLB Hit.  */
         tcg_out_ld(s, TCG_TYPE_PTR, TCG_REG_L0, TCG_REG_L0,
                    offsetof(CPUTLBEntry, addend));
@@ -2270,11 +2257,10 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
         ldst = new_ldst_label(s);
         ldst->is_ld = is_ld;
         ldst->oi = oi;
-        ldst->addrlo_reg = addrlo;
-        ldst->addrhi_reg = addrhi;
+        ldst->addrlo_reg = addr;
 
         /* jne slow_path */
-        jcc = tcg_out_cmp(s, TCG_COND_TSTNE, addrlo, a_mask, true, false);
+        jcc = tcg_out_cmp(s, TCG_COND_TSTNE, addr, a_mask, true, false);
         tcg_out_opc(s, OPC_JCC_long + jcc, 0, 0, 0);
         ldst->label_ptr[0] = s->code_ptr;
         s->code_ptr += 4;
@@ -2446,13 +2432,12 @@ static void tcg_out_qemu_ld_direct(TCGContext *s, TCGReg datalo, TCGReg datahi,
 }
 
 static void tcg_out_qemu_ld(TCGContext *s, TCGReg datalo, TCGReg datahi,
-                            TCGReg addrlo, TCGReg addrhi,
-                            MemOpIdx oi, TCGType data_type)
+                            TCGReg addr, MemOpIdx oi, TCGType data_type)
 {
     TCGLabelQemuLdst *ldst;
     HostAddress h;
 
-    ldst = prepare_host_addr(s, &h, addrlo, addrhi, oi, true);
+    ldst = prepare_host_addr(s, &h, addr, oi, true);
     tcg_out_qemu_ld_direct(s, datalo, datahi, h, data_type, get_memop(oi));
 
     if (ldst) {
@@ -2574,13 +2559,12 @@ static void tcg_out_qemu_st_direct(TCGContext *s, TCGReg datalo, TCGReg datahi,
 }
 
 static void tcg_out_qemu_st(TCGContext *s, TCGReg datalo, TCGReg datahi,
-                            TCGReg addrlo, TCGReg addrhi,
-                            MemOpIdx oi, TCGType data_type)
+                            TCGReg addr, MemOpIdx oi, TCGType data_type)
 {
     TCGLabelQemuLdst *ldst;
     HostAddress h;
 
-    ldst = prepare_host_addr(s, &h, addrlo, addrhi, oi, false);
+    ldst = prepare_host_addr(s, &h, addr, oi, false);
     tcg_out_qemu_st_direct(s, datalo, datahi, h, get_memop(oi));
 
     if (ldst) {
@@ -2880,34 +2864,34 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         break;
 
     case INDEX_op_qemu_ld_i32:
-        tcg_out_qemu_ld(s, a0, -1, a1, -1, a2, TCG_TYPE_I32);
+        tcg_out_qemu_ld(s, a0, -1, a1, a2, TCG_TYPE_I32);
         break;
     case INDEX_op_qemu_ld_i64:
         if (TCG_TARGET_REG_BITS == 64) {
-            tcg_out_qemu_ld(s, a0, -1, a1, -1, a2, TCG_TYPE_I64);
+            tcg_out_qemu_ld(s, a0, -1, a1, a2, TCG_TYPE_I64);
         } else {
-            tcg_out_qemu_ld(s, a0, a1, a2, -1, args[3], TCG_TYPE_I64);
+            tcg_out_qemu_ld(s, a0, a1, a2, args[3], TCG_TYPE_I64);
         }
         break;
     case INDEX_op_qemu_ld_i128:
         tcg_debug_assert(TCG_TARGET_REG_BITS == 64);
-        tcg_out_qemu_ld(s, a0, a1, a2, -1, args[3], TCG_TYPE_I128);
+        tcg_out_qemu_ld(s, a0, a1, a2, args[3], TCG_TYPE_I128);
         break;
 
     case INDEX_op_qemu_st_i32:
     case INDEX_op_qemu_st8_i32:
-        tcg_out_qemu_st(s, a0, -1, a1, -1, a2, TCG_TYPE_I32);
+        tcg_out_qemu_st(s, a0, -1, a1, a2, TCG_TYPE_I32);
         break;
     case INDEX_op_qemu_st_i64:
         if (TCG_TARGET_REG_BITS == 64) {
-            tcg_out_qemu_st(s, a0, -1, a1, -1, a2, TCG_TYPE_I64);
+            tcg_out_qemu_st(s, a0, -1, a1, a2, TCG_TYPE_I64);
         } else {
-            tcg_out_qemu_st(s, a0, a1, a2, -1, args[3], TCG_TYPE_I64);
+            tcg_out_qemu_st(s, a0, a1, a2, args[3], TCG_TYPE_I64);
         }
         break;
     case INDEX_op_qemu_st_i128:
         tcg_debug_assert(TCG_TARGET_REG_BITS == 64);
-        tcg_out_qemu_st(s, a0, a1, a2, -1, args[3], TCG_TYPE_I128);
+        tcg_out_qemu_st(s, a0, a1, a2, args[3], TCG_TYPE_I128);
         break;
 
     OP_32_64(mulu2):
-- 
2.43.0


