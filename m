Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A046CD3441
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 07:56:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKX6N-0002gq-2U; Wed, 06 May 2026 03:55:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1wKX66-0002ca-65
 for qemu-devel@nongnu.org; Wed, 06 May 2026 03:55:11 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1wKX63-00080P-MO
 for qemu-devel@nongnu.org; Wed, 06 May 2026 03:55:09 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-36528851d7dso1684951a91.1
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 00:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778054105; x=1778658905; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Asx/ohujR/GO4GjyTC7aX5UXRfMNDErHMFNUp4fn1WI=;
 b=fEx7Wuy8d2yfFZEMCVjtptr82+rPS3R7jsFevWd33ppHRpZbIhE1cv+xkPvEfil6Nw
 P8kWLfBiQ4PcUaXBjIY7ZikwFFb3sKPSOI6wzp13jj5nI94rMf5JNPCy6GfPmrmQSrU5
 HaBXTlkRoEys2hsLqrc2vFvsus3ZDpGn7sUqVZKEJGRreWMDppCdQs2MzGGWU9ocZn1H
 DOPfV9n3tPQQ+qWC4Fj55BxkdAlWcNNOnsAXjJTzLCG9aWydcaZI0vQZgH6dM3QS4ku9
 CEroL4xCmJXVDLc0s3aSfPyEQA6Y3W3e/VDRJJHwF+FAronLleulB5YUEhaqFJy+ZQIq
 jaBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778054105; x=1778658905;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Asx/ohujR/GO4GjyTC7aX5UXRfMNDErHMFNUp4fn1WI=;
 b=pwL8LiW+nwemdqbvXl8N/uNs1NyUFMKgvBlB/ySf36UX/eBs7HXKwyPpBF1n2QWtD6
 /S1ZccxnP2vg9zTjcchdyb7T6UQ9Unz/jblP4Vj93opkcjb6q69X44fXvdKqKJeQ2Uw2
 rW3O9xDuoTOj+PHDle67mi5Mcl4CzrfqsWibZrPuuzPRSVZa5L+uBFS2lGUjFYwganWk
 s+Wa4N8yoYKd0ZtpHHtbZKRq4wcylrtyuzxwoIkf29qW2K6hh0PCh63WvelpvKxxFSxw
 rPXM67Jd6eGp/QtwkIld9VYyiL9AJIywqf/ahUXy0LiZMFDuHwQzlnf+BsEJyakKDIqM
 SH4A==
X-Gm-Message-State: AOJu0YxMb31CPjTzsNfHPHmIx2AJHnvt6iYZQmlSB6AK9QbmDYuesi7A
 Ei0iUIOoOx3LUK2TyVMcUr35lLBTGu6ZgQ3PgmkFwmNR9nDWM9M5hxeCBwXZNg==
X-Gm-Gg: AeBDievxTWwvtI+FUT0KlfEFQWol0ADJI9WTsky6VolRALfR9DlnwA5gqLUWsZdGqPZ
 iraBY/KsaLbLr1r5/MJ5nD4KQGrdS0lkJphmYAoJ6sRCeNvx+7xpBQlKBSeyQvjl5wwDqTUf3UF
 ey8Bqk6L0ba/Yd7N/UYVrL3pUXyVFIR7dU32CfUmVWFXWNA3ATQqi5vvooOwM17dg35VtNppbdQ
 nyq/K96O15rcOvyPg8xzo4DpTsCLWY3t2J+X+5eTIpC9tsJpVGqtjx+q5KV5Nhi0s3U+/N3ISXo
 TluSX3WcQAAEsCq5dS/KPg2M6jDLDLuv1b3DDSWYUOSjFWCTxxz5xRFgd0AtnR0VQCeEpbNYh3Z
 L8/TEZaLSQY3FlXNVkY3OTqGzqUEVB4bihSJ+JaGKxWAlJ5exsIjP1LsR04fBqsIV3hpI3l6iHD
 2ylGxRQUuGM0Ezl4VbSYSmitT7GrcWvmLbysDpKsweZQ==
X-Received: by 2002:a17:90b:5683:b0:35e:576e:5bc with SMTP id
 98e67ed59e1d1-365ac79c531mr2199710a91.25.1778054105037; 
 Wed, 06 May 2026 00:55:05 -0700 (PDT)
Received: from jeuk-MS-7D42.. ([211.226.54.223])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-365b4bcaa49sm1380997a91.1.2026.05.06.00.55.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 00:55:04 -0700 (PDT)
From: Jeuk Kim <jeuk20.kim@gmail.com>
X-Google-Original-From: Jeuk Kim <jeuk20.kim@samsung.com>
To: qemu-devel@nongnu.org
Cc: jeuk20.kim@samsung.com, qemu-block@nongnu.org, qemu-stable@nongnu.org,
 j-young.choi@samsung.com
Subject: [PATCH 0/4] hw/ufs: Fix guest-triggerable MCQ crashes
Date: Wed,  6 May 2026 16:54:27 +0900
Message-ID: <cover.1778053560.git.jeuk20.kim@samsung.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-pj1-x102d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This series fixes four guest-triggerable bugs in the UFS MCQ emulation,
all reachable via MMIO writes to the UFS PCI BAR with mcq=on.

Patches 1-2 fix bugs reported by Rayhan Ramdhany Hanaputra:

  - Out-of-bounds array read: SQATTR.CQID is not checked against
    mcq_maxq before indexing u->cq[].
  - NULL dereference: SQ doorbell is processed without checking whether
    the SQ exists.
  - NULL dereference: CQ head doorbell is processed without checking
    whether the CQ exists.

Patches 3-4 fix additional bugs found during review:

  - Divide-by-zero: a small SQATTR.SIZE or CQATTR.SIZE produces a
    zero-depth queue that crashes when its pointers are advanced.
  - Use-after-free: disabling an SQ while requests are still in flight
    on the CQ list or in the SCSI layer frees memory that is still
    referenced by the completion paths.

Jeuk Kim (4):
  hw/ufs: Validate MCQ SQ references before use
  hw/ufs: Guard MCQ CQ accesses against missing queues
  hw/ufs: Reject zero-depth MCQ queues
  hw/ufs: Keep MCQ SQs alive while requests are outstanding

 hw/ufs/trace-events |  3 ++
 hw/ufs/ufs.c        | 92 +++++++++++++++++++++++++++++++++++++++------
 hw/ufs/ufs.h        |  9 ++++-
 3 files changed, 92 insertions(+), 12 deletions(-)

-- 
2.43.0


