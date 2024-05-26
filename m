Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30E50C25B78
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2024 20:46:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBKkg-0002yh-Vm; Sun, 26 May 2024 16:45:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBKkf-0002xx-0r
 for qemu-devel@nongnu.org; Sun, 26 May 2024 16:45:57 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBKkc-0003fr-Kp
 for qemu-devel@nongnu.org; Sun, 26 May 2024 16:45:56 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-6f850ff30c0so2901517b3a.0
 for <qemu-devel@nongnu.org>; Sun, 26 May 2024 13:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716756353; x=1717361153; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=DsMIKy/L5erl56a6I+mGWGQ4rNvzDGnzn+CAnzypzwo=;
 b=tihjwXC6kHqYCCXuT0HsByeg4m7T2bPeldiUZqyXF3i+qgzuk+HYTnVpDgHoHTPUMf
 +2UW9EHnYSmOvjSfd2cun/Xy0+0yAJrhwOnmdqv6b/D2Zct7UQTvBxMUWwys64lU0BC7
 Tke91JNsEFYn1SJ0tHt4UKmBcGBdAmSbvhiBZaBPvjdCRtV2bSCjLqFCoNvzY1Eq2FnZ
 SuxWQaY5rnJxQpzGMQx7IjCwOL7l5YUzpUJSGtsPF0Ibn/vkAtN+joOPZiqGvNFIJZCl
 F4VZN4MUuxnBtbS5QtCQO3FWim5Zl6+LDPXlftqNLQuuTKvv0eS65aIf4J3JYqrnwcat
 xeuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716756353; x=1717361153;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DsMIKy/L5erl56a6I+mGWGQ4rNvzDGnzn+CAnzypzwo=;
 b=Dwka33alOIMSGOPxkvHdhoA876DPQ+ScI9H8JxSJO8Ib+MhNN7bpg68r/DXpJhr41n
 Jo/hFSa52/usXtwz8AXbM0WZw/knWmsWMBnsnqpr/4PMMi5s/bGdgKovXMf/AYPCMaka
 gWqnwqJi8n3+yU6WYv5iUy2tRIubOdXqRApqAPdYBCbbPA5YfeO4jxSebddiGblzGpW9
 jT9eNExzHQAMOPSvvtJ3I2oDCWqiQoSM3N9QnN/lvFD4LzIX0MBZJmip6luqAYWuWI0l
 6zM1s9vcKNpKmo5ui0gySiesdvaeNiyFaknu6T8tGIfwUv/egLd+3kK9GXE/KFX1DKZV
 h4Hw==
X-Gm-Message-State: AOJu0YwsCOftQ9khztXVJcn7lIoiXPs5+HSNELDC3b6mSzRZ6QxlxwH/
 V+8uMVaPigNa/n2Mj+0LEnQ6eVVW0ZHxo2uagK2gGe5Fng7jv06hOHsLfvvHsuCKYvO5gdAH1wy
 o
X-Google-Smtp-Source: AGHT+IEkVANMJbJhPg/CKMsdet/lgahht2iOiXSQf0TVFjjeGQ2uKJDDkpEDavd4VNbcoxyEgslYGw==
X-Received: by 2002:a05:6a00:1d8f:b0:6ed:21bc:ed8c with SMTP id
 d2e1a72fcca58-6f8f36f6f75mr9368156b3a.18.1716756352599; 
 Sun, 26 May 2024 13:45:52 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-682226fc4bbsm4658843a12.41.2024.05.26.13.45.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 May 2024 13:45:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 qemu-stable@nongnu.org
Subject: [PATCH] target/arm: Disable SVE extensions when SVE is disabled
Date: Sun, 26 May 2024 13:45:51 -0700
Message-Id: <20240526204551.553282-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2304
Reported-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---

Marcin added the correct patch to the issue 3 weeks ago, so I'm giving
him authorship here.  I only updated the comment a bit.
Marcin, if you'd reply to this with your s-o-b, that would be helpful.

r~

---
 target/arm/cpu64.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index c15d086049..862d2b92fa 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -109,7 +109,11 @@ void arm_cpu_sve_finalize(ARMCPU *cpu, Error **errp)
          * No explicit bits enabled, and no implicit bits from sve-max-vq.
          */
         if (!cpu_isar_feature(aa64_sve, cpu)) {
-            /* SVE is disabled and so are all vector lengths.  Good. */
+            /*
+             * SVE is disabled and so are all vector lengths.  Good.
+             * Disable all SVE extensions as well.
+             */
+            cpu->isar.id_aa64zfr0 = 0;
             return;
         }
 
-- 
2.34.1


