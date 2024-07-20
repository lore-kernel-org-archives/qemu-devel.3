Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2166AC3DA63
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jul 2024 10:15:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sV768-0001Jf-2s; Sat, 20 Jul 2024 06:13:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amjadsharafi10@gmail.com>)
 id 1sV766-0001H5-GO; Sat, 20 Jul 2024 06:13:50 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <amjadsharafi10@gmail.com>)
 id 1sV764-0007Od-68; Sat, 20 Jul 2024 06:13:50 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-79b530ba612so1631380a12.2; 
 Sat, 20 Jul 2024 03:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721470425; x=1722075225; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=J5iJBlb/P6uggEoKi/6RQxxtVuDX/jn1m8urv+H4HeE=;
 b=OW2/7QTUUf/SdPcWu3zl+1rKgyG9ynjuugKvmlwfpatYeoFiy2jRJWbqBFJfN1xpbP
 nedeCsrU77GY8hiaOgtferEULk8cyDIJnU1cw0HwcbcKrhKeMgq6hXQhW3+/lvHBJhRI
 gd37XUFKDozocpc2f7y0Si2HGYdulyocDcFdjGoa3nG6ZO7s/Fc8L4eKYXGMLhBX3JTM
 bDatWd/NoSUfj2rwIm68htcEwNqlUTlhuXccyywhBlF0vFvZBJFWMVhfsJqTh5lsRQFT
 codX++Ex4XeAAyBLI3Oy77TqArQaqU9S/AtK1WxRmZItSA2E+v/6DIleH1rNMpliCxhF
 hOuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721470425; x=1722075225;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=J5iJBlb/P6uggEoKi/6RQxxtVuDX/jn1m8urv+H4HeE=;
 b=vhbRI9dHP2K3iKTAO4Lhz2Cz9VmZdN8mrNzEIRr8LvvFFCKpo7e2yJvCCCE5X11U/o
 e4RxAeYvfbPyQVWYXOjyoudc4iPpFM0mquVzBa/m81+COnAdJDwbQ1JWtJiu7ZK8urEq
 E0mdG9SsOiuyasIE42bGC9XOT0fAl4xusR5rkvkDCQzUb5L7MNGsjxyRLJLMUSC8OEta
 acTMbc4pGAffrUYOvaSbukEaUoObbTb3lHjbWkaGeUzio3pZ1TNecm9gi/O1q7eVlQ03
 xjPXonjShHjvQU9SA1bYDT7M8YD+UgV5KZXi0yRvtrhQG+bdB0XjiPQl8W+hb+22RXHV
 rkCg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWoTi0SfosveaWJgLrgSV646jINDh7dQGa+V7wUkVC/iGR482acIqj640+m0EWDizb1Z9k3qT1cr93Wv87c+pdTQiFf9OA=
X-Gm-Message-State: AOJu0YxwDs9Xa/Cx7FQkmkThI+NinFFsNl5MRq+3vxHeKjPi6KFomiDO
 y1TDJQQzueRHKjZKYAROXIb3irGe+cNWQWkmGB4HK2ZfhFvfz3Q6IAZmfqRS7IL0wQ==
X-Google-Smtp-Source: AGHT+IE19KDisE3XTea3R9wLOwcVpMVdQt40rk2VytUQrxoLnfOq9v1t/weKpkFoZ5VTM2q5SqUiHg==
X-Received: by 2002:a05:6a21:6da2:b0:1c0:e77b:d37 with SMTP id
 adf61e73a8af0-1c42285df07mr2943669637.9.1721470423951; 
 Sat, 20 Jul 2024 03:13:43 -0700 (PDT)
Received: from amjad-pc.. ([202.185.212.207]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2cb76a5fc6csm4411208a91.0.2024.07.20.03.13.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Jul 2024 03:13:43 -0700 (PDT)
From: Amjad Alsharafi <amjadsharafi10@gmail.com>
To: qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 "open list:vvfat" <qemu-block@nongnu.org>,
 Amjad Alsharafi <amjadsharafi10@gmail.com>
Subject: [PATCH v6 0/5] vvfat: Fix write bugs for large files and add iotests
Date: Sat, 20 Jul 2024 18:13:29 +0800
Message-ID: <cover.1721470238.git.amjadsharafi10@gmail.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=amjadsharafi10@gmail.com; helo=mail-pg1-x531.google.com
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

v6:
  - small fixes and code improvements when switching between active vfat mappings
  - small fixes and code improvements for the fa16.py driver used for iotests

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

 block/vvfat.c                      |  34 +-
 tests/qemu-iotests/check           |   2 +-
 tests/qemu-iotests/fat16.py        | 675 +++++++++++++++++++++++++++++
 tests/qemu-iotests/testenv.py      |   2 +-
 tests/qemu-iotests/tests/vvfat     | 458 +++++++++++++++++++
 tests/qemu-iotests/tests/vvfat.out |   5 +
 6 files changed, 1157 insertions(+), 19 deletions(-)
 create mode 100644 tests/qemu-iotests/fat16.py
 create mode 100755 tests/qemu-iotests/tests/vvfat
 create mode 100755 tests/qemu-iotests/tests/vvfat.out

-- 
2.45.2


