Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4CA5D0EE19
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2024 17:25:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1szJFi-0005Qw-Hd; Fri, 11 Oct 2024 13:16:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1szJ7q-0003l6-OP
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 13:08:34 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1szEVp-0004qA-2X
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 08:12:54 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-20c593d6b1cso20427105ad.0
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2024 05:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1728648767; x=1729253567; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=4swU5K0xZ3bQs7A8y7vlQldTMkGkhqlNBJx9qR/gI5s=;
 b=T9HplrKIeCETWPZR7HY55yS1pWXSpsdD0X/K3uxuB5U8IaWtIRmJ9BFKnZ6axRREQH
 fDbZJXpdOppcmw2ji2myM8Lxt+fYWxXtQukvvApcydilqvmv1rEdlL3r1O72XqgsVyFX
 IJoLMFJlFiji76ssX4c1e/EQtAg3sf6kP7u+Z3eEtwgPqUQo7gWrvHPfJvXy9u3pNQiv
 nBKZdzBGb1vVV7BHZAU0rm/IBUBfWMxzq4iEeU2zwb0w4udf081M69sZUeISlE5eBnrc
 9psRQclpc4y5WKdO1qaVY5wvnNFVAnlIX7hrXEH0/M1FdOHmPYPDHUvMMNz4BpNiVzQN
 D7Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728648767; x=1729253567;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4swU5K0xZ3bQs7A8y7vlQldTMkGkhqlNBJx9qR/gI5s=;
 b=YnYQfwXvbj9ZJf6bXCbVz6JREgmY2cu1wFz41upvGk+9/b2yGZbkCzmBfmhab61SqB
 2tKRcdqA4FM+YGfhkFxp/7PgSofQBH+S2ML5PGvYj1ZzmRZ4k0ELRUH5Dui/vhFPmhHQ
 xiKHQgJfPhwtWlbtVyLN/s0iT2gpqPguKQ7YHfFHKfkvuEJF9FutXV0LAVCXELtjkAGQ
 ItJnDcXSdsECzEI2zHf2HS7CmcjASICg20t4TXc9JxV3UpiAyZyWDgB6VrtbTGnPCkWY
 IvWuj+ikyMs6b74TUpaNdmLZ9wnzRXRBrbq4wXKztTUJu4loPWZk1ZtCZyT+s5CRrIq1
 6dnQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVnqasobj86eTqtvlTSoeH0/3L4ULXpbtqIQ5fAoN1d1S5ZgxFws/khTZnXdet1LtMl2wfLG8bgR4Ey@nongnu.org
X-Gm-Message-State: AOJu0YwEbiilfFXNt/6RjM9eUppglDv5fTfOLb2bqVb3kL3KuTYBkuy1
 1XXWU2sE8j1t7L2nYoikumm8UFj0yBv7mBMZxyfFFNLZk++qqOfKRGJ0rfE2O/I=
X-Google-Smtp-Source: AGHT+IEpr0k17wXP45VVQYHwG0zGOceEWMLRK/rACRogBEiO0SYNYRqP/vHd7ldDFVD4j53lX9XTuQ==
X-Received: by 2002:a17:903:2d2:b0:20c:850f:d3d9 with SMTP id
 d9443c01a7336-20ca147231fmr33485405ad.24.1728648766692; 
 Fri, 11 Oct 2024 05:12:46 -0700 (PDT)
Received: from TF4D9JK212.bytedance.net ([139.177.225.232])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20c8bc13551sm22569305ad.88.2024.10.11.05.12.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 11 Oct 2024 05:12:46 -0700 (PDT)
From: Changqi Lu <luchangqi.123@bytedance.com>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, stefanha@redhat.com, fam@euphon.net,
 ronniesahlberg@gmail.com, pbonzini@redhat.com, pl@dlhnet.de,
 kbusch@kernel.org, its@irrelevant.dk, foss@defmacro.it, philmd@linaro.org,
 pizhenwei@bytedance.com, k.jensen@samsung.com,
 Changqi Lu <luchangqi.123@bytedance.com>
Subject: [PATCH v14 00/10] Support persistent reservation operations
Date: Fri, 11 Oct 2024 20:12:21 +0800
Message-Id: <20241011121231.18333-1-luchangqi.123@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=luchangqi.123@bytedance.com; helo=mail-pl1-x635.google.com
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

Patch v14 has been modified, thanks to Stefan for the code review.

v13->v14:
- Fix some protocol and spelling related issues at hw/nvme/ctrl.c.

v12->v13:
- Fix byte swaps at hw/nvme/ctrl.c.

v11->v12:
- Fixed endian conversion during command parsing;
- Add the maximum number of keys, currently limited to 128.

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

 block/block-backend.c             | 403 ++++++++++++++++++++++++++++
 block/io.c                        | 164 ++++++++++++
 block/iscsi.c                     | 428 ++++++++++++++++++++++++++++++
 block/raw-format.c                |  56 ++++
 hw/nvme/ctrl.c                    | 350 +++++++++++++++++++++++-
 hw/nvme/ns.c                      |  11 +
 hw/nvme/nvme.h                    |  93 +++++++
 hw/scsi/scsi-disk.c               | 374 ++++++++++++++++++++++++++
 include/block/block-common.h      |  40 +++
 include/block/block-io.h          |  20 ++
 include/block/block_int-common.h  |  84 ++++++
 include/block/nvme.h              | 121 ++++++++-
 include/scsi/constants.h          |  52 ++++
 include/scsi/utils.h              |   8 +
 include/sysemu/block-backend-io.h |  24 ++
 scsi/utils.c                      |  81 ++++++
 16 files changed, 2307 insertions(+), 2 deletions(-)

-- 
2.20.1


