Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B724AC43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 23:02:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiKDr-0004IT-36; Fri, 10 Jul 2026 19:01:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wiKDh-0004G7-Nm
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 19:01:21 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wiKDf-00030w-M7
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 19:01:21 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-384c94c9414so1480944a91.3
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 16:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783724477; x=1784329277; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=0BCUMzRaN2dQ7QlKdQkuKaMRqmcg3jLO8Oc+HhwtyIo=;
 b=WBdkWbhV0sfp+saAidqN++cHrb2obg/ia1hgOisDQ88aBBFhXIdMnrY5Tm5yEq6bZf
 NkM45nXHgtjV9M/RQX5aF8OjshL9fLuRZO6gFZ2ixYR5da1L9suPUKDXEDM4Hm8N13z8
 Hl6aB07nZFvK/HGKXvOVSMVkyz3wYwAo4/3wSFCurSumV8t52VV+biaWnZ4wj3VDsCXr
 pC05Irvw7y7Gd+qcZevzlse1arSuZmAnreUWJRJ3ypFfR4cjQlJf5CdMOGGgCuieUZPU
 UCI1tX9vluzKUj9m9SZtjeoiDP0H3JO+Zvs+jwqjMmoi42P8+3nvin773f7ZMzxZhuf4
 5Asw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783724477; x=1784329277;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0BCUMzRaN2dQ7QlKdQkuKaMRqmcg3jLO8Oc+HhwtyIo=;
 b=cdcTeym6pkT9DjTxjYQ8Iej+bDpDkZX2VHgL7zdcXh8X4+tEXgbP80E7hqCcdNQUok
 QzluWuVSfOjozsk3wBztGB+Ona50VcdYRiX9mNV2xAH8vG/1dupjMZb4bjCPdZPOT8a/
 WQkN83bhTRtIrN5TA0jcle5KUUEPK9js+rJyMZhqPXUz2Yxf03BtJg975qluI8B5Gb2G
 WMeMtXL3410WbBCi+X1m49ZM4s6YiLZIxJmaW48U1x6pD97pLW4SIAef0gvw32kpUmE7
 lTqo73YsIaAoO/vv2VIOivP1tDcfKOB55S/d+GjK2HMv3IWfc+jaTn/si1b4drJr9YvN
 0GdQ==
X-Gm-Message-State: AOJu0YwrC2D1ppOc9MzUEMq0OigvfL+IgWfSRw32fq4hiA7NQ8FEH573
 X/vDn6rs8c7zOPUr+iNSmPFEg2czA6myzpDnxa9YojC4pj8EqH5xQg8lWMNjOpw+mNJaqxomP/s
 bP6Qq
X-Gm-Gg: AfdE7cllWNrF0859hhgszPKWcRfBWJ4kr3ipzZjmA1lF61SOTEmabA91hF38DD6keHO
 nvZFT5LbxIYKXwvnLoslHzMSAQ5aeyh3nDshzLK7QEFwkqvSWF4k8+sKAUnaSoJ013PA3ke/uRY
 rIVhJNsnvXkDUXs25ci1ysU8kdgopUcMrkOXY3DckSAzMOQlQ+WYTN9iQU7yjdI8rTjnLXiT91r
 Ank6LHH9Nc+wMUOi1HHjW438Z3WM2FFjIixliPqqhQJ/bFnDvjD4xjGJfgn4sdkhA3Y19RoNrov
 H7hyLH/RqVJ9fcn1mjPRbutooe8SBi4k2zbeSCKjBBLleVHfpDpi2T/NZ7nGoPtPnRcM9+7PvZY
 yBwxg5vk5BLVyEL7s7VP83Zzrri1AFy55FSYOEgvD0sgvsVYN445ZfDyyjJd/crjeilNS8RZMRH
 CH5sYI0Oh/bPKU9vzqn6TBrxvKhf14
X-Received: by 2002:a17:90b:5583:b0:383:f52b:d616 with SMTP id
 98e67ed59e1d1-38dc75e3a5fmr747705a91.10.1783724477395; 
 Fri, 10 Jul 2026 16:01:17 -0700 (PDT)
Received: from stoup.. ([71.212.146.49]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38a55b3c9eesm3426569a91.11.2026.07.10.16.01.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 16:01:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/13] user patch queue
Date: Fri, 10 Jul 2026 16:01:03 -0700
Message-ID: <20260710230116.900171-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1031.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The following changes since commit ab2056a0b7c944b16b224a8feabd99023772ae91:

  Merge tag 'pull-ufs-20260709' of https://gitlab.com/jeuk20.kim/qemu into staging (2026-07-09 12:04:14 +0200)

are available in the Git repository at:

  https://gitlab.com/rth7680/qemu.git tags/pull-lu-20260710

for you to fetch changes up to de1a2257117fc893d0703a154683b05f7bee0b12:

  common-user: Move guest_base, have_guest_base to probe-guest-base.c (2026-07-10 14:40:42 -0700)

----------------------------------------------------------------
Handle loading of ET_EXEC binaries at address 0.
Share probe_guest_base code between linux-user and bsd-user.

----------------------------------------------------------------
Richard Henderson (13):
      linux-user: Introduce PGBRange
      linux-user: Use PGBRange in load_elf_image
      linux-user: Drop hiaddr out-of-range check in probe_guest_base
      linux-user: Pass image_range to probe_guest_base
      linux-user: Use PGBRange for commpage
      common-user: Move mmap_min_addr from linux-user
      common-user: Initialize mmap_min_addr for FreeBSD
      include/user/guest-host: Include missing cpu.h
      common-user: Move selfmap from util
      common-user: Implement read_self_maps for FreeBSD
      common-user: Move probe_guest_base from linux-user
      bsd-user: Use probe_guest_base
      common-user: Move guest_base, have_guest_base to probe-guest-base.c

 include/user/guest-host.h        |   1 +
 include/user/mmap-min-addr.h     |  12 ++
 include/user/probe-guest-base.h  |  37 ++++
 include/{qemu => user}/selfmap.h |   0
 linux-user/arm/target_elf.h      |   2 +-
 linux-user/hppa/target_elf.h     |   2 +-
 linux-user/user-internals.h      |  17 +-
 bsd-user/elfload.c               |  37 ++--
 bsd-user/main.c                  |  42 +---
 common-user/mmap-min-addr.c      |  50 +++++
 common-user/probe-guest-base.c   | 347 +++++++++++++++++++++++++++++++++
 {util => common-user}/selfmap.c  |  49 ++++-
 linux-user/arm/elfload.c         |   2 +-
 linux-user/elfload.c             | 400 +++------------------------------------
 linux-user/flatload.c            |   3 +-
 linux-user/hppa/elfload.c        |   4 +-
 linux-user/main.c                |  35 +---
 linux-user/mmap.c                |   1 +
 linux-user/syscall.c             |   2 +-
 common-user/meson.build          |   3 +
 util/meson.build                 |   4 -
 21 files changed, 564 insertions(+), 486 deletions(-)
 create mode 100644 include/user/mmap-min-addr.h
 create mode 100644 include/user/probe-guest-base.h
 rename include/{qemu => user}/selfmap.h (100%)
 create mode 100644 common-user/mmap-min-addr.c
 create mode 100644 common-user/probe-guest-base.c
 rename {util => common-user}/selfmap.c (68%)

