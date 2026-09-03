Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C41C8C624D6
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 14:46:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x28fD-0002sp-U1; Thu, 03 Sep 2026 10:43:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x28fC-0002qt-AF
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 10:43:38 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x28f9-00046z-Vs
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 10:43:38 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-4843f205a5bso1743272f8f.1
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 07:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1788446614; x=1789051414; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lQw6tClcEuh8wmhjZmi7xrA9dHVcRR/JsHSDd6qTuHg=;
 b=lpsW3XLqi28xzP1bKMn3J+NLOc1lc6kbFpLG4b8bfvDol9sni+suB5ZKM9YyAN1/wD
 SnIez3Y1PSEPAssr4lV1cDbiQZtnoL7ZljxIjbMckJeIeUbseT5lv9eP6An0EW5T/aaX
 Ql8obEW7KKRYdVDA0ZnAmXP5rkSDlR2Enoq73pxqpnd8rmRXaiyZUGGHk6n/9Jj2Bumc
 rmGjojbTo9fKiWCStsG6fnBEZv3Mq+DBsI8kOlsfB/QKppHpoC67RnUOP0nbDfBzqv/M
 6eeFor7vnPxSCdOfpvZthPP6u0CkYRJZS106fw7U74ciGR1ebKmReiKH5Ruiess+6ZXt
 tL0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788446614; x=1789051414;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=lQw6tClcEuh8wmhjZmi7xrA9dHVcRR/JsHSDd6qTuHg=;
 b=jlQFencGQSbwQPZotQfpww8wDI1N07yFkXpAx8r8cnFkYqf48HNk3Io0lUbnd+bzh0
 UG1HD7p1RcJc2dl5R6Rq5uoBHpCcUNs8roq/1AFeCAWfc1h7Co+DQyHH2brGOTPEO1ia
 m9qk4jGqAlDadQ2fzOPCssCfaODsyJNuRxR+j/Tpyl2/tyqZNr/CpPAjoV7RF6UfQUy8
 aXls0SwPHGwJUUNYs7Rc0Km49zAqqm68RkBUxnDh87pSeZ8aFI29ZEsMMAwTS+XWDJSl
 tVBlpfgcWhc2mxoKEmDX2yxMdDUiVnsaGAQIPEatcw+XpqOWuR71rYS0K3pjTK+L7ziI
 wSuw==
X-Gm-Message-State: AFuF++kfyUxDuFU1lW6G951fe1cXY+CZB4hLB/pYsdIdxJ3J3j/fOHDg
 o54jVlIIYo3n7kKUzAMPhzgTu6s5etRqZ1sLBCPp+dBAwMx9NJ9l6WdXUoZOhkWnpoKInGmTlJN
 HRaSm
X-Gm-Gg: AYBFou2liT9AxZyIqQowWQkgvgHwOm7Zvu4QuWMUxfIldjoOxeWoRbdRXrltsDrgBZ6
 xWwsf/Ajp/HFphV4cyYJKuds1fU5orXYmXKywk2Spv8edqzturF1cglxVs8gVB4NGI455M0hS63
 +jHDeKN9JuuLcpojH3yGTQSjUOrN7+8xJZNulhmdY/2rGjsQPyxPHEQBheLt+lPD2Sfn+zGu8SW
 yHgAQM6KwHiYZd9htqK630nkZk5/SoDGmiGZCfkKsy2x8LCVUywPfiuznC3ec92+KnCOWHrAsRe
 nc0W2MwXOh8qLMuujCh3LEuXAoc41RjFGl8WAU+gmrefrqaRMUbb3rFIm/srWLx3/cDNd+RZ5yJ
 RxyH0kOEfxliTa9eOJzQg2VXX+lDcG2sSejIQDNGHg4o3zorBcAkchuChZXLuVPXHQSYNL2UITV
 thPfRr3DrrgY4n98WL/s+sleHdtY7lQO4SOAS8bvCFC+a1EK41vWX8auoYgvFLgglTQiE=
X-Received: by 2002:a05:6000:420b:b0:45e:e1a4:c4c3 with SMTP id
 ffacd0b85a97d-48488f20a4cmr19977599f8f.15.1788446614384; 
 Thu, 03 Sep 2026 07:43:34 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:83cc:ab98:cda9:7dc])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48448ee9cf7sm15165483f8f.25.2026.09.03.07.43.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 07:43:33 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH v7 20/25] iotests: rename parallels-read-bitmap to
 parallels-bitmap
Date: Thu,  3 Sep 2026 16:41:38 +0200
Message-ID: <20260903144143.2328870-21-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903144143.2328870-1-den@openvz.org>
References: <20260903144143.2328870-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=den@openvz.org; helo=mail-wr1-x42b.google.com
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

From: Denis V. Lunev <den@openvz.org>

The test is about to cover storing a bitmap as well, so its name stops
being accurate. Rename it on its own, as the patch which changes what a
test does should not be the one which moves it.

Cc: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
---
 .../tests/{parallels-read-bitmap => parallels-bitmap}           | 2 +-
 .../tests/{parallels-read-bitmap.out => parallels-bitmap.out}   | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename tests/qemu-iotests/tests/{parallels-read-bitmap => parallels-bitmap} (99%)
 rename tests/qemu-iotests/tests/{parallels-read-bitmap.out => parallels-bitmap.out} (100%)

diff --git a/tests/qemu-iotests/tests/parallels-read-bitmap b/tests/qemu-iotests/tests/parallels-bitmap
similarity index 99%
rename from tests/qemu-iotests/tests/parallels-read-bitmap
rename to tests/qemu-iotests/tests/parallels-bitmap
index f5a1f33907..814b56b32c 100755
--- a/tests/qemu-iotests/tests/parallels-read-bitmap
+++ b/tests/qemu-iotests/tests/parallels-bitmap
@@ -1,6 +1,6 @@
 #!/usr/bin/env python3
 #
-# Test parallels load bitmap
+# Test parallels dirty bitmaps
 #
 # Copyright (c) 2021 Virtuozzo International GmbH.
 #
diff --git a/tests/qemu-iotests/tests/parallels-read-bitmap.out b/tests/qemu-iotests/tests/parallels-bitmap.out
similarity index 100%
rename from tests/qemu-iotests/tests/parallels-read-bitmap.out
rename to tests/qemu-iotests/tests/parallels-bitmap.out
-- 
2.53.0


