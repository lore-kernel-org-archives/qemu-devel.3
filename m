Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83B9ECD342C
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 14:08:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKcv0-0001bg-0E; Wed, 06 May 2026 10:08:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKcuw-0001Dx-Bs
 for qemu-devel@nongnu.org; Wed, 06 May 2026 10:08:02 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKcuu-00021M-JW
 for qemu-devel@nongnu.org; Wed, 06 May 2026 10:08:02 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-44985f4ab0fso3095667f8f.0
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 07:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778076478; x=1778681278; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=55Zg5+IU6prz/8Xfor+qrsuZFRdcVABRF35SF6CgGpQ=;
 b=wmlWrhonOsC09uP7/4aBLH6yuN/P4tkvu8QDmf9zNU6uQN4biTdblshk9AaWAGu29A
 3rVGeoIS53ksrPoStNXgLY/9FiucwRGFTSHpv/r7/WzI/denaA4lm5ZF9J542LRW0A9b
 sVA7/n+WBFhsdbWqhZunj8YEvBIH5H+KvSUb0WYm9qnCUouuYt6Xzd34fO/1yXIy5gPL
 YLwUMRJ38IuXgx290jfYxyjKYL9ckLexz2ARCm0fptfgy4R0uDquE+ryGOeioKXuuWid
 rhZPAa8ZIIKeb8fd+6wXQj46mXwQwhO1Im9bjnmCJKem8eEtgJ8sNwLyjEDmC1hOLBcv
 n1rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778076478; x=1778681278;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=55Zg5+IU6prz/8Xfor+qrsuZFRdcVABRF35SF6CgGpQ=;
 b=ZAmtHfp6FO6D2lp8UzY/NHFtwTYrb9eP0EluWaYEDieFGW5amOKNdF9+26NVWlLjsM
 lwIJC2hr5WFA2peqFCWmWQrvLCbpzCc07SW4w40VNFLJGNYX3G/xog3VJAgL33O3/3mK
 +yDsxMAymXKmCVP95Ik9tRO+3FDw3bCSceDgmEjOFTJNqBgYO4HdLabrocBV4ATrZ6HS
 78q8sokBJxyQ4zvudXBic3QJkE3xk4sY/knmnAzXWEIXhpFbAx406qhZjraeIPLPcwlb
 Mm09mfHUiAY68d7v2v7d06n0hYDsbRcPmuzVfHZ69zUVqF4lGKywzeWtXIfFP5DRnmbr
 jfLg==
X-Gm-Message-State: AOJu0Ywfgd1UPTWXY5u3rPZyt0Hn2V8BeGN7htOYTOhTqtBqbFi50Hkb
 yYmTFjYu4RV6jpwqWYS+xao6+uESWfL4kX3hLPLKVZeMomHn1leC12lwF8aZhgd0/4caLkbAPCH
 qVnQp1lY=
X-Gm-Gg: AeBDievJ3KLxmstCMD5cgAWI4y81G6et83MfQuDx0QLxRXH9rh4eAoeEYLcTBiFYyRY
 sxVRqhlCf5slrT5uBgdIisbiAJdfsEzmqb81eMQN752le/euadGfGMRgBS/wxdLT16l6URDR/m1
 q7dPLYJDlwtw1frQafgALCKvEvxwVxg3+O6nE0Vi1Khgrqt41zJOQ6DO6AAqMxXS2v/Y25NpZ+4
 C4NurvCeJP9SLxFRgoHkmg9JiZMy9dmcsrKK8NvqrVF4Z/AQzGqzGZJXC/lN3lZg6x6S0FZzXvQ
 VuFxNMrBv9tIMcHaMbj0PBSSHhuS6qoMKcSAgmj4nm2jPHztquQ/9kuXfKopWh7hZr70eSgzmRh
 ugtoc6ikhbTwvIhZ2s/D4ydWhWnowWwfzZ4R9FKjjwcW8ifJu2bCyfo1sKNpHvG7vrht4KhyHHi
 RwFHCEPtecxPoLT6ikve6hpeUVQKYZsW2cvEqxZr9Ana0nl/2ZGu07ygIK2CJq3OrDN4XfEGeFb
 +VgqCJh2Cc=
X-Received: by 2002:a05:6000:3107:b0:43d:2be:e54 with SMTP id
 ffacd0b85a97d-4515dc8095fmr5512169f8f.39.1778076477750; 
 Wed, 06 May 2026 07:07:57 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45055f2487dsm13043341f8f.35.2026.05.06.07.07.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 06 May 2026 07:07:56 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 095/110] target/s390x: Replace cpu_stb_data_ra -> cpu_stb_mmu
 in STFLE opcode
Date: Wed,  6 May 2026 15:55:07 +0200
Message-ID: <20260506135524.20617-96-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260506135524.20617-1-philmd@linaro.org>
References: <20260506135524.20617-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

In preparation of building misc_helper.c as a common unit, update
the cpu_ld/st_be_data_ra() API by cpu_ld/st_mmu() one and replace
"accel/tcg/cpu-ldst.h" by "accel/tcg/cpu-ldst-common.h".

For now we are blocked by the CONFIG_DEVICES use so keep the file
in s390x_ss[].

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
Message-Id: <20260423135035.50126-10-philmd@linaro.org>
---
 target/s390x/tcg/misc_helper.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/target/s390x/tcg/misc_helper.c b/target/s390x/tcg/misc_helper.c
index 1fd900fbbf0..3d13c8bd8ea 100644
--- a/target/s390x/tcg/misc_helper.c
+++ b/target/s390x/tcg/misc_helper.c
@@ -27,7 +27,8 @@
 #include "exec/helper-proto.h"
 #include "qemu/timer.h"
 #include "exec/cputlb.h"
-#include "accel/tcg/cpu-ldst.h"
+#include "accel/tcg/cpu-ldst-common.h"
+#include "accel/tcg/cpu-mmu-index.h"
 #include "exec/target_page.h"
 #include "qapi/error.h"
 #include "tcg_s390x.h"
@@ -710,6 +711,8 @@ void HELPER(stfl)(CPUS390XState *env)
 
 uint32_t HELPER(stfle)(CPUS390XState *env, uint64_t addr)
 {
+    const int mmu_idx = cpu_mmu_index(env_cpu(env), false);
+    const MemOpIdx oi = make_memop_idx(MO_8, mmu_idx);
     const uintptr_t ra = GETPC();
     const int count_bytes = ((env->regs[0] & 0xff) + 1) * 8;
     int max_bytes;
@@ -728,7 +731,7 @@ uint32_t HELPER(stfle)(CPUS390XState *env, uint64_t addr)
      * not store the words, and existing software depend on that.
      */
     for (i = 0; i < MIN(count_bytes, max_bytes); ++i) {
-        cpu_stb_data_ra(env, addr + i, stfl_bytes[i], ra);
+        cpu_stb_mmu(env, addr + i, stfl_bytes[i], oi, ra);
     }
 
     env->regs[0] = deposit64(env->regs[0], 0, 8, (max_bytes / 8) - 1);
-- 
2.53.0


