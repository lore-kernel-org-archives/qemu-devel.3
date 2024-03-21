Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E96C9C54E68
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Mar 2024 10:51:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnFzm-0001mA-GC; Thu, 21 Mar 2024 06:50:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1rnFzl-0001lp-Dv
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 06:50:01 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1rnFzj-0007OO-LM
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 06:50:01 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1dfff641d10so4949615ad.2
 for <qemu-devel@nongnu.org>; Thu, 21 Mar 2024 03:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1711018197; x=1711622997; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=hg2LxHkojpo8q8H6r5/EMWy+uyhOa9hdLVMIdmHZC4Y=;
 b=d6D0QWeX6U/qYPpQxIcd1/iivIS3Ve0/+TWaVVKx6MD/SwS9NOccLhsOT3gmFTKmg8
 3R0RiMsJhjoCi843cxtuX28yi7nhkb0/AcwRFvVKUl42YdwrpOpMJLJCfEtmqT9w7FSD
 vwvPVuy9SWzQ0cxLlVOSRE+oGCjpl8y2EpWGGcbioS4IofsWe1/kEm+pUFr3juSBF3dY
 EhLOFrHDOO2sHpwHed7y/4QhgodtFnbfZAUucEVNk6JiSiIdfhhT7wwncvg2RjPGpf1O
 7EMnjdsDk/aT6e3d+5z0dk+FSjFzPZgkCwNe/UciIZCwxxWZxzSXsL9OgkkSN7A7XD6W
 JVlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711018197; x=1711622997;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hg2LxHkojpo8q8H6r5/EMWy+uyhOa9hdLVMIdmHZC4Y=;
 b=lRX6HxnvuHLrZPA2Y/XVFs1tVi+n/AokrDdvI1qNxVfFaImBAHhDJtTywhEfi7XO2W
 EzevLlePgiqyHlyjAUN4OMaQH1IHwHy11jNpCow2LwoboM6RsMVP8PLglRiYamLrt0ZH
 vMcRTT08iZGcjuJeBG0bBE2mInpOq6opv/EfJmvMUo2SspOp2VZ8R9KSkOwFftUzpCyg
 xc5W5g5qCzQTFbbOH55OHRkGleBPXxs80qY5jYKzbro6iZwlft9/w5Vdlx7r/yi/k7g+
 E7FNsLHCnLywC35Pe+46QVJUpswYFDo4s6Rv8WFgO2taa6eyMnn3Yy+a7y6yGDy+PraG
 BPQA==
X-Gm-Message-State: AOJu0YwbyZetUFZ7dnej6SPeUw1JlGpX0mLgPdTCAe8fGtv651rxiX3k
 RVDNZ6u5ff2nTWOiZcPqYBN0z7SvQbEYxRCaIy6g0b1YwZdoVQWzP6xieMp4ieYXvpN/k14mje3
 zG4BRV3fL8AqZSEAgVpOt2fZoiU9kHSkJQ+xvJNNRONE1FluL8Siv3tkyEXUfR3jksE7mzePOMI
 TpcFZuRqU7FU5hM0fiGubcuwt8w9ZN8dDfJoESadadhA==
X-Google-Smtp-Source: AGHT+IGC4qEZQVBCkmxNjsnTmEB8FTHYxHlE0oSB0MmLC2oDn9wyyfjrC+X37LfUUDh3O/p94uwpSA==
X-Received: by 2002:a17:902:f605:b0:1e0:e3f:1afd with SMTP id
 n5-20020a170902f60500b001e00e3f1afdmr16637633plg.68.1711018197175; 
 Thu, 21 Mar 2024 03:49:57 -0700 (PDT)
Received: from hsinchu16.internal.sifive.com
 (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
 by smtp.gmail.com with ESMTPSA id
 j7-20020a17090276c700b001dc486f0cbesm15423749plt.222.2024.03.21.03.49.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Mar 2024 03:49:56 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Frank Chang <frank.chang@sifive.com>,
 Jim Shu <jim.shu@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: [PATCH] hw/intc: Update APLIC IDC after claiming iforce register
Date: Thu, 21 Mar 2024 18:49:48 +0800
Message-ID: <20240321104951.12104-1-frank.chang@sifive.com>
X-Mailer: git-send-email 2.43.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=frank.chang@sifive.com; helo=mail-pl1-x636.google.com
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

From: Frank Chang <frank.chang@sifive.com>

Currently, QEMU only sets the iforce register to 0 and returns early
when claiming the iforce register. However, this may leave mip.meip
remains at 1 if a spurious external interrupt triggered by iforce
register is the only pending interrupt to be claimed, and the interrupt
cannot be lowered as expected.

This commit fixes this issue by calling riscv_aplic_idc_update() to
update the IDC status after the iforce register is claimed.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Jim Shu <jim.shu@sifive.com>
---
 hw/intc/riscv_aplic.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/intc/riscv_aplic.c b/hw/intc/riscv_aplic.c
index 6a7fbfa861..fc5df0d598 100644
--- a/hw/intc/riscv_aplic.c
+++ b/hw/intc/riscv_aplic.c
@@ -488,6 +488,7 @@ static uint32_t riscv_aplic_idc_claimi(RISCVAPLICState *aplic, uint32_t idc)
 
     if (!topi) {
         aplic->iforce[idc] = 0;
+        riscv_aplic_idc_update(aplic, idc);
         return 0;
     }
 
-- 
2.43.2


