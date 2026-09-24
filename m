Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07A70C98321
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2026 14:51:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9klo-0008QB-49; Thu, 24 Sep 2026 10:49:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x9klZ-0008Kv-MH
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 10:49:46 -0400
Received: from mail-pz2-x0d.google.com ([2607:f8b0:4864:3b::d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x9klW-0005EJ-4o
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 10:49:41 -0400
Received: by mail-pz2-x0d.google.com with SMTP id
 d2e1a72fcca58-85469a34908so1527384b3a.0
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 07:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790261375; x=1790866175; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=SUHli38uwCMd7XorFSNsBkETvs+zfkoOrDzDPTZtZxU=;
 b=pdPheIKfiL1bvi6o1GuSV6aMFhBsMo7dn2KPQVx2Rx1lnFbVlRzgGxNm8xN++KfuX1
 rSbUDoHocOdEsyEE3BcQaIeRR6O8Kb0VSlVHb1nGdhKtrcA3GGhvbc42uOFHfcg9KpgG
 CUAA8RnFECfmC28bEGj3LjM4sFdykR1ulqves9JHv3ajlxh187SeJ6LZYibG+X+Xiw89
 kJEQBotzgBBwAU1CD4xxxUOF6lgL34sv6GdGlvYWG2TZbuxsPLAL7Lu04Rp5bd4Fnp8L
 2ZpaL0gWe4i5IsrJ9VhAWvo7ZMpHtqdwSERvlAebspmHDpSlbBRvHqZOWtAmDPd/4xJo
 HTow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790261375; x=1790866175;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=SUHli38uwCMd7XorFSNsBkETvs+zfkoOrDzDPTZtZxU=;
 b=qLlVqusoMk3jafdB7W7l5xIQTdjL2FhMAW2R7U8PC2kILeFl6d+fTb0mwlLgQgzclY
 RZtPcVk/1OlOctdKefV8sjdzb/V6FjMtWRgQNYqLIBedcjhWdHMBjtoAnzhwB24DGlpG
 pMTo0WJbtxNZHEVcKImT8XgYyZvi6ZfUCIxf4vdUXAEZD/NwypW2SgP3jWX03WJfu8lw
 EdB4wSaH3ihrb7MeAPkm93qU3BGs08KFU6hIUKmp2eZw34NuDPXWcNG+ZGxBPA4N+RDo
 RBRqpADCxU0jLrN3rwRM1dIm2XvDIeUefXJVAKbVf7mK1BrPXxDvCk2OESJGJfX91ddJ
 3ksA==
X-Gm-Message-State: AFuF++lA5i4mpQLeulm+h7VGIOZqnLCeP/xamB4FEYhAnXlsOY4KKG0f
 AGf242xNo0k3LBTh4KcERFFvbjoqOMHAMqipi8Qqsa+igt5ItpffwQZ9TDzmum8efsCw+cCCdVT
 myk9o
X-Gm-Gg: AYBFou3fU//mB0dlOrdTBXonJ1dg8jc3R0NSR6Hhn0IRWvo9KBxhfddJ1Zd3bKgghEm
 6kvd2MSf/JYbgWmPsgK1LS13M/LNNELOMCydj81vENkgStOWPKe4nJHly1tFDsMhdMVGml8R6CM
 6g7MnzLMxrlXJU5Irar7tJXbFOc+ouMZX7XoA9aKIdyZFYrTR6AGP88S0tXVocJ1qei1T8REA5W
 vvQ4J/5DTKLy7aP82/7NYMgkjng5AZFQ2SMZJ4FoXKXKiwaT2aKaixOvc34vAztkVTPObXMYgCf
 7fe+odSzr+3IZuR3yNJEp8qh8e7Lx6N7zBTqRbKnIHr7NGjRSg+bOZbo6GRW8O5/7JySKaw8bYS
 JiLRvX3ENN0age1vHJsvwxrooV1+VPRWAnYGxj96BhTKYirJkbfRj+YBOczbrpUlKHzbMUnhUDu
 42P7KpD6IgCFS/G57WBmEzM6FPRLQxsViAWpQfBOw5+d3zKZDMXScuif74/hPeX2vjV/50umhhr
 JyWHmK0koM+9xLJ+60lsodMbFtW6QUM9PuCuZ42
X-Received: by 2002:a05:6a00:2d81:b0:87d:3894:196a with SMTP id
 d2e1a72fcca58-87ea1483aabmr2439254b3a.57.1790261374685; 
 Thu, 24 Sep 2026 07:49:34 -0700 (PDT)
Received: from stoup (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-87d1dad3978sm3209818b3a.34.2026.09.24.07.49.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2026 07:49:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 2/8] target/mips/tcg: Fix zero in gen_mxu_d8sum
Date: Thu, 24 Sep 2026 07:49:25 -0700
Message-ID: <20260924144931.161335-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260924144931.161335-1-richard.henderson@linaro.org>
References: <20260924144931.161335-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x0d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

This is obviously an attempt to set temps to 0,
but accidentally passed NULL to a regular move.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/mips/tcg/mxu_translate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/mips/tcg/mxu_translate.c b/target/mips/tcg/mxu_translate.c
index 7961b073144..9559b8aada3 100644
--- a/target/mips/tcg/mxu_translate.c
+++ b/target/mips/tcg/mxu_translate.c
@@ -3109,7 +3109,7 @@ static void gen_mxu_d8sum(DisasContext *ctx, bool sumc)
             tcg_gen_add_i32(t4, t4, t2);
             tcg_gen_add_i32(t4, t4, t3);
         } else {
-            tcg_gen_mov_i32(t4, 0);
+            tcg_gen_movi_i32(t4, 0);
         }
         if (XRc != 0) {
             tcg_gen_extract_i32(t0, mxu_gpr[XRc - 1],  0, 8);
@@ -3120,7 +3120,7 @@ static void gen_mxu_d8sum(DisasContext *ctx, bool sumc)
             tcg_gen_add_i32(t5, t5, t2);
             tcg_gen_add_i32(t5, t5, t3);
         } else {
-            tcg_gen_mov_i32(t5, 0);
+            tcg_gen_movi_i32(t5, 0);
         }
 
         if (sumc) {
-- 
2.53.0


