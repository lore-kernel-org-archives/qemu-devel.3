Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A802C48BC4
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 02:24:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rccGZ-00038x-QF; Tue, 20 Feb 2024 21:23:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rccGY-000385-34
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 21:23:22 -0500
Received: from mail-oo1-xc2e.google.com ([2607:f8b0:4864:20::c2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rccGW-0001ID-HX
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 21:23:21 -0500
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-59d78deb469so3886577eaf.1
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 18:23:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1708482199; x=1709086999; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PYo30v7en8CVRQ433AMJs0Zn41Yvafyb8U7LnFnarII=;
 b=IKbM71TfZcB0A4UnyCo/w/VeQWx1AT26PQ5fBDPsI05EQz9lp80Z3yPKSk0I+C4EUd
 Om2V/bPuOXFQ0ctI738F/CTn7GPmFSF3uh0hEhVYelQrMv+BIhqQHHdccUJ+gSHtzYmK
 lQYSa9m/3QIAJYbox439HcbcXe8Wha1c0umH2R1O70/Z1xi4IryI+b3raJHCsB4NIaVh
 WXiX+xpIkvG+WOpcZasXOQgsAwjAf50rhXzNqDRjz1sMiht0/7c3OwfNOCis+Ir4aWqg
 6094zXw02YnUOxn2zJboAHX68h7LysxCeNLF9Gw0pUh3wHoXMP9nUAzcz60PCR6XzTAn
 JZUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708482199; x=1709086999;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PYo30v7en8CVRQ433AMJs0Zn41Yvafyb8U7LnFnarII=;
 b=o2qfETfnYYSkHPhR0vwCy8TlawoBxFcTBv0LvLy0crsWIxiT7j2aez0ZOLPOB0YFKq
 wFMTKtWiFoBW4fgBSRJAPR0Wab7UjjL+WLs/eSiUeZ01KugawSluyW2Sy03bhOByq7cY
 HudAW/gr/gsjBT3NUFfS+dvI7UtgbCF7kD/NRHcYvSVS1hxajpizzBb+nI415xmAhBCi
 W6mgIWUI+u/jUaGNfV8JjWdUt2Xe0cKuMAXuUZfZun4LZawQNWSjmGpy7Jnuq8doaeZ7
 pPFGpFYQRHyVq0DtPtqi/wJrGlTseo/k3IhABUEQJS5wIHXgcFY0vGxL3nry54yNUHoj
 I6DQ==
X-Gm-Message-State: AOJu0YxPyQGbCvS4eWSauszYglY9e28vssSjLevZ67e5Z1DHq5Rd5qMg
 VQMlrR3oF/NlQ4MZKPYfmNLkbf97PqDpb9521jFyK3Vz0YphuIutg26X5Jjdypu0mzhhaqiVuB7
 Y
X-Google-Smtp-Source: AGHT+IH7cbaN4xhaaGF4XeRC2hc4JxxITbBpThG1AvQHeXp5UPuMNV2LiDd60pviez+rsFoJPGNoIw==
X-Received: by 2002:a05:6358:3121:b0:17b:583d:63f4 with SMTP id
 c33-20020a056358312100b0017b583d63f4mr1059759rwe.22.1708482198935; 
 Tue, 20 Feb 2024 18:23:18 -0800 (PST)
Received: from grind.dc1.ventanamicro.com ([177.94.15.159])
 by smtp.gmail.com with ESMTPSA id
 y5-20020a634945000000b005dc48e56191sm7183355pgk.11.2024.02.20.18.23.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Feb 2024 18:23:18 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 richard.henderson@linaro.org, max.chou@sifive.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v5 6/7] trans_rvv.c.inc: remove redundant mark_vs_dirty() calls
Date: Tue, 20 Feb 2024 23:22:51 -0300
Message-ID: <20240221022252.252872-7-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240221022252.252872-1-dbarboza@ventanamicro.com>
References: <20240221022252.252872-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2e;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oo1-xc2e.google.com
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

trans_vmv_v_i , trans_vfmv_v_f and the trans_##NAME macro from
GEN_VMV_WHOLE_TRANS() are calling mark_vs_dirty() in both branches of
their 'ifs'. conditionals.

Call it just once in the end like other functions are doing.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/insn_trans/trans_rvv.c.inc | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
index 58299d9bb8..8c9a0246ef 100644
--- a/target/riscv/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/insn_trans/trans_rvv.c.inc
@@ -2044,7 +2044,6 @@ static bool trans_vmv_v_i(DisasContext *s, arg_vmv_v_i *a)
         if (s->vl_eq_vlmax && !(s->vta && s->lmul < 0)) {
             tcg_gen_gvec_dup_imm(s->sew, vreg_ofs(s, a->rd),
                                  MAXSZ(s), MAXSZ(s), simm);
-            mark_vs_dirty(s);
         } else {
             TCGv_i32 desc;
             TCGv_i64 s1;
@@ -2062,9 +2061,8 @@ static bool trans_vmv_v_i(DisasContext *s, arg_vmv_v_i *a)
                                               s->cfg_ptr->vlenb, data));
             tcg_gen_addi_ptr(dest, tcg_env, vreg_ofs(s, a->rd));
             fns[s->sew](dest, s1, tcg_env, desc);
-
-            mark_vs_dirty(s);
         }
+        mark_vs_dirty(s);
         return true;
     }
     return false;
@@ -2591,7 +2589,6 @@ static bool trans_vfmv_v_f(DisasContext *s, arg_vfmv_v_f *a)
 
             tcg_gen_gvec_dup_i64(s->sew, vreg_ofs(s, a->rd),
                                  MAXSZ(s), MAXSZ(s), t1);
-            mark_vs_dirty(s);
         } else {
             TCGv_ptr dest;
             TCGv_i32 desc;
@@ -2614,9 +2611,8 @@ static bool trans_vfmv_v_f(DisasContext *s, arg_vfmv_v_f *a)
             tcg_gen_addi_ptr(dest, tcg_env, vreg_ofs(s, a->rd));
 
             fns[s->sew - 1](dest, t1, tcg_env, desc);
-
-            mark_vs_dirty(s);
         }
+        mark_vs_dirty(s);
         return true;
     }
     return false;
@@ -3524,12 +3520,11 @@ static bool trans_##NAME(DisasContext *s, arg_##NAME * a)               \
         if (s->vstart_eq_zero) {                                        \
             tcg_gen_gvec_mov(s->sew, vreg_ofs(s, a->rd),                \
                              vreg_ofs(s, a->rs2), maxsz, maxsz);        \
-            mark_vs_dirty(s);                                           \
         } else {                                                        \
             tcg_gen_gvec_2_ptr(vreg_ofs(s, a->rd), vreg_ofs(s, a->rs2), \
                                tcg_env, maxsz, maxsz, 0, gen_helper_vmvr_v); \
-            mark_vs_dirty(s);                                           \
         }                                                               \
+        mark_vs_dirty(s);                                               \
         return true;                                                    \
     }                                                                   \
     return false;                                                       \
-- 
2.43.2


