Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4255EE57C6
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 16:52:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soQYR-0001uZ-5i; Wed, 11 Sep 2024 12:50:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1soQYO-0001qj-Rp
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 12:50:52 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1soQYN-0003dy-5q
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 12:50:52 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-7191901abd6so833309b3a.3
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 09:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726073449; x=1726678249; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=TJpoTzM9GbnBdLmIf7a0iA6SVKMaRDRJnRgQ7RT4sOU=;
 b=wbO2QEu+TngZjQLXSIloHUUajp8iTBA20/1DDlS1wOjbJO7wCxxoR9xkV0nW/jhuFj
 6WNECMlYCH/tzASPlQyXxVBEiIqG4rYHOXVK61EN8IbCGU0u44Omju5aadFQOmBMWXpe
 ssgvUGd0KksBXxMtt4bwkbZVXyu3my/jM2viurt+X0AwfQW27RGcB+OIOyBu1UzALqqw
 gjq3zyszEH7h85GgSirI/ps9ybcnJMXCQvrhQBW45M87ixJnBtGOEVCSxTJR32w2nrzh
 QIvK1oX/B4dkfFiG0VJxTuBCxX3VwNLLiR9iQWNi8bIlJZ4cge8N9LpJR9bB6+GhQSWU
 B0DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726073449; x=1726678249;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TJpoTzM9GbnBdLmIf7a0iA6SVKMaRDRJnRgQ7RT4sOU=;
 b=bqtsB5CYwDoX0I82RVqQ2O5EVBWXkM5sDjYWZmOakLIEW+Pcu/hAWRFZUHJCyh2XKS
 WZRmdVU+u4FKBFI4W+D+jew1J7rkSFjKJil1eLZ4SfL+iFmmSntfCzsyTpMann0l0oLk
 10Dy0VSu+Pi0vebQNxWoOjTNEhxKGqDXSAxkYrDVhvhT7V5b5aROZyuhz/j3f3/mx777
 do0j4CtDGrYabjrPfUIgcdvlEhYDea9yFqiCPVQTGh0XC2CxASWAOfrjb6npALkWltsr
 fJWXYoQenDoOIDN/oTiaT0ClQDdPf+EUKSc7ZYnSEzjrGgWS1wIqVbzuarDsOMp7yz3M
 6Okg==
X-Gm-Message-State: AOJu0YwsowQu4p4eboF5DdqPWbfN8Nu73i6u7kqln6Iznvh1TuNyulCW
 nnocGsQCEcJxola/ib6mqtKmdQjHFQnQyQkzDfQAmrARxQ0p2XSe5D/DtnVetPEvNauyXzpG6YA
 9
X-Google-Smtp-Source: AGHT+IFH/IoaOFNm0ewXbjP8SiIDv4P2RdYMt8LM3iWSF0fnKRrsKlh5WSvj29zKXFrgEJv1il4xdw==
X-Received: by 2002:a05:6a00:1396:b0:706:67c9:16d0 with SMTP id
 d2e1a72fcca58-718d5f15fe8mr20748288b3a.26.1726073448927; 
 Wed, 11 Sep 2024 09:50:48 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71908fe4e7esm3186947b3a.80.2024.09.11.09.50.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2024 09:50:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: zhiwei_liu@linux.alibaba.com, tangtiancheng.ttc@alibaba-inc.com,
 philmd@linaro.org
Subject: [PATCH v2 00/18] tcg: Improve support for cmpsel_vec
Date: Wed, 11 Sep 2024 09:50:29 -0700
Message-ID: <20240911165047.1035764-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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

In order for that to happen, the i386, ppc and s390x backends
must be changed so that they do not rely upon choices made during
early expansion, before optimization changes things.

While I was looking at the issues i386 was attempting to solve
during early expansion, I realized that avx512 does not have the
same issues.  Expansion of vector cmp and cmpsel become trivial.

Changes for v2:
  - Update ppc and s390x backends.
  - Fix avx512 tsteq cut-and-paste error (philmd).


r~


Richard Henderson (18):
  tcg: Export vec_gen_6
  tcg/i386: Split out tcg_out_vex_modrm_type
  tcg/i386: Do not expand cmp_vec early
  tcg/i386: Do not expand cmpsel_vec early
  tcg/ppc: Do not expand cmp_vec early
  tcg/s390x: Do not expand cmp_vec early
  tcg/optimize: Fold movcond with true and false values identical
  tcg/optimize: Optimize cmp_vec and cmpsel_vec
  tcg/optimize: Optimize bitsel_vec
  tcg/i386: Optimize cmpsel with constant 0 operand 3.
  tcg/i386: Implement cmp_vec with avx512 insns
  tcg/i386: Add predicate parameters to tcg_out_evex_opc
  tcg/i386: Implement cmpsel_vec with avx512 insns
  tcg/i386: Implement vector TST{EQ,NE} for avx512
  tcg/ppc: Implement cmpsel_vec
  tcg/ppc: Optimize cmpsel with constant 0/-1 arguments
  tcg/s390x: Implement cmpsel_vec
  tcg/s390x: Optimize cmpsel with constant 0/-1 arguments

 tcg/i386/tcg-target-con-set.h  |   1 +
 tcg/i386/tcg-target-con-str.h  |   1 +
 tcg/i386/tcg-target.h          |   4 +-
 tcg/i386/tcg-target.opc.h      |   1 -
 tcg/ppc/tcg-target-con-set.h   |   1 +
 tcg/ppc/tcg-target.h           |   2 +-
 tcg/s390x/tcg-target-con-set.h |   2 +
 tcg/s390x/tcg-target-con-str.h |   1 +
 tcg/s390x/tcg-target.h         |   2 +-
 tcg/tcg-internal.h             |   2 +
 tcg/optimize.c                 |  99 +++++++
 tcg/tcg-op-vec.c               |   4 +-
 tcg/i386/tcg-target.c.inc      | 488 +++++++++++++++++++++------------
 tcg/ppc/tcg-target.c.inc       | 254 +++++++++++------
 tcg/s390x/tcg-target.c.inc     | 195 +++++++------
 15 files changed, 695 insertions(+), 362 deletions(-)

-- 
2.43.0


