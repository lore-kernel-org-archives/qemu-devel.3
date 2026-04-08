Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (unknown [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7920610F996C
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 18:43:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAXsJ-0006kj-Tc; Wed, 08 Apr 2026 14:43:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wAXrI-0005Zb-H4
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 14:42:36 -0400
Received: from mail-oa1-x2c.google.com ([2001:4860:4864:20::2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wAXrG-0006lw-Od
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 14:42:36 -0400
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-4230a00de40so56914fac.1
 for <qemu-devel@nongnu.org>; Wed, 08 Apr 2026 11:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775673752; x=1776278552; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=riMdFQBw+NPfjx7h9ezpTI7d8ykChtbuKIqP2m2huCg=;
 b=aoUsOhd4Q/95Lu/6rlEtx/yaM7qkzmJyNDiGev4AHMmxETwP8X+TvZTmCWOckAUgLC
 nK/BWOqStomjnSbZjunGYPtG+qeXIzFvQUN6wErDj+T4YECGO6RBgnM6LzjCrfIJhjSs
 0qCatJzBLsj8QcM8ehXs8MhNja92qFWVl5003BFcFtcEORTddQD25PFtAslXlQ5LIe+m
 pPgodcgJyIlum04zB0KckJIZDfYWjuhYppI/GzzzKLiDyKI5ZZcEb9n0e7k7SvXXt6Dz
 uuOnZGmAfuYEJFpRcvo8XGbn3xCP+82ZAJqOYGrXDg7Gbw2920mhE/rKacrmuCx8LV+y
 bBkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775673752; x=1776278552;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=riMdFQBw+NPfjx7h9ezpTI7d8ykChtbuKIqP2m2huCg=;
 b=CAK153uFtxTr0LfBZ59zP8QaLt7f9TnoPHQ0eMJ1wax0pDCcmyaLYi23+CwLvSlGN6
 KJoFR+edx5pXKMr5zB1Ck3f5Ewndp/Z8cw9CdcioKK4/czjRLp3c7SCW/vmPszDL4Wog
 5r6/6yGlLiF8AyJUQ3O8CQQO3WJif92i/O1QEudaqHsssW72snhewmsLajT7gTfw7xGc
 L6HaxWnMgx8ZR/lS+wovi0LSZGx8BtssqSdDvNaSYLJ7RoWdcrWPp2yJ7AONAoMXfCfL
 xvNJMXMqubxkMejuR5Xi+4+yYMwR0/ipmDbV+txcUw/xtRVSbRY2IhDwBnj2T0zB45gu
 TMKQ==
X-Gm-Message-State: AOJu0YzyCGOXUpcbnPLqM5ahEATdGpkkzmFYk1xL98DpH7/ezzNjrc7/
 ERVAbN2DjXatTzA4Yn6XZqz9mF3ra67oejw9NWOOBt9svdvhUPOXSfeJYSHa2aK2zXU=
X-Gm-Gg: AeBDieuy+oi/t5NAaRkAmKhVrWaan+NVMzpKFqL41kYHBp9q16AUIoW4WDrreaie2JB
 x5/EL/O4YipYsNU2aB8KHjY59iQslr049poywmONl8nvf3KDUDROHlB5hkrTbZNZn72zEkw44p1
 RsvbIRhyeQQwijPPMjOJkLVt1PEieUA4EPhUlR9LrrZs1RERD9EH5JtLSGv/XmGg9odKUZDH7bh
 qMMpnhrvWD3bOqfKU5UtylYSyfuL4NSy2xR3oAT6JwMK2dBm9Yo/E05wyzkMdndVzKX9bNLiJ0k
 VogUCpacIIzhuLZ9PDquWnA08iQnfH3OjgcsMKPOB0jfV5syy3JFmGtgHuXlzPVPf8YEWzpkAqy
 fgXdltALcv8KYa40XbeFxd2MyiJCCiIm/wS47QeTtzgkVJTNHBUY08pi8K5uvoTCTHxnoYgkfJ2
 d4wg8pOp7usCpWLYeFgRqbKH7gB+/GSE+74U33HGgKzdZENQTGO7fGtcIXDXhYLyjVl1FxT5xrd
 ZJNsziKuzEW2b+4QYDFN+QGsGRxCSFPt3UIsnje6oJKSGk/18+AJNts6F8mfc+sLL3+lEhfdA==
X-Received: by 2002:a05:6870:fb91:b0:417:3930:1b93 with SMTP id
 586e51a60fabf-423bccb0ae6mr338691fac.6.1775673752324; 
 Wed, 08 Apr 2026 11:42:32 -0700 (PDT)
Received: from Mac.localdomain.cloud (71-218-253-186.hlrn.qwest.net.
 [71.218.253.186]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-422eb25a55asm17388864fac.10.2026.04.08.11.42.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 08 Apr 2026 11:42:32 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
To: qemu-devel@nongnu.org
Cc: James Hilliard <james.hilliard1@gmail.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH] linux-user/mips: keep k0 in sync with CP0_UserLocal
Date: Wed,  8 Apr 2026 12:42:28 -0600
Message-ID: <20260408184228.44242-1-james.hilliard1@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2c;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oa1-x2c.google.com
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

MIPS glibc startup expects the thread pointer to be live in both
CP0_UserLocal and k0. linux-user already updates CP0_UserLocal for
cpu_set_tls() and TARGET_NR_set_thread_area, but it leaves gpr[26]
unchanged.

A guest can therefore successfully execute set_thread_area() and still
reach __pthread_initialize_minimal() with k0 == 0, faulting on the
first TLS-relative store.

Make cpu_set_tls() synchronize k0 with CP0_UserLocal, and route the
MIPS set_thread_area syscall through cpu_set_tls() so all guest TLS
updates follow the same path.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 linux-user/mips/target_cpu.h | 1 +
 linux-user/syscall.c         | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/linux-user/mips/target_cpu.h b/linux-user/mips/target_cpu.h
index c375616c55..0a000ac8f3 100644
--- a/linux-user/mips/target_cpu.h
+++ b/linux-user/mips/target_cpu.h
@@ -36,6 +36,7 @@ static inline void cpu_clone_regs_parent(CPUMIPSState *env, unsigned flags)
 static inline void cpu_set_tls(CPUMIPSState *env, target_ulong newtls)
 {
     env->active_tc.CP0_UserLocal = newtls;
+    env->active_tc.gpr[26] = newtls;
 }
 
 static inline abi_ulong get_sp_from_cpustate(CPUMIPSState *state)
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index f4b74ad350..8e96cc26db 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -13216,7 +13216,7 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
 #ifdef TARGET_NR_set_thread_area
     case TARGET_NR_set_thread_area:
 #if defined(TARGET_MIPS)
-      cpu_env->active_tc.CP0_UserLocal = arg1;
+      cpu_set_tls(cpu_env, arg1);
       return 0;
 #elif defined(TARGET_I386) && defined(TARGET_ABI32)
       return do_set_thread_area(cpu_env, arg1);
-- 
2.53.0


