Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D61D4F55449
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 03:57:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vv61z-0003xq-8I; Tue, 24 Feb 2026 22:57:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vv61x-0003xi-R8
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 22:57:45 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vv61w-0001hF-7N
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 22:57:45 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4834826e5a0so76464835e9.2
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 19:57:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771991862; x=1772596662; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ukzxCsnUD20tsJiQHHLFwK5qahbxJbMxKECzqGh9PP4=;
 b=fdXB/WfeXpo4UY9JjC2LlhT1NB9lpGjqNaRPmdqxhHEJoovtnIrpwR8yLfL2+ytJcN
 Sm/PLW/1Cq371XIDC/Kjn5nZ0RcucEt1NXIYHPwIWnWnKTfNR7Jn1rwCd7dDRLTVEhq9
 aC1t71vBWtQ+m22B/z4iv1/DodIixddFd8XjStjS5Iq8M7VZK+ywQXNaCe+Dsa3IG6Gi
 ofkMP/MNECTaX4ECc6L/azfuJbhtoKbeMVritge5r5K6K3Lv2+Hu0RnEIT7qa23sfQhv
 Jt81lwe7fT1NNFLA22rpMYAM+nqAfDIc82m2i2iUna0svuIw9WvYVDoAnNXPCTxb8cjR
 mdRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771991862; x=1772596662;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ukzxCsnUD20tsJiQHHLFwK5qahbxJbMxKECzqGh9PP4=;
 b=JJm7iXsC0hI1/c4Zzy4YY1FQSgSioCUHmhtZwampmPAvqF7+0eg0cPpJdhF83bSWvo
 m9b4reuFUbL5c8/mVx3A8qHDXL6XuNClVOIjY4ICgMLq4wnfv5fs4woicdwfqrMAKWWI
 5/ABIvwVEArr+hcszimggdIu1scsOELObdOGoXkUFf+2D9Wbz2UcCTdLlb+q2ShWY8Dt
 fa7zyskbgCS1b69uNl+DNXYuviOpBmsHzLsLug2qJkit2ZitWwaLzK4rFWVNf1C2WZhE
 ChSGVax034fbKxipGURJK01A99uMopvni50TdTeu4k482tERQJ4gX/gSd/gJKVSsSATk
 Fi+g==
X-Gm-Message-State: AOJu0YyopP/j74MD4XYxfaeM/6XWZmTTaefPN5XwOFDymKPiVKwEe7Cw
 GbbxMR8r9M4bao8kBy3OtY91wMNXr7PXU+FrN7MJJWocWJapcF3S8CrIZTGcowrkBPw9VZQtwRf
 fZ21cPCY=
X-Gm-Gg: ATEYQzwu8BKQFDrOai30mZLFWyo1rHX+yZIkqs6aEWqIl4B3+TiA1e+KyfUq5+5rWD1
 mYO5gQ6lny4hwdgrooORzFMohO8TpWGv+taPELzPzjPix+BwVZUBTtqEqC3FuPnvuOr14jK8zry
 Pby9Kuthl4occOCspTznuJlsK/0I5KsmiSztNjCkpJ/YbVCp8MlpJvFT6MoHJVxogYCOr9uyc7S
 bYMoXWs/3DX6iY6AGJvEKkRUOuwQHgJAsuhLacWG443NFy9DiYLrv5BpqBxlBNTmsnEybE+vr5i
 eCifK0WSe9r0ZhBCVW/o249ZgmSXpNtgjyGik06gn9F5FOsVK87UTrflMrl1HgY6PiE3k4pox5Y
 h/9eMWXDVzDRVEqmTkPcwUuT5V1Tn5eA7kD78ShK++eEFAg9u3mNx693WpuZOwwgkJmo7aYs+N7
 B6jfaP7lVeC5E6Gs4FGKX7YxA719Rv0TFIvKnK9P7gthJoA9/mlqcYuEpQ4RvwfOroIb7BYVgY
X-Received: by 2002:a05:600c:c167:b0:480:3a72:524a with SMTP id
 5b1f17b1804b1-483a95e9643mr207069835e9.19.1771991861606; 
 Tue, 24 Feb 2026 19:57:41 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bfb789efsm2424045e9.2.2026.02.24.19.57.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 24 Feb 2026 19:57:40 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 00/11] buildsys: Build most stubs once
Date: Wed, 25 Feb 2026 04:57:28 +0100
Message-ID: <20260225035739.42848-1-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Missing review: #5

v2: Move acpi_send_event() declaration

Use meson magical machinery to build stubs once,
instead of one time per qemu-system-FOO binary.

Philippe Mathieu-Daudé (11):
  meson: Include various directories providing stubs before libqemuutil
  hw/acpi: Move acpi_send_event() function out of acpi_interface.c
  hw/acpi: Move qbus_build_aml() function out of acpi_interface.c
  hw/acpi: Always link QOM interfaces with system binaries
  hw/nvram: Build fw_cfg-acpi.c once
  hw/acpi: Build stubs once
  hw/display: Build stubs once
  hw/net: Build stubs once
  hw/*: Build stubs once
  fsdev: Build stubs once
  semihosting: Build stubs once

 meson.build                                   | 14 +++++-----
 include/hw/acpi/acpi.h                        |  1 +
 include/hw/acpi/acpi_dev_interface.h          |  2 --
 hw/acpi/acpi_interface.c                      | 19 -------------
 hw/acpi/aml-build.c                           | 11 ++++++++
 hw/acpi/core.c                                | 10 +++++++
 hw/display/acpi-vga-stub.c                    |  1 +
 .../rocker/{qmp-norocker.c => rocker-stubs.c} |  0
 fsdev/meson.build                             |  3 +-
 hw/acpi/meson.build                           | 28 ++++++++++---------
 hw/cxl/meson.build                            |  4 +--
 hw/display/meson.build                        | 19 ++++++-------
 hw/i386/kvm/meson.build                       |  5 +---
 hw/mem/meson.build                            |  4 +--
 hw/net/meson.build                            |  3 +-
 hw/nvram/meson.build                          |  4 +--
 hw/pci/meson.build                            |  2 +-
 hw/smbios/meson.build                         | 10 +++----
 hw/usb/meson.build                            |  3 +-
 hw/virtio/meson.build                         |  9 ++----
 semihosting/meson.build                       |  9 +++---
 21 files changed, 80 insertions(+), 81 deletions(-)
 rename hw/net/rocker/{qmp-norocker.c => rocker-stubs.c} (100%)

-- 
2.52.0


