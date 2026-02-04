Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08AEAE8B39C
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 05:25:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnVOC-0000f3-K2; Wed, 04 Feb 2026 00:25:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vnVO8-0000Wm-33
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 00:25:16 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vnVO6-0003Hv-KW
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 00:25:15 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2a09757004cso52218205ad.3
 for <qemu-devel@nongnu.org>; Tue, 03 Feb 2026 21:25:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770182713; x=1770787513; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9zcY1K2Qnk7na8oyBT2MIg9u80DbSZ14l8lXIlhE+Y4=;
 b=ODNdHC3dItB+be71Y31PHVTiJNs37z4AgWFunN9emqji+3OJ9RHfQ6/V7RwgvyM9IC
 Kur3FnC+E5A6f+59DW5j2+rofjjoFZF1hpJcZY3igctvaXnyPCQqpkqv4EoNCmKfKthA
 IpopmZvUsHH5IIakiS9IL7UEBZ3UE7PhFqORlNWtR7wBHWMcKKu44Yb7QtTl1WLtSHVe
 yuUtgB/2R/9CPR9edsnKAEnGYPyFDVQQLqPFeCLeNFS0CxMUCjH1tbDrD3UGKWen1dkY
 ShQyQwMBkR0XKKTyE2+AfOAWT2lmQGYQYaSke5IVxXcwMQszXeEL2DC8FaMmr9pYNdV/
 mR2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770182713; x=1770787513;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9zcY1K2Qnk7na8oyBT2MIg9u80DbSZ14l8lXIlhE+Y4=;
 b=SneK3GThOW5PKtsD49L6gO8554pmufHy+VdLchDtot4yjAPpoFpcZoafHbJeE+6mtT
 AwW39lBoXvDjTTvgWJuqk2Rb3ZGoqGXg+0FwHacanL9spUJ9HQQKOAxpFoKXWkL5pBx8
 rRs0G87iiEfSRVo8jwmUud9Uqu5Sv3zQUNgdY5hGqxdFe/EMYppz9TfTshATWDauIv+g
 veZKbV6gTYECqWHYuJ4GVPP7j5bp1d2ZF4ZRUqRU7T8fKijJ8AnNmhYit5cRO3QXApUg
 q5RTz8uFK1YWgBXc6mlkA2ZHXhQDbH6xqCBezap7ZkFnF2wH3sr6fw/DZGvM4v1khkYL
 1uaw==
X-Gm-Message-State: AOJu0Yw1rtvfhl4gtQILK32M5NjQINhe+H9vyZon6tEzV9dgaaZeXF6Y
 2n4wZkWfe0HLdnisHNc9PO7wU5FFKlrT5ZN/hZZCSmvfsWSngref8nO+eLrINinmr5KCq4Oye5H
 m7BAbGIU=
X-Gm-Gg: AZuq6aJlTwIVhrc9t1mKto6Yy960TuOG0oc/HH6ilw8WvuaNdk/Z2UvLg4OoFIF0tpl
 ylDbSI5wH1Q5DUpO86IgqMevU/LZTvLb4AKCkmlmWL8hTJ9oFgSFY0bEpR0R4JJwf+l6goy9EPQ
 xXwT6DkZzMpDJrKH/+FGrFfsnD0QKz6hDvg7ltc7XDGgF00nnNbpuTGqswjgoPJ0vmfItSa4J8l
 MIqHnzo4mTjj/MDNkz9rWZJsBVtxDBAGXgPSQ03KlioinS21W18IHIHDpRBaY7ta3xcIjwhKJ2G
 /zGUcFUdErTQxwP3CjlG005Ptfd28ULcLjwY8pj57Cy2QfypDzPVoUwqZVIcax8rSrqsu5PAJdJ
 3wqDOCw+xnm1JapUIqvPR51sxsC6rQu9FALcqkDJQa9cj+okcubZbXIGnTcZdznkKBCVGuFXXru
 aM8uKpXvBqEZAcAcKvoDeE+78LvgaTYm5OOn0FrJbWYOcLP8woLs9w6gymE6E=
X-Received: by 2002:a17:903:15c7:b0:2a7:6cdc:7f14 with SMTP id
 d9443c01a7336-2a93412686bmr17940015ad.60.1770182713135; 
 Tue, 03 Feb 2026 21:25:13 -0800 (PST)
Received: from stoup.. (bg30dhzlx7lnyrq74wrz.ip6.superloop.au.
 [2401:d002:dc0f:2100:1bc:fe1e:491:928e])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a933965c3esm10062015ad.67.2026.02.03.21.25.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Feb 2026 21:25:12 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
Subject: [PATCH v2 4/6] tcg: Add tcg_op_imm_match
Date: Wed,  4 Feb 2026 15:24:54 +1000
Message-ID: <20260204052456.970605-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260204052456.970605-1-richard.henderson@linaro.org>
References: <20260204052456.970605-1-richard.henderson@linaro.org>
MIME-Version: 1.0
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

From: Paolo Bonzini <pbonzini@redhat.com>

Create a function to test whether the second operand of a
binary operation allows a given immediate.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
[rth: Split out from a larger patch; keep the declaration internal.]
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-internal.h |  5 +++++
 tcg/tcg.c          | 21 +++++++++++++++++----
 2 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/tcg/tcg-internal.h b/tcg/tcg-internal.h
index 2cbfb5d5ca..c1ce50998e 100644
--- a/tcg/tcg-internal.h
+++ b/tcg/tcg-internal.h
@@ -94,4 +94,9 @@ TCGOp *tcg_op_insert_before(TCGContext *s, TCGOp *op,
 TCGOp *tcg_op_insert_after(TCGContext *s, TCGOp *op,
                            TCGOpcode, TCGType, unsigned nargs);
 
+/*
+ * For a binary opcode OP, return true if the second input operand allows IMM.
+ */
+bool tcg_op_imm_match(TCGOpcode op, TCGType type, tcg_target_ulong imm);
+
 #endif /* TCG_INTERNAL_H */
diff --git a/tcg/tcg.c b/tcg/tcg.c
index e7bf4dad4e..778268f5cd 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -3391,11 +3391,9 @@ static void process_constraint_sets(void)
     }
 }
 
-static const TCGArgConstraint *opcode_args_ct(const TCGOp *op)
+static const TCGArgConstraint *op_args_ct(TCGOpcode opc, TCGType type,
+                                          unsigned flags)
 {
-    TCGOpcode opc = op->opc;
-    TCGType type = TCGOP_TYPE(op);
-    unsigned flags = TCGOP_FLAGS(op);
     const TCGOpDef *def = &tcg_op_defs[opc];
     const TCGOutOp *outop = all_outop[opc];
     TCGConstraintSetIndex con_set;
@@ -3422,6 +3420,21 @@ static const TCGArgConstraint *opcode_args_ct(const TCGOp *op)
     return all_cts[con_set];
 }
 
+static const TCGArgConstraint *opcode_args_ct(const TCGOp *op)
+{
+    return op_args_ct(op->opc, TCGOP_TYPE(op), TCGOP_FLAGS(op));
+}
+
+bool tcg_op_imm_match(TCGOpcode opc, TCGType type, tcg_target_ulong imm)
+{
+    const TCGArgConstraint *args_ct = op_args_ct(opc, type, 0);
+    const TCGOpDef *def = &tcg_op_defs[opc];
+
+    tcg_debug_assert(def->nb_oargs == 1);
+    tcg_debug_assert(def->nb_iargs == 2);
+    return tcg_target_const_match(imm, args_ct[2].ct, type, 0, 0);
+}
+
 static void remove_label_use(TCGOp *op, int idx)
 {
     TCGLabel *label = arg_label(op->args[idx]);
-- 
2.43.0


