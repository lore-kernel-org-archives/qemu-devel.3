Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0852C61DBE
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 15:49:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wytOo-0000sL-Sv; Tue, 25 Aug 2026 11:49:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wytOj-0000rf-Jn
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 11:49:15 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wytOh-0006LC-QU
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 11:49:13 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-cbb8b54fcf8so4758917a12.0
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2026 08:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787672950; x=1788277750; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=tozzJruxAcDdKJB+SJXYUVG7KQb2sv6ExSiEXw88olA=;
 b=Njy8UlMEnsItbekOfpBeWdr4HCR/wXQGXH/sWtBScEEdPG+lhIvaL1xp3YViQlOfaF
 jf0eIZkzu6Pfb2uIZrQDSg4rxicL+QIYFQ6eR6uikGldwSUW3sly7u0s6nqZ58H1pebh
 CkUOc5OJIcFQvdrF+n8vwo0syQUEFpjmkNJZMJ6LKcjNe72SxXOFpfIjg/3yMU7OkqOw
 oeVCmpZacnQphNbhi5neYnhMNyiGdXEHqLaDpRZc3Vu6CD9R9jRAI0DGD1jImsn72+mn
 2m46lkvjQEXt0H5oEbevGKgp2fF4u9LEb8OFj9pHHUz2/lDhkz/rgCfDbr4TEiKDeyHR
 wr+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787672950; x=1788277750;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tozzJruxAcDdKJB+SJXYUVG7KQb2sv6ExSiEXw88olA=;
 b=euqRKaBXQztFxni/ThtMD1lHmfAPvpyd2vbG7L3l8owMStsbE13nURDJF8bNQvR0XS
 aG8T2SsG77rt6ETg6WpwiVXT4+dXJpNgAEqSrzibHHtkUrbWKjZPZepRC/t7PmDZltXL
 zZrTAUg1PFzOKFvpn4xy14T69iM8i782XipPRSTmXeGr5ctWHx1KmfRQh9ZdRTPsqJbI
 1OVPyX9/5KwmldiRrRiD9aJgAq6QaSCZsWoxjtyRkentL5BpjOvcgWi9v0QgMl0ouxBP
 3uQmtTqtauAqQP0z/idGh8Wu6HH5SJFc+K44bCdHRBT9/za+z3zHO9yZX8g6GjrtBfOf
 jtvg==
X-Gm-Message-State: AFuF++mjaMFmgGlQnEM+s1sMVHZVihYtYFe3sPqJNvEsAdo0ntZ0G5Cu
 guXk3fJPH1m42cLl+yFzI8pOo4gQWGQjaTc9I0haFdz8isYUHj9kikHC6sYnlGg5vgFgCqcQnKN
 Y9skN4yg=
X-Gm-Gg: AR+sD127hArs8dFcc3VIj+PYtfvFX9pPXchLKOJ2F9o3B1cw9ujZ8h4WcEZfhYHHhnB
 NwJap03ol5v/SGRaOAX3lTcVrwD7FswqK1QtqsNo8eE5X/jCEH86HgzEnO6bMZUmK5CqjdLYO2j
 LhFoHoVWqN1OElUYmtYk5f7j5n88t2Uom1oPMN8Bk1eHPMWFRavFOx3nsO6znPOtxSb3905n99Q
 xTf/2hZFzk7K5qoIT/6cfgdZSviJA883qpgaqTnk3dfw6qrWccO/HMaJSMxgETe/1zcbUlj+OuI
 ekivGsULcYI/fDWaafsqH8Pwthvx3MutfbYYpHKe1v3/K7PWsXqo2cdRHHtjUxYKqOIWgBbNiRP
 NnB1QH0M6n3syWqRI3ylLcN2jW3wV4gJL6gGDoM2J0tUyFI0gp0omp+xBdyLd7exhvm9QL8DXG5
 F0J+Wh/YDXkNSYhQkIzVIauzfyvHnjdgKVyasY/21UwurBPgi7/1b8Cm/Cnegsq5FwU6U6vWZn1
 sOPl0WUXEuN/9EUUA==
X-Received: by 2002:a17:90b:1fc3:b0:38e:9eb2:9d43 with SMTP id
 98e67ed59e1d1-3966d5c1384mr110668a91.16.1787672949593; 
 Tue, 25 Aug 2026 08:49:09 -0700 (PDT)
Received: from stoup (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-396689f9500sm238178a91.10.2026.08.25.08.49.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 08:49:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH] tcg: Fix typo in tcg_gen_hswap_i64
Date: Tue, 25 Aug 2026 08:49:08 -0700
Message-ID: <20260825154908.20472-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x531.google.com
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

Fixes: 288d39e26d ("tcg: Simplify bswap/hswap expansion using bitswap")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4229
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-op.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 28d3b2a847c..2c88f4f7ca9 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -1887,7 +1887,7 @@ void tcg_gen_bswap64_i64(TCGv_i64 ret, TCGv_i64 arg)
  */
 void tcg_gen_hswap_i64(TCGv_i64 ret, TCGv_i64 arg)
 {
-    gen_bitswap_i64(ret, ret, 0x0000ffff0000ffffull);
+    gen_bitswap_i64(ret, arg, 0x0000ffff0000ffffull);
     tcg_gen_wswap_i64(ret, ret);
 }
 
-- 
2.53.0


