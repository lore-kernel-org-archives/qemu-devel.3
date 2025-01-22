Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEF89C0218C
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2025 09:33:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taX4d-0001PS-Ej; Wed, 22 Jan 2025 04:30:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1taX4b-0001NW-Ld
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 04:30:57 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1taX4Z-0003Fy-W2
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 04:30:57 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-385de59c1a0so3791347f8f.2
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2025 01:30:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737538253; x=1738143053; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3ds9Wj0QZU42GLHBsVwmUFq56bCDGO06IGIH+Sdiodc=;
 b=PmjUjP9CKILYn+fBhV8S2ICj/3uSCLw237P+IYX0BTiPjRX8ugYkpGIFh0J5P9hza8
 miDLGx0xAXEOtJHSzN1xWi3vDq3W2lBj7tq6x7At+f5wmrVJgv4ken15WR7zZRxla1zu
 c57wSXDRP/srDP6P3bbhwLwa1sx8ScPRU6iQ/5UbMvRI4BJwve+LKcQLkIrS2Usa843c
 24VX6FTT7ciO8DS4Uu+mi4haxv982CCjBRX+4NY4jyktVwC8pqYYTn0uFb/6/2stJMAE
 skchOP/DHjMkrogdJ35rcyIuD2BmWCQTfVcCAuQ6Jc3kDuSF6evaX/YSvkuVDW5AHKga
 XEpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737538253; x=1738143053;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3ds9Wj0QZU42GLHBsVwmUFq56bCDGO06IGIH+Sdiodc=;
 b=d6XepkMFcK5ZbZbe4PfLD8cP3cwZAKJGHKQwM0S0u5tCkv3POV5J70vQ0HSUEn+Sr5
 FJ2W+7Oa6FTPzM0HF1CBQ3T813gSIymfyajKpOz8iZtFRju/9nE7gSy8svJNtovFBG1V
 1ll8SKKFX0R9/7JkUcGuJphJM/s/Ns4qSjrnd7wilFz6omckjHuMEvEoBAmuCcYY79LH
 vsBfMUj9SWGdbzQCJOdEsdWNfPY8quAIdX/HaMFL6csZyQw/YAnuCB4TEzHtARbJ9h3m
 8ee8N9LdZ92N1WFusrZifcKcDSMpP6Mo+LWD/CSYouWyQdPN9uRFa76TK3QXT4m/LHzP
 ZT6w==
X-Gm-Message-State: AOJu0YyQbnxecDEO1+Fdc8qGR9RTUoVYLkMs2k4M6O67vmL8hGEyNfKg
 dK+itmpcPQxRwT009c2nEWL71FHsEOAexhBP86nCgeFBUFtSrYlko03N2vM+uBv2y8XlFUQXjfN
 hAcY=
X-Gm-Gg: ASbGncsmvw421JehaOyq5jyjTyopjJ08ND6zegCH4bHPgdbGUDHvXX8VBeGDEPrwFS7
 BEg8YFO1OWA69ifTs4INeSSEIgRP2j6tA0WWKL3LacId/y7Ny6MBYKc7paP76a0ZJ7I+6v8ws6y
 SXbvTvIJGYYnKCzBMY1lGe0UVg68TGR4VLbRS2f+ZYYfXPmlkEmm+5md7utrjC/e13O14mMT51E
 hKBoDIFiO7AJjZPGW7NNqAmhvj5QaFGon5ov4buoyjutKTmAhAMUl8qz09x8sEgw9LNp2NZUzzP
 lzMnTTy9qxpwFzshl3SLugLLdP5ylN7YI9ENdLnRgD7q
X-Google-Smtp-Source: AGHT+IGpVW92Redmqgr+HmUbpNm8hsX+p2uNrDpzZR1xgMtAGnI2STvmEVxhrXqPqFc+p4wVYOA0OQ==
X-Received: by 2002:a05:6000:1f81:b0:386:3213:5b9b with SMTP id
 ffacd0b85a97d-38bf57a9477mr21266255f8f.43.1737538253473; 
 Wed, 22 Jan 2025 01:30:53 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38bf322acdcsm16022223f8f.55.2025.01.22.01.30.52
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 22 Jan 2025 01:30:53 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 05/10] accel: Prefer cached CpuClass over CPU_GET_CLASS()
 macro
Date: Wed, 22 Jan 2025 10:30:23 +0100
Message-ID: <20250122093028.52416-6-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250122093028.52416-1-philmd@linaro.org>
References: <20250122093028.52416-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

CpuState caches its CPUClass since commit 6fbdff87062
("cpu: cache CPUClass in CPUState for hot code paths"),
use it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/accel-target.c      | 12 +++++-------
 accel/tcg/tcg-accel-ops.c |  3 +--
 accel/tcg/translate-all.c |  2 +-
 accel/tcg/watchpoint.c    |  9 ++++-----
 4 files changed, 11 insertions(+), 15 deletions(-)

diff --git a/accel/accel-target.c b/accel/accel-target.c
index 08626c00c2d..8a16c0c3ae0 100644
--- a/accel/accel-target.c
+++ b/accel/accel-target.c
@@ -112,22 +112,20 @@ void accel_init_interfaces(AccelClass *ac)
 
 void accel_cpu_instance_init(CPUState *cpu)
 {
-    CPUClass *cc = CPU_GET_CLASS(cpu);
-
-    if (cc->accel_cpu && cc->accel_cpu->cpu_instance_init) {
-        cc->accel_cpu->cpu_instance_init(cpu);
+    if (cpu->cc->accel_cpu && cpu->cc->accel_cpu->cpu_instance_init) {
+        cpu->cc->accel_cpu->cpu_instance_init(cpu);
     }
 }
 
 bool accel_cpu_common_realize(CPUState *cpu, Error **errp)
 {
-    CPUClass *cc = CPU_GET_CLASS(cpu);
     AccelState *accel = current_accel();
     AccelClass *acc = ACCEL_GET_CLASS(accel);
 
     /* target specific realization */
-    if (cc->accel_cpu && cc->accel_cpu->cpu_target_realize
-        && !cc->accel_cpu->cpu_target_realize(cpu, errp)) {
+    if (cpu->cc->accel_cpu
+        && cpu->cc->accel_cpu->cpu_target_realize
+        && !cpu->cc->accel_cpu->cpu_target_realize(cpu, errp)) {
         return false;
     }
 
diff --git a/accel/tcg/tcg-accel-ops.c b/accel/tcg/tcg-accel-ops.c
index 6e3f1fa92b2..299d6176cfb 100644
--- a/accel/tcg/tcg-accel-ops.c
+++ b/accel/tcg/tcg-accel-ops.c
@@ -120,10 +120,9 @@ static inline int xlat_gdb_type(CPUState *cpu, int gdbtype)
         [GDB_WATCHPOINT_ACCESS] = BP_GDB | BP_MEM_ACCESS,
     };
 
-    CPUClass *cc = CPU_GET_CLASS(cpu);
     int cputype = xlat[gdbtype];
 
-    if (cc->gdb_stop_before_watchpoint) {
+    if (cpu->cc->gdb_stop_before_watchpoint) {
         cputype |= BP_STOP_BEFORE_ACCESS;
     }
     return cputype;
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index d56ca13cddf..5a378cb0281 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -622,7 +622,7 @@ void cpu_io_recompile(CPUState *cpu, uintptr_t retaddr)
      * to account for the re-execution of the branch.
      */
     n = 1;
-    cc = CPU_GET_CLASS(cpu);
+    cc = cpu->cc;
     if (cc->tcg_ops->io_recompile_replay_branch &&
         cc->tcg_ops->io_recompile_replay_branch(cpu, tb)) {
         cpu->neg.icount_decr.u16.low++;
diff --git a/accel/tcg/watchpoint.c b/accel/tcg/watchpoint.c
index af57d182d5b..52e550dec6b 100644
--- a/accel/tcg/watchpoint.c
+++ b/accel/tcg/watchpoint.c
@@ -69,7 +69,6 @@ int cpu_watchpoint_address_matches(CPUState *cpu, vaddr addr, vaddr len)
 void cpu_check_watchpoint(CPUState *cpu, vaddr addr, vaddr len,
                           MemTxAttrs attrs, int flags, uintptr_t ra)
 {
-    CPUClass *cc = CPU_GET_CLASS(cpu);
     CPUWatchpoint *wp;
 
     assert(tcg_enabled());
@@ -85,9 +84,9 @@ void cpu_check_watchpoint(CPUState *cpu, vaddr addr, vaddr len,
         return;
     }
 
-    if (cc->tcg_ops->adjust_watchpoint_address) {
+    if (cpu->cc->tcg_ops->adjust_watchpoint_address) {
         /* this is currently used only by ARM BE32 */
-        addr = cc->tcg_ops->adjust_watchpoint_address(cpu, addr, len);
+        addr = cpu->cc->tcg_ops->adjust_watchpoint_address(cpu, addr, len);
     }
 
     assert((flags & ~BP_MEM_ACCESS) == 0);
@@ -119,8 +118,8 @@ void cpu_check_watchpoint(CPUState *cpu, vaddr addr, vaddr len,
             wp->hitattrs = attrs;
 
             if (wp->flags & BP_CPU
-                && cc->tcg_ops->debug_check_watchpoint
-                && !cc->tcg_ops->debug_check_watchpoint(cpu, wp)) {
+                && cpu->cc->tcg_ops->debug_check_watchpoint
+                && !cpu->cc->tcg_ops->debug_check_watchpoint(cpu, wp)) {
                 wp->flags &= ~BP_WATCHPOINT_HIT;
                 continue;
             }
-- 
2.47.1


