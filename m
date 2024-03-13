Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF4AEC54E60
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 19:32:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkUKI-0007DT-Ct; Wed, 13 Mar 2024 15:31:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rkUJq-0006qo-Uu
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 15:31:20 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rkUJm-0002Qn-Tv
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 15:31:18 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-6e5760eeb7aso179441b3a.1
 for <qemu-devel@nongnu.org>; Wed, 13 Mar 2024 12:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1710358272; x=1710963072; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DgCmMDQSmZuQF2R71f2SMhy+sJRtIk+zLEeTXoFqnr0=;
 b=VRuwcT1SoIMO0CukhThqR70kKl7HrhkUVMP+0XdaF/UZ6e4TuYsIANW9gOvTAYtSw4
 zKZxODOaoziFaUGQPQfJ56RhsXRVpArQdLRPsxIfVUYmnQxhU7B+BgZ/XG5VTI5fpeCz
 mKalIuxEQXaus01MT7yrA0bPZQt4Au83fzGZhvGXkaS4sRSbDWwXqt0a3Sm6Opr7ljLk
 wK7Fh8vqWSHhZFgnDXXOhQy6q0ZVGCYvdy2GCAbvf1Zd1vweQA7WKnmwCx5Eh+IYJd5i
 wg1r+twqQma8QE2Yc94N5HFr173uNpKwPODkr5Zsl0WvrLrRNrJxwFxO2fE8ozTWFS5s
 YA/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710358272; x=1710963072;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DgCmMDQSmZuQF2R71f2SMhy+sJRtIk+zLEeTXoFqnr0=;
 b=ee2M7dwwXYLE2e8Lw/P79OPpuvo+WkEuHy1wPq09nW+24UpRIz+gJBddC+dSNSPD14
 29+o9wxP0i1L8qcQnP5DO7vosgFueeWjaIxAdxH5ZU86QpR4fY/ceg61cw9Ewa/O0eQG
 nRzQrgPkFY18zTVmR4iOw+hznLLKURDcoi+FLYY+Dh4cPXdDdgO3LkK+S83cIJGbjA/y
 /hczZj5MV8NzOuXeQPFL1PrJtwRssHJeHGRjGw8REC9ONNsyxYDMXxPQlU21Jno7TAeh
 PcQC3JsoRV9I13S1nIUMiL9kpImgs3WZKDDSLHgk2uqdkqOwlH0IhF9hAMA4lR+oEB4b
 DEmg==
X-Gm-Message-State: AOJu0YyI2MwjbCB78c2zQhx62onDTpGYgr1Zt5q3lQjGjINdK8vkkllm
 X8eYwqhQDozzEAKCQ57wlmOjCp5UlWYRs4kRqlHS9AbNJoXGAUIY2WV3YMvrwpi4bxhhUSSJz3E
 J
X-Google-Smtp-Source: AGHT+IEmPHZKFJSov6cRtP80/duXdMzkf9xuFSL6jvzqtUhLJ+Sm9aV3dlKHl+1HsipNSYXtKt9N5w==
X-Received: by 2002:a05:6a00:2d17:b0:6e6:6cc8:ac9d with SMTP id
 fa23-20020a056a002d1700b006e66cc8ac9dmr3569218pfb.28.1710358272215; 
 Wed, 13 Mar 2024 12:31:12 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com ([177.94.15.159])
 by smtp.gmail.com with ESMTPSA id
 k10-20020a628e0a000000b006e5a915a9e7sm8912421pfe.10.2024.03.13.12.31.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Mar 2024 12:31:11 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 richard.henderson@linaro.org, philmd@linaro.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH for-9.0 v13 2/8] trans_rvv.c.inc: set vstart = 0 in int scalar
 move insns
Date: Wed, 13 Mar 2024 16:30:53 -0300
Message-ID: <20240313193059.405329-3-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240313193059.405329-1-dbarboza@ventanamicro.com>
References: <20240313193059.405329-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x42f.google.com
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

trans_vmv_x_s, trans_vmv_s_x, trans_vfmv_f_s and trans_vfmv_s_f aren't
setting vstart = 0 after execution. This is usually done by a helper in
vector_helper.c but these functions don't use helpers.

We'll set vstart after any potential 'over' brconds, and that will also
mandate a mark_vs_dirty() too.

Fixes: dedc53cbc9 ("target/riscv: rvv-1.0: integer scalar move instructions")
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/insn_trans/trans_rvv.c.inc | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
index e42728990e..8c16a9f5b3 100644
--- a/target/riscv/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/insn_trans/trans_rvv.c.inc
@@ -3373,6 +3373,8 @@ static bool trans_vmv_x_s(DisasContext *s, arg_vmv_x_s *a)
         vec_element_loadi(s, t1, a->rs2, 0, true);
         tcg_gen_trunc_i64_tl(dest, t1);
         gen_set_gpr(s, a->rd, dest);
+        tcg_gen_movi_tl(cpu_vstart, 0);
+        mark_vs_dirty(s);
         return true;
     }
     return false;
@@ -3399,8 +3401,9 @@ static bool trans_vmv_s_x(DisasContext *s, arg_vmv_s_x *a)
         s1 = get_gpr(s, a->rs1, EXT_NONE);
         tcg_gen_ext_tl_i64(t1, s1);
         vec_element_storei(s, a->rd, 0, t1);
-        mark_vs_dirty(s);
         gen_set_label(over);
+        tcg_gen_movi_tl(cpu_vstart, 0);
+        mark_vs_dirty(s);
         return true;
     }
     return false;
@@ -3427,6 +3430,8 @@ static bool trans_vfmv_f_s(DisasContext *s, arg_vfmv_f_s *a)
         }
 
         mark_fs_dirty(s);
+        tcg_gen_movi_tl(cpu_vstart, 0);
+        mark_vs_dirty(s);
         return true;
     }
     return false;
@@ -3452,8 +3457,9 @@ static bool trans_vfmv_s_f(DisasContext *s, arg_vfmv_s_f *a)
         do_nanbox(s, t1, cpu_fpr[a->rs1]);
 
         vec_element_storei(s, a->rd, 0, t1);
-        mark_vs_dirty(s);
         gen_set_label(over);
+        tcg_gen_movi_tl(cpu_vstart, 0);
+        mark_vs_dirty(s);
         return true;
     }
     return false;
-- 
2.43.2


