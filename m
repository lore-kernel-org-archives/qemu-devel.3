Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68665C54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 21:36:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkWEW-0001Jg-R5; Wed, 13 Mar 2024 17:33:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rkWET-0001In-T8
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 17:33:53 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rkWEL-0007hT-Af
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 17:33:53 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-33e76d653b5so216530f8f.3
 for <qemu-devel@nongnu.org>; Wed, 13 Mar 2024 14:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710365623; x=1710970423; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=FIxO42vqFtufIsfhY5joiyENSkrv8/reaFYUY5ay7IM=;
 b=FzNkX7bikvrzaUryZa98vc16OYFfpaWlUukIudteuvtQ2IZc3hwzh3V5gYnWAEeZ3V
 zoI0jszVaGGi35Xh/VJcyNJjb8X4D/ZWS16/tqCyFsRbF3mG/84w9uEK7MzCUDGLHgV1
 4oMEyjDlE8Hiyk8CPLT+bYjx5QGALVSZ3kuRhiVfoOKVCFTOTcc1jMaGf5JYZWqkIHiF
 i7rD7Z2NQImMdF1ozJuJEGFKYSElxHVegnvH8L5HtuCY26LlDVfuRq5wDGgfhm+ZJXJ+
 Bf2cK3WIo3k17jXD/sug+kELUUEKpoWZiYIDGBKKlGs8n2ehUAB3BjCLuxjYMPeZVTR0
 w3xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710365623; x=1710970423;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FIxO42vqFtufIsfhY5joiyENSkrv8/reaFYUY5ay7IM=;
 b=DedHt9j79/47iIhPK63enjDoTd5DZ6uhXCbrUpvi6CBaYzGddKEnSM+HDMexZGjH8b
 jn44i1yjDtMFRoIO3AIjKaAmLI3Jmf/W4TJ39UTgMx1MVHkqeBcBVBNF+hUbt7kl5Lw4
 H3ACWx7Jmw2sJtfrbNZnKpHhyJLrToVURtbZ9j6NFi18uswr9bff+3Fxz3UqqFNCYk2Q
 6piwip8i39CG/PCcC4mpxIfjxKJFOiOQMXNqi99CT4GgXvyppF9zpd1tLg3oMGUwlJlB
 X7pL5OZqP5CrvwxYn9xHc5Sm7htqR0dTWUb2ccrw2BT8a2/KT2s23ScZpvHR7M5nHKDI
 hrzQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZc0YTwM18/UnnDkGhxglHEsbudyUPLoRlPHsuvpc4pUfJPx8RTEk0E5+oQl/eMHNiRJXAHotvY/6GnM5BnvvytEShYhc=
X-Gm-Message-State: AOJu0YwjQruwUpzRl9sTJIlox3Uwp+1TJa+T1z99uWDwersZD1sJ29K4
 1hfQJ2vz/JEgIkgwopVVwxm7Bcltj+0tPkjR7hwq5lXjP1Babnz1UyFtkFdbs/U=
X-Google-Smtp-Source: AGHT+IGO3NaVVT/WOQkFn/CiwtQQYkB+YiO7AyFwqurLvvw4fx4t1V6DIDAoaCNyn0e8u5oCed6SfA==
X-Received: by 2002:a5d:6602:0:b0:33e:97b8:41e9 with SMTP id
 n2-20020a5d6602000000b0033e97b841e9mr2611284wru.52.1710365623375; 
 Wed, 13 Mar 2024 14:33:43 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.182.179])
 by smtp.gmail.com with ESMTPSA id
 bp16-20020a5d5a90000000b0033ec312cd8asm69602wrb.33.2024.03.13.14.33.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 13 Mar 2024 14:33:42 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-ppc@nongnu.org
Subject: [PATCH-for-9.1 00/12] accel/tcg: Finish replacing SOFTMMU -> SYSTEM
Date: Wed, 13 Mar 2024 22:33:27 +0100
Message-ID: <20240313213339.82071-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Finish the softmmu/system clarification.

Poison CONFIG_SOFTMMU at the end, we can still
check for system mode with !CONFIG_USER_ONLY.

Philippe Mathieu-Daudé (12):
  accel/tcg/plugin: Remove CONFIG_SOFTMMU_GATE definition
  travis-ci: Rename SOFTMMU -> SYSTEM
  gdbstub: Correct invalid mentions of 'softmmu' by 'system'
  gdbstub/system: Rename 'user_ctx' argument as 'ctx'
  target/ppc: Rename init_excp_4xx_softmmu() -> init_excp_4xx()
  tcg/sparc64: Check for USER_ONLY definition instead of SOFTMMU one
  plugins/api: Check for USER_ONLY definition instead of SOFTMMU one
  accel/tcg/tb-maint: Add comments around system emulation
  accel/tcg/internal: Check for USER_ONLY definition instead of SOFTMMU
  exec/cpu-defs: Restrict SOFTMMU specific definitions to accel/tcg/
  tcg: Remove unused CONFIG_SOFTMMU definition from libtcg_system.fa
  exec/poison: Poison CONFIG_SOFTMMU again

 accel/tcg/internal-target.h   | 32 +++++++++++++++++++++++++++++---
 accel/tcg/tb-hash.h           |  4 ++--
 gdbstub/internals.h           | 26 +++++++++++++-------------
 include/exec/cpu-defs.h       | 26 --------------------------
 include/exec/poison.h         |  1 +
 accel/tcg/plugin-gen.c        |  6 ------
 accel/tcg/tb-maint.c          |  7 ++++---
 accel/tcg/tcg-all.c           |  2 +-
 gdbstub/system.c              | 10 +++++-----
 plugins/api.c                 | 10 +++++-----
 target/ppc/cpu_init.c         |  4 ++--
 tcg/sparc64/tcg-target.c.inc  |  8 ++++----
 .travis.yml                   |  8 ++++----
 scripts/make-config-poison.sh |  1 -
 tcg/meson.build               |  1 -
 15 files changed, 70 insertions(+), 76 deletions(-)

-- 
2.41.0


