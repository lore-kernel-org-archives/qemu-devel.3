Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB30CC5AC67
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 22:53:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtvL7-000050-KA; Tue, 11 Aug 2026 18:52:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wtvL6-0008WC-7H
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 18:52:56 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wtvL4-0007Ug-Sz
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 18:52:55 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-38e69bdb0fcso415013a91.1
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 15:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786488773; x=1787093573; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=siEA+eoPfFGrDs8/KL2W99pO9PcpFZ6g60+s9nAbM8E=;
 b=rRyF5dzOUrCMyQnh820Z6h7+0ijIDNsZecgpDKM/6NbSRFWzE+4f8iXLxkuYl/+26r
 rKj40yCNDbl82afy69TTuc1e5L4thvJKyNtQfe9tzyYNniT7H3cqFSl2HrqGQt7xGAg9
 rKqdzIbQ6C8jayyK3sPr9qoI3EjhEK8M9YNRNB/dnkxVYJuniPdtsNPB+lLVAi9cRy9R
 BkiaGOw7LjvnvCR8mHtMJCkgrta2uvSHB/2Kb8vYPBL6/RooMHGIGUb0kR/0jUL6taK5
 Je25ZHXMcfH7LKZQocnTj6Ie77R39PAMuTeSPT12kawoizYttBqWBrBlcxo7/DfVHfKE
 9Wqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786488773; x=1787093573;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=siEA+eoPfFGrDs8/KL2W99pO9PcpFZ6g60+s9nAbM8E=;
 b=BCA4qX18lB79PN/dagRZNw/OAjM5FpsuyQp+Btw+oPNM0Glump6CiivRSZBN1mXjjd
 JpLMcr2aW0Bbo/a46R4isSkt9E/1485PMlfADg1tMQYGekyiFP3blct6Xep0ixgBFW55
 6zfGv/H+b8qsYy+viXvIIpxDwWNeRo3fOt4ijMYy4MBxaWMnlGboDx6fLHUB4+mkWn9m
 vmqPP853kEIJqC+htvgL/VK1LQCGhbJd7xe3YX7rUepw+zgsWLAaOZ6bdrXKHjiHHirW
 7ESTlY2BpxadlbwLpSjpuN/spX/r0PYryuE9j1HjUHATHkKljCnO8NVwqr0pP7e2HXgk
 NqHQ==
X-Gm-Message-State: AOJu0Yy3EbaNas9sBGJ8ZWfXYm3ovonjRkO/aS4DazZbUtbU7Z41Xb57
 H1s/OCRRONf289yWUDXmZQzM/aa97GdqPEs1TV+c68yRor2061nSltFxdE8xdCbmDwhYk6rUyOH
 vXK/h
X-Gm-Gg: AR+sD113SGYl93NSmQ6K2SxmLBLL2jYOVjsKPVv7valhBXZdW2ecbDi6HIxfQ1PYwwM
 ja70d5z8DEKGf8Ojk/2BM3HdK4NhxB6EtcNQ5c7VcogDglbx0fWBFygYCD1q19xG3MaoCB65qHP
 Wuaahl37AjTy2zSRIaB7m7OP8FPjobYG+PMIAGCFW60grOo/7O/BbOWmCAapt5Wt0vZO6NW9epY
 2JV5I2pKdAwNu4S60puDdWupyJt8XeVtl/t0XjNbXODZgcjSENQV/rdEO2c4N/kQJ90Q6sagEPb
 n3EAlBmpX70LDjlQZpbDeGWW6RDR0CCenvho2AuOis5OD2d82DMfXdRno1BvNTEH+lnv4MTAU0N
 ibahb58+AlHjco6NtA9q3Z0wvr9Kh7mZjVCkZUcX8nmxqNV5htmrw561Ds+1ngWU9mhDkOsRveY
 5jpAJjmq4HIExMgqMkVTcfM9ivF5lEBt7NWS91OdK94OXU7oDu2U4PkNUIWStag+CwNVsWJmH68
 MjgcOkjb+TlDOqPmDVp
X-Received: by 2002:a17:90b:1b0d:b0:38f:7f60:ba35 with SMTP id
 98e67ed59e1d1-3930123788cmr463819a91.5.1786488772823; 
 Tue, 11 Aug 2026 15:52:52 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-392f933fa84sm1134120a91.4.2026.08.11.15.52.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2026 15:52:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
Subject: [PATCH] tcg/optimize: INDEX_op_mul is commutative
Date: Tue, 11 Aug 2026 15:52:50 -0700
Message-ID: <20260811225250.173812-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1036.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Cc: qemu-stable@nongnu.org
Fixes: 7a2f7084525 ("tcg/optimize: Sink commutative operand swapping into fold functions")
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index fcdef25bee..ed2ff32ed2 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2152,7 +2152,7 @@ static bool fold_movcond(OptContext *ctx, TCGOp *op)
 
 static bool fold_mul(OptContext *ctx, TCGOp *op)
 {
-    if (fold_const2(ctx, op) ||
+    if (fold_const2_commutative(ctx, op) ||
         fold_xi_to_i(ctx, op, 0) ||
         fold_xi_to_x(ctx, op, 1)) {
         return true;
-- 
2.43.0


