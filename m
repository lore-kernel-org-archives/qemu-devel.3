Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7552EC54E68
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Mar 2024 20:46:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rj3YR-0005nu-0u; Sat, 09 Mar 2024 15:44:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rj3YP-0005nR-Oq
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 15:44:25 -0500
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rj3YN-0006k4-8N
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 15:44:24 -0500
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-6e64a9df6c3so2576270b3a.3
 for <qemu-devel@nongnu.org>; Sat, 09 Mar 2024 12:44:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1710017061; x=1710621861; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M1pgxbL4ext+eLfj8GE9V3VngjTMGW2LA/FcQ0QZgQg=;
 b=BZ8KUSPgzfvzxcBIpX9wmHGhmIBRrPY3lx1aU8Co4D3Dq/aw/F7/QLcAOzxiTMSW1H
 8vPGwune0jwapeOFMq+Yw69a9/k7XYOxuInznmmHEdrlI2RQnw9xDEbzYSjTMAm6Zm4W
 7sZ8wvd8obj44ad+WvcXSR1DdwHtSS3MXb9tOFbAJQX9e7zPxc+0PJNSdnBSCtmRTg0Z
 iU6ajRjSLeGvPChDRQgxgSqXOW7Ti6ZvOqiNgV3PfnmGH0cT+YXw99hCpd/y018u+88F
 1bbkqy1jM1bu6+aijjfKAvYFmpJBcM17j2grbJm/Y7n1TUj5SCjfXPFudEKGX4Cki3ig
 KDLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710017061; x=1710621861;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M1pgxbL4ext+eLfj8GE9V3VngjTMGW2LA/FcQ0QZgQg=;
 b=YkpW2aYA3C4r7kek43TKhdOz8GEM5OIrIg2Hhvu0yeBsxb7jngfO7HaZxuCrSWcTzj
 z4Sp8d3RDLZNa3QzwhBfu3zZO+d0KdwoVaHpZvr4YfzGUWtp1wWIuYqwj1fmrtqgdiZ9
 F2ijIwMzHv8fLVLzr9t/51YqjK7se9PEY2lzUnmFqGFgsKHlf+v1PPrkTTtpZGi2zfml
 6CDFJJWb/LgjjyHSfE0PvbEfDfOUF6PerrUQLZ0UDNrCab3o0j9Mr9YpexERbj6HMTiU
 7oibAHr8+D3bNtdrEPET6lRZPbT9snjVIXuSKWfyPRGaxiWUK0P5GQO8a105EE46dPBH
 A+hg==
X-Gm-Message-State: AOJu0Ywh/QLwXnk1RGA48DLGFSCINvKUklGwW0t1mWJ9eWdeIBSt4od4
 EqGLcWsIbWxk10kLYoqMrrYy8m+NtVLo0vlUNMVYTEw/I8WN8wr5+kZiD16VLGIp4l8J8Rk3+ox
 H
X-Google-Smtp-Source: AGHT+IFqnGUk9wWKd4jePVq2tt3U/ZFupM25OWhKgLeyRHYZirSJkVfhDyK5jIA0VWiaHCg3EJvghA==
X-Received: by 2002:a05:6a00:6616:b0:6e6:47f6:eb30 with SMTP id
 he22-20020a056a00661600b006e647f6eb30mr2780106pfb.22.1710017061199; 
 Sat, 09 Mar 2024 12:44:21 -0800 (PST)
Received: from grind.. ([177.94.15.159]) by smtp.gmail.com with ESMTPSA id
 ey15-20020a056a0038cf00b006e647716b6esm1656270pfb.149.2024.03.09.12.44.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Mar 2024 12:44:20 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 richard.henderson@linaro.org, philmd@linaro.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v9 08/10] trans_rvv.c.inc: remove redundant mark_vs_dirty()
 calls
Date: Sat,  9 Mar 2024 17:43:43 -0300
Message-ID: <20240309204347.174251-9-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240309204347.174251-1-dbarboza@ventanamicro.com>
References: <20240309204347.174251-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x434.google.com
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
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/riscv/insn_trans/trans_rvv.c.inc | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
index 4c1a064cf6..b0f19dcd85 100644
--- a/target/riscv/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/insn_trans/trans_rvv.c.inc
@@ -2065,7 +2065,6 @@ static bool trans_vmv_v_i(DisasContext *s, arg_vmv_v_i *a)
         if (s->vl_eq_vlmax && !(s->vta && s->lmul < 0)) {
             tcg_gen_gvec_dup_imm(s->sew, vreg_ofs(s, a->rd),
                                  MAXSZ(s), MAXSZ(s), simm);
-            mark_vs_dirty(s);
         } else {
             TCGv_i32 desc;
             TCGv_i64 s1;
@@ -2083,9 +2082,8 @@ static bool trans_vmv_v_i(DisasContext *s, arg_vmv_v_i *a)
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
@@ -2612,7 +2610,6 @@ static bool trans_vfmv_v_f(DisasContext *s, arg_vfmv_v_f *a)
 
             tcg_gen_gvec_dup_i64(s->sew, vreg_ofs(s, a->rd),
                                  MAXSZ(s), MAXSZ(s), t1);
-            mark_vs_dirty(s);
         } else {
             TCGv_ptr dest;
             TCGv_i32 desc;
@@ -2635,9 +2632,8 @@ static bool trans_vfmv_v_f(DisasContext *s, arg_vfmv_v_f *a)
             tcg_gen_addi_ptr(dest, tcg_env, vreg_ofs(s, a->rd));
 
             fns[s->sew - 1](dest, t1, tcg_env, desc);
-
-            mark_vs_dirty(s);
         }
+        mark_vs_dirty(s);
         return true;
     }
     return false;
@@ -3560,12 +3556,11 @@ static bool trans_##NAME(DisasContext *s, arg_##NAME * a)               \
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


