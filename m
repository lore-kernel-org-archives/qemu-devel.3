Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22D1606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 18:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=zmET4IIQ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMrm6-0006uv-HF; Fri, 30 Oct 2026 14:56:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xMrli-0006rV-PG
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 14:56:04 -0400
Received: from mail-yw1-x1130.google.com ([2607:f8b0:4864:20::1130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xMrlh-0004nZ-9m
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 14:56:02 -0400
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-8ab43af5e97so13182647b3.1
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 11:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793386560; x=1793991360; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iVMFpH/aq+G7a/y6geHD1weiXzxXQjxEl9EYUq2K0ZI=;
 b=zmET4IIQlKmZT8vOBDebmAV7BZ1hRR4NVX6fN8WjSsurgrzgZNhrQS9A1AJCZOIXuO
 /P3Zmls8K2MF5wC2j8dghfM5tToFitqN/M5GauyHRzXPJ7dj4gay6SwpULlJfBcU5Dgw
 rP38cwAdUf+9njHhhVl81TyfPHa9zWFsXavhvIvc8Hh0kP4I81/qpTxgOjmRpwFs82cK
 rcMjyy91BwMSGXB5DbqU6HJxYbtZ4LNNy/ywQqkNDpoM73itzRumNuH/7HuttQgEmXvO
 +IsGHwk82JYl+3aeYcHU+Mipf8AZ0NL/UtHTbCavBCVnyh7tiv+SKDGOueUUmOjQgVF5
 hTvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793386560; x=1793991360;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=iVMFpH/aq+G7a/y6geHD1weiXzxXQjxEl9EYUq2K0ZI=;
 b=OeTO85SIg/2lz/uf4noxh0fL3mHwEMkLUCdHDbVXK9oVP586DJtqX/6rLbWZsNChym
 H4KquU4Mf++XnEAIpC0c7C0Se3rhdvUtCySWYVgrbqkedfeusYE+jgRVi38AttWBciQq
 ypeX+CalU5a6FXYzpn8k2/xn4zxrr4a8sfhS6tePOc6Qh076lTuB/CewLzcdhmi7ebYj
 QHCStNcYVV7x0eScvd2YTdGvKBx7za4niic1MecsPF2nNKTzcXsO79NpgUy2KUTvsZLh
 fwe+apVunVuQBWLsDu8xcLy3x7LS6CvHQRiiHqziVxwpcZQ2pcvHKrptUy+vto+jEZm7
 kFBQ==
X-Gm-Message-State: AFq9FYIQmBciZ2yGFb3Xf26XEo/rOxdudoNC9wGy3eIBNvSNp19Bzx9t
 OFeyWCRI18XDCNQe9R5kGTrBCd6NTVlNrz3o5POKWaeLT/sjChx0UJ/eSsizlabjSEc5KxZCeQG
 8m2fX
X-Gm-Gg: AYBFou0Depu8jloXFjZX7xgHPe18eUlHYCXix7MYoPBs5ZCN/gCBp1ibL8eoVThytWd
 p1ge4HXyyPsFsMYPptIRMJ9NRpJyLkrVxqqDbDXyWXcSnLCsagSNrapB1fEIiinNcoHERmYQxJh
 fagWUnmpHV1V3dlYUgngLbW0aehebGY99e5SY98wLHo7gWNxA/rC5Xheee+Lpv+PerPyR/OSUnk
 hZNr8+8yAXuEjvMAB1WVnaLTEKwb+TIjDl47UCqBu77ReK8oOFf6jYhoZK+sgmnVeJS3DEtVrTo
 JukSkWDAKukV3kMkJIf7+LqnlJZNOIdgceBS2rNPiweujyVwpDluQ0IoOMSd7lOxG6eKl+GOllv
 17t0YfhIZ3348kVbzLzpuuYt1XPNXRCbWb3xmoNUprMa0WPJcYMIBp+yoHIMUS+k3jOKMMjL4QN
 6n76lHGqG5bvP9agq1y7OpwAV5QrLxHAoUK+1yKJZ8VATDYdEfHlw0fQ/r/SVdQobeULtT2suM2
 7cT5A8ytDuoJvsYUODrcBMKYo7fQjVmGwSYxwaMSQ5aGpqaL/px2SypotRcVzTvTbLu+icU6zSa
 3qqFOt8P8idndi74/FmBIzKrOyjgSJ44AaU=
X-Received: by 2002:a05:690c:6609:b0:8b0:bc8e:9d75 with SMTP id
 00721157ae682-8b2b6756fb4mr20448277b3.22.1793386560051; 
 Fri, 30 Oct 2026 11:56:00 -0700 (PDT)
Received: from stoup ([2607:fb90:5e62:412b:1381:b0c1:1339:9c82])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8b2b71a13b1sm13209657b3.39.2026.10.30.11.55.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 11:55:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: iii@linux.ibm.com,
	mattst88@gmail.com
Subject: [PATCH v7 03/14] target/loongarch: Use tcg_gen_goto_jc_tl for JIRL
Date: Fri, 30 Oct 2026 13:55:40 -0500
Message-ID: <20261030185551.193092-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261030185551.193092-1-richard.henderson@linaro.org>
References: <20261030185551.193092-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1130;
 envelope-from=richard.henderson@linaro.org; helo=mail-yw1-x1130.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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
index 124dce6269..b0ff1f7dff 100644
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
index da07778658..d4318dfa43 100644
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


