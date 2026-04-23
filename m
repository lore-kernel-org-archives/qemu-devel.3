Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8FFCF99366
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 10:06:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFqui-0008H9-Cn; Thu, 23 Apr 2026 06:04:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wFqtu-0006V1-Dn
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:03:18 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wFqtt-0002FF-2K
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:03:14 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-43cf8d550bdso5663937f8f.0
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 03:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776938591; x=1777543391; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=JZCnIRERVfWjIo+EO1aPIaYb12SPwec3CBaDb5Mb7x4=;
 b=ldlETwzSCC1zw/8g0ADjM0OlafCx884xSIAK+te0ko3WyMUGPPCeSjJbKFg+nWrTEQ
 fntd/1tbm30XcVjgwu4nFC9TO2PAk7Qpt4zuNRD4tJOfycp4Hlf9Yxzh/4uy8C5q3rrp
 6/lug5ZXDjlvnECVRWnD3A/j6BwUWq/z4U2r9bUvdqkzRteHLXhawbPURCSvA/jIRluN
 78aAjI8OuUBsdTY006KWBCNZV0NOQrd66G9Ba/blkjJxl4jrwTvMaDE+rzKWk4aZBPgg
 +5BMaTzPRCj2pfcDm+7fQA/+IYO4UWyD+c56OqILOpEOu0eYyLu3eE/ab2J1HT89O+kc
 aMHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776938591; x=1777543391;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=JZCnIRERVfWjIo+EO1aPIaYb12SPwec3CBaDb5Mb7x4=;
 b=hbgxHGpTRySMKxdwzr0hr5AzK9AGIFCJqx3654sxk/FVvnXqYJj2Z4XRJULH0GXOzY
 1pN5Mcm2X6AjswTFphv8Jpu2abC1NuIxohLz653pxQIPDyB28pbgdYdmRplS7n9j2xLp
 P7x0bczG3KtBlIR64UctmUlGajNSaPlhO913u3YFthz+oxjc1XaDgpES0WmyJYjJG6N2
 FQmdGOVnLxysNW85J4maglx5C/IVUTxFUrKK9iVaKdHC32Lz+Kg0HHBfMDuM7l8YIOi4
 C2D+Uen87NURx/ODi2+GNCuAlL6UwEUgcihRVLk19c3snzhkWNsW06x2Vc4NoM6JE7ix
 4Faw==
X-Gm-Message-State: AOJu0YwCksbNenmeE+dPz3jlhDpkF7N5EDnFRcpC03jR9KYfA8y+4jn5
 mQacuZUrVK8n7j6aM9nwoe2JTe2/Ay1Sch5vf4+HMZI3D2Npzupm6/hlG9j7F4d8xK+P64rq5Ji
 fr9ms
X-Gm-Gg: AeBDieuSzDtGEzyEdv4POSRu/vG2DoXPkXxNypM5RMCdIILYl+Pivtg6pa9QiOnsdv0
 jSw1iBhA79E3F8rr1QsYom6V7rAIlVfJwM4QPTdp35Sr03aucvYm1n42AkzmPV8hTdJjrgr0t1w
 wdXdVaweM5og09bRX6q7uoit0TN7eeFsG5W6SoMH29cPiaaDYkQTYI8yFvIe1ndnmbky3TmHtII
 1Lpkq6De3je5Y2p6huotBVJyFL85Ot6JMhuD2iFQV/XjunPOXsbGbDp1ST6elRkeZqdnDrb8IdH
 XuBusmNZw7s+Ju5CUBwLgPxfCbb2vbaf1LGVQRtgrT5UEkoJ/al4Ddcvr0QDn5C9+mduHHxQLdM
 FeeV5+YOY0rTM1Oc9MFePIXq/c63aMTPnOtY4344TOLUdvd5erpGsSoNmjBLRl40gKA7P1yLGJc
 u77epfMNNUQfuQ4GkmVe8b4mHrKY0Q/kJv0PAj9Ny05tUNt355O8T2+9YF2BccLQQi+e8hb8jl0
 HH+rPijPUQOuIiRuPMDQj3ywjZgkPqDrZaIDBIrAg==
X-Received: by 2002:a5d:4d06:0:b0:43f:e934:50ac with SMTP id
 ffacd0b85a97d-43fe93450b2mr24011161f8f.7.1776938590803; 
 Thu, 23 Apr 2026 03:03:10 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e4eec9sm49323930f8f.34.2026.04.23.03.03.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 03:03:09 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 36/59] MAINTAINERS: Remove Jeff Cody
Date: Thu, 23 Apr 2026 11:02:06 +0100
Message-ID: <20260423100229.2941820-37-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260423100229.2941820-1-peter.maydell@linaro.org>
References: <20260423100229.2941820-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x433.google.com
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

Jeff Cody has not posted to qemu-devel in some years and did not
respond to a query about whether they still wished to be listed in
our MAINTAINERS file.  Remove them, on the assumption that they are
no longer active in QEMU.

This makes the "VHDX" block driver orphan.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20260416091654.316158-5-peter.maydell@linaro.org
---
 MAINTAINERS | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 567b918a70..d86d7536e6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4179,9 +4179,8 @@ S: Supported
 F: block/rbd.c
 
 VHDX
-M: Jeff Cody <codyprime@gmail.com>
 L: qemu-block@nongnu.org
-S: Odd Fixes
+S: Orphan
 F: block/vhdx*
 
 VDI
-- 
2.43.0


