Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A607C531D0
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jul 2026 00:55:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnn9U-0003i9-4b; Sat, 25 Jul 2026 20:55:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wnn9R-0003hO-Na
 for qemu-devel@nongnu.org; Sat, 25 Jul 2026 20:55:33 -0400
Received: from mail-qk1-x72d.google.com ([2607:f8b0:4864:20::72d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wnn9Q-0007ZL-3w
 for qemu-devel@nongnu.org; Sat, 25 Jul 2026 20:55:33 -0400
Received: by mail-qk1-x72d.google.com with SMTP id
 af79cd13be357-92e533aacf2so83204485a.2
 for <qemu-devel@nongnu.org>; Sat, 25 Jul 2026 17:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785027331; x=1785632131; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=pVwlgtmgEc3axuYS6KKLOPY8UyUmHfC6AB1k/zPj/1o=;
 b=BxSpWb40E2gLCt5J9yD/LrFAaqyfRSMtWdI23Qo+aW2Kv0N0fYdfSRmwNQJCjmFleD
 49CBxPQSbT1adEXV/vUmJ35JRvIETuyql7wW1IcJYIA50y5bxB0S/XbJPh5KDCnUnqzP
 osS2Z+Ut9mpnsF0TMP9TeYK/sFR1oIcdMO7Qr0B0wv+tavlYtyet/253zvlTgxtcquya
 0KVJPl57DbUwwOFL3bjfq6R/fVNHDmbiDl7qaThYsqsG9HEO6yU3aBtqqEBO9iFNoI7I
 snPRfe6vWvhVjTpQS/4SStEq22XEOtaivd3Nqte+UqOtdvI32U6M3R8fexbXJnkTpVvl
 wYYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785027331; x=1785632131;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pVwlgtmgEc3axuYS6KKLOPY8UyUmHfC6AB1k/zPj/1o=;
 b=NT74jaZ0xo714mjcVhBeDwSZlvZxOY/kd3uxiUmWwTJmJipDtSxkZ11ubbSwPtIUkm
 X4tlSWyEF4ITiC8l0RvvADYQPxw/VScvy1MtEFzsyEu3Kw4Hr4/TTQAZ5+5C2HAhkCU8
 00NQFJCSLbokdmW8tg7U1wqYQhZOSmc4cjZoCKIWlvcGPu8YNd091PZ1rRMmEMdvyn35
 /sNWtWoQrGUe2+dfGZq3NulJuCh3Lh7Gbbm4cp7ufnDr1Rr2MnsoOYvgs/vY2COcr5j7
 sb5GD85IJwXyD5rU7Ld4O5nTdyolrtwFPy+2MOX7uZcIEI081YZpxkuNqJDoXHAllk/S
 qm7A==
X-Gm-Message-State: AOJu0YxnXo/6WQYiapSVxtzAJkZ7ZWcKjTgi8bOCDYy5EhVj9eVw1wKC
 ZKDC32vZEbXzSRT6DV5hAZkyX5hzWZbMlt5JR8kixdBM0rXrCYO16qgZGCe1Hg==
X-Gm-Gg: AR+sD11f7vT7KbCZ8h1WHohmtA1PPPjR6/lNt37rBGiud//smgDfQPLnFkEPuGXg5dg
 r+5LCcVvlh9ap2ibB1QNuYd2t466embYH7B/j+xW8slzwCgs7aXDioHtxMeXM0rnMbBl3TObkAc
 A7v5OMDchJEc+BszX7WaVqxk+ojAGTW60GwPKitQMmXvnwkfWwegrb1J21VprSwVh+B5uSn9QsR
 O6rqaZLRY0La/AT4dCdXoh2JwBmGhU6MUsTWmCj9cG9sc93IqQvY2cXv05zI/R2JTzImfuYKEJo
 UNTEqc9uG5YFpFYl51wz8UeJlhVUeG1742n/c6+rtI7Jrxt35Mt2dm2TYcarSg/ReJgLenOJAqP
 s2huSZrLtuwL9fyy8Q13XBdUERovUBsSRq2hnRD4Egx6PIAJH1mr6ugI55QIXmiSxv6y18/xAyg
 NaEvnpW3ZQna5M/bzTmwIKYU5Kz8UmVrPndWBoMpCQlVP+SRQZLpW2vg==
X-Received: by 2002:a05:620a:2913:b0:92e:c116:bef1 with SMTP id
 af79cd13be357-932df730002mr402730685a.78.1785027330825; 
 Sat, 25 Jul 2026 17:55:30 -0700 (PDT)
Received: from localhost (host05.distrikthotelips2.d.subnet.rcn.com.
 [207.96.107.85]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-932de1dcef6sm255457285a.0.2026.07.25.17.55.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 Jul 2026 17:55:30 -0700 (PDT)
From: Matt Turner <mattst88@gmail.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Matt Turner <mattst88@gmail.com>
Subject: [PATCH] linux-user: fix guards for the fsmount(2) syscall series
Date: Sat, 25 Jul 2026 20:55:27 -0400
Message-ID: <20260726005527.2513254-1-mattst88@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::72d;
 envelope-from=mattst88@gmail.com; helo=mail-qk1-x72d.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

The fsopen(), fsconfig(), fsmount() and fspick() implementations are
guarded by defined(NR_fsopen) rather than defined(__NR_fsopen). No such
macro exists, so the guard is never true and the entire series compiles
out. Guests calling any of the four get -ENOSYS, which for example makes
systemd's credential setup fail with EXIT_CREDENTIALS for most units.

The strace bits for fsconfig() have the same typo.

Fixes: 767c32fe6983 ("linux-user: implement fsmount(2) series of syscalls")
Fixes: 6e0aa9f6c731 ("linux-user/strace: add fsmount series of syscalls")
Signed-off-by: Matt Turner <mattst88@gmail.com>
---
 linux-user/strace.c    | 2 +-
 linux-user/strace.list | 2 +-
 linux-user/syscall.c   | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git ./linux-user/strace.c ./linux-user/strace.c
index 3a81cc95f4..d861f311f6 100644
--- ./linux-user/strace.c
+++ ./linux-user/strace.c
@@ -4344,7 +4344,7 @@ print_statx(CPUArchState *cpu_env, const struct syscallname *name,
 }
 #endif
 
-#if defined(TARGET_NR_fsconfig) && defined(NR_fsconfig)
+#ifdef TARGET_NR_fsconfig
 static void
 print_fsconfig_cmd_name(int cmd)
 {
diff --git ./linux-user/strace.list ./linux-user/strace.list
index e363892e0a..3a366b8cac 100644
--- ./linux-user/strace.list
+++ ./linux-user/strace.list
@@ -1725,7 +1725,7 @@
 #ifdef TARGET_NR_fsopen
 { TARGET_NR_fsopen, "fsopen", "%s(%s,%d)", NULL, NULL },
 #endif
-#if defined(TARGET_NR_fsconfig) && defined(NR_fsconfig)
+#ifdef TARGET_NR_fsconfig
 { TARGET_NR_fsconfig, "fsconfig", NULL, print_fsconfig, NULL },
 #endif
 #ifdef TARGET_NR_fsmount
diff --git ./linux-user/syscall.c ./linux-user/syscall.c
index 3da5530d42..740142825d 100644
--- ./linux-user/syscall.c
+++ ./linux-user/syscall.c
@@ -9740,7 +9740,7 @@ _syscall5(int, sys_move_mount, int, __from_dfd, const char *, __from_pathname,
            int, __to_dfd, const char *, __to_pathname, unsigned int, flag)
 #endif
 
-#if defined(TARGET_NR_fsopen) && defined(NR_fsopen)
+#if defined(TARGET_NR_fsopen) && defined(__NR_fsopen)
 #define __NR_sys_fsopen __NR_fsopen
 _syscall2(int, sys_fsopen, const char *, fs_name, unsigned int, flags);
 #define __NR_sys_fsconfig __NR_fsconfig
@@ -14485,7 +14485,7 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
         return do_map_shadow_stack(cpu_env, arg1, arg2, arg3);
 #endif
 
-#if defined(TARGET_NR_fsopen) && defined(NR_fsopen)
+#if defined(TARGET_NR_fsopen) && defined(__NR_fsopen)
     case TARGET_NR_fsopen:
         {
             p = lock_user_string(arg1);
-- 
2.54.0


