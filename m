Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A92B0C27C4F
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2024 07:16:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHeea-0007Rz-9g; Thu, 13 Jun 2024 03:13:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1sHeeY-0007RY-3c
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 03:13:46 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1sHeeV-00071Z-KR
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 03:13:45 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1f8395a530dso7012085ad.0
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2024 00:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1718262816; x=1718867616; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=VEapZkZteW4qeme8HOj8a7YKtrOu1VtdYrrvlphJVHo=;
 b=EujvQEmG/6xAFIQ0l2yfPwxzsVX4xHmR/9eqsKnXJHqs5zmDUNtUL36jDogmGNoTjb
 FdjSW5FiwCDC9N3poSw6Lzg13REngcS28rRZF1TuOIoMpzDsuxoZjmtUNKjp4WssaiWm
 v0fOpp/859ESKlibjO7NJO6l8aJ5l9AevPlsTNV/QTj8VP/O/M2ivWDg+aFahTOtphva
 nGIIkf+nFGwdkB0rgbw93x1damiyBHSh++PZqEUycbAZYjbnuoVvMwurM5J02Nc+YroO
 BArqUeGTq9LVp8oigYj13kOKVY/iPXPrhyvGfPmY9y+8MimB6jgKV+AFmADrK+eGmq2d
 /VJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718262816; x=1718867616;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VEapZkZteW4qeme8HOj8a7YKtrOu1VtdYrrvlphJVHo=;
 b=EeXq2uyVjH1fdEw9uMzKePWUJp2zuZzl1RlujieCUq/8vBIyUFF8pOz/Sxh0OjsuoS
 w2cH3dLy9XJ8eENPGjvzhiq0zEXBd/t2qSUbembZC43kJXUzvYie0FgSr9+IR+MM7sHw
 ERPX9MLdASuCmggBgctaHfHxwdkRdncVnfVaQ/W6yy0MM1HsLiB0Svaoy+oncjf3YkN+
 MvDP0nD1FDicaYWWP5B3/w4wWmNsiNGxEUF/56l5aZG6ks1HIW7BS6UjOQkFQ+M/fEbM
 AQR2VAvaAk3ZjBMZf44dcnvOnN/YbwCp69br0Ft1hCGQNoiak+yrAJOOEgIq1UVL2zTg
 GWZg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWqp229P0ZTKrNq3T91V5apqS3q5H8zG/kzePauMLZNGyyEiajEehwpxC+NT/98sZlvBjPHRxnu/1wjwv87uq3Er03priQ=
X-Gm-Message-State: AOJu0Yy0BXzNEL6apcXzloKPGKHLYIKjz3x4qCBs+JwmTcTJzNsd6sJQ
 uw2RzjoDd1/qXJ2yMDCWAEvcAjN0xrl0iZ1eF2tdZvXYeL35ULP5KA4mPZWwUrI=
X-Google-Smtp-Source: AGHT+IGkW+wkgaTZ/6CMQsZUYnsgp93HOMCC6/jyYjYLy+l6/ZzzKbJuJg4jfNO8nziau2W+uhFBgQ==
X-Received: by 2002:a17:902:f541:b0:1f7:21fd:ab83 with SMTP id
 d9443c01a7336-1f83b710598mr42153655ad.54.1718262815896; 
 Thu, 13 Jun 2024 00:13:35 -0700 (PDT)
Received: from n37-006-243.byted.org ([180.184.84.173])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f855ee6e7esm6378345ad.139.2024.06.13.00.13.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Jun 2024 00:13:35 -0700 (PDT)
From: Changqi Lu <luchangqi.123@bytedance.com>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, stefanha@redhat.com, fam@euphon.net,
 ronniesahlberg@gmail.com, pbonzini@redhat.com, pl@dlhnet.de,
 kbusch@kernel.org, its@irrelevant.dk, foss@defmacro.it, philmd@linaro.org,
 pizhenwei@bytedance.com, Changqi Lu <luchangqi.123@bytedance.com>
Subject: [PATCH v6 00/10] Support persistent reservation operations
Date: Thu, 13 Jun 2024 15:13:17 +0800
Message-Id: <20240613071327.2498953-1-luchangqi.123@bytedance.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=luchangqi.123@bytedance.com; helo=mail-pl1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

patch v6 has been modified.

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
 block/io.c                        | 163 +++++++++++
 block/iscsi.c                     | 443 ++++++++++++++++++++++++++++++
 block/raw-format.c                |  56 ++++
 hw/nvme/ctrl.c                    | 326 +++++++++++++++++++++-
 hw/nvme/ns.c                      |   5 +
 hw/nvme/nvme.h                    |  84 ++++++
 hw/scsi/scsi-disk.c               | 352 ++++++++++++++++++++++++
 include/block/block-common.h      |  40 +++
 include/block/block-io.h          |  20 ++
 include/block/block_int-common.h  |  84 ++++++
 include/block/nvme.h              |  98 +++++++
 include/scsi/constants.h          |  52 ++++
 include/scsi/utils.h              |   8 +
 include/sysemu/block-backend-io.h |  24 ++
 scsi/utils.c                      |  81 ++++++
 16 files changed, 2237 insertions(+), 2 deletions(-)

-- 
2.20.1


