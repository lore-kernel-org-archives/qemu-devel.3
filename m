Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05701CD6E75
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2026 23:52:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVHo8-0006ch-4w; Thu, 04 Jun 2026 19:49:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wVHo3-0006aq-5t
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 19:48:59 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wVHo0-0007qI-Vx
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 19:48:58 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2c0c3546924so8743785ad.3
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2026 16:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780616934; x=1781221734; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=1ucAWI2dxDtortHZVQXRcLQXl473GouZE2h5JHIbeoY=;
 b=yC1Sr4VBPfOVcr3Jq6DA4PdbYjdzE7eGW9PBKZO+TjpLv9g/Wdd8ae7rNebQiOsCpu
 zAdHSL5VzGNNaze+nYc5E3fDBqE5jjJ6GW4TOIkamQpQvdg/Aip4VigqDqw+9YJuzRV4
 gFVUyIi7ikY7pr44FubsuQCzX0OrEYdIOgZ3KkVUqYykmcpTQksTR9xTUQnDv2ILswRt
 Y6svltmKy1ez8vaQMwKNcVunoWjovS81qm1Cdj0OnjIqtV+oYuvH5q8V2ieLP22j5Izh
 m9Z0kUeHshivob6Szhh1OyiObpI10NiVZZJfIp1a/UdBR6ZWnRb8c97vDA1YUrw7RyYu
 U4Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780616934; x=1781221734;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1ucAWI2dxDtortHZVQXRcLQXl473GouZE2h5JHIbeoY=;
 b=hbhwFMuBaGoXg2j7vb+cWDjfkWuk+/ZJzTMqZI76nYv8dkwtYSa7bsqv+kwr8SWFV2
 wegYar64CH9nkjC2gVYAH4yVtLnCtXhXI/kcyKxjKJyWxIeFpYEg8bfGnKq4njM6gIv6
 BpXCQZ8S58fknrD4j8IqQ6olBZPfLRSGD0LTrJzRFoM0u4HyoVGkVxmOvQsnZ3o6ER8a
 i72wUNTkLWbWweJBHPINANciU4WDLiGHrlTCJ6UXxwbBt6az8vBlLVLDqFeDOHJZLHjj
 6vyX36nO/kpVcVr1BLzANFvkRN3aZU5NyLWhT73+UlOjQ6ms5l/O3dhWuPpu5YLG5wws
 a9hQ==
X-Gm-Message-State: AOJu0YyZUrclaMVqI4J4mExtVNgfjiOTxQiX05ckfeJiLMLb63eOFm7U
 5y1eIeYXWQCdQMhXGZTVwnt3vHfIILMRLztGniobN2neeKxRmiN6qq6CKYkq3xsg4OS9Y8+1Pvq
 YWnA+72w=
X-Gm-Gg: Acq92OGf4oiQEfIUaw+nw79Xuhfb84ufnVSCR7YJMwRzY8SScujuKQ77JCJ39iXDWXN
 Fwh2YI07klqxoLwjUphvv+Y5fXy9fPazVkQedZA1PYs8wT0+BjTS4TGkq5pdb31DXKKtdVVirx6
 GHcSuqujml0zSJsmoh8WIPm6hyXqIaRJQPQhLBn4fVel8GVp7Hk9b6DyhsAmw8aI8kfIyyKkw/6
 cyArVosGn/wwC59yrsZfWSYCDhuNeRC05e+M8WuYxdKZiu9w2pWnxI0N+sSWheQV9uNvCmc3M/J
 kJzIbxGVLgTjjxJ8H7e9XY6bGy+cMFaGxQEE0gaNBdZLGaFkRX59vybi9a63JpvwQWPluSSFB1U
 fWI6AHVjrbkdhJsIT/K7xBz1sYhjel5cRSCCS+QmxQAB7JxHPN8FKh/ame2IQaX9RE8SIRPoTpS
 pAHnxLlQ8NZoT4zIF4+euAWzLqo1INOW5BfNrkZgk=
X-Received: by 2002:a17:902:e790:b0:2bd:a5e:4c66 with SMTP id
 d9443c01a7336-2c1e823b3ebmr7536425ad.14.1780616933926; 
 Thu, 04 Jun 2026 16:48:53 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c1664950aesm66541465ad.69.2026.06.04.16.48.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 16:48:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 00/25] target/arm: Implement FEAT_SVE2p2
Date: Thu,  4 Jun 2026 16:48:27 -0700
Message-ID: <20260604234852.573178-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

Based-on: 20260603032855.106930-1-richard.henderson@linaro.org
("[PATCH v9 00/45] target/arm: Implement FEAT_FP8")

Another batch of code on the way toward FEAT_SME2p2.


r~


Richard Henderson (25):
  target/arm: Add feature predicates for SVE2.2 and SME2.2
  target/arm: Rename sve unary predicated patterns
  target/arm: Enable zeroing in DO_ZPZ macros in sve_helper.c
  target/arm: Expand DO_ZPZ in translate-sve.c
  target/arm: Implement SVE integer unary operations (predicated,
    zeroing)
  target/arm: Implement SVE bitwise unary operations (predicated,
    zeroing)
  target/arm: Implement SVE reverse within elements (zeroing)
  target/arm: Implement SVE reverse doublewords (zeroing)
  target/arm: Implement SVE2 integer unary operations (predicated,
    zeroing)
  target/arm: Add data argument to do_frint_mode
  target/arm: Implement Floating-point round to integral value
    (predicated, zeroing)
  target/arm: Implement Floating-point convert (predicated, zeroing)
  target/arm: Implement Floating-point square root (predicated, zeroing)
  target/arm: Implement SCVTF, UCVTF (predicated, zeroing)
  target/arm: Implement FRINT{32,64}{X,Z}
  target/arm: Enable zeroing in DO_FCVT{N,L}T macros in sve_helper.c
  target/arm: Implement SVE floating-point convert (top, predicated,
    zeroing)
  target/arm: Implement floating-point log and convert to integer
    (zeroing)
  target/arm: Implement EXPAND
  target/arm: Generalize sve_compact_[sd]
  target/arm: Implement COMPACT for byte/halfword
  target/arm: Implement FIRSTP, LASTP
  target/arm: Enable FEAT_SVE2p2 for -cpu max
  target/arm: Implement FEAT_SSVE_AES
  target/arm: Use expand_pred_N for helper_sve_not_zpz_N

 target/arm/cpu-features.h        |  22 +-
 target/arm/tcg/helper-sve-defs.h |  19 +
 linux-user/aarch64/elfload.c     |   2 +
 target/arm/tcg/cpu64.c           |   3 +-
 target/arm/tcg/sve_helper.c      | 184 ++++++++--
 target/arm/tcg/translate-sve.c   | 576 ++++++++++++++++++++++++-------
 docs/system/arm/emulation.rst    |   2 +
 target/arm/tcg/sve.decode        | 267 +++++++++-----
 8 files changed, 841 insertions(+), 234 deletions(-)

-- 
2.43.0


