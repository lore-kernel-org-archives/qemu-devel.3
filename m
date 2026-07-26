Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7D4FC531FA
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jul 2026 00:54:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnn7c-00036X-RN; Sat, 25 Jul 2026 20:53:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wnn7a-000369-1c
 for qemu-devel@nongnu.org; Sat, 25 Jul 2026 20:53:39 -0400
Received: from mail-yx1-xb136.google.com ([2607:f8b0:4864:20::b136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wnn7Y-0007Cz-EG
 for qemu-devel@nongnu.org; Sat, 25 Jul 2026 20:53:37 -0400
Received: by mail-yx1-xb136.google.com with SMTP id
 956f58d0204a3-66804667af2so1131998d50.0
 for <qemu-devel@nongnu.org>; Sat, 25 Jul 2026 17:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785027215; x=1785632015; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=pVwlgtmgEc3axuYS6KKLOPY8UyUmHfC6AB1k/zPj/1o=;
 b=aRbPvq2xDmNjDuc4PpgOFXvtg4xz0dPGRcVdrGEsVuSWgxHN6+HR6vpFw7IEsPAHWH
 lsZqFuH8rVQARAaQtKSqChJHBGflkGwvAf07N2KunnYQYhJgwxcDViod6yNd329pURtG
 66FyG9CsElZ9xYyqbgeQehtThdZ2k+m2Ldp8TLIwY2PxUayYCuIYRKDghM7LS9nJo57V
 OsN9mOJqfQBIp8H+nBuQ2/3OUBTPOVZ/SmbBLDSrblcI4IetuPvt2+oZi8kKnY62j6cE
 86c574/jyvOFY6Md/pTrcXj//qXuEry2QXkQkhEI5USQENIhoA25Ow+cABlQvc+SbMBs
 lBmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785027215; x=1785632015;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pVwlgtmgEc3axuYS6KKLOPY8UyUmHfC6AB1k/zPj/1o=;
 b=EvZDOSUkONx0dcpQP/lBbUPUt/hRB0tT3fYijqeaOxJmvtXOhvbYDEh02PRrglxibf
 p1pKvEo4IdZgwLaGem45hJeEA1yrRrKZkOgf5jM45YJVEOpAZCE7d/dY11bbEv/br1pv
 mDVn8JKXWkfy/8sOQweN2I4TmYgxm9kal5xlYW97gH8A3cXyL2YY23a9JfsBKGnFDd5X
 A2sTnHkFhGLtUBazabOLtdabbiEASRAcErxMZMyhYaqY9c+/M+ykh+CGz8tv7KWuZ06A
 TTMaOJyJJ9/n9OSIzNqptVDMCP+DRkNGA18PEt8iRVAuLWeRwLRBl1hdW2EgBAiJj/rK
 qBlQ==
X-Gm-Message-State: AOJu0YwcIQFllA6GnqCSdsnerLsjjZjJc8VVeRa6oi2TWgTiPBmOHitq
 Fw7r+yMkb++bw0MY2RVEsL7iZ6/6a9lXkA/vTGhHudnlOU0jMDw/FXIia/t0mA==
X-Gm-Gg: AR+sD11j+vB6EvXYkBd1BMkT2JG9H7qpt9KVvhoEB5VosDmH8tZ3gA5CqLWZwK8NYGT
 LTO+WhRDvSPZA7t5V+G11/vOjnwt1RqDI++eap/18PrZ87Ziz1vkLTuNUhgGjYdD7A11VeE0Wwy
 fL0sesTwZoLdIHghLvWKtUwahrEKfYSEFY1dHIBXaGBffztYfFIZMX/Ro84QAEgF1H7afNYdl6A
 3S+x+fDZA7ksCf4hskotI40AMac9wEwO+rfVx639n5DzM9JxClAExBdr6VBgSBOctFvOZ+j5P3F
 +pkd5Um1hUO5WyA8xGrkfdfnj+OGPryxvIjRkA0+wVO3lK5F0H+DezseLGYQVoQsh3efEjUQ51v
 pIQoi/wGdD1MEBAFvu942V3Kj9UEeT1lNZghOirEJq6RFqS3R07POSaTmGc4N/uPnhLcYS2KaD/
 PiJlHLtbr/5MNj+g4LVqU/lyLYKIoWgGegtjzm/RnfG58qJx0aVcZNTA==
X-Received: by 2002:a05:690e:4093:b0:668:11e1:1709 with SMTP id
 956f58d0204a3-668c7b58223mr1238758d50.98.1785027214803; 
 Sat, 25 Jul 2026 17:53:34 -0700 (PDT)
Received: from localhost (host05.distrikthotelips2.d.subnet.rcn.com.
 [207.96.107.85]) by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-668c6f696f7sm1373041d50.11.2026.07.25.17.53.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 Jul 2026 17:53:33 -0700 (PDT)
From: Matt Turner <mattst88@gmail.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Matt Turner <mattst88@gmail.com>
Subject: [PATCH] linux-user: fix guards for the fsmount(2) syscall series
Date: Sat, 25 Jul 2026 20:53:28 -0400
Message-ID: <20260726005328.2511963-1-mattst88@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::b136;
 envelope-from=mattst88@gmail.com; helo=mail-yx1-xb136.google.com
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


