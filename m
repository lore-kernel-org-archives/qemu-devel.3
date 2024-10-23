Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7381ED2E00A
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 03:36:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3S9g-0007Tu-M3; Tue, 22 Oct 2024 23:35:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t3S95-0006zo-M9
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 23:34:52 -0400
Received: from mail-oo1-xc2e.google.com ([2607:f8b0:4864:20::c2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t3S92-0008Lj-Kx
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 23:34:51 -0400
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-5ebbed44918so1985730eaf.0
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2024 20:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729654481; x=1730259281; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ys59/oRxjJfDupg9FPxk4fjLEmz2k5pFJaWTi4KH55Y=;
 b=NBhlgv903ysxixv2MBiWeX4fFEhEBKGNzXvS2PfKx/rrY72/dtCULC1CTU/m+HmSoF
 lpOvBBuorb37p2D7qXNp8VMXTPW9alNWThdyWatAiYgvcu//asTlysZ8H/NjBKJ3blOe
 EZ0mfMjaAmlOmMQa+pRZygc5dQrKka5XwiW2Bs0SzhE9NPApjCXXLQzCRzWVU8tb3TDg
 PbtOgfF0TCofS5Gf4VUyrkLHEkM8FPaY2Noqo41itnUzFdo7lvKHNm3G8t9Lq418ImwE
 AxeJun3terP0tSfseO6i8fN0Fpu54i/jU89YYOsvZl/VyZyxaQkJg0Evga7hTj2yY1iG
 phEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729654481; x=1730259281;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ys59/oRxjJfDupg9FPxk4fjLEmz2k5pFJaWTi4KH55Y=;
 b=pthaTYCSix6P9TdacrtPYsLE8vOPRslGiD7srNKNBz4xM0cDz9IGKbaqU4oXIrsHMy
 19BDoZCAlPSLLPg4d3jc90xylvPR66QDJR0S+lHtXV3q+ubKm+hgcQdQYpl4nMu4kKXc
 //VtlnLXL9irvzXcf42d7ffyOMjuuz+vsAnH2mUJ4MZ3rjjCITTvzZfigjFez3BNBeAY
 yWuwogcZnbIWIOIL0uTpePMsqb+2U0GcOlidnm9mxNjtcgsxLDTAV6UsQr0ICC1c6S0q
 L8ycg3oSvfFBrjmz7rMOLhKM2irVsUG9TdFlogm/FfR9gFT5byO+s6J4JnH9Hk5vcLBB
 8rBQ==
X-Gm-Message-State: AOJu0Ywa9hID5nYsdUOsWX8JmZS6jA5AaMVHpqtITGYS1o5GqQCH2azz
 +EYOtPUmHUrbQW1jLaF7AqYzU8/MLkrYor3NzQ2YDcqWuLBtDwZvWfmEXAXvu9tUc1q9REJeUsO
 K
X-Google-Smtp-Source: AGHT+IFva2M5uHKsMTS9rEdBc+0xoNFMT1fpcqxWtOa4LqSzsyRA0ms9SAPJIv9IwbQsWNx+sjPDLg==
X-Received: by 2002:a05:6870:82ac:b0:27b:6762:3fdb with SMTP id
 586e51a60fabf-28ccb44831amr1333538fac.6.1729654480967; 
 Tue, 22 Oct 2024 20:34:40 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71ec13d73b1sm5438338b3a.105.2024.10.22.20.34.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2024 20:34:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
	LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: [PULL 09/24] tcg/riscv: Accept constant first argument to sub_vec
Date: Tue, 22 Oct 2024 20:34:17 -0700
Message-ID: <20241023033432.1353830-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241023033432.1353830-1-richard.henderson@linaro.org>
References: <20241023033432.1353830-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2e;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2e.google.com
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

Use vrsub.vi to subtract from a constant.

Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/riscv/tcg-target-con-set.h | 1 +
 tcg/riscv/tcg-target.c.inc     | 8 ++++++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/tcg/riscv/tcg-target-con-set.h b/tcg/riscv/tcg-target-con-set.h
index 97e6ecdb0f..d8ce5414f5 100644
--- a/tcg/riscv/tcg-target-con-set.h
+++ b/tcg/riscv/tcg-target-con-set.h
@@ -25,6 +25,7 @@ C_O0_I2(v, r)
 C_O1_I1(v, r)
 C_O1_I1(v, v)
 C_O1_I2(v, v, v)
+C_O1_I2(v, vK, v)
 C_O1_I2(v, v, vK)
 C_O1_I2(v, v, vL)
 C_O1_I4(v, v, vL, vK, vK)
diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index ce8d6d0293..1ce2f291d3 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -2350,7 +2350,11 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
         break;
     case INDEX_op_sub_vec:
         set_vtype_len_sew(s, type, vece);
-        tcg_out_opc_vv(s, OPC_VSUB_VV, a0, a1, a2);
+        if (const_args[1]) {
+            tcg_out_opc_vi(s, OPC_VRSUB_VI, a0, a2, a1);
+        } else {
+            tcg_out_opc_vv(s, OPC_VSUB_VV, a0, a1, a2);
+        }
         break;
     case INDEX_op_and_vec:
         set_vtype_len(s, type);
@@ -2565,7 +2569,7 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
     case INDEX_op_xor_vec:
         return C_O1_I2(v, v, vK);
     case INDEX_op_sub_vec:
-        return C_O1_I2(v, v, v);
+        return C_O1_I2(v, vK, v);
     case INDEX_op_cmp_vec:
         return C_O1_I2(v, v, vL);
     case INDEX_op_cmpsel_vec:
-- 
2.43.0


