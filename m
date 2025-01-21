Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ED60C02182
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 19:04:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taJXU-0007wu-9L; Tue, 21 Jan 2025 14:03:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1taJXQ-0007wf-PY
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 14:03:49 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1taJXL-0007eV-S9
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 14:03:48 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-385ddcfc97bso4953718f8f.1
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2025 11:03:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737486221; x=1738091021; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=+wniptwUBWwWqkvzbTkXAxueetmdH6REYBF+XBfVcBk=;
 b=uoFKjueftjKaP/5RwSP+npLmOuSItYqi49Lca9JBJMmkmCtQM1+Ds3t2UIaotzNbZR
 553LhlFt6rRU8XFME6SnFcmLLqaBmi9aQwNkWSLH6QihJclgkxfwFolB7X3PWjEio/Ea
 RVo73li9X+WoRK8+WVeRGFMiz2JsYopkiIln9rZk92QuaP7BtjT0T3of3XkeC7LxUNXf
 4gfQx+x7Xwv8hvuAZhczU9S4lE34KFxP/38hwfAQ4Hm2Ei8xkuyGLbNgdaNBalfda/IK
 WUkGEnLUcXiSqCcEBb9NvtVxsPxVJnJMODu1NwAz6py/z23u1L3FsyY7fDkNgWfLbslc
 kIeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737486221; x=1738091021;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+wniptwUBWwWqkvzbTkXAxueetmdH6REYBF+XBfVcBk=;
 b=DglZGpo4Jd/wrUSoBsYb4RjJgU8ta6oS9W8wxLjDhvYcKAIdAGnfWH1PpTWRN3tQUA
 yXNA2nZETnlC1Slf9OtqT2/RNnf0kHB6h+EIPQ98Ma9qh4jO+UsY983kSGW78gpv2Kpe
 N0AkPXxC1AmFsle0pb0zJhjjMv/q/Fx6iVA1HCFhWeGFm2vjF3VCreUau8FQtRkPkcBr
 jLtpaeOIotQos1R+QvxZzFo7JeO1p1lu0Rhpbm482/NzhxsRuu6YBTzTEWtL3rhJWOC+
 96flJfA8qUEkjbi9m02Zm8yZt1iqKg0lgOyKRNKWA6zANTrmiVEtHqbxIoO98s4WO1JH
 istA==
X-Gm-Message-State: AOJu0YzN5VWvMkqxDBeP2zCglMtNu2NBSNgVo43wfFVBkr7K436hZ+r2
 8AaiWyNqdYWutkImgU8OD54YWJZ3c4OGnUA8Ygb+ZiETNDfrGi/pSDX7WgokBFSE5o8d6lxf8aC
 NrQE=
X-Gm-Gg: ASbGncvoXnIFQaRttkiVPb1htHbuSCLcV2mz4h0V/CcRpb90REwABESNi9CawoiR1/S
 9fyvjoQQD/tPXMyc8yj0DQAuJnKtJwkcarhyStIa4qUUSAia+JlAYn9/9pIQmrZ806t44tnOWsO
 NlJZ+iRc/YxxYHtOGgVHav/BV3Qkp9B4DWswfpj+axfCbw96/B+uu7Tvwyd4C8KbpyxRMyd//Vq
 X0kU0qU35AwZMNGJT9lObzWQ8xCnQ3awyK9rHX4sC9D6F/OnUm8xJFBW0pYLc3QeagegHXCgzUj
 V0KdeLtBGyjs9BCkU95Ozmr7KVPSS3Z8gACsfP8hlgVU
X-Google-Smtp-Source: AGHT+IEN7cY+ZfdUSIaNFsp5kNeWJ54tznhrwqUeHjL8QSHXlhvgfkoZLNuoZuAXJDjTHKx0KCeCTA==
X-Received: by 2002:a05:6000:1a8c:b0:38b:ed6f:f00f with SMTP id
 ffacd0b85a97d-38bf56635a1mr16420997f8f.17.1737486220561; 
 Tue, 21 Jan 2025 11:03:40 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38bf3221761sm14008914f8f.22.2025.01.21.11.03.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Jan 2025 11:03:40 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] linux-user: Constify target_shmlba() argument
Date: Tue, 21 Jan 2025 20:03:38 +0100
Message-ID: <20250121190339.58223-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
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

Returning target segment low boundary address multiple
shouldn't need to modify the CPU env. Make it const.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 linux-user/arm/target_syscall.h    | 2 +-
 linux-user/mips/target_syscall.h   | 2 +-
 linux-user/mips64/target_syscall.h | 2 +-
 linux-user/sh4/target_syscall.h    | 2 +-
 linux-user/sparc/target_syscall.h  | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/linux-user/arm/target_syscall.h b/linux-user/arm/target_syscall.h
index 412ad434cfc..de5661c296b 100644
--- a/linux-user/arm/target_syscall.h
+++ b/linux-user/arm/target_syscall.h
@@ -35,7 +35,7 @@ struct target_pt_regs {
 
 #define TARGET_FORCE_SHMLBA
 
-static inline abi_ulong target_shmlba(CPUARMState *env)
+static inline abi_ulong target_shmlba(const CPUARMState *env)
 {
     return 4 * 4096;
 }
diff --git a/linux-user/mips/target_syscall.h b/linux-user/mips/target_syscall.h
index 08ead678104..7aade628645 100644
--- a/linux-user/mips/target_syscall.h
+++ b/linux-user/mips/target_syscall.h
@@ -30,7 +30,7 @@ struct target_pt_regs {
 
 #define TARGET_FORCE_SHMLBA
 
-static inline abi_ulong target_shmlba(CPUMIPSState *env)
+static inline abi_ulong target_shmlba(const CPUMIPSState *env)
 {
     return 0x40000;
 }
diff --git a/linux-user/mips64/target_syscall.h b/linux-user/mips64/target_syscall.h
index 358dc2d64c9..c4d54bda1d6 100644
--- a/linux-user/mips64/target_syscall.h
+++ b/linux-user/mips64/target_syscall.h
@@ -27,7 +27,7 @@ struct target_pt_regs {
 
 #define TARGET_FORCE_SHMLBA
 
-static inline abi_ulong target_shmlba(CPUMIPSState *env)
+static inline abi_ulong target_shmlba(const CPUMIPSState *env)
 {
     return 0x40000;
 }
diff --git a/linux-user/sh4/target_syscall.h b/linux-user/sh4/target_syscall.h
index 148398855df..8fd504fff1b 100644
--- a/linux-user/sh4/target_syscall.h
+++ b/linux-user/sh4/target_syscall.h
@@ -21,7 +21,7 @@ struct target_pt_regs {
 
 #define TARGET_FORCE_SHMLBA
 
-static inline abi_ulong target_shmlba(CPUSH4State *env)
+static inline abi_ulong target_shmlba(const CPUSH4State *env)
 {
     return 0x4000;
 }
diff --git a/linux-user/sparc/target_syscall.h b/linux-user/sparc/target_syscall.h
index e4211653574..6ab47102045 100644
--- a/linux-user/sparc/target_syscall.h
+++ b/linux-user/sparc/target_syscall.h
@@ -45,7 +45,7 @@ struct target_pt_regs {
  */
 #define TARGET_FORCE_SHMLBA
 
-static inline abi_ulong target_shmlba(CPUSPARCState *env)
+static inline abi_ulong target_shmlba(const CPUSPARCState *env)
 {
 #ifdef TARGET_SPARC64
     return MAX(TARGET_PAGE_SIZE, 16 * 1024);
-- 
2.47.1


