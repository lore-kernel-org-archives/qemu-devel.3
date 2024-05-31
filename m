Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45890C27C4F
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 17:46:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sD6KB-00021t-47; Fri, 31 May 2024 13:45:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1sD6Jx-0001ul-FM
 for qemu-devel@nongnu.org; Fri, 31 May 2024 13:45:44 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1sD6Ju-0007fg-Tp
 for qemu-devel@nongnu.org; Fri, 31 May 2024 13:45:41 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1f62a628b4cso12636575ad.1
 for <qemu-devel@nongnu.org>; Fri, 31 May 2024 10:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1717177536; x=1717782336; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=USFoNRQZ4JeBfsf5SGx5N9OQ/v8517aQy/lRnAVzBe4=;
 b=ETkdgQ6U18k2lsNHHT565TsJA53p2kKmxmA7XpaOLuf5B6A9eDmd8UZeDEQykj5SGp
 CwtIRoBdQ0Uqqp5INxktGie9vwngesoNWCpVhQO47rYErHUi7gVvXDi9xVb8jHTgCtvI
 aQtm1vDQ2Nmt1PhL+bdM9t8FlN0Z800RBtY2CcF6CN30eWJ2DLiBPVGD7d91Ut7b6hDP
 qJ4n0LFbRjI/YxdcOTaBJ+DGuCCa25WIhK+iNWSwm50e5E5Xbu3iVkfMHCkNbMuKirTx
 vjFBWK4OMpTRT2eef0OYWmgqa8fd+hoS0d1+q3OZf1mdaMVFujoWeJB6z2dMJC/XjZd/
 nHtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717177536; x=1717782336;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=USFoNRQZ4JeBfsf5SGx5N9OQ/v8517aQy/lRnAVzBe4=;
 b=C3q0dzlaIfv3Hku3Ksn838ptYrlp3A/xWXwOV1L0x63f0UCiH9oHbHFPll5BCwNw2s
 DYKTeAycvzMgAnZWQ/81geidj0fbts456jyL3SvaoZAZJ9kWtaWUKI1+EAvo2flBEWeg
 Z+KqVPs2ZvZ2FxUvnxA6irx/j2DdVkP6Uh/wOFqlB8hpma8kIvIOl4WvYVUBXCxxZGi1
 il3O8kwFLJ3Bdzd2ZB4n3CKLG4hjBKgMPNqZeao06gwBu/ArScALUjF+qxbC76jOLlk7
 FZTaxxyi60EpDzzyA6erU8JerABSC9M5noSs1hmCY3D8CaXVh8MPHyJf+OKh/TcAqZKs
 Bqqg==
X-Gm-Message-State: AOJu0YyWvGe/q1aySq92JeD95aJ4gGynLTS1scNNNRRvPcejJKFN7Rp7
 /fNQuR5SAE35hsUxOHZOV83RzeTIO4lVs1/L5DQE0tZedhIm1PNkz9E4ZLsSf6XPN1v4Ksg7xwu
 uuGV8/iR5IOYWwO1zbT3Sjm17N+7hNYZ5p4z1018F7H3ny5Lr0U95/VpDTxkh43GqBEa63kR6US
 wLmA//VranruNm56ZVFnyXPW7rxUCIVVTDFym4cQ==
X-Google-Smtp-Source: AGHT+IFOytKgGcIwhycDTkjN3u3UrI7ejFH27Zz0XVNEoWlUGGCQYnvJc5JDHxbCZRuqO+fH+b72Eg==
X-Received: by 2002:a17:902:d4d0:b0:1f4:f02f:cb14 with SMTP id
 d9443c01a7336-1f6370a0c13mr32942015ad.47.1717177536013; 
 Fri, 31 May 2024 10:45:36 -0700 (PDT)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f63236ce6dsm19389875ad.95.2024.05.31.10.45.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 May 2024 10:45:35 -0700 (PDT)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: dbarboza@ventanamicro.com, Max Chou <max.chou@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [RFC PATCH v2 5/6] target/riscv: rvv: Optimize v[l|s]e8.v with
 limitations
Date: Sat,  1 Jun 2024 01:44:52 +0800
Message-Id: <20240531174504.281461-6-max.chou@sifive.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240531174504.281461-1-max.chou@sifive.com>
References: <20240531174504.281461-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=max.chou@sifive.com; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

The vector unit-stride load/store instructions (e.g. vle8.v/vse8.v)
perform continuous load/store. We can replace the corresponding helper
functions by TCG ops to copy more data at a time with following
assumptions:

* Perform virtual address resolution once for entire vector at beginning
* Without mask
* Without tail agnostic
* Both host and target are little endian

Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/insn_trans/trans_rvv.c.inc | 197 +++++++++++++++++++++++-
 1 file changed, 195 insertions(+), 2 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
index 1e4fa797a86..bbac73bb12b 100644
--- a/target/riscv/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/insn_trans/trans_rvv.c.inc
@@ -714,7 +714,105 @@ static bool ld_us_check(DisasContext *s, arg_r2nfvm* a, uint8_t eew)
            vext_check_load(s, a->rd, a->nf, a->vm, eew);
 }
 
-GEN_VEXT_TRANS(vle8_v,  MO_8,  r2nfvm, ld_us_op, ld_us_check)
+static bool trans_vle8_v(DisasContext *s, arg_r2nfvm * a)
+{
+
+    if (ld_us_check(s, a, MO_8)) {
+        if (!HOST_BIG_ENDIAN && s->vstart_eq_zero && s->vta == 0 && a->vm) {
+            uint32_t vofs = vreg_ofs(s, a->rd);
+            uint32_t midx = s->mem_idx;
+
+            TCGv_i64 t0, t1;
+            TCGv_i128 t16;
+            TCGv_ptr tp;
+            TCGv_ptr i = tcg_temp_new_ptr();
+            TCGv len_remain = tcg_temp_new();
+            TCGv rs1 = get_gpr(s, a->rs1, EXT_NONE);
+            TCGv addr = tcg_temp_new();
+
+            TCGLabel *loop_128 = gen_new_label();
+            TCGLabel *remain_64 = gen_new_label();
+            TCGLabel *remain_32 = gen_new_label();
+            TCGLabel *remain_16 = gen_new_label();
+            TCGLabel *remain_8 = gen_new_label();
+            TCGLabel *over = gen_new_label();
+
+            tcg_gen_mov_tl(addr, rs1);
+            tcg_gen_mov_tl(len_remain, cpu_vl);
+            tcg_gen_muli_tl(len_remain, len_remain, a->nf);
+            tcg_gen_movi_ptr(i, 0);
+
+            tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
+            gen_helper_check_probe_read(tcg_env, addr, len_remain);
+
+            tcg_gen_brcondi_tl(TCG_COND_LTU, len_remain, 16, remain_64);
+
+            gen_set_label(loop_128);
+
+            t16 = tcg_temp_new_i128();
+            tcg_gen_qemu_ld_i128(t16, addr, midx,
+                                 MO_LE | MO_128 | MO_ATOM_NONE);
+            tcg_gen_addi_tl(addr, addr, 16);
+
+            tp = tcg_temp_new_ptr();
+            tcg_gen_add_ptr(tp, tcg_env, i);
+            tcg_gen_addi_ptr(i, i, 16);
+
+            t0 = tcg_temp_new_i64();
+            t1 = tcg_temp_new_i64();
+            tcg_gen_extr_i128_i64(t0, t1, t16);
+
+            tcg_gen_st_i64(t0, tp, vofs);
+            tcg_gen_st_i64(t1, tp, vofs + 8);
+            tcg_gen_subi_tl(len_remain, len_remain, 16);
+
+            tcg_gen_brcondi_tl(TCG_COND_GEU, len_remain, 16, loop_128);
+
+            gen_set_label(remain_64);
+            tcg_gen_brcondi_tl(TCG_COND_LTU, len_remain, 8, remain_32);
+            tcg_gen_qemu_ld_i64(t0, addr, midx, MO_LEUQ | MO_ATOM_NONE);
+            tcg_gen_addi_tl(addr, addr, 8);
+            tcg_gen_add_ptr(tp, tcg_env, i);
+            tcg_gen_addi_ptr(i, i, 8);
+            tcg_gen_st_i64(t0, tp, vofs);
+            tcg_gen_subi_tl(len_remain, len_remain, 8);
+
+            gen_set_label(remain_32);
+            tcg_gen_brcondi_tl(TCG_COND_LTU, len_remain, 4, remain_16);
+            tcg_gen_qemu_ld_i64(t0, addr, midx, MO_LEUL | MO_ATOM_NONE);
+            tcg_gen_addi_tl(addr, addr, 4);
+            tcg_gen_add_ptr(tp, tcg_env, i);
+            tcg_gen_addi_ptr(i, i, 4);
+            tcg_gen_st32_i64(t0, tp, vofs);
+            tcg_gen_subi_tl(len_remain, len_remain, 4);
+
+            gen_set_label(remain_16);
+            tcg_gen_brcondi_tl(TCG_COND_LTU, len_remain, 2, remain_8);
+            tcg_gen_qemu_ld_i64(t0, addr, midx, MO_LEUW | MO_ATOM_NONE);
+            tcg_gen_addi_tl(addr, addr, 2);
+            tcg_gen_add_ptr(tp, tcg_env, i);
+            tcg_gen_addi_ptr(i, i, 2);
+            tcg_gen_st16_i64(t0, tp, vofs);
+            tcg_gen_subi_tl(len_remain, len_remain, 2);
+
+            gen_set_label(remain_8);
+            tcg_gen_brcondi_tl(TCG_COND_EQ, len_remain, 0, over);
+            tcg_gen_qemu_ld_i64(t0, addr, midx,
+                                MO_LE | MO_8 | MO_ATOM_NONE);
+            tcg_gen_add_ptr(tp, tcg_env, i);
+            tcg_gen_st8_i64(t0, tp, vofs);
+
+            gen_set_label(over);
+
+            finalize_rvv_inst(s);
+        } else {
+            return ld_us_op(s, a, MO_8);
+        }
+        return true;
+    }
+    return false;
+}
+
 GEN_VEXT_TRANS(vle16_v, MO_16, r2nfvm, ld_us_op, ld_us_check)
 GEN_VEXT_TRANS(vle32_v, MO_32, r2nfvm, ld_us_op, ld_us_check)
 GEN_VEXT_TRANS(vle64_v, MO_64, r2nfvm, ld_us_op, ld_us_check)
@@ -785,7 +883,102 @@ static bool st_us_check(DisasContext *s, arg_r2nfvm* a, uint8_t eew)
            vext_check_store(s, a->rd, a->nf, eew);
 }
 
-GEN_VEXT_TRANS(vse8_v,  MO_8,  r2nfvm, st_us_op, st_us_check)
+static bool trans_vse8_v(DisasContext *s, arg_r2nfvm * a)
+{
+    if (st_us_check(s, a, MO_8)) {
+        if (!HOST_BIG_ENDIAN && s->vstart_eq_zero && s->vta == 0 && a->vm) {
+            uint32_t vofs = vreg_ofs(s, a->rd);
+            uint32_t midx = s->mem_idx;
+
+            TCGv_i64 t0, t1;
+            TCGv_i128 t16;
+            TCGv_ptr tp;
+            TCGv_ptr i = tcg_temp_new_ptr();
+            TCGv len_remain = tcg_temp_new();
+            TCGv rs1 = get_gpr(s, a->rs1, EXT_NONE);
+            TCGv addr = tcg_temp_new();
+
+            TCGLabel *loop_128 = gen_new_label();
+            TCGLabel *remain_64 = gen_new_label();
+            TCGLabel *remain_32 = gen_new_label();
+            TCGLabel *remain_16 = gen_new_label();
+            TCGLabel *remain_8 = gen_new_label();
+            TCGLabel *over = gen_new_label();
+
+            tcg_gen_mov_tl(addr, rs1);
+            tcg_gen_mov_tl(len_remain, cpu_vl);
+            tcg_gen_muli_tl(len_remain, len_remain, a->nf);
+            tcg_gen_movi_ptr(i, 0);
+
+            tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
+            gen_helper_check_probe_write(tcg_env, addr, len_remain);
+
+            tcg_gen_brcondi_tl(TCG_COND_LTU, len_remain, 16, remain_64);
+
+            gen_set_label(loop_128);
+
+            t0 = tcg_temp_new_i64();
+            t1 = tcg_temp_new_i64();
+            tp = tcg_temp_new_ptr();
+            tcg_gen_add_ptr(tp, tcg_env, i);
+            tcg_gen_ld_i64(t0, tp, vofs);
+            tcg_gen_ld_i64(t1, tp, vofs + 8);
+            tcg_gen_addi_ptr(i, i, 16);
+
+            t16 = tcg_temp_new_i128();
+            tcg_gen_concat_i64_i128(t16, t0, t1);
+
+            tcg_gen_qemu_st_i128(t16, addr, midx,
+                                 MO_LE | MO_128 | MO_ATOM_NONE);
+            tcg_gen_addi_tl(addr, addr, 16);
+            tcg_gen_subi_tl(len_remain, len_remain, 16);
+
+            tcg_gen_brcondi_tl(TCG_COND_GEU, len_remain, 16, loop_128);
+
+            gen_set_label(remain_64);
+            tcg_gen_brcondi_tl(TCG_COND_LTU, len_remain, 8, remain_32);
+            tcg_gen_add_ptr(tp, tcg_env, i);
+            tcg_gen_ld_i64(t0, tp, vofs);
+            tcg_gen_addi_ptr(i, i, 8);
+            tcg_gen_qemu_st_i64(t0, addr, midx, MO_LEUQ | MO_ATOM_NONE);
+            tcg_gen_addi_tl(addr, addr, 8);
+            tcg_gen_subi_tl(len_remain, len_remain, 8);
+
+            gen_set_label(remain_32);
+            tcg_gen_brcondi_tl(TCG_COND_LTU, len_remain, 4, remain_16);
+            tcg_gen_add_ptr(tp, tcg_env, i);
+            tcg_gen_ld_i64(t0, tp, vofs);
+            tcg_gen_addi_ptr(i, i, 4);
+            tcg_gen_qemu_st_i64(t0, addr, midx, MO_LEUL | MO_ATOM_NONE);
+            tcg_gen_addi_tl(addr, addr, 4);
+            tcg_gen_subi_tl(len_remain, len_remain, 4);
+
+            gen_set_label(remain_16);
+            tcg_gen_brcondi_tl(TCG_COND_LTU, len_remain, 2, remain_8);
+            tcg_gen_add_ptr(tp, tcg_env, i);
+            tcg_gen_ld_i64(t0, tp, vofs);
+            tcg_gen_addi_ptr(i, i, 2);
+            tcg_gen_qemu_st_i64(t0, addr, midx, MO_LEUW | MO_ATOM_NONE);
+            tcg_gen_addi_tl(addr, addr, 2);
+            tcg_gen_subi_tl(len_remain, len_remain, 2);
+
+            gen_set_label(remain_8);
+            tcg_gen_brcondi_tl(TCG_COND_EQ, len_remain, 0, over);
+            tcg_gen_add_ptr(tp, tcg_env, i);
+            tcg_gen_ld_i64(t0, tp, vofs);
+            tcg_gen_qemu_st_i64(t0, addr, midx, MO_LE | MO_8 | MO_ATOM_NONE);
+
+            gen_set_label(over);
+
+            finalize_rvv_inst(s);
+        } else {
+            return st_us_op(s, a, MO_8);
+        }
+        return true;
+    }
+    return false;
+}
+
 GEN_VEXT_TRANS(vse16_v, MO_16, r2nfvm, st_us_op, st_us_check)
 GEN_VEXT_TRANS(vse32_v, MO_32, r2nfvm, st_us_op, st_us_check)
 GEN_VEXT_TRANS(vse64_v, MO_64, r2nfvm, st_us_op, st_us_check)
-- 
2.34.1


