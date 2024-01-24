Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A212C46CD2
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jan 2024 07:56:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSY7N-0001Rd-7t; Wed, 24 Jan 2024 02:56:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rSY7L-0001RB-Lb
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 02:56:15 -0500
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rSY7K-0005S9-55
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 02:56:15 -0500
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a2d7e2e7fe0so870810766b.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jan 2024 23:56:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706082972; x=1706687772; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=L9VZHvE2FPkiZMCjVyYiBUbJfHj/7b2dkv8KOQcC+KE=;
 b=nN7HhpgbSYRUHsXaMAiAb82etg5vVzjZgZwmZKwzn6NCGFK7ZAqfzbUNUI1+74mLVF
 w12IhLwDufKnw/7q7oIaNcFbWepzwWF6n5A2xtcFLpHmfx5hiTzlur6Xzb7S3/RdIMkw
 G5cjkD3XKrEPUhy9o2sNsww9K6RhEZ8fj1iayprF17sfd8/lrHHG3Y8RBFG3fktBl5K7
 gshJMIUjY5SdDV7gFS1jhjwbZ7wtwnBRQmKKKewLeLGxpC1btwOJnI8TNt+OZONx5a7i
 qJsV0hrlBnCdIMrqYOSw9I7sqq5KkagM3mP85N7FjdYoyZGL1/QTxgt/efcsNiZf9FBr
 B+kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706082972; x=1706687772;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=L9VZHvE2FPkiZMCjVyYiBUbJfHj/7b2dkv8KOQcC+KE=;
 b=mM3PAgfUaoqBXP97IdEj6w9xuzG7y9gnurxEkmB9Y4eEPgjzm/6LsO+emBZEPuF4Us
 YBk1ANmMyiSSr8K3hkZIQe+w0q+mmE4uZrZqXnlv0yjH5hEtb/6D3ZAyPb3Nds52sixu
 wRDux84yVMiBlWuF/Lcu9SJzPM/8yWDe9TYtETnfncTfob2NJO0xR4gmWIzknPChxvNB
 2kBOXiA5lWWY+eRX8LB70Etmz30QYmFuUGzipwd5Q98x6rA9IitaHeUbWj9o0MVluUt8
 +vO4GMDtX6YJ7SjNpO1yY72Bq7e1V/XThGs5YAn0Q6m37S7zfqZXzmCB9/Y+WKxi/e1n
 imYQ==
X-Gm-Message-State: AOJu0Yxly0rVMsdlyWSoOVE8LGgRMyAn+dpsNeRZrvi1Qzi24IvQzFC4
 o3dWZhoE4xPwj/+BN+YmVrqofeulyPRwtRTu4b16V/TpB7fb0CvG1XfVkG+nUVAHLq/DQkbjjOG
 a
X-Google-Smtp-Source: AGHT+IGGuiE+ISjLbqcHd3YOuNlt/9v3ZBJ1q9sEZI42AFEkPx5l6p2uW0E5UmGI8QZ3VdJGP756JA==
X-Received: by 2002:a17:906:bc9b:b0:a30:e1b6:2879 with SMTP id
 lv27-20020a170906bc9b00b00a30e1b62879mr771770ejb.1.1706082972218; 
 Tue, 23 Jan 2024 23:56:12 -0800 (PST)
Received: from m1x-phil.lan (lgp44-h02-176-184-8-67.dsl.sta.abo.bbox.fr.
 [176.184.8.67]) by smtp.gmail.com with ESMTPSA id
 l18-20020a17090612d200b00a28fd9607a8sm15094936ejb.81.2024.01.23.23.56.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 23 Jan 2024 23:56:11 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v5 0/4] accel/tcg: Move perf and debuginfo support to tcg
Date: Wed, 24 Jan 2024 08:56:05 +0100
Message-ID: <20240124075609.14756-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Since v5:
- Rebased on commit 53e8868d69
  ("meson: remove OS definitions from config_targetos")

Ilya Leoshkevich (4):
  target: Make qemu_target_page_mask() available for *-user
  tcg: Make tb_cflags() usable from target-agnostic code
  accel/tcg: Remove #ifdef TARGET_I386 from perf.c
  accel/tcg: Move perf and debuginfo support to tcg

 include/exec/exec-all.h          |  6 ------
 include/exec/translation-block.h |  6 ++++++
 {accel/tcg => tcg}/debuginfo.h   |  4 ++--
 {accel/tcg => tcg}/perf.h        |  4 ++--
 accel/tcg/translate-all.c        |  2 +-
 hw/core/loader.c                 |  2 +-
 linux-user/elfload.c             |  2 +-
 linux-user/exit.c                |  2 +-
 linux-user/main.c                |  2 +-
 system/physmem.c                 |  5 -----
 system/vl.c                      |  2 +-
 target/target-common.c           | 10 ++++++++++
 {accel/tcg => tcg}/debuginfo.c   |  0
 {accel/tcg => tcg}/perf.c        |  9 +++------
 tcg/tcg.c                        |  2 +-
 accel/tcg/meson.build            |  4 ----
 target/meson.build               |  2 ++
 tcg/meson.build                  |  5 +++++
 18 files changed, 37 insertions(+), 32 deletions(-)
 rename {accel/tcg => tcg}/debuginfo.h (96%)
 rename {accel/tcg => tcg}/perf.h (95%)
 create mode 100644 target/target-common.c
 rename {accel/tcg => tcg}/debuginfo.c (100%)
 rename {accel/tcg => tcg}/perf.c (98%)

-- 
2.41.0


