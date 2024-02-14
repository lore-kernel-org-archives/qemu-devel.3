Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EAF3C48BEB
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Feb 2024 22:24:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raNfP-0002y6-C0; Wed, 14 Feb 2024 17:23:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <minwoo.im.dev@gmail.com>)
 id 1raNfM-0002xV-TP; Wed, 14 Feb 2024 17:23:44 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <minwoo.im.dev@gmail.com>)
 id 1raNfL-0004Ke-I0; Wed, 14 Feb 2024 17:23:44 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1d953fa3286so1960325ad.2; 
 Wed, 14 Feb 2024 14:23:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707949421; x=1708554221; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=x6xxcsiSUNesMUsaVvEufcQWtndSLe/rjH+aBMNMcI8=;
 b=k3EY2sQDPbDZzwwg2OA81yrDjMPgLCHFjR2XjBIzdpGNgTb3tUDAUVNET7ehW1FZHt
 Oy6cjtcoMMH8/o5XcTYF/kLUwUq7RY2nRVZxCBqaNIU5JJYcFR8rgNA2l1ANCCip3WyL
 QsxIOt59tgE0FOD1U/VpNXYj5T5q4CwmKOYgaIEC28u71lN8hJSwLRGGy5sGtQBkWMMf
 oSR6XojGAMZQ9sEL04g4TKldvR+uThFpDSu4Lu2ihHQiV4ugUdaEKXmUeBabTcYPeNfU
 kmivPeQemsSVL9JYDQI0UmWGBTPdcCy7bZS7iuh4nehujutAwG4b4uKUqQ5EjSj3GuoQ
 sq2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707949421; x=1708554221;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=x6xxcsiSUNesMUsaVvEufcQWtndSLe/rjH+aBMNMcI8=;
 b=RhaZuiAfsD7iInZwZVKzf0bg9CPT4s0XUstTI8MBncwGvBOhnkcX1g+xJZeopJLj60
 Hetwclr8rnTZl1Us3KGRG4yZI9rHXnX8iv3I+f2H1AwlSCk9smBgAZmkzA+8OW4oO98H
 leFR8iEyoAQz9u7sjYOA0jfiacZon7MFzY6JqB8vIqenx4PP2coXSOTle1QOV0ZW+TPT
 hBTcQO6otPyFOuJGFDmDLuRJ2/2+DPC3h8JB994qKqGoDtjBRlgqDSCE/4Tb/4Ts5jN3
 tIlQZ1geRpNQKlSE1IHdACtmfo3tF5ZcwJ2AuwRR4HbX1ArQIy9jR1Xf40RRGSQDuRMd
 +AXg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUz1FPLUzU4uPheTVcOGNh6StlB7tWx1a4J9g0qxtKukv8bOYpU30omPUmwvLEHNHQ64CFxatVQmHVFBWmmXWcMjowEag4=
X-Gm-Message-State: AOJu0Yzv3MFq1tduFTLU12/Hi2kCwS88mCDiq+v7Ycqxx1b6S/oZ71Pl
 G8RLvJoFEG9X01ezFx/Sia796HLYkco9Le9sjVR3EKFvWIZoJfAe
X-Google-Smtp-Source: AGHT+IFyhOejmZey7dB6mmHsEek8q2nZ7C3ZrcwTnyvfm552YXfGjUUgoLTxgAgWcec3mMfIVrOlfA==
X-Received: by 2002:a17:903:48a:b0:1da:2216:f1f8 with SMTP id
 jj10-20020a170903048a00b001da2216f1f8mr3408201plb.39.1707949421501; 
 Wed, 14 Feb 2024 14:23:41 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXrAC/mLkWyLQREPDYx4QjJTw0pJdJKtbxOcs/0ucToXoDNWq9UvLCYK5U6gO0MnyEcFd5u0PMZxGosyVdeMedVuVV88ItUqRkxFz9761mtLE4emqQWSy2xnpbC89+q2jEL1hzVSrRLepRFSiR9CyyV36EPicR1b10TxD3M2wxLjmqz01TjjQTn
Received: from localhost ([116.121.76.56]) by smtp.gmail.com with ESMTPSA id
 lo12-20020a170903434c00b001d901c2087esm4233626plb.302.2024.02.14.14.23.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Feb 2024 14:23:41 -0800 (PST)
From: Minwoo Im <minwoo.im.dev@gmail.com>
To: Keith Busch <kbusch@kernel.org>,
	Klaus Jensen <its@irrelevant.dk>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Minwoo Im <minwoo.im@samsung.com>, Minwoo Im <minwoo.im.dev@gmail.com>
Subject: [PATCH 0/3] hw/nvme: FDP and SR-IOV enhancements
Date: Thu, 15 Feb 2024 07:23:34 +0900
Message-Id: <20240214222337.5699-1-minwoo.im.dev@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=minwoo.im.dev@gmail.com; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Hello,

This patchset includes patches for adding Identify data for the
recently added Endurance Group (endgrpid=1) used in FDP, and patches
for increasing the maximum number of SR-IOV VF Resources to support
more resources to enable testing as recent SSDs.

Thanks,

Minwoo Im (3):
  hw/nvme: add Identify Endurance Group List
  hw/nvme: Support SR-IOV VFs more than 127
  hw/nvme: Expand VI/VQ resource to uint32

 hw/nvme/ctrl.c       | 36 +++++++++++++++++++++++++++++-------
 hw/nvme/nvme.h       |  6 +++---
 include/block/nvme.h |  1 +
 3 files changed, 33 insertions(+), 10 deletions(-)

-- 
2.34.1


