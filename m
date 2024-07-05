Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B38CAC3271F
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 10:57:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPgcB-0002AT-F4; Fri, 05 Jul 2024 06:56:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1sPgc9-00028X-Kt
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 06:56:29 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1sPgc7-0006Yk-7F
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 06:56:29 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1fafb9a33b3so7964575ad.1
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2024 03:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1720176983; x=1720781783; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=3e7KptOEaYocxrc+0ZzQ+mp68VC1C9a7NZ0Is9aEo14=;
 b=T8/CRCe4BzZV0BHm9SgmpGar9BbylhsbIbyelmwCZ/e4S92bWAxEycLY1TxePLH0xd
 uHo8s3nqyvprTJBK0Fdg6Lg1yLskq/yyRD7ryb8MHdqELPHVERTBrpY2c972/Qv0PveC
 taMKzbJJE11O6cQ/AOdCWW/uGX/EJLxNHITf1hf5QvszprcHlaAxZQi1B+c732QhGjCk
 5QAEe5fxKOdz52chBUjHPnpdELGel6NGj3AJLc18FyLdDYdDCYPI2cacPwWA0esiRv5I
 IbCsnLiJxwvqdqtAkvLCenTn5R7tK+pdhWnOcMQOu6hIHypFeI1fu/0dGgxpOkv/oLOA
 TClg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720176983; x=1720781783;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3e7KptOEaYocxrc+0ZzQ+mp68VC1C9a7NZ0Is9aEo14=;
 b=onNIyq09vuLzS+7P4VOpsnwZwHTm/LVU9BBtY9cuED40nncT8EFNVQfH654MAxxjvz
 71U0pkfzyyRpKKbl66WO3oLKkDwlVETh4nzfz78VNFe938lw/w9q4YC7+YTruodsEmhR
 sXcHRDb8Ybr4k0tPch07Gdd+xVfYao1VovRBaOdRPIxngIwWnKoOUv7ucIv5EIlXdcMa
 jONVISuXm/0Qh1Or72DX1SAt06yHHrWAbOMfqmUC6N1tmH9u8Hj5ZDtv0NlgXuiL67aB
 +0UsEAHDeOWUN+CpZeDUD4rOXqzmLr47ni4GKOzN0AHUnWS0WzZf3Mvwp/3S9Powt2jM
 aqvQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWAkzjgZYmV99BKetaixSsj4PzvxpXyjWHhAg2vtn9sxWBZ2rXwdtEN73zCInNQ8ugpV0FlvsDaRvSmaPCIkgrUfgtf+nc=
X-Gm-Message-State: AOJu0Yw96LchEoxMEO+w0RRqA1nmwEQKlYsC3JAxZHTZE2scKxkc5nub
 78ZUiZbs/1Vq2lMTZhb3o/j52kgXe9EABynq6HzrA4D7uURjv1V2449hx3thp7Q=
X-Google-Smtp-Source: AGHT+IHUvyKSArRdVDiB6xOnr5PwB5zve/fCiXrjoZF/7khnaRp0Vf6a5LvpX7Wmirh2P1QTfRNRzw==
X-Received: by 2002:a17:902:f54f:b0:1fb:30f2:3b80 with SMTP id
 d9443c01a7336-1fb33efe08emr32074185ad.52.1720176982973; 
 Fri, 05 Jul 2024 03:56:22 -0700 (PDT)
Received: from n37-006-243.byted.org ([180.184.84.173])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fac0ba60a2sm141292125ad.0.2024.07.05.03.56.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jul 2024 03:56:22 -0700 (PDT)
From: Changqi Lu <luchangqi.123@bytedance.com>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, stefanha@redhat.com, fam@euphon.net,
 ronniesahlberg@gmail.com, pbonzini@redhat.com, pl@dlhnet.de,
 kbusch@kernel.org, its@irrelevant.dk, foss@defmacro.it, philmd@linaro.org,
 pizhenwei@bytedance.com, Changqi Lu <luchangqi.123@bytedance.com>
Subject: [PATCH v7 00/10] Support persistent reservation operations
Date: Fri,  5 Jul 2024 18:56:04 +0800
Message-Id: <20240705105614.3377694-1-luchangqi.123@bytedance.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=luchangqi.123@bytedance.com; helo=mail-pl1-x62f.google.com
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

Hi,

Patch v7 has been modified.
Thanks again to Stefan for reviewing the code.

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
 block/iscsi.c                     | 431 ++++++++++++++++++++++++++++++
 block/raw-format.c                |  56 ++++
 hw/nvme/ctrl.c                    | 326 +++++++++++++++++++++-
 hw/nvme/ns.c                      |   5 +
 hw/nvme/nvme.h                    |  88 ++++++
 hw/scsi/scsi-disk.c               | 368 +++++++++++++++++++++++++
 include/block/block-common.h      |  40 +++
 include/block/block-io.h          |  20 ++
 include/block/block_int-common.h  |  84 ++++++
 include/block/nvme.h              | 100 ++++++-
 include/scsi/constants.h          |  52 ++++
 include/scsi/utils.h              |   8 +
 include/sysemu/block-backend-io.h |  24 ++
 scsi/utils.c                      |  81 ++++++
 16 files changed, 2247 insertions(+), 3 deletions(-)

-- 
2.20.1


