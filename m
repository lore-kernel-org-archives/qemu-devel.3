Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9432DFF8855
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 14:00:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKcmW-0001uk-O8; Wed, 06 May 2026 09:59:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKcmT-0001py-R1
 for qemu-devel@nongnu.org; Wed, 06 May 2026 09:59:18 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKcmS-00009X-3e
 for qemu-devel@nongnu.org; Wed, 06 May 2026 09:59:17 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-488ad135063so61522825e9.0
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 06:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778075954; x=1778680754; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=em2bIFDKeutaom59G3vLD0YKyJW6+wSKDB4EoAo3nsM=;
 b=HUC+wMFgdHxGEGAn/iGmDRRmTLMIkYtynXWt+mvF5GZV7R9/cBW1uElR5Bf+A/TgHn
 tD/QokTEpoec8vSN2hpbabX93ZcModR5b7y9DLzLP6hUknjhAxCx1IcOJYWvpdYaHFWL
 cvWYO/7P3M0JkO6/7nHJzc+YX8q99QVxog7w4cbrzERW5vSv6fV1F63sy9DtaWgxiHAd
 0k8B40aUx6qWGKOdLde4nUxPuELwz0qIyeJfdRqoZKzkvYpYxHEf7mPnrhwz1jOsBSYK
 W+WmsAKDDGwjwZtOcpdwacZCLaEN78pVt7h/kOffyV+WozrJF7hsZE80Q8uWInGNM2Xw
 aDUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778075954; x=1778680754;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=em2bIFDKeutaom59G3vLD0YKyJW6+wSKDB4EoAo3nsM=;
 b=iyszz+HnR0RPMr8TW5demwsuOfnn/bInijuF+VJpuvYluuceLU8GD5fgBJHeGU3fqe
 P1EE6VVxAU75TvNQsPPBJnm39u1gPCAsb7jde4qIPJnFXDaYBH7nXwzRMiOwlAle6iwb
 YGj/U9qy217yunMwys0CjXaFN73L9AqGmQNyj9KAzqiQHTDA6knIapAem2aOfNM5yKHj
 k4qZC4u99BBTpudi0ieMO8bJeES2e+8PKgp5/M1+b80/4B5bcBPxKSO2sx3ZeWU8suRY
 QvwIhgl4QYqWuu1Y/+pAT21oR+FuP/Ox4ptWPE9OAVLa0cjcXz8ikzv095OwVl0s70m1
 sz5g==
X-Gm-Message-State: AOJu0Yw07K247APXocE86WBH/0CddN3ok8QeqZ9ZQVU89VZ/2hw6a0U5
 GnR6t0sWxyqSJzoh2b80wKMU77g+Wg3WUh1tfrFnMIe4ADXZl6kmgX5hrWgB0XEiK672lcBe+yu
 ZKrONBtQ=
X-Gm-Gg: AeBDieuL/zkIq0gUGTN/1K+BoxoXVSNdSTVxTji5VhvD/kCx6L76bDL61zPqj/vGS2M
 CLQ/fGfDCXfwJ7f1V8RfNOvG+23NgoCOoewl8EOAiYpIJFCALcmFQyRPYAOQeGWCiMIhJ7yklPp
 qDH3sDblRZ3pGVhCAJmz5js8kKBYNroSgMA7jY2dsjEo88CmODkBauNd/8JrzMZATMKTThazg81
 KLSyy/TOfxyFmu3JzWIFQ+HbXJntdRMx7iy2UV9J2O5LWObaHVMN0ZaL+ZRzTRsZ+cBms2ZU81i
 1rmDHy8nYoAK1ajiLwm2exmywClsvJZxcl2Ccj9Daco4GZiY5Zt+RySZ0M3LAo2Z/Bg/Ainsin0
 7657X/G8/R0Kpq/l7r0rQvlgiY1SD3DWI8oEA8rS8bb9A/2zNVaBWcG18YRz4vM1EopVcrqAb1e
 Cq0vxjrOg7jkNVOIQkEknva6KAIQ3C7W1tvQfV+hsZEJ9At3feC9gpAWWueDxgGl5uzmt3dg4Ar
 ecna5S+BTM=
X-Received: by 2002:a05:600c:a305:b0:48d:361:4df6 with SMTP id
 5b1f17b1804b1-48e51e19680mr43423165e9.9.1778075953592; 
 Wed, 06 May 2026 06:59:13 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45055f2203csm12912273f8f.37.2026.05.06.06.59.11
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 06 May 2026 06:59:11 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 030/110] migration: Remove unused target-specific macros
Date: Wed,  6 May 2026 15:54:02 +0200
Message-ID: <20260506135524.20617-31-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260506135524.20617-1-philmd@linaro.org>
References: <20260506135524.20617-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

Last use of VMSTATE_UINTTL_TEST() was removed in commit 445d3facffe
("ppc/spapr: remove deprecated machine pseries-2.7").

The following definitions were added in commit b6c4f71f508 ("Resurrect
the safe part of r5274") but never used:

 - qemu_put_sbetl qemu_put_sbe64
 - qemu_get_sbetl qemu_get_sbe64
 - qemu_put_sbetls qemu_put_sbe64s
 - qemu_get_sbetls qemu_get_sbe64s

Remove all as unused.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Peter Xu <peterx@redhat.com>
Message-Id: <20260325211728.89204-5-philmd@linaro.org>
---
 include/migration/cpu.h | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/include/migration/cpu.h b/include/migration/cpu.h
index e3d6c06b7d4..bb8ecfbeea5 100644
--- a/include/migration/cpu.h
+++ b/include/migration/cpu.h
@@ -12,10 +12,6 @@
 #define qemu_get_betl qemu_get_be64
 #define qemu_put_betls qemu_put_be64s
 #define qemu_get_betls qemu_get_be64s
-#define qemu_put_sbetl qemu_put_sbe64
-#define qemu_get_sbetl qemu_get_sbe64
-#define qemu_put_sbetls qemu_put_sbe64s
-#define qemu_get_sbetls qemu_get_sbe64s
 
 #define VMSTATE_UINTTL_V(_f, _s, _v)                                  \
     VMSTATE_UINT64_V(_f, _s, _v)
@@ -23,18 +19,12 @@
     VMSTATE_UINT64_ARRAY_V(_f, _s, _n, _v)
 #define VMSTATE_UINTTL_SUB_ARRAY(_f, _s, _start, _num)                \
     VMSTATE_UINT64_SUB_ARRAY(_f, _s, _start, _num)
-#define VMSTATE_UINTTL_TEST(_f, _s, _t)                               \
-    VMSTATE_UINT64_TEST(_f, _s, _t)
 #define vmstate_info_uinttl vmstate_info_uint64
 #else
 #define qemu_put_betl qemu_put_be32
 #define qemu_get_betl qemu_get_be32
 #define qemu_put_betls qemu_put_be32s
 #define qemu_get_betls qemu_get_be32s
-#define qemu_put_sbetl qemu_put_sbe32
-#define qemu_get_sbetl qemu_get_sbe32
-#define qemu_put_sbetls qemu_put_sbe32s
-#define qemu_get_sbetls qemu_get_sbe32s
 
 #define VMSTATE_UINTTL_V(_f, _s, _v)                                  \
     VMSTATE_UINT32_V(_f, _s, _v)
@@ -42,8 +32,6 @@
     VMSTATE_UINT32_ARRAY_V(_f, _s, _n, _v)
 #define VMSTATE_UINTTL_SUB_ARRAY(_f, _s, _start, _num)                \
     VMSTATE_UINT32_SUB_ARRAY(_f, _s, _start, _num)
-#define VMSTATE_UINTTL_TEST(_f, _s, _t)                               \
-    VMSTATE_UINT32_TEST(_f, _s, _t)
 #define vmstate_info_uinttl vmstate_info_uint32
 #endif
 
@@ -52,5 +40,4 @@
 #define VMSTATE_UINTTL_ARRAY(_f, _s, _n)                              \
     VMSTATE_UINTTL_ARRAY_V(_f, _s, _n, 0)
 
-
 #endif
-- 
2.53.0


