Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1903BCD4840
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 19:07:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMVyA-0002Va-EN; Mon, 11 May 2026 15:07:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wMVxh-0002J9-3H
 for qemu-devel@nongnu.org; Mon, 11 May 2026 15:06:43 -0400
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wMVxe-00085y-VN
 for qemu-devel@nongnu.org; Mon, 11 May 2026 15:06:40 -0400
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7de46b8e432so4495986a34.1
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 12:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778526397; x=1779131197; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Qyf6YBFk0GjVtnUoYY95prdAtX/pGyAO9qSqnYgRlTo=;
 b=B9w/V0Gh7pPqyeQq3BqFp88HJ3uS2+hOrmHFS60bRfA1FxqYqDVfQzh8YaX7sp3K89
 hrmeZMJ00wkfYs06hfcD/BBEWFdk8v9Z6b9vqbnrmK0jhj2QJlbR3ARRAsdz4slHIzTv
 THFbYRXxv97h9TwS1KT7ml6GFpIdodWO/J1USTx1zYHRXBFrmvpm94DwGFG9TcJObG8S
 P9OvUfVSiTVPHa2iJz6UtclLYTj1LDN4XwVD46GXjDo5Na2R8yGVHOZV8xcgtPe0VZWF
 eFLhW1IAa51VYx2YrJZGFCIYwM7erF0uLlvoQrmS/KAL4uxj3J9l8O7iBnVbgq/sf6EI
 g/ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778526397; x=1779131197;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qyf6YBFk0GjVtnUoYY95prdAtX/pGyAO9qSqnYgRlTo=;
 b=E7+kUjTu9JsVbDV3pfdRfD7gYrzea8NkeHivDvkcYyFvrYHR0zdnbBEhT85ek8gMf3
 hzB3RBxSfplor42SPLrRjuSRm1ePmDgtONaCw9GZ64zESYCScnb5Tws6JDNqfGTHoDAw
 Nq3ggG//7yd6KnQrPH/9xxMIA2RSS6Q4x+YUdLZuFZRWwixsOCIPpoyfm5erhTR9F/TO
 KPGJr+oLG43Ycm+VawjgqY2hE7WpdP80QnjzTIqBAJugXkBb6+phmuZXQcZ0k4BYgcIv
 H3LpNXtQ3Aq8vsBHmcRkXTRJg8ixSMqHZdZZAnx8JF2bLJi41lTlgmS+HJNJsrSz+Q17
 q2LQ==
X-Gm-Message-State: AOJu0YwO4D4RLdOi0CRTh8mM7lRGaxyWk+MEGwjd/Mjco+6UmeLM4CMU
 49NiXxt8eJpAylw0jPIXOvBQpLUuPTWsok0xTY/BA2RGRLqznKcJFHduSBAEDw1bvAYGhYjhHaY
 L2UpJ
X-Gm-Gg: Acq92OGhp9VgGf+IPOYiFQUuSXfcHq6W1i5vQU4ONkgYT9K2W/SkERXJnd4yBbRRZPs
 2i/Sg6t3iWV29lI5qcz4Rb//tYVUr9tdVlr0JkFkxNinJbsphDAWFC55Xej7s8vh+NO9jp4pty/
 wBksszLLqONR2hhYjE6nblLJSYJUqBb23+MNmTxRmF8yaFKpdZCA78DQQOZ34mrtncvm1d8dvAq
 3KLPE/UaLwUAbq9x96SjqnFZ1Jw89yb21mfESGXnBkovmzl6QbotK2uZXF9taCJ+LkRaTo/pfD+
 IdDfQBGTIKqyJD7ccKn8eWHP3xsDlwO6YqJImw4LnogKa3WVHkKp073RbY2fcIAnz2gE+BgS6Ql
 Ji/W20VPdeKomeC08DsRtj/mXVL2h/q8JfBUH8KfppwFy5OWbmxMdJTiVWdcC07huqXiAapJoxs
 g3Fl84F+qN86+YMq9J1OWxSOo8i0uzMibjumxh9JWwGQo/Gg==
X-Received: by 2002:a05:6830:6a93:b0:7dc:d2ad:fb17 with SMTP id
 46e09a7af769-7e1df107bc1mr15439058a34.20.1778526397176; 
 Mon, 11 May 2026 12:06:37 -0700 (PDT)
Received: from stoup.attlocal.net ([2600:381:c938:6375:e3e5:757d:3cef:3491])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e367d8feb1sm7157011a34.23.2026.05.11.12.06.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 12:06:36 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@oss.qualcomm.com,
	philmd@linaro.org
Subject: [PATCH 0/5] target_info optimizations
Date: Mon, 11 May 2026 14:06:29 -0500
Message-ID: <20260511190634.472174-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::332;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x332.google.com
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

Based-on: 20260509005453.3984184-1-pierrick.bouvier@oss.qualcomm.com
("[PATCH v5 0/6] single-binary: deduplicate target_info()")

Allow TargetInfo accesses to resolve to a direct structure access.
Arrange for the structure to appear const to the majority of qemu.
For user-only, the structure actually is const; for system, the
structure is initialized early.


r~


Richard Henderson (5):
  meson: Build target-info-qom.c with -fno-lto
  target-info: Expose target_info as const data
  target-info: Merge target-info-impl.h into target-info.h
  target-info: Merge target-info-qapi.h into target-info.h
  target-info: Inline accessors

 include/qemu/target-info-impl.h   |  44 -----------
 include/qemu/target-info-init.h   |  45 ++++++++---
 include/qemu/target-info-qapi.h   |  29 -------
 include/qemu/target-info-qom.h    |   2 +-
 include/qemu/target-info.h        | 123 +++++++++++++++++++++++++++---
 configs/targets/aarch64-softmmu.c |  18 +----
 configs/targets/arm-softmmu.c     |  18 +----
 hw/core/machine-qmp-cmds.c        |   1 -
 hw/uefi/ovmf-log.c                |   2 +-
 hw/virtio/virtio-mem.c            |   2 +-
 page-vary-common.c                |  10 +--
 page-vary-system.c                |   8 +-
 system/arch_init.c                |   2 +-
 target-info-qom.c                 |  13 ++--
 target-info-stub.c                |  27 +------
 target-info.c                     |  95 -----------------------
 meson.build                       |  13 ++--
 17 files changed, 179 insertions(+), 273 deletions(-)
 delete mode 100644 include/qemu/target-info-impl.h
 delete mode 100644 include/qemu/target-info-qapi.h
 delete mode 100644 target-info.c

-- 
2.43.0


