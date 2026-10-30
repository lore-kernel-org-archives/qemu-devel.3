Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB22606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 19:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=OY4f7YWq
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMsW6-00069Q-Ii; Fri, 30 Oct 2026 15:43:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xMsVi-00063u-K2
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 15:43:35 -0400
Received: from mail-oo1-xc2e.google.com ([2607:f8b0:4864:20::c2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xMsVg-0000A5-TH
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 15:43:34 -0400
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-713e6ecf595so1051056eaf.0
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 12:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793389411; x=1793994211; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=L9U3xpR2VVEc/VBrMNdYEpXepFo3fcltUSwxFqBgYFE=;
 b=OY4f7YWqz5cjhOU2KECWVccQCRJ/PSqH5PTDPzFGDqt6xUQXxCgcNrfaSgZXIo45XT
 XoTmXU01C29v1NXUDaVEQdKrzAHkcBoxHuvpQUHV3Yd0uZHnwVvML29xcP86v5jgfrGi
 vXLo49Djau9OH5sazcgB3qtS48Rr+icCEZsFqV2V6CoXuV3A/xbbRn+HX7T7cEPypZDd
 EyGlmaSSjHFGSzWsVtwek5d/zYfVaJsDrOzTeDVNEgSPrZCT43v7MtICbBA+l6VUQxcn
 dUD7ljRwiZ8xvtN8OOyTkks/r5LWLI8AtcdD4FJHwaHc/m5jEBWCVODyy3hMpvLNKD1m
 NIdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793389411; x=1793994211;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=L9U3xpR2VVEc/VBrMNdYEpXepFo3fcltUSwxFqBgYFE=;
 b=gnqc5UW9o8xe84gKiHdoRrQntJowq3Ao/HePRqs4j4SFFMPd7suAKRzw+rSqFmcMEa
 pgWZ7l+qjRllSCgOJDelnNZTnHT7F0d61n3Yz+gS/OJ3a4h+WYvJvFhN6VnusKYWO7yc
 3xkE2H9+XfwVm9IIsLhWGdHkkhzgUykScoe1XShe0lW6jP6YlHs/wSYgJtgr0zOgkiX5
 I5984NV3lHdZfXtXj6UYEtuk5XupUDQHc2Lxrvazm4uEMK712QiC/tf8/foeGKWVHTzI
 Fa0fXDlYxCsh68Dkn4kHP+Hcv6SpKKdo0KnWx2K5k9DGfCHg8hZi50lulkY301E898YR
 6eoQ==
X-Gm-Message-State: AFq9FYI2GLG2wCbHM4KiQYUT0gBlfYbrIx17DLKzPDOn3yPAny7rNd+n
 4j+IsjZvd0met9AYdPFS8nf3NEkMF/LJjNp4p+CSgCCD8FTe59xtWy+k6cEm+d4HZMs3bFPAiYb
 5f5ut
X-Gm-Gg: AYBFou1M0CCm74367orRPEpoYIzcjYeyRKww1//aht3hvkJ9z0cj/6ryhFpEIz0+ArH
 VaWDv2q8o1B+o9911yq3ucUpn4aZHuot5xpI9L/YKHkwTXrP6OKe0OLzKrGyXumJVXeap7rVgTb
 +facV5XCCS54uzUgKf290jmtq3e+7/56oNuhv+aIxfreH4t4duGzSL3xW22UQAswZkHkISTbmtF
 6Zr8s3m8YQFxIxZE82dGlK7GrJARFPMYf0nz2KAS/J7yIiOLUVc119sGfNffkPDCf8QF3IxO/pW
 1EWo8In7HlF4RfAtL2URw9pt14J1C1IQ8cXg/kItQO/WanU3aBIFpKaQZPosgUNjUncKftGB22Z
 wuwh5NLcUdB2DbI19BXbFtGOo42RGBZkb6gLQ9oQEsMZ59SyliMVA5ff+rsBu2KkoFUuGw0C1OI
 M50KPgKZJu1Dw1smzSGMeABY0ACGCI61ZKxllFFqu5syA2HFPm4PV9I0MlMc31mGg6srXNsdviQ
 8yAj4tFBqIDoSWIGDr0rYcWLGH/XXCXyo2W5L0bYE19ntg8pyvwquRBzqUTyVVoBusYBURFgKs+
 rppPOEY5JtZjkFDbD0jFFweFfeyUNQDLs2I=
X-Received: by 2002:a05:6820:1898:b0:6f6:1e3a:6e1 with SMTP id
 006d021491bc7-714ddf7f9c1mr3641187eaf.44.1793389411493; 
 Fri, 30 Oct 2026 12:43:31 -0700 (PDT)
Received: from stoup ([2607:fb90:5e62:412b:1381:b0c1:1339:9c82])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-85d351e77c8sm2654768a34.2.2026.10.30.12.43.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 12:43:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 8/9] target/arm: Rework gen_goto_tb to gen_direct_branch
Date: Fri, 30 Oct 2026 14:43:17 -0500
Message-ID: <20261030194318.319310-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261030194318.319310-1-richard.henderson@linaro.org>
References: <20261030194318.319310-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
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
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The only remaining uses are true direct branches, or
simple chaining from one TB to the next via fallthru.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 0f6331a695..edbf67b03c 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -573,15 +573,15 @@ static bool gen_indirect_branch(DisasContext *s)
     return true;
 }
 
-static void gen_goto_tb(DisasContext *s, unsigned tb_slot_idx, int64_t diff)
+static bool gen_direct_branch(DisasContext *s, int64_t diff)
 {
     if (use_goto_tb(s, s->pc_curr + diff)) {
-        gen_goto_tb_int(s, tb_slot_idx, diff);
+        gen_goto_tb_int(s, 0, diff);
         s->base.is_jmp = DISAS_NORETURN;
-    } else {
-        gen_a64_update_pc(s, diff);
-        gen_indirect_branch(s);
+        return true;
     }
+    gen_a64_update_pc(s, diff);
+    return gen_indirect_branch(s);
 }
 
 static bool gen_cbranch(DisasContext *s, const DisasCompare64 *c,
@@ -1780,8 +1780,7 @@ static inline void gen_check_sp_alignment(DisasContext *s)
 static bool trans_B(DisasContext *s, arg_i *a)
 {
     reset_btype(s);
-    gen_goto_tb(s, 0, a->imm);
-    return true;
+    return gen_direct_branch(s, a->imm);
 }
 
 static bool trans_BL(DisasContext *s, arg_i *a)
@@ -1795,8 +1794,7 @@ static bool trans_BL(DisasContext *s, arg_i *a)
     tcg_gen_mov_i64(cpu_reg(s, 30), link);
 
     reset_btype(s);
-    gen_goto_tb(s, 0, a->imm);
-    return true;
+    return gen_direct_branch(s, a->imm);
 }
 
 
@@ -1837,11 +1835,9 @@ static bool trans_B_cond(DisasContext *s, arg_B_cond *a)
 
         a64_test_cc(&c, a->cond);
         return gen_cbranch(s, &c, a->imm);
-    } else {
-        /* 0xe and 0xf are both "always" conditions */
-        gen_goto_tb(s, 0, a->imm);
     }
-    return true;
+    /* 0xe and 0xf are both "always" conditions */
+    return gen_direct_branch(s, a->imm);
 }
 
 static bool trans_CB_cond(DisasContext *s, arg_CB_cond *a)
@@ -11265,7 +11261,7 @@ static void aarch64_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
         switch (dc->base.is_jmp) {
         case DISAS_NEXT:
         case DISAS_TOO_MANY:
-            gen_goto_tb(dc, 1, 4);
+            gen_direct_branch(dc, 4);
             break;
         default:
         case DISAS_UPDATE_EXIT:
-- 
2.53.0


