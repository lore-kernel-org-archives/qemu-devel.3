Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E582FA1FEC
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 20:00:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFdkc-0007YA-Dx; Wed, 22 Apr 2026 16:00:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFdkY-00078O-8V
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 16:00:42 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFdkW-000220-Br
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 16:00:41 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-43cfde3c3f3so6043485f8f.3
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 13:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776888038; x=1777492838; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=C0apGIz1BwsAJXSXLn4sYhDjCgYgxotRdF6SHq/q5LM=;
 b=Rl0rpdetDc9SNcjJThYnSKt8JMjiN+VxIxUTDLrZn9BrYe3O5NmVV3HRtyH6YI17b0
 Mjmu1/w3sXziZRwvFzNZJiBsUwtGSRCv+L16PBe+6+yldtrn76DQU2Rq4FmIUIuEtrG7
 kkjh//2/SlGzP+HWQc1F3FhkB6V5VW4vrRqchimYeEgUR9q135rLvAG5khzQImYwSLLY
 UJuRgOLOUO+U1ir5nFSgKqsgidkw87YFetiiRkIhEwn+1ZG27UYhjWMCadhbGaq6CFMb
 xMCSKaJb1913dgXpKK4TDvDUW350hkJ2shLO+10AaMGfmkuShBOHe+0FVT64BH0csWRS
 of2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776888038; x=1777492838;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=C0apGIz1BwsAJXSXLn4sYhDjCgYgxotRdF6SHq/q5LM=;
 b=HdrzJxbroTTCDcXHpVJLjuddD6dp+KhvrlLa7Ua+CYubEZm+gpKGxJK5SZ0aqs/MsV
 1OajTcTlgPxvA37BZjDVn+l6PZ+b1hZWDe6yyo9xD2KAt6Dj27pZJ8mFHBHJVvhcgMe0
 JyLJTXkG93b1v/wEvDUJ4+/Nw6o5gZQXfEL/KPMxy9Chp3HQIQULsDXKWq9x7h0Pu/tG
 ZjjdkOeWx0SFCZIoThBbCD7Ua3lNZ04ALvO8CEgcnLfvmAoLUo/F2QZsdPtwwtEEQvhi
 KAg6UUAmoNOGbS0CXRx18uCqFdBa7xe0vMIqqDRuB1VbemuNcdbFta/xBabt+GO3bMMZ
 kNkA==
X-Gm-Message-State: AOJu0Yz7UwZ+Akn6XL01VP5vl3/SoguDbX+ybsT0blIGuA9e5eHXx3He
 BUknhEPqKMeM51bS649APxgWsBFJxgLP5914VKsAfnVh8DHgc9LpRWnRSrFKQknhwDibptFT/QF
 RcT2cqtc=
X-Gm-Gg: AeBDiet9Rn4GvH63vTqzGXMeEiBqdmJ9gv9g2R/s8vlrCUv7Yy2NaCQ3M0yz/Nv0Vtk
 WDMbK4bcrRmmQYO1Ga1s3YoxiALBspVD2PIvdP5iqv7hflSQzKd9TE355WKM1kdlfTD0Q9usfDb
 B0XTT9YCjDlCaHLY+3xmp+XqxieKWcbdXflIoGdGGaSvJNUcOcUc+8FNAiKipVJuDyDoCtklXlw
 jR6OawFnSifcfEixSHfYUbL8bY2dJRkpdlrZ+vW4ESYGMOrQYyl3pN1kaXZPMEAVlE5wGgPvRUv
 Imtf/LNW9LkKBwx+ZiWhAFDGzJDF1HdRNLZr98NCkqBRwOgHVl0C0eVqTWlS0XK+vP37yoaDZFP
 I8xuxbCTE2qBMcz3HlmbRKWVboAEU46yxwwBNgF9OX8IJ8z6MtoOdtOCaIEZ4TJAfSu6FJQoiO1
 e4zRpO4PE2DP4niBcdFuRjdUSEbLRykoYxWdoHBsw/sPl0hX8W8VcE5OpGAsCE5Wv/0Ps6qI8BL
 qiB+g6FozM=
X-Received: by 2002:a05:6000:1889:b0:43d:7b7b:ab76 with SMTP id
 ffacd0b85a97d-43fe3dc54ddmr36976152f8f.10.1776888038039; 
 Wed, 22 Apr 2026 13:00:38 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e4d5b1sm51645351f8f.30.2026.04.22.13.00.36
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 22 Apr 2026 13:00:36 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 24/48] hw/ppc/spapr: Un-inline rtas_load/store() helpers
Date: Wed, 22 Apr 2026 21:57:22 +0200
Message-ID: <20260422195746.88865-25-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260422195746.88865-1-philmd@linaro.org>
References: <20260422195746.88865-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

The 32-bit binary doesn't use these helpers, so don't need to
compile them. Rather than using 64-bit target #ifdef'ry in a
global header, un-inline the calls since the helpers are called
from I/O (cold) path.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Reviewed-by: Chinmay Rath <rathc@linux.ibm.com>
Acked-by: Glenn Miles <milesg@linux.ibm.com>
Message-Id: <20260319111936.68041-2-philmd@linaro.org>
---
 include/hw/ppc/spapr.h | 18 +++---------------
 hw/ppc/spapr_rtas.c    | 15 +++++++++++++++
 2 files changed, 18 insertions(+), 15 deletions(-)

diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index b022f8dd25d..9acda15d4f6 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -796,21 +796,9 @@ static inline uint64_t ppc64_phys_to_real(uint64_t addr)
     return addr & ~0xF000000000000000ULL;
 }
 
-static inline uint32_t rtas_ld(target_ulong phys, int n)
-{
-    return ldl_be_phys(&address_space_memory,
-                       ppc64_phys_to_real(phys + 4 * n));
-}
-
-static inline uint64_t rtas_ldq(target_ulong phys, int n)
-{
-    return (uint64_t)rtas_ld(phys, n) << 32 | rtas_ld(phys, n + 1);
-}
-
-static inline void rtas_st(target_ulong phys, int n, uint32_t val)
-{
-    stl_be_phys(&address_space_memory, ppc64_phys_to_real(phys + 4 * n), val);
-}
+uint32_t rtas_ld(target_ulong phys, int n);
+uint64_t rtas_ldq(target_ulong phys, int n);
+void rtas_st(target_ulong phys, int n, uint32_t val);
 
 typedef void (*spapr_rtas_fn)(PowerPCCPU *cpu, SpaprMachineState *sm,
                               uint32_t token,
diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
index cb79ad34053..0871425237e 100644
--- a/hw/ppc/spapr_rtas.c
+++ b/hw/ppc/spapr_rtas.c
@@ -52,6 +52,21 @@
 #include "migration/blocker.h"
 #include "helper_regs.h"
 
+uint32_t rtas_ld(target_ulong phys, int n)
+{
+    return ldl_be_phys(&address_space_memory, ppc64_phys_to_real(phys + 4 * n));
+}
+
+uint64_t rtas_ldq(target_ulong phys, int n)
+{
+    return (uint64_t)rtas_ld(phys, n) << 32 | rtas_ld(phys, n + 1);
+}
+
+void rtas_st(target_ulong phys, int n, uint32_t val)
+{
+    stl_be_phys(&address_space_memory, ppc64_phys_to_real(phys + 4 * n), val);
+}
+
 static void rtas_display_character(PowerPCCPU *cpu, SpaprMachineState *spapr,
                                    uint32_t token, uint32_t nargs,
                                    target_ulong args,
-- 
2.53.0


