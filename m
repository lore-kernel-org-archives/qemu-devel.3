Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7161AC79F80
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 06:27:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2NOL-0008Fy-55; Fri, 04 Sep 2026 02:27:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3u2SaagoKCko45mzxqAvt6s00sxq.o0y2qy6-pq7qxz0zsz6.03s@flex--stanleyjhu.bounces.google.com>)
 id 1x2NOK-0008FK-65
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 02:27:12 -0400
Received: from mail-pj1-x1046.google.com ([2607:f8b0:4864:20::1046])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3u2SaagoKCko45mzxqAvt6s00sxq.o0y2qy6-pq7qxz0zsz6.03s@flex--stanleyjhu.bounces.google.com>)
 id 1x2NOI-0005FN-8t
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 02:27:11 -0400
Received: by mail-pj1-x1046.google.com with SMTP id
 98e67ed59e1d1-399311947f6so1137004a91.0
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 23:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1788503228; x=1789108028; darn=nongnu.org;
 h=content-type:cc:to:from:subject:message-id:mime-version:date:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ZCAgkqfVivZbmEgVKbH7blMKkj6x3PGne6FqgaPuv6E=;
 b=WMqQ8iF82Y7xfnoplTAvbQZ6Qd2E4ZgwZvsoC7qqPDY5H5ULV2Nntrx0AzkXddcwCS
 QENWH2hho7oQpsE+ECEEdAX4BUxz8t39CfDnnGHv3kkgTSN4kVs3yXDOUdO9Bh6mG1tV
 RgrsUo8Vxe7HB4/2AHNT0eJDvUf0XC3SoVkBIUhJlUnx/aTDPxka7nDvRGa8k6cD+FLT
 cMZe73zm35CMm+HIdzNAPCt6V7++S7900nBX5yKVFM9hv5hM0xoVSULbQ0Ja0QyPx60z
 IrSlGGHlAy+ccfYMxcHq/Dwg9IZ5XwG4wYVgwMPNEy4zu9Z1akV9gf0V9wrS6JSSa2QY
 TWIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788503228; x=1789108028;
 h=content-type:cc:to:from:subject:message-id:mime-version:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZCAgkqfVivZbmEgVKbH7blMKkj6x3PGne6FqgaPuv6E=;
 b=BxguICxeCs/6suhE1fQl23ChStd6UX8hdWpSw/nvaRc59LRbfpFY/0oLbLq1CEsOpM
 IWNlVYMXirnxSOSnWxRP4bNDpDRudxuqFWfldlNgzmITQnA79EfoB01b65+Z4EjfR3fc
 Dx763xdUY3l5rmT4K788uUNNIVrUlJ/H523TBcQhSgO/yo0Ox2EtaMDQ5uwMs+jlHH2q
 euf6aFm9TLG32tU+8S/b+qsEYbb+sGPat5TrVlZnPlZuhoAU5cfmY2MggTkq2A/oGmyO
 v4r3rMKLnPk9sjKIeAMV1roSYs6OZrPtB/nVXot3dtGzIHvQSgo9sicHUTEF1symMrh0
 rllw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwDfnndTvmlg2905fMoOWfFzErYKKoYa9BxsmmHpl17KH4PYW5XYhtoNTbOErX8DCBtuFoJAVvjnHu+@nongnu.org
X-Gm-Message-State: AFuF++labETlQQv7Jf0WOup9Z6GKV8kNOqZnXSq0l5ujbMU3x0KXx5cG
 leoAEclZcdgF3fUEepXeLKE1HUZBgbwLU7nZfd+BwGcLFKqvP7I4b73UPfAFzVQiWxonPH3iX8q
 ucuwtLqkMp9cwiLbfz4zoJg==
X-Received: from pjqs3.prod.google.com ([2002:a17:90a:ad83:b0:39b:2bd4:ced7])
 (user=stanleyjhu job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3809:b0:381:a766:efc9 with SMTP id
 98e67ed59e1d1-39b261014e2mr5300423a91.7.1788503227889; 
 Thu, 03 Sep 2026 23:27:07 -0700 (PDT)
Date: Fri,  4 Sep 2026 14:27:03 +0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.979.g7e5102b832-goog
Message-ID: <20260904062706.2684958-1-stanleyjhu@google.com>
Subject: [PATCH 0/3] hw/ufs: Support MCQ runtime registers, Task Management
 (TMR), and fault injection
From: Stanley Jhu <stanleyjhu@google.com>
To: Jeuk Kim <jeuk20.kim@samsung.com>, qemu-devel@nongnu.org
Cc: Jeuk Kim <jeuk20.kim@gmail.com>, Jinyoung Choi <j-young.choi@samsung.com>, 
 qemu-block@nongnu.org, Stanley Jhu <stanleyjhu@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1046;
 envelope-from=3u2SaagoKCko45mzxqAvt6s00sxq.o0y2qy6-pq7qxz0zsz6.03s@flex--stanleyjhu.bounces.google.com;
 helo=mail-pj1-x1046.google.com
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

This patch series builds directly on top of the recently reviewed patch:
"[PATCH v3] hw/ufs: Reset controller and MCQ state on HCE transition to 0"
(Message-ID: <20260902081610.2290123-1-stanleyjhu@google.com>)
Based-on: <20260902081610.2290123-1-stanleyjhu@google.com>

### Background & Motivation
When running upstream Linux kernel UFS driver error recovery and task aborts
(e.g., ufshcd_abort() or ufshcd_mcq_abort()), Linux interacts with UFS Multi-
Circular Queue (MCQ) runtime registers and issues UTP Task Management Requests
(TMR) via UTMRLDBR. Currently in QEMU:
1. Writing to MCQ operational registers (SQnRTC, SQnCTI, SQnIS, SQnIE, CQnIS,
   CQnIE, CQnIACR) logs "invalid register offset" warnings.
2. TMR registers (UTMRLDBR, UTMRLCLR, UTMRLRSR) are unsupported. Task aborts
   time out and unnecessarily escalate to full device or host resets.
3. When task abort cancels an in-flight command, lack of SCSIRequest tracking
   presents Use-After-Free (UAF) hazards during asynchronous block AIO callbacks.

### Series Overview
- Patch 1 (hw/ufs: Support MCQ runtime interrupt and queue status registers):
  Implements UFSHCI 5.2.1/5.6 per-queue runtime registers using QEMU REG32/FIELD
  macros. Implements SQSTART/SQSTOP queue gating, SQ_ICU queue cleanup reporting,
  and W1C interrupt handling. Dynamically recalculates active CQ interrupts to
  clear global IS.CQES, preventing virtual interrupt storms. Cleans operational
  registers during HCE 1 -> 0 while preserving MCQCONFIG.MAC capability.

- Patch 2 (hw/ufs: Implement Task Management Request (TMR) handling):
  Implements Task Management Request processing via UTMRLDBR. Tracks sreq in
  UfsRequest and safely cancels pending SCSIRequests via scsi_req_cancel() to
  eliminate UAF hazards. Supports dual-queue tag lookups across legacy UTRL and
  MCQ queues. For UFS_QUERY_TASK, returns FUNCTION SUCCEEDED (0x08) if the
  task is pending in the device/controller, and FUNCTION COMPLETE (0x00) if
  the task does not exist, adhering strictly to SAM-5 and JEDEC specifications.
  Latches pending doorbell bits in utmrldbr upon UTMRLDBR write per UFSHCI 5.2.1
  Section 5.3.3. Preserves dword_2 header OCS masks and returns completion
  codes in both response and output_param1 to satisfy both JEDEC specifications
  and Linux kernel driver validation. Clears TMR registers during HCE reset.

- Patch 3 (hw/ufs: Add experimental fault injection properties for task abort testing):
  Adds experimental QOM properties x-hold-tag and x-hold-mode to ufs-pci and
  ufs-sysbus devices. Decouples UFS_HOLD_TAG_NONE (0xffffffff) to preserve Tag 0
  testing and UFS_HOLD_TAG_ANY (0xfffffffe) to automatically sniff target direct
  I/O (READ_10/WRITE_10 with LBA >= 512) while allowing guest boot metadata
  requests to proceed unimpeded. Supports runtime dynamic modification via QOM
  (qom-set / qom-get) on realized devices, enabling continuous multi-case CI
  testing in a single running VM without reboots.

### CI/CD Closed-Loop & Regression Prevention Vision
Together with the companion Linux kernel patch:
  "[PATCH] scsi: ufs: core: Add fault injection for task abort failures"
  Link: https://lore.kernel.org/r/20260903235308.1240963-1-stanleyjhu@google.com/
these QEMU changes establish a deterministic closed-loop verification testbed
for UFS exception cases (abort successes, abort rejections, transitions, and
hardware timeouts). This provides a reliable foundation to set up regular
automated CI/CD regression suites, ensuring long-term health and zero regressions
for future Linux kernel UFS driver development as well as QEMU UFS emulation.

### Testing & Verification
- Style: 0 errors, 0 warnings across all patches via ./scripts/checkpatch.pl.
- Emulation Matrix: Verified in ARM64 QEMU Linux kernel environment across 5
  scenarios (Abort Success, Abort Failed, In-Transition, TMR Timeout, and
  Normal I/O) in a single running VM session without rebooting. All cases
  recovered cleanly according to spec, and subsequent direct I/O read/write data
  comparisons passed with 100% binary integrity (cmp PASS on /dev/sda).

Stanley Jhu (3):
  hw/ufs: Support MCQ runtime interrupt and queue status registers
  hw/ufs: Implement Task Management Request (TMR) handling
  hw/ufs: Add experimental fault injection properties for task abort
    testing

 hw/ufs/lu.c         |   7 +
 hw/ufs/trace-events |   5 +
 hw/ufs/ufs-pci.c    |   4 +
 hw/ufs/ufs-sysbus.c |   4 +
 hw/ufs/ufs.c        | 450 +++++++++++++++++++++++++++++++++++++++++++-
 hw/ufs/ufs.h        |  55 ++++++
 include/block/ufs.h |   9 +
 7 files changed, 531 insertions(+), 3 deletions(-)

-- 
2.55.0.979.g7e5102b832-goog


