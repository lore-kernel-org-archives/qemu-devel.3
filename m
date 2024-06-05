Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C63C2C41513
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 01:00:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEf0e-0008GY-GY; Tue, 04 Jun 2024 21:00:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amjadsharafi10@gmail.com>)
 id 1sEf0b-0008FK-39; Tue, 04 Jun 2024 21:00:10 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <amjadsharafi10@gmail.com>)
 id 1sEf0Y-0004Rk-DS; Tue, 04 Jun 2024 21:00:08 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-7024d571d8eso3860502b3a.0; 
 Tue, 04 Jun 2024 18:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717549203; x=1718154003; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=0E1X89onMnXj7jR/KXm35viaRfOjLWkvHpW6iFXu/Es=;
 b=Y7LIsxoZSob2vcgZlWgbIWeJ/ccP8HF54TFR3V4XseZvQzESL8tisFqH+1o1y5pX5Q
 V0R4W2AoCRD7C8lQFrGP7YMGzryyoJorKZrSQgQNhqSDfBiXcUxNpH3roVCjRedouqNP
 ZpPeXhKx+zlG8vUyOnFtn1Z3a9FThtqUQBSzL71XDFiDEAiTt0+cih3Dh6sh5wJN71nB
 7jRgUruK2BH0WR46eqDwbESIOnsCao5zwsDUkc6DlERlCxQd76u3oaPXbXWM4MoU9jP9
 GcNPEcI00zdsJ56mEx3liCYZLNkrGucYaVPYOKOHdlALL1SpcyDwdaVtB5TVMVu/Hyog
 JvcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717549203; x=1718154003;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0E1X89onMnXj7jR/KXm35viaRfOjLWkvHpW6iFXu/Es=;
 b=ZbyUn1Q1n9uYqjZLEwwjRpFgDdLNVe3fDG81wqLnHOkwlSB6QU4+xZT4JizBXVf0Xj
 Eq45ypfM28VLJK/eZ7OSE3zsc8WIKQpGF0stsKNYqRKx6UpwRQYF5JbfTdKNjWNaIv/5
 CA6D2DFL5GYbWP6+qs624z/BWaKK/+mJ4MHHu7CbEo7r2PszeQXHfUX8Y9psDIV+D/sn
 jkOIOdzi1JHWEo6PAddZFOeTPp9a47JBAH5OPjyRQPmpJMi2titfGJpwyIZIOrFgHT0M
 C1ZhGSd29tmaqyBAhike7DMJ6f/W/yOiW7xhxQcIXDgDQq/9/WbhBkbJNhXF1QtuUTKY
 odsw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXigiY56SlWtXCdU3B4ueoOFO7aSfXlu6Zimu2n2iCnQFRjL3a1k+1GT82CGu3Vy9fX2Xo3+CUog8DaWtv0MGDRR4e+3hc=
X-Gm-Message-State: AOJu0YziZMuyb61OBigAGr1kavtvQ3t8tDJuPc+jGnOA82qWF1bAarpe
 g1s618gOgc5fnWktaOmC6w7dxd3b3h516GqXk5Y9l9BoqFmNuMpwpMAnt4SkZzo=
X-Google-Smtp-Source: AGHT+IFo+HCzPenA6ZsPGfJZEIsIF7+sMXXc2n6yunKt8bI6fd01W7WKe8+rRkyX1hh/lfWPq81Dyw==
X-Received: by 2002:a05:6a21:318b:b0:1b2:91a0:6255 with SMTP id
 adf61e73a8af0-1b2b71b5cdbmr1669388637.62.1717549203047; 
 Tue, 04 Jun 2024 18:00:03 -0700 (PDT)
Received: from amjad-pc.. ([192.228.203.229]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-703ee633e04sm3731b3a.19.2024.06.04.18.00.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Jun 2024 18:00:02 -0700 (PDT)
From: Amjad Alsharafi <amjadsharafi10@gmail.com>
To: qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 "open list:vvfat" <qemu-block@nongnu.org>,
 Amjad Alsharafi <amjadsharafi10@gmail.com>
Subject: [PATCH v4 0/4] vvfat: Fix write bugs for large files and add iotests
Date: Wed,  5 Jun 2024 08:58:36 +0800
Message-ID: <cover.1717549035.git.amjadsharafi10@gmail.com>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=amjadsharafi10@gmail.com; helo=mail-pf1-x434.google.com
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

Amjad Alsharafi (4):
  vvfat: Fix bug in writing to middle of file
  vvfat: Fix usage of `info.file.offset`
  vvfat: Fix reading files with non-continuous clusters
  iotests: Add `vvfat` tests

 block/vvfat.c                      |  38 +-
 tests/qemu-iotests/check           |   2 +-
 tests/qemu-iotests/fat16.py        | 635 +++++++++++++++++++++++++++++
 tests/qemu-iotests/testenv.py      |   2 +-
 tests/qemu-iotests/tests/vvfat     | 440 ++++++++++++++++++++
 tests/qemu-iotests/tests/vvfat.out |   5 +
 6 files changed, 1107 insertions(+), 15 deletions(-)
 create mode 100644 tests/qemu-iotests/fat16.py
 create mode 100755 tests/qemu-iotests/tests/vvfat
 create mode 100755 tests/qemu-iotests/tests/vvfat.out

-- 
2.45.1


