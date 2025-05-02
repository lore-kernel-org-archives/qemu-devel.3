Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAB68C3ABAC
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 16:42:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAtSU-0007eD-C5; Fri, 02 May 2025 12:41:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uAtST-0007dj-4V
 for qemu-devel@nongnu.org; Fri, 02 May 2025 12:41:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uAtSP-0006QZ-6k
 for qemu-devel@nongnu.org; Fri, 02 May 2025 12:41:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746204107;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=IVyQGmZHakl/JocFLp1qesylf4SM4d2BrJv+WWqNJ5k=;
 b=QnLJHiX4+lh5Fyzo6VepRBjYSVXUMNJgzJ4wwioY6a7D4S5ZxJKLkLaiEYOEfS1h8mXbuQ
 SnVd6ZnCqD5LXMhbK0BwZVPc2V5tNFbt26fAyP7k1IWVTncOSEzMlzNv/pbyyw+NAl0hU3
 M9zkz/NXAVqxSBNyllgBxFGSm+OHMMI=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-522-bYvRtKBdN76SXfqJGTzNhg-1; Fri, 02 May 2025 12:41:46 -0400
X-MC-Unique: bYvRtKBdN76SXfqJGTzNhg-1
X-Mimecast-MFC-AGG-ID: bYvRtKBdN76SXfqJGTzNhg_1746204106
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-7c0c1025adbso463457985a.1
 for <qemu-devel@nongnu.org>; Fri, 02 May 2025 09:41:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746204105; x=1746808905;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IVyQGmZHakl/JocFLp1qesylf4SM4d2BrJv+WWqNJ5k=;
 b=c0BFqJHaoinyLvMKj0JvXG86NVbvCar8xRvuhJ7fBkS+DTKr3geg2vQRiuLJssWk2k
 lk21BivAZi5+FwFZ4QuNzJz2USt5JWf04nIBnvCV/xWyrhr8gZ8VW1O6VZovT0pEr6/V
 kuSSt3h4V12H0qSiz6M6Zu7do4KziPFzZgE6qvKlBfASYaRWTztN/C/gtw0IXx6oNT+O
 TuHiTTvzsc9Ix6k+Nf7CO4HYYtj48Rhq+fvbmGx/0bQfNwFrzxgBiJMm5laxY9jSuXm6
 9M01CpbSWeA/DFM5/QKjXG8wMTwpIXlXS5HO3t8F/yS68enn3CULy5sAW8EGbSR3VZJN
 MJzg==
X-Gm-Message-State: AOJu0YysMvZ3MIaZ6uH5KvvWdv63naRzY2TWmn3VnL9eqNguriRRNhcw
 LOpurB5/xKvrrcuWd1GeulfyXE5bFcRBOjNFWlufC6GIpR+6xaWmAb+CoSF0J2rBjlsAvgILhTA
 jPfj4heOw+ua9QxcIqGo4dwF8IbGzJ7ValIR0epPezjq5RunSC5YOiqnqbDdvmisFOkCQndF4pi
 Ej4pmqitqjYlq4C19HSCD3e+ravnheqOqXPQ==
X-Gm-Gg: ASbGncvSRk7Is81ZTcr4egglsPoQUHemPrATcB51MVd+y35dem2kCl/UIDxUpk5hOBV
 F8N+KMnpmva1vZyzy7sGcGM4UwjyMlynnLtSIW/VgxTdx+kUVKqPj9s9QISqL4sfhRB7pmOIBNs
 s8vv0mVcT/TPOWr8vxFINf9k92LVwfl/p8Vv0XaKleBAjWW/gk6wtDNtX2IcDKW84Aws/3gnEEZ
 wnBHBQ9igtUNmokm/aDDhc03W6hyOSAKDliPabPVXWBVMC8tVH8Wz+t660hRAlgoPcjVLU/aSFy
X-Received: by 2002:a05:620a:2481:b0:7c7:b5dc:2e36 with SMTP id
 af79cd13be357-7cad5b397f2mr470486385a.18.1746204105274; 
 Fri, 02 May 2025 09:41:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEhz8IqP9l8EcwcdSYjB0+DEYqY/8bo2kpyyjEyVUNGdg/LmaxWWrPW/DZ+0t/c+pmON3b3Tw==
X-Received: by 2002:a05:620a:2481:b0:7c7:b5dc:2e36 with SMTP id
 af79cd13be357-7cad5b397f2mr470482285a.18.1746204104835; 
 Fri, 02 May 2025 09:41:44 -0700 (PDT)
Received: from x1.com ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7cad23d1c8dsm203108385a.60.2025.05.02.09.41.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 May 2025 09:41:44 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Stefan Hajnoczi <stefanha@redhat.com>,
 peterx@redhat.com
Subject: [PULL 00/14] Migration 20250502 patches
Date: Fri,  2 May 2025 12:41:27 -0400
Message-ID: <20250502164141.747202-1-peterx@redhat.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.644,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The following changes since commit 5134cf9b5d3aee4475fe7e1c1c11b093731073cf:

  Merge tag 'block-pull-request' of https://gitlab.com/stefanha/qemu into staging (2025-04-30 13:34:44 -0400)

are available in the Git repository at:

  https://gitlab.com/peterx/qemu.git tags/migration-20250502-pull-request

for you to fetch changes up to e674fedbd1fd9953bc30026670aba6779848280a:

  scripts/vmstate-static-checker.py: Allow new name for ghes_addr_le field (2025-05-02 11:09:36 -0400)

----------------------------------------------------------------
Migration pull request

- Prasad's few pre-requisite patches from multifd+postcopy enablement series
- Markus's fix on a latent bug for tls_authz setup
- Zhijian's latest RDMA series (includes the rdma soft-RoCE unit test)
- Jack's RDMA migration patch to re-enable ipv6
- Thomas's vmstate static checker update on rename field in acpi/ghes
- Peter's postcopy preempt optimization for locality hint

----------------------------------------------------------------

Jack Wang (1):
  migration/rdma: Remove qemu_rdma_broken_ipv6_kernel

Li Zhijian (5):
  migration: check RDMA and capabilities are compatible on both sides
  migration: disable RDMA + postcopy-ram
  migration/rdma: Remove redundant migration_in_postcopy checks
  migration: Unfold control_save_page()
  migration: Add qtest for migration over RDMA

Markus Armbruster (1):
  migration: Fix latent bug in migrate_params_test_apply()

Peter Xu (3):
  migration: Add save_postcopy_prepare() savevm handler
  migration/ram: Implement save_postcopy_prepare()
  migration/postcopy: Spatial locality page hint for preempt mode

Prasad J Pandit (3):
  migration/multifd: move macros to multifd header
  migration: refactor channel discovery mechanism
  tests/qtest/migration: consolidate set capabilities

Thomas Huth (1):
  scripts/vmstate-static-checker.py: Allow new name for ghes_addr_le
    field

 MAINTAINERS                               |   1 +
 include/migration/register.h              |  15 ++
 migration/multifd.h                       |   5 +
 migration/options.h                       |   1 +
 migration/rdma.h                          |   3 +-
 migration/savevm.h                        |   1 +
 tests/qtest/migration/framework.h         |   9 +-
 migration/migration.c                     | 164 +++++++++++--------
 migration/multifd.c                       |   5 -
 migration/options.c                       |  30 ++++
 migration/ram.c                           | 168 +++++++++++++++----
 migration/rdma.c                          | 191 +---------------------
 migration/savevm.c                        |  33 ++++
 tests/qtest/migration/compression-tests.c |  22 ++-
 tests/qtest/migration/cpr-tests.c         |   6 +-
 tests/qtest/migration/file-tests.c        |  58 +++----
 tests/qtest/migration/framework.c         |  75 ++++++---
 tests/qtest/migration/misc-tests.c        |   4 +-
 tests/qtest/migration/postcopy-tests.c    |   8 +-
 tests/qtest/migration/precopy-tests.c     |  91 +++++++++--
 tests/qtest/migration/tls-tests.c         |  23 ++-
 scripts/rdma-migration-helper.sh          |  70 ++++++++
 scripts/vmstate-static-checker.py         |   1 +
 23 files changed, 614 insertions(+), 370 deletions(-)
 create mode 100755 scripts/rdma-migration-helper.sh

-- 
2.48.1


