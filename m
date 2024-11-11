Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5F7FD3ABF4
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2024 22:45:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAd9Z-0005ze-AG; Mon, 11 Nov 2024 17:45:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tAd9X-0005zT-OS
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 17:44:59 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tAd9V-0008GW-TA
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 17:44:59 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-37d3e8d923fso3566982f8f.0
 for <qemu-devel@nongnu.org>; Mon, 11 Nov 2024 14:44:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731365095; x=1731969895; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=HbptZfaMtZGTcm7Pug5x0xF4ndFJdzn3nDzgxt2Fk9I=;
 b=KLl7w6r86Tv2Zlq496clxQii8a9twYRBmNrZYrL+4VhcvRPOQkJrsvPW1BoPWzFyFT
 5Z+GV45871ucrNPzZGvRCe85eR4Me3xwhtgG4LFFe457+1bKTDadAQiOjKR4cjojAn4/
 T8/aMn6lbODkKC9VSFJ/Zv3fuDmO7gEc+fd7GKYgB8qdzAyGffJXsuAEoET7u8XrJGjQ
 pyzy3fUtzQ2F3hTPx9PuXw+rYX44qU80XryKwahvPm5MWpQdRiYhc9q3e5TH5SxZpdGX
 Y8Xkzkm/VPjf3jI/eYSkL9xRRxU9oNbR9EQZ3YaelvKTLQGBpOHqdRsuWGL2PwgskeX5
 n8ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731365095; x=1731969895;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HbptZfaMtZGTcm7Pug5x0xF4ndFJdzn3nDzgxt2Fk9I=;
 b=OYAk21iO51ltFMNoNum4HpgeBFEMlt/uKTW3eAqNMEbs/kUFI2o21ZTX5FW5v4jWFu
 J1ukQPLQKWFW9lTdRH0KaAe8RgS9dC7NkD367KnKKqUj0BMuRzNrCC8HgqfS3vO8mxoI
 zh8e3L5wROLLPOJxIN3Mu+l48WdI6/15Ki7z8+1oed6GSYDciSN8SlH2RJu1oLLO5jEA
 FKdfgOL9gjr59/PR9+WksgOfxqJhogBNGUVZXrV78QYs7GNxFByDgtD0yPMsUX8Gm9aQ
 cl4eWtLOnlfhzfHI+tkCiqiS+xl7G9HzXZZmgsowaLD3OUWbw9UhDI2WN5qU6VlyPGH7
 A78g==
X-Gm-Message-State: AOJu0YwMcOsq44oML5xgUYke9HuEKBOvbbPFh3gw6OHiQpzYEN/em9as
 WluLOyhOJKuc2jSrkGJuDPMNkIWVdXkiq5c/YxsH1GEkcLAiYrMrF3YvbgMNyTBaGcKrMpSgBj6
 l
X-Google-Smtp-Source: AGHT+IH+D+zD0SzeAZ+Sk1vYRa6XRg5LD0U16LncflvN8yPazci7/d2PGzIBd0XrQGonnb6vm0GeRw==
X-Received: by 2002:a05:6000:4028:b0:37d:476d:2d58 with SMTP id
 ffacd0b85a97d-381f18858b3mr12884195f8f.45.1731365095211; 
 Mon, 11 Nov 2024 14:44:55 -0800 (PST)
Received: from localhost.localdomain
 (vau06-h02-176-184-43-163.dsl.sta.abo.bbox.fr. [176.184.43.163])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432b05305a4sm190737885e9.5.2024.11.11.14.44.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 11 Nov 2024 14:44:54 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <arikalo@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 0/2] target/mips: Convert nanoMIPS LSA opcode to decodetree
Date: Mon, 11 Nov 2024 23:44:50 +0100
Message-ID: <20241111224452.61276-1-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

Yet another 2 patches extracted from an old branch
I'm rebasing. Trivial decodetree conversion of LSA,
however this introduce the basis to convert nanoMIPS
opcodes.

Philippe Mathieu-Daudé (2):
  target/mips: Introduce decode tree bindings for nanoMIPS ISA
  target/mips: Convert nanoMIPS LSA opcode to decodetree

 target/mips/tcg/translate.h              |  2 ++
 target/mips/tcg/nanomips16.decode        |  8 ++++++++
 target/mips/tcg/nanomips32.decode        | 16 +++++++++++++++
 target/mips/tcg/nanomips_translate.c     | 26 ++++++++++++++++++++++++
 target/mips/tcg/nanomips_translate.c.inc | 16 +++++++--------
 target/mips/tcg/meson.build              |  3 +++
 6 files changed, 62 insertions(+), 9 deletions(-)
 create mode 100644 target/mips/tcg/nanomips16.decode
 create mode 100644 target/mips/tcg/nanomips32.decode
 create mode 100644 target/mips/tcg/nanomips_translate.c

-- 
2.45.2


