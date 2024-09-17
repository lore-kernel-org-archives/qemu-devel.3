Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20EACCAC5AA
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2024 21:56:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqgAI-0006OU-MS; Tue, 17 Sep 2024 17:55:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sqgAF-0006Mi-6s
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 17:55:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sqgAD-0004hC-Jk
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 17:55:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726610111;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=IDANZhxftsiqaGKiWyuK2SCkmD4yE6+OuVSzfGQjGNM=;
 b=ZEaSbOOK2sGS+1ITujEg5g17hiffuOd3yF7umCPalzfF250TRI3/LMbupU97t2iV2Lih4J
 5qALS8jYh2Co3M8pEFlyMINb6R3EbfCmHY3+dzjIz5wsVX70c/OYb90mK7dvMqbNc4YMbt
 kqkdvIGHiSwT3BZ9GLwJPs1aj7kudJM=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-6LgmlIS1O5GwgZcjlIymbQ-1; Tue, 17 Sep 2024 17:55:10 -0400
X-MC-Unique: 6LgmlIS1O5GwgZcjlIymbQ-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7ac9b08cb77so289137485a.1
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2024 14:55:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726610110; x=1727214910;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IDANZhxftsiqaGKiWyuK2SCkmD4yE6+OuVSzfGQjGNM=;
 b=DIXMkMychv/6g8r0dhRQCLGLJDXgMLm5S1AAX8ueOWytjnYLjPiHUWyUc6GJLLtIbN
 K8cM9kpK6xiBO8b+7CdDvnichL3zg/DF5XxM57V2yKUIbPHA+qIPGuasyWDponyrTjPp
 gUohzSaDQnxMh0WGEDSkqSyYdz7bJPTgx47zt1vqc3yMoE96b2vUdorV78+82T/P8Q7M
 ImpDPAxr52dWVqacIqge2CUreAZIMLZPJBkwveCT/H62uOwshBcDjRx6SgCXOerrJjaQ
 Pch/2cy8lindeGc/vh8fe4THsT53PlXRH+ZmVT4aFeVjS06dUYbVqF731sy8hm3cn1Vp
 yMEQ==
X-Gm-Message-State: AOJu0YytvKYUJyD0Cv6ptIzznpDPe02T/AOEExB4mho/QDZ2Q6R9I1P1
 T5xzIDawAuF8Op04LQGHhLcgzcTAu8DEmOLl2ClPd9bAUfF5kfDxdT96tfxk3xL4tmFrTeDDqcT
 IrzwBXCA/UhMHKk+XGP+lUoww+rEbz+rBZZr/ClYVHUWOHFRJwe5lSyH+rBIb17SBBoJz5hGMzT
 LszGELIta8SecK0zA+Red0uhxG2oOOD15/9A==
X-Received: by 2002:a05:620a:4105:b0:7a9:c203:7c2f with SMTP id
 af79cd13be357-7a9e5eea55amr3174729685a.4.1726610109882; 
 Tue, 17 Sep 2024 14:55:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFwLdQoioNb8Dgkcu5KckYFZUTM+SGkhCLBG8mRnodWNkeLNuJ0NqLlfZV3H0ioylu3hl086g==
X-Received: by 2002:a05:620a:4105:b0:7a9:c203:7c2f with SMTP id
 af79cd13be357-7a9e5eea55amr3174724685a.4.1726610109304; 
 Tue, 17 Sep 2024 14:55:09 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7ab3e97c9fasm402869685a.28.2024.09.17.14.55.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Sep 2024 14:55:08 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, David Hildenbrand <david@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PULL 0/6] Migration 20240917 patches
Date: Tue, 17 Sep 2024 17:55:00 -0400
Message-ID: <20240917215506.472181-1-peterx@redhat.com>
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

for you to fetch changes up to 7b8b4c0e59d2b7928836072536a5528820d8a041:

  migration/multifd: Fix rb->receivedmap cleanup race (2024-09-17 17:50:45 -0400)

----------------------------------------------------------------
Migration pull for 9.2

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


