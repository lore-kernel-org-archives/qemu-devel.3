Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 235CAD6B084
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 16:11:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlUbN-0002Ok-Ly; Thu, 29 Jan 2026 11:10:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vlUaw-00017X-EH
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 11:10:10 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vlUau-00076I-OD
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 11:10:10 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-42fb5810d39so843289f8f.2
 for <qemu-devel@nongnu.org>; Thu, 29 Jan 2026 08:10:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769703007; x=1770307807; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=DYhBXb9tZ9nUut1dqHb9Y0oo8fziSVA1dkINPePndao=;
 b=vx5FKgxXZOxcFEXBLQ7xGgGLpIbhJLmXeOG3xQeK325193FmDXWch3RZlQ7yes83sO
 9dDOqF7cXtc2m0PldMLy6JLIM8g0qZeLvHLCQeT4i9OeUcoE8caJB5rzMHBlZUJlCoVV
 YOStByVLv/ptqGjy632zZFdRxZrjlj6M9diHQYY0RidECndQkkHQ9pGxP7qIh893dF+K
 U2gmykdZEBslNsE8w7HyM3/TYl60tnFegTDajt75qnQlJ0MPs8SBUvH+IwpEnkJZBvf1
 oxvXTn/ALnZh7FNd1hFgpr5XnT1bdGPWEr5/J9hMV6ae8LTl/CzsPz33Xz1ka3E+1/ob
 mRVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769703007; x=1770307807;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=DYhBXb9tZ9nUut1dqHb9Y0oo8fziSVA1dkINPePndao=;
 b=IXI4yLo/A1H0R3WKI9eI16qJmB8TS8nG1Bc5GmMsvTnF1KawUiQC9SgPDiGiB2XyFI
 roQQ8azSdkS551aWjM/Trtrzj0FnufkbbxCii8YEOrvOHvCBlYAJUEqCrm5XDApylmYu
 JtIsavqyXblTKAnYWs8a9kn36nHrZZt4O5L5fEolLOPdIEMYD2u4m1NsXeCNwnfBkHCG
 wnrZ2bcPQlKbmChHoYy1wCfcp8v6vU3Afsa+pOWvjatm7a3abll9PRI9O+gnMSTFXHrw
 kWwyY+4AvZDz9UcmkLfBMJ2cy+qTWAE+CebnQtBJGVgAQ5zCYGLPN1QzAP23SypzDl6N
 LkNQ==
X-Gm-Message-State: AOJu0YxaYaB0ox5q5oXgPp0y+JLi6KGJ2r+ua/lRbLl6Rn3lXQ58TqeU
 dxXdROfWtl33uT+Y+P1b/+V2u6ftWlLX03vW4zwxqBRIfvNfxCe5dX577upse02qQWP7jIYimDS
 eK4gGZuM=
X-Gm-Gg: AZuq6aIsrrE3Ckl5+UgcdMWKT+Sx5w/4SrLOqsLyK+FNqjyhE186SIVDR3wLhlDDVCJ
 pMjky6M8/nDry+W0VjmAaeqIhfmfvAFHJFPt9cDCS2QJWLO9yl9cFqhtqWhOc/9XZ2Zvlmf1IYM
 wvZxQmFz2GOoXfl17mUUK/fD4dTG2DrR3J5V3hd/jn9AD0TnwPzPQ2byGObWYOUmhKpddEUbthw
 QLStpoWhJ5ie74chSIGdf0GWKfblhDo7uBaOSoLlFYyT1RbsqBnakN9f75gOO7q59fnlvc1nDka
 HR5tclStCtCzUHGXxsni3xP7HQ8hIUnVpNg/nkjbUinFroCdSNIBGxps6+XluO7AuCgwvJ1gado
 nuolHiGSsssuwyWwX5BDV8SbsoHol/AGpyyMbDDDR2jaojr3A4uL4bnW09iTqRZQczbIPi9CSie
 E9U5fXgGuQKxWqXLU9+EKs/slonB15CA==
X-Received: by 2002:a5d:5d84:0:b0:435:6c8d:d017 with SMTP id
 ffacd0b85a97d-435f3aa8ff7mr149019f8f.32.1769703007237; 
 Thu, 29 Jan 2026 08:10:07 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10edf62sm16762185f8f.13.2026.01.29.08.10.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jan 2026 08:10:06 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 41/43] docs/system: update FEAT_BBML[12] references
Date: Thu, 29 Jan 2026 16:09:15 +0000
Message-ID: <20260129160917.1415092-42-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260129160917.1415092-1-peter.maydell@linaro.org>
References: <20260129160917.1415092-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42b.google.com
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

From: Alex Bennée <alex.bennee@linaro.org>

It looks like the features were renamed to include the levels at some
point. To make it easier to match features up to the Arm ARM update to
use the full name.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org
Message-id: 20260127145555.3070590-1-alex.bennee@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/arm/emulation.rst | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index 3f30ea5a30..e0d5f9886e 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -26,7 +26,8 @@ the following architecture extensions:
 - FEAT_ASID16 (16 bit ASID)
 - FEAT_ASID2 (Concurrent use of two ASIDs)
 - FEAT_ATS1A (Address Translation operations that ignore stage 1 permissions)
-- FEAT_BBM at level 2 (Translation table break-before-make levels)
+- FEAT_BBML1 (Translation table break-before-make level 1)
+- FEAT_BBML2 (Translation table break-before-make level 2)
 - FEAT_BF16 (AArch64 BFloat16 instructions)
 - FEAT_BTI (Branch Target Identification)
 - FEAT_CCIDX (Extended cache index)
-- 
2.43.0


