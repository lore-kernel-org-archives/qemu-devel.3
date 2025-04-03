Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10216C36014
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 00:04:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0UVq-0002Kk-Kh; Thu, 03 Apr 2025 20:02:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0UVS-0001oD-8c
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 20:02:04 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0UVQ-0003Ex-FW
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 20:01:57 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43d04dc73b7so14510635e9.3
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 17:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743724914; x=1744329714; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VlQYulyRFs+KcJzdqcrZEMpQxfGXO+wcW4ZSqu04L5k=;
 b=hQyFGS7ymuJsBu00R+0e+vrquuhWJ7oTeOi6+1geNOqiZ+nfd0YcpMSfgPgn/IxmML
 OKyyePPaUm5PpkgGIF97Zc2WWZKkSnGiMiS7KuLu7J5E8EW8HwcI/0F2hc9cDW0clyK+
 5pZFIXZ3Ljn1pjNwOc56cwFzp4MNFMFfOqAe4slubkLw3mWP0p6vjLFzEETWGQS2kjCm
 l8ObZ44HDrVTcUa5fnbTU5h4GDzzBnN6ykiUBRYHcOSobaL9nf/Qm3PQ+O47TuU6h8VU
 +SVz9vNQ4k4O45PMwpFrBAS0BlgzWDl6uUgaI4XsGe/5Bx77iFXxV+xKvlTtSXRmJQI2
 kjyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743724914; x=1744329714;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VlQYulyRFs+KcJzdqcrZEMpQxfGXO+wcW4ZSqu04L5k=;
 b=JwXlyHO9Kc3eX4MMjmiOw3QSMYpxtEwCVJspSsqxMQnvoy2GUdo4/TEpHAD4epZr2H
 P3sC0p+GsrNtceLXhk6c7lCNne7nZrIhXLjROt3hY4X3+kB8vPywV/qXoIYIWq33iLKZ
 /zaLYEE5Ka9g+LRH68Z3mKlJv+iOYz1yhEgkXg6B6R1ZHjrAAv8inJDOyaoZM4I3zpxU
 mOj+OYikpTTz34c0i2B9CEgvIG/ZPr6U0AtnRZvAyfp3jz7LKSVoiFj0Arq/aiJAiroR
 KOpsY1ShivodShiudGQst6O4HeWuYmttF5fsHwWfGCwhCRM0GfSH3BIW4J5CPq6cGKCC
 tbGA==
X-Gm-Message-State: AOJu0YxR3D/rW3a0+vxX+RCG+tqGyT/1l4iNJ9KwqLEvaZHHWk3wUxew
 UTSIGZjuq41QXzZZ8Lj5K5qs6Ojospqox0jHjMVsZXxhBkSeoHDdz2fO0jhkpGDE4oQNoWhq95B
 B
X-Gm-Gg: ASbGncsLV5eqZL1SG5Uw4Xg8VUAf89rPsi4ZCOoVbLt6hIQw/wf1Ci8+N4NCIj5sdZk
 rb8CAemn1byycZf2raIMpH8zzxt5W5onMgvzU19mNrJ9irkDxQ5XKs6er6ymqTDxz2S9EDd9Zpe
 GOd5CIfNs3r0Ec+2B2Nk6MetmqxX6By19wRwl2kqfx2ZvfKkc/UBWyALU2uSvqWn1cuNsJK9zno
 B0/Dthkj5/okLj/y34Qr7XNTu//s0PmgIbld/sCXniohX52ds5e/fL3KamZqfReTnt6cxXHjeaO
 mFfbU9AWt+mqxYVb58pfeanJ+jEXe2DUMbN+3Ta4MtXiRpgf4wGwhkxduZii/1Bip4hv1PCV4L3
 LufvjhXDrAQz0tqdwvlw=
X-Google-Smtp-Source: AGHT+IECRzMi5XQthL/0ZboD1pA2DQQu7uOvI46WYc3BJW0sfEyHo0Zm3TZ7Ud7ClAbi57LsvZRJgQ==
X-Received: by 2002:a05:600c:3d94:b0:43c:fceb:91f with SMTP id
 5b1f17b1804b1-43ed0bc8d58mr5501025e9.11.1743724914582; 
 Thu, 03 Apr 2025 17:01:54 -0700 (PDT)
Received: from localhost.localdomain (184.170.88.92.rev.sfr.net.
 [92.88.170.184]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec16602bbsm34181125e9.9.2025.04.03.17.01.51
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Apr 2025 17:01:53 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Subject: [RFC PATCH-for-10.1 32/39] target/arm: Replace target_ulong -> vaddr
 for CPUWatchpoint
Date: Fri,  4 Apr 2025 01:58:14 +0200
Message-ID: <20250403235821.9909-33-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250403235821.9909-1-philmd@linaro.org>
References: <20250403235821.9909-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

CPUWatchpoint::vaddr/len are of type vaddr.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/internals.h   | 9 +++++----
 target/arm/hyp_gdbstub.c | 8 ++++----
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index ce60aee41d8..86577207b85 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -26,6 +26,7 @@
 #define TARGET_ARM_INTERNALS_H
 
 #include "exec/hwaddr.h"
+#include "exec/vaddr.h"
 #include "exec/breakpoint.h"
 #include "hw/registerfields.h"
 #include "tcg/tcg-gvec-desc.h"
@@ -1948,10 +1949,10 @@ bool find_hw_breakpoint(CPUState *cpu, uint64_t pc);
 int insert_hw_breakpoint(uint64_t pc);
 int delete_hw_breakpoint(uint64_t pc);
 
-bool check_watchpoint_in_range(int i, target_ulong addr);
-CPUWatchpoint *find_hw_watchpoint(CPUState *cpu, target_ulong addr);
-int insert_hw_watchpoint(target_ulong addr, target_ulong len, int type);
-int delete_hw_watchpoint(target_ulong addr, target_ulong len, int type);
+bool check_watchpoint_in_range(int i, vaddr addr);
+CPUWatchpoint *find_hw_watchpoint(CPUState *cpu, vaddr addr);
+int insert_hw_watchpoint(vaddr addr, vaddr len, int type);
+int delete_hw_watchpoint(vaddr addr, vaddr len, int type);
 
 /* Return the current value of the system counter in ticks */
 uint64_t gt_get_countervalue(CPUARMState *env);
diff --git a/target/arm/hyp_gdbstub.c b/target/arm/hyp_gdbstub.c
index 4e52d37ed80..4d8fd933868 100644
--- a/target/arm/hyp_gdbstub.c
+++ b/target/arm/hyp_gdbstub.c
@@ -125,7 +125,7 @@ int delete_hw_breakpoint(uint64_t pc)
  * need to ensure you mask the address as required and set BAS=0xff
  */
 
-int insert_hw_watchpoint(target_ulong addr, target_ulong len, int type)
+int insert_hw_watchpoint(vaddr addr, vaddr len, int type)
 {
     HWWatchpoint wp = {
         .wcr = R_DBGWCR_E_MASK, /* E=1, enable */
@@ -182,7 +182,7 @@ int insert_hw_watchpoint(target_ulong addr, target_ulong len, int type)
     return 0;
 }
 
-bool check_watchpoint_in_range(int i, target_ulong addr)
+bool check_watchpoint_in_range(int i, vaddr addr)
 {
     HWWatchpoint *wp = get_hw_wp(i);
     uint64_t addr_top, addr_bottom = wp->wvr;
@@ -214,7 +214,7 @@ bool check_watchpoint_in_range(int i, target_ulong addr)
  * Delete a breakpoint and shuffle any above down
  */
 
-int delete_hw_watchpoint(target_ulong addr, target_ulong len, int type)
+int delete_hw_watchpoint(vaddr addr, vaddr len, int type)
 {
     int i;
     for (i = 0; i < cur_hw_wps; i++) {
@@ -239,7 +239,7 @@ bool find_hw_breakpoint(CPUState *cpu, uint64_t pc)
     return false;
 }
 
-CPUWatchpoint *find_hw_watchpoint(CPUState *cpu, target_ulong addr)
+CPUWatchpoint *find_hw_watchpoint(CPUState *cpu, vaddr addr)
 {
     int i;
 
-- 
2.47.1


