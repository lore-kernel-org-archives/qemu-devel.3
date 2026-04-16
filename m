Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A57E9F8A145
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 09:19:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDIru-00072J-C7; Thu, 16 Apr 2026 05:18:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wDIqW-0005EW-92
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 05:17:12 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wDIqU-0007lV-E4
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 05:17:11 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-43d43e09de5so4633514f8f.1
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 02:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776331029; x=1776935829; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=rXxsqvU8KAHfpNpeEIYf8wNiKt588KH4HTajlRG1OBU=;
 b=K/rC/3DMEOo5GBt0+rWvkHA5tKo5tPrHu48gWcvFuHDY3xCUnTYFGk8oJ87n6myEbh
 1rmQHNi8SVt9dTtxx4hxRImWEM+OQ0RXX/6/mLOEI0TFLLsN3lBR9bhb/ervdOyYOwPH
 gZKXM5Oe2DEnK4QGkG8WlQw3B3PjZj/Epd61vYrd4ZK4lfA40mNcFQjCc7m2XHN1gTTu
 g9tNXlSSOrl/zCcqe7V62TqfEusK34lvu/Szdl9m7H2h1SxFpG3ce8p5K2fcVI1P2MV9
 14DN1Lh8dArUC69/1tYqa6Da3AutBZ8RooZvgHYG51ei6iEySlNNMkBVfoOhWPWXFtB/
 cBig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776331029; x=1776935829;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=rXxsqvU8KAHfpNpeEIYf8wNiKt588KH4HTajlRG1OBU=;
 b=PRlJDVpL2coA9f4KlDhJhQU0nuxg83mjqz2a4k5NtIpA03/r9FUR9iRAkDmMxeECk6
 jZVd1v03y6t7Lougn8lTsE+LC296zWCoqjBj5qn+Zwok0DjgrJkk3zvo8qAXehoMpuGs
 rDq9LOtsCi6U6L/ncZp3XJ3grKdHd9q7VGcICF5NkfPP3wFaC7hkDQov0qh+7ZzyPY2h
 sAwTD2YUG9FYD30EbjzAMWQZYAB7ckYyxDvS+msT9JyseagqTQq+YID8I+ThLIclnC7d
 K675l6Cz2zJx3pNGtJbVV/xx2+XMigXubeZFxF9OXMDBJYGD8XuDbMy6qAK5qIXzdq84
 dODA==
X-Gm-Message-State: AOJu0Yy5NMxpPENCxnJ5PSZI7Ww6Yv1j8wHNrL5hmtu3bXuRLbCcWcKs
 hXaf2qgsFHRK2vLVPWkgWGNrCrS8U2Y8V4N4wpN7PQcle5ueSDbNDOUp2jF27AX6ZzHcDcrgTHB
 rF2p2gLU=
X-Gm-Gg: AeBDiev6Ocw+U9shBcVuDEJcvZF2pGtxk8mzzloPIOlJyLgKSaB9aeXaFrmLHS93Job
 9WYFC0BIpxgh6Vm3QODelSndVSphyjx1XJRru5ORuqLpt3LBy3VZATYGuD2DL1k59wZUi/LisOL
 0QqT3r+LTWGTwbnI3IYA6JFav1ffowTafw3dFhcYcKP8PzdOXE8gluarwz0ULFYxcc6J3JffcEk
 zeveIoM/4Q/nvxVFOjVRKtrfkIzBYZ2x9OCg7DvUjDLEKi5wynFxbYywSEruYftTqWD/5Kbkaul
 YcAdIfENJJCujP+c+JThlUiKigIWGlLL/uUAtP/iF/NiP7H2bG8XXHfZANb2Ol3A6VcyI2E0Xnh
 p4bUUVg3JbIh95W9zt+YhfIiz/mu3S8m8SUMjcmNhvpV0oGg7JNHpxY2VrA07KT5xu54FAIa8Ei
 nrQmQbIWdswam8JBlcUB9C/bbrLj3s/0cE31r/F61GesjcIO5NA4hO0YfePC/miWaADSwca+zWV
 Okl5op/TyBX1tFRARt+9iEQC4tZTlhg1Z2BR2cdDg==
X-Received: by 2002:a05:600c:a305:b0:488:ab37:b442 with SMTP id
 5b1f17b1804b1-488d68c7f92mr240153035e9.28.1776331028679; 
 Thu, 16 Apr 2026 02:17:08 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488f5818da1sm37186565e9.6.2026.04.16.02.17.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 02:17:07 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 12/28] MAINTAINERS: Remove Mahmoud Mandour
Date: Thu, 16 Apr 2026 10:16:38 +0100
Message-ID: <20260416091654.316158-13-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260416091654.316158-1-peter.maydell@linaro.org>
References: <20260416091654.316158-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x431.google.com
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

Mahmoud Mandour has not posted to qemu-devel in some years and did not
respond to a query about whether they still wished to be listed in
our MAINTAINERS file.  Remove them, on the assumption that they are
no longer active in QEMU.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7817a1c97d..f5cfeeb239 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4091,7 +4091,6 @@ M: Alex Bennée <alex.bennee@linaro.org>
 M: Pierrick Bouvier <pierrick.bouvier@linaro.org>
 T: git https://gitlab.com/stsquad/qemu plugins/next
 R: Alexandre Iooss <erdnaxe@crans.org>
-R: Mahmoud Mandour <ma.mandourr@gmail.com>
 S: Maintained
 F: docs/devel/tcg-plugins.rst
 F: plugins/
-- 
2.43.0


