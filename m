Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31C30C3ABC3
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 18:20:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEXZR-0007oL-VG; Mon, 12 May 2025 14:08:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uEXX5-0002Ys-51
 for qemu-devel@nongnu.org; Mon, 12 May 2025 14:05:47 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uEXX2-00009S-EZ
 for qemu-devel@nongnu.org; Mon, 12 May 2025 14:05:42 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-b200047a6a5so3621990a12.0
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 11:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747073137; x=1747677937; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rVtP/RnhHG9awohdmhc7BZy6oUycGDI8ImSQa94LuXo=;
 b=zyIq5RY2BMRwSc00hlIPx6FhAEVMU4ZLZS4DfW4AqAnvCWYv3EEnostkW3exATQuHy
 mUJgZunRuZlUO4aLtTUx6VFbDbjDf0YDnieh2OZy3ZiuqelynIoigGcEKRDYTw9LqxvO
 j6JxKyl7bJbz2bl7X14q0sENq4cN6VBfjyV5c+/4DvMNGssOgGgOHZXsOIaxAtfiAXW4
 1C5KHLm5yPybf6YGjHwt/Zv8PsKrpRH1HFsEq85lAfCgYkJ5orXLU5B06U7CuyDQa1d9
 UlhRJBBmr4LOn57UuqmJu4hS9IQcSdzO1sPDpIyFouDo3Zl6eLytxqccczBWZCwnY2F9
 UtuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747073137; x=1747677937;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rVtP/RnhHG9awohdmhc7BZy6oUycGDI8ImSQa94LuXo=;
 b=PEMfLkgNFExythilHP0E7b8G3/iBzoBohz1JFwFu2Zyeihpg/Mcp0YAu/ociVfn2Y0
 ld9kJAYcyBthOBSVcv1Y/V0kIDB0UbOgPUDBtrE2Dqoq22P5KYGtXUX5GWQwg6Ph/UNw
 5wA3+0KJg/WIeKyQCQz/BfbSzTMQBoUFtWO6I62vBjxj7cavOUPaI+bdS4yZlaEgoHo6
 lLpDniY/Cg4jWNNyWNSMNKtwtSGEhY0XGeKRMsobnR1QC8FOhluOg9Wxevk7NIUxgB9t
 dloh2AS96zJzVt5SO0FWu3OQjdaX0gPGwgzciHk6I5tWfzb3E6Df/yw3QZXcpSTQJgzl
 uq1A==
X-Gm-Message-State: AOJu0Yx//uRxGKFuvGBL4N3WGhrSKkJfmtvGaBL23jePXBoBVAumbiym
 mzPN1Ln4cKxJqD2MdTBaQK14dy88iJrB7sEq3xHlMNxvPf3UP2rRYxyi5sg3c+YqA3KUahwwyY/
 m
X-Gm-Gg: ASbGnctZPZN0Tkewfp/ESFMyVhscF8/h90fpFQgQ0aDNgg8HOTqw9aDQQoAt5oi4NBR
 4Lj/Gm9OTiBGI9YCL5inYwmn/QRTgjMSUpntjtB5f0vGgikXEUqkVuoegovVt1CWwJJZ0AFQ3Go
 ZWR3kuz7UBb5cFNMxszYbCY+pyXf1amBaMLyzrgiYIz9T/Fa1CrUBIvLuhIwWzcMPo/cJBRw7dS
 F2ciLidxbF7kQDk5rQp1Wt9sjwWJJWoX94DpfwE15RHsC6lmNYecJ2c2knf4PlGmnZJpB58aZzx
 mWkPk016nZf+rtxCMHWkQPetrN7rEtKJD8dIa8rKldCVHlpNO4c=
X-Google-Smtp-Source: AGHT+IHQktjkFkIYbxcsH/03GT/KqC3Zw458X78euWuyq7vNjTjOxPnKiAkDjbUnG4wIaS9Ypg1Ktw==
X-Received: by 2002:a17:903:2f92:b0:22d:c846:3e32 with SMTP id
 d9443c01a7336-2317cb65e55mr5398205ad.25.1747073136768; 
 Mon, 12 May 2025 11:05:36 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22fc82a2e4fsm65792005ad.232.2025.05.12.11.05.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 May 2025 11:05:36 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org, alex.bennee@linaro.org, anjo@rev.ng,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v8 28/48] target/arm/cortex-regs: compile file once (system)
Date: Mon, 12 May 2025 11:04:42 -0700
Message-ID: <20250512180502.2395029-29-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250512180502.2395029-1-pierrick.bouvier@linaro.org>
References: <20250512180502.2395029-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x531.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/meson.build b/target/arm/meson.build
index 7db573f4a97..6e0327b6f5b 100644
--- a/target/arm/meson.build
+++ b/target/arm/meson.build
@@ -16,7 +16,6 @@ arm_system_ss = ss.source_set()
 arm_common_system_ss = ss.source_set()
 arm_system_ss.add(files(
   'arm-qmp-cmds.c',
-  'cortex-regs.c',
   'machine.c',
   'ptw.c',
 ))
@@ -38,6 +37,7 @@ arm_common_system_ss.add(when: 'TARGET_AARCH64', if_false: files(
 arm_common_system_ss.add(files(
   'arch_dump.c',
   'arm-powerctl.c',
+  'cortex-regs.c',
   'debug_helper.c',
   'helper.c',
   'vfp_fpscr.c',
-- 
2.47.2


