Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88A12C02188
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2025 11:54:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcNhL-0006Jo-BE; Mon, 27 Jan 2025 06:54:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tcNhJ-0006Hj-9o
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 06:54:33 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tcNhG-0006nW-CB
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 06:54:33 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-438a39e659cso27832435e9.2
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2025 03:54:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737978868; x=1738583668; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=OVs1uQBXV3uSV4KyChDtl5CQXcS/tEhsZMOP3GSwHeM=;
 b=N0LmHQe2Z9uUckrFumMPBpDjQw+mazbdiciDwIuFFIvOpzFl+nBKV1aoaRtPdAmBrp
 Oj5pygnyBwWQhUeR6Q/SdrEgN+5xNMCKrpHUMNDP+PWMEhNq9tDVo1kMhAUm4EoGoxYE
 7U0ss9yIAVyWt8+QM9HnIZsvmhFuUZUuZBQ5pFqFNXyIw0bAMRAvnQMeNX7njtN+c5X/
 2qYWzWmMnVr9ElMQ2DqffMcSwmmS/NS44l5EsOdsR0BC+i5OYZM9tdS79Q/YiJUysA3+
 L0Jbgu96n24K5TtNH4zC2XQJPro22EFj+VjOROn723NuYYKcF8ptu2iMSNVtbeDqFeaG
 cThg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737978868; x=1738583668;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OVs1uQBXV3uSV4KyChDtl5CQXcS/tEhsZMOP3GSwHeM=;
 b=NmNoDsNJ3G8Bl87WB9/jAcrXkYEyNf3SX3OmlxIR18gCE5R5dhfyr7N4h6/7JN7DGQ
 ZyS8KKHVvgz/CmUfvvidiAQl7ioGmLXAljcMogANRe6JGOf0jDXKnQ2B/8uvMkCasY+z
 yVLChNStGP/ePXoghmbYM8FTeFKOx/pKlM4xmNxGeGJmeaFa24p5sQRBG6oO5tbDcW84
 OO0U9BeoT+kR2dzJfQmsFcM7NOvnMJUkoCQVDPeDczxMZ5xV5eT/RH6yI5uVKa6saZ7h
 vS8bIpjJ+bch5UOzMEROba1NcGKQ7CUdnlfQq7rsMa0ocgTdlqNJl5FCSrBAJbpfhDWx
 o24Q==
X-Gm-Message-State: AOJu0YxX/Rp2B9w4SnroK+MVPlEu7zqhW0FKVNOvhWKOL4qXCTI7JXFF
 DfHL0JZkh4uHqrwqHQ7BXsNTYW4/xRvCKA5DozLGj1bX1abP52S7OUIOnkM1NU0fNZZHsLWyy/b
 JxSs=
X-Gm-Gg: ASbGnct2PICHln/wYt2lWoMjaXqsSup6M2QA/j01D2hrOXNL6EydeeuPUWsNZoVOQR6
 bhlBqoP4KMNmnS/UOmFvnhSvRsakZXIyb8GWXhL5H4qFgsAel/OJqoB9dv7PEmYhf0ftSIwwgji
 0eOLBqY/ab6NZ4aqPVtF1KRpnz1W1ZFLDI5VxPREQEbm182W+n3Bzvi7dgCD9G/LJsFQuZ7fyTQ
 wUUs7/cmfATcesWv5a1uHt0nJUZjeFKlerc+QhIInoTYfxHOuRR72nWfQlPeqErT7wxIpNmyOtQ
 0Ajx6eDPUw9svLTbUJFwL3WsivHZjNZTsXdlTgWPS8VDRuk0Znmf+2M=
X-Google-Smtp-Source: AGHT+IGxSDj+2vWF9wluF6+VcjoBU0kC6hDQGQxaj9jSGxUYvlc3yjrZKjjs9Vc416KyvqLNh5zcsw==
X-Received: by 2002:a5d:6c65:0:b0:38a:888c:676f with SMTP id
 ffacd0b85a97d-38bf565f13bmr40889739f8f.15.1737978868609; 
 Mon, 27 Jan 2025 03:54:28 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c2a188928sm10793575f8f.45.2025.01.27.03.54.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 27 Jan 2025 03:54:28 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-riscv@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 00/10] disas: Have CPUClass::disas_set_info() callback set the
 endianness
Date: Mon, 27 Jan 2025 12:54:16 +0100
Message-ID: <20250127115426.51355-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Targets are aware of their endianness. No need for a global
target_words_bigendian() call in disas/ where we call the
CPUClass::disas_set_info() handler which already update
disassemble_info fields. Specify the target endianness in
each CPUClass handler.

Philippe Mathieu-Daudé (10):
  target: Set disassemble_info::endian value for little-endian targets
  target: Set disassemble_info::endian value for big-endian targets
  target/arm: Set disassemble_info::endian value in disas_set_info()
  target/microblaze: Set disassemble_info::endian value in
    disas_set_info
  target/mips: Set disassemble_info::endian value in disas_set_info()
  target/ppc: Set disassemble_info::endian value in disas_set_info()
  target/riscv: Set disassemble_info::endian value in disas_set_info()
  target/sh4: Set disassemble_info::endian value in disas_set_info()
  target/xtensa: Set disassemble_info::endian value in disas_set_info()
  disas: Remove target_words_bigendian() call in
    initialize_debug_target()

 disas/disas-common.c    | 13 ++++---------
 target/alpha/cpu.c      |  1 +
 target/arm/cpu.c        |  2 ++
 target/avr/cpu.c        |  1 +
 target/hexagon/cpu.c    |  1 +
 target/hppa/cpu.c       |  1 +
 target/i386/cpu.c       |  1 +
 target/loongarch/cpu.c  |  1 +
 target/m68k/cpu.c       |  1 +
 target/microblaze/cpu.c |  5 +++++
 target/mips/cpu.c       |  3 +++
 target/openrisc/cpu.c   |  1 +
 target/ppc/cpu_init.c   |  2 ++
 target/riscv/cpu.c      |  9 +++++++++
 target/rx/cpu.c         |  1 +
 target/s390x/cpu.c      |  1 +
 target/sh4/cpu.c        |  5 +++++
 target/sparc/cpu.c      |  1 +
 target/tricore/cpu.c    |  6 ++++++
 target/xtensa/cpu.c     |  5 +++++
 20 files changed, 52 insertions(+), 9 deletions(-)

-- 
2.47.1


