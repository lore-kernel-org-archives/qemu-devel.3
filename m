Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65275C369DC
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 02:02:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBl1E-0004XD-VF; Sun, 04 May 2025 21:53:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBl0s-0003xP-DI
 for qemu-devel@nongnu.org; Sun, 04 May 2025 21:52:59 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBl0n-0002af-Sv
 for qemu-devel@nongnu.org; Sun, 04 May 2025 21:52:57 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-736a72220edso4333093b3a.3
 for <qemu-devel@nongnu.org>; Sun, 04 May 2025 18:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746409971; x=1747014771; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4DYtSZEbP1atLGb677pRK4UuiMz1CYlbqC5aWBJkLTc=;
 b=aTthELWNn5cR6dWupKxFvvzL3tGT7xLaDHCKZ3O9taO6e7MyF8gYalypblCodEJ0NF
 0eh1m0OUQJBqzchk9eO9CQ/75cPDisWbJ7rpiyc+lby10TkbqlnTPj1M9lqa1831ZLHm
 ajjHuNR35nYiKjLbVpNGDDRlsWei/zaPWlxI0Av3jzT4+uVhIGMHUX6CmWVpadg3EOyA
 bXvN1FfA1uqh/n1QAD++W/tXxOhR/rOOMfU4dItjKIESnOu3GMP7V9HK0c63guj34NVD
 zUSwPLVY2rQ9Tw5pvC1pDLWs9Je0JxXfBSSETRCPcqrStNbOtGwj09ut972itViyi6Z/
 tCCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746409971; x=1747014771;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4DYtSZEbP1atLGb677pRK4UuiMz1CYlbqC5aWBJkLTc=;
 b=V5jS48El4YVqzmZUKWdWtT7djDW9ppu+T/STK+lXvVG709pbOoyLi8ZS/ZR9LJzoNh
 IVngbIT6QGLYfUFq7+2ywOy5VW8tba6B1OFNgaoNpqFa7tmfd92humAbbGHUuGuGW5nB
 UmCgPsnGgJRSUnZFFlIyD40WwhiLL1sssN2ied3XyFJYRnarUlh9RHi4SOcVr665U/cQ
 DoRqo5Yptx0D9ta1HUm+8pCRQfzZrd+hmzMEb4fPRnd83u178tELdVUSkayWCIQdDzQG
 +xuYzwgZL/goxJorMIXSTHSxB1+F5OQaDHxPe8G3C+uJyAaSckN4TD/5EApumdwRnvfy
 Uo3g==
X-Gm-Message-State: AOJu0Yzj9gfL/LHKzHUDKucnx7S379SUK7NXC4ZBd80MFPO6sn+Kl6Z/
 mdFo3LA2EuLjFINI4FrtNdLCIQbEgLLQPvG7ZDkFZWShTW8zsOyyYtgxWoVyJhQIQtI5fKrXyRL
 pySw=
X-Gm-Gg: ASbGncsNjcN2yxFiSVVmq5xEU5LSIKVpDvPv16ehyt29cbTc0fFKS09BWNSpOQQQaYf
 nuwVBp9NLIPZRQ7qV5bJ92ot+ATfcKEFV6sDBVMpRWc44MWsyDhmlB2XpcMjl2U5PufwZr83EQY
 RFwhofcMD2+dz4sJINDU3Znjm1+YX9+8LB4sL8p4FNiAcTW58qDJ9bynr1FWw9ceufs+oQHybVx
 CpmhK7O2HJyL1Keur9bMIPWH/X7eYX79DEZnNB2hD0IUutPPHuUg6234w+hZr/mOoHziM/BDDqE
 LBjxZBCSI/0ZrJ3mc6ff2vKVKpw8cVYs4EgNbY3f
X-Google-Smtp-Source: AGHT+IGVarzG9+Ft7iZTh+BmJpw4oNqMHWcxpYoJIe/50d6p1PE5Wrx6QUAXleCla+pHMM66eQdcWg==
X-Received: by 2002:a05:6a20:87aa:b0:20f:953c:fb57 with SMTP id
 adf61e73a8af0-20f953cfbf2mr2868991637.42.1746409971130; 
 Sun, 04 May 2025 18:52:51 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b1fb3920074sm4462101a12.11.2025.05.04.18.52.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 May 2025 18:52:50 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 richard.henderson@linaro.org, alex.bennee@linaro.org, kvm@vger.kernel.org,
 Peter Maydell <peter.maydell@linaro.org>, anjo@rev.ng,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v5 25/48] target/arm/helper: compile file twice (user, system)
Date: Sun,  4 May 2025 18:52:00 -0700
Message-ID: <20250505015223.3895275-26-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250505015223.3895275-1-pierrick.bouvier@linaro.org>
References: <20250505015223.3895275-1-pierrick.bouvier@linaro.org>
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/meson.build | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/arm/meson.build b/target/arm/meson.build
index 48a6bf59353..c8c80c3f969 100644
--- a/target/arm/meson.build
+++ b/target/arm/meson.build
@@ -2,7 +2,6 @@ arm_ss = ss.source_set()
 arm_common_ss = ss.source_set()
 arm_ss.add(files(
   'gdbstub.c',
-  'helper.c',
   'vfp_fpscr.c',
 ))
 arm_ss.add(zlib)
@@ -32,6 +31,7 @@ arm_user_ss.add(when: 'TARGET_AARCH64', if_false: files(
 ))
 arm_user_ss.add(files(
   'debug_helper.c',
+  'helper.c',
 ))
 
 arm_common_system_ss.add(files('cpu.c'), capstone)
@@ -39,6 +39,7 @@ arm_common_system_ss.add(when: 'TARGET_AARCH64', if_false: files(
   'cpu32-stubs.c'))
 arm_common_system_ss.add(files(
   'debug_helper.c',
+  'helper.c',
 ))
 
 subdir('hvf')
-- 
2.47.2


