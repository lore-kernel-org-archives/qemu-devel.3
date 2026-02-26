Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45DC4FD8FCE
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 15:57:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvdiW-0005PK-So; Thu, 26 Feb 2026 10:55:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vvdiR-0005NR-Ah
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 10:55:51 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vvdiP-0003lT-Di
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 10:55:50 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-43767807cf3so724232f8f.1
 for <qemu-devel@nongnu.org>; Thu, 26 Feb 2026 07:55:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772121348; x=1772726148; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=WSrDqWRIaOtHv55qkOHl6cQ041BeMEi4R6eKWEMbzxg=;
 b=azgW3ySR+A7o/YLufLDKdVz6rzul5j7z5fkrHIkIJmiWOyo63ACIq0IrYIsLYbqIsV
 wYTFosx9EOpJEIO2M7BlgH6ItjED+sAADCt7TYvHA6MAPCwS1u8zTeIwGAPZMeuUOHJt
 ejPvQcXZen5+8lXvw1TsRb0SWOcLfNKi1KP++aztOadXNjGiiAnDFLKoOSc4OGLfaElZ
 IaqPpGzyUUPvde0YzZVFDOogF7LJ1XicXl36k5G6h5rQ3sBQdgNwCsnENDBUSpYUalE7
 B4vIzafamEdLORM1dKOmUBnsFFiqzjqyZa0k6dxoAapqv8R5D+q9Iw0WrgNMTgUGFDrA
 GumA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772121348; x=1772726148;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=WSrDqWRIaOtHv55qkOHl6cQ041BeMEi4R6eKWEMbzxg=;
 b=ccXgevwaXLxDyrsOh0aKHnlqKG3GovnAoXhO8pydrHeUPLNxqtLEDuVBTWUaQmOL0o
 qftx5SZKk+1WwWVyrx4nTAUCYlMmw9sU9Cl8gJiXjwaIElfweY5WM+p/VlQqC7MzBjX3
 TSFzwwHZSalaAkMzryQEw6vU1L7PUft8kw0Agb/TYUvrO5yuopRyClA9aIhVt1MbJswq
 oq41QDJ8mQFxfVdfOoKGKJEO3ESbVSxRByF5dc0BzssqBVtftUtuNGgSmhUcTEsYyOvC
 g+YIlgSoBZImcb9UqywdkuRu+R+uZ19ntFUuN8BpwqjaBrscvMB/SRkjVpmGo8rgxDcQ
 C3GA==
X-Gm-Message-State: AOJu0YwjH/5SyyuBSQoYq8/ajcCDGopeOQaVZruAZoubWbb0EGSuTnR5
 /kj6YtlPKv72fAWLDHcZVIVU4uGTKRP5QeNThRfI8m132F+H40DvJF4IwNsQOJ8JiX7Tl6N9HwP
 HbQxl
X-Gm-Gg: ATEYQzyBcReSGrrOC5izwOs3Hqd7b41VtuXDBecpTgNjWCtBaDNCFT0QDL9Bl3U6Yyn
 X172mCZuz56FTIFaHcAllzB8UsgG3dD2dEzCCPgP0IB3l2W27OgS4ox/KNKBss2QeWJyPqEAJcL
 AxBSX0PYUTffzKEtn5PCuk3dyGyPVH8/N7MpTRzNL0xaLQAyzxVqK2m3WzKfHA3Z8lCLK3Qbyyy
 XK2Pwncjcz/nbWx2hFIl/aOzxyXG6AOjqQvZ0/ExYq2dgwVfXp3LswcPKk1r7liNCztkvj30Xll
 3+6PywVVtcCK2CGHqYk3aVYZrcPdF2GY7DGWLdVWkwRKBeWINpAagJgWLK1AxDna+ZPk9Bdxt/i
 mWmsxfFrMrfGo4+ZlQpffQlJ9FnY8uMOjjFgM9w2L+W9PDk9SGd4NmE3lm1hF3QA8Q9/A8Yjnow
 +3AeFgZPDSafzl3JPGRrzis0nqPt4tseP8UUMdjPD9wIdFpNrWaUWct9axqDI0gdXtAKmgxMwyj
 5+LJ42sehim7IWLboQTmwZ7hrWMX7c=
X-Received: by 2002:a5d:64e5:0:b0:439:8bb9:dad4 with SMTP id
 ffacd0b85a97d-439942109cfmr8198321f8f.0.1772121347619; 
 Thu, 26 Feb 2026 07:55:47 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4399c75b8afsm407235f8f.23.2026.02.26.07.55.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Feb 2026 07:55:46 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 10/20] target/arm: Remove aarch64 test for kvm
Date: Thu, 26 Feb 2026 15:55:25 +0000
Message-ID: <20260226155535.1171290-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260226155535.1171290-1-peter.maydell@linaro.org>
References: <20260226155535.1171290-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42d.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

We no longer support kvm for aarch32, therefore the aarch64
test is trivially true.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20260216034432.23912-3-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu64.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index dec430c48b..87b8c586c4 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -799,9 +799,7 @@ static void aarch64_host_initfn(Object *obj)
     ARMCPU *cpu = ARM_CPU(obj);
 #if defined(CONFIG_KVM)
     kvm_arm_set_cpu_features_from_host(cpu);
-    if (arm_feature(&cpu->env, ARM_FEATURE_AARCH64)) {
-        aarch64_add_sve_properties(obj);
-    }
+    aarch64_add_sve_properties(obj);
 #elif defined(CONFIG_HVF)
     hvf_arm_set_cpu_features_from_host(cpu);
 #elif defined(CONFIG_WHPX)
-- 
2.43.0


