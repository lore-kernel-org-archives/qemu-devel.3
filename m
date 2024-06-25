Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ABE9C2BBCA
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 18:51:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMB5i-000172-9I; Tue, 25 Jun 2024 14:40:47 -0400
Received: from [2001:470:142:3::10] (helo=eggs.gnu.org)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sMB3q-0000rb-2L
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 14:38:50 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sMB2N-00065Z-Dk
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 14:38:08 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1f9cd92b146so45735165ad.3
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2024 11:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719340538; x=1719945338; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=o3TrT+1edJpCmza9gqCf/5QxVas39HNQW55OMRlXNaM=;
 b=pEYHdZc7MX4nHHg+1XqAoAJaK1cgzcV0IoO2mpA3An0zKelWyIfQKQ3y1WRmsVSQBd
 qCSh064B7dQJ2UUKDsOR1CpdOHgV8iyVte3qDkgePWg+pjiJN2ugwVo6vpNb+w+no/Sl
 scAlozovotCgb8IoiPrG90E7vJ4PgnxnsKV51OMx5U3QoauHuSjpqQwZqEgwIeUf2bvU
 PGTuxCK3eVK/vgyDgiCEdi/8e/kzIJ4QoqPIQfPHSP1BXyCwS1YZur+MwB85xw+1D8sN
 EoaSOSgkrzI03IMQmk9GTm/L3k6OtrZu1XLLKMBjq+QlnXwJ2Oc9h5DKDjNabsUaglbI
 +0pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719340538; x=1719945338;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=o3TrT+1edJpCmza9gqCf/5QxVas39HNQW55OMRlXNaM=;
 b=e9AZ22QAYd9QGJlKP4EXZfBRadd9+1vzYb5sprccwoRvDoP9J72wq/C7XrtW/FD2GS
 YS9YXpxaVOcWJ9Ge3/Wj17DmLbZQx2wE6glKdz7+jQTq09bKBBLcvq48qOnLn537ECeU
 lfONG63fXnhwBiwArP2ZWX8io1lg5wj0xAjzk/sB7+/eP9srqNNsig6U8BJzOS94dfxQ
 TK0pzIs/S+xHLGotev3+nREaVpzcuPD86jK43y7OJJ/mInEqBSU9NtAp3sBQ1Tv9VClE
 qpRq00XCcUjcvEa1MTsWHFSJcz18VZunwIYqU7iBz8KxIenX5zx1p6sF7C/AUInZR/ki
 FLYQ==
X-Gm-Message-State: AOJu0Yw8mEMBmXnIl/RY7sjP0OrYSWroDHwC5CnFDmvGdTE7Y15zxCGg
 Zj2Y61+G8G4LXF+x0d5W66wTANUCLqoLpiktehkX9+4ZQ5fZylU6xnvu7fQtYhgplG/0+m6XxVu
 v
X-Google-Smtp-Source: AGHT+IGKcK+3ox4nQ3B5KiL9UYM/bEI495nOyo6Vv1n7zlciQs3nJZNhpDz5B8su6nG9uCZld+gWPA==
X-Received: by 2002:a17:902:c407:b0:1f6:e4ab:a1f2 with SMTP id
 d9443c01a7336-1fa1d51e50amr99561685ad.25.1719340537890; 
 Tue, 25 Jun 2024 11:35:37 -0700 (PDT)
Received: from stoup.. (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f9eb3c6027sm84693235ad.133.2024.06.25.11.35.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Jun 2024 11:35:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v2 00/13] target/arm: AdvSIMD conversion, part 2
Date: Tue, 25 Jun 2024 11:35:23 -0700
Message-Id: <20240625183536.1672454-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Convert another hand-full of instructions, plus fixes
for two issues that are related.


r~


Richard Henderson (13):
  target/arm: Fix VCMLA Dd, Dn, Dm[idx]
  target/arm: Fix SQDMULH (by element) with Q=0
  target/arm: Fix FJCVTZS vs flush-to-zero
  target/arm: Convert SQRDMLAH, SQRDMLSH to decodetree
  target/arm: Convert SDOT, UDOT to decodetree
  target/arm: Convert SUDOT, USDOT to decodetree
  target/arm: Convert BFDOT to decodetree
  target/arm: Convert BFMLALB, BFMLALT to decodetree
  target/arm: Convert BFMMLA, SMMLA, UMMLA, USMMLA to decodetree
  target/arm: Add data argument to do_fp3_vector
  target/arm: Convert FCADD to decodetree
  target/arm: Convert FCMLA to decodetree
  target/arm: Delete dead code from disas_simd_indexed

 target/arm/helper.h               |  10 +
 target/arm/tcg/a64.decode         |  43 ++
 target/arm/tcg/translate-a64.c    | 808 +++++++++---------------------
 target/arm/tcg/vec_helper.c       | 100 +++-
 target/arm/vfp_helper.c           |  18 +-
 tests/tcg/aarch64/test-2375.c     |  21 +
 tests/tcg/aarch64/Makefile.target |   3 +-
 7 files changed, 421 insertions(+), 582 deletions(-)
 create mode 100644 tests/tcg/aarch64/test-2375.c

-- 
2.34.1


