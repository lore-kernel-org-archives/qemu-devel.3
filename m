Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD0D1C982D0
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 09:35:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x78UZ-00042Z-Ax; Thu, 17 Sep 2026 05:33:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x78UX-00041h-5J
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 05:33:17 -0400
Received: from mail-oo2-x0f.google.com ([2607:f8b0:4864:31::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x78UV-00017V-C8
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 05:33:16 -0400
Received: by mail-oo2-x0f.google.com with SMTP id
 006d021491bc7-6b1ae7089c1so272200eaf.2
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 02:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789637594; x=1790242394; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DR4ago32rbhsMJJC/vm3OLbSxd1/1ShpsL+4aOfOAmg=;
 b=uGn24EmcrQM1WvkvVYwnf2j+bKy0Kf1cYFoVW+HAiz8sxNyYzCYCzmmwR4kRIMNyfg
 4Oe5KEcTqEwWgc/Dv/gRA4EFAgtBa/yt2wd/hiz4OzreVGwKhoiyv1ftmCKxE3OT4FiA
 DxyMJlq9JpoEtE6GYkt8WfC+IRkfhlXbeySOuF+29RkR6LENSYmS0sgYObDkUBruLR8r
 VSTYUEmSbhUWFwpVYr1Xy90PFxMoIMsmcxiILhuVv1unxUWzS2A2n7cHStRn990LiQuk
 UPOf6r9PZk4MAviXQkcdGwbPWZBiJIb1VGK6dVgl4YX6FSDhJMeASuGDQEXI9GKDtS5E
 iJTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789637594; x=1790242394;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=DR4ago32rbhsMJJC/vm3OLbSxd1/1ShpsL+4aOfOAmg=;
 b=QKGtDMj/ra47oHXOjVzoVx80lm4sqNoZq4joIVqI8jQzxpfgiDkH+epcH0U9fw0L2P
 1JVdfGdl1WnoQFL6v8AqTn9SgEJaRuLTRAOcYLgnWWwwBrP4sJIHuvKV1FJk8LbT3rGr
 ziPq+h72HIRmY6Tbr5n6EUuugGqJWMwG2Q+lbML4HlMZxlXhg+hJrNxkL4XVwhmJ1SAE
 AgYe/qSQWUGJblaT0he1jhOxWTRKY8QgXs93xLkXy/zI7QnRK9wHjFrO8fCq+JmrCs/n
 EE6klaizFDZrRLIK/Ii6WUFQFd+4lNIRMQwKyuG5PQM1BaH1B+avzOu3b797Vzpj6ygQ
 xm6A==
X-Gm-Message-State: AFuF++n/oZVh6XduZAoa0IOguNfP+7T2dvAs6uxtzvUYg5RenDv6kN1l
 ivI+PvsDNCUFzOTBFnci4qE1xLQT4QuzpcRPecnmxRj5JNPqeU/pvqBJUrMvPEymXw4wQr/Gejn
 S9nAa6gY=
X-Gm-Gg: AYBFou1jcBaiFlvyrPBc7dhApZJmzFUFdJwUSURnCKSdovbXoEWQE6qaRKDr2kK46KB
 pN41DIrYgqWtmewBl+StwSKqsNKEQgsXe6eVEdqxxBZoulZ7KbZZ3j7testjGZKdSK+UYEKMNLK
 ag8gZU7BE/LxHlfrqDozrt4dAGZC/CZ2kIkYbtp45BqM0kk+YvDyIkdpzUiPK4dIf2MQenp7fBh
 yrXXgcd+KES3+4HP+mkLVKlEZFtF7I1SBjkNNq6hiG1ZV6dTGuqowgGbJYzcwx2AiZ+eVx/xWsQ
 pdN+Hz8x43kiRbOB+IxZU0Upw0Rhq6ilkqj83AIWmBwGDQNoKaC4Wxo/UdV3cPVLYThiY+WJZ4A
 fPEEopuyi8ZflJpic7IJq1XRQdS9nDgvLj7HKNMYNABTLW2Rap2Mq4/pE2c77CaUtH8ypO5z4Hp
 jd/LTrGK1LZ8meFv/XLH6gE5otnNovSq97Glz9w18e+SU1OxN440RIz8j+JXi3TBDWjO9cKGy06
 DBSa2A=
X-Received: by 2002:a05:6820:c2d4:20b0:6c8:dccc:eb1d with SMTP id
 006d021491bc7-6c8dcdc3073mr2339394eaf.55.1789637593961; 
 Thu, 17 Sep 2026 02:33:13 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:325f:1938:d075:8c13])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14395d771e5sm12494696c88.15.2026.09.17.02.33.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 02:33:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v6 03/13] target/loongarch: Use tcg_gen_goto_jc_tl for JIRL
Date: Wed, 16 Sep 2026 23:32:57 -1000
Message-ID: <20260917093307.1092084-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917093307.1092084-1-richard.henderson@linaro.org>
References: <20260917093307.1092084-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:31::f;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo2-x0f.google.com
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

From: Matt Turner <mattst88@gmail.com>

Allow direct use of the jump cache for direct and
indirect branches.

Signed-off-by: Matt Turner <mattst88@gmail.com>
[rth: Drop the change to DISAS_STOP for now.
 I suspect both uses should simply use DISAS_TOO_MANY.]
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/loongarch/tcg/translate.c                   | 2 +-
 target/loongarch/tcg/insn_trans/trans_branch.c.inc | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/loongarch/tcg/translate.c b/target/loongarch/tcg/translate.c
index 124dce62695..b0ff1f7dff7 100644
--- a/target/loongarch/tcg/translate.c
+++ b/target/loongarch/tcg/translate.c
@@ -111,7 +111,7 @@ static void gen_goto_tb(DisasContext *ctx, unsigned tb_slot_idx, vaddr dest)
         tcg_gen_exit_tb(ctx->base.tb, tb_slot_idx);
     } else {
         tcg_gen_movi_tl(cpu_pc, dest);
-        tcg_gen_lookup_and_goto_ptr();
+        tcg_gen_goto_jc_tl(cpu_pc);
     }
 }
 
diff --git a/target/loongarch/tcg/insn_trans/trans_branch.c.inc b/target/loongarch/tcg/insn_trans/trans_branch.c.inc
index da077786585..d4318dfa437 100644
--- a/target/loongarch/tcg/insn_trans/trans_branch.c.inc
+++ b/target/loongarch/tcg/insn_trans/trans_branch.c.inc
@@ -27,7 +27,7 @@ static bool trans_jirl(DisasContext *ctx, arg_jirl *a)
     tcg_gen_mov_tl(cpu_pc, addr);
     tcg_gen_movi_tl(dest, make_address_pc(ctx, ctx->base.pc_next + 4));
     gen_set_gpr(a->rd, dest, EXT_NONE);
-    tcg_gen_lookup_and_goto_ptr();
+    tcg_gen_goto_jc_tl(cpu_pc);
     ctx->base.is_jmp = DISAS_NORETURN;
     return true;
 }
-- 
2.53.0


