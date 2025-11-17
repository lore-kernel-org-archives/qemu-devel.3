Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA144CEACEF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 15:42:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vL1Mm-00080V-AB; Mon, 17 Nov 2025 10:42:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vL1Mf-0007zk-Pd
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 10:42:03 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vL1Mc-00069O-MA
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 10:42:00 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-42bb288c17bso1241426f8f.2
 for <qemu-devel@nongnu.org>; Mon, 17 Nov 2025 07:41:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763394116; x=1763998916; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=xYeIl3mtcWUCJeVXRBw8qX4nIcjFSObNWJG++fEgW+4=;
 b=FM9jtyqi2CR1Jv5BldYrfS8W2sJJW673psLYvgT91w2cEstCf/IfN642rFZzGYGblO
 eHcYpnm7L4OfVUeGtTIW5FXwUMT5bZYcLJ+ONMqIb6UQ1vGdQNXQatcZjARwY3z3i/Al
 qWAIBISCbReFd8bR9AuQNEk2iqWvrcTH/4x9puKSWL3FvmpU7/vLFMCGOmFlRF831nym
 RBom90SD++Z8y0lnpgZeXgBJtwo6HFg3Y3iTZRQjS2x5HcuK67ktdqYT+2mXmScI3iSk
 rjvOBt0+ePfv9r8oOamRPwW3iEmItHQ6KtR8j3ydaKc1ByqKawOnTnqiilILpCw1eLRW
 I7Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763394116; x=1763998916;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xYeIl3mtcWUCJeVXRBw8qX4nIcjFSObNWJG++fEgW+4=;
 b=m8ZvBXg4KextVGUW7l8S0turbvtsmxD9Nz6jhtcviM2pkxUNWB2hpx3SOdhKY8Y2Oo
 qvvQ7R8p1MjAw2K6RzAKth3fwHg06g3hxKvMaJ5Fg/D6PNxgmT1Iysng0i8mrcqsJe6E
 9rQfNaupeEGPhAuz8OYAQuCq1xP4GXf8uZg4e2Dw8SarhiI+Ie0b23vnqFfQZYWBzqec
 rYYOcmSX+XCzlpMWIiQRQ//C67GBuqcZHCZEc5+oP/tY068ykE4MWMNkFdPefV5x2hxq
 ya58uVFEWmWLfhtjL70OzHHLg65GaVpG6tfcP077Huwf58tkay75TyWySkbbrU+EnVx2
 QkPg==
X-Gm-Message-State: AOJu0Yzw0c33rhcFBt3zni0Igp6nVIgXLf1lBe2+fujOLJlOOMeBJTW0
 HdQGC9qaJBFSt9uZWKfayqfWAvyEf4eb1AbF3ZIESH7Rh3uiZd09PGDmbE40VDhxzb1gDUwnN5Y
 /2umsBocSLA==
X-Gm-Gg: ASbGncv7E+92i7aaNE9jMvSt1xMlMdtvqo1tIeQ2J5cEpTqNSequX+jBgAU9GOd8sII
 /Yn3fDsLpvX8a4NKtGNskOSsUlekDunM1E/860LnnIYCCjpGwczMn04zDTjc5WM6v4Ebp/c8GUj
 sQ/0p8Oovr9r7GEZIZopyE4fKkt8amE3VRQk5irgV8mx0TfpaDEtkDMZra5zhw+EovIVP7mlFTO
 ZdqnBNluPaQTuFFfE8rpakkTFLdqRZNuh8MbkRrn0Mpx21cx47Bn9i/4VVeWysW6h2NtCUXmncd
 UoYSTnxS0Bup99Mewwkukcr3BGxhbul4lOx62dGXqQkd4FjojvsgbS8lg6jfABPx8cvXgFB1IvI
 aoH/zf6dEV6h3jgKxl7QjusCVBaXEAMg9wP+LwpLGxSqjVxAUgDRasyPc3MKBhxx40AoQRGzmzA
 KJmAMc+iefUtsetDcpRct76ByZZClq808ZV8XygyoXuItUFaxDZw==
X-Google-Smtp-Source: AGHT+IHAIFOWTLVJ0JjdatGPqaRU28JD/MLlFroeORzmoKsKYRcTfVUHjfkhYhIhD/a5PvOqOPH9wA==
X-Received: by 2002:a05:6000:64a:b0:42b:47da:c318 with SMTP id
 ffacd0b85a97d-42b593737d4mr10604706f8f.52.1763394116571; 
 Mon, 17 Nov 2025 07:41:56 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42c97745f79sm12620833f8f.23.2025.11.17.07.41.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 17 Nov 2025 07:41:55 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH-for-10.2 0/2] tcg: Remove support for 32-bit arm hosts
Date: Mon, 17 Nov 2025 16:41:52 +0100
Message-ID: <20251117154154.79090-1-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

32-bit hosts are deprecated since QEMU v10.0.0; we already
removed support for MIPS and PPC hosts. Time for ARM removal.

Based-on: <20251117140420.62193-1-philmd@linaro.org>
          "roms: Do not try to build EDK2 for 32-bit ARM on Fedora"
Based-on: <20251117153756.78830-1-philmd@linaro.org>
          "docs: Mention 32-bit PPC host as removed"

Philippe Mathieu-Daudé (2):
  gitlab: Stop cross-testing for 32-bit ARM hosts
  buildsys: Remove support for 32-bit ARM hosts

 MAINTAINERS                                   |    6 -
 docs/about/removed-features.rst               |    4 +-
 configure                                     |   39 -
 meson.build                                   |    5 +-
 linux-user/include/host/arm/host-signal.h     |   43 -
 tcg/arm/tcg-target-con-set.h                  |   47 -
 tcg/arm/tcg-target-con-str.h                  |   26 -
 tcg/arm/tcg-target-has.h                      |   73 -
 tcg/arm/tcg-target-mo.h                       |   13 -
 tcg/arm/tcg-target-reg-bits.h                 |   12 -
 tcg/arm/tcg-target.h                          |   73 -
 tcg/arm/tcg-target-opc.h.inc                  |   16 -
 tcg/arm/tcg-target.c.inc                      | 3489 -----------------
 .gitlab-ci.d/container-cross.yml              |    6 -
 .gitlab-ci.d/crossbuilds.yml                  |    7 -
 common-user/host/arm/safe-syscall.inc.S       |  108 -
 python/qemu/utils/accel.py                    |    1 -
 roms/edk2-build.py                            |    4 -
 .../dockerfiles/debian-armhf-cross.docker     |  188 -
 tests/docker/dockerfiles/debian-bootstrap.pre |    5 +-
 tests/lcitool/refresh                         |    5 -
 21 files changed, 4 insertions(+), 4166 deletions(-)
 delete mode 100644 linux-user/include/host/arm/host-signal.h
 delete mode 100644 tcg/arm/tcg-target-con-set.h
 delete mode 100644 tcg/arm/tcg-target-con-str.h
 delete mode 100644 tcg/arm/tcg-target-has.h
 delete mode 100644 tcg/arm/tcg-target-mo.h
 delete mode 100644 tcg/arm/tcg-target-reg-bits.h
 delete mode 100644 tcg/arm/tcg-target.h
 delete mode 100644 tcg/arm/tcg-target-opc.h.inc
 delete mode 100644 tcg/arm/tcg-target.c.inc
 delete mode 100644 common-user/host/arm/safe-syscall.inc.S
 delete mode 100644 tests/docker/dockerfiles/debian-armhf-cross.docker

-- 
2.51.0


