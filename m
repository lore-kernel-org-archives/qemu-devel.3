Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A51AF8E4A7
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 04:27:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDanB-000616-EX; Fri, 17 Apr 2026 00:26:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wDan9-00060i-7l
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 00:26:55 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wDan7-0006OC-GQ
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 00:26:54 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-488ba6366a7so2629835e9.0
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 21:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776400012; x=1777004812; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FOkTJe5q76NlJ9pYBZFYxgrP1+yuHZk0NW640n8cnlQ=;
 b=N8rCzIc0CXH/5ZJD9uYdpeCP+rkShRQ8Afj7eY1e/2MPjaUYbOgnYWf8fN2bnQ7LAt
 uyqMPJOMejscTVENCqECFVVcU6Vsxidgs2/U2e88H11sapNL6lSXXyb5/G96CAeEDZcf
 Vl5LmxnAr971ewgLbdVMxDyj/IDRoVVdlPkPkDd3lYs2SdfX5DtzPys0zfeo1/Gn2qDC
 47VcAK0ujt0fr/VlAamKi2Bp7X1GXmJ21NGEOSptphVLNEgeZJcTp73VuNnT31dSmEH5
 vYXr64N1GcFgprTSJ4Vc1rnBy6t4lLsl43VaMnI00usgX/MhWjTS5SvvLss3zJeIdg+g
 xG8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776400012; x=1777004812;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FOkTJe5q76NlJ9pYBZFYxgrP1+yuHZk0NW640n8cnlQ=;
 b=LUKQv7/1fSO6CiAyinDlwB4P9ZjVg5DGcEGZVwqUxV9yR1v6aD4BMEk1ocRV6MUjLQ
 GgULM4FjBQqM5af55sBA1XBZKbbw//hHxGS5ZUcs/FQ9dfqTGeKWU4epvmhj5cu0G78+
 Cr69NgJF/B0WzsT69T1Jfv5VhVUld6e9HMNAwWPuuBmvQHTbV1ylEH+4lmLsfHjLaJxf
 KUtQjhy8LxI0+uFQGeZlQNZZyLGwEiLpyxz6Y7iRA0+RyeHYz1hYewo20QOgVvo6Zsmy
 xVf0m7Mo8SFgMZKkUjrvJxmR5teey0kdFT8veU6FXfGZ8cV6lLNc6JexuJ2vjEGQ6ANR
 MaMw==
X-Gm-Message-State: AOJu0YzooszT8pzPqlIfykuVPw6kQkeUmk6fjgsdbSVo0ZofVZwZE1oJ
 Inxptd5wLm/GLiLGwyzUfpkQBOR8PxgU7ThhjThNmqUhb89G3i+VGjFlbQSxc+SgpzbqvteY4bc
 JLtQxlXo=
X-Gm-Gg: AeBDiese4b6coBU++Oy60pWNo0xzhwXX9n3y+uPDdDWoVRbz/rH/Idqq6EYM4Fsua/c
 c8nPEPDYi5wdNEURgANbLx4u1Z8voVc48bRdUFmKg6yO4A2cepl5MrzXwwik/yBt9s0zXt+0q31
 CgHBZCYEgi11tLv9N7rGaZbbsGnGxjIzpz7OAoGngL985wLuvDnNFvsvsOUxlXj7FPz9AZhsAtT
 u2LiaDKWt9pjCqC0GiqATP9UOzNO1BrGwYGNZ2NdPcFu4s0+g/+OSNQBq8btxReXu3V6zuxrLLc
 VGPRZgzASEQsAOK+lkwDSOGPDIbeOdI6zS8dsL9aO7wqYcL5LE15+BsYAH7pYWf7jouBogL4fxF
 aQ1Z3cZiAmICNqirtnEkl60c9wH/2q+smvCKv8N8EcIFQJ/K61GQwlrOGghN7LJDGxuUS/s88YX
 n16+BLQIcI/if6tp7itJSNHKqNYHK4DLG8V1JebSPRUlX8OrIfmBWCOu9NErR6Y/D+s83iVBYsB
 yWSr0yU2OM=
X-Received: by 2002:a05:600c:33aa:b0:488:ae6c:42c0 with SMTP id
 5b1f17b1804b1-488fb742e7fmr9370165e9.7.1776400011742; 
 Thu, 16 Apr 2026 21:26:51 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fc1c0354sm10873215e9.11.2026.04.16.21.26.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 16 Apr 2026 21:26:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v6 4/4] target/mips: Remove last MO_TE use
Date: Fri, 17 Apr 2026 06:26:19 +0200
Message-ID: <20260417042620.35329-5-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260417042620.35329-1-philmd@linaro.org>
References: <20260417042620.35329-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

Unfortunately commit 54821ff6e90 ("target/mips: Convert mips16e
decr_and_load/store() macros to functions") got rebased on top
of commit 2803e24694c ("target/mips: Replace MO_TE by mo_endian")
and we missed the replacement. Fix that.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/tcg/mips16e_translate.c.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/mips/tcg/mips16e_translate.c.inc b/target/mips/tcg/mips16e_translate.c.inc
index beb5b04ea29..e83587971d4 100644
--- a/target/mips/tcg/mips16e_translate.c.inc
+++ b/target/mips/tcg/mips16e_translate.c.inc
@@ -293,7 +293,7 @@ static void decr_and_load(DisasContext *ctx, unsigned regidx, TCGv t0)
 
     tcg_gen_movi_tl(t2, -4);
     gen_op_addr_add(ctx, t0, t0, t2);
-    tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx, MO_TE | MO_SL |
+    tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx, mo_endian(ctx) | MO_SL |
                        ctx->default_tcg_memop_mask);
     gen_store_gpr(t1, regidx);
 }
-- 
2.53.0


