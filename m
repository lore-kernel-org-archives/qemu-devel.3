Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 520BDC4345F
	for <qemu-devel@archiver.kernel.org>; Sat,  4 May 2024 08:45:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3B0h-00084F-Uu; Sat, 04 May 2024 04:44:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amjadsharafi10@gmail.com>)
 id 1s3B0g-00083V-2J; Sat, 04 May 2024 04:44:46 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <amjadsharafi10@gmail.com>)
 id 1s3B0b-0001Uf-Aj; Sat, 04 May 2024 04:44:45 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-6f45f1179c3so108819b3a.3; 
 Sat, 04 May 2024 01:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714812278; x=1715417078; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=0/9jpqWzfP6QUw5FjWRXmb86sEKcV2SZni9T89hbtGw=;
 b=CxFg2uAPhqP+by97Als/FUQZyvdsLSycZe9cFLLyMyHtFhjpMoVs46MU0ET/aIsgoe
 H8YpnF/pIgvinQuedI5Al4v3LCUKfvPky/lmpEcibBissb/0WNdFcst/xzcT7ewkmpwM
 K52ArcSSO/QeUaUOJGtwKs3Id0nkicv60QeGq+Dva+gv0NwnyxR1GooO8rzdTVOpY3Dg
 CgeKgNLGj2lNGnNDiLpzvdL5owZxTNvE2CN9sDkShXKFlj5MXEqW661vpHJopatM7U9X
 CstfdVNq0oC+uTXm5jtn7lVWnwTPd/LLoTEjOQioMCa31PnMOPBNVawrMBXuh/Ut9h0L
 4bJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714812278; x=1715417078;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0/9jpqWzfP6QUw5FjWRXmb86sEKcV2SZni9T89hbtGw=;
 b=jFYfYaQVxTqw2WNT9F3DIbEZMkCM7KbkVlmxwIdLd3xSNGmXFloQhrdGaOJfh9Ttt7
 P/k8VkZj0FypOEcq98utm0NPStpVEhDz38V6fWBedH09s+eKeUZkx5I2HlKmS7jmjryu
 RJ+zFR3oWJEZXMNZtEjKofYxMPro5ndakJczrnJdez/NdChMXI54cAq9MpO0SdmNkR5B
 NqVa0+N8Y09ApasWxF5jfsM4noLDoLBVF/UjN9m1vN9qzzmoCtgNltKecpQP6KbTCIJo
 IzISgfLZQ8kaddZ+3Ov906MV0CKvcNeM9aDNJ6vpVQZ46SxvkjhlXzAGhscYYrREaOrv
 MzyQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU57BL/FSuAurnM6XjcdMv4dtd73BYsJL6ETV/OOlvKFBVStUEWYdB+5F7KIkzDugxZyW+RDHBDOyggntC5cgOx4Xo/lAw=
X-Gm-Message-State: AOJu0YxTNkXEAnOW64PN8DWk53AheiSesKPgnP+Ji5Zc2TFsVLdYAupg
 ToTuIpnFvAWzSbxHq8mVHqM7s6KYOfV8bm+vOd5V7sbUvpF3OvptMlA6489h
X-Google-Smtp-Source: AGHT+IGscS4lAVwPVRQUrGpZ+/IAiSKUncDGLIlLgdRN6KxnEU4NiyWCN6S6kLoscqhcs/UJFID/7w==
X-Received: by 2002:a05:6a00:842:b0:6f3:89d3:cb1c with SMTP id
 q2-20020a056a00084200b006f389d3cb1cmr5623544pfk.16.1714812278197; 
 Sat, 04 May 2024 01:44:38 -0700 (PDT)
Received: from amjad-pc.. ([192.228.203.229]) by smtp.gmail.com with ESMTPSA id
 ei32-20020a056a0080e000b006f44e64dfe3sm2310393pfb.177.2024.05.04.01.44.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 May 2024 01:44:37 -0700 (PDT)
From: Amjad Alsharafi <amjadsharafi10@gmail.com>
To: qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 "open list:vvfat" <qemu-block@nongnu.org>,
 Amjad Alsharafi <amjadsharafi10@gmail.com>
Subject: [PATCH v2 0/5] vvfat: Fix write bugs for large files and add iotests
Date: Sat,  4 May 2024 16:44:18 +0800
Message-ID: <cover.1714811679.git.amjadsharafi10@gmail.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=amjadsharafi10@gmail.com; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

v2:
  Added iotests for `vvfat` driver along with a simple `fat16` module to run the tests.

v1:
  https://patchew.org/QEMU/20240327201231.31046-1-amjadsharafi10@gmail.com/
  Fix the issue of writing to the middle of the file in vvfat

Amjad Alsharafi (5):
  vvfat: Fix bug in writing to middle of file
  vvfat: Fix usage of `info.file.offset`
  vvfat: Fix reading files with non-continuous clusters
  iotests: Add `vvfat` tests
  iotests: Filter out `vvfat` fmt from failing tests

 .gitlab-ci.d/buildtest.yml                    |   1 +
 block/vvfat.c                                 |  32 +-
 tests/qemu-iotests/001                        |   1 +
 tests/qemu-iotests/002                        |   1 +
 tests/qemu-iotests/003                        |   1 +
 tests/qemu-iotests/005                        |   1 +
 tests/qemu-iotests/008                        |   1 +
 tests/qemu-iotests/009                        |   1 +
 tests/qemu-iotests/010                        |   1 +
 tests/qemu-iotests/011                        |   1 +
 tests/qemu-iotests/012                        |   1 +
 tests/qemu-iotests/021                        |   1 +
 tests/qemu-iotests/032                        |   1 +
 tests/qemu-iotests/033                        |   1 +
 tests/qemu-iotests/052                        |   1 +
 tests/qemu-iotests/094                        |   1 +
 tests/qemu-iotests/120                        |   2 +-
 tests/qemu-iotests/140                        |   1 +
 tests/qemu-iotests/145                        |   1 +
 tests/qemu-iotests/157                        |   1 +
 tests/qemu-iotests/159                        |   2 +-
 tests/qemu-iotests/170                        |   2 +-
 tests/qemu-iotests/192                        |   1 +
 tests/qemu-iotests/197                        |   2 +-
 tests/qemu-iotests/208                        |   2 +-
 tests/qemu-iotests/215                        |   2 +-
 tests/qemu-iotests/236                        |   2 +-
 tests/qemu-iotests/251                        |   1 +
 tests/qemu-iotests/307                        |   2 +-
 tests/qemu-iotests/308                        |   2 +-
 tests/qemu-iotests/check                      |   2 +-
 tests/qemu-iotests/fat16.py                   | 507 ++++++++++++++++++
 tests/qemu-iotests/meson.build                |   3 +-
 .../tests/export-incoming-iothread            |   2 +-
 tests/qemu-iotests/tests/fuse-allow-other     |   1 +
 .../tests/mirror-ready-cancel-error           |   2 +-
 tests/qemu-iotests/tests/regression-vhdx-log  |   1 +
 tests/qemu-iotests/tests/vvfat                | 400 ++++++++++++++
 tests/qemu-iotests/tests/vvfat.out            |   5 +
 39 files changed, 967 insertions(+), 26 deletions(-)
 create mode 100644 tests/qemu-iotests/fat16.py
 create mode 100755 tests/qemu-iotests/tests/vvfat
 create mode 100755 tests/qemu-iotests/tests/vvfat.out

-- 
2.44.0


