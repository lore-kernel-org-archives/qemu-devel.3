Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39BEACA5FCE
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 11:03:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDgTd-0002ZB-DS; Mon, 05 Oct 2026 07:03:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <39YPDagoKCmgYZGTRKePNaMUUMRK.IUSWKSa-JKbKRTUTMTa.UXM@flex--stanleyjhu.bounces.google.com>)
 id 1xDgTZ-0002W9-Bw
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 07:03:21 -0400
Received: from mail-pf1-x448.google.com ([2607:f8b0:4864:20::448])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <39YPDagoKCmgYZGTRKePNaMUUMRK.IUSWKSa-JKbKRTUTMTa.UXM@flex--stanleyjhu.bounces.google.com>)
 id 1xDgTX-0005Pg-KX
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 07:03:21 -0400
Received: by mail-pf1-x448.google.com with SMTP id
 d2e1a72fcca58-887e45c81bdso920125b3a.1
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 04:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1791198197; x=1791802997; darn=nongnu.org;
 h=content-type:cc:to:from:subject:message-id:mime-version:date:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=8MPYG4Bh6FkEtC/KAsAPK+0BOK3VGLPUJ5RkXknpzwc=;
 b=E6T609Koo8Efb7tz37VaDj/SyM0sR1ING4sFWz8Im+FlHoGhZ7AsTp8VTIlC5CeNnK
 NH9Yeg730N2F+k4H8UOrmwRbMOL9fNZnFqtbasZP1eI4Yp5oPZqm+StQTyoHWAvohV/i
 VqT+9nkyOnVqyfazgO+m236QTytBaFo2aDAxwNWDE73uupVCEKEGzvjilzkyC/jQFeyE
 y6WSxCriHLVo4dobapgXafSY4cJ9g848K7mpWyc4KvzzqvFLMBYzUl9WRKa+AdvK4Nyt
 Nk8YKbrTG3jatty9/ae6Dvbwp3p1nizN3ISmYpmNRfoNdKFNNnnRi4Omqzue50Lwtq/j
 KF8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791198197; x=1791802997;
 h=content-type:cc:to:from:subject:message-id:mime-version:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8MPYG4Bh6FkEtC/KAsAPK+0BOK3VGLPUJ5RkXknpzwc=;
 b=0qX8ZQgmGiWmncUAEnaeEg5Ut/3MzdeCm914vHNKJZQJ0Z47lXp3MQbqEclJ7z/F8K
 lgunzcov6yuVQwDVFh77EhlgcAv9ofAmd8cS01kEviGKVDp6xonFUqQN8epaELcXvwpk
 /NFDViY/qk446rDvT3kXLvd7U8ZrlpVkdQZ5qCmLrQswfPcR1E7cmdd0g8IBlpWy7xrt
 wXDmOKqVTQHc4+eE0pZ23tCXpRn/9nB1iDfog3kq13ly/NxzU05CjwTZdej6DTPzBef4
 36A3clAapvx3S4+Rdr8vxcEPeUdPFOW93+YXBTl7ZPuG6YOnpgvIoq1BHMSLNwdwESeU
 v26w==
X-Forwarded-Encrypted: i=1;
 AKwUvBwnxe05hCwnzScQaTBbs1XJZ0EZsfaOZW3sLRSecX7YlO3dHxGwTyRmLBXBSVMiqeeXFuJyYgitwafb@nongnu.org
X-Gm-Message-State: AFq9FYJqIgz/9ytwgiWOlhGqGSX7IVROHETRffbX4PfxfDJ01wwzDBqi
 qMvckZe4IvtuQGOalk3TyXtNdr1hGPMXAwa2ZKxS/1sZ6sIkGW7O/g36GAuwivtOuuM/6wlor/8
 W9XgezSBFRH4zDEjw/xQWKQ==
X-Received: from pfoo15.prod.google.com ([2002:a05:6a00:1a0f:b0:88d:7c25:5ff])
 (user=stanleyjhu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:451b:b0:86a:c062:8af2 with SMTP id
 d2e1a72fcca58-88af249500emr9233312b3a.3.1791198197225; 
 Mon, 05 Oct 2026 04:03:17 -0700 (PDT)
Date: Mon,  5 Oct 2026 19:03:11 +0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261005110315.3327418-1-stanleyjhu@google.com>
Subject: [PATCH v4 0/4] hw/ufs: Support MCQ runtime registers and Task
 Management Requests
From: Stanley Jhu <stanleyjhu@google.com>
To: Jeuk Kim <jeuk20.kim@samsung.com>, Jeuk Kim <jeuk20.kim@gmail.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, 
 Stefan Hajnoczi <stefanha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, Jinyoung Choi <j-young.choi@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::448;
 envelope-from=39YPDagoKCmgYZGTRKePNaMUUMRK.IUSWKSa-JKbKRTUTMTa.UXM@flex--stanleyjhu.bounces.google.com;
 helo=mail-pf1-x448.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_PDS_OTHER_BAD_TLD=0.01,
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

This series adds support for Task Management Requests (TMR) and
Multi-Circular Queue (MCQ) runtime status, interrupt, and queue cleanup
operations in the QEMU UFS emulator.

Why:
Linux UFS error recovery issues Task Management Requests (TMR) via the
UTP Task Management Request List (UTMRL). In MCQ mode, the driver also
uses per-queue operational registers (SQnRTC, SQnRTS, SQnCTI, CQnIS) to
stop queues and clean up aborted tasks, and nullifies unfetched SQEs by
setting Command Type to 0xF. QEMU does not yet model these paths or
track per-request SCSIRequest pointers needed to cancel individual
in-flight commands. Per-SQ interrupt status/enable bits (SQIS.SSS/SUS,
SQIE, and IS.SQES) remain unmodeled.

What:
- Patch 1: Track SCSIRequest in UfsRequest and cancel it in
  ufs_clear_req().
- Patch 2: Implement MCQ runtime operational registers and SQnRTC.ICU
  cleanup.
- Patch 3: Implement UTMRL doorbell and TMR handling (QUERY_TASK and
  ABORT_TASK).
- Patch 4: Skip nullified MCQ SQEs (CT = 0xF) and post CQEs with
  UFS_OCS_ABORTED.

Differences from v3:
- Report SQRTS.RTC (0..3) and preserve SQRTS.CUS across SQ_START (Jeuk)
- Separate TMR rsp_header.response from output_param1 and gate IS.UTMRCS
  on the UTMRD I-bit (Jeuk)
- Drop non-spec MMIO configuration register resets in ufs_hce_reset()
- Complete nullified MCQ SQEs (CT = 0xF) with UFS_OCS_ABORTED

Tested:
Verified on QEMU ARM64 with qos-test and Linux guest MCQ TMR abort, SQ
cleanup, and host reset.

Stanley Jhu (4):
  hw/ufs: Track SCSIRequest and cancel pending requests in ufs_clear_req
  hw/ufs: Support MCQ runtime interrupt and queue status registers
  hw/ufs: Implement Task Management Request (TMR) handling
  hw/ufs: Skip nullified MCQ submission queue entries with OCS_ABORTED

 hw/ufs/lu.c         |   8 ++
 hw/ufs/trace-events |   2 +
 hw/ufs/ufs.c        | 268 +++++++++++++++++++++++++++++++++++++++++++-
 hw/ufs/ufs.h        |   1 +
 include/block/ufs.h |  17 +++
 5 files changed, 292 insertions(+), 4 deletions(-)

-- 
2.56.0.rc1.315.gc6ed9934b7-goog

