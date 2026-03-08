Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B8F3EA8543
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2026 22:36:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzMjM-0003EH-1K; Sun, 08 Mar 2026 18:36:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzMjJ-0003Bj-OK
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 18:36:09 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzMjH-0003ML-Dv
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 18:36:09 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-4327790c4e9so8465628f8f.2
 for <qemu-devel@nongnu.org>; Sun, 08 Mar 2026 15:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773009365; x=1773614165; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=t4eGZ6Wov9vgJTgXJvaXO5cQavtM/WJnNpf+PFgt2X4=;
 b=yG7Zkfd1PfB26gSBMzX8PkTG+WSOdhT3Hn0DVZXqJyLZfPCep0GhTGl/8RG+rb7Ksl
 B7CuesFl8XwU78w5B0z2AliFJySr68EPb34zA+bBrxsB6OOS7n5Puuf+3zKxTROCOU9j
 ozEhaff1qYZmIuVn1j+9dpZLPSUCerGvuB8Om7i6l9zHAXFltkN+igO93j3SwdG6ACOm
 Snwv53DJ1v1XMa2pXlcrr2sKpyTVwie5hxFuJJ8KtfcrmlpcfM4jG2352E88S6+YWHT3
 oXpoPd5RasbyYRuUDMCmF0JN1iBWb2ne7fHh8GnLKvfOY1LyssppIKH+r70csCWREX8G
 st5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773009365; x=1773614165;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=t4eGZ6Wov9vgJTgXJvaXO5cQavtM/WJnNpf+PFgt2X4=;
 b=HZCXmyASGot4KKIZ5Fh1dToiBl+yDPBw7xnGqCN0vc0MBi/hbYiibvxjLmq3MydLv/
 NoU0oL8OoNUqeGDKBXgcdLhLN12sIZAd9NB6x8dZA6f0MtUSydDjaD+ojrptagNzmi7S
 /J/hZAYFFLp/v/f4rVfQUUxNXXC6Ti9TY5Ew+pK1vOj+MIjtbhAD9+uXsVYTRYQGOFDT
 UQfbPkdce4nHE0RPp4Ece/JIfw+fxwLDHjLz+m9qhhOkO34CGXwrbquvWmKEkpka8BM0
 bpqZNcr6c1Y3mn62xw/EsOuHJac97z44/kl2JbvOtHGciOOwbgnP3pd5ttYpH9jnSkDd
 pg5Q==
X-Gm-Message-State: AOJu0YwZ3fBj82C/kVw6r1E0/CaMRz+NK+Adnqn4CORLOtbt1mgvz1cZ
 7sPqFyFosto0KmgdfHi1ak0+CzZOoq8L88CQt6L0IFrxyxrVPENwxMDPSe3fBOK3aAd8TaKlZ0Z
 e8wfh0i4=
X-Gm-Gg: ATEYQzzToF/2jcSykIhvul5hnbOhPkkq2ZWB1cFU8sEv7j6tOzdsbe3xzUeFoWekGOU
 M+b/MrYZMcrLI400BvKtYkyEAyvU2vm3agTrZS1KDxEMoxN+E5xu5P9f4TZ7I5KMG7l663dNX71
 y1eQSEIZW+++Kbbp/vGE7CBYfAUoKdQk7nqXi+ObmFBw/hCctoSmwH3sKiKKcsPzBRIKodz/2xH
 Gvl5LTdSRyTCv+fItLsU9uCEKPkoz92t4WtLi4YOcPbB2JwJkDPIdK2EmOGGxx063K6pTR74Dee
 CC5+1Wac0WamAxfbPf3aojBzGvzL+lRm3OePvI0n47zy0olUYwCrWGf0PgevbFX7z6o/iUglbB8
 P+SFNas9rdqaAMCf2hy9BkNTu+QUzCw2DbyPRpy7kIGhaDCbmHQqWcjaMhqp1LCKn8/DzihFGIZ
 G1vwOzD1Kjri4cYqc4M+C/QOqxK+L8quxqs+B/b8qvYyLRRaZSSFwtM3KQQni4Dkmt+LNZaF3HI
 sRH+Q==
X-Received: by 2002:a05:600c:4752:b0:480:4a8f:2d5c with SMTP id
 5b1f17b1804b1-4852697721cmr157502685e9.29.1773009365207; 
 Sun, 08 Mar 2026 15:36:05 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-485237e8095sm127662315e9.2.2026.03.08.15.36.02
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 08 Mar 2026 15:36:03 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 13/49] semihosting: Build stubs once
Date: Sun,  8 Mar 2026 23:33:57 +0100
Message-ID: <20260308223433.25503-14-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260308223433.25503-1-philmd@linaro.org>
References: <20260308223433.25503-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

Move stubs to the global stub_ss[] source set. These files
are now built once for all binaries, instead of one time
per system binary.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20260225035739.42848-12-philmd@linaro.org>
---
 semihosting/meson.build | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/semihosting/meson.build b/semihosting/meson.build
index 99f10e2e2bb..15e3be26989 100644
--- a/semihosting/meson.build
+++ b/semihosting/meson.build
@@ -1,4 +1,4 @@
-common_ss.add(when: 'CONFIG_SEMIHOSTING', if_false: files('stubs-all.c'))
+stub_ss.add(files('stubs-all.c'))
 user_ss.add(when: 'CONFIG_SEMIHOSTING', if_true: files(
   'user.c',
   'guestfd.c'))
@@ -8,12 +8,13 @@ system_ss.add(when: 'CONFIG_SEMIHOSTING', if_true: files(
   'guestfd.c',
   'uaccess.c',
   'syscalls.c',
-), if_false: files(
+))
+stub_ss.add(files(
   'stubs-system.c',
 ))
 system_ss.add(when: 'CONFIG_ARM_COMPATIBLE_SEMIHOSTING',
-  if_true: files('arm-compat-semi.c'),
-  if_false: files('arm-compat-semi-stub.c'))
+  if_true: files('arm-compat-semi.c'))
+stub_ss.add(files('arm-compat-semi-stub.c'))
 
 specific_ss.add(when: ['CONFIG_SEMIHOSTING', 'CONFIG_USER_ONLY'],
                 if_true: files('syscalls.c'))
-- 
2.53.0


