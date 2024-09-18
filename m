Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B640CDD54F
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2024 18:32:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqzTC-0001jU-IR; Wed, 18 Sep 2024 14:32:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sqzT9-0001hd-6Y
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 14:32:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sqzT6-0001zk-Th
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 14:32:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726684317;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=9UuXYercPx+yzdVxMuWHgiGJm7ilgLZXDllJ7gHsVgk=;
 b=MzbT4zI67SoI5XISpkXJwg90E8v+FLWAV2AH9ktqz3NyCMGAJeJnkrph2Ju0TEL2Qu3sCJ
 Sy5fQ3R2MlrscA52AgwK4tJdZDyECbXyhw6JggUanQOOUQ2QVQOxMAuqHalg/cZG9WB7Sm
 OaRUAwmWXUOTVu5Oq/1Ti6T2Hlr6XL0=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-386--kpNwUEpPG6wtLH_putTzQ-1; Wed, 18 Sep 2024 14:31:55 -0400
X-MC-Unique: -kpNwUEpPG6wtLH_putTzQ-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-6c3554020afso118560106d6.3
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2024 11:31:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726684314; x=1727289114;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9UuXYercPx+yzdVxMuWHgiGJm7ilgLZXDllJ7gHsVgk=;
 b=LSp55PVf0jM9e1RGM996AvTrXj3c0NE7D3YeYlmxwT1lavyZfxrWlYA/Rbe3bX+ok+
 PPIZ7jvauACGs20zzikCIXfjtd7K3lEg9vD+sF5dQ0sWKd9dE9hJhf91Em9riNtgUvUC
 sQn+oFpBB9SA7iSrnvK+lhS4WQdeDcT4ylpvqbYIRFdC2hbXp1gkwq4YqE9PusdMmtR9
 BV6dEwluLlkXpgbcsCzn+gC9ieSo/+n9VYrovXtEDxzNFzaqLBx11pYyBywjOC+O444Q
 bok/eVudwObjYtpycR3FbKa3ZHE258WGDXc9AVHEnDYirmufBfWev/fS1Kmlpa/cuBvC
 g2pA==
X-Gm-Message-State: AOJu0YzSb/39Qu/SdgYm9svCQxAsd4GBOWsyD5ux+Xgqxj7Amzdq0NUZ
 3hCX3MyXJ+phK5sBm+NxiYO63Z1Cxt4TmWyFVpqDTfPVwmqJ1ZkehNNrV9l38xtD/CZuH0lZze5
 XKtL+wnKPVshitOoAVBgP8lof9zUgV22mUgWMy91fY9Yo0vwucUxwxLgdVI7GTupghgqtkIhKZf
 EO5S0ymuyookL8GT4NynY430VB5q7Rb2T4bQ==
X-Received: by 2002:a05:6214:5c07:b0:6c3:5a9a:572b with SMTP id
 6a1803df08f44-6c573532f8amr309399636d6.20.1726684314140; 
 Wed, 18 Sep 2024 11:31:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHedxJ97WPY8qm7Je9VyUdfcQFvH5rm9DEyn/vqqSfuvAln/GV0wCDE6sSJcXp/D4fROd0SRw==
X-Received: by 2002:a05:6214:5c07:b0:6c3:5a9a:572b with SMTP id
 6a1803df08f44-6c573532f8amr309399416d6.20.1726684313711; 
 Wed, 18 Sep 2024 11:31:53 -0700 (PDT)
Received: from x1n.. (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c75e494a28sm30486d6.68.2024.09.18.11.31.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Sep 2024 11:31:52 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Fabiano Rosas <farosas@suse.de>,
 peterx@redhat.com
Subject: [PULL v2 0/6] Migration 20240917 patches
Date: Wed, 18 Sep 2024 14:31:45 -0400
Message-ID: <20240918183151.6413-1-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

The following changes since commit 2b81c046252fbfb375ad30632362fc16e6e22bd5:

  Merge tag 'block-pull-request' of https://gitlab.com/stefanha/qemu into staging (2024-09-17 14:02:18 +0100)

are available in the Git repository at:

  https://gitlab.com/peterx/qemu.git tags/migration-20240917-pull-request

for you to fetch changes up to 4ce56229087860805877075ddb29dd44578365a9:

  migration/multifd: Fix rb->receivedmap cleanup race (2024-09-18 14:27:39 -0400)

----------------------------------------------------------------
Migration pull request for 9.2

- Fabiano's patch to move two tests to slow tests.
- Peter's patch to fix qatzip builds
- Stefan's multifd-zstd fix on unsigned diff comparisons
- Fea's bug fix to consistently use memattrs when map() address space
- Fabiano's bug fix on multifd race condition against receivedmap

----------------------------------------------------------------

Fabiano Rosas (3):
  tests/qtest/migration: Move a couple of slow tests under g_test_slow
  migration/savevm: Remove extra load cleanup calls
  migration/multifd: Fix rb->receivedmap cleanup race

Fea.Wang (1):
  softmmu/physmem.c: Keep transaction attribute in address_space_map()

Peter Xu (1):
  migration/multifd: Fix build for qatzip

Stefan Weil (1):
  migration/multifd: Fix loop conditions in multifd_zstd_send_prepare
    and multifd_zstd_recv

 migration/migration.c        |  5 +++++
 migration/multifd-qatzip.c   | 18 +++++++++---------
 migration/multifd-zstd.c     |  8 ++++----
 migration/savevm.c           |  8 ++++----
 system/physmem.c             |  2 +-
 tests/qtest/migration-test.c |  8 +++++---
 6 files changed, 28 insertions(+), 21 deletions(-)

-- 
2.45.0


