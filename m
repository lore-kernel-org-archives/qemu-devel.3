Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19432C88E72
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 23:10:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6FnV-00036m-W0; Mon, 14 Sep 2026 19:09:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6FnP-00035o-Re
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 19:09:07 -0400
Received: from mail-pj2-x11.google.com ([2607:f8b0:4864:39::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6FnO-0007EK-99
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 19:09:07 -0400
Received: by mail-pj2-x11.google.com with SMTP id
 d9443c01a7336-2d747eb79f6so17406325ad.0
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 16:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789427345; x=1790032145; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iFlFZtVpV9jpAzy7VrI0X3CeUaUUofMp7RHgwlXc+0w=;
 b=S+tSCZGU9uiDyju+ig/wVeEahnxSxPRRvesa8fs2hBPWOAytNj6Pvux+Nzvwrymulh
 f2TS4/9BIXFAIfeCzZlI39Og4NERRwsLaEO31gbLDMCfGw6Ch8NhYgmVW3D726kadCFq
 F4h7pPp4UCaniG+yxQx/tGtaXdKFYhxWPHzrS0lqn4ubIgySRAysr7ZR6zpLIjTk9pbB
 MUUyEGIV+loQ06XpPYyNOmZ2LFkiYsrQcrNQFU+sAdqaj46h0AzuEuQCnsBH/K+ufgbW
 UXmfmykp/9mnLzKbZb7TqQ+tMd/bgL7ccTCuvByrHp9p3HaVoLcyFBrgh/uo3kOSeRIb
 rRnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789427345; x=1790032145;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=iFlFZtVpV9jpAzy7VrI0X3CeUaUUofMp7RHgwlXc+0w=;
 b=1axQs6VcgqMUEpAXRQ7WI7omQy9yPxIN8c9fs7376XzpRHf5zmnu7CQINxa+ph/2OQ
 cEHepb15zfaw5rDE1O5l/0S29YNBjUhIgI6f0BwTiJ0Dku/IhMQn2anZKvY60fR48QEN
 TS1NpoMN08W4iuR2J4r5sepO/JPgT7XUdf7E0pXXJolNcVH+VLzTYnsLrjumRaNsnfaq
 gEGHacCh41ikl9xWWmf6VRIwUwNPE+5pBukitBdvXl2dvAidv5TJ2vCKoBtOkxZUIngh
 RCuMBcE7xNbp/UWNWDOEKa59/ZWtYSr+SSz65r1baKLFhj2la0bUXwK8iH6AwsbjuXex
 IWEA==
X-Gm-Message-State: AFuF++lWEuQgY73xlYBfTfu1lrrufLiLySfN7S0kGyKqPr/N4y1aQsdp
 N8bj1H/KQqX2t/feD48C5ZP6OjPfn1tXH4vjOPNBPkMsXfUSw6YblQg3EE5xMmQrviTPwgTjq2E
 5Ro+xlzk=
X-Gm-Gg: AYBFou1tTjY7SuulYr2A0ktm3W/o9NINXizxn0JLfXxpo5I1VtWRQz2K9jljZX21ntC
 b5iz8UCXwulbGD6vdr7hUh8po3LsVIe2CWLMuKiq5/QTs+piwvZezKdQVzeZzMNZPLlyhzxeEzz
 WWbzWVKpUNtx2Y75q6NJrUopoFSKhtRBES9P5oFeozBv6IyCthD51u6ABGtDstjDpHL9DnH0cF7
 Y3h1Tnpa9PSQcsXWMbK+TMf2B7sa09RHyi/vpNP4ESjo/ERnNryrqF7A7OFB4mxmSQxslAR8LBR
 +nQOOSI5RjzXAq4aPN8jT5HIVOSV47IgNWsb45bUwO3elT9mKrdnQo7gBzfM0DfDu10fSL1r2Id
 Dk4ymAd9uMwuKvqcgBR+7LkAqFXuLnQeii0g3aNSwS/A8sB2Z1HOyQIr6qpSJxyzcar4whRq+K7
 GiZl2IGBtRUWlMPFPmA4REou8B7NCir+Kr7vbW55yLUzsfuOlvgZgpm4JdxDCBF1ZCBYYq/vO9r
 FXq5e9z
X-Received: by 2002:a17:902:e807:b0:2db:43c6:d2c8 with SMTP id
 d9443c01a7336-2dd6c5be56amr97593025ad.1.1789427344668; 
 Mon, 14 Sep 2026 16:09:04 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:7164:7976:4c53:31bc])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba4e9a3casm28054447eec.12.2026.09.14.16.09.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 16:09:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@oss.qualcomm.com
Subject: [PATCH 1/6] target/mips/tcg: Fix zero in gen_mxu_d8sum
Date: Mon, 14 Sep 2026 13:08:53 -1000
Message-ID: <20260914230901.1781309-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260914230901.1781309-1-richard.henderson@linaro.org>
References: <20260914230901.1781309-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::11;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x11.google.com
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


