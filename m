Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45426FF885E
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 12:50:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHLQ3-0001RP-3r; Mon, 27 Apr 2026 08:50:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHLNj-00083h-0g
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 08:48:16 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHLNZ-0005e5-Tk
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 08:48:05 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-488af96f6b2so134254175e9.0
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 05:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777294078; x=1777898878; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=0V9tqvJQMF5c3moywi8PIdJIdKM/gu4gtuRVdkg4evc=;
 b=EpPciJ+QjywMtEuZZpkK66OB1rXe4MHC2YNXQlqH9wKyMf8pOJ7PPZu3eAt+pIPU+2
 gNtQqaxxMwGG7yogqT5Os9Oj/484Nsvd1D7rxEb12KVIVtSzhlKPtFaBl/80tGtb1Gxl
 9yS7MUdYlG5N0iW/H62Q9INBBX8D24SAnKoELdghnR+kPgGcvr0CAy2+SLq2n2a3B/CV
 3+sKSbFu+cegAAabqW3kvpIy6UV/Q663Jb02+y8gAmT3/8xKSdf187ABgwhCIz0XtR2g
 rj6fh8Bpcl8zrLxUpNhuBjf2cg2LHx/lrQaA2xo/d231OT9Akbvlz6gbFNrK8tURnXu0
 3kHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777294078; x=1777898878;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=0V9tqvJQMF5c3moywi8PIdJIdKM/gu4gtuRVdkg4evc=;
 b=ZfjpnEzVCs/G1lb4Qszqg1e1SdKKYXc/S25jr9Zr1lMYjmbglan0B9pOqTfZDz9xYX
 3hSIobYt7eGtcIyVwkwgqEIYK9uQhil7N25popTMsigGbLzxMC4pdBs3uaozgDNvEHU7
 xTvi23FbhtdElKPUUB8NXl43Q1Fwjs2VaseJVrjJbQYK8ZWL4wANs5exNVhnudsbW9+2
 mrtLB9MzqcRD2GZxtVR8MVNdLEw4VnrnAPiUORYcLqyrCvhHbZ6xSV2KiPW4g9B4Gciv
 M033VKhLpicGRZz55GMShbZdQwbT/5ypeTcNcJwVABu9h6eSDcxbq/ez07IpkGI14G31
 v6qA==
X-Gm-Message-State: AOJu0Yzr8nlPMVJwI+7ZX77MmRfZIiWLxhwLvDUF07xo72EoqkomPcf5
 TCxTeYJELW7mocg/E27RBJY1BiCfw4z6GOJgJP58B6hehw9RM0Nh+K9enacxCMz6gzaX+iz/pCP
 s70Sc
X-Gm-Gg: AeBDievZWZxt8lgWElHO7lJE2IZxyA7m4rckQJUl5m5vu/eJllNAOfSgz3jFIQHiRlh
 rkbhd+fqyIUhQBaJay5WyvD8ikLmh5GjmOlDNThzTVUmC9KxY+3vRm+eFgGO1jQNzUNV9tPisng
 HBHmbNrwa6C5SbkHmygtHWevhWIUXTICj6CFnjr4HzrLhLn+zTMNmOYXi+gK6QI05r/3tinU0ER
 Nypzvc430dzAPb/SydwcZ3CU4vuHq5TSgdKGf9QTxKulsQxFgPiJG8+yFBrlqX2z5vrXvuAaSoU
 dQi25KRHdlDaFfwZMNiu3q/Gw9bAaAFhcswX7+3hqcuj7VWFHJxVXMIK8u8drwZJyb1XGfyMLlP
 MScXzRmIloTv40v3uKQrLehxk3MaKp1qbcVkyzt2h0hWK8o//KkT5GJTOaGmQiqgSzwKC8nnLqV
 5izDHidEgQrxc0jPpF8Hsm5fWy9obwpFMo5GPJ6PQ0Tmkv7qhImHSoIUyEZ4dzMwf1BOUgJnPTM
 /ZUk+A1v8W3RStWDby88vC49q9/wrKVmvB2Wf6G+Q==
X-Received: by 2002:a05:600c:a086:b0:48a:568f:ae82 with SMTP id
 5b1f17b1804b1-48a568fb009mr376914665e9.10.1777294077767; 
 Mon, 27 Apr 2026 05:47:57 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488ffc5e3f4sm448974115e9.2.2026.04.27.05.47.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 05:47:57 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 21/63] target/arm: Introduce mo_endian() helper
Date: Mon, 27 Apr 2026 13:46:55 +0100
Message-ID: <20260427124738.966578-22-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260427124738.966578-1-peter.maydell@linaro.org>
References: <20260427124738.966578-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260414005348.4767-6-philmd@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/internals.h      | 6 ++++++
 target/arm/tcg/mve_helper.c | 3 ++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index af5e9a1acf..06655409e5 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -28,6 +28,7 @@
 #include "exec/hwaddr.h"
 #include "exec/vaddr.h"
 #include "exec/breakpoint.h"
+#include "exec/memop.h"
 #include "accel/tcg/tb-cpu-state.h"
 #include "hw/core/registerfields.h"
 #include "tcg/tcg-gvec-desc.h"
@@ -46,6 +47,11 @@
 #define BANK_HYP    6
 #define BANK_MON    7
 
+static inline MemOp mo_endian(CPUARMState *env)
+{
+    return EX_TBFLAG_ANY(env->hflags, BE_DATA) ? MO_BE : MO_LE;
+}
+
 static inline int arm_env_mmu_index(CPUARMState *env)
 {
     return EX_TBFLAG_ANY(env->hflags, MMUIDX);
diff --git a/target/arm/tcg/mve_helper.c b/target/arm/tcg/mve_helper.c
index 4bea0991de..a5a23c9705 100644
--- a/target/arm/tcg/mve_helper.c
+++ b/target/arm/tcg/mve_helper.c
@@ -299,7 +299,8 @@ DO_VSTR(vstrh_w, MO_UW, 2, stw, 4, int32_t)
         unsigned e;                                                     \
         uint32_t addr;                                                  \
         int mmu_idx = arm_to_core_mmu_idx(arm_mmu_idx(env));            \
-        MemOpIdx oi = make_memop_idx(MO_TE | MO_UL | MO_ALIGN, mmu_idx);\
+        MemOpIdx oi = make_memop_idx(mo_endian(env) | MO_UL | MO_ALIGN, \
+                                     mmu_idx);                          \
         for (e = 0; e < 16 / 4; e++, mask >>= 4, eci_mask >>= 4) {      \
             if (!(eci_mask & 1)) {                                      \
                 continue;                                               \
-- 
2.43.0


