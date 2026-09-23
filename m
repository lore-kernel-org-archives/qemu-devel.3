Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4017C98302
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 14:49:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9OHk-0006Lr-M8; Wed, 23 Sep 2026 10:49:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <36eazagoKCuIWXERPIcNLYKSSKPI.GSQUIQY-HIZIPRSRKRY.SVK@flex--stanleyjhu.bounces.google.com>)
 id 1x9OHg-0006Kb-UL
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 10:49:21 -0400
Received: from mail-pj1-x1047.google.com ([2607:f8b0:4864:20::1047])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <36eazagoKCuIWXERPIcNLYKSSKPI.GSQUIQY-HIZIPRSRKRY.SVK@flex--stanleyjhu.bounces.google.com>)
 id 1x9OHf-00014l-8U
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 10:49:20 -0400
Received: by mail-pj1-x1047.google.com with SMTP id
 98e67ed59e1d1-39e3c10ac70so1632477a91.2
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 07:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1790174953; x=1790779753; darn=nongnu.org;
 h=content-type:cc:to:from:subject:message-id:mime-version:date:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Xrj/ZsejF0EwH0vy8vEJG/rN5FDfi4IbyJY0ZxxvFgg=;
 b=WJoXYegqkG8obN5eBup70sfqf+gs1u9D0QByG3AVzj/Q7fLEs36kx6Hq7glSDt6p+u
 4HUbL0TtWHlkMnqAyUe3Ep4V9MSCmj+XS35YpZ8uEbtXg/Aa5l4IOnDTqnbnRqpFw9LY
 uPMvDuUqe54wTrtC1/4+4TpW6kN46shS0G2vD2gMKCATPJpFfdZcagr/Q+gvhqypNSkK
 igqEbmX0QLFqDITrOiwFCTMLg1rTMUnY4YE5s7wJtHdqt9wnzESkFLZJRF6sIX+/NWAD
 gIhln5pcRW9IA4RsWmtPlGnoM/6FGqVAe1DYgd7dZum2g6d/0r9/goNCF45KwgSbxnT8
 RJxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790174953; x=1790779753;
 h=content-type:cc:to:from:subject:message-id:mime-version:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Xrj/ZsejF0EwH0vy8vEJG/rN5FDfi4IbyJY0ZxxvFgg=;
 b=1TXvd+bQB7USIukISWdD28IYSiKAqPFfOg4JWk0krgfG6YyFMk6YpqiMchcSt3BkbI
 YMC+Q7AAXMF6HhmEXTzD3YSuhQnGR6d6ABe0Vsb1prPYnJvVQcpjV7cQ/CP9POI0AHfH
 nkDBI9PfRg2HNdRrcUlo5tREF/YvHpr2E4cYSX2b/5R944R7yGN25bAmla2KLeQFxeUH
 3sRFaXXX3Zq22nDNBzIp2N39lSPr0eoDzEw1RGMFCfpLBpA4eOpBiOglIRyZcsZ7M+JA
 j3J4qzKeAMweoNO3mT/dVn7p/VaFU4x9dhDf1WspOaPHpIiXaLNq4yCqVZgcv9w4xBvW
 fvGA==
X-Forwarded-Encrypted: i=1;
 AKwUvByBjiJwXEjQy6Wgi2+833zgdUQ1FdXIy9BBk77ImlimEE3NsYOgPvAySZgYVe9GEwaqy2ZecMx0iNFq@nongnu.org
X-Gm-Message-State: AFuF++nnXdCwwVfDzE/b2tecPCuqphWFxpGEwi6BvLyjKdqWVM3w7EZB
 0JoK/h68oRKMJguimdG6jxGzsIlYxUXaweUkT8bLnRz6Mky5QbApyZWT3rXZBDFff9D48aey8d+
 8bWqWEuCcJKyI8Flqln7wrw==
X-Received: from pjpx15.prod.google.com ([2002:a17:90a:a38f:b0:3a0:2b14:811f])
 (user=stanleyjhu job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:514e:b0:39e:58fc:1d73 with SMTP id
 98e67ed59e1d1-3a07e5455f2mr2580292a91.23.1790174953053; 
 Wed, 23 Sep 2026 07:49:13 -0700 (PDT)
Date: Wed, 23 Sep 2026 22:48:08 +0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.rc1.310.g51773c2048-goog
Message-ID: <20260923144911.2877141-1-stanleyjhu@google.com>
Subject: [PATCH v3 0/3] hw/ufs: Support MCQ runtime registers and Task
 Management Requests
From: Stanley Jhu <stanleyjhu@google.com>
To: Jeuk Kim <jeuk20.kim@samsung.com>, Jeuk Kim <jeuk20.kim@gmail.com>
Cc: Stanley Jhu <stanleyjhu@google.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, Jinyoung Choi <j-young.choi@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1047;
 envelope-from=36eazagoKCuIWXERPIcNLYKSSKPI.GSQUIQY-HIZIPRSRKRY.SVK@flex--stanleyjhu.bounces.google.com;
 helo=mail-pj1-x1047.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_PDS_OTHER_BAD_TLD=0.01,
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

This patch series implements JEDEC UFSHCI specification compliance for
Task Management Requests (TMR) and Multi-Circular Queue (MCQ) runtime
status and interrupt registers in the QEMU UFS emulator, rebased onto
the latest QEMU master (7074591d7).

Why:
In QEMU UFS emulation, Linux guest error recovery paths (such as SCSI
abort during command timeout) issue Task Management Requests (TMR) via
the UTP Task Management Request List (UTMRL). Furthermore, when MCQ
is enabled, the Linux driver initializes and accesses per-queue runtime
registers (SQnRTC, SQnRTS, SQnCTI, SQnIS, CQnIS, etc.). Currently, QEMU
treats UTMRLDBR and MCQ operational registers as unsupported,
triggering "invalid register offset" warnings and causing SCSI EH aborts
to time out and escalate unnecessarily to full controller resets.
Additionally, aborting an individual in-flight transfer request via TMR
or MCQ queue cleanup requires tracking and cancelling its underlying
SCSIRequest without purging the entire SCSI device.

What:
- Patch 1: Tracks SCSIRequest in UfsRequest and cancels pending
  requests via scsi_req_cancel() in ufs_clear_req() as preparation for
  Task Management Function (TMF) abort and MCQ queue cleanup support.
- Patch 2: Implements MCQ runtime operational registers (queue
  lifecycle control, SQnRTC.ICU cleanup via SQnCTI posting
  UFS_OCS_ABORTED CQE, per-queue interrupt status/enable, and global
  CQES sync).
- Patch 3: Implements Task Management Request handling for UTMRLDBR
  (supporting UFS_QUERY_TASK and UFS_ABORT_TASK for both legacy UTRL
  and MCQ queues, and clear-on-zero UTMRLCLR semantics).

Differences from v2:
- Rebase onto latest QEMU master (7074591d7)
- Frame Patch 1 as TMF preparation and assert(req != NULL) in callbacks
- Drop redundant u->resetting checks and implement SQRTC.ICU cleanup
  using SQnCTI to post UFS_OCS_ABORTED CQEs
- Defer MCQ request recycling in UFS_ABORT_TASK until SQRTC.ICU and fix
  UTMRLCLR clear-on-zero polarity

Tested:
Verified on QEMU ARM64 via qos-test and Linux MCQ EH without UAF.

Stanley Jhu (3):
  hw/ufs: Track SCSIRequest and cancel pending requests in ufs_clear_req
  hw/ufs: Support MCQ runtime interrupt and queue status registers
  hw/ufs: Implement Task Management Request (TMR) handling

 hw/ufs/lu.c         |   8 ++
 hw/ufs/trace-events |   2 +
 hw/ufs/ufs.c        | 246 +++++++++++++++++++++++++++++++++++++++++++-
 hw/ufs/ufs.h        |   1 +
 include/block/ufs.h |  16 +++
 5 files changed, 270 insertions(+), 3 deletions(-)

-- 
2.56.0.rc1.310.g51773c2048-goog


