Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14BDCC369CB
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 05:02:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9d6w-0001WE-B3; Tue, 29 Apr 2025 01:02:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u9d57-0007o6-Mh
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 01:00:35 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u9d54-00062P-DX
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 01:00:33 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2295d78b45cso79682125ad.0
 for <qemu-devel@nongnu.org>; Mon, 28 Apr 2025 22:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745902827; x=1746507627; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k54PyA3qe+UbX4AzHMockqDzIGWdHV1GUXIbKPo2M9I=;
 b=lMD/JuApbxFv09LVnqJJsWusb+FRJqLAG+ZYJrD5Y21t1L+/mgq5+2v7CtbKydMfln
 AnnVAOalgRTprWUxoHX+eXJnwQTWyGHTmi9FuSGyjSy/DkFWd4nK6mvvw7AUBo7ylElZ
 oNJ3GlhFX1HEq+wUo3ayyi9DX0xGP/zXWVAYkYDl7e5NHxztjX3Ybyadj+vywaLAEWGU
 t2x6ntapqY2WeEI8GP0hg3m0nmPR/l9V0h/DHiAmn1UaM4xq/dAr0XNqf99fna/hP6RM
 pscL9//UbZ5aX0Rk7rNnhQwMb/xDiCcNQC/WZexcnWtFSYaphkrJ2z4mHVCcQGk6+Aps
 PIYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745902827; x=1746507627;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k54PyA3qe+UbX4AzHMockqDzIGWdHV1GUXIbKPo2M9I=;
 b=ismRluAlm235jnzaW83k4gvsoaSRQAPcVeQnip9D0YJSsF5JbArlY5osHvQppjns+x
 E+lHJeoTAhzZ8RMvviPmChHI9DjgM+1o8w2+++fxHDA/Q5yo/l6L3jTDu8m3QTlfDzCA
 xKknHuVgRy8CV3saCtyc5pM/gev4Og/eL9MdXDpsFKvNc/Wnc4APVPDK4ypQnifE/8kT
 mskF/mPBUFwdkRHLSnUwVnKsO8MT5O9DDQbkWVlWnJjcyfrWzKZdOyWyhs2Z2Ix3u2nd
 QU8dptxcVW6C7TrPA3uaH8TmSxknJa1TkejYlmQcFf9OQlda/sxvTPqLw6KQZ/Dh/Xm1
 mVfg==
X-Gm-Message-State: AOJu0YyiLwoYhxv9r1LHFxV/UNNrCCnlEjccFQuXmk0SVS4TQMBLxrhs
 /nNtbAct12V+3pIvfpoO0FriRwfqUjwkLY2hL/rsl6SodSXrsJa1QfzAvI+OzpNZj70VAnUi438
 L
X-Gm-Gg: ASbGncuVSEHRFOdRA9qiCuZzGILA3v2GXR33vVwJNb6J++ExkBMKTOonp3ptzf3+kt1
 hw9KbqzeVViIB0WXn9wIzeSvKsmm+mb8hmrMdSHB5h5XdRsIWGHGlCg2MEWgmr2gyqn2sCWUl5H
 yFUMp+W9xNll477wrwWF/18YWH0k9T7EhMcO0a8qMQicaIkVGFdFSXgU5DnDhLkcATuhunmiNcI
 ODoYO4T/Hm9kaoZZq94uKTQw+pw/geTNkMAZMVg2WJo1O150v/okprD5jESXwhxvgZqWsv6JlDe
 D1l5ggzW0xA5hkl917KqHl6G0gtZUJa+whRQnUfp
X-Google-Smtp-Source: AGHT+IGBsvYnMwHnQTWjvEkq+70PORjBWNX+JNL7swJfV4JLCjXOenAAVaroor531SGQHMVm8lxvuw==
X-Received: by 2002:a17:903:3c47:b0:216:3c36:69a7 with SMTP id
 d9443c01a7336-22dc6a8744bmr177357855ad.45.1745902827034; 
 Mon, 28 Apr 2025 22:00:27 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22db4dbd6f7sm93004015ad.76.2025.04.28.22.00.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Apr 2025 22:00:26 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, kvm@vger.kernel.org,
 alex.bennee@linaro.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, anjo@rev.ng, richard.henderson@linaro.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 12/13] target/arm/cpu: compile file twice (user, system) only
Date: Mon, 28 Apr 2025 22:00:09 -0700
Message-ID: <20250429050010.971128-13-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250429050010.971128-1-pierrick.bouvier@linaro.org>
References: <20250429050010.971128-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62a.google.com
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
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
2.47.2


