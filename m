Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A45E7D597C7
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2024 02:01:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tB2gr-0001lU-Mt; Tue, 12 Nov 2024 21:01:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <takeshibaconsuzuki@gmail.com>)
 id 1tB0OB-0001AW-1O; Tue, 12 Nov 2024 18:33:39 -0500
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <takeshibaconsuzuki@gmail.com>)
 id 1tB0O9-0008Ra-Bn; Tue, 12 Nov 2024 18:33:38 -0500
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-720cb6ac25aso5739993b3a.3; 
 Tue, 12 Nov 2024 15:33:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731454415; x=1732059215; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=HiSJoaMz/JfeegKxyLZ5KwEj93XsXLThBRkovzz2TyQ=;
 b=fEoY/YJVVxsctgNdV+ePxnWUwR6SptTJ6/D2muvltZcVbmC6tim6ynGuR1AQ3kcYdo
 KUip/DpjqWcXk3ppaQkVHOta5HGm38Uk5b77K6mzvcCdyTRB7YfavcTlcXeeziymt2eV
 B4jwbRg7hZv+fiMFXFl/JS/IyrAAetrRp2uiKfWcuiSyv3C4ju1yemUU9m0ZJA1aGlQc
 HNTAKCfBAPem1iz1ywgim5/f4F32oNaLKo6erS0kUzjwn4QFoM5WWJiIg2ToD0WRq+Mc
 j9CXGXOka5VO36fdC3yjbUe1uuvCsf4MBQEyziA2JX5NCziC+8p5qEe4UE7ccz0qwMH3
 krcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731454415; x=1732059215;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HiSJoaMz/JfeegKxyLZ5KwEj93XsXLThBRkovzz2TyQ=;
 b=MSxDncqjulUemKSVlOQHzSruNH2fCM0RcvAka2qapoBi9JkwpmlBotyjL4dncC6XxL
 dV770EgZCIhTdCq1rYaSQA6MIWIGm5oLxY0GJylUGdKQcuC62TbFOt4Kdlhp4xs5g5Qq
 2DhQy1kdGNCn5t2xUncIY3z1hlhHM9ET9s2vauQFQE8oZwu00uEsEuPu5aMKzfF9+dKV
 fW3TD6vJ4WoAON6tx4cUMAOd98tfCKC04LDaZUElcCtaYSipxX9oXY8bkaKUH95pIBbI
 wKTpDKiByNm1GzuPVjXJIYTr3IFPaOxHeT3dIJiZTzokIIykjoofySdwC7jgCAqKnGmj
 qIDg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVk0aZxVp4stCrIhOcf3Ef1NoA/VtWTwgC/qrlfBzv0NXk99UYh1pH7pRR9VU5am9qjQYTsFDTEIIgf@nongnu.org
X-Gm-Message-State: AOJu0Yz19099J0UNoB1lZDHnO4/QugAk5OAXRS6/PtYdOwfSZOP2DIYp
 lLTZXX72muI6uScCHQcXOCs37FS+/mxckLbY2Z0V8E31nTRbmqeThxIqq1dSJLQ=
X-Google-Smtp-Source: AGHT+IHn06rLx5hmfvwShl8tXsfzQeCgYM6wpfCp6gD1CdJFNQSbbOUzarlQzmIwde+gRk5sKXwFxw==
X-Received: by 2002:a05:6a00:4144:b0:724:46a6:46ef with SMTP id
 d2e1a72fcca58-72446a67062mr7566303b3a.16.1731454414764; 
 Tue, 12 Nov 2024 15:33:34 -0800 (PST)
Received: from localhost.colo.rubrik.com ([104.171.196.13])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-724078bfccfsm11963033b3a.82.2024.11.12.15.33.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Nov 2024 15:33:34 -0800 (PST)
From: Takeshi Suzuki <takeshibaconsuzuki@gmail.com>
To: qemu-devel@nongnu.org
Cc: codyprime@gmail.com, kwolf@redhat.com, hreitz@redhat.com,
 qemu-block@nongnu.org, Takeshi Suzuki <takeshibaconsuzuki@gmail.com>
Subject: [PATCH 0/2] Add RW support for 4k sector size vhdx
Date: Tue, 12 Nov 2024 23:33:02 +0000
Message-Id: <20241112233304.3300-1-takeshibaconsuzuki@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=takeshibaconsuzuki@gmail.com; helo=mail-pf1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 12 Nov 2024 21:01:02 -0500
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

The first patch adds support to read and write VHDX images with 4k logical
sector sizes. This is done by internally converting bdrv sectors of size 512 to
logical sectors. VHDX image creation with 4k logical sector size is NOT
implemented.

The second patch adds an iotest which reads and writes to a VHDX image with 4k
logical sector size.

Takeshi Suzuki (2):
  Add RW support for 4k sector size vhdx
  Add iotest for 4k sector size vhdx

 block/vhdx.c                                 |  76 +++++++++++++++++--
 tests/qemu-iotests/315                       |  65 ++++++++++++++++
 tests/qemu-iotests/315.out                   |  20 +++++
 tests/qemu-iotests/sample_images/4k.vhdx.bz2 | Bin 0 -> 37834 bytes
 4 files changed, 155 insertions(+), 6 deletions(-)
 create mode 100644 tests/qemu-iotests/315
 create mode 100644 tests/qemu-iotests/315.out
 create mode 100644 tests/qemu-iotests/sample_images/4k.vhdx.bz2

-- 
2.34.1


