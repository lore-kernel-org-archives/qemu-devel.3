Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E20F7CD3443
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2024 15:40:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slVdY-00020S-3H; Tue, 03 Sep 2024 11:40:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1slVdW-0001vt-Ce
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 11:40:06 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1slVdT-0006LE-AR
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 11:40:06 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-42c7a49152aso35685715e9.2
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2024 08:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725378001; x=1725982801; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=IjJBVSJBVK08cjjPKvTMib0MeQYe05YnRDAmcYrt6jk=;
 b=Au4ds6B6bF+VKU7tzz1uruHeWx1OvCiVQsrC0ibBqfTiWmhdqKMLxkJNV2vnkIxKsI
 jKZDSeNCKCHrVzKGr54ArtODkcJPkD2YqEVRJGgB0Ouz6qp4MMTs1aNBpbD5M7ZCRPhn
 2KHZdu1MBKt3XwTy6f5M+pu7nSF0y3jIY24j0YugAm/fdmAcHgOu1iZQQURmtJrLukQD
 GTsKgHm5hXtLOzvg2HWfN8n9ciklTJBmQayTxqMnqEgijrQLcve70sKr68tzJTtt0Zw7
 n74rTro0+xwF4k3jh/MdiLp0Xwt42uheyrM6TBSJMk7fDo/1EwVBDUpQTWF0NuCBIw4e
 FAUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725378001; x=1725982801;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IjJBVSJBVK08cjjPKvTMib0MeQYe05YnRDAmcYrt6jk=;
 b=QU1vGU601neYWAumZzBVoFN7Wm4C/YV50+NkcpReLTCOmvFRF28Xkxz1fVkhEFPHI4
 tSyE7ytArIy21KWDMeY0X+HQnyenOQlNP/JEruMabPQzHRrwaQhpz0bfPdra1pVXD2vP
 SVlQ8BMne7j4u8io8qrKE/UY0zdwuaTX9Uv9ut/rLbh730o9Gr9NbB+GpleYH1B9w3Xw
 gjF9jkK94I4cjpGOfhqthSMcOXoge/OSGN5eG/fFD3Ib4dUjJqf7aYbERjHwHd6WcPIz
 edEv+CTri0sqm9uJpjohpQJaLfShS3/CD7Pr2BJX0fWmkBOaNYJ5YX92s5Bh/2uZ32N1
 92EQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUioN83QrW6qvEpwrtfoI5upfuBRDXCvzur+MNaBwr7k5nIr/uc1/JoS1KN3RBiub47UujrdHF2L693@nongnu.org
X-Gm-Message-State: AOJu0Yyzor0XxxuUF+43GKBX/W5SszsLvW3kd2awJ8zqnHf8aWGJgWmY
 snXDLI+bsXO/ta1ikbVGKHN19/KqU7VdabxEPwdszHnRtx/ieseTuJJ7syY9Yxw=
X-Google-Smtp-Source: AGHT+IEpEtpYtpauw7j1Ok3Y/v+8fst05IZgyvY/+Eyy77Hj6cUPjiUcQRUdI3KiGrNZF5bQY80N6w==
X-Received: by 2002:a05:600c:45c4:b0:425:64c5:5780 with SMTP id
 5b1f17b1804b1-42bb01ae2d7mr146314105e9.1.1725378001383; 
 Tue, 03 Sep 2024 08:40:01 -0700 (PDT)
Received: from localhost.localdomain ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42bb6deb303sm178363365e9.9.2024.09.03.08.40.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 03 Sep 2024 08:40:00 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Samuel Tardieu <sam@rfc1149.net>,
	qemu-devel@nongnu.org
Cc: devel@lists.libvirt.org, Magnus Damm <magnus.damm@gmail.com>,
 qemu-block@nongnu.org, Yoshinori Sato <ysato@users.sourceforge.jp>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/3] hw/sh4: Remove the deprecated SHIX machine
Date: Tue,  3 Sep 2024 17:39:56 +0200
Message-ID: <20240903153959.18392-1-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

Remove the deprecated SH4 SHIX machine, along
with the TC58128 NAND EEPROM.

Philippe Mathieu-Daudé (3):
  hw/sh4: Remove the deprecated SHIX machine
  hw/block: Remove TC58128 NAND EEPROM
  hw/sh4: Remove sh7750_register_io_device() helper

 MAINTAINERS                             |  11 --
 docs/about/deprecated.rst               |   6 -
 docs/about/removed-features.rst         |   5 +
 configs/devices/sh4-softmmu/default.mak |   1 -
 include/hw/sh4/sh.h                     |  19 ---
 hw/block/tc58128.c                      | 211 ------------------------
 hw/sh4/sh7750.c                         |  57 +------
 hw/sh4/shix.c                           |  86 ----------
 hw/block/Kconfig                        |   3 -
 hw/block/meson.build                    |   1 -
 hw/sh4/Kconfig                          |   7 -
 hw/sh4/meson.build                      |   1 -
 12 files changed, 7 insertions(+), 401 deletions(-)
 delete mode 100644 hw/block/tc58128.c
 delete mode 100644 hw/sh4/shix.c

-- 
2.45.2


