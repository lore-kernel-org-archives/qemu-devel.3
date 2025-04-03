Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D052DC3601A
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 20:34:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0RF4-0003yB-Ae; Thu, 03 Apr 2025 16:32:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0RF2-0003xZ-GM
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 16:32:48 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0RF0-00042C-Dz
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 16:32:48 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43ce70f9afbso13582125e9.0
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 13:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743712364; x=1744317164; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=p6BYkyZFOa9EORLlgbu2rbeQ2Eo+6KfAhtQGHxTMVXQ=;
 b=Vrh7ieoVsvBjE511QdVtJscunGJI0+VQKgDgYNeDq3Xepzj76E9HH8YAfxkR2vROfp
 EkJGIvgy56wu04Yvj3wuYleVjC7xJMzLlpZ7dH0u3dOl/E2QFSpQIVCNgEXh4EvOmD0W
 roU3JOroIuDmHWhgiIsbnR0YWxuskY8795UzQPXnsba+rOJFT8vkqxu29PJCYtqimyEL
 R+mMzd5oecNKsm9PDO2W51KKp1pBfJEm+CD4m66GehnzYNzEsaQQH/cJTCmofOzHmWlE
 b/1zfnHA217eZkmxNAYlcqnqbNrOTTq6MJZtAH1/1SUH9ixeXvffctSbje6EGzumjNOQ
 jWsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743712364; x=1744317164;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=p6BYkyZFOa9EORLlgbu2rbeQ2Eo+6KfAhtQGHxTMVXQ=;
 b=OxAlMQddeg8RdcWhYfQpDES8KhwcLzJzSStRlkLsv6QT/XUt/S0INutjR62ZdXsv/d
 fngEP2k0I4uXbYnM1/HCBTuHeV04VOkqXaV1+jA4/KpY6432osU3XqyRrozmdEUjQbRz
 jwblxgRGErOTAX48RVrHGl/Nq1CZSDzpc0VmtNogQaST5HI70PgPVrn8o4M7wzlyUF/D
 Op9j+s1khsKSrEvK61+Ya3ptIlheGIUrEje0qa2CUYfggWwrj7FzPzXG2lOLVaTDnFFB
 fYevAX52qcM39krjPQNUJN53kwkx+bh/PWggkN6bfnhHHzJ9zOtzmnJ2XEUFcyx0zeyj
 iNvQ==
X-Gm-Message-State: AOJu0YwTr8Wjt8vOJUQxVQfWUfBzUJe8lWZ8WlwM/iv855xZ029f9inO
 CCtkjvPeRhJoPU7oSLummOnRoO+EC9w2/1DL8kh/kGLlxIDRafQ0IQ/v2LUdsYA09IJQisFl6aE
 s
X-Gm-Gg: ASbGncs1ZywlKG8VkjnA3/Mm79bqd2N5GDMQcScLnCDgWAmzqLTUqheyU1O5WAbVEDE
 RvBZsZ9A1keR2vltUYlcuRnCvH7TIJimkamxbcPcVV3HFaFGGXQ2/WDP+Zb8/EC1mScm7BWy3TN
 Tx8+73crYuhCWBzD3t9Gz0Sswlz1Huw+7T/eK1IDButR08F8V8a4IOYh7lHhOK1vzCoKAAMJkUC
 OqpKN/iI/bGCIjWqOIlPFe/OyllyMTiWUk+hnoieASCuNYsrmfHNsz+9PxyLo7ielh9ZSZcUnlG
 zryloI5CQjfQBoBB5OW5y1JH+Qug/FqGrg3NujW99MPCqOi7ERqNDZGlBGQcPDsIMOU1sOIr3HL
 wDsi7Zy8hcA5m+voJP3Bi6KiO
X-Google-Smtp-Source: AGHT+IFXI7UFO9iJtwquNw+XMAT6mN1RVFnoXJQ3TLpbOlUUB+SN0oePfYsszoaGbZsVsYqd0lgpoA==
X-Received: by 2002:a05:600c:350b:b0:43c:eeee:b713 with SMTP id
 5b1f17b1804b1-43ed0d6b07cmr872025e9.20.1743712363631; 
 Thu, 03 Apr 2025 13:32:43 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ea97904b7sm59431815e9.1.2025.04.03.13.32.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Apr 2025 13:32:43 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH-for-10.0 v3 0/5] hw/arm: Tests fixes for 10.0
Date: Thu,  3 Apr 2025 22:32:36 +0200
Message-ID: <20250403203241.46692-1-philmd@linaro.org>
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

Hi,

I tried to gather all the hw/arm/-related patches for
the GitLab issues tagged for 10.0:

- trivial ones fixing / disabling broken tests
- disable the VMapple machine (not sure about it)

Regards,

Phil.

Since v2:
- Reword skipIfOperatingSystem() decorator
- Dropped ACPI patches

Philippe Mathieu-Daudé (4):
  tests/functional: Add a decorator for skipping tests on particular OS
  tests/functional: Skip aarch64_replay test on macOS
  tests/qtest: Skip Aarch64 VMapple machine
  hw/arm: Do not build VMapple machine by default

Pierrick Bouvier (1):
  tests/functional/test_aarch64_rme_virt: fix sporadic failure

 configs/devices/aarch64-softmmu/default.mak |  1 +
 tests/qtest/libqtest.c                      |  1 +
 tests/functional/qemu_test/__init__.py      |  2 +-
 tests/functional/qemu_test/decorators.py    | 15 ++++++++++++++-
 tests/functional/test_aarch64_replay.py     |  4 +++-
 tests/functional/test_aarch64_rme_virt.py   |  4 +++-
 6 files changed, 23 insertions(+), 4 deletions(-)

-- 
2.47.1


