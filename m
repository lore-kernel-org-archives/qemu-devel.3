Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DD69ECE588
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 20:13:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snkjt-0008LQ-EP; Mon, 09 Sep 2024 16:11:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1snkjr-0008Kt-Lg
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 16:11:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1snkjp-0004yp-UW
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 16:11:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725912712;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=dyIZbyaaDW6HJxSc1eD7cm8S/fscDqlC4iLVh1JeHfw=;
 b=Z24kqFK4opEkIgGeNOrhTTYvCE68FATB4J+OXfiKAsw61/LkHpLqXdlKvFWXjnHa8G8PSk
 hRQ1NnucBkgoiz4ue4e8LMBoI+NEfPzSqepgGveCFlXpR9DbbWMprGB0d7OnsmXxKTQr6q
 yB4tqeMrPgqUrcZHkw6jMN7cTutHGQ0=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-509-8L0mNsC1NxOI5CP1uAQflA-1; Mon, 09 Sep 2024 16:11:51 -0400
X-MC-Unique: 8L0mNsC1NxOI5CP1uAQflA-1
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-4582493b3f7so33477751cf.0
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 13:11:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725912710; x=1726517510;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dyIZbyaaDW6HJxSc1eD7cm8S/fscDqlC4iLVh1JeHfw=;
 b=L8Vx6TAhw8P7W+LWS1cIondVNqYuJwo5Dlaifz/va0O62j0o3M9JW+3xiySvJ9a39H
 GN3JksD4hOo/H8t67knkLoPd36sJVOeubhl206usLyAxbaVfpNEw1uXCQU8Ig1fBF0F1
 NB13IAprKaBT3JRRxpG7K8REpAsS3IFaKXXui1TKd/g8kS2K2JUXN3jKE7GdDhIzJITS
 gtoPYA68ukDNyGWKtcFhqcO3JT769xGs/F4zKRp7E5qw4FCX535vlzTzAoIOWOMJg1kj
 l45O6vg/V8L9B6c09bgRvpgw3guZRl5bywzEc8HMZFQEcZLiEXw4N1LfNMxTRIQUpQNY
 ZhuQ==
X-Gm-Message-State: AOJu0YyCVDS0m6tb3mmZZBxzGEIyZkz6uXX472LgceV+EQaGhMimi/mz
 1mcjcKxDVieZ06wZ2DgGoN+oMRCAx+DjUlAS/fm54e1r4fB7SdpOcG7iwxIDRtUKl47Zz3N1WJW
 MGTmkT1YnUgvYQC+vn2hufZERH+SS4P+j02uGLV1fCsI/eU0m4S1OUAr/xyqzAdiz3WR7ENuITW
 XaQW2vBGRTbWzauBWvzOduFIPVaQPyiAsJOg==
X-Received: by 2002:ac8:5a0e:0:b0:456:8ee8:f5ed with SMTP id
 d75a77b69052e-4580c78def9mr157850621cf.48.1725912709977; 
 Mon, 09 Sep 2024 13:11:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEkmCTKfHYe5vw9BlAykJFcDh+mJorwEpGA6vMr3kxOV296uMB2eINE6ub/hwIa233o8pW9MA==
X-Received: by 2002:ac8:5a0e:0:b0:456:8ee8:f5ed with SMTP id
 d75a77b69052e-4580c78def9mr157850191cf.48.1725912709545; 
 Mon, 09 Sep 2024 13:11:49 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45822f93978sm22838561cf.83.2024.09.09.13.11.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Sep 2024 13:11:49 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: [PULL 0/9] Migration 20240909 patches
Date: Mon,  9 Sep 2024 16:11:38 -0400
Message-ID: <20240909201147.3761639-1-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The following changes since commit f2aee60305a1e40374b2fc1093e4d04404e780ee:

  Merge tag 'pull-request-2024-09-08' of https://gitlab.com/huth/qemu into staging (2024-09-09 10:47:24 +0100)

are available in the Git repository at:

  https://gitlab.com/peterx/qemu.git tags/migration-20240909-pull-request

for you to fetch changes up to 89bccecdda253c9a1a38921cf9266a4f9655c88c:

  system: improve migration debug (2024-09-09 10:55:40 -0400)

----------------------------------------------------------------
Migration pull request for 9.2

- Mattias's patch to support concurrent bounce buffers for PCI devices
- David's memory leak fix in dirty_memory_extend()
- Fabiano's CI fix to disable vmstate-static-checker test in compat tests
- Denis's patch that adds one more trace point for cpu throttle changes
- Yichen's multifd qatzip compressor support

----------------------------------------------------------------

Bryan Zhang (4):
  meson: Introduce 'qatzip' feature to the build system
  migration: Add migration parameters for QATzip
  migration: Introduce 'qatzip' compression method
  tests/migration: Add integration test for 'qatzip' compression method

David Hildenbrand (1):
  softmmu/physmem: fix memory leak in dirty_memory_extend()

Denis V. Lunev (1):
  system: improve migration debug

Fabiano Rosas (1):
  ci: migration: Don't run python tests in the compat job

Mattias Nissler (1):
  softmmu: Support concurrent bounce buffers

Yuan Liu (1):
  docs/migration: add qatzip compression feature

 docs/devel/migration/features.rst           |   1 +
 docs/devel/migration/qatzip-compression.rst | 165 ++++++++
 meson.build                                 |  10 +
 qapi/migration.json                         |  21 ++
 include/exec/memory.h                       |  14 +-
 include/exec/ramlist.h                      |   1 +
 include/hw/pci/pci_device.h                 |   3 +
 migration/multifd.h                         |   5 +-
 migration/options.h                         |   1 +
 hw/core/qdev-properties-system.c            |   2 +-
 hw/pci/pci.c                                |   8 +
 migration/migration-hmp-cmds.c              |   4 +
 migration/multifd-qatzip.c                  | 394 ++++++++++++++++++++
 migration/options.c                         |  34 ++
 system/cpu-throttle.c                       |   3 +
 system/memory.c                             |   5 +-
 system/physmem.c                            | 117 +++---
 tests/qtest/migration-test.c                |  27 ++
 .gitlab-ci.d/buildtest.yml                  |   8 +
 meson_options.txt                           |   2 +
 migration/meson.build                       |   1 +
 scripts/meson-buildoptions.sh               |   3 +
 system/trace-events                         |   3 +
 23 files changed, 767 insertions(+), 65 deletions(-)
 create mode 100644 docs/devel/migration/qatzip-compression.rst
 create mode 100644 migration/multifd-qatzip.c

-- 
2.45.0


