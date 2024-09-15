Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 101F3C3ABA1
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Sep 2024 16:10:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sproC-0002Or-Lw; Sun, 15 Sep 2024 12:09:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1spro8-0002Nd-JS
 for qemu-devel@nongnu.org; Sun, 15 Sep 2024 12:09:05 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1spro5-0006Mk-Bv
 for qemu-devel@nongnu.org; Sun, 15 Sep 2024 12:09:04 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-71798661a52so2725979b3a.0
 for <qemu-devel@nongnu.org>; Sun, 15 Sep 2024 09:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1726416538; x=1727021338;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=fvyu9/KPw9ahb1xNyc1WDuxlW1JAo/n8uLCb7GZr1J0=;
 b=0DJVdsrLHglJgOEiSFgmmiOSg38rwbi1auUIeiF9G4wxViF0a/IfoRZYc6p2o0X3td
 A9tmNFLRZB14plFTNEbBsNw5YM+OkoJR8GUH4gdLEKZ5TNvWI3SU2aeYSTBv41Sy91Ut
 MMlevNksozobg1gAx+mRpe1rcJq9L2HC6mq6aeKxgcXt3ePc7KALMVFgsv4JNDXEtWdP
 JsmyKQMcTrqcUzihkKxLqsKc/TDUEpdhVRpO2yhxCU/D/ck1J0puSfKuLFgI45t+K1b8
 xyiOMP58oL/9hXsOiL4p7BusF/tK3fVKKbfJm3Z69Kj6oMeWuC15BBMWlChzsbbmfGzk
 SJeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726416538; x=1727021338;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fvyu9/KPw9ahb1xNyc1WDuxlW1JAo/n8uLCb7GZr1J0=;
 b=FSUq/LRbdKHnk3z42swyyzIaFvp1pRcElyMHq4TRxrrxYVjtHroVzvS0lPkZWTUMbx
 oE6zJ0UkXjPUL2oi45synxQED4ov1KfhtQBgMjlMnmfzLfCr3uqsakENcwEY3RlbX9jp
 d2S6pGePfHVoDj2DcwAlO+QWisqBwAMByrplOsOq/uqh1bkp2dPtknqehmAB+w/S3HIy
 LnrKfFOskowYLwUM1PDxs5POnc9gdGok7B4HhOt9cydfDwQ7E73yfueeiAhz8mzfXctK
 FnqW9sT+aWpE44HjdSxj7UuznueOzjr2GK9GBM2ySbfKNOLm38CmkVkCYFCnye99rm/c
 ZTvg==
X-Gm-Message-State: AOJu0YwNY8hiPNBFoBbpUy9mUAkEIcYrkEctPvw70XIcPAqDEYinl6jB
 aUlO00FtJHhhF3M+1Xk/Ax0DX6DG2f6K7RynBC3pnGxaP36hH+D7Pw6PxWu4dULVP4o6Cb5KSUt
 JFGTRww==
X-Google-Smtp-Source: AGHT+IGVU8rAeAK65JGWI5OWk1xoTJt33e8TR1tL6xnsSoiL9gSQTixPn8w97B+NT2yFfpweSR8ThA==
X-Received: by 2002:a05:6a00:858a:b0:718:db3b:435 with SMTP id
 d2e1a72fcca58-71907edd332mr33620879b3a.8.1726416537134; 
 Sun, 15 Sep 2024 09:08:57 -0700 (PDT)
Received: from localhost.localdomain ([118.114.94.247])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71944bb5967sm2344795b3a.182.2024.09.15.09.08.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Sep 2024 09:08:56 -0700 (PDT)
From: Hyman Huang <yong.huang@smartx.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, yong.huang@smartx.com
Subject: [PATCH v1 0/7] migration: auto-converge refinements for huge VM 
Date: Mon, 16 Sep 2024 00:08:43 +0800
Message-Id: <cover.1726390098.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=yong.huang@smartx.com; helo=mail-pf1-x429.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

This is the first version for auto-converge refinements; refer to the
following link for details about the RFC version:
https://patchew.org/QEMU/cover.1725891841.git.yong.huang@smartx.com/

This series introduces two refinements called "background sync" and
"responsive throttle," respectively.

1. background sync:

   The original auto-converge throttle logic doesn't look like it will
   scale because migration_trigger_throttle() is only called for each
   iteration, so it won't be invoked for a long time if one iteration
   can take a long time.

   The background sync would fix this issue by implementing the background
   dirty bitmap sync and throttle automatically once detect that
   the iteration lasts a long time during the migration.

   The background sync is implemented transparently, and there is no
   new-added interface for upper apps.

2. responsive throttle: 

   The original auto-converge throttle logic determines if the migration
   is convergent by one criteria, and if the iteration fits twice, then
   launch the CPU throttle or increase the throttle percentage. This
   results in that the migration_trigger_throttle() won't be invoked for
   a long time if one iteration can take a long time too.

   The responsive throttle introduce one more criteria to assist detecting
   the convergence of the migration, if either of the two criteria is
   met, migration_trigger_throttle() would be called. This also makes it
   more likely that the CPU throttle will be activated, thereby
   accelerating the migration process.

   The responsive throttle provides the 'cpu-responsive-throttle' option
   to enable this feature. 

We test this two features with the following environment:

a. Test tool:
guestperf

Refer to the following link to see details:
https://github.com/qemu/qemu/tree/master/tests/migration/guestperf

b. Test VM scale:
CPU: 16; Memory: 100GB

c. Average bandwidth between source and destination for migration:
1.59 Gbits/sec

We use stress tool contained in the initrd-stress.img to update
ramsize MB on every CPU in guest, refer to the following link to
see the source code:
https://github.com/qemu/qemu/blob/master/tests/migration/stress.c

The following command is executed to compare our refined QEMU with the
original QEMU:
# python3.6 guestperf.py --binary /path/to/qemu-kvm --cpus 16 \
--mem 100 --max-iters 200 --max-time 1200  --dst-host {dst_ip} \
--kernel /path/to/vmlinuz --initrd /path/to/initrd-stress.img \
--transport tcp --downtime 500 --auto-converge --auto-converge-step 10 \
--verbose --stress-mem {ramsize} 

We set ramsize to 150MB to simulate the light load, 3000MB as moderate
load and 5000MB as heavy load. Test cases were executed three times in
each scenario.  

The following data shows the migration test results with an increase in
stress.

ramsize: 150MB
|------------+-----------+----------+-----------+--------------|
|            | totaltime | downtime | iteration | max throttle |
|            | (ms)      | (ms)     | count     | percent      |
|------------+-----------+----------+-----------+--------------|
| original   | 123685    | 490      | 87        | 99%          |
|            | 116249    | 542      | 45        | 60%          |  
|            | 107772    | 587      | 8         | 0%           | 
|------------+-----------+----------+-----------+--------------|
| background | 113744    | 1654     | 16        | 20%          | 
| sync       | 122623    | 758      | 60        | 80%          | 
|            | 112668    | 547      | 23        | 20%          | 
|------------+-----------+----------+-----------+--------------|
| background | 113660    | 573      | 5         | 0%           | 
| sync +     | 109357    | 576      | 6         | 0%           | 
| responsive | 126792    | 494      | 37        | 99%          | 
| throttle   |           |          |           |              | 
|------------+-----------+----------+-----------+--------------|

ramsize: 3000MB
|------------+-----------+----------+-----------+--------------|
|            | totaltime | downtime | iteration | max throttle |
|            | (ms)      | (ms)     | count     | percent      |
|------------+-----------+----------+-----------+--------------|
| original   | 404398    | 515      | 26        | 99%          |
|            | 392552    | 528      | 25        | 99%          | 
|            | 400113    | 447      | 24        | 99%          | 
|------------+-----------+----------+-----------+--------------|
| background | 239151    | 681      | 25        | 99%          | 
| sync       | 295047    | 587      | 41        | 99%          | 
|            | 289936    | 681      | 34        | 99%          | 
|------------+-----------+----------+-----------+--------------|
| background | 212786    | 487      | 22        | 99%          | 
| sync +     | 225246    | 666      | 23        | 99%          | 
| responsive | 244053    | 572      | 27        | 99%          | 
| throttle   |           |          |           |              | 
|------------+-----------+----------+-----------+--------------|

ramsize: 5000MB
|------------+-----------+----------+-----------+--------------|
|            | totaltime | downtime | iteration | max throttle |
|            | (ms)      | (ms)     | count     | percent      |
|------------+-----------+----------+-----------+--------------|
| original   | 566357    | 644      | 22        | 99%          |
|            | 607471    | 320      | 23        | 99%          | 
|            | 603136    | 417      | 22        | 99%          | 
|------------+-----------+----------+-----------+--------------|
| background | 284605    | 793      | 27        | 99%          | 
| sync       | 272270    | 668      | 28        | 99%          | 
|            | 267543    | 545      | 28        | 99%          | 
|------------+-----------+----------+-----------+--------------|
| background | 226446    | 413      | 22        | 99%          | 
| sync +     | 232082    | 494      | 23        | 99%          | 
| responsive | 269863    | 533      | 23        | 99%          | 
| throttle   |           |          |           |              | 
|------------+-----------+----------+-----------+--------------|

To summarize the data above, any data that implies negative optimization
does not appear, the refinement saves the total time significantly and,
therefore, shortens the duration of the guest performance degradation.

Additionally, we examined the memory performance curves generated from
the test case results above; while no negative optimization is there,
but the performance degradation occurs more quickly. Since it is
inconvenient to display the graphic data, one can independently
verify it.

Please review, any comments and advice are appreciated.

Thanks,

Yong

Hyman Huang (7):
  migration: Introduce structs for background sync
  migration: Refine util functions to support background sync
  qapi/migration: Introduce the iteration-count
  migration: Implment background sync watcher
  migration: Support background dirty bitmap sync and throttle
  qapi/migration: Introduce cpu-responsive-throttle parameter
  migration: Support responsive CPU throttle

 include/exec/ram_addr.h        | 107 ++++++++++++++-
 include/exec/ramblock.h        |  45 +++++++
 migration/migration-hmp-cmds.c |   8 ++
 migration/migration-stats.h    |   4 +
 migration/migration.c          |  13 ++
 migration/options.c            |  20 +++
 migration/options.h            |   1 +
 migration/ram.c                | 236 ++++++++++++++++++++++++++++++---
 migration/ram.h                |   3 +
 migration/trace-events         |   4 +
 qapi/migration.json            |  22 ++-
 tests/qtest/migration-test.c   |  40 ++++++
 12 files changed, 479 insertions(+), 24 deletions(-)

-- 
2.39.1


