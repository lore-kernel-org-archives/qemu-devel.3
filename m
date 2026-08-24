Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88309C5DF94
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 05:55:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyNbE-0004zg-Q5; Mon, 24 Aug 2026 01:52:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wyNZ6-0001yB-2r
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:49:51 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wyNZ4-00025p-Hn
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:49:47 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-38dfe910e9dso3368443a91.3
 for <qemu-devel@nongnu.org>; Sun, 23 Aug 2026 22:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787550585; x=1788155385; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=pvkNgzPBnkClRwc9O5eyz1kkZLDtZhEMJDHTwwC8vGY=;
 b=cGl6RNZqLuVHSZH/mdC1/3A7qFO6geNUFCxUykeO0zk2E4+gQE1gzzi4kEw2MFQecs
 /7x2Dr3y7Aq0iBz+6/H9zGN3pTkbgYZUYYYLPF2HSR4Wh1UuYAdebVYmOp34vRd44PtF
 mBQOstUkXQxoUTbfvSAwrBED8suBU/41RSF6Zwi2tC6R7nVIHLF4BhHs7kLcq5AHLHEc
 ojBa6B5Tw5abJjV+HE4fZUysx6uHysKs7WVgDNFZnULBflEg5wjq7F86DhVn8Z01+AZD
 Jx7xAE6tN0+5drSCZ8+Q9YDy2JV2m1mvMOqQCQzIOZDVwO0W9EkfNKS66k3cwkowI7eS
 VNtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787550585; x=1788155385;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pvkNgzPBnkClRwc9O5eyz1kkZLDtZhEMJDHTwwC8vGY=;
 b=QO8CcCeAu94CEET5nF9MlltYKwKr64ehAOH5ODU940DQdLYVYOdIlvf+uf2qNZv9dR
 AaDsAOpz+lh3e42EvJm8zc+ZreOCg6n+8oEbodZ/QrLTo4i2WHm29qRglgkfD6UxaYKa
 9oab3oA0EYG0D3b003v9nuMBlRCg0cHedgEj7sBT3G5ix+4Q9toR33D510OKjeWeOLeP
 b1EGpWiKBpPA+lEKOMHrZyOtCangKlBIeWxxYkCbwJB+7qUI+ejQ8InU9n99GRlQTcEW
 gj9HLJBQ6bB09JdV/eLpAkt6aWG/PKaseJ36OGngu8dn56A52qqgJNHL0+5Fut9ukOBo
 amrw==
X-Gm-Message-State: AFuF++kvqvSLDDUH5ADOVzppfvZLWnpKXsHKbwl4KTZWI0kRWbfvvSpM
 7OInxRgDb6vLPqszjtnTVUkXXZfsMPFb70acuLxoFRxvzrIbKjJoJhh72VViJQ==
X-Gm-Gg: AR+sD13jN4PPWTx6Qp+KIFW2rY1zb9H5I+QxPhlCpC+5f6SamLPl1fBX9q0EKkFerAe
 X4lAgdv6nKIqua7gBjz458LjhoeYuWP1knIaaGt4ClF7SLWTT/mJSmgkOXUs493okwLtoL8+AXi
 /AVUs7sjDg0FGkmXvxqHNXG3JAcP2NM0mGR8H3NogdpAma7VmvR4koXzbDg8Z44ezQJoJlQxtuW
 d/H7J0SR5YSuhCvyn2C3dyzOAUIKW9r5I+176an/30J7CHv0824NkwJlVkk2ViK6J0daRxs0tap
 y+HYVmivMJYO2MhW9TFQgB8VEpqr8H5lNo5SHCsNK456Um6Yy/sStggnfvPf9KMsCqOjj2sZekA
 gwQqYvW1h5J1IkXtNpN8pXPtYI1V8uswMWLQvy/zaTJ0RV16VWDqCoGFScdDnN39MxD3kzohOGl
 Os/Ucv1nqXuoPFlWLjPOhnqRTZdUDmXN0S3vO9F8lB1akiCuXYq3nifnTdNOtiV1C2K1wAcnjUu
 xWaoQ==
X-Received: by 2002:a17:90b:4a89:b0:390:8361:a532 with SMTP id
 98e67ed59e1d1-395c33bd6d1mr41672629a91.7.1787550585057; 
 Sun, 23 Aug 2026 22:49:45 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-395c917d2f2sm4046005a91.3.2026.08.23.22.49.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Aug 2026 22:49:44 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: TANG Tiancheng <lyndra@linux.alibaba.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 27/96] disas/riscv: Fix 6-bit immediate extraction
Date: Mon, 24 Aug 2026 15:46:57 +1000
Message-ID: <20260824054806.2790041-28-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260824054806.2790041-1-alistair.francis@wdc.com>
References: <20260824054806.2790041-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x102b.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: TANG Tiancheng <lyndra@linux.alibaba.com>

rv_codec_r2_imm6 is used for XThead instructions whose 6-bit
immediate field is encoded in bits 25:20. The old expression
left-shifted by 38 and then right-shifted by 60, so it kept only
bits 25:22.

Use extract32() to decode bits 25:20 directly. This fixes the
immediate printed for th.srri and th.tst.

Fixes: 318df7238b9f ("disas/riscv: Add support for XThead* instructions")
Suggested-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: TANG Tiancheng <lyndra@linux.alibaba.com>
Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260703-b4-disas-xthead-fix-riscv-next-v4-2-84c566330bc7@linux.alibaba.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 disas/riscv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/disas/riscv.c b/disas/riscv.c
index 7f1b262773..fdf75a12ef 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -4546,7 +4546,7 @@ static uint32_t operand_zcmp_rlist(rv_inst inst)
 
 static uint32_t operand_imm6(rv_inst inst)
 {
-    return (inst << 38) >> 60;
+    return extract32(inst, 20, 6);
 }
 
 static uint32_t operand_imm2(rv_inst inst)
-- 
2.54.0


