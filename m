Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04601C61DB9
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 05:11:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzSNf-0002VK-Pw; Thu, 27 Aug 2026 01:10:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wzSNb-0002Tt-Pb
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 01:10:23 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wzSNa-00040u-At
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 01:10:23 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-3965d3d9ab8so1768543a91.3
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 22:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787807421; x=1788412221; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=m8Kte4PTJGY69G7A8K62LLjGu3iDEpCuzO0dR9OmEVQ=;
 b=FJIInTNh2TP8GWwmEZmr8Kt5gbFPIL1Q752KUzWt6TVfmz+Rw0uoUrJGDwsprIPztz
 z5aIVhp43MxLxPaiMBLEL1BJclY7+Ed/p/09qBpHQY230cldqvBkskpZ6ajqbnqiktjA
 I8u0RzFiY9oiVFgJx50Cl3DNo38HMJy86dWfxPvM30qxDxDGnjl9H2RiOzFywGd2DfRV
 ErBfV9KjUOCW++c6ofhAYqBK4TNVlFmrdtOICUEV0i9LavdriLqSHNJZlI4M6vc8rgO+
 VnHDIMPEN0nz8gbx19aRUKk8BaMWnsnVTbgVuumM4y7kIseqKThV60A8uMK6ARwQECf0
 RMZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787807421; x=1788412221;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=m8Kte4PTJGY69G7A8K62LLjGu3iDEpCuzO0dR9OmEVQ=;
 b=ikns3ECd6AdvQ6XIVUr3IKya2wNvXq3ocNkSp2e3EOjKiA3yGoT00nDsn/IY5qYN9O
 aV4q3FcGEiztr/ARZCydZ8BjnXRR8AgUV3SFeffP4EDykMQ89kK1SU0krpBIPw3H5vlO
 WQKmykfPWBbThYzWjDQfKoWX7Yy+HVqaBN1G+oSENTg6VHHJuICSdeQoKb43qJp2gY8q
 EvK0htBI22RbOMxtWhxN78JLWMkkzFhqiUv0PVT4y3nCiCSIhHpqPOyOXIROqtGC/lKF
 bEfd79Q9mw55eflcSvZIF2FJ1zLJ87luFjoEyUH94dzPwjuC+7InNtq+why0hgyq4ccv
 QA6w==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro5BRxeHosblbK5uXQZj24YfXkncspGE7JKGkZMh2FHeCN47HKY/5OtCnnsL4tNOkGmOkMf2R8uZoBe@nongnu.org
X-Gm-Message-State: AFuF++lvzHTCrJUMTYInhkJfvc9rq1zQ4ysSmK24RA92ym7i7Sb+jltk
 gdZlKokf1cfGl8x31aSg70FBxh9ax1D5x+mQiicmdoIShvc8eeOkBFr7
X-Gm-Gg: AR+sD10mVeq1qx6ucjQCkin3KIx23OWuYYVI/TWUeZzf5kahgBEj58Gt7L3p57e0ecv
 MP9MpaBz3DQ0P9x75qmNNjhJUq86QgVE4gKN047+MACqOr3wSsUywvqcZAWFb2kC5YKlNPp2obA
 NthbWMJgF+mAvvslg/VCvqAqj8BbTOkT+jqNsEn6XP9Xw8sDovtCSrmGzERmrBRYyYwZR/L91IV
 Mz8BIMTiG6bqgcupUkL7yMzV9Bg0lcOg/hCGg/OnprxaLcJNFl+HHk4MycQ32Zrh00csRSLjCII
 2GCADNjgMzbAGKQdeh9ulpHE1+Tmy0WtfW16J5/XNdLzsXgCzM03xFUsnT6+dyQVyDZwDcwaXQN
 hlx4AoYHjKvsOrOoGfCvva7RMCkG7rm71TecDX09Pq/u4SXI/2aGEt/EqJtFiiCAirUaKy7b6ib
 Lq36ciLI0X0veepN+kMOZNJwD1JM/c3a5H5OPNayngHO0IlUe4WUxXygCnQX0trHSgZie5OQDZa
 R9aKusLxs0C15LcuTPfDQbmZD9DxwNYECV6zLAeawv4sBjM6lU5Eeeu8Zf3fmhB6fWqst4O6oU7
 HpcgoGrsiBlmbFYDKBc+
X-Received: by 2002:a17:90b:2b4c:b0:38e:97f0:aa4b with SMTP id
 98e67ed59e1d1-3966d4592fdmr26918579a91.13.1787807420908; 
 Wed, 26 Aug 2026 22:10:20 -0700 (PDT)
Received: from donnager-debian.. ([180.150.112.50])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39670599275sm2210473a91.0.2026.08.26.22.10.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 22:10:19 -0700 (PDT)
From: Joel Stanley <joel@jms.id.au>
To: Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Michael Ellerman <mpe@kernel.org>,
 Portia Stephens <portias@oss.tenstorrent.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org
Subject: [PATCH 01/12] tests/tcg/riscv64: Include stdint.h in semicall.h
Date: Thu, 27 Aug 2026 14:39:40 +0930
Message-ID: <20260827050953.67184-2-joel@jms.id.au>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260827050953.67184-1-joel@jms.id.au>
References: <20260827050953.67184-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=joel.stan@gmail.com; helo=mail-pj1-x102c.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

semicall.h uses uintptr_t.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 tests/tcg/riscv64/semicall.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/tcg/riscv64/semicall.h b/tests/tcg/riscv64/semicall.h
index 11d0650cb06c..2fdd322af91f 100644
--- a/tests/tcg/riscv64/semicall.h
+++ b/tests/tcg/riscv64/semicall.h
@@ -6,6 +6,7 @@
  *
  * SPDX-License-Identifier: GPL-2.0-or-later
  */
+#include <stdint.h>
 
 uintptr_t __semi_call(uintptr_t type, uintptr_t arg0)
 {
-- 
2.47.3


