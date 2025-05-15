Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1015FC2D0CD
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 10:35:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFVnc-0005Ks-9E; Thu, 15 May 2025 06:26:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uFVn9-0004gJ-TT
 for qemu-devel@nongnu.org; Thu, 15 May 2025 06:26:20 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uFVn7-0008Aq-Q7
 for qemu-devel@nongnu.org; Thu, 15 May 2025 06:26:19 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43d04dc73b7so8012725e9.3
 for <qemu-devel@nongnu.org>; Thu, 15 May 2025 03:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747304776; x=1747909576; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5iuDbPPf5lEYT71cv+B0giQZmGA3HvyTgZbPr6A9ErE=;
 b=soKSFVKxFAS+oKZMe6UoBJ9H2LvmWRB9THjpCl23OLOVbh+4JDxnnikwz9OXoVCTc3
 4OtsPU8bZX7qQ+GJEyAsTh9cjp0hvwNZTGW9GWEkCbQ/F3D5yP6BmflwH9Lp04Lx5GzN
 WrVuUjSKvtDujtsM12cLS/nogiQvKuQ3gWdgAglLiEzGv/ASRv+WdlNBf/5gSfqvHmfx
 F33fFEUeV9IQE4NBxdeswoTzAcX+bg2j9idLlVQWKIsVNyrI+dknuqVu6Fq3fAPvbzIN
 VgFsLttNjplaU6tluAeDkE1CINiZWOnhvmiiiBWKl9jGhDzESYzqJHuZ2YWscfaqcFfk
 elow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747304776; x=1747909576;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5iuDbPPf5lEYT71cv+B0giQZmGA3HvyTgZbPr6A9ErE=;
 b=NZCPkf/2MnlTKrUmhi9Y6ECXB8W/NwN9sk/u6qeD5laQ+TuUbTePOgdlSj+hQ6gAuV
 ORvP4e/6TXI8xpDgts/j6rl8JFSVGZubZDM2Sa852oq83yXa68lxWw9Brk5Taf4AZzlw
 2HAo8+k9EIlFt0/8JF8dFdWU0UP3QSAd2JgY4JwQUb7QtI3LcRdrDjUj2/fzYGgUBRAt
 RGGY9tLDiADFo19GV1+80qZQ3V45I0Hs3qYHdShf8WaeIiwK6qGEmIPgXRxJLimGJQTq
 nzkUA17SMCNSceFOv9pfmXfEDIB1SFm0oyA7NX+6mTs5Pzx9HcIpW+D2jQR11MmtjBNJ
 wokw==
X-Gm-Message-State: AOJu0Yz8EfnZBmJvbriRd7mLvSYh6TA6ABmz35QMbYNXm7vLknl6w1z8
 tiiiFgGIVdH/68Ekk4zFP0JbCZuurTqWUO/in5m7SxBqqXEq9yuGcVwOFq9uQEtNkDqHGdkCVaw
 Sjk0=
X-Gm-Gg: ASbGnctKx72pVWi3LfQH4yP/4pdIiWdY7qqNoD6M4xGfTQbHDPZzEkjuzRugllWNEH5
 qNYgeTOAvnoWCWHnr+vrSLeqOJVwuo3uAG8ztFO/Tjuq9XtHaGv6/fblcmXW5NyNnFawgu91c/u
 fpEuGLnD5r56j++Duvh8BYSMbUFbFy54zrwqtINVB97suKsEv3OoM4Cmodw3Plr1dr+KXQt/6yS
 9KIic1EwEwvk29XrhH1aJisAFQtpNp+wvTlP3sO4NMOtNVAIZsoE3l66aYPambDUoTP+RRwcx6f
 cgfvGCfbmrtfKtzOiRN/3V/8hsA5SUkc1B1V3wBbGkUiNl7pzFMoPTqYYv90IOp1Io+V
X-Google-Smtp-Source: AGHT+IEV0tMwlzxPDPTNuMcZxDjTY0+BLUo03NL6PWpYqT35aXzCjJaKNBjywNz2bf93mI/CgoWBYg==
X-Received: by 2002:a05:600c:3483:b0:442:d9f2:c753 with SMTP id
 5b1f17b1804b1-442f21684b4mr58321475e9.26.1747304776361; 
 Thu, 15 May 2025 03:26:16 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442f396c3a4sm65657855e9.26.2025.05.15.03.26.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 May 2025 03:26:15 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 20/58] target/arm/cpu: compile file twice (user, system) only
Date: Thu, 15 May 2025 11:25:08 +0100
Message-ID: <20250515102546.2149601-21-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250515102546.2149601-1-peter.maydell@linaro.org>
References: <20250515102546.2149601-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-id: 20250512180502.2395029-11-pierrick.bouvier@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/meson.build | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/target/arm/meson.build b/target/arm/meson.build
index c39ddc4427b..89e305eb56a 100644
--- a/target/arm/meson.build
+++ b/target/arm/meson.build
@@ -1,6 +1,6 @@
 arm_ss = ss.source_set()
+arm_common_ss = ss.source_set()
 arm_ss.add(files(
-  'cpu.c',
   'debug_helper.c',
   'gdbstub.c',
   'helper.c',
@@ -20,6 +20,7 @@ arm_ss.add(when: 'TARGET_AARCH64',
 )
 
 arm_system_ss = ss.source_set()
+arm_common_system_ss = ss.source_set()
 arm_system_ss.add(files(
   'arch_dump.c',
   'arm-powerctl.c',
@@ -30,6 +31,9 @@ arm_system_ss.add(files(
 ))
 
 arm_user_ss = ss.source_set()
+arm_user_ss.add(files('cpu.c'))
+
+arm_common_system_ss.add(files('cpu.c'), capstone)
 
 subdir('hvf')
 
@@ -42,3 +46,5 @@ endif
 target_arch += {'arm': arm_ss}
 target_system_arch += {'arm': arm_system_ss}
 target_user_arch += {'arm': arm_user_ss}
+target_common_arch += {'arm': arm_common_ss}
+target_common_system_arch += {'arm': arm_common_system_ss}
-- 
2.43.0


