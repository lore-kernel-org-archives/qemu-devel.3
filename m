Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94EDBC54E41
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Mar 2024 04:13:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgGjF-0005KI-RK; Fri, 01 Mar 2024 23:12:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgC1W-0003rn-E0
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 18:10:43 -0500
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgC1U-0005hH-UV
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 18:10:38 -0500
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-299dba8fd24so2014952a91.2
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 15:10:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709334635; x=1709939435; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iM2DWBTbIODm0qN2yhX9D3hAXXDtYwow0kqtsMcFoQE=;
 b=q2VDXy6EXcCz4B0fluG1oG09P/pGUBrBh3mVizp/k16h5/BayaqN/BkCu9yONkG9f8
 qqkAyepHULzVJE6OD4F7bPY6FqyDAv+VQxBdyQw9UhFNQ4akFOpOpVPJT/9XUazDq/pu
 LgstV1MYqnX/id5/bogeOZh+rCzg322vZQAL5Hml3x8EWJe98sxazm4tbt34uMV8a4Ds
 LbOpgg1Z0LnluMI9B0qynu7rHpfwMsW3YAbZnWkFzMHkbbLhFM/8NWRevKkP2Pv4yL7Z
 WQ9O8rwHU++kUqJ/EV/AAskf2P7uJGALjcA0VTGXSnHeObgQ8tlRO6wfYD/sAEbtWgYB
 5/+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709334635; x=1709939435;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iM2DWBTbIODm0qN2yhX9D3hAXXDtYwow0kqtsMcFoQE=;
 b=tXA5tsIV2I3jHwxD9Rw57sPnfY4vSNqXgzP+PWq5DpsmqYZcJ6kViyCSxEETycJvRT
 1SU9nAOUchM78FfkJ3hr3zn7vSH7LNAC2HTgEy+yGlfd1fIWGqhavbIqONVSkTTeeWw7
 1d5yy1Q2NgWyw+YohLbcjOL1qZIwAMSCNojQrjPgGtdx9zSJRX4ZI9qJajNsoOlJg3+7
 D98XvrdvEL8d5qbsoPivajVhZYpyMYa6/tYuCEuGJHvzmYJrfC7pOst6j2vdiSBv+56c
 TEobqx3xXOYgqlvnlo/2jQ4RnRuy/3tcOkXfREbtmN+a2QCX+Zm+LgWypVWcMy7o9cx8
 neBg==
X-Gm-Message-State: AOJu0YzN1f0P38PtO8pnKy/znEMRH+uLeKzVg8ujCU2l1ZJ5LiaDSbyj
 VpOOxAj/Csu/83KS2JkqTy8dQd2/Rb9oQi4jRGB1lQY/mrvhaX+KsS4yXLsGtB5/kmJWbscBVVQ
 j
X-Google-Smtp-Source: AGHT+IGzobOfqcAfHrq8iEteXzqbDe4u12aBCAcJ9kunxr8DWCdhGTefmlobibC/PvA2PoGOhNQO2A==
X-Received: by 2002:a17:90b:4e83:b0:29b:2628:6a18 with SMTP id
 sr3-20020a17090b4e8300b0029b26286a18mr2680942pjb.15.1709334634998; 
 Fri, 01 Mar 2024 15:10:34 -0800 (PST)
Received: from stoup.. (098-147-055-211.res.spectrum.com. [98.147.55.211])
 by smtp.gmail.com with ESMTPSA id
 c2-20020a634e02000000b005e438fe702dsm3449407pgb.65.2024.03.01.15.10.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Mar 2024 15:10:34 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Helge Deller <deller@gmx.de>
Subject: [PATCH 49/60] linux-user: Allow TARGET_PAGE_BITS_VARY
Date: Fri,  1 Mar 2024 13:06:08 -1000
Message-Id: <20240301230619.661008-50-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240301230619.661008-1-richard.henderson@linaro.org>
References: <20240301230619.661008-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

If set, match the host and guest page sizes.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Acked-by: Helge Deller <deller@gmx.de>
Message-Id: <20240102015808.132373-30-richard.henderson@linaro.org>
---
 linux-user/main.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/linux-user/main.c b/linux-user/main.c
index bad03f06d3..12bb839982 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -55,6 +55,7 @@
 #include "loader.h"
 #include "user-mmap.h"
 #include "tcg/perf.h"
+#include "exec/page-vary.h"
 
 #ifdef CONFIG_SEMIHOSTING
 #include "semihosting/semihost.h"
@@ -680,6 +681,7 @@ int main(int argc, char **argv, char **envp)
     int i;
     int ret;
     int execfd;
+    int host_page_size;
     unsigned long max_reserved_va;
     bool preserve_argv0;
 
@@ -791,6 +793,16 @@ int main(int argc, char **argv, char **envp)
                                  opt_one_insn_per_tb, &error_abort);
         ac->init_machine(NULL);
     }
+
+    /*
+     * Finalize page size before creating CPUs.
+     * This will do nothing if !TARGET_PAGE_BITS_VARY.
+     * The most efficient setting is to match the host.
+     */
+    host_page_size = qemu_real_host_page_size();
+    set_preferred_target_page_bits(ctz32(host_page_size));
+    finalize_target_page_bits();
+
     cpu = cpu_create(cpu_type);
     env = cpu_env(cpu);
     cpu_reset(cpu);
@@ -804,8 +816,6 @@ int main(int argc, char **argv, char **envp)
      */
     max_reserved_va = MAX_RESERVED_VA(cpu);
     if (reserved_va != 0) {
-        int host_page_size = qemu_real_host_page_size();
-
         if ((reserved_va + 1) % host_page_size) {
             char *s = size_to_str(host_page_size);
             fprintf(stderr, "Reserved virtual address not aligned mod %s\n", s);
@@ -904,7 +914,7 @@ int main(int argc, char **argv, char **envp)
      * If we're in a chroot with no /proc, fall back to 1 page.
      */
     if (mmap_min_addr == 0) {
-        mmap_min_addr = qemu_real_host_page_size();
+        mmap_min_addr = host_page_size;
         qemu_log_mask(CPU_LOG_PAGE,
                       "host mmap_min_addr=0x%lx (fallback)\n",
                       mmap_min_addr);
-- 
2.34.1


