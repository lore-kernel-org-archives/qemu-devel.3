Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59CD2C3ABB6
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 23:29:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uC57V-0006rS-4e; Mon, 05 May 2025 19:21:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uC57L-0006bf-Cg
 for qemu-devel@nongnu.org; Mon, 05 May 2025 19:20:59 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uC57I-0003hy-OP
 for qemu-devel@nongnu.org; Mon, 05 May 2025 19:20:59 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2260c91576aso44837605ad.3
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 16:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746487255; x=1747092055; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fjvN9GkUlSXmzEXtUb9+tptKE6zBbBhkZRx0p6n3iY0=;
 b=GVdeaW2p9xOfze8GOakvLHHpwnvgwLWtg2b7DEWYEX9I21PjFST2Ug1An/EbCYBOgv
 oNtfROBbROqc+L101G3Eo5OUDGuAXEMLLyfH3pHPwUaHDyaNL6lmK0xGMlaJBppXwEGO
 my5zuP9aXxL4mUGNP1/oU/8/zsPea6JG1bKd32BDnbw0gEvx5EvKgCsRYH1gMpuHJJMg
 KGpYuZxQ1FFKkIRllEmMoLwqdcywcPpmcahRvYoBOM08nhLtSDHZum0XQmA6ZHQFzWe/
 U4f4vLx+A6eWJwRDsJmdywS1Bx5bVlqNWYtqiKYqDYeFqi2id8aTijJTecGGCyn2gte+
 OkkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746487255; x=1747092055;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fjvN9GkUlSXmzEXtUb9+tptKE6zBbBhkZRx0p6n3iY0=;
 b=L1PL3vcOMYRuFR5zZNJ3eW/0+kTsWa0og7mQB40v87TGOm8kLur0iGdTRxhynokue+
 WUmP7zc9J07BtIZoDuFhu2UGcl5NbCn407R0Elz1nA0HJrI3iupmGLaL2DQabmmDCjc1
 +8ay+NjsniBS0np7Q7wyx0XNokBiF2/Jb1cWjUNsSWmf4STm/vGcKsn67NchiDpqBZFq
 HUEOaGhMmuMfVM8qugKgz9sUtZPLYYgLvP8zSxyy5T3i41kYxmz+vGR18XXnxc3HE12m
 iVQyl8/6tfKkoHGQZGThsgcBK6lxm6lCaDYpd3UMy33TWYlpAiPt5r+JfZ7WNSLU/AKa
 gCTQ==
X-Gm-Message-State: AOJu0Yz4qSTBGTPQMXLIRC1Ew9oLcIPh+saXxJKjJ/SqYjNu+PxHw5f7
 eGvH+GFk/ZwArZ25/GMZY4GJi600zZeLxcfMe08gPPvW1G5W/uO5aiu7Bc8iYMDEOkLSAvUSHbT
 h3lo=
X-Gm-Gg: ASbGnct+QI43iU4+LA5+P018OGxLMCTzPA5GpJs81oeLNBqjkI5us+ILz3/lCtX9lAT
 vXUqen35udqrsXEx+Ilkdw4IYSXTVXAJSIaKCYBTy4segcpAZoYxpLVMji9mewVGMjePMdGp6bV
 0zaySYk2S8Xei8bfqyQSWikgTaponHCkwdm32ACxcPgmqpMgCZ0Sc+X/rL6nQTNLqrEylpRMgB3
 v9XaImEudj8rDDX7EoROLDeOMqEzQNkNr0yHQYPYNkeNhQh8q1uWqd040aLuFuNz2onUQRk8Lem
 5yFuduxa12EyEm/q9lwYw7Haf3kTul8+JRvTKNOs
X-Google-Smtp-Source: AGHT+IEzyM9z7CVe4AtEhGj/jyZA+D2xzzxXGDSUKPWZMwhpDevNTLCDhN002Fitb043HbVefJtNKA==
X-Received: by 2002:a17:903:18e:b0:224:6ee:ad with SMTP id
 d9443c01a7336-22e1eb0c7fdmr138057955ad.44.1746487255044; 
 Mon, 05 May 2025 16:20:55 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e1522917asm60981715ad.201.2025.05.05.16.20.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 May 2025 16:20:54 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, anjo@rev.ng,
 Peter Maydell <peter.maydell@linaro.org>, alex.bennee@linaro.org,
 kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v6 39/50] target/arm/kvm-stub: add missing stubs
Date: Mon,  5 May 2025 16:20:04 -0700
Message-ID: <20250505232015.130990-40-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250505232015.130990-1-pierrick.bouvier@linaro.org>
References: <20250505232015.130990-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62e.google.com
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

Those become needed once kvm_enabled can't be known at compile time.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/kvm-stub.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/target/arm/kvm-stub.c b/target/arm/kvm-stub.c
index 4806365cdc5..34e57fab011 100644
--- a/target/arm/kvm-stub.c
+++ b/target/arm/kvm-stub.c
@@ -109,3 +109,13 @@ void arm_cpu_kvm_set_irq(void *arm_cpu, int irq, int level)
 {
     g_assert_not_reached();
 }
+
+void kvm_arm_cpu_pre_save(ARMCPU *cpu)
+{
+    g_assert_not_reached();
+}
+
+bool kvm_arm_cpu_post_load(ARMCPU *cpu)
+{
+    g_assert_not_reached();
+}
-- 
2.47.2


