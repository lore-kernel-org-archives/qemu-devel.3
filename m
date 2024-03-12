Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38BB0C54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 18:42:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk74G-0000SC-Rw; Tue, 12 Mar 2024 14:41:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rk74C-0000PH-Et
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 14:41:37 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rk747-0001NV-A8
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 14:41:35 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-6e6b54a28d0so116368b3a.2
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 11:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710268888; x=1710873688; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=owm/IAg32HMjFxsQJhlmbOKm3Qbhqz7rn/KBgK1esIo=;
 b=u/1qTk7cT2fZF1eZy4QnoayvVMZm92JJpojggpmRr0A0Tqyh2k5OH+LoZ4W/xKagc8
 /UTBztR6iVcJgWLa5cSAHiP65L489/qqx/f0IdkhSt2yjZf8iWqJ+Gl8iTf031GjBKZd
 2MWfQ6q96z/pb6s7r09yBdjbgUQgN/JCsDk7JMNXte9MGvWW15ySmxy6EcitPf6vFKGT
 szNajtR7ix5uejkO7T8NPnbyhKxoqiLL57Ns33znOYrBJjAj+9IMgUaaOHT9aCY4i2Hy
 tcb0bTJ8fTbc/ARPI4DL3RlKzxMR+4hP1c2ZeiFxURYguLTjfIayeml71elMOgE0MGIc
 L4OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710268888; x=1710873688;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=owm/IAg32HMjFxsQJhlmbOKm3Qbhqz7rn/KBgK1esIo=;
 b=M3AKTwSZpHqgKu377cp9ziimqvDRhtzCFlFRHR00rZOueuczK/tuv0T96QKXPG/ZCq
 f2qcGcYX3ln8hcVXoW4Y0K4xIut2jVNKABCqIlcZm20j9msMWOmYZ3sFM13qbvpyY2IB
 rVhl4QltTOzBxulvQnjYKh7sXOJp0nNahdgRXHokIMLZ6//fpH92FvQLQXacnLViYNkG
 UlTF6Im6M9gF4kxGfOVDaB+gc9tGL6AAfsTmttgMHWVC/IHFEV7FA/6Re9ZEX0xkWMoS
 p+Uh6u1f6o54+XTGE1+22Q5Ftq+S9PZajzO0+WK5mjvzE+G1hQxQFmtaoB2+ZBbEakki
 DN9A==
X-Gm-Message-State: AOJu0YxF0vuTCDf940fyf1vSi/+/l5sA1qoZB/vQq8vs3TixxbnU56uW
 BRs7WxaVXZ8pUKg1bUC7IH1EEmXyI+qcmw1Ic5w6QBCDzJLJELlGDQ+s7VXSa0ScZ3yLT3kMDej
 p
X-Google-Smtp-Source: AGHT+IHHw1S+E4zXfdKc15L8gOiA8O5NKoRm3BygvXogYUWXLG+GG6YYLxhCTY+0OrdKDAL4mSweFg==
X-Received: by 2002:a17:902:f7c7:b0:1dd:61a6:ecd1 with SMTP id
 h7-20020a170902f7c700b001dd61a6ecd1mr9066513plw.32.1710268888728; 
 Tue, 12 Mar 2024 11:41:28 -0700 (PDT)
Received: from stoup.. (173-197-098-125.biz.spectrum.com. [173.197.98.125])
 by smtp.gmail.com with ESMTPSA id
 b11-20020a170903228b00b001dca40bb727sm6951739plh.88.2024.03.12.11.41.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 11:41:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 8/8] tcg/aarch64: Fix tcg_out_brcond for test comparisons
Date: Tue, 12 Mar 2024 08:41:15 -1000
Message-Id: <20240312184115.365415-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240312184115.365415-1-richard.henderson@linaro.org>
References: <20240312184115.365415-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

When converting test vs UINT32_MAX to compare vs 0, we need to
adjust the condition to match.

Fixes: 34aff3c2e06 ("tcg/aarch64: Generate CBNZ for TSTNE of UINT32_MAX")
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/aarch64/tcg-target.c.inc | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index 38446c167e..56fc9cb9e0 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -1464,6 +1464,7 @@ static void tcg_out_brcond(TCGContext *s, TCGType ext, TCGCond c, TCGArg a,
     case TCG_COND_TSTNE:
         /* tst xN,0xffffffff; b.ne L -> cbnz wN,L */
         if (b_const && b == UINT32_MAX) {
+            c = tcg_tst_eqne_cond(c);
             ext = TCG_TYPE_I32;
             need_cmp = false;
             break;
-- 
2.34.1


