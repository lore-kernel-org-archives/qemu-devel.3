Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05072D29DE7
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 19:41:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfkFq-0002tB-M2; Tue, 13 Jan 2026 14:40:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vfkFo-0002rJ-Ee
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 14:40:36 -0500
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vfkFm-0003l1-QQ
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 14:40:36 -0500
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-81f4f4d4822so1280067b3a.3
 for <qemu-devel@nongnu.org>; Tue, 13 Jan 2026 11:40:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768333232; x=1768938032; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=441dD7EwIt/lzGqbhDRbBDkSJ4comyNgrz4qp24vxc8=;
 b=ngDo0Ipzwemnnd6TdRdi9NQhvH5a0heD0QIrj2ph96Q9LCiSeZv1xtVy8fyGCpDO7t
 XqrEqTNlmRqK4SVc7qv/47v17rTJR1GGcQavn0tVceMZa+CpKegcpHz4gm5vIm+Crwgt
 Bl8pkG3Blye1EzVsGNGLHyTfDD4u9hOl4k7+gXkoGozgqoRczz9KrKAPCpvpNbCI7yda
 hQHCI8jXxP1aW+R01aRG1pbOlrT/TDaXUyEZGpRcWFajoxz/70qan0mIWu1e4FMfkHDM
 /3TcrDa12Li9h1Zsyw1cBpdb2JcRGLvSIwQAYKCTuVaw9itrVKQxlQv71VXUr02CTql3
 QEKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768333232; x=1768938032;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=441dD7EwIt/lzGqbhDRbBDkSJ4comyNgrz4qp24vxc8=;
 b=MU6WatYcAn7JxGIfrXWlosXAENPGdaPyORhDkUbI/slSU8rSlwN7ypM/WoVnOzlQRR
 w7J/ELl2ymu6wfKPTYw6Z+FGqXSvCRAV86BK52UDzq+GvcG2BUBY+n1kOuoSOTKAOOy0
 ZoWvx7x95/gCSwVlht8n9LflAivyxMf05TlkIeMFgySRGunxSqikRkuORL13OI35CKT+
 2wris8A7v+hczmdM/2VvyJlsutik4GycA9Dra/Jb7OxtQbIbeAMuyN9sjbUpfu/Bvvei
 sTFmylQLDjTsmztKQSs3XOc9B7+wjhJ5mRdjjdUy+a0BGKNlNarEbqLwUUdoRl+fTX6i
 zJUQ==
X-Gm-Message-State: AOJu0YxCJxBWKGo30MzKiQpFYCadd8j1v6B0wSaXxRs4XC9PtoZW115E
 +f75quKOYcGyrsWif4XL/naSCcGxY80eFkpKzw9hDPUMDDvrUiUhFFmEB8cxALQq7aI7Mycr947
 +bxMiCNE=
X-Gm-Gg: AY/fxX4H8kbB0saaMdDzeDKC+N2R6FcuhGQ/xjaTdmzWuYVeOw6B1mFydoxhHasTBEu
 Yq8q418S63GlTzKBo9DYw1fXupmG6MyNw7XjRNlDuyHePe4gcw/xJxnip2VgjZjgNdBBiMjDPIB
 1ez2yPq05sPTrQthAyYuCJ62rONAH7BPxh4zQdVgX7k4qyj34IHVSE3ASrjPB1LkWFsRIE7G5EI
 F2I71gF4deg/M6iyFGdylpF+M31ZbyxaidGsrhUz0grn0N39Yc3Bj4jipc2aaYG3n5La6rnKJss
 JC7E3g+Xqx8UdC+8k+ilSo0pMR83xo4wywbphuyjAEt6jeD9Cuji8n9ym2CibNHfnGI9fgJ9ker
 esbxLLaBig//AGGQhPJwLMlDCJUdcpfrrJxrvGPlk+jSY8P6MdDEHSC46bEyLFwV445thVlht4a
 vq7tacsiTJhp4Lj7HWdYrjN3CKYNuYY2UjFM+9c0Iv7hz+Sj3nh2/13tVbjkyIZ7hY
X-Received: by 2002:a05:6a00:4502:b0:81f:3fbd:ccf with SMTP id
 d2e1a72fcca58-81f81d37a5cmr26300b3a.23.1768333232268; 
 Tue, 13 Jan 2026 11:40:32 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-81f73c27d18sm2604234b3a.46.2026.01.13.11.40.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jan 2026 11:40:31 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Phil=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>, alex.bennee@linaro.org,
 Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH] linux-user/aarch64/target_fcntl.h: add missing
 TARGET_O_LARGEFILE definition
Date: Tue, 13 Jan 2026 11:40:29 -0800
Message-ID: <20260113194029.1691393-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42c.google.com
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

This caused a failure with program using openat2, where O_LARGEFILE was
replaced by O_NOFOLLOW.
This issue is only visible when QEMU is compiled with musl libc, where
O_LARGEFILE is different from 0 (vs glibc).

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3262
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 linux-user/aarch64/target_fcntl.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/linux-user/aarch64/target_fcntl.h b/linux-user/aarch64/target_fcntl.h
index efdf6e5f058..55ab788a7ce 100644
--- a/linux-user/aarch64/target_fcntl.h
+++ b/linux-user/aarch64/target_fcntl.h
@@ -11,6 +11,7 @@
 #define TARGET_O_DIRECTORY      040000 /* must be a directory */
 #define TARGET_O_NOFOLLOW      0100000 /* don't follow links */
 #define TARGET_O_DIRECT        0200000 /* direct disk access hint */
+#define TARGET_O_LARGEFILE     0400000
 
 #include "../generic/fcntl.h"
 #endif
-- 
2.47.3


