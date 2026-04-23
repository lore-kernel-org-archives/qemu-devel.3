Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5F27F99366
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 10:06:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFqub-0007dM-Md; Thu, 23 Apr 2026 06:03:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wFquF-0006dr-KB
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:03:37 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wFquC-0002SO-3b
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:03:34 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-43d73422431so5468586f8f.2
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 03:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776938610; x=1777543410; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=yNMD+cZhFkCSWWBwMZg0ulQAIbieaEaFnQleXzBKqfc=;
 b=XzE0pfec4i8BJZ6thSoXAEuyu/aXH4em22Qizu2RKrM2EMGO92BoDq/fzypABuN4+M
 Ji4XvXh7Hjj4sunm3md5pMXo+pDey/mmjYABnQtpkfnfuw4uMsc7u3WjYE7kbML8FK7t
 oDIe3JkgVQ5OOtiyBxezqA1R0JD4E3/XYvvmfILFNyIrqSZp7jOphl5p6ceFrmllCwey
 9qPTG/QQTOOfpH8aoDrrVE8pEVEClLWhPCeArjMeS0+xeLvr3eH/spse6cGo/8mjRrHQ
 9NSSRvKpB5RDUxgejtAhtIWRG1B50Z5+zeHPWVDWXC9AO9HtBPFH90wnzxNW6zZBIQdA
 wCPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776938610; x=1777543410;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=yNMD+cZhFkCSWWBwMZg0ulQAIbieaEaFnQleXzBKqfc=;
 b=V82O4QkzCPg8jBYHgY1D7AxoaGOZ04hq47ZCPHd4q0DZbIuHmaMNjO6aday/BvxmdJ
 ZGaYSTWZe7sPBDKTZ0sm56guhGpgkHzZ1v5OYleXSDvaZNybHqdNj0t05ecoGFplvsHQ
 PmJMPL+T8ictni7cFgoFdHhDx2/fCdhRJylcSOPs5rMTOulEJ4teWCPEN4qHzvFodFiC
 PMi5sA5AaiawBEeVBnT6ZKBF8pckGWsE87YWB4tiSXYn5Zpi5rsGw+JDUCgIZwsmN1Pm
 YuCIBRG933XB3+ROPc3MPx/pIyP5Kg1+6TJPDekAMvOZ5ScmZKO5yAwiaxq5/51xnUHz
 EcNA==
X-Gm-Message-State: AOJu0YwCpMQ+cRV917CA0X7UcYufkvXUhQiA5PJsF3v5QpQPRny17Dle
 WoO0GrhEtpBEWrpT1uX2puCTxKBYHWa3fKqUFUnbDfDLYwlQLxkVEiQmZ+VSG42q/sjtv+tIHwN
 QDTsE
X-Gm-Gg: AeBDies8HucDpvIbwgUsyDK4xBelorGGc/l+Bp0ufuKVjePAPhB2wjie0PwScWUyrxm
 GDYm8i9DfO3kNJNv3b+XskWOaFT/wk32tWahYCcwJE35SKI/iv4ZtgwLydnQbj53WCsV9XqVyhZ
 aHSoG454cRKcv89PzFoPm65wEHqHbtLrQfUc85Y4ARAVqWeUhiqWs5ahJtHbWRFDGBS90ufjP3G
 RW6nOAd3NFhw1ebCrX0v1SmqUXTU8azdKzPqAJH0uxRwgyCu9VqVZBjTs6IYejK/84yO8dRfth0
 NyKREW2urf1I4H2oQQbZMhkg/2stvf/5pMcZ7ytSGaw6U1nTzR2eqX2J4DW9DDmbIfTd++Ql1ZH
 TKRZ+xZs+ejoQ0MMk0mxoq7vSpz5+Efa88+m63T2+vWQNTZTGkbR3ae45kx/CuHitf2TQMaiKSH
 Mjw+YXQrg0lrm5Aa3Y2sPANLXRqhpw8c85w/Zw4zYFDUQZx0qHr5Spms2xLBXJceFiOX5UvjUJv
 DsS2PfMO+KuKO/XgYZ8fBLiZOBmj5fNhKMfLmUVFw==
X-Received: by 2002:a5d:4350:0:b0:43f:e721:76b8 with SMTP id
 ffacd0b85a97d-43fe72178cbmr29474734f8f.37.1776938609991; 
 Thu, 23 Apr 2026 03:03:29 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e4eec9sm49323930f8f.34.2026.04.23.03.03.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 03:03:29 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 53/59] MAINTAINERS: Remove Shannon Zhao
Date: Thu, 23 Apr 2026 11:02:23 +0100
Message-ID: <20260423100229.2941820-54-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260423100229.2941820-1-peter.maydell@linaro.org>
References: <20260423100229.2941820-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42f.google.com
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

Shannon Zhao has not posted to qemu-devel in some years and did not
respond to a query about whether they still wished to be listed in
our MAINTAINERS file.  Remove them, on the assumption that they are
no longer active in QEMU.

This makes the "ARM ACPI Subsystem" orphan.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20260416091654.316158-23-peter.maydell@linaro.org
---
 MAINTAINERS | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index ddb2633ebd..b5d5f74099 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2185,9 +2185,8 @@ F: docs/specs/acpi_pci_hotplug.rst
 F: docs/specs/acpi_hw_reduced_hotplug.rst
 
 ARM ACPI Subsystem
-M: Shannon Zhao <shannon.zhaosl@gmail.com>
 L: qemu-arm@nongnu.org
-S: Maintained
+S: Orphan
 F: hw/arm/virt-acpi-build.c
 
 RISC-V ACPI Subsystem
-- 
2.43.0


