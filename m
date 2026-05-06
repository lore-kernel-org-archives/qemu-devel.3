Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D3BCCD3440
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 14:00:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKcmk-0002tJ-KV; Wed, 06 May 2026 09:59:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKcmi-0002os-V8
 for qemu-devel@nongnu.org; Wed, 06 May 2026 09:59:32 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKcmh-0000Bc-Ar
 for qemu-devel@nongnu.org; Wed, 06 May 2026 09:59:32 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-488b0046078so57216395e9.1
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 06:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778075969; x=1778680769; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=yBKRutgN3yjojHntkFFZk++yw8Yg1fzT+jwbzOTAYOo=;
 b=bNAukAdvWEoruwEsA2EckT4jE0RMJI0oBr90zaVZi+Vi0WyXaq4+nPbqECBNT6yFw6
 Fy8DyOxcJi6Q/IvhLpj1qH3uQRHrS5Jv8wzd/blZLRpG0anYe1GhqqY3oOt8cP/6stu0
 AKDUZ1n6/4lWSrr96cjIlN9qPquAkTtALncaZPY908py+7Lvj6MKMnyZPluTZ21lS7Fd
 z/lMPQdcg3O0Y/kyqdAaWnDhhdX8HQ9MVdezUOKKbtOBDeUGl3T3GUHHUc1lfoIetblt
 Lxru48395XWYV9kx6a6Kl146ra2rOnWF0rh3lvzzxidTrSg6144vOHcZHlsjBZtV7g9/
 GXjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778075969; x=1778680769;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=yBKRutgN3yjojHntkFFZk++yw8Yg1fzT+jwbzOTAYOo=;
 b=bHl6AadtmdUI08KxhBHSBq4THUpw2132GuVQMSR+04D81UIzD70ueb/nJcqXVx4nxA
 HzY0fqEZd4A/2xgo0Uiv6XkbsdMR+mO46xHRfwLvGr51a/dhcjTnvNcGYY4+YQqUIcjR
 dlDmyC9zz+buas51ITSDgrxTvPC4U/U0YgBLmUQhdwKOgms5Qh53kKJz/wNEegIMgsKh
 qTyDikcr7f+Q+yON5hWCngAxfOL5XyrdydMkOdoRu65cqCjNbsaJYKaOlckO6oqVOVRc
 RTM5eCPlYt/tkh330W8gd2jopS5c4YMKZ5onxlf5B/yPeN73l2GfyOMa/ewzMjIVuEDI
 nCnQ==
X-Gm-Message-State: AOJu0Yy2UvHzVMLYfRkvN4KE5OcMeE3c3GTSly5Ht+t72sJUnvX2Ky1+
 Fmjii5RzMXxvKw5yjSUmjJAfqbZIe3auGcOALW4xXkMCdBUCIHsuz+lzZbisP02TLTHM7q2fNbM
 FygAdXsw=
X-Gm-Gg: AeBDieuHfWZ//2Z3vHwLiazgU3Wx8b47dzLT9D/n2lQsqCPNZNdEcafhnELADeIv3nm
 8y2PjQSot8Rw04C//KMg96kE3wAcP95WJQxPH5AYz/QwlpxMUlEC9DteNHdR8Qyt+tMQshkKDJ+
 57J0WPPr/qypwA2oGymDdq89SPRKv+xOaGmSHEGpKY1eSldaW6glo6j8K5YXIPLNUcUTSBwt1AR
 d8129dSf2s2GVucmRPL10t+e2t5sxIh4+ioYqpdog+DJAP8Lf4AicH/b73J2pD2OcfSykL5Enu7
 dXqqU7N5I+smcgcfyO3m7mbCM2neNdFC1D8p9oOP1gLvJhDERdyl5gJBS/2m9T3noDFhAr+LCaq
 ecD0mpnrmJGVBF+EYxJ4DO6qzBeR4Koy9YXJ4h6W6LSh3BbyDlm8sNptmMm7PZ8GS4K07vudHyE
 fZPKdLNNFv0nCAPp/5kQpXs4zDR0NF+gLiX/S1L38rTaW0NR2XVKSuH0OKYPiw+nTuIP4cRHUNk
 CIowYOOFKw=
X-Received: by 2002:a05:600c:c082:b0:485:3ec6:e634 with SMTP id
 5b1f17b1804b1-48e51f327fbmr43772345e9.15.1778075968560; 
 Wed, 06 May 2026 06:59:28 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e53141f41sm17381615e9.26.2026.05.06.06.59.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 06 May 2026 06:59:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 032/110] target/mips: Inline qemu_get/put_betls()
Date: Wed,  6 May 2026 15:54:04 +0200
Message-ID: <20260506135524.20617-33-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260506135524.20617-1-philmd@linaro.org>
References: <20260506135524.20617-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

Use TargetInfo target_long_bits() helper at runtime to migrate
the VPN register as 32 or 64-bits.

The "migration/qemu-file-types.h" isn't required anymore in
"migration/cpu.h", however it was missing in "ppc/machine.c".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <20260325211728.89204-7-philmd@linaro.org>
---
 include/migration/cpu.h      |  7 -------
 target/mips/system/machine.c | 14 ++++++++++++--
 target/ppc/machine.c         |  1 +
 3 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/include/migration/cpu.h b/include/migration/cpu.h
index 87ca977a3fd..8260ce0a3b7 100644
--- a/include/migration/cpu.h
+++ b/include/migration/cpu.h
@@ -4,13 +4,9 @@
 #define MIGRATION_CPU_H
 
 #include "exec/cpu-defs.h"
-#include "migration/qemu-file-types.h"
 #include "migration/vmstate.h"
 
 #if TARGET_LONG_BITS == 64
-#define qemu_put_betls qemu_put_be64s
-#define qemu_get_betls qemu_get_be64s
-
 #define VMSTATE_UINTTL_V(_f, _s, _v)                                  \
     VMSTATE_UINT64_V(_f, _s, _v)
 #define VMSTATE_UINTTL_ARRAY_V(_f, _s, _n, _v)                        \
@@ -19,9 +15,6 @@
     VMSTATE_UINT64_SUB_ARRAY(_f, _s, _start, _num)
 #define vmstate_info_uinttl vmstate_info_uint64
 #else
-#define qemu_put_betls qemu_put_be32s
-#define qemu_get_betls qemu_get_be32s
-
 #define VMSTATE_UINTTL_V(_f, _s, _v)                                  \
     VMSTATE_UINT32_V(_f, _s, _v)
 #define VMSTATE_UINTTL_ARRAY_V(_f, _s, _n, _v)                        \
diff --git a/target/mips/system/machine.c b/target/mips/system/machine.c
index 0a32665f835..5880b401b07 100644
--- a/target/mips/system/machine.c
+++ b/target/mips/system/machine.c
@@ -1,7 +1,9 @@
 #include "qemu/osdep.h"
+#include "qemu/target-info.h"
 #include "cpu.h"
 #include "internal.h"
 #include "migration/cpu.h"
+#include "migration/qemu-file-types.h"
 #include "fpu_helper.h"
 #include "qemu/timer.h"
 
@@ -140,7 +142,11 @@ static int get_tlb(QEMUFile *f, void *pv, size_t size,
     r4k_tlb_t *v = pv;
     uint16_t flags;
 
-    qemu_get_betls(f, &v->VPN);
+    if (target_long_bits() == 64) {
+        v->VPN = qemu_get_be64(f);
+    } else {
+        v->VPN = qemu_get_be32(f);
+    }
     qemu_get_be32s(f, &v->PageMask);
     qemu_get_be16s(f, &v->ASID);
     qemu_get_be32s(f, &v->MMID);
@@ -183,7 +189,11 @@ static int put_tlb(QEMUFile *f, void *pv, size_t size,
                       (v->D0 << 1) |
                       (v->D1 << 0));
 
-    qemu_put_betls(f, &v->VPN);
+    if (target_long_bits() == 64) {
+        qemu_put_be64(f, v->VPN);
+    } else {
+        qemu_put_be32(f, v->VPN);
+    }
     qemu_put_be32s(f, &v->PageMask);
     qemu_put_be16s(f, &asid);
     qemu_put_be32s(f, &mmid);
diff --git a/target/ppc/machine.c b/target/ppc/machine.c
index 9eae0ff647d..569536bd02d 100644
--- a/target/ppc/machine.c
+++ b/target/ppc/machine.c
@@ -5,6 +5,7 @@
 #include "helper_regs.h"
 #include "mmu-hash64.h"
 #include "migration/cpu.h"
+#include "migration/qemu-file-types.h"
 #include "qapi/error.h"
 #include "kvm_ppc.h"
 #include "power8-pmu.h"
-- 
2.53.0


