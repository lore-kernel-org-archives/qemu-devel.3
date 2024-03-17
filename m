Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61E60C54E68
	for <qemu-devel@archiver.kernel.org>; Sun, 17 Mar 2024 20:59:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rlxaC-0002BY-Ei; Sun, 17 Mar 2024 16:58:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rlxaB-0002BA-Cj
 for qemu-devel@nongnu.org; Sun, 17 Mar 2024 16:58:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rlxa9-0002ZH-F9
 for qemu-devel@nongnu.org; Sun, 17 Mar 2024 16:58:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710709092;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=yj6+2OOOZFRaDx1wfLqi3Ph0h7MLz2jfHulxgc/o+KM=;
 b=WrpefUN6uqA9sRXeSKH2rdkXyLlUmTyREWh+P2LDSRVchmVlDqxRkWHB+m+0UE/PwLsrzh
 myEUDtLRJsonsamm+OBsy7eZBkCjnvZ+rgWLc60Fk2xPGaVYVDhXy0AFBeNmu/A0SB/mue
 MzttqSSzPUB2gmZ2Mh5uHvM84YUW1GU=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-rpqmfsFBMga4p6vyURRWCA-1; Sun, 17 Mar 2024 16:58:08 -0400
X-MC-Unique: rpqmfsFBMga4p6vyURRWCA-1
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-430b4572a97so12822091cf.1
 for <qemu-devel@nongnu.org>; Sun, 17 Mar 2024 13:58:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710709087; x=1711313887;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yj6+2OOOZFRaDx1wfLqi3Ph0h7MLz2jfHulxgc/o+KM=;
 b=mbCI/DW1z7mDaLO0vQnWYla5BIkAhKyEioW1dr71GAJhfufw+jtThipdet4GLMGcq1
 TP+tbQWz7gKVwQDrdxlkbObfKbhUfd13OscZo1XS4Z85U8TPuH2zPp/7PC7TvNEDIotT
 YdRg7WFPjcjZcVjsE6R8KmgOqc6MoRI42boy7dvNGs3SPQkzgHj51w6Xd9/W+i8jOqKl
 doJ8ntteNFCalcgWCUWAVlp4GXX7abBPeoyX5JZNPFHRugAq6SUT8lt9AfSc8BQSZB8y
 Rumwt3xdpn1AHFF+NtalZ+6K17wvzh5StDTn8R/A1KkALB9WSoANpDDkwTJjfjdpJVhj
 y20g==
X-Gm-Message-State: AOJu0YxcAoF7qSvqfDwGhgWy3AdVmmrrnyB0IgiZsg/bCA0L28jG+JAB
 8TvEsUKydMgyBDms483s0Vr2HKDAhULuXWz+kp7PcftX3WmqFVzzg3m5eRV7vrd6ioFTqnD877K
 aiUh4fpW/xGuw55sCGgOat4VpaG7B8Oll0oTthG2KqJY8gPTL9qorq5Vn6/BiB2ErR8oWiH9F0J
 yoKkKbDzGvKR2nbmFGBhSyjaHYd7/rX+VD4Q==
X-Received: by 2002:a05:6214:5d87:b0:68f:deb6:2f48 with SMTP id
 mf7-20020a0562145d8700b0068fdeb62f48mr8998334qvb.5.1710709087449; 
 Sun, 17 Mar 2024 13:58:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEmJgaRvyvNVGetIzjPvzyu6PPehOeQPQTq/v1+iYlIl/fmAzOSOuqqbM5Dfb0Cp1Gwu8+XDQ==
X-Received: by 2002:a05:6214:5d87:b0:68f:deb6:2f48 with SMTP id
 mf7-20020a0562145d8700b0068fdeb62f48mr8998310qvb.5.1710709086896; 
 Sun, 17 Mar 2024 13:58:06 -0700 (PDT)
Received: from x1n.. ([99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 ed8-20020ad44ea8000000b00691879d7a50sm2391566qvb.115.2024.03.17.13.58.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 Mar 2024 13:58:06 -0700 (PDT)
From: peterx@redhat.com
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Cc: Fabiano Rosas <farosas@suse.de>, Prasad Pandit <ppandit@redhat.com>,
 peterx@redhat.com, David Hildenbrand <david@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 00/10] Migration 20240317 patches
Date: Sun, 17 Mar 2024 16:57:53 -0400
Message-ID: <20240317205803.361163-1-peterx@redhat.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.316,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

From: Peter Xu <peterx@redhat.com>

The following changes since commit 35ac6831d98e18e2c78c85c93e3a6ca1f1ae3e58:

  Merge tag 'net-pull-request' of https://github.com/jasowang/qemu into staging (2024-03-12 13:42:57 +0000)

are available in the Git repository at:

  https://gitlab.com/peterx/qemu.git tags/migration-20240317-pull-request

for you to fetch changes up to 9adfb308c1513562d6acec02aa780c5ef9b0193d:

  migration/multifd: Duplicate the fd for the outgoing_args (2024-03-15 11:26:33 -0400)

----------------------------------------------------------------
Migration pull for 9.0-rc0

- Nicholas/Phil's fix on migration corruption / inconsistent for tcg
- Cedric's fix on block migration over n_sectors==0
- Steve's CPR reboot documentation page
- Fabiano's misc fixes on mapped-ram (IOC leak, dup() errors, fd checks, fd
  use race, etc.)

----------------------------------------------------------------

Cédric Le Goater (1):
  migration: Skip only empty block devices

Fabiano Rosas (5):
  io: Introduce qio_channel_file_new_dupfd
  migration: Fix error handling after dup in file migration
  migration: Fix iocs leaks during file and fd migration
  migration/multifd: Ensure we're not given a socket for file migration
  migration/multifd: Duplicate the fd for the outgoing_args

Nicholas Piggin (2):
  physmem: Factor cpu_physical_memory_dirty_bits_cleared() out
  physmem: Fix migration dirty bitmap coherency with TCG memory access

Philippe Mathieu-Daudé (1):
  physmem: Expose tlb_reset_dirty_range_all()

Steve Sistare (1):
  migration: cpr-reboot documentation

 docs/devel/migration/CPR.rst      | 147 ++++++++++++++++++++++++++++++
 docs/devel/migration/features.rst |   1 +
 include/exec/exec-all.h           |   1 +
 include/exec/ram_addr.h           |  12 +++
 include/io/channel-file.h         |  18 ++++
 migration/file.h                  |   1 +
 io/channel-file.c                 |  12 +++
 migration/block.c                 |   5 +-
 migration/fd.c                    |  51 ++++++-----
 migration/file.c                  |  75 +++++++++------
 migration/migration.c             |   6 +-
 system/physmem.c                  |  10 +-
 12 files changed, 279 insertions(+), 60 deletions(-)
 create mode 100644 docs/devel/migration/CPR.rst

-- 
2.44.0


