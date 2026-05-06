Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FC31FF8855
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 14:07:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKcuC-0006ti-6o; Wed, 06 May 2026 10:07:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKctd-000677-H1
 for qemu-devel@nongnu.org; Wed, 06 May 2026 10:06:41 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKctZ-0001oV-LY
 for qemu-devel@nongnu.org; Wed, 06 May 2026 10:06:39 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-48909558b3aso71359865e9.0
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 07:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778076395; x=1778681195; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Ox57tRe7cloUuWsftSDPkfC9DCnim7Tis7+4yAuGV2Y=;
 b=VPt2SVy57/BvWuOAQwXlhXSPEMd6dweLRZuFEFo3040mp2/NIJpJpFJDynqB5kqibb
 rAUrSTLUGvJ/CxlgklkAw0ruPZ40voVRRt7q7LCvb1QQY4ZIxtQkWhi43HzD3jL2aTUi
 RBEey6NCR/beZIbJ5cYPCa84wGFhOn+S0slMNLIung3LfgKk4An9UfZA0nE+CehQurED
 CtZTzY6Xr1ritxg4io01BlBN2Cj3WF6ZmD/thjoQm8lLLYYWYQVRvm1XNhe2oL3L7BGD
 7fXbMubTEZ6a24jZ3ZmtfgVDBKt1zTc2fEN+VzDcLA3BJ1HUfaxRyc8DlwtsIDxVtd4+
 ZtEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778076395; x=1778681195;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Ox57tRe7cloUuWsftSDPkfC9DCnim7Tis7+4yAuGV2Y=;
 b=nvlpaX68nZX5JsU89IhdBj9QduaELrxYjPmEN7NeH6coB8+jFujbGiBH7otSrSFOnZ
 09b4Pyn0rZGj3FSA8Qq5Rkxh2Vh3zucVlrUZt8pgndx+SjnOvfGzdgfLiXkKI7cfxyaK
 GnYMyPUV0WWyG1MIjuOMLttb5OcNe7vFM+ym3NnwSwekED980NwV1KAc8sq1lF5wAnmL
 1xq/jKFQuYUeWpbVyWyjsOHSLEcr9BWaUSXCCvykOgFifGhSYKCqBcYLFowdso4FbxbS
 9kbpgEeSIK5az88KmppisZdv+vp+7+G8Qplg6InFLGoqe+Chr5hwk8rEMH3rXIRHL++z
 9rMw==
X-Gm-Message-State: AOJu0YwU5g8al1zLadlyQe9DjI5AEs2UcW24NmeR/ZC/fU1Clv63uqeR
 PSOT4fZdjllCj5cKbSWPUKkRkE4pyz8Bj6X0aHTq8A7WEHoQf3S9GJ61RihqOytVmltO9P3X9kf
 8gNGelKg=
X-Gm-Gg: AeBDietZEaV6ttDOLY3Zd0TEPBEiIMq3sWMdf1kILCZpt2BYmAe8bw0e3otVgaFelv9
 ysNAifDSnVYgyekRdbBoMRA5D3GI4DrBKr0/Mrs50cYNvm+JcYXtc8HF3Oln18RWB84qnVdRuek
 Inx9oyHJmXCneD69GLnGDbcDO6Aqa2IdgaHZLP2zc6wcwdcYjx/REp008je7nlluBwk0vuuf0WV
 IJFSl3agijP9fhj6nAQaL9AKxEYAm5jcJx1ebT3v1p5tvQslgbGReXe4NwIFTYPCL2qZfqj+7AV
 ZBdrgklLraelAcjghWZxeSdzWJjzYfTmHEzvD9gyXgxDFZF2g/PQ6RP94kvnTWEYg9qULzwg3cA
 bIRUrxP2+ORsV98jRPfc0A3egM6EheQJqr9vyxzqmGenOjwVtbe1KcUFCtCzilu858cqEq3W8LO
 UltL0290nbK6f7Xn/RfH1K7qhDIEyLS2HRotfw4N9gNvfzzzMNuDSLSV21jBwHgYlxiYx6PtbtB
 gPgt6ZSJVg=
X-Received: by 2002:a05:6000:2dc6:b0:43d:740:fb37 with SMTP id
 ffacd0b85a97d-4515ce1c977mr6306917f8f.24.1778076394862; 
 Wed, 06 May 2026 07:06:34 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45054b02c5asm12749011f8f.19.2026.05.06.07.06.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 06 May 2026 07:06:33 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 085/110] target/microblaze: Compile op_helper.c as common unit
Date: Wed,  6 May 2026 15:54:57 +0200
Message-ID: <20260506135524.20617-86-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260506135524.20617-1-philmd@linaro.org>
References: <20260506135524.20617-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

In order do build op_helper.c as a common unit we simply
need to use the common version of "accel/tcg/cpu-ldst.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-Id: <20260423100612.27278-7-philmd@linaro.org>
---
 target/microblaze/op_helper.c | 2 +-
 target/microblaze/meson.build | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/microblaze/op_helper.c b/target/microblaze/op_helper.c
index 31da2c7c3ae..84c60c2636e 100644
--- a/target/microblaze/op_helper.c
+++ b/target/microblaze/op_helper.c
@@ -23,7 +23,7 @@
 #include "cpu.h"
 #include "exec/helper-proto.h"
 #include "qemu/host-utils.h"
-#include "accel/tcg/cpu-ldst.h"
+#include "accel/tcg/cpu-ldst-common.h"
 #include "fpu/softfloat.h"
 
 void helper_put(uint32_t id, uint32_t ctrl, uint32_t data)
diff --git a/target/microblaze/meson.build b/target/microblaze/meson.build
index 94c76de39bd..add3e6ca9f9 100644
--- a/target/microblaze/meson.build
+++ b/target/microblaze/meson.build
@@ -4,13 +4,13 @@ microblaze_common_ss = ss.source_set()
 microblaze_common_ss.add(files(
   'gdbstub.c',
   'helper.c',
+  'op_helper.c',
 ))
 
 microblaze_ss = ss.source_set()
 microblaze_ss.add(gen)
 microblaze_ss.add(files(
   'cpu.c',
-  'op_helper.c',
   'translate.c',
 ))
 
-- 
2.53.0


