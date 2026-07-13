Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A49BC43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 06:46:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjAQw-00050Q-Gl; Mon, 13 Jul 2026 02:46:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1wjAQt-0004zj-4w
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 02:46:27 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1wjAQr-0003FK-Dx
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 02:46:26 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-38dc4553f62so1564616a91.0
 for <qemu-devel@nongnu.org>; Sun, 12 Jul 2026 23:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1783925184; x=1784529984; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ZpoN550kNPQMyUpmD2Q/rsY1LHXm3CjmEsFP04Om5/8=;
 b=edFjIXN+u7m9B22oc1IP9cb+qPNICSDvROrgcNo2IA4TYwVa7Qo5t6OhR6PztSC2HU
 3JFNXFuRnxk/33+Xc6FeRpLZiyin/4YDa/lem/9jTweq2VAUVhu6uIrPBc5Ggl5vTHWm
 4WG45OzQVEpHJ+OyJ12+BQHJPrfBKhy2mfqUk0vxXJ8pNq9V39jC6bKZU2y3TwtHYRvI
 gwMqjdK27d2WEifLVuXZ43didCl2KSEZhu0mHoo+QGSL9qjux29txQZD0HXCAlVvl7en
 7oUQ7/1TGzuVqzFx9bGXzF8t1rXizClV2FmJzlwi+CJ8S1C+jl6VsJ77qkJMF4YPmNlF
 B5gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783925184; x=1784529984;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZpoN550kNPQMyUpmD2Q/rsY1LHXm3CjmEsFP04Om5/8=;
 b=LQ5lSceYbrEqQV3BI9tz/Q+o0ofXVA21MqYwGh/f0lHZclUUyf6ODRMAsqLhUiSCcu
 KsVyA98exYW9PCQzkUf5udrNoqFV042Q4Y9IUgAJLEzUcWhwhNxalSfxQFKbHi2Nrn+y
 4LoS+cOs/YImN02cEf42iVgDtSWv2eamFyY2BzUi2UAwOVIXvnAgHWPF1ggzWeAZ1AGz
 VJ502JOK3YLyjb9MXsX3sPrH4gS+S08F83x2GL1lhIt77e83EbnyiiVL7dA/QsohRLfN
 +M80uF4WEKnnewSbL4Xado3WWzODp6lcjBzt5U67PrEZIEQNc2mSlW+PZjBGOdIBfmo6
 0Pww==
X-Gm-Message-State: AOJu0YzVORFytlfdZ/sYabqPH81IW7vdlA6vNrZP77CdNw2y4Cc+VWM4
 ZQ+z1+FazZ4qj7gD8HqnIDAapEoDnXdcH6NheU4ae/JwIWxet1uqA+5rCHu9s7o5dU+gPlALDLp
 fDutZ5bmttbOnpJHZfKpaZ3mvYhDSPTIe068PX/A6MX13X+WeaMIgH0aYhD/0S7p1y/jkVmkP59
 1pFH87rySFiUBw6AcghLS+mc2a+ZiB0EyDlNhpozhLQ7M=
X-Gm-Gg: AfdE7cmkuH1kPkcrBL4YC/2NXk59PDvzUpSns8/5syU+PE/8YOt/3wFgHz2pkvr6ppj
 m8puDWu7tzL3a0LDtCDFrn5Mk/9BXbQvgcTDFMWPa8GErinMbEVnLgB8NW2g8VBYwMAtJBN+KNl
 qRBBxxO31ndwpyi9KhA+dn0tkPgtTCUN5OGWqs9en9G7QWPh9aa/Whqp2C3bfsZJ2hGVuHXc8YZ
 5qkxIF3zqKB63WrJ5AlCGY7QqjpJP4ZEuHzO3c7PTYG5HNokb5LN6s6rS4S/e5pcqBMBrwwV/s6
 sO/nblg6HUhny1268hBEAn2zA5Bko1d5qltvbgtMnZDk+GGwnmTHipYDtCYGoZJ9BPjPVvnb4wo
 qzZz7doB+UVVYQkZFxqCd9Ggi9otJb8EpAVDfcL+AWnzzz6uw7Mg9+nWAR7f35chajQsT+2rs+j
 6rnIRue2Y+Y6pyoonzdB+fsL1CdVkMWV+/qwxButTGYmfw7HvgXSo=
X-Received: by 2002:a17:90b:180c:b0:38e:fbe:b67b with SMTP id
 98e67ed59e1d1-38e0fbeb818mr54199a91.0.1783925183563; 
 Sun, 12 Jul 2026 23:46:23 -0700 (PDT)
Received: from jchang-1875.internal.sifive.com ([136.226.240.163])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38a5516ad85sm6004910a91.2.2026.07.12.23.46.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 12 Jul 2026 23:46:22 -0700 (PDT)
From: Jay Chang <jay.chang@sifive.com>
To: qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>,
 Jason Wang <jasowangio@gmail.com>,
 qemu-arm@nongnu.org (open list:Xilinx Zynq),
 Jay Chang <jay.chang@sifive.com>, Frank Chang <frank.chang@sifive.com>
Subject: [PATCH] hw/net/xilinx_axienet: Fix PHY register 17 link status
 reporting
Date: Mon, 13 Jul 2026 14:46:17 +0800
Message-ID: <20260713064617.85374-1-jay.chang@sifive.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=jay.chang@sifive.com; helo=mail-pj1-x1033.google.com
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

The Marvell 88E1111 PHY register 17 (PHY Specific Status Register)
bit 10 reports real-time link status. Previously, this register
returned a fixed value of 0x8800 with bit 10 always cleared,
causing U-Boot to always detect "No link" even when the link
was up.

Signed-off-by: Jay Chang <jay.chang@sifive.com>
Reviewed-by: Frank Chang <frank.chang@sifive.com>
---
 hw/net/xilinx_axienet.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/net/xilinx_axienet.c b/hw/net/xilinx_axienet.c
index 970732b162..9f5f65ecfa 100644
--- a/hw/net/xilinx_axienet.c
+++ b/hw/net/xilinx_axienet.c
@@ -103,6 +103,9 @@ static unsigned int tdk_read(struct PHY *phy, unsigned int req)
         case 17:
             /* Marvell PHY on many xilinx boards.  */
             r = 0x8000; /* 1000Mb  */
+            if (phy->link) {
+                r |= 0x0400; /* Link is up */
+            }
             break;
         case 18:
             {
-- 
2.48.1


