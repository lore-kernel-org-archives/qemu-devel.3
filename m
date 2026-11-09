Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10625606A31C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 16:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=thRNB6oP
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQRxP-0000Lm-M6; Mon, 09 Nov 2026 11:10:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xQRwx-00008D-NC
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 11:10:29 -0500
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xQRws-0005pH-Gk
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 11:10:26 -0500
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-8b4c8b51b58so696033b3a.1
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 08:10:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794240618; x=1794845418; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=YFc5dCRqkcbfzirL8jQAoqTW5yFCVMgCcIvLwP2L3Kc=;
 b=thRNB6oPDFQpi1zn78QMXQw150hkm6zlYbdMQ8GPZo4MQhofyZpGXrbpC+YDQbXArY
 IT8VvhRIVYmBms8U4FKMwYSo1BUIZKZK720a5Rs3Kr6oSIiHMupj9gF0mbj6kYhxpVVm
 yBkQPkicqQTanUdU/mESpcHgIQj9j4qIam/GwcD+n8b5KwH2tNPnXHXsLwOi82AQJYa/
 9rgnemdHZs9neK3igN/xQ+vtxU5IZL8l7zGmqW943qBlFMkEr5CCQuhELb02z5KL60bD
 PKFCmgwIDa7zacnLMCOJcqomDc7tq/pe5n2m5bQhfMkg9vXQWuYdaKu91ywel3e5ZDGA
 oS5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794240618; x=1794845418;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YFc5dCRqkcbfzirL8jQAoqTW5yFCVMgCcIvLwP2L3Kc=;
 b=cV3mxXxh1A5R/YlsLR5nT8xuQW51h+WXGxqGZ+zYLH+FOATLGXSxB8NvlL4xRnEloq
 qBdR7FxK/xbKV2FGDWotY/xf79g+gaZ0qgySTMLV4cdaHEYmNi+3n0zCJc8wum4b7vg8
 trbPt15HTKe35z66ZkaanytvdEkataxXqtSUsIQt48L9QonQbRg/NDB3y/CsSdcEodJ0
 hNQdZR9enbc/E207OOAYIrG0L4+qbo3SWmhElS66lFqpyAlJd8Mhi8Eool510g5ApLdp
 jnb0e8AL7NlKVN1/THFpac+BjQW4CFp/gIJ4iVCJFqLuMBXjGp+ZXt5SRp16OltupO7R
 h0sQ==
X-Gm-Message-State: APuU4Z+8sv82hYfyRtqZ0q2b0Z9jLWYGUnvCr3lsQJI1SefSzBEs0DGG
 fYilGmD1UNp8HGbph0DVDOH/LbOLT1ogOYjK2SxZXmRDGtc2CvgEnGlM5xpFv0W0v8fUHwEbAjr
 UBorB
X-Gm-Gg: AYBFou2raDBQTBxfCA2y4xeseGVl6EH+g7dPsJbfO9da6263KN62ZnZFespQMc0dyev
 SqwB8jZZ+zzh9YtLzWXd7HWtgycFQrxS+aN3EQ3Xli/CB3LETXFixxbWyiUUwDhDaEzrA6p+ult
 Sof4X0N6SENAq8yOpP9wvwqmVBlqhPex3Wqq8AMRQJLtzVnbNCUOh9qt+yJmdeTbbsqIKxKDruo
 L855t/hFEMi4Y8Ztbtu05xN5R/X931togUMnTfs8cduIPi268F8RPBpamoV9oK/9jBhNx43Sbj1
 dLcQEw0Ast/Fisug/HC6N3c4BkI8YeqKztVwZxqJ0sF/d3nXCTs0oC0EO5gI80DWgDfOxkH3/Fw
 tfTXFVNod3Yfv8fcFHbAx/XY//GNiuZ1enAEij8d1LxhgrOLLmJDI+S9jlJFu1PexUNZrbguUg9
 5PFTsgUWGSO1A0l0FW3+QP6ZA5ujaa2SFRcS0dySN+F69aLPJdW+JHJ6jAZ8FvWNmL62FkgjVP0
 J7OrPjSNdZVQGSmX00AxcQhb+7FUoW5KahXrywDID71Z4LjOKurZvYbv4BW2d2wNNc+mxO47BAx
 atr0I3ar+Js+GhLKkMjKH6iQItIwEg5ONfVpeu+R8iKPcdsi/dqDI01E9tc7
X-Received: by 2002:a05:6a00:4290:b0:89f:5bc4:fc95 with SMTP id
 d2e1a72fcca58-8ba8965908dmr44176b3a.23.1794240618004; 
 Mon, 09 Nov 2026 08:10:18 -0800 (PST)
Received: from stoup (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8b648e55e85sm1598946b3a.17.2026.11.09.08.10.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 08:10:17 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH 0/2] accel/tcg: Fix #3092
Date: Mon,  9 Nov 2026 08:10:14 -0800
Message-ID: <20261109161016.43218-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This isn't urgent, because the assertion is not enabled by default.


r~


Richard Henderson (2):
  accel/tcg: Drop DEBUG_TLB_LOG_GATE
  accel/tcg: Adjust tlb assertions to allow stopped cpus

 accel/tcg/cputlb.c | 80 +++++++++-------------------------------------
 1 file changed, 15 insertions(+), 65 deletions(-)

-- 
2.53.0


