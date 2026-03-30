Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C6471061B03
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 14:32:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7DeW-00015P-3l; Mon, 30 Mar 2026 10:31:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w7DeO-00014x-TV
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 10:31:33 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w7DeK-0002d6-Ac
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 10:31:30 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-486fda2a389so37033205e9.1
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2026 07:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774881087; x=1775485887; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FPfexUg//huq83MvV9fAvc/hO7xuXpj/vqxDNr67Au8=;
 b=X1+l1hPiC5RKz6MBxFBtoSHQzz2SnaZHslNO2ZVrV5RoBDLUKBMZxzTyTyexFi/cfs
 MBHo5Wmu683OH22SW0YwqdVG/1t3s4tLGw++MktrIcl52HhRApDoy34+a2M/8SPiri7y
 kPrv134oqhBmk5D9zOKbYefzEN3imGpolx+eCS9eNLoaQQdiDDM8K6p4MttF0dRZ8Efy
 t1WnJS0Gdd5wNgAb8WasTi45sFxW/20KE3gDADYofBosyIJHQsCro6JYJtopGOLLX75l
 9TV0VUtaFnk9gwWCbm95UB2hN1QOoE3RxHaEudG1BLZsJ1G9KtOdWfn7XPm9Y8eLDIzH
 bDiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774881087; x=1775485887;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FPfexUg//huq83MvV9fAvc/hO7xuXpj/vqxDNr67Au8=;
 b=YSHLQGs+xOnCAAxOSCbOVYEJTmK/53Wwujl09qiAvEtNyRCWnxTUB8dKXy9FnGHrqj
 0wBUReq93VHHBUPf140fozdCn3EikkJq2LKfppghZc3ol8gDXk8aokDa5J2sLHsnhdgI
 zUplQ1itblRQeMU2AlBxYWCWm5ZwlEkNNzDCA2Kh2jqbiGKspPusl+grH2kojdYHNh4A
 9VX23kwNRT75b84mfTe5IZcsqDkLr812+iYIEWv6t82bJuqts6bhhGhWmH6Al+3zxQcX
 NTjTOy88ob1xbcDG2mkWMTBWDeWItSTP8YikBO+0NaZFTIxrqJvyDPZvyEo7cxw8ya5q
 FRXw==
X-Gm-Message-State: AOJu0YzO3YoQkKvtf3TdrlcDzRAop4gygM9wYeXy/aB/Mt72IJaieGgI
 GhXWWNNC/sNZvxE4IVFE88uKm7VhUnhmsh2/WW+jqGn337jSTRArzwg4bRceimFQo4DdW3dVqEK
 0G7ezvoA=
X-Gm-Gg: ATEYQzzke5zUa5cDr4uPs3H8jHSoJzPx5qsw724ocQNlsCqYbIB+Ket7jjV280sdcE6
 dldCSXa7SYMULGaX34y3l0lvmx6GDPcgczH/0u6iICeeH69TBA5rXX53XQ0963A7XX7JQXOjSb7
 scQSMu0MRpOKAFoBPAnxxo4bb6VeX6kji3LYz8cRLSPp7J+CtbR11W3nvd0IPLodBdSe9XbWAex
 BmI7s1ZN04Z+EoohLmsD3yC28kyrljBRyK8mH63C/JdOnTzIRVjpEAAAjhlXhchs+6QXq10LUUI
 pI0YzL7z3101aNA5Bd7yZX39Q8rX6k0dJ0kF6x9QmfnJ7vY+TtorHk/x82IpSdxm56RvhD//cRX
 HtGjyc/qqv18WcUcBeMbf+6pT42l5d2KEUWRiqjU+k3HbTMT9DNuz5kgGx8786wqNwGMprurF0R
 KakPStG0HPkmr+6/Hz8X73lb7L9iffcmxoqnoBBiXrlS9/sT9T53fGCjtJR5BIjUPnXCxNBSFh8
 7VRy+htOR/plJ3+KxuFSkASPRBBMEhFhXO334PA3A==
X-Received: by 2002:a05:600c:4e15:b0:485:2ce2:4c8a with SMTP id
 5b1f17b1804b1-48727d67a21mr203850625e9.1.1774881086527; 
 Mon, 30 Mar 2026 07:31:26 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48722d49c18sm279767145e9.14.2026.03.30.07.31.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2026 07:31:25 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 1/2] include: Don't include guest-host.h in cpu-ldst.h
Date: Mon, 30 Mar 2026 15:31:22 +0100
Message-ID: <20260330143123.1685142-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260330143123.1685142-1-peter.maydell@linaro.org>
References: <20260330143123.1685142-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
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

We currently include user/guest-host.h from accel/tcg/cpu-ldst.h.
However that file doesn't need anything from guest-host.h, since we
removed the uses of g2h() in commit 9b74d403b30e ("accel/tcg: Move
user-only tlb_vaddr_to_host out of line").

Move the include of guest-host.h to where it's actually needed.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
This isn't needed for the following bugfix patch, but it made
it a bit easier for me to understand where we're actually using
the functions.
---
 bsd-user/qemu.h              | 1 +
 include/accel/tcg/cpu-ldst.h | 4 ----
 linux-user/qemu.h            | 1 +
 3 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/bsd-user/qemu.h b/bsd-user/qemu.h
index 2c586e546f..b0b2c249fb 100644
--- a/bsd-user/qemu.h
+++ b/bsd-user/qemu.h
@@ -27,6 +27,7 @@
 #include "user/abitypes.h"
 #include "user/cpu_loop.h"
 #include "user/page-protection.h"
+#include "user/guest-host.h"
 
 extern char **environ;
 
diff --git a/include/accel/tcg/cpu-ldst.h b/include/accel/tcg/cpu-ldst.h
index a5711bc15a..ea2cbf40fe 100644
--- a/include/accel/tcg/cpu-ldst.h
+++ b/include/accel/tcg/cpu-ldst.h
@@ -71,10 +71,6 @@
 #include "accel/tcg/cpu-mmu-index.h"
 #include "exec/abi_ptr.h"
 
-#if defined(CONFIG_USER_ONLY)
-#include "user/guest-host.h"
-#endif /* CONFIG_USER_ONLY */
-
 static inline uint32_t
 cpu_ldub_mmuidx_ra(CPUArchState *env, abi_ptr addr, int mmu_idx, uintptr_t ra)
 {
diff --git a/linux-user/qemu.h b/linux-user/qemu.h
index 85e68eff7b..cfe5f45fc4 100644
--- a/linux-user/qemu.h
+++ b/linux-user/qemu.h
@@ -10,6 +10,7 @@
 #include "syscall_defs.h"
 #include "target_syscall.h"
 #include "accel/tcg/vcpu-state.h"
+#include "user/guest-host.h"
 
 /*
  * This is the size of the host kernel's sigset_t, needed where we make
-- 
2.43.0


