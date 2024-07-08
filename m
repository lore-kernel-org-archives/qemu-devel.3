Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A618C3271E
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2024 13:02:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQnzu-0003fX-MV; Mon, 08 Jul 2024 09:01:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1sQnzd-0003Nc-85
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 09:01:22 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1sQnza-0000VB-60
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 09:01:20 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-70b09c2ade6so1756230b3a.3
 for <qemu-devel@nongnu.org>; Mon, 08 Jul 2024 06:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1720443674; x=1721048474; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=tSEhHjiskCQhJXGxGcGe0FFAr/6d1dYEoUj2mKF099s=;
 b=hgizYYolmo7/Dt0Bx6riA+qiU6HU9wUS0BHRtx6aAfy+qyndhVX2kDs9zed+FqtSi7
 cLCfi0wVHxZO1XzOlHe7yhg+LGibyxSO8DGVMY6x/Jm5i0Tnfk4Cd5oCGXJ2Bcv5bJmL
 xrOM2SHnKwLQNZ9nARajqnR6vuX1RRJRu6hHmuD1mPUrPAlOLMikVablu9Mzm7i8lk3k
 m1sOsG4h89vTWDskfpB8ZeW41uCTCaF1YF8B46exxeW+iHwSNlrjbFWY2CtSF5BGlxRB
 EScw37Vt6is9UxH1DYIUXc3D/oTzKIhcDmZlf1CfKmMaRQZq9CknmRvPYB5ZIgfJpd8A
 Gi3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720443674; x=1721048474;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tSEhHjiskCQhJXGxGcGe0FFAr/6d1dYEoUj2mKF099s=;
 b=MRzq6nnNBNNFRptcOHS/lvhxBFd5CAu5ix2XuN2X3++Irdx70LmpKHrm0CYuTdj6Uj
 tuseHphX4M2/AgeNKB0Yik68pBq8PJOXv5+3aCwDE1Y39npGsYtY0N2PhxrOCh0zpjsQ
 ynm5CG3sesLuEc//UksM+097ajLLK6ZHJCykTmlbQQydconG+uXWCjmXtOar/7e7kO9s
 xsDNKBbzuC8SdpR7UyASIMC1I/jZdCe8wb+J5lm4oMEA5Vgi0F78AogXzFsKllwP+zVz
 8DD8gTC6poF32BHT3T/j8QFFGtt6yRLKCb6GCYX78LVUZuoFaUkGmrEGpj7vMgdpuqNG
 Katw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWIxw1FZJep99LwPZxTFW7STO8vSUQJoW+qhS1m7fajo97wkoNTx2+TDhz9gWqtdVT5tnQSZSNfXIJ+vk/WYNe84dbTZks=
X-Gm-Message-State: AOJu0Yw+acie8jijzezUUlFpRmkg/MW5DVdCsbT2HjyPF8bkA4Fcm3pI
 1Dti66KOpQrCoCNCPlqVpJ31muB9wgxB+64gHJiRmb9171UN7EI2sUAyqSYQySE=
X-Google-Smtp-Source: AGHT+IHLMgMkfXEI7L+Cxw3qyJs6cxGokV/mdtp4/KERTJGMcnsMnSaaoDyhAAYhsRs6GFo0p1pt1g==
X-Received: by 2002:a05:6a00:198f:b0:706:31d9:9ca0 with SMTP id
 d2e1a72fcca58-70b00927369mr10286644b3a.4.1720443674395; 
 Mon, 08 Jul 2024 06:01:14 -0700 (PDT)
Received: from n37-006-243.byted.org ([180.184.51.134])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70b15e0cefcsm5219872b3a.166.2024.07.08.06.01.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jul 2024 06:01:14 -0700 (PDT)
From: Changqi Lu <luchangqi.123@bytedance.com>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, stefanha@redhat.com, fam@euphon.net,
 ronniesahlberg@gmail.com, pbonzini@redhat.com, pl@dlhnet.de,
 kbusch@kernel.org, its@irrelevant.dk, foss@defmacro.it, philmd@linaro.org,
 pizhenwei@bytedance.com, Changqi Lu <luchangqi.123@bytedance.com>
Subject: [PATCH v8 00/10] Support persistent reservation operations
Date: Mon,  8 Jul 2024 21:00:57 +0800
Message-Id: <20240708130107.11495-1-luchangqi.123@bytedance.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=luchangqi.123@bytedance.com; helo=mail-pf1-x42c.google.com
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


