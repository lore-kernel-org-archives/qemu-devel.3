Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF28EECE577
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Sep 2024 02:29:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sn7dW-0003Mj-5f; Sat, 07 Sep 2024 22:26:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sn7dT-0003AQ-FY
 for qemu-devel@nongnu.org; Sat, 07 Sep 2024 22:26:43 -0400
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sn7dR-00050n-TS
 for qemu-devel@nongnu.org; Sat, 07 Sep 2024 22:26:43 -0400
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-710da8668b3so479554a34.1
 for <qemu-devel@nongnu.org>; Sat, 07 Sep 2024 19:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725762401; x=1726367201; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/GYQH+qlsiZNusd91SlPcZXeCA8M1xc1mlbTAMFEsWI=;
 b=Gb+ABANnyglRwCEUKdp1iR5BZKFJJW40P6+kTmoyAG4mpkNY6+6cThqutRiZ/ar1dt
 c7ILOiTyiUHdBPjOY9GS8rcyrnZoYaX3zTYcduwpecjnTJ0pLVQUEgtizLU8tl2CqXk9
 hTQjUtBx3r84tLvXHhf5L0z/iGVk3kOL6Lgn6LqI9KL8ZQOpn5y0lUNNwD8os0duUi+c
 H+DPXVANrc/gjZ94gCcJgq9GRjS6xR1R2Z7LTajmPIRle4M5iI1xrYOj3x+SU2IOe+yO
 vKv+jIv27V4f2agrnnlHaXNs2lETLsSTZ7JxxbQQAFksfb0TSkTzCd/KnfIPw5WfGHf3
 93hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725762401; x=1726367201;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/GYQH+qlsiZNusd91SlPcZXeCA8M1xc1mlbTAMFEsWI=;
 b=O7FaezAotExGCDzvUbJCgqMwk45Cijrq7HvmRLiGj/cNFxQumDcEl8blqpAiqnLEeF
 51bvnlDt6urH22qTxAQSrRh7fJGohRoRMctnhK62LHhasUXZJ5Wm0JcKpwkl3Gyy39f5
 ROF8Zbx2Y3efL5sv6Lq9ArGBZTPoTiwhib2RumiG6c76b8ZY85ut1PkKRBPcoEkCOUbE
 19BE+RSz7Gf6SCL+mDhBJz/ufMIRcXTeQ0PTd8/hy2G9f0luxVNG6CLYNfTXZlKBCQCU
 WFy9ipnoiFmCrwARzWE8MIxtXARsi6X7YpDgE0LDpGdxEMS6D/dao1enEsR07k5NNt8B
 kHAw==
X-Gm-Message-State: AOJu0YwvhIYtM0VfHJWBevTfbbSEfLThE6eC/RI29EEaB+hOP/AGEEWJ
 WC6IRLFLwV/E6p9PXoIR04weVpLRoxhGjMStxVMp11E1+wm3HxGAhRxFdJkYwCMVHDfL9EyUORi
 Y
X-Google-Smtp-Source: AGHT+IFPV5ddEwzUHQevvpH5mWuwC7UH0ippviagH5gjYNuXdjVgVZppCmxZRGaBTa5khBTUA6Kygg==
X-Received: by 2002:a05:6830:4411:b0:708:d860:e51b with SMTP id
 46e09a7af769-710cc22c384mr8034581a34.15.1725762400534; 
 Sat, 07 Sep 2024 19:26:40 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2dadbfe46d4sm4084019a91.1.2024.09.07.19.26.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Sep 2024 19:26:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: zhiwei_liu@linux.alibaba.com, tangtiancheng.ttc@alibaba-inc.com,
 liwei1518@gmail.com, bmeng.cn@gmail.com
Subject: [PATCH 06/12] tcg/optimize: Fold movcond with true and false values
 identical
Date: Sat,  7 Sep 2024 19:26:26 -0700
Message-ID: <20240908022632.459477-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240908022632.459477-1-richard.henderson@linaro.org>
References: <20240908022632.459477-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::336;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x336.google.com
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

Fold "x = cond ? y : y" to "x = y".

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index ba16ec27e2..cf311790e0 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1851,6 +1851,11 @@ static bool fold_movcond(OptContext *ctx, TCGOp *op)
 {
     int i;
 
+    /* If true and false values are the same, eliminate the cmp. */
+    if (args_are_copies(op->args[3], op->args[4])) {
+        return tcg_opt_gen_mov(ctx, op, op->args[0], op->args[3]);
+    }
+
     /*
      * Canonicalize the "false" input reg to match the destination reg so
      * that the tcg backend can implement a "move if true" operation.
-- 
2.43.0


