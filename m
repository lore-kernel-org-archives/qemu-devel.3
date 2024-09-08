Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36DD3ECE57B
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Sep 2024 02:28:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sn7dQ-0002tK-6T; Sat, 07 Sep 2024 22:26:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sn7dP-0002rU-9M
 for qemu-devel@nongnu.org; Sat, 07 Sep 2024 22:26:39 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sn7dN-0004yk-Gk
 for qemu-devel@nongnu.org; Sat, 07 Sep 2024 22:26:39 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-718d704704aso1736871b3a.3
 for <qemu-devel@nongnu.org>; Sat, 07 Sep 2024 19:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725762395; x=1726367195; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=U2j0lMZsRK4bacOx+pZpf0i68zngCZE0Eba4wU07RQs=;
 b=Tw9FG8EjLTa0SG5k28aQBqP9E5LVtZdytAb77859ohRzHVpeC1wI5mq6CAnV/St2vU
 E6EV7xt5HAL+8Qic95UvIBUJNYmrJ58exYTdIJZNkzLoT5pZQSvwbIXWlV9sYDHalaW0
 w5aw7FCrRj5SnhRmMAVlpnoYDuiC8CWXEqf66VJni0pFVSVxb9F7pnieWlmoS4le8Lxe
 p0MzRoolfi38TdXl+q3u6RQJTxKQekRqh5OqD2S1sScsTOBB+hnYq0fENARxorjOQXpn
 iGtXHojG893hvi7bCnpBcZDTSGLZsfdtT0f+NCFaG8Y9iVHbRYjsqTDTSrDSJbTa+1s2
 Ho9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725762395; x=1726367195;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=U2j0lMZsRK4bacOx+pZpf0i68zngCZE0Eba4wU07RQs=;
 b=iSnL4xjzPtCxeAgSOwxpfLpVT7xB3J4djpKH2v06vgCyamDJiQ4dE/jkI5F0IMhX6B
 aUhe5yHZiBlsRELlPJ85HMizUHT9UrfWazxowyyV+t5k6ZzLRWW+tmCC2oqKsPFqfCwo
 RTJBdyyQVEbjSxoZ3mERsI1xFNP+xkzUQkXgLY/zq/Hhff7czUHtRnjF36K27QlY0jdO
 Px7y66Qt+Dqni+QmkpWSGle4nhgxHG8D+NzX8gJ9sEkByLl1Yp6K/VktprmgMv4sqfiQ
 9x/5fjQOnE6N478ezcWapXP70NiY46PaJOE3VrBd0FlGfs8rM3P2cR5Mg/csP0GsBING
 fErg==
X-Gm-Message-State: AOJu0YxuychNb3zW8w/zhUagcVNjxl3FcjqBYdA9C6wuroan2scB/GFD
 XMQddoQuLxjRDWqxrh7HLqQzRW6RZwNXGRV33Ajs0YH1+OYoyyPK95rxIUw8vZAwqnUX3fSmEuG
 L
X-Google-Smtp-Source: AGHT+IH+xCbEUs3q5sL+zpDLJugLIMOpL2eWBzuSgpDFKzdQ+7i+uFOVxIzU2QP9K3VQCq+51SsvHw==
X-Received: by 2002:a05:6a21:398a:b0:1c6:ecee:1850 with SMTP id
 adf61e73a8af0-1cf2a0fb354mr5000725637.49.1725762394766; 
 Sat, 07 Sep 2024 19:26:34 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2dadbfe46d4sm4084019a91.1.2024.09.07.19.26.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Sep 2024 19:26:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: zhiwei_liu@linux.alibaba.com, tangtiancheng.ttc@alibaba-inc.com,
 liwei1518@gmail.com, bmeng.cn@gmail.com
Subject: [PATCH 00/12] tcg: Improve support for cmpsel_vec
Date: Sat,  7 Sep 2024 19:26:20 -0700
Message-ID: <20240908022632.459477-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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

The patches to optimize cmp_vec and cmpsel_vec -- particularly
canonicalizing immediate operands -- are directed toward helping
the in flight tcg/riscv vector backend.

In order for that to happen, the tcg/i386 backend must be changed
so that it does not rely upon choices that it made during early
expansion, before optimization changes things.

While I was looking at the issues i386 was attempting to solve
during early expansion, I realized that avx512 does not have the
same issues.  Expansion of vector cmp and cmpsel become trivial.

I think I've split the difference nicely, so that avx1 still works.
Also, the avx512 predication example should be a nice model for
riscv and some future aarch64 sve vectorization.


r~


Richard Henderson (11):
  tcg: Export vec_gen_6
  tcg/i386: Split out tcg_out_vex_modrm_type
  tcg/i386: Do not expand cmp_vec early
  tcg/i386: Do not expand cmpsel_vec early
  tcg/optimize: Fold movcond with true and false values identical
  tcg/optimize: Optimize cmp_vec and cmpsel_vec
  tcg/optimize: Optimize bitsel_vec
  tcg/i386: Optimize cmpsel with constant 0 arguments
  tcg/i386: Implement cmp_vec with avx512 insns
  tcg/i386: Add predicate parameters to tcg_out_evex_opc
  tcg/i386: Implement cmpsel_vec with avx512 insns

TANG Tiancheng (1):
  tcg: Fix iteration step in 32-bit gvec operation

 tcg/i386/tcg-target-con-set.h |   1 +
 tcg/i386/tcg-target-con-str.h |   1 +
 tcg/i386/tcg-target.h         |   2 +-
 tcg/i386/tcg-target.opc.h     |   1 -
 tcg/tcg-internal.h            |   2 +
 tcg/optimize.c                |  99 +++++++
 tcg/tcg-op-gvec.c             |   2 +-
 tcg/tcg-op-vec.c              |   4 +-
 tcg/i386/tcg-target.c.inc     | 469 +++++++++++++++++++++-------------
 9 files changed, 400 insertions(+), 181 deletions(-)

-- 
2.43.0


