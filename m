Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8192F4BB9E
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 11:09:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvCkj-0007lR-Gc; Wed, 25 Feb 2026 06:08:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vvCkg-0007km-Hc
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 06:08:23 -0500
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vvCke-0003dG-3m
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 06:08:22 -0500
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-82318b640beso3476943b3a.0
 for <qemu-devel@nongnu.org>; Wed, 25 Feb 2026 03:08:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1772017698; x=1772622498; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=MDqnGTbQ7s5Iu3OApPv+nw3kqEk559Kz4gOkSWSpTxE=;
 b=N81OfhGZQHHeAMhDnabsr3Mx5AjPrJnl1B2riA3qLGuUiE72VVs52FR8vu31o5XN+o
 H8VkLSnAnDgDIGTsKKntM0G3024l2zqClhWCUbDCZkIFPh9yqqHzCr8b524IlD1BsNHE
 B0Crgmaftb7ab2FSMjafMy5BcynDifjJOvmwtvhtSjNnpYCHt80v1n0tf4jGhoSlJcAT
 RaT7i9+PWb1n1LstuOQQRRuwND/zKRcKwQFJOiv7YGvCxg7S8j2HEP1BFDB30VB57e5L
 lWGFVbHedtiktvkV7Qob+rYQNsRJ67ZG+tdO+idjJA8d2qPsWPJlpwLBEjavFEX1Alrg
 u2RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772017698; x=1772622498;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MDqnGTbQ7s5Iu3OApPv+nw3kqEk559Kz4gOkSWSpTxE=;
 b=fdSSrhY2XkvbmQLDX2oUldSnLIN5sZVBK71HLzby71G+RGb9+TP0FKt0vPnVlSRHyV
 u/xhNsG29BG+yNIlC54FtLH96Lhi+HeuQiOA9glSCdwr5STbtCid+TtSbq8JUdGoBVNx
 pshti5c0yV0uAsQhMCx/YdI1b3ZlYsw4Y4JngphH35cchDKLeYk0vvz+CdM0U0GRYVue
 FFokCx8lx76ZgMiC4q7kuRWYhnvtb/LLPcV119WFPxBmvyYLWv6dtl3EC6jJHMhnIatF
 0NeeNmw296J3UbAJphsVgCbz+gh9ZKBW9cr3gASiWJfh7wtjn+FMs0rxgG5Uk2/+sH5h
 TMRw==
X-Gm-Message-State: AOJu0YwpLzfbTaF8KI5GYF/Zfnsgvb65++BgsXjX5JFdApmScrntg6k2
 pHtnmmTG/XxZimKGJjMy7zKhF3wuLhe9kNXOq1IysAiA9z+ky6saoGFDKxxzRCqKoULN4uMBSO+
 nxg5YQjmUg+O7F8BS05Z1ezBnDwIYquHm7320SITXoE0kGlhUOu5XqlPdRDP/oqV7ZeIHhJBJyi
 3DOAO5UumI96Yl7n6s5JAVt5puCJ76ST7wviWmKUpb9ijX
X-Gm-Gg: ATEYQzz/ZRzBBeX26WsuCEytTjLLU+H7SlIFXsfVsjYfkqWbRR1gPkDugbH438jmh3m
 WVM3/aMO+bfAWUw9z79j1PhjdgTX/dyokBHgMJFtwy5G+FyKz2zqg7KudNDhMJUoDBXmDVl/Jne
 0gqGWeoOft4AMNrdR1M0regIoZwzHH9PZpF0T7pFZVCgvwJjlLC55hma9imn/iQ9fHCHAweQX7e
 L+SHoo4W+kFKcm4u89LnbsMXuBvaM9tmeTqQnva+XFD6ctimKSRshQAfWL0Qb3YUZ5b+yYosy7d
 OU1l3WTWb++MU//u9qx1tL5WBOPa+7TniPIF9musa9ZlfCnLUS51YHyhMbmKlq/nQarCo5TFuEQ
 DqQIbUiMnLY+TKDlz41SEuSzYXkwYcdHOcXb5B63B9UKVQfK9LznrZ+YvCSVWZ+QzIIMSYnq/o0
 tegRoSG11e5UlpzWPNEkLFKWCoOojdRDw8kPLJVief42yJrsXIDizQXTxeZg9oQ/thQEvIlIQ3u
 s2D2oQRRxfSuxLPjJ2PCG/lcrsH4hrGBCeT9w==
X-Received: by 2002:a05:6a21:4c06:b0:38b:e70c:63f5 with SMTP id
 adf61e73a8af0-39545fca90dmr15358296637.70.1772017698182; 
 Wed, 25 Feb 2026 03:08:18 -0800 (PST)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ad74e35133sm140452665ad.9.2026.02.25.03.08.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Feb 2026 03:08:17 -0800 (PST)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, Max Chou <max.chou@sifive.com>
Subject: [PATCH 0/3] fpu: Fix OCP FP8 E4M3 conversion issues
Date: Wed, 25 Feb 2026 19:07:59 +0800
Message-ID: <20260225110802.1217946-1-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=max.chou@sifive.com; helo=mail-pf1-x42b.google.com
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

This series fix following issues related to OCP FP8 E4M3 conversion.

- Numeric overflow to E4M3 produces incorrect exponent values due to a
  missing local variable update after calling uncanon_e4m3_overflow.
- Converting infinity to E4M3 incorrectly raises OF|NX exception flags.
- The E4M3 NaN classification logic in parts_canonicalize uses an
  indirect method that obscures the architecture-dependent semantics.

rnax

Max Chou (3):
  fpu: Fix repacking issues in the uncanonical step for E4M3 overflow
  fpu: Fix unexpected exception flags when converting infinity to OCP
    E4M3
  fpu: Simplify OCP FP8 E4M3 NaN classification in parts_canonicalize

 fpu/softfloat-parts.c.inc | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

-- 
2.52.0


