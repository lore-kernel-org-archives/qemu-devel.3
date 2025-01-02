Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF179E77197
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 21:19:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTSaD-00041T-JS; Thu, 02 Jan 2025 16:18:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tTSZy-000407-G5
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 16:18:07 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tTSZw-0001L6-Li
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 16:18:05 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3862ca8e0bbso9067926f8f.0
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2025 13:18:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735852682; x=1736457482; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=wMAJRJAkKvu+7ixiGIgm9NO78i/9tU4KbqtSnkAIp08=;
 b=Cmcu7FGX9gBY8suvU5aA5Oehzaz6TUKdBq66CcozNVUnlg4Qqcoz1GJpfPmnkVgEIm
 RMvrbNNwkOvxz1azsXKmYCBsQzEKH4v53r8J2dCnCttdQFM3zhsVZ0Fq6HlUeG5A3F/I
 CbCz6+CfEuWlkjQdBgtg0aKSZpd/uKebnVF8VIMUDIVI/Ke7F1r7EPujn2luOOdBpFy9
 4/H9EDBB0geJkW7vEqW6N+1r5EeOiNM5tcaGJtf6JB72G8XTGzA2hRLy1fm8Yb47UMBn
 soaSCnyZQ772S5FsqtOR81TvVDKgntsz9BDlInvFZMq3QzAbHUynO04DkX9dJKgFq9hf
 kAYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735852682; x=1736457482;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wMAJRJAkKvu+7ixiGIgm9NO78i/9tU4KbqtSnkAIp08=;
 b=n+I0pCLoD/5/9HHAic8BncYVxJXiZe2WfNxBcyIMu10oJjBzl/idZzj0arJ3WFlo0H
 OjZdrtPGwd2kBtC80tjUb+cnbTx61nHRq0y7rJttAIgOdq+mnNvAM7HuVjrosxuPaMVC
 nTmLfDH/QbPm8kS/1yHVX4asf88ttaIh3GuWFGLpI1zCjor4sy18/nLOd82LCe16CyCz
 6gI/QQ6MEimMfzxWBBsfJNIUWh12XLgUAKFi4jtWBkmdPWydVmqF5RFOUVOD/Ay//5l/
 SNkrMTOJ6dr+IjrJa9OKmbmc5aibnJ1Kk3ip5OObQtO1PlmVFOW8vsKTbIKWZD8wJr97
 njPQ==
X-Gm-Message-State: AOJu0YzKLWPOv7wKkMW8GDIOQPPWDzpBwJHsFPLGA9GEdjLl9PqmSq31
 SKt9Ihav8xhZSAqNALs3muVMCjQ4dYWCp+FtLKfNKClrGpMdI+U8B7/PmdjvcxrQK52DtqNz+Tw
 yyyBXLw==
X-Gm-Gg: ASbGnctjt0bLU1wWe94nhlUbB8BziS1RGG73tov4LBOUE0lVxENJAkJTBkI9yyvpAa1
 PfB0Xl+2ObGLg1MWB26Pv8kfZpTTCtbEJBXX6jaWawcPfdP8gCQo24wWg7jIUZNU6E1h5rNz4uW
 sWEslemM6K09C2g7ouaDqMk5J3r/68p2Cj2eEyO86bjO+3f+Jlzn7nTSGIhN5+Sl8h/NmNAJFlQ
 IPWx+jkzBXLMXlhGlDwHAUDaqSXPisanXbsA2SHMUjJWc5Kq8RjoFsdiDJESimpwjYUoUVPlvwx
 scpitm5OHw9B5hBQUVvkeWHMSxp89e0=
X-Google-Smtp-Source: AGHT+IFuW3tyNIYDS+29N8PpC8hwZkQCJi3VhvNvAO/VoeqXFTrOF41nHQMn7j5MRlfqp01c7bRzdg==
X-Received: by 2002:a5d:648d:0:b0:382:4b9a:f51f with SMTP id
 ffacd0b85a97d-38a223f82afmr41619242f8f.47.1735852682268; 
 Thu, 02 Jan 2025 13:18:02 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c8b874asm38986775f8f.109.2025.01.02.13.18.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 02 Jan 2025 13:18:01 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 Zhenwei Pi <pizhenwei@bytedance.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Fam Zheng <fam@euphon.net>, Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH v4 0/8] QOM: container_get() removal
Date: Thu,  2 Jan 2025 22:17:52 +0100
Message-ID: <20250102211800.79235-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

Respin of Peter's v2:
https://lore.kernel.org/qemu-devel/20241121192202.4155849-1-peterx@redhat.com/

'The series is about container_get() and its removal.'
(See v2's cover).

Since v3:
- Implement qdev_create_fake_machine() in single patch (peterx)

Since v2:
- Create fake machine container for user emulation to avoid:

  $ ./qemu-x86_64 /bin/echo foo
  qemu-x86_64: ../../hw/core/qdev.c:825: qdev_get_machine: Assertion `dev' failed.
  Aborted (core dumped)

Peter Xu (6):
  qdev: Make qdev_get_machine() not use container_get()
  qdev: Add machine_get_container()
  qdev: Use machine_get_container()
  qom: Add object_get_container()
  qom: Use object_get_container()
  qom: Remove container_get()

Philippe Mathieu-Daudé (2):
  qdev: Implement qdev_create_fake_machine() for user emulation
  system: Inline machine_containers[] in
    qemu_create_machine_containers()

 include/hw/qdev-core.h | 20 ++++++++++++++++++++
 include/qom/object.h   | 21 ++++++++++-----------
 accel/tcg/tcg-all.c    |  8 +++++++-
 backends/cryptodev.c   |  4 ++--
 chardev/char.c         |  2 +-
 hw/core/gpio.c         |  3 +--
 hw/core/qdev-user.c    | 21 +++++++++++++++++++++
 hw/core/qdev.c         | 21 ++++++++++++++++++---
 hw/core/sysbus.c       |  4 ++--
 hw/i386/pc.c           |  4 ++--
 qom/container.c        | 23 -----------------------
 qom/object.c           | 12 +++++++++++-
 scsi/pr-manager.c      |  4 ++--
 system/ioport.c        |  2 +-
 system/memory.c        |  2 +-
 system/qdev-monitor.c  |  6 +++---
 system/vl.c            | 19 ++++++++-----------
 ui/console.c           |  2 +-
 ui/dbus-chardev.c      |  2 +-
 hw/core/meson.build    |  1 +
 20 files changed, 113 insertions(+), 68 deletions(-)
 create mode 100644 hw/core/qdev-user.c

-- 
2.47.1


