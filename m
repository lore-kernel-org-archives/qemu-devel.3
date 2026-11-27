Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B23606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 06:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=ncjf2CJs
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWp4P-0006JI-RJ; Fri, 27 Nov 2026 01:04:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWp2H-0004G0-US; Fri, 27 Nov 2026 01:02:23 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWp2E-0000Wv-Rm; Fri, 27 Nov 2026 01:02:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1795758881; bh=IxtEAMOX0TmTOJfGbu/ErttVo58ruW6ovHpkhX8oZtw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=ncjf2CJsoXve7WJqkHZ5VeVycYqA8UOXtx4CHDIKyQ3vEUjnhfK1LChhfv22VL3sQ
 aGeikInwdUzsgmdyFbjFxKm6TfWR7hOaIpJmh1lXZIM8Jn0Av0z8gG44s18G3lx9/P
 LUkGNh2gvAKvom3JbDe+CL1u1eCw4RuX0lfQTB5LjPPP53suqJCbVYICRYs0F09pyw
 il8xPZADcFmi5zAUm1Zq/EMk9Dsvt0OOT3xIgqbLsMqiBExw2u+44lngxftCiRaxiI
 GLSO8jRNRXGA0a9FTNbCftg8MfuAVfWp2g1Ty9epzODZllTP/rIxzf79aVoCYQJovO
 SaS1OTq6h/fWQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id F11371EA317;
 Fri, 27 Nov 2026 08:54:41 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id EDEF0469957;
 Fri, 27 Nov 2026 08:54:41 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id BAE60CF2AE; Fri, 27 Nov 2026 08:54:41 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Matt Turner <mattst88@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.16 v2 140/140] target/ppc: Test CF_NO_GOTO_PTR in cflags,
 not in TB flags
Date: Fri, 27 Nov 2026 08:54:06 +0300
Message-ID: <20261127055421.39015-81-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.16-20261127085304@cover.tls.msk.ru>
References: <qemu-stable-10.0.16-20261127085304@cover.tls.msk.ru>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

From: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

CF_NO_GOTO_PTR is a TB cflags bit, but it was tested against
tb->flags, where bit 10 is HFLAGS_SE. Use tb_cflags().

Cc: qemu-stable@nongnu.org
Reported-by: Matt Turner <mattst88@gmail.com>
Fixes: 46d396bde988 ("target/ppc: enable PMU instruction count")
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20261117080843.8314-1-philmd@oss.qualcomm.com>
(cherry picked from commit da70db241dc765d5dc547a416ce6aa97c449d216)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index a52cbc869ae..caa626c53a8 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -3648,7 +3648,7 @@ static void gen_lookup_and_goto_ptr(DisasContext *ctx)
          * tcg_gen_lookup_and_goto_ptr will exit the TB if
          * CF_NO_GOTO_PTR is set. Count insns now.
          */
-        if (ctx->base.tb->flags & CF_NO_GOTO_PTR) {
+        if (tb_cflags(ctx->base.tb) & CF_NO_GOTO_PTR) {
             pmu_count_insns(ctx);
         }
 
@@ -6669,7 +6669,7 @@ static void ppc_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
          * tcg_gen_lookup_and_goto_ptr will exit the TB if
          * CF_NO_GOTO_PTR is set. Count insns now.
          */
-        if (ctx->base.tb->flags & CF_NO_GOTO_PTR) {
+        if (tb_cflags(ctx->base.tb) & CF_NO_GOTO_PTR) {
             pmu_count_insns(ctx);
         }
 
-- 
2.47.3


