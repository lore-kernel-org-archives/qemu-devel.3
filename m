Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B79FEECE57A
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 13:49:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snel1-0008W8-Ds; Mon, 09 Sep 2024 09:48:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1sneky-0008UP-Ii
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 09:48:40 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1snekw-00009C-1e
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 09:48:40 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-7d50a42ce97so1656086a12.0
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 06:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1725889714; x=1726494514;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=3Tkz+kcXDD5yhOfDHn82P1vETFk9tK0Xmv2fYqMXp7I=;
 b=iEXkzMIxJvVMfMOx9A1AKvb8mMX+gz/0jZS5CS/RtoVy4rvrMuk1giz3EUOD1sFzYn
 fjY+r7riCipECGrQS6rTEYrsXVVT/lNU8riO0g25pGvB5R0Ki82mmEesdArLXUWUxsqB
 k0mI4Lw6/I1meA+RLuATQ39dY6DMqFbOCAuaaLYzo18xfZfwKre8Q1PJ6uFnOviMBkwS
 5X+B8/Qm7gymbkj0nZCdsjH/YvnHEfNIYtBhV7Zn6l6VDy4YPPKPkSeTbdJhtgaFtKwD
 pN6Wp1RVNjj7r4WdwK2tMQCGiAvQJrJP7CihGWDp4Mlb84gHsS6jn8Rwyx+l7Jpjn3/j
 On/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725889714; x=1726494514;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3Tkz+kcXDD5yhOfDHn82P1vETFk9tK0Xmv2fYqMXp7I=;
 b=iChu3H+pM9C+CB8zFbGxC68rjlNkbewibJBW9JRw7RsoFPhQyfWQ8BK9699fOJs4y0
 xufMPGqC+8Y9VmaBfq4YaIessokWQxwp1DzQ9ZAEsIV1MB8uXAg4asrD6mcCuN86AE4T
 dkQsnEjw8hCbZH1Tf0PzAZzRpCRs1W/jl3T8t1zL8+Vn7FotZ6Va+EyyELQHIjMo7Cmt
 FoNIuJQMh8WQIkM/WaBYuhYbdX+PZZI8JTYv5Yyq5y/NzgFC9eJxWrk09mHrCT502gYy
 2SydyUtMr+FWAH/EGtSUTvDrdEG+wRmJk4/cMq/fQg+/B/pfLARZbz9cOWl5wGpp3CQD
 P8bQ==
X-Gm-Message-State: AOJu0YxmLS5saO3bmY0dyK9Li1OQWqN1GHBDli/6iJcwxdkVBW3oXrRH
 +YX43b+qtU8qtmjbBCWwo0EAUhNsf6RMNGvLYyCVXgRD1/qkvtNIsaVNvWCSNsAO20PIKlDJCzd
 oEcJPHg==
X-Google-Smtp-Source: AGHT+IE3z5cruTX/IGnhQ240mevWX1iN3G2Lful/T6OS7zYMxFfAjSJfXRqyNX8m2azk5eZG6Apoog==
X-Received: by 2002:a05:6a20:b2a6:b0:1cc:e43e:3a01 with SMTP id
 adf61e73a8af0-1cf2a0e58d3mr7288376637.33.1725889713215; 
 Mon, 09 Sep 2024 06:48:33 -0700 (PDT)
Received: from localhost.localdomain ([118.114.94.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2dab2c6b0b9sm7841031a91.0.2024.09.09.06.48.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Sep 2024 06:48:32 -0700 (PDT)
From: Hyman Huang <yong.huang@smartx.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, yong.huang@smartx.com
Subject: [PATCH RFC 00/10] migration: auto-converge refinements for huge VM
Date: Mon,  9 Sep 2024 21:47:12 +0800
Message-Id: <cover.1725889277.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=yong.huang@smartx.com; helo=mail-pg1-x52b.google.com
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

 include/exec/ram_addr.h        | 117 ++++++++++++++++--
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
 12 files changed, 600 insertions(+), 28 deletions(-)

-- 
2.39.1


