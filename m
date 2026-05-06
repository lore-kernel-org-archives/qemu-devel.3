Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05F0FCD3440
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 14:09:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKcuN-0008Gv-23; Wed, 06 May 2026 10:07:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKct7-0005Yl-QG
 for qemu-devel@nongnu.org; Wed, 06 May 2026 10:06:11 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKct5-0001l6-Oo
 for qemu-devel@nongnu.org; Wed, 06 May 2026 10:06:09 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-48334ee0aeaso46487695e9.1
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 07:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778076365; x=1778681165; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Q7JoIcCA8qNl17AS9UcDFI607F3aol8TFPBvdZnjpeQ=;
 b=PUXKEuhrhIfhQbKuDCjLKSwMmJngAFsOX0zXH8Uy8CDk6yNFXXs2Mza1oMMsh95N7m
 efyGon2yxNJFWEqW8Fk/2IZpIbBzVqz5h03fTHWU0R5qWUR/l5Rx8H+XdEZje4G2iGZ1
 X8L530CSZZR+5IPs8pP4ciAIvyzCuCEKQ6BIB7OSRy0VruWppVZtm+xKio1j1m0Yf1R+
 xDQU/iCT8Ig4g/KxAq0s2JWQWJ4sfpCa2SonaotMckTyxAIlgqNh+iHwsPd/L3g1BD54
 qZ+2d2GU6uZUyeYUwnCA2uGImpesFYMfXNjpQof60sVc4GOX6kTH5ncf3uVgbplvj5Of
 Gs1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778076365; x=1778681165;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Q7JoIcCA8qNl17AS9UcDFI607F3aol8TFPBvdZnjpeQ=;
 b=BYTV+XxngNNQPjUbTTmkSDDpN7S1CwjG+dEwl96QwaIyWRFwkfOEWMJ7q4yuaGhYvo
 8JZQISgDfugb0J0CUocAJLy5pEvHa3gLWDUzCOVNyFepUrwLddxk8XuJOwCLOdpdZn66
 b7NAaVJdHJiiY6is0njHbevYeybsUBqbpIi9o5fM5EzFw60MJyQ/ehEJtwUK3NhMRWzD
 I6FdFugL8y/dImz6dyr7zW6eYfmaj2pXqLhMUxePKsiyEWblRi+sQZzE/DR4BFuDIH2G
 3pIWEO0trBJPqh4arcmS7pZhhI2ul+W4P58T7aHgsHhkatQ8e4oI5Zj0kz+95FnwbOID
 0Rxw==
X-Gm-Message-State: AOJu0Yyo84LYogWNWFoDiziCPcOGYxuxWyPVbI4/phR5GBgWtS6afItd
 lCHld79MFpFDLKYoKQAGVkSPp5/l4oeJRoJ4i2YLOqDyzELdkRjBxfWfPppDLcaqwyvkP5vtb22
 LKNhWjVE=
X-Gm-Gg: AeBDieuqLSn3jKBmp+imB+LrCDqtvSiDda+JjXP0ndOIDroCbes3B5MYtWA93Z1Tshz
 BVbIz+2BKomwbOJYjtCwKxTlBYtqwsZGH6/XZQ3QP7xWqtXaXy+ABY0mgxNyKmmw/Y+OW/F3/Sv
 uX4i7nB20ZB+Rf1sfJR+1LEiQGKTboKigkwascV28iJLanwY9wFwgDZNyy5FaCwOXeY5uRQyLy9
 d0LEX7s32jS6NfYTxj+UZ8b8Ao8P360V5FKDeBQ9iNtWL+1JxzyTzlSDs8lzc+GqkqeIrKjo2xL
 NbzTHLYsSfIIb1SttBXDqPqZK1dLPOgN3MKYCU1gwvQnqOYLEY6MlUceD9Wt8WFfaGhU7MzVOQm
 nZSPhXLX/hJuCNPZzORa2s/AbRO7psC6XHsIuF17Qobn3CItcWQTiGQASb0+yJBqxbpSJrAJF9Q
 usrClp7Mq0LjrLk8Ol4HemOvlcW/yNpi6CvyIaY599SJ2hBCv9DyWEdkys2P6w9nJf0WcmBV2tl
 4Rj6IPe7eE=
X-Received: by 2002:a05:600c:b8a:b0:48a:56de:d620 with SMTP id
 5b1f17b1804b1-48e51f32ac3mr65522115e9.14.1778076364501; 
 Wed, 06 May 2026 07:06:04 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e538bc9bdsm60504185e9.11.2026.05.06.07.06.02
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 06 May 2026 07:06:02 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 081/110] target/microblaze: Fix endianness used to disassemble
Date: Wed,  6 May 2026 15:54:53 +0200
Message-ID: <20260506135524.20617-82-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260506135524.20617-1-philmd@linaro.org>
References: <20260506135524.20617-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

MicroBlaze CPU model has a "little-endian" property, pointing to
the @endi internal field. Commit c36ec3a9655 ("hw/microblaze:
Explicit CPU endianness") took care of having all MicroBlaze
boards with an explicit default endianness (similarly with
commit 91fc6d8101d for linux-user binaries), so later commit
415aae543ed ("target/microblaze: Consider endianness while
translating code") could infer the endianness at runtime from
the @endi field, and not a compile time via the TARGET_BIG_ENDIAN
definition. Doing so, we forgot to propagate that runtime change
to the disassemble_info structure. Do it now to display the
opcodes in correct endianness order.

Cc: qemu-stable@nongnu.org
Fixes: 415aae543ed ("target/microblaze: Consider endianness while translating code")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-Id: <20260423100612.27278-3-philmd@linaro.org>
---
 target/microblaze/cpu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index ec513ae82d4..639f46b525e 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -237,8 +237,8 @@ static void mb_disas_set_info(const CPUState *cpu, disassemble_info *info)
 {
     info->mach = bfd_arch_microblaze;
     info->print_insn = print_insn_microblaze;
-    info->endian = TARGET_BIG_ENDIAN ? BFD_ENDIAN_BIG
-                                     : BFD_ENDIAN_LITTLE;
+    info->endian = MICROBLAZE_CPU(cpu)->cfg.endi ? BFD_ENDIAN_LITTLE
+                                                 : BFD_ENDIAN_BIG;
 }
 
 static void mb_cpu_realizefn(DeviceState *dev, Error **errp)
-- 
2.53.0


