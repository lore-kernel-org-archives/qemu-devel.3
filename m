Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9C89CC6B2F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 06:09:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHEdo-0003m2-6h; Thu, 15 Oct 2026 02:08:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <33W3QagoKClgIJ0DB4O97K6EE6B4.2ECG4CK-34L4BDED6DK.EH6@flex--stanleyjhu.bounces.google.com>)
 id 1xHEdl-0003ke-TU
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 02:08:33 -0400
Received: from mail-pg1-x547.google.com ([2607:f8b0:4864:20::547])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <33W3QagoKClgIJ0DB4O97K6EE6B4.2ECG4CK-34L4BDED6DK.EH6@flex--stanleyjhu.bounces.google.com>)
 id 1xHEdk-0004Hz-8f
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 02:08:33 -0400
Received: by mail-pg1-x547.google.com with SMTP id
 41be03b00d2f7-cc4fc935a11so1319810a12.0
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 23:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1792044509; x=1792649309; darn=nongnu.org;
 h=content-type:cc:to:from:subject:message-id:mime-version:date:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=cAi4uB2hBMj2hz6r0GKZ7hS/pjMimcswPAylWvF5K2g=;
 b=f0HZ4Wnu0XvwjGmaFLNzjl1JQDPT4c0SWh2g//SVaJ1SL9qQWw9emhQx9SI5c8R6eN
 XxLmjvgrrIQc2Ex6ZAyacHwSWo2rrF+MmUCn/Iy8naTxMz88EbZah+wYu69UXKb2lx6s
 D9F/Vq2gNU5BONY8+FHt55Nfv4lhswxbDWrkqnv+3EWuD06KLWjVuCdeFhMvhisJ543Y
 6tQDsC9qhldTmNcIAwJc21NBlX89TgHeMBVk/Q0CfceWKqMTsfeZdt1KpzQtqzJAWtUp
 X2gPN3dhBZD40KBc9YcsFCP+cVfx7Jf7KQm9gfKghi8ckXzuASTbwGHtve6ZF0cU2aPF
 V9TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792044509; x=1792649309;
 h=content-type:cc:to:from:subject:message-id:mime-version:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cAi4uB2hBMj2hz6r0GKZ7hS/pjMimcswPAylWvF5K2g=;
 b=nEKwKKClqaxGB9yMLHDRCBayLU5BjR4N1WC98i5G0auL3/kYsQf+b03Pur8zcoi1bm
 dfNi3LfNznMWI7ftuqTWe97DhsoGC//OHzEtUe2mShrJOSDwJ/eXe/yfH5nBkXLkaRV2
 rv3k9T5LmHmsBxj4u282gyFum7uEhvY/cs6C9U+Stt1fzQR/6SuS64eoJThcYFejYRpD
 STYD8r2igkJ8mECCFur71zrN/gV7XFpDHTbWgqN9vBXKhWrRvxRIxwexc6j/817sdECp
 t+ZBIGhsHCyVVnZQAD9fpgaQdLKDABd8rVY2d9UtLHMT45VhOCbPlhE9tE1t5bbPuVBW
 dH8A==
X-Gm-Message-State: AFq9FYL27Lw3PAGm1FvnKpMCx3xcf8JJVSH4xHQxJJoAGtYVhp3hbi//
 J7zXKYpXNaL5mPbbDJsIV5ZQKdHLMDVmax0qBhnVdr8NY6MQLFF6lyYE8YqF3bKIMLco+DvT8IB
 DEZ+tuPG+zZT6d9KcWP0qTQ==
X-Received: from pgbda6.prod.google.com ([2002:a05:6a02:2386:b0:cca:c02e:bfd6])
 (user=stanleyjhu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:6004:b0:3e1:558d:e369 with SMTP id
 adf61e73a8af0-3e16bfbf84bmr15879666637.27.1792044509156; 
 Wed, 14 Oct 2026 23:08:29 -0700 (PDT)
Date: Thu, 15 Oct 2026 14:08:19 +0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Message-ID: <20261015060827.341298-1-stanleyjhu@google.com>
Subject: [PATCH 0/8] hw/ufs: Add fault injection, update TMR doc,
 and add qtests
From: Stanley Jhu <stanleyjhu@google.com>
To: Jeuk Kim <jeuk20.kim@samsung.com>, Jeuk Kim <jeuk20.kim@gmail.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Jinyoung Choi <j-young.choi@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::547;
 envelope-from=33W3QagoKClgIJ0DB4O97K6EE6B4.2ECG4CK-34L4BDED6DK.EH6@flex--stanleyjhu.bounces.google.com;
 helo=mail-pg1-x547.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

This series adds experimental fault injection to the UFS device model
so host drivers can exercise task abort and power management recovery,
updates the task management description in the UFS docs, and adds
qtest cases for controller reset, MCQ runtime registers, task
management and fault-injected task abort.

- Patches 1-2: x-fault-inject-tag and x-fault-inject-mode properties
  to hold a transfer request, and task management handling for the
  held request.
- Patch 3: ssu-timeout mode for power management recovery testing.
- Patch 4: document the supported task management functions (QUERY
  TASK and ABORT TASK).
- Patches 5-8: qtest helpers and test cases.

The fault injection properties are experimental (x- prefix) and off
by default.

Tested with qos-test on aarch64 and x86_64 (14 and 15 UFS cases).

Stanley Jhu (8):
  hw/ufs: Add experimental fault injection properties for holding
    requests
  hw/ufs: Handle task management requests for fault-injected held
    requests
  hw/ufs: Add ssu-timeout mode for power management recovery testing
  docs/system/ufs: Update task management request support status
  tests/qtest/ufs-test: Add TMR and async MCQ SCSI submission helpers
  tests/qtest/ufs-test: Add HCE reset unit test
  tests/qtest/ufs-test: Add MCQ runtime register and TMR handling test
  tests/qtest/ufs-test: Add QOM fault injection task abort test

 docs/system/devices/ufs.rst |   7 +-
 hw/ufs/trace-events         |   3 +
 hw/ufs/ufs-pci.c            |   6 +
 hw/ufs/ufs-sysbus.c         |   6 +
 hw/ufs/ufs.c                | 337 +++++++++++++++++++-
 hw/ufs/ufs.h                |  62 ++++
 tests/qtest/ufs-test.c      | 610 ++++++++++++++++++++++++++++++++++++
 7 files changed, 1027 insertions(+), 4 deletions(-)


base-commit: 8ee6c77176cfee03be0ec7665b6652b2f31f1531
-- 
2.56.0.385.gd3acb90ef8-goog


