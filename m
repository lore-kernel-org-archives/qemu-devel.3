Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59B8ACEDD90
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 12:43:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syW1g-0004hK-DG; Wed, 09 Oct 2024 08:42:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1syW1d-0004h8-Us
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 08:42:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1syW1c-0005Q8-FD
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 08:42:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728477763;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=4nb+8tiOqGgKjwOS264AkApkrCHN7lS055Icz/qATWk=;
 b=SIDpgpQiceCU0RQbQJabtJDWOnUSg4p5Ed3F634by9CboNg5jYlvASVqfQgLOBTBu9wdcL
 Ln11Rdl7ny9Q2IdKKSuJ1i7crHzonU3MWdYS6a9Kb/LbWRUcm5J9pznH2XMeYDXp8Hncjt
 cH/cbwr18S0SsAunXmtMoEPbdlmtby0=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-RbAUJKE2MkamFRYhbuzu9g-1; Wed, 09 Oct 2024 08:42:42 -0400
X-MC-Unique: RbAUJKE2MkamFRYhbuzu9g-1
Received: by mail-io1-f71.google.com with SMTP id
 ca18e2360f4ac-82cedb7a183so557391539f.0
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2024 05:42:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728477761; x=1729082561;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4nb+8tiOqGgKjwOS264AkApkrCHN7lS055Icz/qATWk=;
 b=ZV1e+yQEbYS5eWEDb22k7aQ52knuieOAp8KN82J+qk4Fek7bFTmfDbhaqMWjs4MZe7
 dGeGrtBjVUcUnkGGpuaUOWro0LUulKqbPZeqSu6yiKWlLYTPlAex60uOjAv/zUbY1CaE
 yu4w9RBnXNpGWSOiNdMPX/C4vl+Ppf5LNYRJHUY8+pdViASMs/SZMCApetDPRRKN+cXx
 n0mcN0CNLBPXtrHUsMVw199BfNSqdzK91xb5L0wU/zJMTlnLAk8UcXHb6FV/LoLNYbTg
 8nzkAeXfnLlY76ikA0NXLfl6p6qwnzscDlPejSXHPAN5J0TMSwgFMEtSuKi6TORWXOWc
 iUEQ==
X-Gm-Message-State: AOJu0YxMVzb+zFDraA73/ttTDHLOwDQ4T4vyIQPLhgsF0H/vzEOK8Tx9
 /eoJrVgEdea3o00gN632hQWkAwDmRPWq4pMOAOOiPtwd263F3+Af7mdsF1FDf/4wTYladvirwF2
 ghrooa9Q2wQoEFpEVZCnM87AmFVDJCkVjVDbDQqqXMIIZoQhq5RBAU4UlSLnRqZL95lRth1iXRL
 qDuzXcjC/N4qQWTcsV2Ij7vyQVrCGf1cbInQ==
X-Received: by 2002:a05:6602:2cd0:b0:835:3a07:740 with SMTP id
 ca18e2360f4ac-8353d491666mr254619539f.6.1728477761367; 
 Wed, 09 Oct 2024 05:42:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGGvPfmtsypEc3jLKrKsC3jTKwdIECJl1+7KrZic/S7qN6YeOEAoJMBiZ6OZ+4RjCE8Kjt2nw==
X-Received: by 2002:a05:6602:2cd0:b0:835:3a07:740 with SMTP id
 ca18e2360f4ac-8353d491666mr254615139f.6.1728477760942; 
 Wed, 09 Oct 2024 05:42:40 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-83503aacb18sm220272039f.30.2024.10.09.05.42.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Oct 2024 05:42:40 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Fabiano Rosas <farosas@suse.de>,
 peterx@redhat.com
Subject: [PULL 00/12] Migration 20241009 patches
Date: Wed,  9 Oct 2024 08:42:26 -0400
Message-ID: <20241009124238.371084-1-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.151,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

The following changes since commit 2af37e791906cfda42cb9604a16d218e56994bb1:

  Merge tag 'pull-request-2024-10-07' of https://gitlab.com/thuth/qemu into staging (2024-10-07 12:55:02 +0100)

are available in the Git repository at:

  https://gitlab.com/peterx/qemu.git tags/migration-20241009-pull-request

for you to fetch changes up to 2e49d6a20b2193378e508b01de82eaffc5adc3bc:

  migration/multifd: fix build error when qpl compression is enabled (2024-10-09 08:30:53 -0400)

----------------------------------------------------------------
Migration pull request

- Ani's patch to complete the memory API on coalesced IO / eventfd notifies
- Fabiano's Coverity fix on using pstrcpy() over strncpy()
- Dave's series on removing/deprecating zero-blocks and uffd cleanups
- Juraj's one more fix on multifd/cancel test where it can fail when
  cancellation happens too slow on src
- Dave's one more remove deadcode patch in iova-tree.c
- Yuan's build fix for multifd qpl compressor

----------------------------------------------------------------

Ani Sinha (1):
  memory: notify hypervisor of all eventfds during listener
    (de)registration

Dr. David Alan Gilbert (7):
  migration: Remove migrate_cap_set
  migration: Remove unused migrate_zero_blocks
  migration: Remove unused socket_send_channel_create_sync
  util/userfaultfd: Return -errno on error
  migration/postcopy: Use uffd helpers
  util/userfaultfd: Remove unused uffd_poll_events
  util/iova-tree: Remove deadcode

Fabiano Rosas (2):
  migration/multifd: Ensure packet->ramblock is null-terminated
  migration: Deprecate zero-blocks capability

Juraj Marcin (1):
  tests/migration-test: Wait for cancellation sooner in multifd cancel

Yuan Liu (1):
  migration/multifd: fix build error when qpl compression is enabled

 docs/about/deprecated.rst    |  6 +++
 qapi/migration.json          |  5 ++-
 include/qemu/iova-tree.h     | 25 -----------
 include/qemu/userfaultfd.h   |  1 -
 migration/options.h          |  2 -
 migration/socket.h           |  1 -
 migration/multifd-nocomp.c   |  4 +-
 migration/multifd-qpl.c      | 10 ++---
 migration/options.c          | 31 ++------------
 migration/postcopy-ram.c     | 48 ++++++---------------
 migration/socket.c           | 18 --------
 system/memory.c              | 83 ++++++++++++++++++++++++++++++++++++
 tests/qtest/migration-test.c | 12 +++++-
 util/iova-tree.c             | 23 ----------
 util/userfaultfd.c           | 49 ++++++---------------
 15 files changed, 141 insertions(+), 177 deletions(-)

-- 
2.45.0


