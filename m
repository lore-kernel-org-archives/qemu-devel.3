Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE4A8FF5138
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2026 20:01:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wACaP-00046D-Nz; Tue, 07 Apr 2026 15:59:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1wACaH-0003xX-Bs
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 15:59:37 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1wACaE-0007Iv-J4
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 15:59:35 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-35da9c0c007so5170667a91.2
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2026 12:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775591973; x=1776196773; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eTl6UdXPMq3a4SAQ816+q1nAoDgsRIfLxCudW7enz6A=;
 b=UjfU1Z6uoGlQcdhFlHgzAsCaVx8khoYTU8DMjL+PxO7z9cFxXHe090bO9P6j7BpLlp
 BM34AZ6yjXn4+Jy1SouH+J7UC19dl7aTL8PBeGDYFlgfjjf5V9B9SDIq4S0+x4ijvXU2
 dqNdS9ey41Yd25LUVbny8Q5UDiErQ8wa8lDDzQ+1P/lO/dGj6z5ZDyU+Df9BnlbgYmSC
 gZiJOQbRQml2+QygBKyKPbru/TB4sdGKdLNuN1+J5JmVclMQLKxGshmyIqcDxYXskkp7
 oFzV99e4RrrzaiH8xbVj4PsWNbPOUPu+PEJ6Enc3iwG/LI2k28ZG6tPfcOFjllJG7UM8
 ZOtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775591973; x=1776196773;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eTl6UdXPMq3a4SAQ816+q1nAoDgsRIfLxCudW7enz6A=;
 b=cW59JcJcOJUKxtvirrDCzc10U9y8A8QAKBs9zf20FmvqkJ26HXdvh6NamTFUI3TeQN
 WcyJFWrMVUg4i/VHYlf3Kcdz0RSQHsMt9q2AIkS//ja+vvGA5i/LaSKHMCSG0q6CGbMb
 la3uNySZmWK1vLqL5gdGUYw0DG9z6+rlmfiy8b1Vi9KHwxqiWmVpsnNcfHI5qenRVTXX
 zCnDE2/4x0gdDjqbrpJPB8wilFdpDW/M7L0W/zXzeGZP4CxbzFfZbivuchHLVo4qpfpU
 2Jp09IhBApz7BPVanGyBlcxzLRTjGjvqmX8Yibmt5IOHk0rgR59fi2vsO7o9aBKtqQun
 V0Lw==
X-Gm-Message-State: AOJu0YzK/1TI5w9Eqv2oTveHun/MJZrKFNO2p7l/12mdSnO3XTnQbv7h
 eCdLq74VvcOKMujq+yFMUxppadMJJQCy49TXe8NVjUn/QLSBEXYGgSL6YyJyHcw4kBzHdbviq2A
 2CL5fgKg=
X-Gm-Gg: AeBDieu6gNS63rdKBImc1ToDi9yNWwRF0tKKUih+oswaCTm3tPFNC87DkOvhCMWryq9
 FV0IwwESwI7pK/40jbxPd6En22lg6GLsiwv7BZpyDsZq22R5+h9PeJmCIkr+Bkka2WZ7MUpURvJ
 iaDHZekpfobJj8eGrbOJxs7ESmV7lyYxUBL1Xk7jFGiQ2OIxevSp92uK6/Q2r7XMgBvYq3Xr+Dr
 qZ/i0bYCdsUxFH6aUJZeGyBbqEfk4rKXV66IBmCChxBy7hYJ0EpMzj3/TQ6Z2Bhj8AeLLrqz2uI
 wlhLsnDZZLCaeV13KFybPI+udA+MA3wQnJ4bsK0HsSCICgNR+ljgcwkXpkgXVv4/6or88PBu7WE
 Y+JXYMIQtzKlFfboLHgv4gJvWZ8hN1jC224+T6QRf+6yuZwmJ+JRGOerna6+b2O5gOWDf7+j1uq
 qtypkHjfNGIbCaMIAXeBmP7HJldhXq6UuhF3TzN43a9Ko04QpN2L8bVQem70k8Nub2UgTIfnfCu
 gje
X-Received: by 2002:a17:90b:3bd0:b0:35d:8fd8:d893 with SMTP id
 98e67ed59e1d1-35de67eb212mr18427373a91.7.1775591973046; 
 Tue, 07 Apr 2026 12:59:33 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35e27c9855csm126911a91.3.2026.04.07.12.59.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2026 12:59:32 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, jim.macarthur@linaro.org,
 Richard Henderson <richard.henderson@linaro.org>, philmd@linaro.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v10 03/21] target/arm/tcg/translate.h: remove tcg-op-gvec.h
 include
Date: Tue,  7 Apr 2026 12:59:04 -0700
Message-ID: <20260407195922.196410-4-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260407195922.196410-1-pierrick.bouvier@linaro.org>
References: <20260407195922.196410-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102d.google.com
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

Include tcg-op-gvec-common.h instead.
No target/arm code rely on target specifics for gvec ops.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/tcg/translate.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index 6d52606f9b7..e28eac54afb 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -3,7 +3,7 @@
 
 #include "cpu.h"
 #include "tcg/tcg-op-common.h"
-#include "tcg/tcg-op-gvec.h"
+#include "tcg/tcg-op-gvec-common.h"
 #include "exec/translator.h"
 #include "exec/translation-block.h"
 #include "helper.h"
-- 
2.47.3


