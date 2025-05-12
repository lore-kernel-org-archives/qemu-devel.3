Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F90FC3ABCB
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 18:24:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEXXL-00038k-T4; Mon, 12 May 2025 14:05:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uEXWp-0002RK-6B
 for qemu-devel@nongnu.org; Mon, 12 May 2025 14:05:30 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uEXWl-0008U9-Jq
 for qemu-devel@nongnu.org; Mon, 12 May 2025 14:05:26 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-22e730c05ddso43218085ad.2
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 11:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747073122; x=1747677922; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Emf7r2NlJCGBegzvSaP4+YNHnVcvC5KK1KGZi+oKRes=;
 b=KitpuzGAx7ZnGnt9PeFEuu4ruxr7SWQ8C94LhZAAeZJ7Q1mFhuOIIszAt8J1b1cYrQ
 sAgBw8N8plyUSFcddSmWgtMpPMWag24M8S5XVlDFTUDW2d45fahVWSxRo85ZpU4sRC2R
 cq1gZp/JIuDRtnUT0zqUUTGRY5tqqwb7+vl7kyvCT0uSiS25HXUGjJihM1gHUaJ0uQcB
 j/awns1jRq9vHgwQUy6gjscYSynMdA+KxwqPDI2hgfPjXeoEjiWXtbsdryBD/4gbiSnw
 lEIrixc4ZAcoOeSXOCjohFd2tEPdrNZIyPfriZmj0/qYzaCZJTI1LwWHDCrVg0LJV97Y
 2dbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747073122; x=1747677922;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Emf7r2NlJCGBegzvSaP4+YNHnVcvC5KK1KGZi+oKRes=;
 b=EebYtfua3uO7ZfrFFksN9abSHJHTbHLRUXQGUBYDYH+yNlwsyY7USm894j9f9QSWzf
 bI/zp3+cim2dNEDGuo0T4DW/+GOKlelwd/FALe3yE0yrEBBRod3NC039wUX+GAOK4Kj3
 nlCVGqURGSIaVjkN9VvQYctwAMRgo0tJi5/sLlD14SNSef6vpFzfMyo5XAqIVT70sMuQ
 8yepiJcg7vomqVA4PG1oG9xseTHt8KEiLhBr/cpVtCXKIIkdLuHVAKnKOR9nguiaqPbe
 0bV5iLxvHERiqy2GOakIPg9JRPJJr0A8NdZkQQgO/3xd4W4u9EJFFXGzzuO29LU/Hwe9
 cLWg==
X-Gm-Message-State: AOJu0YxZA2nvCyVJVq1mWqKTZ+kMQyMZUXRG4FRnz2cgq+HO9B5j3TDY
 Dh31T3gsr9o7CfpBd9zkHBLN5Kvgs9WHPoQYnLllRDaW7+Y1hlyrWB1yxejDD7BzQM90nWKsD9v
 g
X-Gm-Gg: ASbGnct8CJ0VQQkn9mYwzrcXYDmwAdYkYeweI3hJHCk1AqaiAyQKaZCz2tRzsnGb7Cn
 nXxNeodg7Bb4Eo9saM6yKLZnNefAxT4RmM1ph49IDfpv+V2/jd1pdLeeiP1c5nGiO9NGyc0XcXu
 6gLGHmu+CrQxq2/HfzZdS6cpQmmLqVCq+9SI5w4/anh1gfDjeiM+39Q6vmPpJZ1hmA1T2hZ8146
 Mwqj9z5JrRiY7KUt1ThDJknbTDHCKxX2q/gUJEZqm53Q8LPNzJv44NfXOZgeSrLxt9BqaJjZihi
 uIRxD7XEtOooZz4Du2QdtigVMc9mgV1sB85j03VFcT8c7iOdmfY=
X-Google-Smtp-Source: AGHT+IHpKFuSCTSiVQdUzZhZS6mF5YhbOhklGnyzh6uu2TTMvgGfDj0vX8tWLok7xquOCnqAQWr5kw==
X-Received: by 2002:a17:903:186:b0:224:c46:d162 with SMTP id
 d9443c01a7336-22fc8b3d8b2mr169123125ad.20.1747073121680; 
 Mon, 12 May 2025 11:05:21 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22fc82a2e4fsm65792005ad.232.2025.05.12.11.05.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 May 2025 11:05:21 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org, alex.bennee@linaro.org, anjo@rev.ng,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v8 11/48] target/arm/cpu32-stubs.c: compile file twice (user,
 system)
Date: Mon, 12 May 2025 11:04:25 -0700
Message-ID: <20250512180502.2395029-12-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250512180502.2395029-1-pierrick.bouvier@linaro.org>
References: <20250512180502.2395029-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


