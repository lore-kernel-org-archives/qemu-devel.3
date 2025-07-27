Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 128FBC87FCF
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Jul 2025 07:38:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufvx0-0001cY-7L; Sun, 27 Jul 2025 03:37:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ufvwy-0001We-Pd
 for qemu-devel@nongnu.org; Sun, 27 Jul 2025 03:37:40 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ufvwr-0000QV-NF
 for qemu-devel@nongnu.org; Sun, 27 Jul 2025 03:37:40 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-b390136ed88so2608377a12.2
 for <qemu-devel@nongnu.org>; Sun, 27 Jul 2025 00:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753601851; x=1754206651; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=OH4aLJlRBZdD5fXvlcl1QSignnUhy4EBtlnGLBq5wQI=;
 b=xxhwRSGpX6UhumDWJGfrFY75kvmQVgoJDVx8u0JNaT6Fy1FX2DOBCvfIUaA34hderF
 ZFYm1+YD7/q0AApJhXm7B7ST3KZznorF4KoFoR7Ji8uNYj38f2g5z4/0QTi5JXm0WSyA
 gU80ySBfuEcDKladkjAfrtWSUVkznGtvWag0WhH/IQ7m0lxzdGPlLZP71FiuqVxPE3lq
 9MGMptclrxLRpsXfhV3UCVdV1bwo+8Rlh3xs+vivcwOpoD4QkKndq1+61l7fvdCQTT2E
 yacvWbaYqIfl7MlRT+31hroorwAZJy+V5K3AAQvHSmBpTFZlvbHMYIMEcZDWyykThmA1
 KGQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753601851; x=1754206651;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OH4aLJlRBZdD5fXvlcl1QSignnUhy4EBtlnGLBq5wQI=;
 b=cackNQ3fS4tQyaqKo3lSQY5m0DhIlaW67RV2ipUhdh0sx58ll1YcAJmoRaLyiT2i8J
 JP0yI0xvXcge8wHlgAPMiok8Cbuchj9ljad9Kv8oqDmLT1DTM+5Vv5JDqa88/yBCyZpD
 6Q6TVmxetUgAmbd4lZ0N3MP3juZOJ/NX61q5vSFO+NXlpuwkJ7204B9/w8lbrq6w1jQp
 jghUo4UXGQSVJrLihcczLtzjaT4n9HS34TZqcHIC2hOl+Gn2KvQdX6y4rRqcLzCR3wtL
 QpMFowF+onOEB4/SF5GUQqd8fSPO4bRpGt7ti3x7zy1hg32yu/jQLF+E7Enn58oyDkK+
 hpFw==
X-Gm-Message-State: AOJu0Yw+ONyC9IuUjsuKEMxRaIe/lcuQuWSr423ojlGZ83i/vEml4UfU
 CIFpAA2acU2/Gixx/Ji8R+b45tTsGOBgNpX28t4zYl2p7WiLPn0hI7yR0kmvAW9zu0et3gcRUbi
 ijiIN
X-Gm-Gg: ASbGncuuA4Nft5lt8podNOffgZL9kRuna2FUkkL1EoUAhw3OiueKsj9u1nZ8nlY3HPf
 Vgj1wk5RAyLAgo1He6thyerE/XyE0/D8Ygj9FzGo1aDc2hy4ajfVs+p95e6xl11mO/LvPXL6TRC
 fdd5slRDQ7xnKKamF0v3r3w1uqORlv3XtPp4Mb98gXCzY50d4nzEkqZezm7UQXzfjFI893S5vUA
 MenmNMJLahCsdQs2aOg+mmCF+6Ft96xTee6Wv73V+Gan9JTHyL3093LYzYvcgXbgZ4E+CU0bZ9c
 Dt0lRcBC9aj5O6LgTEHtjxgUKRUbMpafi8dzwx1XhKTZ0ZBWtIanekHxpccKboa1eVfP5QIEdW8
 7JqH+u/qFu4fK5i2n3GHa+lqjXEG2kyS6hO7E5UvP1+b501zX+5B7Hdc2E+TewHwhbLwvNUPQlC
 caovf+Hhk5kw==
X-Google-Smtp-Source: AGHT+IFcS8+bhDRqg2ERANrU4aXS+WoA1bVdo75cDuCP+lWXnDP2cVkqlIH86GIHargpepstuG/QIw==
X-Received: by 2002:a17:903:2a86:b0:235:e1e4:ec5e with SMTP id
 d9443c01a7336-23fb31252dfmr132106115ad.49.1753601851347; 
 Sun, 27 Jul 2025 00:37:31 -0700 (PDT)
Received: from localhost.localdomain (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23fbe327443sm29824635ad.44.2025.07.27.00.37.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Jul 2025 00:37:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 0/3] linux-user patch queue
Date: Sat, 26 Jul 2025 21:37:25 -1000
Message-ID: <20250727073728.82913-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x533.google.com
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

The following changes since commit c017386f28c03a03b8f14444f8671d3d8f7180fe:

  Merge tag 'pull-target-arm-20250725' of https://gitlab.com/pm215/qemu into staging (2025-07-25 08:24:52 -0400)

are available in the Git repository at:

  https://gitlab.com/rth7680/qemu.git tags/pull-lu-20250726

for you to fetch changes up to e35215db401113867e20634622a370c0e8931797:

  linux-user/aarch64: Support ZT_MAGIC signal frame record (2025-07-25 13:11:48 -1000)

----------------------------------------------------------------
linux-user/aarch64: Clear TPIDR2_EL0 when delivering signals
linux-user/aarch64: Support TPIDR2_MAGIC signal frame record
linux-user/aarch64: Support ZT_MAGIC signal frame record

----------------------------------------------------------------
Peter Maydell (3):
      linux-user/aarch64: Clear TPIDR2_EL0 when delivering signals
      linux-user/aarch64: Support TPIDR2_MAGIC signal frame record
      linux-user/aarch64: Support ZT_MAGIC signal frame record

 linux-user/aarch64/signal.c | 139 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 136 insertions(+), 3 deletions(-)

