Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 635BACCF9E9
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2024 07:48:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stjCd-0002Jt-0V; Thu, 26 Sep 2024 03:46:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1stjCW-0001xJ-OB
 for qemu-devel@nongnu.org; Thu, 26 Sep 2024 03:46:12 -0400
Received: from mail-io1-xd2c.google.com ([2607:f8b0:4864:20::d2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1stjCQ-0006Fe-ET
 for qemu-devel@nongnu.org; Thu, 26 Sep 2024 03:46:10 -0400
Received: by mail-io1-xd2c.google.com with SMTP id
 ca18e2360f4ac-8323b555a6aso44499839f.3
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2024 00:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1727336758; x=1727941558; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=EP6OpBPbhOC6nNPasYk/AM6cEN/mrc6105iISnxu3lY=;
 b=bnCa345ObKjJOxGF0PeGAIuKLnUun/CbRE199JlEkNEuP8UUNCZ9BQ6R5muRVmSKrF
 h3entf2cEIlTzyPMNbIlrXQcX4YcRBsLgzwD2LH6tBAi0wMVoBINQU4ZcYwDny02zJqc
 ndkOuZkrpotzG1gogrLplFuyXu8rTc2QlPL68nGvCMoHH1k11RGPPOQ5NZsyVda2/NMz
 Xv0CrLMwiRjDsowGLWk6rexXXI/ug9LrhxemYNInPvxKTSlBc+HVaUtcGkx3T9+acsLb
 edX9CLDiu5HKUXITrhhYgeeUGvTgcQO3N/xQlPiozP91HxRpuc366Fm3bH6caph91vkn
 g9Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727336758; x=1727941558;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EP6OpBPbhOC6nNPasYk/AM6cEN/mrc6105iISnxu3lY=;
 b=qjaHr6rX5CXhgTbloRhSOqIrBdPzcfW6Y6SzS7gUwVv8pP+OQBDlNZyXnu8VbiHChn
 SZD+NM9tJcF72qxwgIKlYZSr6LUYsJR8Od0jcMWeG61ZesU3bf3JNwdMw83R7r27Pt9Z
 3DcP/VagybQGRUonDyPbBN3m9agIRvxcNAwuSaocgYkHcjU0k2TwRWY82hTq1N8l6NQI
 Fmia6ww7riKE5bgapM3FEgd4lldnp/grSeJ6S/ojBNXwHvylK2MsslKu9xu4OCjy4ADN
 6lf88ueukLViPHGrzcmXNokyvjozGx9sYcmUIZVUjhko4hX6wWRdfnk91csY1KwSIOJ2
 vF7Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCW1eSpzcrme73wpMp1IgfMTu/g2PT9aYfCdo38Ru+x/gwrYtuYm6+RHn9eywNS85igK4tmY9F+n/PJ4@nongnu.org
X-Gm-Message-State: AOJu0YyGIvCA1IYV9RQvVMT6GqxdrQ1JlhRNHHaxkN5/+7edGoCshpDv
 4SJkwL1UXaKmJcgmiCp8bYFmPV/LNp97Hg9csAgkQqfIEosJptfht6oCbfa+Xog=
X-Google-Smtp-Source: AGHT+IGMEaHmjhKy5xQg3QSEo5wEAboBqEmT/Z0xWA8QoOhjzobvkdLtS+AbSt7MtSCO0A2q4Wp/Yw==
X-Received: by 2002:a05:6602:2dd2:b0:82a:4e38:b47c with SMTP id
 ca18e2360f4ac-83247cf53dbmr561906139f.1.1727336757733; 
 Thu, 26 Sep 2024 00:45:57 -0700 (PDT)
Received: from TF4D9JK212.bytedance.net ([61.213.176.7])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7e6b7c31bb5sm3683357a12.16.2024.09.26.00.45.52
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 26 Sep 2024 00:45:57 -0700 (PDT)
From: Changqi Lu <luchangqi.123@bytedance.com>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, stefanha@redhat.com, fam@euphon.net,
 ronniesahlberg@gmail.com, pbonzini@redhat.com, pl@dlhnet.de,
 kbusch@kernel.org, its@irrelevant.dk, foss@defmacro.it, philmd@linaro.org,
 pizhenwei@bytedance.com, k.jensen@samsung.com,
 Changqi Lu <luchangqi.123@bytedance.com>
Subject: [PATCH v13 00/10] Support persistent reservation operations
Date: Thu, 26 Sep 2024 15:45:36 +0800
Message-Id: <20240926074546.24507-1-luchangqi.123@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::d2c;
 envelope-from=luchangqi.123@bytedance.com; helo=mail-io1-xd2c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Patch v13 has been modified, thanks to Stefan for the code review.

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

 block/block-backend.c             | 403 +++++++++++++++++++++++++++
 block/io.c                        | 164 +++++++++++
 block/iscsi.c                     | 433 ++++++++++++++++++++++++++++++
 block/raw-format.c                |  56 ++++
 hw/nvme/ctrl.c                    | 362 ++++++++++++++++++++++++-
 hw/nvme/ns.c                      |  11 +
 hw/nvme/nvme.h                    |  94 +++++++
 hw/scsi/scsi-disk.c               | 374 ++++++++++++++++++++++++++
 include/block/block-common.h      |  40 +++
 include/block/block-io.h          |  20 ++
 include/block/block_int-common.h  |  84 ++++++
 include/block/nvme.h              | 107 +++++++-
 include/scsi/constants.h          |  52 ++++
 include/scsi/utils.h              |   8 +
 include/sysemu/block-backend-io.h |  24 ++
 scsi/utils.c                      |  81 ++++++
 16 files changed, 2311 insertions(+), 2 deletions(-)

-- 
2.20.1


