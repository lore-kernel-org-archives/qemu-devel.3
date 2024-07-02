Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5813C3065C
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 23:43:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOn8c-0007nJ-Jp; Tue, 02 Jul 2024 19:42:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sOn8P-0007lQ-CV
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 19:42:05 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sOn8J-0006Mk-C0
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 19:42:05 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-710437d0affso2816836a12.3
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 16:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719963718; x=1720568518; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=mZ5AdtoXeBWo04SqXtXVV3bVy8fFh+q0Y63ABmnLjpU=;
 b=HS2CvEqSFlkzP8SzQLvpFM9t7L1geY47WOyZJI4LHQc9CPSNsSWCEEP1sLAMxfjQsD
 qawWm93eZZLFMKTK9ytjzja5XGPr5VMszhg6yODKE4EirqYtFjTzw8llUAx7Hl/U5FKK
 mP+65et3CAGNfFoq6V9CKbAO5I3HDIjAjNC3/CK7VLX7SiYy3zSfXqHQHcgvcBSDequd
 p11ChWRe9Qexgbp+QpWDjH7uUWfQfbIeitTW6YGPEiTpJo7gd8oBFmH/mMqNJnRJXF3q
 bc8njGPsDd9cA8ng2PqTSsIPJSZHSEwOlheUKkGXqbhN6TR/szQ0e6vFLzQz8iMt6GxJ
 LbJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719963718; x=1720568518;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mZ5AdtoXeBWo04SqXtXVV3bVy8fFh+q0Y63ABmnLjpU=;
 b=U6KCFbMadwbF7WlpJzlBtJM5sJOoxyb9d8h+L583S7hXnyjnfU3B26A6c2nzmgrjSV
 KRE7k432KCy2YZ20OgmvLfRYWfCCxcMZzyQdVu/DRfCHqMkZdicwwMRxTfpqHdtLnhvp
 ENk12iS7L9esQnDLR4qT38/S6f5/nOA/ZME7C9lRESfa6qM1PidOxn/OuCjCXSiDAYc+
 XKk/Ox33i/e3FKE0/6vyoZ6QOsaQOQOdzqUl8ym8FpFo/Z3NKOISF+5VI36wGkWOM2fj
 9F1GV63rMomcs4lVC5okCTjHZoCTHXdbivWXFlMJ2xiKGbcDEE1PhBjrM3dvfJDUnvId
 Nz1g==
X-Gm-Message-State: AOJu0YxP0fgT1WU2/m+1WNRBNircSU0lDk6GK8DdXXU6jtovJDD2kv+E
 J0Yxy6MqFlXzVB4vpmzalzxVDQyku/NPUwhXkW8LeE6vTzSuzCkxrcEzWnhVYlsFOg3zs+RBpc6
 8
X-Google-Smtp-Source: AGHT+IGNZa3TI8BO0F0AVOq4RnSj6Qdnhi7PBvl6+40DrqmDo6FzYHL0IRYmTUxVzobZ7yJHWmGXNw==
X-Received: by 2002:a05:6a21:999e:b0:1be:c42f:be42 with SMTP id
 adf61e73a8af0-1bef61019f4mr11018847637.19.1719963717603; 
 Tue, 02 Jul 2024 16:41:57 -0700 (PDT)
Received: from stoup.. (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fac15993c5sm90403755ad.244.2024.07.02.16.41.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 16:41:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, iii@linux.ibm.com,
 david@redhat.com, balaton@eik.bme.hu
Subject: [PATCH 0/2] target/arm: Fix unwind from dc zva and FEAT_MOPS
Date: Tue,  2 Jul 2024 16:41:53 -0700
Message-Id: <20240702234155.2106399-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

While looking into Zoltan's attempt to speed up ppc64 DCBZ
(data cache block set to zero), I wondered what AArch64 was
doing differently.  It turned out that Arm is the only user
of tlb_vaddr_to_host.

None of the code sequences in use between AArch64, Power64 and S390X
are 100% safe, with race conditions vs mmap et al, however, AArch64
is the only one that will fail this single threaded test case.  Use
of these new functions fixes the race condition as well, though I
have not yet touched the other guests.

I thought about exposing accel/tcg/user-retaddr.h for direct use
from the targets, but perhaps these wrappers are cleaner.  RFC?


r~


Richard Henderson (2):
  accel/tcg: Introduce memset_ra, memmove_ra
  target/arm: Use memset_ra, memmove_ra in helper-a64.c

 include/exec/cpu_ldst.h            | 40 ++++++++++++++++
 accel/tcg/user-exec.c              | 22 +++++++++
 target/arm/tcg/helper-a64.c        | 10 ++--
 tests/tcg/multiarch/memset-fault.c | 77 ++++++++++++++++++++++++++++++
 4 files changed, 144 insertions(+), 5 deletions(-)
 create mode 100644 tests/tcg/multiarch/memset-fault.c

-- 
2.34.1


