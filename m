Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4A93C54791
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Mar 2024 20:45:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rj3YK-0005mI-IK; Sat, 09 Mar 2024 15:44:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rj3YH-0005lF-ML
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 15:44:17 -0500
Received: from mail-oa1-x2d.google.com ([2001:4860:4864:20::2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rj3YG-0006go-7i
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 15:44:17 -0500
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-221830f6643so1561085fac.2
 for <qemu-devel@nongnu.org>; Sat, 09 Mar 2024 12:44:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1710017054; x=1710621854; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ouu07Gj9HPW4I5D5mowUTGwHBlivJi2oAjm1kvjMVi4=;
 b=BNttbOoAiRDNb1+YbXhIkZ3Qzs9k5IvRIsXyAztqhJFp7uLQqWyQgK2tDduwlsbPzA
 rksNtibE1Ol6SdQ/Yc/fMPWC+g67wppvKph4NixQB4A5+tqcE3tDD5yftRtLlZ7EHSic
 Nk7YrIe/Q/mcyvUbnuNL2UuUveO9PEGSKEv3/98M8nHVPaw0uTI+yILV8cnGVCqyfO04
 KIAyM+yqSO4KnuhjAAiJ6/unjftwbSZ3XVBoLVyfD765d2DKJ7bxTkBzLhBPWTndGGKX
 Jg0KnI1gely9eNSHvTkPHPI0d3QCBUDGfaIN+KfVDjuWHSWgTtE1nb1UxuhvjVvVO9ht
 VOyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710017054; x=1710621854;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ouu07Gj9HPW4I5D5mowUTGwHBlivJi2oAjm1kvjMVi4=;
 b=doCvWN2qhmbde676fTFViJ38m/IPCUrMg9qoY9cOIidSZkg/eHWDbEv3pUKouBCJxE
 DHlABxl+YTE0PY4jnymrfI3Sg4NaSvhgU7bE+V7pdeiWahzMXhLxtFXHxWLKSN1LW7ri
 RRK3SIgVPVbPTo05lHWJQIsfVMrHGNwQQEucj8WQyF/M7o+tjEVwff/LaeHgzzEeUNMS
 kPD3UjNn4ZTkSuQz1aqLkVKoN56gFE6PxIgRusyZsUxQN3tbWvjfxdI2T0JruEPM3v7b
 we58tjjqFsKw9yzrq2sj1+Zo1g65osnoQFdn5cLvcplxaxII8UNFVsEMVlRXQKpOfGvy
 PI4A==
X-Gm-Message-State: AOJu0YxWkJMyGljXco1rbC8Zg55lLBD0s6GgvV8sNSHhj37cAJo1HFaf
 njQfYQ54zI6rniqmv4RmvXTdB9s1NRANpw8RkD194pb0PJX+I8QVIg9G4a+iUTF2z8xW+6FnfEH
 p
X-Google-Smtp-Source: AGHT+IFc26WFafbzDVwquPd2bU6Fn6j80EfnOkv+M8yBkqv4RByrl1V8H7xYSU9HYKglxgDFnwrE/g==
X-Received: by 2002:a05:6870:ecaa:b0:21f:22a6:c0e5 with SMTP id
 eo42-20020a056870ecaa00b0021f22a6c0e5mr3060211oab.52.1710017054430; 
 Sat, 09 Mar 2024 12:44:14 -0800 (PST)
Received: from grind.. ([177.94.15.159]) by smtp.gmail.com with ESMTPSA id
 ey15-20020a056a0038cf00b006e647716b6esm1656270pfb.149.2024.03.09.12.44.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Mar 2024 12:44:14 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 richard.henderson@linaro.org, philmd@linaro.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v9 06/10] trans_rvv.c.inc: set vstart = 0 in int scalar move
 insns
Date: Sat,  9 Mar 2024 17:43:41 -0300
Message-ID: <20240309204347.174251-7-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240309204347.174251-1-dbarboza@ventanamicro.com>
References: <20240309204347.174251-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2d;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oa1-x2d.google.com
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


