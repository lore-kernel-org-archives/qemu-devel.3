Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A696AC3DA60
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 13:35:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sURI1-0006Ba-F9; Thu, 18 Jul 2024 09:35:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sURHo-00054s-2H
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 09:35:08 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sURHm-0000Ko-Dh
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 09:35:07 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4266fd395eeso2872425e9.3
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2024 06:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721309705; x=1721914505; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f+aYS0CmzIbyjKGvExYGEZFqxw8XdQ+/CcKYqmT4dqY=;
 b=oXflXLyhSJgYocxDAZKKQTcFcC8vdvri+sXFYDuwraTt/NLci8+YUY/OPrLSSTJXmk
 huXE/U26MqqiqIrkvUrsDkOAa+ubp4lv/e+wZ3BPN+w5PX6L3tMnoqMIH3N6dBT1brxV
 zJonY4FQYRo0/drftzdtDOW7USWDmV1pqj9efuRjHcNPagCfwoyvE4Bq7kFoQYfbGpYZ
 jEzoCw23TqYZVhRjV1YiSJyXIxamdEErJm0hC9r+5oJ6lseoCOimHtS1feUpFmqnGyOY
 ZcPt/zI98KE5vdA6chD895bG/b4AAECMD7m3IrbcpL96PT/XRN2GxZeZh5Vpb7QtrhNl
 kZVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721309705; x=1721914505;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f+aYS0CmzIbyjKGvExYGEZFqxw8XdQ+/CcKYqmT4dqY=;
 b=ekYUw6ViQ83gEYg0BxbJ43Tt2clN+2anKAarevMA5W/+vQr8MdDUewnwROTCf5eZ11
 Y8WxpblVISKWi0fJ+LHEBNHzuANiHWi6pQrAs75ovDKIqKX4P8ceZ5kn7O6LccAuYy59
 hFWX4VTKbkxjVf4BZvmlDcOOyLeZIvuv0NpK8qFH36Khjzqcb64LcxKaxLxdj7xWrtsF
 VlUV7yI+MIFcnU3yvWRmlPBQSYLJUljBAB+bieh5tSf/0u05APtprB3nr551qebr9apJ
 9KrkveFjrYUVzTM3yRVXzFsEb1TJRt/+x9Y0zcWS9hlUfkkG9q/c85HyQ2cR7SvB46QS
 x3JA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVkYtLlLYUTjTVnygBZ4pubk70t49snyyvoTgYw6ctR8LGCG7fzLxijod6JZ9coTYpx/6CnudzgsZVbFmzjU07E1dNUo7U=
X-Gm-Message-State: AOJu0YwlZajddHBPQDEwnVu4jx3koMYf2NB5FQLs7H5tzoRAV+qX1M6z
 vq9ZBigCOfJnHkhB2XwGGi1QfTl/3M9j63jf+/+aI3B/twft/cK0eRYo2JiN5Vk=
X-Google-Smtp-Source: AGHT+IFAzrwFp5dERG2h81V/RI7HAd+FW2b4vo/XQ9++1CoTFl4ScJ3jg6nYyd3k5dZaxayJGLMCbQ==
X-Received: by 2002:a05:600c:450c:b0:426:6416:aa7a with SMTP id
 5b1f17b1804b1-427c2d12992mr37507605e9.34.1721309704958; 
 Thu, 18 Jul 2024 06:35:04 -0700 (PDT)
Received: from localhost.localdomain ([176.176.173.113])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d2b2a11asm14390595e9.40.2024.07.18.06.35.03
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 18 Jul 2024 06:35:04 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Bibo Mao <maobibo@loongson.cn>, qemu-devel@nongnu.org,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Song Gao <gaosong@loongson.cn>, Paolo Bonzini <pbonzini@redhat.com>,
 Huacai Chen <chenhuacai@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 Xianglai Li <lixianglai@loongson.cn>
Subject: [PATCH v5 19/19] docs: Correct Loongarch -> LoongArch
Date: Thu, 18 Jul 2024 15:33:11 +0200
Message-ID: <20240718133312.10324-20-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240718133312.10324-1-philmd@linaro.org>
References: <20240718133312.10324-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 docs/about/emulation.rst | 2 +-
 hw/rtc/ls7a_rtc.c        | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/docs/about/emulation.rst b/docs/about/emulation.rst
index b5ff9c5f69..3bfe8cc14a 100644
--- a/docs/about/emulation.rst
+++ b/docs/about/emulation.rst
@@ -42,7 +42,7 @@ depending on the guest architecture.
     - :ref:`Yes<QEMU-PC-System-emulator>`
     - Yes
     - The ubiquitous desktop PC CPU architecture, 32 and 64 bit.
-  * - Loongarch
+  * - LoongArch
     - Yes
     - Yes
     - A MIPS-like 64bit RISC architecture developed in China
diff --git a/hw/rtc/ls7a_rtc.c b/hw/rtc/ls7a_rtc.c
index 052201c2cd..3226b6105e 100644
--- a/hw/rtc/ls7a_rtc.c
+++ b/hw/rtc/ls7a_rtc.c
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
 /*
- * Loongarch LS7A Real Time Clock emulation
+ * LoongArch LS7A Real Time Clock emulation
  *
  * Copyright (C) 2021 Loongson Technology Corporation Limited
  */
-- 
2.41.0


