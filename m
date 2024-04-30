Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09BBAC4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 19:43:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1tNV-00070V-K9; Tue, 30 Apr 2024 15:43:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s1tNU-0006we-4L
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 15:43:00 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s1tNS-0006jz-4k
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 15:42:59 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-6f07de6ab93so5736445b3a.2
 for <qemu-devel@nongnu.org>; Tue, 30 Apr 2024 12:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714506175; x=1715110975; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=9tTrPpSr33ydLoAnD+UnU5Z4fD5tn694jmjy2cqw5Ig=;
 b=xEd5LIujyVWMyf3Pr6V/iBvi1O8f+xB7dj2u76wDVa8vdTlLj79VX68yCc/JVlrzmw
 EByLxnD5JdbHW+NQpUYYnmmZO2pc4X+WNSd3SAoD4+L1PYk7LexpM0hqrB1Z4+A+Zy2e
 NetCgLdD0aR/RdGvLVn+kK0fRobDcFekHXCJE8M7mUtBUWxa/MNfd7QKXSPzlqWLx0it
 xRcKAtr2mxUEB92zKT7hf/Bsz7eQP3XVQPv3vz/3LvLxSbyWvQU4i+I08KBvHiThoc1g
 gnJ55B+E6qRG9f+Y1D3lVHoAtRicsBB7b1T1D5lkUQWPcnPKFoyt2LMYpBwttbrI24xj
 24tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714506175; x=1715110975;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9tTrPpSr33ydLoAnD+UnU5Z4fD5tn694jmjy2cqw5Ig=;
 b=etu/bbKvvOKJgGGW8Pbd0PmJ3Q0G6QqfwTqkuSSjK5NJup6KvSZ8LHgDcOCnues/l8
 VHsXcG5OrE+TyEQL8Du9ytVM3PkRsh0voTmgqMzUm4DbSwyp+yKncHQEK3oCkZq9ZzFI
 tWcZlVhJIzk5zOQQz7TzSD5pRRiPTYZ1aFfsBEsOyBjTF3BT6xJS7r2cKHycJ34XlDAw
 1ucf5IxxKKY74HcPi2RseODeRgCtH5RC2VvJoVZD48mSIyQYdJTpNj0jeq/jMh6lJL+j
 gZbsS8X6yDdmdqsz7gbkgXsFCL29uuECw+1IU7tJ5l9Ac7I/qE8i6tJKFUd4Ogjo3ChU
 VusA==
X-Gm-Message-State: AOJu0YwtphFC7N95TBj1tW6HWyFzLpDLr2x7h4/cXmyWuNxtl75ysA2R
 4Gw2EmXFQ5BAwdXviicuTbmtD48fzz7pMUa8BqeKnUhNTCM/MwP+2rK+1k4kiMgU0YMOlXieoKG
 c
X-Google-Smtp-Source: AGHT+IHnM3VfEQM2SC9yvUajo75WMdypny/zGchPsQrh53GCDzInm1esY6qmeDh2J3VcSq6gRT3jJQ==
X-Received: by 2002:a05:6a00:244a:b0:6ed:1012:9565 with SMTP id
 d10-20020a056a00244a00b006ed10129565mr700803pfj.15.1714506175243; 
 Tue, 30 Apr 2024 12:42:55 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d12-20020a63360c000000b005d880b41598sm20861523pga.94.2024.04.30.12.42.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 12:42:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org
Subject: [PATCH v7 00/10] 
Date: Tue, 30 Apr 2024 12:42:43 -0700
Message-Id: <20240430194253.904768-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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

v3: https://patchew.org/QEMU/20240206204809.9859-1-amonakov@ispras.ru/
v6: https://patchew.org/QEMU/20240424225705.929812-1-richard.henderson@linaro.org/

Changes for v7:
  - Generalize test_buffer_is_zero_next_accel and initialization (phil)


r~


Alexander Monakov (5):
  util/bufferiszero: Remove SSE4.1 variant
  util/bufferiszero: Remove AVX512 variant
  util/bufferiszero: Reorganize for early test for acceleration
  util/bufferiszero: Remove useless prefetches
  util/bufferiszero: Optimize SSE2 and AVX2 variants

Richard Henderson (5):
  util/bufferiszero: Improve scalar variant
  util/bufferiszero: Introduce biz_accel_fn typedef
  util/bufferiszero: Simplify test_buffer_is_zero_next_accel
  util/bufferiszero: Add simd acceleration for aarch64
  tests/bench: Add bufferiszero-bench

 include/qemu/cutils.h            |  32 ++-
 tests/bench/bufferiszero-bench.c |  47 ++++
 util/bufferiszero.c              | 465 ++++++++++++++++---------------
 tests/bench/meson.build          |   1 +
 4 files changed, 324 insertions(+), 221 deletions(-)
 create mode 100644 tests/bench/bufferiszero-bench.c

-- 
2.34.1


