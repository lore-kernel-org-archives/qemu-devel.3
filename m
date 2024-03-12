Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13F0AC54E60
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 14:41:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk3HN-0003VW-0i; Tue, 12 Mar 2024 10:38:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rk3HL-0003V5-P2
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 10:38:55 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rk3HD-0007iF-2E
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 10:38:55 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-6e6b22af648so37799b3a.0
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 07:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710254323; x=1710859123; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=R0UZa/Kqkq/XhvVg7z6ft3YJNiymrdk7cLXPp9kdhQ8=;
 b=XMiJaYQKXE7U1o0j3zvC0nec5mmGjYPKjzok/U4Oqug7Df7cDX/soPFn3XfGK5X6bk
 uiChtZWQ4sPiv87/9uW+O8vWoOyZypgA7xsjD4n29Sr9/buKL++1dT2a/1yT54Oa6/2S
 g+O/fMinehqvpM2rRg3TrxX5Vd8Oplnlvg75C18jr7VQm3TnxYar7UeWKFt687V0OpJX
 x1+TzPBVWS36uzTuD/oHCSq6NUc0c2Csjh2+FWQiyWRVwsrceh13rU3ulrMLgbis7bix
 hLvpnBt51DdFHjcsczp14F6fLA3bhl8MvX8FCDLLR+5msH6dJ2311sRuiKWkcO4R249h
 FLvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710254323; x=1710859123;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=R0UZa/Kqkq/XhvVg7z6ft3YJNiymrdk7cLXPp9kdhQ8=;
 b=YM0V2l/j8WpUJqTeFaPvtdXFzet4178fYKDDOFHGUU1XY58G3bbnSXDnyMJ3wVl4bt
 zG+sw84Mdp7FsuaxL1gHyCT4B5FsszivDu3jgpCpwCXLUyFAIgtI2/n7uDfKVu4e9CnQ
 ewsI6c8OfXx/bDv+BHtzSfOaGuKUM6hYTdcrsGm+U+hi36KCE4DzEtPc1rIKtYhd7HqU
 qbweQx7PG640SyLJiaSKQUFtMac5g/XzfbSHcaCwpwqeueYCpZMT3B9nZD0LI7BaOqeo
 mpbWoF1QYuk3s1hAaJr6BJQGFqMOJTuaHfd0TeGohEc7pwD0pk1eYKSTW/+VFOcPVEiu
 AY6w==
X-Gm-Message-State: AOJu0YwhLebC1X0Mx6/dzZOYLBae/RyIIssG8Yn4k3H8xfjSpjP1dTZo
 Mlx7rjma870AEJAnxdO1f34Ullsfcjcjmksp/mpPA+3n4TMgmmJUYYT4TZD3ULbnojiA+ixPMCI
 1
X-Google-Smtp-Source: AGHT+IHJFyWXCQF1B6FPOBD9OUtT9kTq2qgjT0DcxE7A/VV0qmAO50OLMnBie3tOrC0ZCZmqd1Ue7g==
X-Received: by 2002:a17:90a:f40d:b0:29b:a1de:32d3 with SMTP id
 ch13-20020a17090af40d00b0029ba1de32d3mr15086588pjb.17.1710254323601; 
 Tue, 12 Mar 2024 07:38:43 -0700 (PDT)
Received: from stoup.. (173-197-098-125.biz.spectrum.com. [173.197.98.125])
 by smtp.gmail.com with ESMTPSA id
 jx15-20020a17090b46cf00b0029baa0b1a6csm7492214pjb.24.2024.03.12.07.38.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 07:38:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH for-9.1 00/15] tcg: Canonicalize operations during optimize
Date: Tue, 12 Mar 2024 04:38:24 -1000
Message-Id: <20240312143839.136408-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This is a follow-on to 6334a968eec3 ("tcg/optimize: Canonicalize
subi to addi during optimization"), which I wrote at the end of
the previous devel cycle, then forgot about during the current.

In addition to sub->add, canonicalize andc->and etc.

The early expansion that we produce for deposit does not fold
constants well; expand unsupported deposit during optimize.


r~


Richard Henderson (15):
  tcg/optimize: Fold andc with immediate to and
  tcg/optimize: Fold orc with immediate to or
  tcg/optimize: Fold eqv with immediate to xor
  tcg/i386: Do not accept immediate operand for andc
  tcg/aarch64: Do not accept immediate operand for andc, orc, eqv
  tcg/arm: Do not accept immediate operand for andc
  tcg/ppc: Do not accept immediate operand for andc, orc, eqv
  tcg/loongarch64: Do not accept immediate operand for andc, orc
  tcg/s390x: Do not accept immediate operand for andc, orc
  tcg/riscv: Do not accept immediate operand for andc, orc, eqv
  tcg/riscv: Do not accept immediate operands for sub
  tcg/riscv: Do not accept zero operands for logicals, multiply or
    divide
  tcg/optimize: Fold and to extu during optimize
  tcg: Use arg_is_const_val in fold_sub_to_neg
  tcg/optimize: Lower unsupported deposit during optimize

 tcg/i386/tcg-target-con-set.h        |   3 +-
 tcg/i386/tcg-target-con-str.h        |   1 -
 tcg/loongarch64/tcg-target-con-set.h |   2 +-
 tcg/loongarch64/tcg-target-con-str.h |   1 -
 tcg/riscv/tcg-target-con-set.h       |   4 +-
 tcg/riscv/tcg-target-con-str.h       |   2 -
 tcg/optimize.c                       | 318 +++++++++++++++++++++++----
 tcg/tcg-op.c                         | 244 +++++---------------
 tcg/aarch64/tcg-target.c.inc         |  50 ++---
 tcg/arm/tcg-target.c.inc             |   6 +-
 tcg/i386/tcg-target.c.inc            |  20 +-
 tcg/loongarch64/tcg-target.c.inc     |  31 +--
 tcg/ppc/tcg-target.c.inc             |  32 +--
 tcg/riscv/tcg-target.c.inc           |  58 +----
 tcg/s390x/tcg-target.c.inc           |  56 +----
 15 files changed, 393 insertions(+), 435 deletions(-)

-- 
2.34.1


