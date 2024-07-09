Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4352C3271E
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 02:48:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sR0t0-0005n1-FE; Mon, 08 Jul 2024 22:47:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1sR0sy-0005lM-8w
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 22:47:20 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1sR0sw-0003na-8X
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 22:47:20 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-2c95ca60719so2721757a91.3
 for <qemu-devel@nongnu.org>; Mon, 08 Jul 2024 19:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1720493236; x=1721098036; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=rLPuNk6WnrxhDVSQumXF4B+IsPv49XBim5zto6sLs3U=;
 b=diTTz6iaQlCSUuCJIFHQUYl0AEdqXcE1gZVRtJJgj+RYTRf9bSo9Gpa4KAtzum8NYM
 xzv8pR1FEPRs5r7xWP64CcXqgIJP2Z2d+/dH/1lgFivjs4vjMLsAWaMVGDQ/R+T84MvE
 vbE8yLdp6Q/Aqqp3Y404O1dwpM9305MylAb/P3FyP1Y+KaRMvNYU4xqLOi3AABlNIOwh
 +nQNYxDWKfAOrcoA9jQLfVa/Jzd+PKwKYL0axnc4zPKpdb+8hyGTqT82Btk4L9Mr7sxp
 tkSBeV7aYVQIGIEzW6DMfK2PGc1urF2zJDOhhyxWVtHRz3V//chMcPNqxPOC4+I9SVwW
 q06Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720493236; x=1721098036;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rLPuNk6WnrxhDVSQumXF4B+IsPv49XBim5zto6sLs3U=;
 b=dAPeSunyCRQHR2aep9FMfftoQEmqLodzM0nV06Omk3CGrzQxPzUG9uVzOJ9ej561Y2
 3ubF0H1sEJbfFE6Yot73Q9R5kD/IBT6LymnSdatsEu+i5yoC4TOVXb1SoK9sUi0iQpbm
 bFDdhQf5ddN4ajQnTfIglklP5eVoYYkNLipsk7UJBNzHXbER2NayfYA8NqKof52/VnP1
 DyPuQlCwfbWVhB7fDn/hkTt2zZeIiPxOui7NEKPGMG47Dly1hvBF6uow4r6TpXsxGSt9
 sBCXNHCAIF/BPHdXBVfTT+io1ShF1uNkbZITPKu631VMPXbNbrTfvrQFLFvin/1lN2SG
 Sb2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCU47RBbEElbquWwgFtRvgDXfejy3rj0j88qzY7og/40Mu8LheEIN4Laiey4DRbbE2I3wJVaQNA5u7YncROzWnTiHD2YXOE=
X-Gm-Message-State: AOJu0YzmksMqzv9Sf7eC0OSV98uhPbI1CQcu8kuYp+x0/p3+lc3ezLSz
 Z1JwJzTY1AaVtrd2LBelz0WPciIwx+Mj1VNr+TY4jw/grW4HafdKz7x9p3A/SFo=
X-Google-Smtp-Source: AGHT+IFg1Wkw7OZb0/NLj/FRL1eHcOd3CWTrLaNcr1O24YPGdjcviPhpaqNNruAJYmYSaL0LTvhHNw==
X-Received: by 2002:a17:90a:bf90:b0:2c9:e0d3:1100 with SMTP id
 98e67ed59e1d1-2ca35c362e7mr1169577a91.19.1720493236375; 
 Mon, 08 Jul 2024 19:47:16 -0700 (PDT)
Received: from TF4D9JK212.bytedance.net ([61.213.176.9])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c99a97e8a5sm8964661a91.27.2024.07.08.19.47.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 08 Jul 2024 19:47:16 -0700 (PDT)
From: Changqi Lu <luchangqi.123@bytedance.com>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, stefanha@redhat.com, fam@euphon.net,
 ronniesahlberg@gmail.com, pbonzini@redhat.com, pl@dlhnet.de,
 kbusch@kernel.org, its@irrelevant.dk, foss@defmacro.it, philmd@linaro.org,
 pizhenwei@bytedance.com, Changqi Lu <luchangqi.123@bytedance.com>
Subject: [PATCH v8 00/10] Support persistent reservation operations
Date: Tue,  9 Jul 2024 10:46:56 +0800
Message-Id: <20240709024706.4108-1-luchangqi.123@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=luchangqi.123@bytedance.com; helo=mail-pj1-x1035.google.com
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

Sorry, due to network problems, the patch I sent earlier was incomplete.

Stefan, the issue you mentioned has been fixed.

Almost all patches have been reviewed, thank you very much
to Stefan and Klaus.


v7->v8:
- Fix num_keys may be less than 0 at scsi_pr_read_keys_complete().
- Fix buf memory leak at iscsi driver.

v6->v7:
- Add buferlen size check at SCSI layer.
- Add pr_cap calculation in bdrv_merge_limits() function at block layer,
  so the ugly bs->file->bs->bl.pr_cap in scsi and nvme layers was
  changed to bs->bl.pr_cap.
- Fix memory leak at iscsi driver, and some other spelling errors.

v5->v6:
- Add relevant comments in the io layer.

v4->v5:
- Fixed a memory leak bug at hw/nvme/ctrl.c.

v3->v4:
- At the nvme layer, the two patches of enabling the ONCS
  function and enabling rescap are combined into one.
- At the nvme layer, add helper functions for pr capacity
  conversion between the block layer and the nvme layer.

v2->v3:
In v2 Persist Through Power Loss(PTPL) is enable default.
In v3 PTPL is supported, which is passed as a parameter.

v1->v2:
- Add sg_persist --report-capabilities for SCSI protocol and enable
  oncs and rescap for NVMe protocol.
- Add persistent reservation capabilities constants and helper functions for
  SCSI and NVMe protocol.
- Add comments for necessary APIs.

v1:
- Add seven APIs about persistent reservation command for block layer.
  These APIs including reading keys, reading reservations, registering,
  reserving, releasing, clearing and preempting.
- Add the necessary pr-related operation APIs for both the
  SCSI protocol and NVMe protocol at the device layer.
- Add scsi driver at the driver layer to verify the functions


Changqi Lu (10):
  block: add persistent reservation in/out api
  block/raw: add persistent reservation in/out driver
  scsi/constant: add persistent reservation in/out protocol constants
  scsi/util: add helper functions for persistent reservation types
    conversion
  hw/scsi: add persistent reservation in/out api for scsi device
  block/nvme: add reservation command protocol constants
  hw/nvme: add helper functions for converting reservation types
  hw/nvme: enable ONCS and rescap function
  hw/nvme: add reservation protocal command
  block/iscsi: add persistent reservation in/out driver

 block/block-backend.c             | 403 ++++++++++++++++++++++++++++
 block/io.c                        | 164 ++++++++++++
 block/iscsi.c                     | 425 ++++++++++++++++++++++++++++++
 block/raw-format.c                |  56 ++++
 hw/nvme/ctrl.c                    | 326 ++++++++++++++++++++++-
 hw/nvme/ns.c                      |   5 +
 hw/nvme/nvme.h                    |  88 +++++++
 hw/scsi/scsi-disk.c               | 368 ++++++++++++++++++++++++++
 include/block/block-common.h      |  40 +++
 include/block/block-io.h          |  20 ++
 include/block/block_int-common.h  |  84 ++++++
 include/block/nvme.h              | 100 ++++++-
 include/scsi/constants.h          |  52 ++++
 include/scsi/utils.h              |   8 +
 include/sysemu/block-backend-io.h |  24 ++
 scsi/utils.c                      |  81 ++++++
 16 files changed, 2241 insertions(+), 3 deletions(-)

-- 
2.20.1


