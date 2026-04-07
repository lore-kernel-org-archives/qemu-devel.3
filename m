Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (unknown [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4985E10F996B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 18:32:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAXeu-0005AV-2k; Wed, 08 Apr 2026 14:29:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1wAXes-00059S-A7
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 14:29:46 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1wAEoT-0000oQ-SO
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 18:22:27 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2b25cf1b5f0so36709665ad.3
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2026 15:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775600544; x=1776205344; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FGhpyO9gJO4O10TYeQgNeX96IysIFLL6455aGE1zsuw=;
 b=M2MSunQvcXgNjwTsdXQ+5dh8SHre+uV+QOmaibdnTZATGmKIJvepUyKrRbmbklyQTI
 JtjWDFsP9AuZlblTH4Saz0nCvxicGCLjQ8OWMaKm2jMFPho+3Tn+libxMsxKuYeNiWJn
 t6vnR3UWIuBpWNFoUe8R/m55P8VX5Yvu0vKIJgAKgFcn6Gr+X81ohM5qMPYB/mvD031Z
 a+/ut2qiUCIvTpz5PQVwY9iQPCp8qMawaIfcQxnk7AQbHuMk4dJmMU8C1sC4XIm7vNRQ
 UMIa+RAASJHWPE4XO0o+mXAOGC/YfmSh6vO2Bpm9dAPHquGT6sdMP+8PMcXmpGkxm6IA
 NbxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775600544; x=1776205344;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FGhpyO9gJO4O10TYeQgNeX96IysIFLL6455aGE1zsuw=;
 b=lU+047TfwiPLLDB53KxW63O7Jl1BHLuGp7qxA8NuvkYjxthZmUzUYVHhuPHZR3sR1i
 IfFYta9xw0pjHpLBTZ7lO+0zEkwNWZvIogQvZPhsHggUdN18fa+crE592tYp+FfprOiY
 HwIFz/MlDexnFBYjvqcAgV2dgzTlb0+oKfVDxTHFVP0gUjGJS3ZWd92L+elN9wo5cz2y
 BglYjqYQ/OWfkkLd8I6k/Vx5o+EJBip4zX+IBAdEA8+yD5UiieSUBGQz2VHNg2uHszLW
 CpCTLNO4bxqigNxZrbreMrjGRC4QpWr/U3KbQAth5Wa327zNPcdDknhO+wucIxCt9ssl
 HSUw==
X-Gm-Message-State: AOJu0YzZDdizSQgWYht6xgkd75Jd7yKi3kVb+I9xSSzKrWuU+cozn7sN
 4IKLvkTfN/Tao5redwFsdWPbPB/Sd9SfTsFRyRALGIpLqhwe11OQ2351oTOo/bHLmSbUwzoHA9E
 CQzCRg0Q=
X-Gm-Gg: AeBDieuwlqN6T1RAqhbGap5aMcom4KC7B7Pt5c2N3qSxdZL6/KffAYPihYICmCzc7QC
 JxDPZz01UIcii442PSI7h6Zm/H7dDuP1yJbh+G1fQyX0USmuuOzG30a0cF1xU6utV3LgnTf8WVm
 xWF7dwezA6VdLWj6EKdxXz9XoxtVH8pc2mOmkALSeOEoyjO1KzgndVfQ/nV9fqUyhZuVNJmZzal
 GtJ9NsywLMiNHLLqWQ1J+rFLD8o76WqpUhRMYgaTNr+i75qAi8E9lWVPbK1vRR1Y55Jw934KFNb
 vB3gsNcyWTi0oCPIFCv3nAHNChVs+mhTWtP/smNgYmK+79FqFllC6HXi5dNadrkB9zpdHVPzlVF
 xQAdBjtz0zRdFgVvzBNf6m5hK8kfyId1AiAyJ66kXRRu9TNajjnKNROEaLEhe+T/SzP7H+Q5gh9
 IUBSpniMqMU6DQDIYq+ih9mUe8dHrjYqL1cypqWUjgOHDNcu4o7LSDrzQX9AKIc3v89KdgLbEKs
 3iC
X-Received: by 2002:a17:903:40cc:b0:2b2:9f9f:fe6b with SMTP id
 d9443c01a7336-2b29f9fff92mr117408235ad.40.1775600544497; 
 Tue, 07 Apr 2026 15:22:24 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b274979d5csm180412065ad.38.2026.04.07.15.22.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2026 15:22:24 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org, jim.macarthur@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v11 09/21] target/arm/tcg/op_helper.c: make compilation unit
 common
Date: Tue,  7 Apr 2026 15:21:56 -0700
Message-ID: <20260407222208.271838-10-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260407222208.271838-1-pierrick.bouvier@linaro.org>
References: <20260407222208.271838-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x636.google.com
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

Remove unused header accel/tcg/cpu-ldst.h that has target specifics.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/tcg/op_helper.c | 1 -
 target/arm/tcg/meson.build | 3 ++-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/tcg/op_helper.c b/target/arm/tcg/op_helper.c
index aa14f15eb62..75ad53ec6c6 100644
--- a/target/arm/tcg/op_helper.c
+++ b/target/arm/tcg/op_helper.c
@@ -23,7 +23,6 @@
 #include "helper.h"
 #include "internals.h"
 #include "cpu-features.h"
-#include "accel/tcg/cpu-ldst.h"
 #include "accel/tcg/probe.h"
 #include "cpregs.h"
 
diff --git a/target/arm/tcg/meson.build b/target/arm/tcg/meson.build
index 70beec7a6c9..1fa26670587 100644
--- a/target/arm/tcg/meson.build
+++ b/target/arm/tcg/meson.build
@@ -37,7 +37,6 @@ arm_ss.add(files(
   'translate.c',
   'm_helper.c',
   'mve_helper.c',
-  'op_helper.c',
 ))
 
 arm_ss.add(when: 'TARGET_AARCH64', if_true: files(
@@ -74,6 +73,7 @@ arm_common_system_ss.add(
   'debug.c',
   'hflags.c',
   'neon_helper.c',
+  'op_helper.c',
   'psci.c',
   'tlb_helper.c',
   'tlb-insns.c',
@@ -93,6 +93,7 @@ arm_user_ss.add(
   'debug.c',
   'hflags.c',
   'neon_helper.c',
+  'op_helper.c',
   'tlb_helper.c',
   'translate-m-nocp.c',
   'translate-mve.c',
-- 
2.47.3


