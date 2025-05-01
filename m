Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3815FC3ABA9
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 06:30:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uANLb-0005U6-Rg; Thu, 01 May 2025 02:24:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uANL4-0005Bg-N5
 for qemu-devel@nongnu.org; Thu, 01 May 2025 02:24:10 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uANL1-00077x-H3
 for qemu-devel@nongnu.org; Thu, 01 May 2025 02:24:06 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-7398d65476eso542031b3a.1
 for <qemu-devel@nongnu.org>; Wed, 30 Apr 2025 23:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746080642; x=1746685442; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Emf7r2NlJCGBegzvSaP4+YNHnVcvC5KK1KGZi+oKRes=;
 b=TBVRwO12Spu3YNCTei6AcUlZxEfkU+FFr/cYrVeL3qj9WQCA0/VjcR4QqS+s5DPAZO
 x++9m/C6Q/PupS53g7/cNANeGz+YlrFwRlrWOGqtR3AZLE9d2/bsKe2/eJPUhpGJfbjE
 t/uk1Qz1OPlKBy3W45fXD3OAQ2On8yWvHw6Bs9SYGUQhF4+msIfRGFBDgXeWEDg3G6g+
 J264etq/uPkBSBQEJbP8PIocPJXYtD/wBHwxZZ67jrRWGp7Pa2L6JYvfqzWPCuynKhP+
 cXdm48GH6h4iywro3oKBVSn+UQsz0ydflVPXmRoL8s3oLybQlQ0Whu9++OGpiCng4Qbd
 EZbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746080642; x=1746685442;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Emf7r2NlJCGBegzvSaP4+YNHnVcvC5KK1KGZi+oKRes=;
 b=W/Rwqe2rQep9CaAgV3Vxc+AI7rKcoHPEia6vseifWwQq6Tv0RjOMeNwU8ay9Qp370v
 FGJP48EQ/lNZjIgyoq4lQZJLdI8C5UwVQNKLCTYr6gkM7hUBoPJuPhaWV3ZXHMMKMiCc
 8tmu/lh2aSLhXArPOEMNLXqBcLME2vtwW5jjhAQq28+mXlDydD4SL2HjmZYLPh4dmXGt
 pOoGWnpFM0FPyqsHjG3pN2xOEKW/H0sy1xxUXNbF0W6ixnavd0ZlgUP/V+XmzTZCvh+6
 PGc+bXaBXbQ8OEz6UfOnz+nlMSpD6Py6j9odBskOV96YLFOEXoSO5hEd9af0zLIEqVyE
 s4sA==
X-Gm-Message-State: AOJu0YxAvrJ6GmbCA/+BKoUuWUhfOWnuQBIQczxgiT8ECrgs0jb766tN
 UUi7AnzeJiHCoRAj2iA9JB5Xf2iFl4r6nOAAoW6IqUdDGcOW9XmS5ZqPW46giyfECwyI9DFy+QB
 m
X-Gm-Gg: ASbGnctyc36cICYbpSVOyaR+G4HUbxImxXcam29SLZRjnCoR9DEejCnlwLfjREe0H+N
 CS0pTef2ee47qamw0Kx8ZnO3lUmC8PprYz+ctv2Rc5DhG+RD8UMaJG/yQfBJPLeyol1j99xi50d
 7ZSm1xkWCqEAh6ViEGr5f5WcdqSxZQSn0QeixhzJ+RFIt6CFT8wYaHyJk8Amt3+1D6toXcGKdd9
 Bpn4YwJRKWcHiwXtlp+IMDOTxnRb9j90VQG3oYgC3nyfZcTlR/B54jxGOa5suMYfm8KrE1Ulsqs
 FmWbyX7TuV+Bzc9xwOvRC1HK3OJWqtQY95pjPeUF
X-Google-Smtp-Source: AGHT+IE22a31367JIZHwwKpXwGfowHm8X6Fj6YHyiKmD1fh8ib1PzRjpm73hHdINL6KudHQM2Ftrww==
X-Received: by 2002:a05:6a00:2e84:b0:73d:f9d2:9c64 with SMTP id
 d2e1a72fcca58-7404946fbd5mr1830280b3a.10.1746080642040; 
 Wed, 30 Apr 2025 23:24:02 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7404f9fed21sm108134b3a.93.2025.04.30.23.24.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Apr 2025 23:24:01 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 richard.henderson@linaro.org, alex.bennee@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>, anjo@rev.ng,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 12/33] target/arm/cpu32-stubs.c: compile file twice (user,
 system)
Date: Wed, 30 Apr 2025 23:23:23 -0700
Message-ID: <20250501062344.2526061-13-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250501062344.2526061-1-pierrick.bouvier@linaro.org>
References: <20250501062344.2526061-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42f.google.com
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


