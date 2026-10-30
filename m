Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85CC9606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 19:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=UoXEuGfP
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMsW4-00068z-Cu; Fri, 30 Oct 2026 15:43:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xMsVg-00063S-AK
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 15:43:34 -0400
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xMsVb-00008o-O9
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 15:43:31 -0400
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-83bbcfba0ffso859290a34.0
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 12:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793389406; x=1793994206; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4s+HOF9Q3xtcH8tmlmlazPhw+aN08WYT48sQMLUqAZo=;
 b=UoXEuGfPCvmQTVBewMSbQct0HoZECrDiJFRwGcunJjRAC7W/gGfN32awJCaCgfH1Ye
 4y7uGLYiSPJBrS7Kwni1I0Ngry8WwM3UNQNS/ALHCgTo7G2hmAyXcj7fqzRRqGrqCf0v
 wMITGcVa0CYTu2+IrcA5emEAl3UvSPTksJdQ8pfv6fJ4K7QmCcQHJUMB0AbU62SX6Sye
 6pbQ7alr8s85VBnjwgrASYPNEG/PBe7c+peB2ILbG/XaaW4ZTAznuh3ujiBcrgTocHSu
 8iRFR4OO/mEGQvEmYCFHBB2AN1/smURpd1/TWhpImDdrm8DDkYf6gxzFUqkgp5BVssEb
 Pjrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793389406; x=1793994206;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=4s+HOF9Q3xtcH8tmlmlazPhw+aN08WYT48sQMLUqAZo=;
 b=CMRMrhuvl6DySCwIFhks5GIDtowRFmR+nNCzlq/Z2a+TnAIBm08OSBdHTMkLOJSWJC
 /GcWtwISssm/RXTVGr7bN3KEuc3aYSCQsiZNG4PTNy6RAiApsnPCdOhttc9NNi0Ckqh0
 2OAxoQsY+exkd9arRtX7QK+DA3tOHwcLAdMuFZCHmm6nx4w/zFPulQlKCLpOcD+W8eeQ
 gT9kcgEWaUPcA+cbLUpunaM6Vo1M0tkNLvaGjkyfz5KXiJrnBk4F5/Q0NWe/k5yqXH6R
 iz+YD8U02DqV+88MC80WxZwxkppz7gykWadV/uxIf/3oELI1H0KeMSxAlsAt1zVGQZuh
 xZug==
X-Gm-Message-State: AFq9FYIE/X5ElcPY/xprfA9oFtiMpJEBPvO8qCj29WSANl9QI6ESj5bn
 0e6PqKXruC/YFxig8CXXRqHIpu02P/z/2bYl6W37mzsCwSbrEBIftwFHXZXrk8+T+W/gD8wmtEz
 xeQHh
X-Gm-Gg: AYBFou3FoAK+RnpUrldN+EStqFhG8hTBqaFlh006ge3qnJaRk08fcFaFtWpkBEAQwRP
 t1Uab4uIlnTO5NqhSjRXjMgx92eedxhnXe9EZSv3llKjFs+HFylhedI5mKzJXBDkbvP/zBI7mWt
 eZF/aNh6ScmAHFqQu/64XeeAfgxoMaMDbyEK8BcWRIxYabWN3CJF/ixPbNKftTaeG4xqC3Ln9gK
 dIk8RVRWyD1J7SCy2M2Yibh4W/Z0OWf63b5mare+TlFYIJ1Zu8hBlulcP/uPUxfsO0R6fnL2F8u
 dHdaJbtTVrJQ+J/ezlA/6bqma11PRtU04AhzPP7xT1pAYxXt3QnymDZQ7Mg4OrZjF+8ZbIM6aXd
 e0aB93F2BvgXSDgPpUlHMgDNHdTnehhAgSR8BR9ME2tpnf6GVZ3KutSyKNufgOsls2i6DFHpYtu
 rLRD3Q3VFO6V48FfqMhoJ4IJaBVpzYYjlv6CZ8t091m2jjo09nmCjloa7SDYBvXZcV0PZCksz3k
 SEGNfih/74PVvJlBfE3cdAyRNPMNui8/xMplvuHgOiasH3EzYfO3+Sa+zMPk+SrlfY7gyOCl4sN
 a/UXSK3zgUPig8IEu7LIwzSA9PcC48ll5ulRViPyqzfTbXjmAio3GA9UXw==
X-Received: by 2002:a05:6830:4393:b0:817:bb8:cb7d with SMTP id
 46e09a7af769-85d36575f5emr2814404a34.18.1793389406400; 
 Fri, 30 Oct 2026 12:43:26 -0700 (PDT)
Received: from stoup ([2607:fb90:5e62:412b:1381:b0c1:1339:9c82])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-85d351e77c8sm2654768a34.2.2026.10.30.12.43.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 12:43:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 4/9] target/arm: Split out gen_goto_tb_int
Date: Fri, 30 Oct 2026 14:43:13 -0500
Message-ID: <20261030194318.319310-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261030194318.319310-1-richard.henderson@linaro.org>
References: <20261030194318.319310-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::329;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x329.google.com
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 38 ++++++++++++++++++++--------------
 1 file changed, 22 insertions(+), 16 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 884b7d78e2..4289b65fdd 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -541,25 +541,31 @@ static inline bool use_goto_tb(DisasContext *s, uint64_t dest)
     return translator_use_goto_tb(&s->base, dest);
 }
 
+/* We must have already tested use_goto_tb. */
+static void gen_goto_tb_int(DisasContext *s, unsigned tb_slot_idx, int64_t diff)
+{
+    /*
+     * For pcrel, the pc must always be up-to-date on entry to
+     * the linked TB, so that it can use simple additions for all
+     * further adjustments.  For !pcrel, the linked TB is compiled
+     * to know its full virtual address, so we can delay the
+     * update to pc to the unlinked path.  A long chain of links
+     * can thus avoid many updates to the PC.
+     */
+    if (tb_cflags(s->base.tb) & CF_PCREL) {
+        gen_a64_update_pc(s, diff);
+        tcg_gen_goto_tb(tb_slot_idx);
+    } else {
+        tcg_gen_goto_tb(tb_slot_idx);
+        gen_a64_update_pc(s, diff);
+    }
+    tcg_gen_exit_tb(s->base.tb, tb_slot_idx);
+}
+
 static void gen_goto_tb(DisasContext *s, unsigned tb_slot_idx, int64_t diff)
 {
     if (use_goto_tb(s, s->pc_curr + diff)) {
-        /*
-         * For pcrel, the pc must always be up-to-date on entry to
-         * the linked TB, so that it can use simple additions for all
-         * further adjustments.  For !pcrel, the linked TB is compiled
-         * to know its full virtual address, so we can delay the
-         * update to pc to the unlinked path.  A long chain of links
-         * can thus avoid many updates to the PC.
-         */
-        if (tb_cflags(s->base.tb) & CF_PCREL) {
-            gen_a64_update_pc(s, diff);
-            tcg_gen_goto_tb(tb_slot_idx);
-        } else {
-            tcg_gen_goto_tb(tb_slot_idx);
-            gen_a64_update_pc(s, diff);
-        }
-        tcg_gen_exit_tb(s->base.tb, tb_slot_idx);
+        gen_goto_tb_int(s, tb_slot_idx, diff);
         s->base.is_jmp = DISAS_NORETURN;
     } else {
         gen_a64_update_pc(s, diff);
-- 
2.53.0


