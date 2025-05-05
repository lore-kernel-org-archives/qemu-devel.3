Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87034C3ABB6
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 01:56:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBl18-0004Ji-Gn; Sun, 04 May 2025 21:53:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBl0k-0003w5-PA
 for qemu-devel@nongnu.org; Sun, 04 May 2025 21:52:55 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBl0b-0002Vs-7F
 for qemu-devel@nongnu.org; Sun, 04 May 2025 21:52:49 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-736c062b1f5so3803997b3a.0
 for <qemu-devel@nongnu.org>; Sun, 04 May 2025 18:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746409960; x=1747014760; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Emf7r2NlJCGBegzvSaP4+YNHnVcvC5KK1KGZi+oKRes=;
 b=DRnw5PkaFw5m6gmsdswxRl0jF0NEaEYuUpZCgX9aw2OvDf8/ypSgrkDU3KkHpX0DZm
 YcejJ0ngTtxrVSazH0UDCbrpzKFaWuDeLkhzuP+5Dbof4XBd4zHJlH9nSO6lCN/u/paX
 EZHk3/ZaITOA83PHp6TpI3zN1O6beiMgs+UUSvRyvH9f9ic2Lbo9Ag5Ihar/FloeYCoA
 JHagkMiqlixYRzgihV2qK7d3gCvtmZKD//uprHUlkv6A/HAZuzctVNqhBDaKVJPS8SKb
 RhpVjd6tod3MeQh8wwoRT+xBdJYGGwD4if1gz9PjBl0i0O5QsA7/KNPACU+t04msHRcs
 9lVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746409960; x=1747014760;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Emf7r2NlJCGBegzvSaP4+YNHnVcvC5KK1KGZi+oKRes=;
 b=n5inEZX6vrrxS67F5OiQ+SDlaS/FcalajTpLRCNPrEwBO7zHTgke8EzHhz3Jj8TWw7
 T4ZlUJz8nyjo9aeoxNfdudZLjGQBWxRVYb2q7GBV3WBjiPMwFAhDFx0aMCV+oa2RdnEh
 1Vjm9bRL7hYmI1QjeOyv+49xILaJGZkbuXJzRveoT49IFT12Vo3rSNSxVjwUKAIIh+Dh
 LKV3k4E5aTcQyBPn7qmUuci3kq3TkNSht4c1scDy/RgcW9q1j8wi4p06X58WSPPMqfep
 1h8A7qSdcgNl2TngQlwSlRO5PD0Bt4JoQ7M13hZWerwjr+A40OZuurMRKD0wV8CgmK+e
 Umhw==
X-Gm-Message-State: AOJu0YyITVs7pNwvINNc48x3hEzAUS/yVHBxKfeIT4rfgLvJGxuBOiKR
 QmJjC91djjoTe4BHe+MqU/ascS/lSgbkWdG8Vgi70wyE4BQh3dJTpuq5u3SybBxcvS+5ceSW1dC
 wUto=
X-Gm-Gg: ASbGncsygOHivYvn/FeMZxY3YQJiRfd7FAptbQJBgZPJJXjov46+ws3m0CjScf6Bkum
 z/Gaa6k1YaorEfG2KnosLiEXg5a+RcmzKfLY/sjFUe2imzj2E/R4e2kXAILvgYgNPORjE+pE3AI
 tSta9uW0qtXKw6G2LNdj3kENSlI2LsxbnoX4Mp0tR3oRPH8OInni3rlt29Rab06J1jKP3bYANtX
 aoApZf/Gf1ojPHTTf/8uDrlByZhZfET3Bi1UJqMltB55J/PNJrLNuWHHWE/A441El9Gdpw1bzwr
 brnRAi/tZbDe88JPDNpRJRzdy/Rjtbf/oaDzwz9v
X-Google-Smtp-Source: AGHT+IFk2nTZ/2szMRArYw4zKgFF+u89wGma1goBz8QRVaaG2xYMWCbEQLMiDHJTA0UwqgVt1ZSd+Q==
X-Received: by 2002:a05:6a20:3950:b0:1f5:86c6:5747 with SMTP id
 adf61e73a8af0-20e97ac1a8bmr9116493637.32.1746409959886; 
 Sun, 04 May 2025 18:52:39 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b1fb3920074sm4462101a12.11.2025.05.04.18.52.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 May 2025 18:52:39 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 richard.henderson@linaro.org, alex.bennee@linaro.org, kvm@vger.kernel.org,
 Peter Maydell <peter.maydell@linaro.org>, anjo@rev.ng,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v5 13/48] target/arm/cpu32-stubs.c: compile file twice (user,
 system)
Date: Sun,  4 May 2025 18:51:48 -0700
Message-ID: <20250505015223.3895275-14-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250505015223.3895275-1-pierrick.bouvier@linaro.org>
References: <20250505015223.3895275-1-pierrick.bouvier@linaro.org>
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


