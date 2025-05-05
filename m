Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF3B4C369DC
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 01:57:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBl4O-0002FI-Ko; Sun, 04 May 2025 21:56:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBl4G-0001aq-TD
 for qemu-devel@nongnu.org; Sun, 04 May 2025 21:56:29 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBl4E-00035S-Fv
 for qemu-devel@nongnu.org; Sun, 04 May 2025 21:56:28 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-b0b2d0b2843so2882133a12.2
 for <qemu-devel@nongnu.org>; Sun, 04 May 2025 18:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746410185; x=1747014985; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3FxyL5xQTQeKYw4fbOUfGUh6DzvIDzEt1jfdRlnRDo0=;
 b=aexxEwG8u41yu5h4oW+HYbsqeMfzqk5f87hhXnjQNPOyOD2tUFZamyqCjklcvq7orf
 o5r3PgmI5HRXJk9NZ8tOGGCuV8I3GbhVEWPkeMR6jrBUCiL86q9kl4IKb9bcmzCkw7kM
 5iXkFSJqX5ESa/AybeH7zt22KxT/B72HC966OlTqSWuEzNB3COuS4g90E6U2a5wK4eUi
 qjLCD5xFhAQZIXnbxSnvzxYfLWo+Is9gUBoOI3tEMO96w5cnZaF/b5nz47GPrCrPVHXE
 CSWHVg9eXfcRF3s+mr1W4oStXkXZlUufcqDWRV0UqwDS6NKBxzU655zYUdY106h4G99P
 S08A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746410185; x=1747014985;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3FxyL5xQTQeKYw4fbOUfGUh6DzvIDzEt1jfdRlnRDo0=;
 b=DfVn2oQIQByMIVJLBhj8qIYTMdGb6NvBgDX4Jqugw0l2oR1yO6kp12WqmCVVMGJBuJ
 wGTyLaRim+9oir4NixFlFtrQxX6y4FUiAhNiSC6Clp2RRRe/mNFhbESQebafuJrqfBPP
 Hxxuyclu+vk/3k8mbP+EtWUBQzZPVMbNzsWr7HGXhwqGJfUY32rpPHLZqdrrrt0L0OzD
 BtDVgtgp10UOhry4o+SuMc1qJfIJBGf46LtbbvjBjCaiFLwxmMRyK77+R+QJ7zH//ExJ
 2Z9duJNXjs5jB/fNP0SfHKZ+dwJUlFCIP3XmxtkDoygkdA2Wfdxuxpj0twXadNkAJai8
 xVhw==
X-Gm-Message-State: AOJu0YwI95IWxZlTE03E+0boYyhQtvWX9tUeRMWH4JEczhtGEtqfX8Dm
 W6aeOzbDcSaMdgNOCEAVV2pnKlvshCdx15r9rjjjRcbsRpoklWjN4AroxqfSRQAAvb9o/s2nnUc
 onjY=
X-Gm-Gg: ASbGncujl1Y9K5q+bi6pPdIzfADLqVbY9pGHOV4G3/tvvroa2AQ+mYpZwwKnqX8Hnbb
 q/hUIlboZ23FCE0/imsrHLSfw8wIojuOTyjmxI6HV+pej68/AoSYESuTKlwae66lmNB9Fjx+xVm
 Uzsg7zyWN40wm87m1AWvupvAie9XlCvA6o8i92j3phglDS5huYsI3tZC4lp3pCRRtRwq25/SIfi
 d///l4S6mVP7YjuMu701BN7c41xAxoGuPp4HnEpNeZNtQV8NDQt20QFOXKytNGMbozuJVCyZfiF
 nb4VgX7NNISK92ao5riTzuRAS1O6XtRXlkkl2Gt4
X-Google-Smtp-Source: AGHT+IF08gkZkIRf18bKpe+h6dy7sLRJNTB7MMLMd8vtQdIpHc8Bzf6wKZHpeIbs8t/snEv3ZsWcRA==
X-Received: by 2002:a17:90b:586e:b0:2ee:6d08:7936 with SMTP id
 98e67ed59e1d1-30a4e5c5ed2mr16612751a91.20.1746410185269; 
 Sun, 04 May 2025 18:56:25 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30a47640279sm7516495a91.44.2025.05.04.18.56.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 May 2025 18:56:24 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 richard.henderson@linaro.org, alex.bennee@linaro.org, kvm@vger.kernel.org,
 Peter Maydell <peter.maydell@linaro.org>, anjo@rev.ng,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v5 41/48] target/arm/tcg/crypto_helper: compile file twice
 (system, user)
Date: Sun,  4 May 2025 18:52:16 -0700
Message-ID: <20250505015223.3895275-42-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250505015223.3895275-1-pierrick.bouvier@linaro.org>
References: <20250505015223.3895275-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x536.google.com
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
 target/arm/tcg/crypto_helper.c | 4 +++-
 target/arm/tcg/meson.build     | 8 +++++++-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/target/arm/tcg/crypto_helper.c b/target/arm/tcg/crypto_helper.c
index 7cadd61e124..ca14bd17a58 100644
--- a/target/arm/tcg/crypto_helper.c
+++ b/target/arm/tcg/crypto_helper.c
@@ -12,12 +12,14 @@
 #include "qemu/osdep.h"
 
 #include "cpu.h"
-#include "exec/helper-proto.h"
 #include "tcg/tcg-gvec-desc.h"
 #include "crypto/aes-round.h"
 #include "crypto/sm4.h"
 #include "vec_internal.h"
 
+#define HELPER_H "tcg/helper.h"
+#include "exec/helper-proto.h.inc"
+
 union CRYPTO_STATE {
     uint8_t    bytes[16];
     uint32_t   words[4];
diff --git a/target/arm/tcg/meson.build b/target/arm/tcg/meson.build
index dd12ccedb18..e3be0eb22b2 100644
--- a/target/arm/tcg/meson.build
+++ b/target/arm/tcg/meson.build
@@ -30,7 +30,6 @@ arm_ss.add(files(
   'translate-mve.c',
   'translate-neon.c',
   'translate-vfp.c',
-  'crypto_helper.c',
   'hflags.c',
   'iwmmxt_helper.c',
   'm_helper.c',
@@ -63,3 +62,10 @@ arm_system_ss.add(files(
 
 arm_system_ss.add(when: 'CONFIG_ARM_V7M', if_true: files('cpu-v7m.c'))
 arm_user_ss.add(when: 'TARGET_AARCH64', if_false: files('cpu-v7m.c'))
+
+arm_common_system_ss.add(files(
+  'crypto_helper.c',
+))
+arm_user_ss.add(files(
+  'crypto_helper.c',
+))
-- 
2.47.2


