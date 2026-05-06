Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9531CD3443
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 14:09:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKcuY-0000BJ-3V; Wed, 06 May 2026 10:07:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKcu5-0006Aq-Py
 for qemu-devel@nongnu.org; Wed, 06 May 2026 10:07:10 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKcu2-0001s6-4i
 for qemu-devel@nongnu.org; Wed, 06 May 2026 10:07:07 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-488e1a8ac40so63789985e9.2
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 07:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778076422; x=1778681222; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=He5fI3HAK0zWkP0HykCz3DzGEmI9iL9vOVxmp5oEXGk=;
 b=x6Mbx5n3gsxh2Nkt5GpPPmQBLaTYN7F5VOkcCJmDka9JLNC9ZKe8yvao251hZ04jGR
 UKPrO2y3DoHyyOfiCq8IhCqxqL6djwRCbfGJ08FRMd0MijXPfTjSpVNYVt8np8iLloZE
 uVTfH//V6oSkzyhVK+G3WemRIgYFpj7fP99f4ulkLA9ntr8PY9ZYaYJJuVla/VpH0yOp
 ESUQyMoGBpiRu16yEp0e0XLAOq/J9Mh/6hf5O3fGSekfs58jnLAcWbPizrs2pT67Qfxp
 OhXw0zke5mUO/QBjQsOPzVSupPOROHfdw6OqXzc8dDKY+JUZskEVNhQ8jTZoRZXaUas6
 l9vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778076422; x=1778681222;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=He5fI3HAK0zWkP0HykCz3DzGEmI9iL9vOVxmp5oEXGk=;
 b=RqXJsLs7hOaOjbwWbPcnooxtuhUL7zjpJsBZnzc2tc3uMS1Fux6Er/rwp/WcCQcCAP
 1Ed/MsjEv/+1KuDfV8Pxio6mnQF7HkU0hKtvOtvpmk3V+7K8iTxZuam2YIdNaqYcUFjf
 z+E5yU+Bq3d0T6o6tRQl1sg5gvTNjeJE+YlsYju9vfkr9DhhTRiRGB5hJw91vHnjFjoN
 qAwwk2jjdoTERKcxtvltCCPpKvuGhGaN221cAhcg787Y0k8l1cjCzqhCvglfvvlOKhCn
 q1iFPJTN5xJkRX0rM9JLPACipqQXYZbDtZlWzZaXCL/3uWUNxJJ9GNFd4XKpHg8Swg8/
 VapQ==
X-Gm-Message-State: AOJu0YyK9Af7Z9WuyfD+lb7f80E5Huf1rlAGvWJILTBtg0jf1F/pCb0D
 AXTd9bSTzjbHHLtmSwsIav4vWz4SGlAYAtvxT3gi+Bp7YKB7EJ+mdRHYbR2YSr4UJW/Eh/jRWqS
 0138Mw20=
X-Gm-Gg: AeBDiesVprTmgMP/EWRXsbW8vIAHg6iRm4YMqLt6Y/wWYtMHVlCGvHcwU1YYbPwXSgT
 iYOBFLtf6KolGF0xwGEPeGco5FcWk96VmanXrz79+jpDiZfcEEZ+s75mJ/+O98H5PbUaY8LLdg9
 6rW6dMlfWg+lbYtqcEKc2Fy9+JvV5N/Ah0zH0kCVUAqUvlJkH5zbuxtfI1MvIK469joFA5IP5jr
 W32eZJT6U57Pu0gUcoy1D/W/IjBhoTCEm43RA9QqtCO5I3N9aLU+VLurp9o1cvzg7epmsA4wuBY
 HmTZuJBpd8/74wK6kZbsG60j1fWGW8PyYAtAUnNarU+4RWcPJEOow4KUuXnWp9YAlSSG1s4R6b6
 0sS0xNFrcsHHT9Xr6pCBk+WcMpXiKueiiB9qpY1lEy72rlkisKENL202j/tUa4Bln8wfhtLrhsS
 KbIYIZoZwKOTol8tU3uPJ2EHPkJ6AZ8aYn/hzEC2Hs5nabtARMsaia/rJen4Ttv245IwMMmRtOl
 WWaEj4xk7o=
X-Received: by 2002:a05:600c:3b96:b0:48a:66a8:9981 with SMTP id
 5b1f17b1804b1-48e51f55272mr67269415e9.27.1778076421907; 
 Wed, 06 May 2026 07:07:01 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e53891d62sm83626985e9.1.2026.05.06.07.07.00
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 06 May 2026 07:07:00 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 088/110] target/microblaze: Compile translate.c as common unit
Date: Wed,  6 May 2026 15:55:00 +0200
Message-ID: <20260506135524.20617-89-philmd@linaro.org>
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

In order do build translate.c as a common unit we need to
replace:

  "accel/tcg/cpu-ldst.h" -> "accel/tcg/cpu-ldst-common.h"

and:

  #include "tcg/tcg-op.h" -> #include "tcg/tcg-op-common.h"
                          -> #include "tcg/tcg-op-mem.h"

taking care to define TCG_ADDRESS_BITS, which is fixed
for these 32-bit targets.

Remove the now empty microblaze_ss[] source set.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-Id: <20260423100612.27278-10-philmd@linaro.org>
---
 target/microblaze/translate.c | 6 ++++--
 target/microblaze/meson.build | 7 +------
 2 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index bf8f864c324..74b5420ed24 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -20,9 +20,11 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "accel/tcg/cpu-ldst.h"
+#include "accel/tcg/cpu-ldst-common.h"
 #include "accel/tcg/cpu-mmu-index.h"
-#include "tcg/tcg-op.h"
+#define TCG_ADDRESS_BITS 32
+#include "tcg/tcg-op-common.h"
+#include "tcg/tcg-op-mem.h"
 #include "exec/helper-proto.h"
 #include "exec/helper-gen.h"
 #include "exec/translator.h"
diff --git a/target/microblaze/meson.build b/target/microblaze/meson.build
index 2ce50f35397..9c1ecd1cf1c 100644
--- a/target/microblaze/meson.build
+++ b/target/microblaze/meson.build
@@ -1,16 +1,12 @@
 gen = decodetree.process('insns.decode')
 
 microblaze_common_ss = ss.source_set()
+microblaze_common_ss.add(gen)
 microblaze_common_ss.add(files(
   'cpu.c',
   'gdbstub.c',
   'helper.c',
   'op_helper.c',
-))
-
-microblaze_ss = ss.source_set()
-microblaze_ss.add(gen)
-microblaze_ss.add(files(
   'translate.c',
 ))
 
@@ -26,7 +22,6 @@ microblaze_system_ss.add(files(
   'machine.c',
 ))
 
-target_arch += {'microblaze': microblaze_ss}
 target_user_arch += {'microblaze': microblaze_user_ss}
 target_system_arch += {'microblaze': microblaze_system_ss}
 target_common_system_arch += {'microblaze': microblaze_common_system_ss}
-- 
2.53.0


