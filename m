Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C49D8C5AD5A
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 00:51:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuJem-0000eJ-P0; Wed, 12 Aug 2026 20:50:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wuJeY-0000cU-BU
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 20:50:38 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wuJeV-0003zs-Da
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 20:50:38 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2cf6d65d8a7so24701185ad.0
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 17:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786582233; x=1787187033; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=+K0TRBn0btkMesDXAbUcRtIlrFR7ztFn+SHBFR89EaM=;
 b=q/lvkdoTNTQz09p655bGsQPRZQj85FXFEfTsQ9rSTuW68RM4xlJF0Q9E4iE6buHZf2
 Th13JLrDC28ZdDmRoMbe5J0tvc9JoB7mha6M27BYYvRPIGkj4oKLTeJ3YmjNYvUmqth5
 IJt1gHbsrPLXI0ImyHnTkyU9ElB0Ggasl/wW706q+FCS0V4Sy4g3D14JxD3UXziKylH+
 HamNutAM1wupy9StRP6/Gq9yEua9Mur6y6m39uqD69wZDWxwUKpv3bYfD9uM7mPKiRIR
 ZZ/ipODhWL3lt8RFSqeZgQpVHFNhKrtCNj8B1Zd9aed78WJ8BC5uR5fa2YRBE3kgYlOz
 N/3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786582233; x=1787187033;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+K0TRBn0btkMesDXAbUcRtIlrFR7ztFn+SHBFR89EaM=;
 b=UzLhOXQq6AcCqMxyCPmnFKl/6t1GNg6ERZWhRuMskPf3S8y6xsCcsrn/ixKkMUuUXR
 eSxytXmmY0nz3fIOvRubt4ENfvfhsjK3WaxLZkdxPKUE/ljCNWSITcZGxp6u4uI9290B
 jUfZVSsips81+b3wDSW5ST9a1vaTphKw+r3m8NWP3MDfo5GQUwLFTLjfUiO68BoNEPGa
 RBlfabzRpdc7BKQaGZDWPrEGn6G+x9R4shgCjFBnEg8S5R/qyyvRKalE0zcSCBbroq9t
 4bNjnq2Mrh6tzmIdXqn9Au9vnapCvsksbPOeUowcc5G/f6hNanmReXQDARtCL4G/nVYF
 XtuA==
X-Gm-Message-State: AOJu0Yx3hOlthYgYnDkkpkMOHpNMKLmooLVFFbVxHKNN5tpyWfw45rPo
 dmw1+nLi65xAaZBTmIm5Q1nqA3VRAWWzhLV7L/aFKloEgdlpt5yyRdfLKOyYv+JyJhdm+qeRLp/
 54g+/
X-Gm-Gg: AR+sD12LHuI9nsV8OMb1EJj8CJZ5P0z1aAQ64Ow8B9v7JEFKpAl9klLhE5CC1Tv1m+B
 npk0f/p5+KhNTtwrO1328bPRs6Owtos/y9Y+42wM4fDRWlS1gdXoP6N46rEubp3/LAhUWe6InQR
 BEy4weXLX5DihzdIoVy3F1jNwhQdRCFhocJ4ibYKloAGY7YUFikWTkl8w0u4yw2SiPmBkP5p+P2
 bbe4J6LGZgtxrqNH+EJbKzCeGphWtYIRY92qHaPTILuzZTUD4jpx8y/5SwaXFYtofGZcjtUWa6J
 lDN72478egC8fSH/8/4avynKUpUZ7k8jOcKY9nQYtT1QvWXbjNz60EeaQl/umCPGEoy8gJvkeTw
 L8y6Kd/sF5WAFcgOIAU3/VUt2VEKUvcxoDwO5rWNWpY4dpCgjCpfB/oEhqqSi34jyiE3f5dSeRB
 mFkdE8THCc5PUpAhLkRr0zsRhtrrx4JunzAU8bF7NsxQhm48M7UBK+m/EYOYfHbN1loedZVWuC7
 Q87p8Nd6xw5CiX/Zi5o
X-Received: by 2002:a17:90b:46:b0:36d:b424:4f17 with SMTP id
 98e67ed59e1d1-3931dfdd5bdmr2658776a91.1.1786582232667; 
 Wed, 12 Aug 2026 17:50:32 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3931ca612e7sm1259918a91.0.2026.08.12.17.50.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 17:50:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: yvyas1991@gmail.com, qemu-ppc@nongnu.org, rathc@linux.ibm.com,
 anushree.mathur@linux.ibm.com, npiggin@gmail.com, harshpb@linux.ibm.com
Subject: [PATCH v2 0/3] tcg: Defer tb_flush when initial thread region alloc
 fails
Date: Wed, 12 Aug 2026 17:50:28 -0700
Message-ID: <20260813005031.518387-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

Hi Yogesh,

The main problem with your patch is where you've placed the change:
tcg_region_initial_alloc__locked is also used by tcg_region_reset_all,
used by tb_flush.  Along that path, we really can't have a failure.
The path on which we can defer allocation is via tcg_register_thread.

The second change I made is to use code_buf_ptr == NULL to signal
reallocation is required.  In addition, tcg_tb_alloc doesn't need
to immediately fail: in the interim since thread creation, we may
well have performed a tb_flush already.

Please have a try vs your hotplug test case.


r~


Richard Henderson (3):
  tcg: Return success from tcg_region_alloc__locked
  tcg: Return success from tcg_region_alloc
  tcg: Defer tb_flush when initial thread region alloc fails

 tcg/tcg-internal.h |  2 +-
 tcg/region.c       | 40 ++++++++++++++++++++++++++++++----------
 tcg/tcg.c          | 24 +++++++++++++++---------
 3 files changed, 46 insertions(+), 20 deletions(-)

-- 
2.43.0


