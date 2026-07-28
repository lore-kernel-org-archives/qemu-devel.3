Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13749C53219
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 12:33:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wogyO-0005Ts-In; Tue, 28 Jul 2026 08:31:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wogyG-0005SD-RS
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 08:31:44 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wogyF-00037D-E2
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 08:31:44 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-4758bd3731bso846032f8f.0
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 05:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785241902; x=1785846702; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EAtccSSfceesBHQUwRAR85ajuanAtR3J1PhK61JcJYE=;
 b=E1D9Q8+P7LCgtoafnL6Jz1hOlGrDMvF/WqYkGwjuB3vshebSLWMXuMjNZsP62Qbkdr
 MZ73YY9OJDgETIA7Hazhe9v/iUd80/daFm4sW8CUgkYnONAS/vuL4RlkwCW4gf5xH1fA
 YGf+Tn8hpR+r6citmMftchmY6nVnyEzuABpc/qObjocffMGjlEHo5VkeK082JNFMI723
 1oitxTQxIRLXbdsmwhYN5YFWwnIRrwI7W6v1AjllFj7rvv+khYvBwqUYlNaJ54dSGJmp
 6bzWtKZZp2vFK0deKvJZWgjEwCxolEpdjY0340qkvU3dl7EM7qu+/D8IHO0UTuDyWeJw
 Kl+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785241902; x=1785846702;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=EAtccSSfceesBHQUwRAR85ajuanAtR3J1PhK61JcJYE=;
 b=Q2UqmvmthrTihIe2y+OgeiaJ6Gyz9/YB8NY9jKKJg1QDB+dHALbG+QapileCuaXBsd
 VZ+BBaHwRpSVk0Js2NYcqSccv86FEhApBkfvv9ZHxb9mqE1uXdndCqxThPM2lLkI3v4x
 NhcQeooTS2gTx7z1QfQ1UsjewBlwLvw9hqZl7+gKgHKaTppFnaLOuhfC3d7pcQqY1763
 J4y21f1l2zGmP5bO4I0CS7OkgoZxpH+EWPswATTDrHRuYvHv+XlJhssIj5jTzL3SFPfW
 BiVBVQRzqqnvQGHBLvZ/ykZBA1k5lMw6iKI/BpSzDfTrQKoTZ0z0lILc1325ZeXRQRev
 A+sg==
X-Gm-Message-State: AOJu0YzGav0PFej2O4DLerP6n9IUvhtA4BLWwbItLST3rzxDUrqHpsjd
 VLYrxTirSEHgOWva2k2v0ULyhAg/pk85MlzGFfoTDHPnmkPe4ZqXDqfAjkqkrC4JGHA+dXBGkeH
 Klr2n
X-Gm-Gg: AR+sD10XEHpd0nxDQxbJU++VQFTUpTg5udEhhaPQgBfDV3sk6TFg2kYmi8XNNuVkyZx
 laR8HxmqmGNNZPSESxbVMpaAnhfT1K8MD1kUx0rk0YjtUQ8ra1zeSZ+mOulv3o52MLY1w59JHme
 xf/eoPakOr9LEZYnjcg2SASdRy8jtCk1fsCIRfBSjEpSTu3XqPRZKA0MldVk1QWz04L0siTx1Ba
 ojDYqtTUy92KuP11qS5iiE7g7x3lAf7kMIVGdsAkCs/wJ31nnahLU6Lu1t6abK3pb0zpAn51+6K
 3ERqaKzhTatvEZ7zTFf49RK9KIT4+fTJUj+9ql2x1ZeICGJmTNMcnbfTN9HG+jDBubvwRxOx1ff
 T4JtokbzWhyKTgdkeW2Sk31KL/mbTW5G9LIR2SQ1gAgOC14S3I9WhPFWFWSS/ZkiuoUjTg6wlYN
 PPsx4WmRoPzYMjQebuT7XOL4j8XxHAgYzfhvirpQMdfKfO8OfO9DdIi5kFT8jBnsOABy/g9kA+a
 dp195OS+a0=
X-Received: by 2002:a5d:5f91:0:b0:47f:9159:f1f3 with SMTP id
 ffacd0b85a97d-47fb1ef0e18mr2521299f8f.29.1785241901880; 
 Tue, 28 Jul 2026 05:31:41 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85c6f076sm58499039f8f.34.2026.07.28.05.31.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 05:31:41 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 12/20] hw/net/can/flexcan: Fix RXIMR reset mask
Date: Tue, 28 Jul 2026 13:31:19 +0100
Message-ID: <20260728123127.1711653-13-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260728123127.1711653-1-peter.maydell@linaro.org>
References: <20260728123127.1711653-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x434.google.com
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

From: Bernhard Beschow <shentey@gmail.com>

The RXIMR registers are not affected by soft reset, so their reset mask
must preserve all entries. Set the mask for the entire array instead of
only the first register.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Tested-by: Pavel Pisa <pisa@fel.cvut.cz>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-id: 20260723070059.6332-9-shentey@gmail.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/net/can/flexcan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/net/can/flexcan.c b/hw/net/can/flexcan.c
index f84f090a7fd..205d0d64134 100644
--- a/hw/net/can/flexcan.c
+++ b/hw/net/can/flexcan.c
@@ -140,7 +140,7 @@ static const FlexcanRegs flexcan_regs_reset_mask = {
         .data = { 0xFFFFFFFF, 0xFFFFFFFF },
     } },
     ._reserved4 = {0},
-    .rximr = {0xFFFFFFFF},
+    .rximr = { [0 ... 63] = 0xFFFFFFFF },
     ._reserved5 = {0},
     .gfwr_mx6 = 0,
     ._reserved6 = {0},
-- 
2.43.0


