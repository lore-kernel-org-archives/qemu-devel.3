Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B557C4345F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 15:13:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2ubB-0005j2-Uz; Fri, 03 May 2024 11:13:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s2ub9-0005iZ-LS
 for qemu-devel@nongnu.org; Fri, 03 May 2024 11:13:19 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s2ub7-00074x-LT
 for qemu-devel@nongnu.org; Fri, 03 May 2024 11:13:19 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1ecc23e6c9dso19239265ad.2
 for <qemu-devel@nongnu.org>; Fri, 03 May 2024 08:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714749196; x=1715353996; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=KN7mvNM4ccaoGCBt4lKkk9TGSRN8QN005qBKGqmNmQY=;
 b=kw0lTyQ+c1ZCUtodmrK5gEQSyKqAOKxnJIWk3+RfaRp8ng6BqSzSuvlW35Z9pNThX6
 IhGaIb325lHcICb1DAis3viRM1Ve2BURM1Nx34+d3orFXqx2EZ53Kopl3d2wNecBMlnV
 hAANShptiPQtexvTt03eCfPO2vGgTaDriEApDSdRylUE/tKtM7rwoLxW1FJKb36XlCUw
 R5g8XzVrTgZwV/nAYnUycIl30A4Hq8C7Qau7t3O0OXWfMn49/dOJbBj5Ud+2VLP8jGIB
 Ze1nUJzEsG6HFw3uMngXWBkqvEv2HoX+quBUM1el3YKj2UbsHkw4rXRdyEYm8lLsz+hu
 xmLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714749196; x=1715353996;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KN7mvNM4ccaoGCBt4lKkk9TGSRN8QN005qBKGqmNmQY=;
 b=neYvIqqF3VPj651PKUdOcHVfvfRDHlS0oa4+5CViN6Q1RZEevOY2Q7gKta2UFBKaNL
 3VcN8mxV8ydSCfjYeE+qjdEmikPVfT3swkPzAi089u2zwt8VDTBELdGAXeg/alehQjHq
 dMoea75o8RW4lKf57Per0zOo3lac1PxkWanwKh3VvS+f8w2B4Rym9pgnHenlMRxnJhwS
 XDqpFxB19mJdx377JP9HsE9jB7dpw3WthQVMGD2VuIZJmmbKGdXhrv1+V2BtOi7LJvNI
 bQbsN69gIqIVGcfez3Q+MipiHni5ksfGt1kecMWG72UK7tJsbJVbd0leiKOIUP9qYTLE
 fVrQ==
X-Gm-Message-State: AOJu0Yyga9qf4NplReKGjP2g0Af4HZntn0K8U9VkWrF6fC7M1c1gC1Zv
 RLXeKW1VndCB8oDA/waR1iOi4JK0P9mR7DM7i3vvnHFHC92DBbp6iFKG2SVsSRyXum9eAHwuY7t
 T
X-Google-Smtp-Source: AGHT+IGUc57MLWps77qcv7x4UIlxDAdfzTgoPVnLgTjfX9HtXrDlW8uSLo3tCATuhfOD9LiMf1gINQ==
X-Received: by 2002:a17:902:f681:b0:1eb:5323:c320 with SMTP id
 l1-20020a170902f68100b001eb5323c320mr3200609plg.56.1714749196155; 
 Fri, 03 May 2024 08:13:16 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 p10-20020a170902c70a00b001e81c778784sm3366611plp.67.2024.05.03.08.13.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 May 2024 08:13:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/10] bufferiszero improvements
Date: Fri,  3 May 2024 08:13:04 -0700
Message-Id: <20240503151314.336357-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

The following changes since commit 4977ce198d2390bff8c71ad5cb1a5f6aa24b56fb:

  Merge tag 'pull-tcg-20240501' of https://gitlab.com/rth7680/qemu into staging (2024-05-01 15:15:33 -0700)

are available in the Git repository at:

  https://gitlab.com/rth7680/qemu.git tags/pull-misc-20240503

for you to fetch changes up to a06d9eddb015a9f5895161b0a3958a2e4be21579:

  tests/bench: Add bufferiszero-bench (2024-05-03 08:03:35 -0700)

----------------------------------------------------------------
util/bufferiszero:
  - Remove sse4.1 and avx512 variants
  - Reorganize for early test for acceleration
  - Remove useless prefetches
  - Optimize sse2, avx2 and integer variants
  - Add simd acceleration for aarch64
  - Add bufferiszero-bench

----------------------------------------------------------------
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
 util/bufferiszero.c              | 465 +++++++++++++++++++++------------------
 tests/bench/meson.build          |   1 +
 4 files changed, 324 insertions(+), 221 deletions(-)
 create mode 100644 tests/bench/bufferiszero-bench.c

