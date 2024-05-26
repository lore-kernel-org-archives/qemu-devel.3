Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA773C25B7C
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2024 09:58:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBAcM-0006BC-6K; Sun, 26 May 2024 05:56:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amjadsharafi10@gmail.com>)
 id 1sBAcK-0006AY-KP; Sun, 26 May 2024 05:56:40 -0400
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <amjadsharafi10@gmail.com>)
 id 1sBAcI-0003oR-Np; Sun, 26 May 2024 05:56:40 -0400
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-6f12ed79fdfso4304145a34.0; 
 Sun, 26 May 2024 02:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716717396; x=1717322196; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=05ybJTF+SWQIYHPzPFuid4eJMTJbA+2SmgrKckqgFf0=;
 b=Qf1UIHd7/83NfEp/NxR8gUOMEayrWM2+Pbfevs6bkC1T5je+gltdtDRVzHHoTjqGDi
 0VulW9h1yF6gqNsGErAQgaypxZMPiVFrhRKkc76QYOW2bK+60dD6Tl3METxswiRaFrzN
 EFDgw75k21tPH0weGGLkCy9L41ZnSBxRXZ1nJBK50WbNFjBne/kB/Ki9oDvkQqOIsjcm
 IhY8vNbpUj3tzAy6y8ebCrJtbRBafO3VNDAXJG2RJlxTGdZKOL28+rRCG3Oe3B/B1uLO
 KCKwRb1Ay3jfRIFAfcTkyhk9wbE5go51qFk4PS5phovOII3nH8/ZlLYDh7DSctyOLvQd
 NwDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716717396; x=1717322196;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=05ybJTF+SWQIYHPzPFuid4eJMTJbA+2SmgrKckqgFf0=;
 b=tK71vS07ZoYWUkm5Cr9NNrHdE5uJzEVn1vmVbP6Zu7WULQaT2hz3LZcAu/ExhmF9pK
 sZ703b9MqpaSXkEcj5ogLkOFbg/poH1ERSbIoy0ac0yMSkUvEhcTQFK3f7lZF9YS8lh6
 lkF5TLbpdxqtQ/VrXROiEHSmcAqZuPCJo1Cu6mtV+sU6vOtvip8iEN5XND6tsbqzOlod
 4AgN6wN3da4d/5E1Rp3e29Y1Zbb1Zsr5s9xO7HQaMuHS0tjhaAfdKqsjgXqI1iYmHHmC
 Zd+RM7UZASuZITZy90+6UN5/gnm136B29NOSYpK9iR9I9D7NCeszRHJFhi0VJm9tHFDx
 2Qsg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX15Bq7M/ZsuineRVrN9ZN9vXpAAgiZzVIWO6XON8ctJsdMMPknmqQeqL/769ra/7zwF4G/sCvkniYAvgQdcJOSxxurYII=
X-Gm-Message-State: AOJu0YyCwGlsY5erSt44nltZGg7pasG8V334COaEdXJjMWQP2N0q1ECe
 bHvHmrSDtUVGvBCNB+PhcH3oNhPGrIGJjv3kZ5feVHWyBVLB7V9fUdVS1Xva
X-Google-Smtp-Source: AGHT+IHab7XLPZiT5gvtdPigxABLemzag2ghzppZjNcalfcbmI0MlschRoE2UCk8yguJvp3SoMrPPg==
X-Received: by 2002:a9d:5e85:0:b0:6f1:2b6c:a468 with SMTP id
 46e09a7af769-6f8d0937ef7mr6953166a34.0.1716717396030; 
 Sun, 26 May 2024 02:56:36 -0700 (PDT)
Received: from amjad-pc.. ([192.228.203.229]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-682227f1838sm4021368a12.46.2024.05.26.02.56.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 May 2024 02:56:35 -0700 (PDT)
From: Amjad Alsharafi <amjadsharafi10@gmail.com>
To: qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 "open list:vvfat" <qemu-block@nongnu.org>,
 Amjad Alsharafi <amjadsharafi10@gmail.com>
Subject: [PATCH v3 0/6] vvfat: Fix write bugs for large files and add iotests
Date: Sun, 26 May 2024 17:56:00 +0800
Message-ID: <cover.1716717181.git.amjadsharafi10@gmail.com>
X-Mailer: git-send-email 2.45.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32c;
 envelope-from=amjadsharafi10@gmail.com; helo=mail-ot1-x32c.google.com
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

v3:
  Added test for creating new files in vvfat.

v2:
  Added iotests for `vvfat` driver along with a simple `fat16` module to run the tests.

v1:
  https://patchew.org/QEMU/20240327201231.31046-1-amjadsharafi10@gmail.com/
  Fix the issue of writing to the middle of the file in vvfat

Amjad Alsharafi (6):
  vvfat: Fix bug in writing to middle of file
  vvfat: Fix usage of `info.file.offset`
  vvfat: Fix reading files with non-continuous clusters
  iotests: Add `vvfat` tests
  iotests: Filter out `vvfat` fmt from failing tests
  iotests: Add `create_file` test for `vvfat` driver

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
 tests/qemu-iotests/fat16.py                   | 619 ++++++++++++++++++
 tests/qemu-iotests/meson.build                |   3 +-
 .../tests/export-incoming-iothread            |   2 +-
 tests/qemu-iotests/tests/fuse-allow-other     |   1 +
 .../tests/mirror-ready-cancel-error           |   2 +-
 tests/qemu-iotests/tests/regression-vhdx-log  |   1 +
 tests/qemu-iotests/tests/vvfat                | 419 ++++++++++++
 tests/qemu-iotests/tests/vvfat.out            |   5 +
 39 files changed, 1098 insertions(+), 26 deletions(-)
 create mode 100644 tests/qemu-iotests/fat16.py
 create mode 100755 tests/qemu-iotests/tests/vvfat
 create mode 100755 tests/qemu-iotests/tests/vvfat.out

-- 
2.45.0


