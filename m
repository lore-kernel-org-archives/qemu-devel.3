Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A66ACF46112
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 13:48:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4fdI-0000de-C2; Mon, 23 Mar 2026 09:47:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w4fdE-0000cz-LS
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 09:47:49 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w4fdB-0005Xf-R8
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 09:47:47 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-439d8dc4ae4so3698426f8f.2
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2026 06:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774273664; x=1774878464; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lDhuw2IJg32nXxRPCi62WRK5q30TyZs9Esw5mWCSeJ4=;
 b=XYYEsGmI3wy5dWr0DAq2rIdEZ/IQTqTSpuY7IuyOMcpSR6yitBN8J5z3lx4xg8pCWO
 Ilmmhg6EekVY+En9X87uIfxSyk0/SO+7/vwY05HE9x/UPFnjeoDBWNyw4GerheTSrVq/
 G8sXwFWofiS4yDtKnR/iTlCDtGg7mlmmuI79kjb6hrn5EUTKYr64m+ImPS7m0+jV1p9/
 45bBtI6YOHpB40zY18UQKjLTxj3DhQ/yaaeLpRKlUHCiekqKJzhprxr4IYlyxLdDW97k
 iOesG1vedMsUeNqrno4FXyIJ0etc5oArHVZ9XaQxcau3f2+QlPtFX4JdgUQtq4w3O13m
 K60g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774273664; x=1774878464;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=lDhuw2IJg32nXxRPCi62WRK5q30TyZs9Esw5mWCSeJ4=;
 b=Y6FVdY5sCjUDFs1nm7qJTNc9aFgNmcMnPO2UbyDmzwFn/9l/X/SYVW7yRTRaxsDTG/
 Y8UX2LIYGBVpDPx5+/4IU410Db5iYGnd9Ewr2M+8KHL78dohyu8qs0TrZYE2QHlItDAr
 OsTs+HfImt2VGYVNTJdXYee2FQCsZG+xgxoxTUnl7/085j+VynRvxVJBUw2PIrZirDJQ
 e3tu5qBawbuzgXzO5ap217wOLVbCoXeOxwsr/iXDT4NIKotyKsCqPm9nLLE44c+lL3HA
 8LA8srAor1c7Jc/4x4i+pHv54Xbi3A0F7ACqm8ngFNTxGGVfwm70vz5/lBBIb3X5jtT/
 pAFg==
X-Gm-Message-State: AOJu0Yz6JRRxxxQpk6EAEymObGYbZLfJq3FruZ9zNqSX3vJCP8r5i713
 DgyV76v6t7B3n0Y08qy2aPvSvSdpmIwlIGLGI4Lh4QD6sEJGPSxjxXJ7AGHPADSpxpqEHfayKIh
 SSa/JTWI=
X-Gm-Gg: ATEYQzxW4vIse+F857FrHnR8AavA2+3OOoOC8iNgt6oxp9TWcwPSLM++riLbTvqM6c7
 jV5yA+tV2M6MeQ/OTGmsO3NVxdKfC4ad74+GzjdEJXGaTp2ia7++PMNWbRXAfFn2nJWk2g+KpuC
 +hANL9xrPsBblhN4Or/LkXXWp6I7EobI9DnrzAN38C54pEm2EU/LcD+WPDmBC5hnKgBWWWeBcVb
 SlGfVUO99OqYKSqQoIP7t583I1skjzrC0x9zSNO6fqpR72K3dKd2VxJ4uhFxy5vFryg9mlLvgMH
 8Fi2xFu6YMkanVkOfoQcw2k//+yYzxVCXPC9MhYBTEzrNbbb50hZzu4rLwx9j3fe1Ef8NA/r/UK
 ysZvqyDAWMXb9yF9XVxvPem417zppGJUZyvZuK+MQbBTpMLa59TvPwJKpEcX82Zpdv5Sz8Hu1gX
 R8U5kH+xN60SdF9WpO838zBMSXsvzgTm2sj33HHtaMuayjQo9JNWIRTyIoYYXlA+jbz9YroitPN
 AxydnvCPLk4EjYXyvKWW2WC6yOMmCU=
X-Received: by 2002:a05:600d:8401:b0:485:35a4:939f with SMTP id
 5b1f17b1804b1-486fee297bcmr118977545e9.28.1774273663896; 
 Mon, 23 Mar 2026 06:47:43 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b646b0d3dsm28308143f8f.16.2026.03.23.06.47.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2026 06:47:42 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/2] MAINTAINERS: Remove Riku Voipio
Date: Mon, 23 Mar 2026 13:47:40 +0000
Message-ID: <20260323134741.4114629-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260323134741.4114629-1-peter.maydell@linaro.org>
References: <20260323134741.4114629-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x436.google.com
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

Riku Voipio doesn't wish to be listed in MAINTAINERS any more;
remove his email from the relevant sections.

This moves the "overall usermode emulation" section to Orphan status.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 MAINTAINERS | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 25fb621c30..c686010599 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4052,8 +4052,7 @@ F: hw/core/resetcontainer.c
 Usermode Emulation
 ------------------
 Overall usermode emulation
-M: Riku Voipio <riku.voipio@iki.fi>
-S: Odd Fixes
+S: Orphan
 F: accel/tcg/user-exec*.c
 F: hw/core/cpu-user.c
 F: include/user/
-- 
2.43.0


