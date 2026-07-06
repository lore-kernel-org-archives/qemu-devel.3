Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CF78C43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 23:02:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgsJG-0001Rz-QF; Mon, 06 Jul 2026 19:01:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3qzNMagYKCpwPEPQONCKKCHA.8KIMAIQ-9ARAHJKJCJQ.KNC@flex--titusr.bounces.google.com>)
 id 1wgsJF-0001PU-0L
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 19:01:05 -0400
Received: from mail-pg1-x54a.google.com ([2607:f8b0:4864:20::54a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3qzNMagYKCpwPEPQONCKKCHA.8KIMAIQ-9ARAHJKJCJQ.KNC@flex--titusr.bounces.google.com>)
 id 1wgsJC-00073D-MD
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 19:01:04 -0400
Received: by mail-pg1-x54a.google.com with SMTP id
 41be03b00d2f7-c8895156101so5405646a12.1
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 16:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1783378860; x=1783983660; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:from:subject:message-id
 :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
 bh=jJ/QGDIwxxWojel6t16Pw/gPL5Ob54izX9DwQJLsiuk=;
 b=QMdzTDmvD4oyh6/kuvkV8qWLAq+j2GDzVmPVm6TYhzqaj3BbgrETgKg9t6ZsHe7ljw
 mEQcKLbDgRvvgb/+TyXq46gSdkQFBlZopPY2PRbDSk7UJIQmfMKfjdIHJLjnZ3HCbMA9
 RqsOh4ZgReJMn63wxXkP7FjX+3lkgvvOpSasF6UioKzRWHqaIjcq4gRgpMGfB2CEYB3/
 zKQrwEdj5/9rp4rOhchOS/VQa/4Yhx7CmHgbEnBD70HG+XlMg7/g8T+PRIJnUpE2l1W9
 EwTyPjbYaESkc1hQoMagKcp6KLAvKLsjIoJ2GkxMQ/JIM1RMAXtgmtyFd+mFNw2xwGjJ
 ZkIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783378860; x=1783983660;
 h=content-transfer-encoding:cc:to:from:subject:message-id
 :mime-version:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jJ/QGDIwxxWojel6t16Pw/gPL5Ob54izX9DwQJLsiuk=;
 b=ThCgfOrLZeNmDLPPfmF8jV5D1FYu/MiKxFpP2fYPxl5NJQw3o3doa9dT63PCKDrSuA
 zZuXCWrFyuHn7XwXZKkRas4oXTTHsME/NnCB5ZAeyk4Wap4b3B0NJHsbgvS9BkB73zQc
 hcEeKF2gC9dQhDqU5VwRBXj1Khpy4wFVT/M/Jc6dsVtBzl/8IILmvnOeJqo9Uy5Kqyna
 iA6cBHTCp+ucROdwjf9D+/DnTS7EDphKNJmeQqzcb+cOQ3S+/RivD2ZxddRZOgMpYJUC
 HNl7qXzuEqpJJBhSduYNL7rpDDzgKZIJf2CSFG4ZWD7AWQJAgP9N0p/vc//S5OsUPAuC
 iSHQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrCFLEAR+fUcXD6MusQA+gl1GgxvI0iWWSIaMt/R5Fftqv+CaqKgM3isvYxs8Nnf7NDCeNnr79qAL9E@nongnu.org
X-Gm-Message-State: AOJu0YwzMi7+lcDJ+CstFA2sNmgS3Lljo6JTUDSXVmm3/Nf8Lkp2WTds
 xq1WBOdW/QKEuvRz8u0dUcJmhr0SlDquac9Qay2FLc8/qedmSI4P9SMWCFJk+l+ZW9ZX7tRgD4+
 n01J+2g==
X-Received: from dyw18.prod.google.com ([2002:a05:7300:8812:b0:30c:83f3:7370])
 (user=titusr job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:d488:b0:3bf:983d:e9b4
 with SMTP id adf61e73a8af0-3c08ee92daemr3189828637.33.1783378859741; Mon, 06
 Jul 2026 16:00:59 -0700 (PDT)
Date: Mon,  6 Jul 2026 23:00:49 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.rc2.803.g1fd1e6609c-goog
Message-ID: <20260706230056.1888992-1-titusr@google.com>
Subject: [PATCH 0/5] hw/i2c: PMBus updates
From: Titus Rwantare <titusr@google.com>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, kfting@nuvoton.com, 
 imaginos32@gmail.com, wuhaotsh@google.com, philmd@mailo.com, 
 Titus Rwantare <titusr@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::54a;
 envelope-from=3qzNMagYKCpwPEPQONCKKCHA.8KIMAIQ-9ARAHJKJCJQ.KNC@flex--titusr.bounces.google.com;
 helo=mail-pg1-x54a.google.com
X-Spam_score_int: -94
X-Spam_score: -9.5
X-Spam_bar: ---------
X-Spam_report: (-9.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FUZZY_MILLION=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=unavailable autolearn_force=no
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

This series adds various fixes to PMBus and SMBus support.

The maximum SMBus data length is increased to 257 bytes, (payload is 255 by=
tes) to support SMBus 3.0 block transfers. SMBus devices don=E2=80=99t have=
 to report their specification version, and this change allows us to enable=
 newer PMBus devices that are based on top of SMBus 3.0.

Additionally, this series:
  - Adds the `DIV_ROUND_CLOSEST` helper macro, lifted from the linux implem=
entation, to match the rounding in linux drivers.
  - Adds PMBus helper functions to convert sensor values in milliunits to/f=
rom linear mode format (Linear16).
  - Adds helper functions for converting data to PMBus Linear11 format.
  - Adds a fix that the PMBus output buffer is cleared on new write transac=
tions to prevent stale data reads, this resolves an issue with guests perfo=
rming incomplete reads.

Changes to the adm1266 are in a separate patch series.

Titus Rwantare (3):
  osdep: add DIV_ROUND_CLOSEST
  hw/i2c: pmbus: add milliunits linear mode functions
  hw/i2c: pmbus: add Linear11 format helpers

titusr (2):
  hw/i2c: pmbus: clear output buffer on write
  hw/i2c: smbus: increase MAX_DATA_LEN

 hw/i2c/pmbus_device.c         | 61 +++++++++++++++++++++++++++++++++
 hw/i2c/smbus_slave.c          |  4 +--
 include/hw/i2c/pmbus_device.h | 64 +++++++++++++++++++++++++++++++++++
 include/hw/i2c/smbus_slave.h  |  2 +-
 include/qemu/osdep.h          | 14 ++++++++
 tests/qtest/adm1266-test.c    | 10 +++---
 6 files changed, 148 insertions(+), 7 deletions(-)

--=20
2.55.0.rc2.803.g1fd1e6609c-goog


