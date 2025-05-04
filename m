Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26DDBC369DC
	for <qemu-devel@archiver.kernel.org>; Sun,  4 May 2025 05:36:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBRv1-000275-Be; Sun, 04 May 2025 01:29:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBRux-000248-84
 for qemu-devel@nongnu.org; Sun, 04 May 2025 01:29:35 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBRuv-0004KJ-6V
 for qemu-devel@nongnu.org; Sun, 04 May 2025 01:29:34 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-7398d65476eso2737985b3a.1
 for <qemu-devel@nongnu.org>; Sat, 03 May 2025 22:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746336572; x=1746941372; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Emf7r2NlJCGBegzvSaP4+YNHnVcvC5KK1KGZi+oKRes=;
 b=fyMwrqFsApOWNTo/JCNOm2OoYSLfzGsEYznf5/8Bwf1Nm9/SjKNVhIlslaJPmQn+pv
 HlzfxBUIS/fgzyKOwcaZk5Fs4Fwry68sVGvjiVlSQMw0QGN84xUFwePG4EYBi5K7euMj
 StBNkE8IWeMFwwq/vHLPOXqzo/WfwVGksk416b+tOV2uxBGbElfji0Ztk4qBrrRu8lPu
 lRVfw4eU966ygIteWusopV5mxyirPazS3tYoCVg96QZv44CMQUPW5OkKx+jCKpACGPUh
 4QM3e/lU71F1BWf/DoiVGBq9N0iuQMzCJmaqXI4sfc1l51jg12eGzymzTDTSkHSY27gk
 WNkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746336572; x=1746941372;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Emf7r2NlJCGBegzvSaP4+YNHnVcvC5KK1KGZi+oKRes=;
 b=ks25HnUvJiR/P5VG/Alho1Oh9i8TRgkrgs7U+2NMc23hCzi7BkbMiIh6HLjo9/YGnq
 GR+9R7AOA3ABIxfHjxMMT5UHhrZR/EZsan3isCleXQbKxwUNWOiIJIWiG5OF385xWSNS
 R6P4v7ToOZRc80A+isH3J7N7mFxEEuq6SmVJ8PFcYP+H+SCIWPWW2XowGZeyr0zMHQ0b
 I3LZOUTLw4UvwaxLlLptj/7ZSz/T7VKmwsWZL/kUGqPxk7EhPdzN9n3XTFlthR2HsYfI
 hBYnTQI049wYVPWO1sT2Z5Uwzqubn2J61yuK7QGn0IvbNBea7oI0/QyXTlczBsPrtj9x
 BquQ==
X-Gm-Message-State: AOJu0YzX8Pw89L9Cg7S9uwG89E7a8raoldDYV5qyxwKIkV5ik79gcl/p
 1Tc8+m7lOGpCGvje4OPmVZzVxvXBlqxep3yrZ31pGGj2iDeT9sZIMhC0EkKpDBAu2WCsb2YGmNG
 00kw=
X-Gm-Gg: ASbGncuqaY5UE8KIlLRkw3oqrb0tIRmxqBDIZ8UahVkFQZY6kkZLQk3I9O2U56fQoVT
 JD1diRDL6ua+NsfXgLhfmu4m8NPtzhGetOMs/0uXGzdYBjxQAkc3f5NQD4NhFYH9son95TugwZ+
 Bl2tIulFK3RNF6tNhriiAl1zuKZZG12ASxzdUTqktCruQj8PIvpR8KMHN01JXkRk6H3OCw2xJBh
 j5LSdyBXlvq+fPg8RQ0wrXM05W4wT623oCBfRPi9Il4yavK+jiQEFQT6z++CZ6iELr0AbRffyiU
 VFgtjjdDjbqA7eiNwUFg/WA2Im/SGXaPzXoMi+8m
X-Google-Smtp-Source: AGHT+IH252EWjnH5DLBOIaSkYHKk6fED8pkBcv5fssuzsDnYonZrqjLHB+BuPp4SpV0ym3S7HAaCVw==
X-Received: by 2002:aa7:9311:0:b0:736:bced:f4cf with SMTP id
 d2e1a72fcca58-7405798f929mr14072441b3a.0.1746336571700; 
 Sat, 03 May 2025 22:29:31 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-740590207e3sm4400511b3a.94.2025.05.03.22.29.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 May 2025 22:29:31 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org, anjo@rev.ng,
 kvm@vger.kernel.org, richard.henderson@linaro.org,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 alex.bennee@linaro.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v4 13/40] target/arm/cpu32-stubs.c: compile file twice (user,
 system)
Date: Sat,  3 May 2025 22:28:47 -0700
Message-ID: <20250504052914.3525365-14-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250504052914.3525365-1-pierrick.bouvier@linaro.org>
References: <20250504052914.3525365-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x433.google.com
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

It could be squashed with commit introducing it, but I would prefer to
introduce target/arm/cpu.c first.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/meson.build | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/target/arm/meson.build b/target/arm/meson.build
index 89e305eb56a..de214fe5d56 100644
--- a/target/arm/meson.build
+++ b/target/arm/meson.build
@@ -11,13 +11,9 @@ arm_ss.add(zlib)
 arm_ss.add(when: 'CONFIG_KVM', if_true: files('hyp_gdbstub.c', 'kvm.c'), if_false: files('kvm-stub.c'))
 arm_ss.add(when: 'CONFIG_HVF', if_true: files('hyp_gdbstub.c'))
 
-arm_ss.add(when: 'TARGET_AARCH64',
-  if_true: files(
-    'cpu64.c',
-    'gdbstub64.c'),
-  if_false: files(
-    'cpu32-stubs.c'),
-)
+arm_ss.add(when: 'TARGET_AARCH64', if_true: files(
+  'cpu64.c',
+  'gdbstub64.c'))
 
 arm_system_ss = ss.source_set()
 arm_common_system_ss = ss.source_set()
@@ -32,8 +28,12 @@ arm_system_ss.add(files(
 
 arm_user_ss = ss.source_set()
 arm_user_ss.add(files('cpu.c'))
+arm_user_ss.add(when: 'TARGET_AARCH64', if_false: files(
+  'cpu32-stubs.c'))
 
 arm_common_system_ss.add(files('cpu.c'), capstone)
+arm_common_system_ss.add(when: 'TARGET_AARCH64', if_false: files(
+  'cpu32-stubs.c'))
 
 subdir('hvf')
 
-- 
2.47.2


