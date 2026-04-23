Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C334F589DA
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 13:52:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFuTk-0001V8-6I; Thu, 23 Apr 2026 09:52:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFuTK-00011A-4H
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 09:52:03 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFuTB-0006WU-Oh
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 09:52:00 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-43d7badbd7dso3317578f8f.2
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 06:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776952311; x=1777557111; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+oLfXPk2seH667v62QgQRAk1m1SjRVL6L/A4xaQoVdA=;
 b=P90UJ0Q/3jj9Re8AAbSHR72N83QG+spun5jH1BIA3Z0/qLTYq7tpeaDDFY9Oixc6qg
 Ws5lweFAnht+44VAKRfVVRNtMW3h6vSjsnGtBs2txb45P/btd1MLyTIhdfpUq8koZVqX
 N/N1PUQdwHvRjt2/baogVpQj/fJB0lw3inuyRvMa5aOMliuN3yH1fhsDXHmqTLK5Ir3R
 hgR1sYhs10fexsC4RbKXaZ0yoGQzKXoe7O15c2kA52YesxW/8/ivQWgqReEXGm/YKESg
 YhV8MyYLYQ9OZd+oBaJFf99pRCgjtEIS5hkAExZw6sfV3spZ0wAEoeQprzWKSCSUQtVd
 HHQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776952311; x=1777557111;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+oLfXPk2seH667v62QgQRAk1m1SjRVL6L/A4xaQoVdA=;
 b=IlxCtJaZH8dKKXgMlCc7Y5ne7tIS8Eq4VTjVhJ8Jb9kk+oO6vsDtHkTgfYb5CTsmdL
 madMJ5jAc4f38aAJBSQJ0D0G46YYYhWMmpc52c1QCUp47ZVpV0ugUOQrtDDuzM5oHy5u
 oTT8qzYBnOPSt+NXhJRTX70kbaY6MMR5KDIpWNoz4KVFj3KJRRpGm4OYq8iQ9mDH+YkZ
 ekJ415UCmPZKRrxmR6MmW8skN1zNOWeYno2lIWDZWqV9ZfozvtIxDDP3BAhax8PBLtqf
 UjLm8czUUlkq5Q/Cmo5cvn8B60gXBX8XeyBjCb2UUFBZIa5cPIetMZIjoJNjsipG+HlT
 zoOw==
X-Gm-Message-State: AOJu0YxrVhY85BZTsrTgzr3h27kV2TLqUJvGcLCZO3yOYDp3AicvolQr
 xqPfESAz7K/ShhDos/iz7enocrrRqFT4+VjwcEumXTtOK+YPcisEsRJUdWgSxDIiib2+qFZ9f5o
 RwcGQo3o=
X-Gm-Gg: AeBDiesjbWeTfdfK+daloMwm3uXslqc4xN+q/yRCPmmXWjVU4qbnC/zRD7HLkJQlV5I
 qqlAcnchTZxvKRr/Brr+JDiRgPLZCAPNooFB/1aybUdalAKQiQxeoFdsABUdwPxQXsidRa/3Hy3
 HZ7/JN51AvMeuZ6VNKrnhYpnB4kVuKtMj63rKylX+YrCDnWuf3WLi1vXoKXp1pLz/A8xIOUNf39
 FzlCtfiCb05MMyfTQ2aB0Wf0AQ6CjoKcP90riXH0D84gXpdbMgfmnjI+z1C9mtSa0aJ6wJ4Gpr+
 Cxd6Waz8fTzKLk3+u/XhrXB7BLrfTfIAvN1Ij19lXqH4yVBA6opHL/2HBz/1OfMkiXXza+SdZXU
 MF2zgRD5g8/3CtsoPrLcPfNT7nicSZIP3ObUC1WHq5FVr3/DKPIkZ4xR3mmow44fIMSolRJZSXR
 DCjSxc5q91xSeHRqS+UZdq26nlAsniAFNC6rZ4WL9lp0k62goKThiQG4CGLw4iXSoxNoIMD/t5B
 a0nuT1+nuI=
X-Received: by 2002:a05:6000:2303:b0:43d:75a2:44a1 with SMTP id
 ffacd0b85a97d-43fe3e1527bmr43642763f8f.47.1776952311439; 
 Thu, 23 Apr 2026 06:51:51 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e3a166sm52149649f8f.19.2026.04.23.06.51.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 23 Apr 2026 06:51:50 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, qemu-s390x@nongnu.org,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 David Hildenbrand <david@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 Eric Farman <farman@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 9/9] target/s390x: Replace cpu_stb_data_ra -> cpu_stb_mmu in
 STFLE opcode
Date: Thu, 23 Apr 2026 15:50:35 +0200
Message-ID: <20260423135035.50126-10-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260423135035.50126-1-philmd@linaro.org>
References: <20260423135035.50126-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


