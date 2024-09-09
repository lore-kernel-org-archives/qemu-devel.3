Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F0FDECE57A
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 14:26:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snfL5-0000QH-3y; Mon, 09 Sep 2024 10:25:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1snfL3-0000Ie-7i
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 10:25:57 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1snfL0-0004S5-F2
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 10:25:56 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-7d4fb2cd1ecso119060a12.0
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 07:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1725891951; x=1726496751;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=jTNqf7YIcbT3aR3MdvtgQS4AHyFeYqCdyXrPgZtmqy4=;
 b=AeMSEmn8Ul0GFMvCYe1HzeGXJdQPqtKvRe9x71EWtDcQLGt5XLBVvDalnfUwOU8vNW
 cM4IP4nGTRAiCzsdPCuKYMP3saE0tj+EuOx9HCJFMT+HhrJ8KsLmrLifI3bwJlwCslDN
 HAjyru0ICpxliFPjNYxjlPz/i6UHM7B+I8lEJiPv2NMc68sOWlAha4KHXdjvldI5k9ni
 TTkchUMD/i4kM2AcEdf8X5UsEGsuBCRyUJkAEhwGKKR5+qfUfpH0wKtQOKks6Cmtf5wU
 9Wey9h/yRu4Z1yQvqRRTMsseCTo8n9EQrfRM6J+jV0F5DwFdcW01FiNp7qRQb0fYd7cD
 VMjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725891951; x=1726496751;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jTNqf7YIcbT3aR3MdvtgQS4AHyFeYqCdyXrPgZtmqy4=;
 b=ehvIhYW7Jfq+vTInzg614w6i1+k4MEhyaAiLPQG16noKFEQ4aTfGTkpiTVp8/eQ5Hs
 tsFT1TCW/cIJ+PJd5xCXQUZ7yYkLaKqUt2CXLSjL+zI4n+i54eJkNarTvnAWdzg0UORx
 m9T3XbQ0CW7q1Rek57RUIMXYeT6v77fH7c5+aZbFIXgFeiuDdFZxDh3aWeBgtoIK1115
 8ZI/KPHNdygg7aSAugiYt6X4fIt+hBsuuBXsD+9FCFKMpKIfjKA+RlldUBLCtI9wOC9H
 +8eg8+R0P/jtsvL8A81rtV1KUO/g5FpP1+rWXKxvXSYA++e0lqB1kYWX5FeZcADzueFd
 r8TA==
X-Gm-Message-State: AOJu0YxD9lAmzkCxzucrkEO4+loyGH+co3QTZAuVktXwhZAo8G4yv0n6
 CYC6ZonJhjodgWNA8jFJSRDIGfyscdQdcP9d7lOdanFVxYtwUY7advvNgc1CDV9bZpec6bzJPFr
 zEPi/ig==
X-Google-Smtp-Source: AGHT+IFPjBPA4JqCYaEgGoNM/V+BAD+hoMRJA+i8O/Zdvk8Ww9qOk7HDqkIBU3fhG8rCQL0xx8tidQ==
X-Received: by 2002:a05:6a21:648b:b0:1ca:cdba:2121 with SMTP id
 adf61e73a8af0-1cf2a031a6emr6584035637.14.1725891950548; 
 Mon, 09 Sep 2024 07:25:50 -0700 (PDT)
Received: from localhost.localdomain ([118.114.94.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-718e58b2a88sm3561164b3a.46.2024.09.09.07.25.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Sep 2024 07:25:50 -0700 (PDT)
From: Hyman Huang <yong.huang@smartx.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, yong.huang@smartx.com
Subject: [PATCH RESEND RFC 00/10] migration: auto-converge refinements for
 huge VM
Date: Mon,  9 Sep 2024 22:25:33 +0800
Message-Id: <cover.1725891841.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=yong.huang@smartx.com; helo=mail-pg1-x535.google.com
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

Currently, a huge VM with high memory overload may take a long time
to increase its maximum throttle percentage. The root cause is that
the current auto-converge throttle logic doesn't look like it will
scale because migration_trigger_throttle() is only called for each
iteration, so it won't be invoked for a long time if one iteration
can take a long time.

This patchset provides two refinements aiming at the above case.

1: The periodic CPU throttle. As Peter points out, "throttle only
   for each sync, sync for each iteration" may make sense in the
   old days, but perhaps not anymore. So we introduce perioidic
   CPU throttle implementation for migration, which is a trade-off
   between synchronization overhead and CPU throttle impact.

2: The responsive CPU throttle. We present new criteria called
   "dirty ratio" to help improve the detection accuracy and hence
   accelerate the throttle's invocation.

The RFC version of the refinement may be a rudimentary implementation,
I would appreciate hearing more feedback.

Yong, thanks.

Hyman Huang (10):
  migration: Introduce structs for periodic CPU throttle
  migration: Refine util functions to support periodic CPU throttle
  qapi/migration: Introduce periodic CPU throttling parameters
  qapi/migration: Introduce the iteration-count
  migration: Introduce util functions for periodic CPU throttle
  migration: Support periodic CPU throttle
  tests/migration-tests: Add test case for periodic throttle
  migration: Introduce cpu-responsive-throttle parameter
  migration: Support responsive CPU throttle
  tests/migration-tests: Add test case for responsive CPU throttle

 include/exec/ram_addr.h        | 107 +++++++++++++++-
 include/exec/ramblock.h        |  45 +++++++
 migration/migration-hmp-cmds.c |  25 ++++
 migration/migration-stats.h    |   4 +
 migration/migration.c          |  12 ++
 migration/options.c            |  74 +++++++++++
 migration/options.h            |   3 +
 migration/ram.c                | 218 ++++++++++++++++++++++++++++++---
 migration/ram.h                |   4 +
 migration/trace-events         |   4 +
 qapi/migration.json            |  45 ++++++-
 tests/qtest/migration-test.c   |  77 +++++++++++-
 12 files changed, 593 insertions(+), 25 deletions(-)

-- 
2.39.1


