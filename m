Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30F02CD3442
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 14:09:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKcuX-00008x-PN; Wed, 06 May 2026 10:07:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKctp-00067p-6I
 for qemu-devel@nongnu.org; Wed, 06 May 2026 10:06:53 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKcti-0001pw-QV
 for qemu-devel@nongnu.org; Wed, 06 May 2026 10:06:48 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-488a88aeec9so72974305e9.2
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 07:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778076402; x=1778681202; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=oLdAnvA5IV4NNKrgMoyQHaW4IfTpZPSlRBtPBQoOFMA=;
 b=myzyLFncYZap+heo36756ZJGCihqfkoYMSYcNh4cJVbGFhZzcK0qJg9Tc9B7hGInsh
 qQojQ+GDufhnjsGspE4UXqORFnt2/l2c5N8oGM/y1ZokM7ENGsi9yeq1xwu9VL8h3a4c
 1PNDPCrsdMno7NNyu6BSoU4j7/lYd6z2S5BVrEUUL9XqGwVDg2Jo2Md5lFdnoC9gI1uv
 FnfszjqaIGqd5r95LUbrWX+MKb6CDtlHy58T3N49I9yrFGMtLA9PLpB8P9v4ya4o4lkR
 EmFfBA/oryZjV7CvQHmggd2Ucs9YG58+W3u2WW+5NTluziTPU7XzNgzLofbCzKm5mVIi
 VrDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778076402; x=1778681202;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=oLdAnvA5IV4NNKrgMoyQHaW4IfTpZPSlRBtPBQoOFMA=;
 b=U35gtxJ3xjTtTFkxNay7C2Dz3aniH711exPC3bmcnyGqnQg/ovUdHEvHxb1asMEFdZ
 Py07L86Pcf/oJct1otE3s/4WaAPP+zCJgFvfh3NhzlRxLAmYqKO1t4iU0hK9Z7q0gXJk
 bEnPLJAfLGozLzevbh0KznSZ1E0B8vxpHjphHvQP+Udtef56dKAvWffuvhZZpOMhMQut
 AuQWuZyUDEhzfuTFc624NRajrXVZASOZ1gmr1LxaHVKX7yj2EOa4xFnmP26KV6QLZ/VD
 rinyp4gYs70WcIdXa0erU7V+mBF1AxDsoBMtLJBK0WyKkm7sq3bkFpF4sxV2Zj+5yGCr
 qStg==
X-Gm-Message-State: AOJu0YzGKHWJcjseyJ1uKKSEtqd88/q31u7G1WoKdyabLyKEOCg3qRsu
 KFLV8T7jzcZQQos6BDmKhAlIwbcNKtNTUsQsd2jsuzKXDtpFkB8fiKz7wPFPXRzinUJlygrwIAo
 aaD3vmC4=
X-Gm-Gg: AeBDietTCykehTKeQ/pTdM0UrbSDCRj8QNtqvXiIPScxmXRGe5vpY3gKwMgEj6gaN9I
 YKm/rtq3nfWUYiFA5ZimKJGWDipjOetoJEKE221NDhpJd/rfSO9AjG5v+2KtWj9A6jtLBBtGRrw
 GFsFn0AZAKyTQQ48reNunLKYYI1/X7XubZxGSNVR4b8l2zi1h+DyadD9QWrSIttusK6rg5ppHnv
 tiKi7wiLi2eg5jUSB3ZEbsG/YqjpDN/dl8H9jd/1RdiX/RS7tYQbGbZNDiUK0kccf9ektfZrcln
 FZq5qIHNWH1IZvJTLQKzWSMpJ0l7Jrrg2DRUmFYiV20tZmCjaI0epHpWHkOazosq/hpp5Kt+I6v
 QptgBBbhvE8Y0ejh5rlkq3wUQvyiSilGU+ZeWgzG6iKtDdaqVcpDn7tsDITrXmb7S2a/dAhkSxH
 gG9t/Vk56t/fRoV+HMPUvOgdn8VhCOX4q5sGJf0VB6TaAJ39cAzsrLXFgDQbRh84aNnzRIuT9H4
 3tBCXWFCT0=
X-Received: by 2002:a05:600c:871b:b0:483:709e:f238 with SMTP id
 5b1f17b1804b1-48e51f4652fmr65261695e9.29.1778076402189; 
 Wed, 06 May 2026 07:06:42 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e538fb19csm47192005e9.11.2026.05.06.07.06.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 06 May 2026 07:06:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 086/110] target/microblaze: Compile cpu.c as common unit
Date: Wed,  6 May 2026 15:54:58 +0200
Message-ID: <20260506135524.20617-87-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260506135524.20617-1-philmd@linaro.org>
References: <20260506135524.20617-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

In order do build cpu.c as a common unit we simply need
to use the common version of "accel/tcg/cpu-ldst.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-Id: <20260423100612.27278-8-philmd@linaro.org>
---
 target/microblaze/cpu.c       | 2 +-
 target/microblaze/meson.build | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index 639f46b525e..04d31536888 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -27,7 +27,7 @@
 #include "cpu.h"
 #include "qemu/module.h"
 #include "hw/core/qdev-properties.h"
-#include "accel/tcg/cpu-ldst.h"
+#include "accel/tcg/cpu-ldst-common.h"
 #include "exec/gdbstub.h"
 #include "exec/translation-block.h"
 #include "fpu/softfloat-helpers.h"
diff --git a/target/microblaze/meson.build b/target/microblaze/meson.build
index add3e6ca9f9..2ce50f35397 100644
--- a/target/microblaze/meson.build
+++ b/target/microblaze/meson.build
@@ -2,6 +2,7 @@ gen = decodetree.process('insns.decode')
 
 microblaze_common_ss = ss.source_set()
 microblaze_common_ss.add(files(
+  'cpu.c',
   'gdbstub.c',
   'helper.c',
   'op_helper.c',
@@ -10,7 +11,6 @@ microblaze_common_ss.add(files(
 microblaze_ss = ss.source_set()
 microblaze_ss.add(gen)
 microblaze_ss.add(files(
-  'cpu.c',
   'translate.c',
 ))
 
-- 
2.53.0


