Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 710EAC79FAD
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 03:12:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x48jA-0002Xa-E5; Tue, 08 Sep 2026 23:12:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3dc6gagoKCvAklSfdWqbZmYggYdW.UgeiWem-VWnWdfgfYfm.gjY@flex--stanleyjhu.bounces.google.com>)
 id 1x48j5-0002Wj-7O
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 23:11:56 -0400
Received: from mail-pg1-x546.google.com ([2607:f8b0:4864:20::546])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3dc6gagoKCvAklSfdWqbZmYggYdW.UgeiWem-VWnWdfgfYfm.gjY@flex--stanleyjhu.bounces.google.com>)
 id 1x48j3-0004z1-LK
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 23:11:55 -0400
Received: by mail-pg1-x546.google.com with SMTP id
 41be03b00d2f7-cc1a439db36so5251244a12.2
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2026 20:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1788923509; x=1789528309; darn=nongnu.org;
 h=content-type:cc:to:from:subject:message-id:mime-version:date:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=wG6vhjCcJCzF8WS4RUURvctoxRoa1qxy7vvQn4n/kCw=;
 b=REHVosyNEuumd/atwrZBP3WcsRFcWPjx2hdKS6szjyRHC21QqMl5tk4rQnFTVHnvAl
 IFLSxxmcpEEjFjSHvqWgqLjhdN582KSeEieIF+gZ0MVEolIxPIsIL/ZiKF44j8vIa+1x
 XDtkZ49Kn0V6W0rcPTUPJpYMHIbPUylY234bwCoiZoO6xWfq9iI0g677x7mi7HE30AP4
 rl6A2sMPTfz3Ys1RzH+NRVJf8aiQMDuXIOaZB7qJT4ngM+xoKcywqkyrIY3BP61PHxTo
 +MNoO6jTnxkM3kxMyoADL+uYEtgQXlycGaebVGXAgjZVgEOJppHmVQBupZGk7IaUuVH1
 630A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788923509; x=1789528309;
 h=content-type:cc:to:from:subject:message-id:mime-version:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wG6vhjCcJCzF8WS4RUURvctoxRoa1qxy7vvQn4n/kCw=;
 b=VxOPbVJSdJr7gGm8kkxus2C1iJJJguZ9mTzJuAHG3BsuyIWA6lLAdyC2zmnbiEGKAN
 Uuwh9bem1B+dV+BWulewpuPZaZvWlzWg2ILdvJHZ7RcXIcVmWUy8y+8F8BKATpRr7wB/
 0H7vR9ij+nf4f2N+SSmnEMyawj7bTmKMtcfqDp9o4B/b9M2b32+DI8yC71FZPQJwM4Sl
 iE/RK6N89vFd8ax4J8/jg2nN71RDGQ2TWrf6QEut/B8/4xLqfSy8yHqc0yBbFRF2G3VN
 ImMIuF/1gjeSDhmSGwsWxhuKJRjLiePhCTEqMQyTPdozeyy3XLflP2ZVf9jKH05nZahL
 vlMQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByfKWz9B5KAg7Vm4cmQQkWU+EzdfoZq+rm+hN7kH1989PBTF5OO3oQIZ0M8mpPYG99b0qVuC86VMFCC@nongnu.org
X-Gm-Message-State: AFuF++kQUUzTmzyYVhO+dsJdnlPYxrKfRVqj6SrZbjT5jHRsc5MNK55H
 BnvjgbX4OYPs3KQIu44wpHfWe36Gj5f2xBjRflL5puSfxCbirfgBv/GHOyQgIlJJ40UyY+Q845c
 Qw2taKEsn7u2i8YFCVJUrLA==
X-Received: from pgjb13.prod.google.com ([2002:a63:cf4d:0:b0:c86:61a1:3390])
 (user=stanleyjhu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:a87:b0:3b4:5ff3:45cb with SMTP id
 adf61e73a8af0-3da39beb1eemr55093409637.8.1788923509157; 
 Tue, 08 Sep 2026 20:11:49 -0700 (PDT)
Date: Wed,  9 Sep 2026 11:11:43 +0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.1007.g17ff1f9808-goog
Message-ID: <20260909031146.1646684-1-stanleyjhu@google.com>
Subject: [PATCH v2 0/3] hw/ufs: Support Task Management Request (TMR) and MCQ
 status registers
From: Stanley Jhu <stanleyjhu@google.com>
To: Jeuk Kim <jeuk20.kim@samsung.com>, qemu-devel@nongnu.org
Cc: Brian Kao <powenkao@google.com>, Stanley Jhu <stanleyjhu@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::546;
 envelope-from=3dc6gagoKCvAklSfdWqbZmYggYdW.UgeiWem-VWnWdfgfYfm.gjY@flex--stanleyjhu.bounces.google.com;
 helo=mail-pg1-x546.google.com
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

This patch series implements JEDEC UFSHCI specification compliance for
Task Management Requests (TMR) and Multi-Circular Queue (MCQ) runtime
status and interrupt registers in the QEMU UFS emulator.

Why:
In QEMU UFS emulation, Linux guest error recovery paths (such as SCSI
abort during command timeout) issue Task Management Requests (TMR) via
the UTP Task Management Request List (UTMRL). Furthermore, when MCQ
is enabled, the Linux driver initializes and accesses per-queue runtime
registers (SQnRTC, SQnRTS, SQnIS, CQnIS, etc.). Currently, QEMU treats
UTMRLDBR and MCQ operational registers as unsupported, triggering
"invalid register offset" warnings and causing SCSI EH aborts to time out
and escalate unnecessarily to full controller resets. Additionally,
pending SCSI requests in the block layer were not cancelled when requests
were cleared or aborted in ufs_clear_req(), posing Use-After-Free
hazards upon asynchronous AIO callbacks.

What:
- Patch 1: Tracks SCSIRequest in UfsRequest and cancels pending requests
  via scsi_req_cancel() in ufs_clear_req(), ensuring clean Block AIO
  teardown.
- Patch 2: Implements MCQ runtime operational registers (queue lifecycle
  control, per-queue interrupt status/enable, global CQES sync) and HCE=0
  MMIO read protection.
- Patch 3: Implements Task Management Request handling for UTMRLDBR
  (supporting UFS_QUERY_TASK and UFS_ABORT_TASK for both legacy UTRL
  and MCQ queues).

Differences from v1:
- Split into two independent series: this series contains production
  specification compliance and memory safety fixes; experimental fault
  injection properties (x-hold-tag, x-hold-mode) have been moved to a
  separate follow-up patch based on this series.
- Separated scsi_req_cancel() into Patch 1 to isolate the block layer
  memory safety fix.
- Added HCE=0 operational register read guard (returning 0xffffffff) in
  Patch 2 per JEDEC UFSHCI specification.
- Cleaned up TMR completion handling and trace events in Patch 3.

Tested:
- Verified on ARM64 Linux guest (linux-next) running on QEMU.
- Verified ufshcd_mcq_make_queues_operational() succeeds without invalid
  register offset warnings.
- Verified SCSI command aborts and Task Management Requests via Linux
  SCSI error handling escalation.
- Verified 100% data integrity (cmp) on /dev/sda after abort and reset
  recovery.
- Passes ./scripts/checkpatch.pl with 0 errors and 0 warnings.

Stanley Jhu (3):
  hw/ufs: Track SCSIRequest and cancel pending requests in ufs_clear_req
  hw/ufs: Support MCQ runtime interrupt and queue status registers
  hw/ufs: Implement Task Management Request (TMR) handling

 hw/ufs/lu.c         |  12 +++
 hw/ufs/trace-events |   2 +
 hw/ufs/ufs.c        | 196 +++++++++++++++++++++++++++++++++++++++++++-
 hw/ufs/ufs.h        |   1 +
 include/block/ufs.h |   9 ++
 5 files changed, 217 insertions(+), 3 deletions(-)

-- 
2.55.0.1007.g17ff1f9808-goog


