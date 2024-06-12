Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3B79C27C77
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 12:44:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHNLG-0000sH-4S; Wed, 12 Jun 2024 08:44:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amjadsharafi10@gmail.com>)
 id 1sHNL8-0000ob-7T; Wed, 12 Jun 2024 08:44:35 -0400
Received: from mail-oi1-x22b.google.com ([2607:f8b0:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <amjadsharafi10@gmail.com>)
 id 1sHNL5-0004xQ-Oa; Wed, 12 Jun 2024 08:44:33 -0400
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-3d23db75f5cso416451b6e.0; 
 Wed, 12 Jun 2024 05:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718196269; x=1718801069; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=yHr9lNUj2ZTKyx95ZV/zYEXckRvIr3hVApTDr938oqw=;
 b=C/38VVfasKrbzf2OS3lcLTPtkLsuOqJi3h85QeRFg773A2Sh1E13oypDvpf6Tom7q5
 gIHGVyv0l0sVbNxeNi1IG0sbt3CiLiMeaBZsOZoMUbDUrpvbTJL18ycm7Tid02VPsI2E
 XD2LyhxFyjkwDbCFxaOW+ZkUsyYiKauaokVbpCZOYIA/nnh6Kj4K9/A3jKjMhp7bGHoV
 2lIm4vAhb4wk7MsNVdAEz0Il6wG+Mmtpm6B0BzPcWyfQ+Q2L6HbJDZPnEzaUqjNWk/sX
 Xept5b2AuxClfnLOpHartTSaL2RJpMGNfY0a4OzEbedTq1epYl57zngBHaiNsyx9lzSy
 yIlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718196269; x=1718801069;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yHr9lNUj2ZTKyx95ZV/zYEXckRvIr3hVApTDr938oqw=;
 b=wqiWFyUZq3LYbIHnZ8pQTPVHsCoasRf5TUMkJNwVh5LflbRGGijJG9YYY1XXlrd7C+
 5mVm67VhIU8qqZhaLQYVstNOHtwImJRstEl4pOuYxnrAeGLyh9dPQdm7yfJInM8mu/5M
 2ViRkWCrUEgq3yQ4WxH+yoqnCNl2OZNmnD/dbiEaqXDdOnHx99pQOVElksogzeyD1sQf
 bVo6wm2YjXFRoWf+kT5Q2JUtzeN2Ap/SeHedQ5QIx6wWN9BRUs4/VlrjmHzlpdRx5wCs
 TB+quPcOCHYwpjEReh+ingJwTLgalQFqLJL0pi7Q4DUOqkBZp13Hp8httacss4LYAFoc
 ZQ1w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUDRklMfH5sqQEjuOWFsKEO5id9j8lybFksQ4WGiZwf2N4U4EbTp5j+GiShI4MsXtnGoImqzShB5i8empcWNRXS0PCTOQc=
X-Gm-Message-State: AOJu0YxlmoB9sLra8uzKO5Y6RoJa1Df6+5+sV3q8uT3HPtImEnwqA5N5
 6CahoAuVatEl/jSB00TOwE23vgyi2TP+WaZ0BQjQvgGQh+19DqdILGshLpRggS0=
X-Google-Smtp-Source: AGHT+IH91EVZT4hDMJsRmKkJh7MOV5pa45va9oM9Dkf3PgwhKqeDXqCP1eAQH6ZIj3wicajYrtBvVw==
X-Received: by 2002:a05:6808:3a09:b0:3d2:278d:8ae7 with SMTP id
 5614622812f47-3d23dfde5abmr2150768b6e.19.1718196268648; 
 Wed, 12 Jun 2024 05:44:28 -0700 (PDT)
Received: from amjad-pc.. ([202.185.212.207]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7042dff35fdsm6928961b3a.131.2024.06.12.05.44.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Jun 2024 05:44:28 -0700 (PDT)
From: Amjad Alsharafi <amjadsharafi10@gmail.com>
To: qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 "open list:vvfat" <qemu-block@nongnu.org>,
 Amjad Alsharafi <amjadsharafi10@gmail.com>
Subject: [PATCH v5 0/5] vvfat: Fix write bugs for large files and add iotests
Date: Wed, 12 Jun 2024 20:43:21 +0800
Message-ID: <cover.1718195956.git.amjadsharafi10@gmail.com>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22b;
 envelope-from=amjadsharafi10@gmail.com; helo=mail-oi1-x22b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

These patches fix some bugs found when modifying files in vvfat.
First, there was a bug when writing to the cluster 2 or above of a file, it
will copy the cluster before it instead, so, when writing to cluster=2, the
content of cluster=1 will be copied into disk instead in its place.

Another issue was modifying the clusters of a file and adding new
clusters, this showed 2 issues:
- If the new cluster is not immediately after the last cluster, it will
cause issues when reading from this file in the future.
- Generally, the usage of info.file.offset was incorrect, and the
system would crash on abort() when the file is modified and a new
cluster was added.

Also, added some iotests for vvfat, covering the this fix and also
general behavior such as reading, writing, and creating files on the filesystem.
Including tests for reading/writing the first cluster which
would pass even before this patch.

v5:
  - Fix a bug in reading non-contiguous clusters in vvfat for more than 2 mappings.
  - Added a test for adding more clusters where they are non-contiguous and
    result in 3 mappings (for the above fix).
  - Split PATCH 2/4 into 2 patches and a better fix for the `abort` issue (now in PATCH 3/5).
  - Other fixes and improvements in `fat16.py` module used for iotests.

v4:
  Applied some suggestions from Kevin Wolf <kwolf@redhat.com>:
  - Fixed code formatting by following the coding style in `scripts/checkpatch.pl`
  - Reduced changes related to `iotests` by setting `vvfat` format as non-generic.
  - Added another test to cover the fix done in `PATCH 2/4` and `PATCH 3/4` for 
    handling reading/writing files with non-continuous clusters.

v3:
  Added test for creating new files in vvfat.

v2:
  Added iotests for `vvfat` driver along with a simple `fat16` module to run the tests.

v1:
  https://patchew.org/QEMU/20240327201231.31046-1-amjadsharafi10@gmail.com/
  Fix the issue of writing to the middle of the file in vvfat

Amjad Alsharafi (5):
  vvfat: Fix bug in writing to middle of file
  vvfat: Fix usage of `info.file.offset`
  vvfat: Fix wrong checks for cluster mappings invariant
  vvfat: Fix reading files with non-continuous clusters
  iotests: Add `vvfat` tests

 block/vvfat.c                      |  47 +-
 tests/qemu-iotests/check           |   2 +-
 tests/qemu-iotests/fat16.py        | 673 +++++++++++++++++++++++++++++
 tests/qemu-iotests/testenv.py      |   2 +-
 tests/qemu-iotests/tests/vvfat     | 457 ++++++++++++++++++++
 tests/qemu-iotests/tests/vvfat.out |   5 +
 6 files changed, 1164 insertions(+), 22 deletions(-)
 create mode 100644 tests/qemu-iotests/fat16.py
 create mode 100755 tests/qemu-iotests/tests/vvfat
 create mode 100755 tests/qemu-iotests/tests/vvfat.out

-- 
2.45.1


