Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3580BC19F4F
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 13:14:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4h5s-0005DZ-7z; Wed, 08 May 2024 09:12:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1s4dkb-0007La-O4
 for qemu-devel@nongnu.org; Wed, 08 May 2024 05:38:13 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1s4dkZ-0000WN-2Z
 for qemu-devel@nongnu.org; Wed, 08 May 2024 05:38:13 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1edfc57ac0cso25495555ad.3
 for <qemu-devel@nongnu.org>; Wed, 08 May 2024 02:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1715161087; x=1715765887; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=IAz7iaY05iUXwWWdMEiJCHMpa1weX6eAJlOf0zRUJsI=;
 b=cIo5GA11maEZMRszk41DojX2YvOX2Tl/9zKDb/pTUnW0CwbkyCdI+abCnlO1U0Sb0T
 7VY7O/ecsmIrnjXputDtfeJijg85B/jSaaDKDXURMQO1jyKqOiTiTu2fKT/xALu0Fi4i
 MRFWBOyjFYRWk5flkncvWrWZT8Yu6GXKIsBt9X2E3wZzx7eWEiab1tSspI2Qn+3rIO8S
 o5ZULWLPlZ/pfFanNbTLuQMFVt/Rtc5qa579A/77etK7fmWcnoq80qEF5EnqmU3JAM79
 L2afySdXH9JrCC+lP9cNvzhhgKSejobQhpy/vT7Vs8rkx9c9whEFWtGmYXYsntlWH1c1
 wtRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715161087; x=1715765887;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IAz7iaY05iUXwWWdMEiJCHMpa1weX6eAJlOf0zRUJsI=;
 b=g+rnzQ7tkFfKXDOFWb4p1uiaoDeZuBFspxxI/Bu71PL3VX18w/Iyyut2vp8bx5DQbV
 I2uIArVC5FTeMOuCFt4s0dQZ5fQhonLwAH83uFHUPsxwgJfWN5Yd7rOHcPWxyqT0y66I
 4HGVH+H4TAJyT0b5YeUoS7kmfcTyeSnOEHnRNr1OIepZ4NMYAAFj1yGZHHlS2GFnEaA0
 XjDBZVLvtm5Z/2tjqFjSolpAWwlnSf4iGqKm6aW0b15RAoTDzhEesV4XPuWCSC9mUKUD
 1fiXzHMWgacQOhoMsG9fGbLCd6nnZ04s8e5pt/hmn9QWNk8lN1UwSnO9iRe03y24mqNB
 L9jg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVGhgsvCUEmFUUK8/a1pK1BbKNwV1JpWFtNPvO2hkHH0l9O7pGzbAXFAafAVA/JV4nSmpvA4VaCQxrDMqRKcjffc86gPT8=
X-Gm-Message-State: AOJu0YxdZAUd4X6doGvJ9ys84bRpv/28Nrx1N+CCa+mCXXZ5JJstu8ch
 L8iCreaJP4HoEgTBuGCnw2kJ5PY2SAPZvXg4njjXdozumnN7FVQM+66bh/caztQ=
X-Google-Smtp-Source: AGHT+IFW9RCkoIY5BOEXclPdOm2PKvfv8Ss+V9Je/tx3ER+sMYEQcD9WHY0UyvkfRhb3P1ns7f03ZQ==
X-Received: by 2002:a17:903:1cf:b0:1ee:b35e:963f with SMTP id
 d9443c01a7336-1eeb35e9676mr18298735ad.26.1715161086796; 
 Wed, 08 May 2024 02:38:06 -0700 (PDT)
Received: from n37-006-243.byted.org ([180.184.51.134])
 by smtp.gmail.com with ESMTPSA id
 p16-20020a1709027ed000b001ee13eb2bedsm4992178plb.98.2024.05.08.02.38.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 May 2024 02:38:06 -0700 (PDT)
From: Changqi Lu <luchangqi.123@bytedance.com>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, stefanha@redhat.com, fam@euphon.net,
 ronniesahlberg@gmail.com, pbonzini@redhat.com, pl@dlhnet.de,
 kbusch@kernel.org, its@irrelevant.dk, foss@defmacro.it, philmd@linaro.org,
 Changqi Lu <luchangqi.123@bytedance.com>
Subject: [PATCH 0/9] Support persistent reservation operations
Date: Wed,  8 May 2024 17:36:20 +0800
Message-Id: <20240508093629.441057-1-luchangqi.123@bytedance.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=luchangqi.123@bytedance.com; helo=mail-pl1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 08 May 2024 09:12:22 -0400
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

I am going to introduce persistent reservation for QEMU block.
There are three parts in this series:

Firstly, at the block layer, the commit abstracts seven APIs related to
the persistent reservation command. These APIs including reading keys,
reading reservations, registering, reserving, releasing, clearing and preempting.

Next, the commit implements the necessary pr-related operation APIs for both the
SCSI protocol and NVMe protocol at the device layer. This ensures that the necessary
functionality is available for handling persistent reservations in these protocols.

Finally, the commit includes adaptations to the iscsi driver at the driver layer
to verify the correct implementation and functionality of the changes.

With these changes, GFS works fine in the guest. Also, sg-utils(for SCSI block) and
nvme-cli(for NVMe block) work fine too.

Changqi Lu (9):
  block: add persistent reservation in/out api
  block/raw: add persistent reservation in/out driver
  scsi/constant: add persistent reservation in/out protocol constants
  scsi/util: add helper functions for persistent reservation types
    conversion
  hw/scsi: add persistent reservation in/out api for scsi device
  block/nvme: add reservation command protocol constants
  hw/nvme: add helper functions for converting reservation types
  hw/nvme: add reservation protocal command
  block/iscsi: add persistent reservation in/out driver

 block/block-backend.c             | 386 +++++++++++++++++++++++++++++
 block/io.c                        | 161 ++++++++++++
 block/iscsi.c                     | 390 ++++++++++++++++++++++++++++++
 block/raw-format.c                |  55 +++++
 hw/nvme/ctrl.c                    | 304 ++++++++++++++++++++++-
 hw/nvme/nvme.h                    |  44 ++++
 hw/scsi/scsi-disk.c               | 302 +++++++++++++++++++++++
 include/block/block-common.h      |   9 +
 include/block/block-io.h          |  19 ++
 include/block/block_int-common.h  |  31 +++
 include/block/nvme.h              |  67 +++++
 include/scsi/constants.h          |  29 +++
 include/scsi/utils.h              |   5 +
 include/sysemu/block-backend-io.h |  22 ++
 scsi/utils.c                      |  40 +++
 15 files changed, 1863 insertions(+), 1 deletion(-)

-- 
2.20.1


