Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0772DC369DC
	for <qemu-devel@archiver.kernel.org>; Sun,  4 May 2025 05:31:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBRvB-0002F7-8j; Sun, 04 May 2025 01:29:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBRv4-00028r-2I
 for qemu-devel@nongnu.org; Sun, 04 May 2025 01:29:42 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBRv1-0004Mt-KY
 for qemu-devel@nongnu.org; Sun, 04 May 2025 01:29:41 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-7376dd56f8fso4681058b3a.2
 for <qemu-devel@nongnu.org>; Sat, 03 May 2025 22:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746336578; x=1746941378; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u/RowU+G9lDkd5OLEKmfnzuDeOXrVzkwWk098+SYGJQ=;
 b=cG0QFkhPb5Ae7mI6LFE07FQ5v4yPCAV+MC0oa0/S0CkFE2L716jAF8h9Fk8fH9koyx
 KO/XWBx4hLkL7EsO9jUwBSU9i5IfkcbnGXkIUimMfqmU9ecueo7oVndoxZQeKgCJ4WOb
 4joiFcMYo5LJx7mPheu3wJRYamWXHZrDFBhWbVkZbCXFnCOic8aT5rXUkrHHwvNn88B6
 UXnXCq/m+lE17Jb72JlGjkUzepiK6opN7oA6O51NfDBqtM5CLyq1wxDperNm8ZJxaw/Z
 2EFJIfvavygxDo5+AHawOYjyYdgPrW+ei8/QKRZ8tykIE/5LW8unuYu3GofR4rUmr++g
 KxYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746336578; x=1746941378;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u/RowU+G9lDkd5OLEKmfnzuDeOXrVzkwWk098+SYGJQ=;
 b=wdSiU3NIblt8DAxmbBhnTR9YI8j1eUN1SQz47J6QUs4GjZSQa0Xj1g+kMoXSvyVDV8
 glOqsK3kXkXb8RSHPfYcqxTFOtnYxnNw9FZ7/kZfoAHesM97hEdJCBtw1RAF+C/Q7Byc
 TMTZAbw7hm7/kgr87iHn0TDnkSZ9wd7RTGPF4EaJD+8n7T+Os7kNek1BxXK79d5GsD8S
 c1K9b56tvWSTEZ7YiXrcWtQNtHOebopv16lSqvhzYcRc/s6aqMJIIPzS8+GX0CghIIpy
 PJyuMGSc1kXQA4ikV9N8Zk4On07LzXl+LjGDsdKHLBrDxxTIHvrlCgHvtoMKN6JaRfYa
 twKQ==
X-Gm-Message-State: AOJu0YyPT6a5x6qa/Va8Vm+khcPa5SQi74yM1mg0/W2UkEeDFsSRXBcn
 LFHp6wR2RvysCmfyZH/ikSGL7WnDMvUo8IIhVWC4fro3ypql0cOd2SFF9xDyQiBQgJIBE4aYI5X
 2jEI=
X-Gm-Gg: ASbGnctGW5hmxUEmt9nP09GgEH0WJdBjFk2YZAIKY3ZUcNBFN82KB30NSSpY33oOYrg
 YMwauew5dKnNW2gVku/wdF+OIYSH/9IIqMaZkU8RCeVVKRw37xBn4aR+YFedzg3rCzVINC5vyEu
 jJxb+6dZCFTkDgpVSEcpnewnpe1gFQEsUXKquC+kZxvcwqnoWUbOAtBS2qeHOwIahJ+j0xmYc6K
 FpBVO/N0F0BXq7DvfRqOO4wn44H7OdaKn0P/MBWzV+gploy36miyMDZIgGOTZKjjLRobvGFYok4
 mhoPXmEUclopMA+hQH/xtpylXUKUqGRfMMuUyZ1Q
X-Google-Smtp-Source: AGHT+IFaP6D5Ew8hDYaflp+HVUummZVr2ncTgzSc1dejl9uu0i0B5hfKlcfV+xs9jmY0up0zG7JkNA==
X-Received: by 2002:a05:6a00:450a:b0:73c:3116:cf10 with SMTP id
 d2e1a72fcca58-74067443390mr6685540b3a.23.1746336577838; 
 Sat, 03 May 2025 22:29:37 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-740590207e3sm4400511b3a.94.2025.05.03.22.29.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 May 2025 22:29:37 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org, anjo@rev.ng,
 kvm@vger.kernel.org, richard.henderson@linaro.org,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 alex.bennee@linaro.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v4 20/40] target/arm/debug_helper: compile file twice (user,
 system)
Date: Sat,  3 May 2025 22:28:54 -0700
Message-ID: <20250504052914.3525365-21-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250504052914.3525365-1-pierrick.bouvier@linaro.org>
References: <20250504052914.3525365-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x432.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/meson.build | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/target/arm/meson.build b/target/arm/meson.build
index de214fe5d56..48a6bf59353 100644
--- a/target/arm/meson.build
+++ b/target/arm/meson.build
@@ -1,7 +1,6 @@
 arm_ss = ss.source_set()
 arm_common_ss = ss.source_set()
 arm_ss.add(files(
-  'debug_helper.c',
   'gdbstub.c',
   'helper.c',
   'vfp_fpscr.c',
@@ -29,11 +28,18 @@ arm_system_ss.add(files(
 arm_user_ss = ss.source_set()
 arm_user_ss.add(files('cpu.c'))
 arm_user_ss.add(when: 'TARGET_AARCH64', if_false: files(
-  'cpu32-stubs.c'))
+  'cpu32-stubs.c',
+))
+arm_user_ss.add(files(
+  'debug_helper.c',
+))
 
 arm_common_system_ss.add(files('cpu.c'), capstone)
 arm_common_system_ss.add(when: 'TARGET_AARCH64', if_false: files(
   'cpu32-stubs.c'))
+arm_common_system_ss.add(files(
+  'debug_helper.c',
+))
 
 subdir('hvf')
 
-- 
2.47.2


