Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A012FFF8855
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 13:56:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKcjF-0000l9-Dz; Wed, 06 May 2026 09:55:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKcj6-0000ic-67
 for qemu-devel@nongnu.org; Wed, 06 May 2026 09:55:51 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKcj4-0007n3-Of
 for qemu-devel@nongnu.org; Wed, 06 May 2026 09:55:47 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-441209fb77eso668978f8f.1
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 06:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778075743; x=1778680543; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=rfBnR67cSug6VeJxFxqj2aDxrXwWihWO4VxUu8vOlKU=;
 b=f2vDM0th+KPD5UmO7eypYTUlPqF72f7koPGu9qc96SD2rJVHrPU1mZFWfS8BDjE2oQ
 vwvUUOOelJ5TatxwwGqPbcsoKmtWorYKcGAJDtzjJ2xW9kp1GXqh3k7P+L7NE8KXmTae
 y3lji35PKjobtMNpeXIRDKG4cSPDtuU+Dh5nGBF5d+OQFpKiyY4fIm0S3AZ78wGVFmQ6
 IPVV0ZwmLLqTC8mVnUX6oe5oLjZk/tAMWdbw/M1VY9NXpcgZkxGNUp6pSTGAUp8FBOT/
 NmuCjZz3VPDecyXfETkQo0mITh/w6FbCj9pNufCGIliUK8YlIhhPi8kY1KEm2JdImk8j
 F9OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778075743; x=1778680543;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=rfBnR67cSug6VeJxFxqj2aDxrXwWihWO4VxUu8vOlKU=;
 b=hS2nAD2A3ZH98jw5c2cfhOUl9JjXs0gMqICWsTDpWFjbN7/EqAFOSRwkaD0Z2aMCCP
 nAAYuGAQnK1IiEk5WEm+GBsgHwuy8/1IJMMBBLV0mNoMfLNcf3d2XDMRya6TxFc6Xtj1
 MOyvcm0e6seu5kbl16Pd6vBGNKmQE3HMxZZJzjjBghgFFLWsO9FI08RsaeQj7l0knMF0
 RCxjPCJ9kSzDJVOVgVI5LPnmILGoOI8BC7ROC+O7sVbIRFrPAUiOw46dlwyNMo8lYi3O
 owR/9ceAVG3MwW5PJJt4izFpwksx7SRg0ZZUxSqi3g8T8vWATKLkc3VmxxGYgbyD6pgB
 S74A==
X-Gm-Message-State: AOJu0YyNlLij0elL+d8KY32pr7c8vXfxoT3j94cstPnGI+0zRcIZK8WM
 cOJBtFzy03/kZ5hnN9mJhOHesVb7pxTtu9Dgk1+T7to3tih03SZhqNhR2n9/pvdmy8H1ItiHO/u
 No5lra2s=
X-Gm-Gg: AeBDietB59sV6z9oQ+N0rQa2haY5HtQnWRzonGRfryCtptXyDkRIKrtL3hIubGuCfWm
 PFISETP2pGmJYcdpb3JaMFxkgxmYgr0lCKI9H+JanbeeDSWDlhuP1J2I8wa5REgGsMUtPIAHRX/
 WqPn2EKtX6Mj+vGo1TW6Q1SZYFZ5JoRd2g5ZfSyhmQ25EfbYY5hirhcYo4hWobHS7jDlqiUXTU9
 v9HrP/szFMqCCdTG8ub0UaN0mDDLa25ABQsrU3ORbnDYEVRUSBS14WnKhjrn+5JDb9+9BSB1jlZ
 oNOawukSMtywALaEMrPPJ+KqexVp8IMiSg+IxuHDFwrc0Q5KOIOV3pvETzFdE2cgNWv0mHQ/akk
 bES+KM3cjo0KN5yrOh7QyPAebictzftS16sp9DmGvWYxV1Rg/SevCjfyR7kM0R8J392Lbu80Ppz
 MHopp8cevSKPzao8zfRUAzlPoHAzLM2BFYyJED+q/Z8xaHybf+1svMd8/QXK+Mt0GdRw9XnRTwo
 dASKYev+BE=
X-Received: by 2002:a05:6000:2809:b0:450:ad00:86aa with SMTP id
 ffacd0b85a97d-450ad0086d6mr6660493f8f.15.1778075742617; 
 Wed, 06 May 2026 06:55:42 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45052a48911sm12891349f8f.11.2026.05.06.06.55.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 06 May 2026 06:55:41 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 002/110] target-info: Include 'exec/cpu-defs.h' explicitly
Date: Wed,  6 May 2026 15:53:34 +0200
Message-ID: <20260506135524.20617-3-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260506135524.20617-1-philmd@linaro.org>
References: <20260506135524.20617-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

The "exec/target_long.h" header is indirectly included, pulled
via "cpu.h" -> "exec/cpu-defs.h". Include it explicitly otherwise
we'd get when removing the latter:

  ../target-info-stub.c:39:23: error: use of undeclared identifier 'TARGET_PAGE_BITS'
     39 |     .page_bits_init = TARGET_PAGE_BITS,
        |                       ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <20260313062055.2188-6-philmd@linaro.org>
---
 target-info-stub.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target-info-stub.c b/target-info-stub.c
index f5896a72621..07d8647ed8e 100644
--- a/target-info-stub.c
+++ b/target-info-stub.c
@@ -11,6 +11,7 @@
 #include "qemu/target-info-impl.h"
 #include "hw/core/boards.h"
 #include "cpu.h"
+#include "exec/cpu-defs.h"
 #include "exec/page-vary.h"
 
 /* Validate correct placement of CPUArchState. */
-- 
2.53.0


