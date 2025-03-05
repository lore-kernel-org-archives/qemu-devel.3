Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 405CCC282DE
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 16:13:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tprMh-00036K-Bg; Wed, 05 Mar 2025 11:12:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tprMc-00034z-6R
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 11:12:54 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tprMa-0007YU-JK
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 11:12:53 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-390dd3403fdso5981744f8f.0
 for <qemu-devel@nongnu.org>; Wed, 05 Mar 2025 08:12:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741191170; x=1741795970; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=eULSMR+wOPom3XwDZHhHaMYxsR4PJeNusGTgEDgMQis=;
 b=BxSLhhf/g8rAJnynhuOD14+idpEn/O5ata/V3BK3b+bbyzJhlM1dQTVV0wAGm1pdFB
 a1kyxWDY5ouSBny3MKPOd8S2V1wC1C3vahMucp3Snvjo0xOVUOWk27/UdZaAbVc+jAhZ
 arQaeW6Eh0O5I5C8tXUddeybylFzjeUfxvcmtetuwexcRNOjVWv/EHP+OJDCBeAx2rDX
 +5El08uidhBW9Pap1XaCMEcXjLunkcVdImBVjPfg/GVpyQ6mBdGwvBCD1Gxq6UkskNBU
 1xnrQNigHGy7x2HRw8+P3W2/yLV/W2tOIKn4GJk74uToSZwdytvk1L+yIPDZfkIKPGOU
 bj+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741191170; x=1741795970;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eULSMR+wOPom3XwDZHhHaMYxsR4PJeNusGTgEDgMQis=;
 b=KHD4HAe28OpCJSq6Y9uuB/t6mMPGdSCBRohqeIe7T95g5g6PiCmwDV6aeoGo+ZmTNb
 jpIYo8VTtE3q9FfWvojDIMiYWdGhDu9y4x9EXO+1xzu3wW9ASMjJDCD1uC4C3pwuelSV
 b7SbzqfQFZGOrW3LpVI8CDyokB6AGcYMCCQEeXmnfgcPU1lk18BIo/SR2adkmtvgVQ5v
 i7HBVXqHsZUXuz/v+1NesJ1tWmdXKzPqiGYiU8+xmuieMz0mb+6FiR519cTUkOWNIUVm
 kL5+nspYEQw+csQ8QZvmu1iYdw6/8ot1rgILX/aeEz8hBV7HiqDaC6PG3idOKefWg1BX
 d35w==
X-Gm-Message-State: AOJu0Ywr73+5JWeATZQamIfPbmC+lXH9YJxw7oKeqWJ4FXysCxMAYfe6
 WBmbJgiSn78vIsCtK//u7TuCkkuKtIShyMnLZfUL7nGFdO9aK6N5tQKjMhwDYprUcW8iIa0UfjE
 GwFc=
X-Gm-Gg: ASbGncuk+pTlvJk10/Xpo97lIWcIKQIcC/sEoOMqUGCWjoP3/zG8ebooJN7Ptqz0pw7
 XiMVVLvZVny0I/Qw5JdVq24ltta4t8arh6iyoaw4kx9d/SiKkBB5zk3brtLrHt//fbjIFFPfs6Q
 xYIGy0KIlObTzslRGP1MX676rGXyP+qcJgHyDter7i4k/kGmUTgbXPpHJwjvRw+odjBTo22db73
 pcFs9/yTvVgQuSGG5Hbo66o/3b+Rr/I70IejV1fo1Y6Rz8itbb2wT/lA9TTi5g/744DU+t1ANGi
 OwLfAGRqhJUiRkynZzLHFLO5z5pKFCKvE84xUWcdaQ7RVlvoUy2uOJs0DSSHSEE6taAzajlTI3h
 Py9OdMwpuw0k5r6YZYbA=
X-Google-Smtp-Source: AGHT+IEYQibmHjw9N7LchBFy6y339Sg5OLg0NcqSCdtZ2kKQKuxt6kE3aOx+yP0Jn5TOb4rm6hpdDA==
X-Received: by 2002:a5d:588b:0:b0:390:ebae:6c18 with SMTP id
 ffacd0b85a97d-3911f740b6amr2820440f8f.12.1741191169879; 
 Wed, 05 Mar 2025 08:12:49 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912933c050sm41438f8f.100.2025.03.05.08.12.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 05 Mar 2025 08:12:49 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-arm@nongnu.org,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH 0/4] hw/arm: Register target-specific QOM types at runtime
Date: Wed,  5 Mar 2025 17:12:44 +0100
Message-ID: <20250305161248.54901-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

In preparation of having a single binary for both ARM and
Aarch64 targets, unify raspi & aspeed by replacing the
compile-time TARGET_AARCH64 check by a QOM runtime call
on legacy_binary_is_64bit().

No behavior change with current binaries:

  $ ./qemu-system-arm -M help | fgrep raspi
  raspi0               Raspberry Pi Zero (revision 1.2)
  raspi1ap             Raspberry Pi A+ (revision 1.1)
  raspi2b              Raspberry Pi 2B (revision 1.1)

  $ ./qemu-system-aarch64 -M help | fgrep raspi
  raspi0               Raspberry Pi Zero (revision 1.2)
  raspi1ap             Raspberry Pi A+ (revision 1.1)
  raspi2b              Raspberry Pi 2B (revision 1.1)
  raspi3ap             Raspberry Pi 3A+ (revision 1.0)
  raspi3b              Raspberry Pi 3B (revision 1.2)
  raspi4b              Raspberry Pi 4B (revision 1.5)

Based-on: <20250305153929.43687-1-philmd@linaro.org>

Philippe Mathieu-Daudé (4):
  qom: Introduce TypeInfo::registerable() callback
  hw/arm/raspi: Replace TARGET_AARCH64 by legacy_binary_is_64bit()
  hw/arm/aspeed: Replace TARGET_AARCH64 by legacy_binary_is_64bit()
  hw/ppc: Remove TARGET_PPC64 use in ppc_create_page_sizes_prop()

 include/qom/object.h | 1 +
 hw/arm/aspeed.c      | 8 ++------
 hw/arm/bcm2836.c     | 6 ++----
 hw/arm/raspi.c       | 7 +++----
 hw/ppc/fdt.c         | 5 +++--
 qom/object.c         | 4 ++++
 qom/trace-events     | 1 +
 7 files changed, 16 insertions(+), 16 deletions(-)

-- 
2.47.1


