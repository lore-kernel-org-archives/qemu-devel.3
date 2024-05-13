Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56F05C41513
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 03:53:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6Mk8-0001Cr-5G; Sun, 12 May 2024 23:52:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1s6Mk6-0001CL-AA
 for qemu-devel@nongnu.org; Sun, 12 May 2024 23:52:50 -0400
Received: from mail-oa1-x2d.google.com ([2001:4860:4864:20::2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1s6Mk3-0008Gj-IK
 for qemu-devel@nongnu.org; Sun, 12 May 2024 23:52:49 -0400
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-23eb1851c34so1632293fac.0
 for <qemu-devel@nongnu.org>; Sun, 12 May 2024 20:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1715572361; x=1716177161; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=k4r5bPkTEUA9UvUQXWiEYSWl/dR7TqRMtkaysq5leBU=;
 b=TQcPn+UG9+IBEmKOij/hfLzhIOMqO9wyrSDm5Htm/n0rS2W13WiSJNOHxVvzgVVTEg
 rCpBhylxW16G1P9FELlNUTt+9bA4z/E3tDq1RFFyZ3fx+efIXzGAqckpw9RfX8y0FXqE
 G4rOWptCmzE7PNZVs9TzHtJfqqhhjUuiccUPxizLqqP9Xk2q86Jl+prmOBsbve5mFK57
 hgAC9MbgMq6t/546EIXi4C4nPKCev0JUSrp1gPkIoSBr2dQyTzQzh/PHxk71z5t2tgHh
 ZbxF5Y8UpLzs0RCVrixb4CMm3xCbeovGwL8BpE2nmsE4ZYY8zG0v50pxGINK/p4zQyBM
 W9Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715572361; x=1716177161;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=k4r5bPkTEUA9UvUQXWiEYSWl/dR7TqRMtkaysq5leBU=;
 b=QblGgXjW1RavHF4TrBMOEgQYqtTWrVGNGl/xFnBDg06iHFmtULrC+6Cx4vZ1bX3m6A
 flOgs+ghGD9lcLQJPgMzYcUtLxkl8OS7ozJ362a6z1Xdw0bROec9wzG/U5TK80Ov9nY/
 HwPsc5BLVZM3A+xKKT/UTztNyjT94bADD8d1O9gGFRQSNL9FK7Dled0h9lwN8oYrd9Bj
 YtTNDMavZLPKS5JjJVfG7vELOp0WM+lXBRJ0gHpxEjV9iKaRacOa2HBm92UlPUNBzRhz
 nxMB2orGvnj4JX0s/Tbc5DKAYxuZ5jzQSZg9kd08NNYwfoI8Wym/oTTyKPrw3CJZ6oJa
 sUkw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUj8Z0vTGtM8Zfzp1MimqRAKGNss7D7v/qicqO9VVtazl5QIe+pTEWpMfuX6I6slNlu0zZTNKXo8YxBHZROz6TdujTPPno=
X-Gm-Message-State: AOJu0Yx8JUgAbxXeAKwFhq7cV8NOUCd11mgdGDvTjWxTRdv/9ulvBkbV
 s/WtTgsBeP2l0Z0xJ3X3w3nmZdu9znfDIAA6fdPDUR+9B3qsgUbgEiEd70KitdI=
X-Google-Smtp-Source: AGHT+IFoBcEAE/k1uP2FXwoHjqqHzjdF67mV+7cCLCu4PlhB2/Su2fxUDNWc4if8wLs8QKTHIOeYoA==
X-Received: by 2002:a05:6870:4345:b0:23e:8800:a56d with SMTP id
 586e51a60fabf-2417290e2a9mr10605740fac.10.1715572360959; 
 Sun, 12 May 2024 20:52:40 -0700 (PDT)
Received: from n37-006-243.byted.org ([180.184.51.40])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f4d2a8137asm6407947b3a.45.2024.05.12.20.52.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 May 2024 20:52:40 -0700 (PDT)
From: Changqi Lu <luchangqi.123@bytedance.com>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, stefanha@redhat.com, fam@euphon.net,
 ronniesahlberg@gmail.com, pbonzini@redhat.com, pl@dlhnet.de,
 kbusch@kernel.org, its@irrelevant.dk, foss@defmacro.it, philmd@linaro.org,
 pizhenwei@bytedance.com, Changqi Lu <luchangqi.123@bytedance.com>
Subject: [PATCH v2 00/11] Support persistent reservation operations
Date: Mon, 13 May 2024 11:52:19 +0800
Message-Id: <20240513035230.60162-1-luchangqi.123@bytedance.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2d;
 envelope-from=luchangqi.123@bytedance.com; helo=mail-oa1-x2d.google.com
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

Hi Stefan;

Thanks for your advices! The existing PRManager only works with
local scsi devices. This series will completely decouple devices
and drivers. The device can not only be scsi, but also other
devices such as nvme. The same is true for the driver,
which is completely unrestricted. And block/file-posix.c can
implement the new block driver, and pr_manager can be executed
after splicing ioctl commands in these drivers. This will be implemented
in subsequent patches.

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
- Add scsi driver at the driver layer to verify the functions.

Changqi Lu (11):
  block: add persistent reservation in/out api
  block/raw: add persistent reservation in/out driver
  scsi/constant: add persistent reservation in/out protocol constants
  scsi/util: add helper functions for persistent reservation types
    conversion
  hw/scsi: add persistent reservation in/out api for scsi device
  block/nvme: add reservation command protocol constants
  hw/nvme: add helper functions for converting reservation types
  hw/nvme: enable ONCS reservations
  hw/nvme: enable namespace rescap function
  hw/nvme: add reservation protocal command
  block/iscsi: add persistent reservation in/out driver

 block/block-backend.c             | 390 ++++++++++++++++++++++++++
 block/io.c                        | 161 +++++++++++
 block/iscsi.c                     | 448 ++++++++++++++++++++++++++++++
 block/raw-format.c                |  55 ++++
 hw/nvme/ctrl.c                    | 307 +++++++++++++++++++-
 hw/nvme/ns.c                      |   7 +
 hw/nvme/nvme.h                    |  44 +++
 hw/scsi/scsi-disk.c               | 348 +++++++++++++++++++++++
 include/block/block-common.h      |  40 +++
 include/block/block-io.h          |  19 ++
 include/block/block_int-common.h  |  85 ++++++
 include/block/nvme.h              |  92 ++++++
 include/scsi/constants.h          |  52 ++++
 include/scsi/utils.h              |   8 +
 include/sysemu/block-backend-io.h |  22 ++
 scsi/utils.c                      |  77 +++++
 16 files changed, 2153 insertions(+), 2 deletions(-)

-- 
2.20.1


