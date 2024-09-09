Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93AE8ECE57E
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 11:36:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sncfs-0001cZ-Ph; Mon, 09 Sep 2024 07:35:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1sncfp-0001Vb-K2
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 07:35:13 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1sncfl-00010m-PG
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 07:35:13 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2057c6c57b5so22663305ad.1
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 04:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1725881703; x=1726486503; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=27gz/vZuThPHRcY/Qj+UEahQLS0Wv5RxC6HKL79z4y4=;
 b=j14tpxfgiNiuPEWY3PdoejwOpzrFnOgPsIcdSQA4uYlfIxcleJdWzgZ8nJ/hkdTep9
 mYmGQGLMR2SrfgeE5Vo9BNSkiS0SCe0mSW3M0fEQPOsZi+a92iEprmWiLsvrIwbL30+S
 QMzeBqYRtuRWAJEC8l9RHBv1G1OPa1Wmi1ul7kb/BS8pwXX3ebGnXjIIWrbOL0AEwRXU
 A6YDI4Z3j06yAB8Kjm5pk7irDj7vfx9r5rk+c3oh3D7sylQQjK9H9YlbA1pQ6zy77BEA
 tRqE+SYIqFp9IMSZ6uy+SbACH5h7Glpk6lNjA9l6dTsuiUo7I4SU0poE3aW9V36jUf9Y
 aJjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725881703; x=1726486503;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=27gz/vZuThPHRcY/Qj+UEahQLS0Wv5RxC6HKL79z4y4=;
 b=gprctPZw2V5dMiuakCvScnI88CaYF0RkeoQj1NtRnLHnWYXVYb8LOqxslOtCjD3G4G
 iMHLdK4HnCPHJWaLhkBgrQJcs6QFEMaWq0diXXN0gFQnjhnFWSizMeJg1E9UyVDvngPk
 UQJKl4gb6/p06VTqIIr42pf7URteHp2t2+Wd9MWg89RbRk4ZRJwbuDKw9xvmkwHP8jo2
 Ejl/XrMmpMMJgo2PMACLfCQAkosf6vkGkQJW6GgfYgRqnmANCh4iEvDb8dFAMb7en0kH
 gKzvCFIEpDphz1H9xtPRUtMnk2womE1CSOkLA23aEsF1RI5rlxbuuBCT1o1P0WkQ20NA
 SFBA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUBTqpOLpXPEH1jB/ZoHRbiUz/zusF2bsrF7C96GBa83vLPLpy0UqifPOFNd/HbLfwlyggwFS06dTFT@nongnu.org
X-Gm-Message-State: AOJu0YybzzwuU/Nkgd4pQ9wEusD9+hOtwG87aE8nBRBAB6a1bT5U1oA1
 bKXjlUZ0CqOsp7FKpUlp9gaw5xZxmfWGPrbrkeOt11xh9rIaBV+uPkYPB5nz5rk=
X-Google-Smtp-Source: AGHT+IEVlMCi1n9dXoAtZHeJyiE/Yx0JntwXXvkconQQK/kwb7RjOn6wnQJkel4DFS+fxbhu8D1+eA==
X-Received: by 2002:a17:902:da86:b0:205:5bc9:37df with SMTP id
 d9443c01a7336-206b848b292mr259855725ad.30.1725881703437; 
 Mon, 09 Sep 2024 04:35:03 -0700 (PDT)
Received: from TF4D9JK212.bytedance.net ([61.213.176.5])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20710e328aasm32378605ad.91.2024.09.09.04.34.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 09 Sep 2024 04:35:02 -0700 (PDT)
From: Changqi Lu <luchangqi.123@bytedance.com>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, stefanha@redhat.com, fam@euphon.net,
 ronniesahlberg@gmail.com, pbonzini@redhat.com, pl@dlhnet.de,
 kbusch@kernel.org, its@irrelevant.dk, foss@defmacro.it, philmd@linaro.org,
 pizhenwei@bytedance.com, k.jensen@samsung.com,
 Changqi Lu <luchangqi.123@bytedance.com>
Subject: [PATCH v11 00/10] Support persistent reservation operations
Date: Mon,  9 Sep 2024 19:34:43 +0800
Message-Id: <20240909113453.64527-1-luchangqi.123@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=luchangqi.123@bytedance.com; helo=mail-pl1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Patch v11 has been modified, thanks to Klaus for the code review.

v10->v11:
- Before executing the pr operation, check whether it is supported.
  If it is not supported, return NVME_INVALID_OPCODE directly.

v9->v10:
- When the driver does not support the pr operation, the error
  code returned by nvme changes to Invalid Command Opcode.

v8->v9:
- Fix double-free and remove persistent reservation operations at nvme_is_write().

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

 block/block-backend.c             | 403 +++++++++++++++++++++++++++
 block/io.c                        | 164 +++++++++++
 block/iscsi.c                     | 433 ++++++++++++++++++++++++++++++
 block/raw-format.c                |  56 ++++
 hw/nvme/ctrl.c                    | 349 +++++++++++++++++++++++-
 hw/nvme/ns.c                      |  11 +
 hw/nvme/nvme.h                    |  93 +++++++
 hw/scsi/scsi-disk.c               | 368 +++++++++++++++++++++++++
 include/block/block-common.h      |  40 +++
 include/block/block-io.h          |  20 ++
 include/block/block_int-common.h  |  84 ++++++
 include/block/nvme.h              | 107 +++++++-
 include/scsi/constants.h          |  52 ++++
 include/scsi/utils.h              |   8 +
 include/sysemu/block-backend-io.h |  24 ++
 scsi/utils.c                      |  81 ++++++
 16 files changed, 2291 insertions(+), 2 deletions(-)

-- 
2.20.1


