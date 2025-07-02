Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C677C83038
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 17:04:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uX0r9-0003gy-NC; Wed, 02 Jul 2025 13:02:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uX0qx-0003f9-FX
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 13:02:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uX0qu-0003aP-Uo
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 13:02:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751475751;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ZIyesBS/Vzc5gqFCRvLlk6rISfO5HVKmAJXbUC1XAsQ=;
 b=cPK888Ompgif+u+zj+gP8E5FvlEC6IWUDvAU/7obtUigMgS9TTpg/ukJYa7QYjek0nQc69
 m38bwylSg+28ak8CmG4eSeoUFbiYPl+hJ7VxJZbQaTQGGydjBljpi2TM6qsrpnVd4K5+6L
 8RL6glIVwF83TxuEjokZq5wGAmwX9tY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-176-7Ad8DWrmOC62EBD7_6CCDQ-1; Wed,
 02 Jul 2025 13:02:29 -0400
X-MC-Unique: 7Ad8DWrmOC62EBD7_6CCDQ-1
X-Mimecast-MFC-AGG-ID: 7Ad8DWrmOC62EBD7_6CCDQ_1751475749
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 140E7186DE77
 for <qemu-devel@nongnu.org>; Wed,  2 Jul 2025 17:02:10 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.23])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A94E519AC0FC; Wed,  2 Jul 2025 17:02:08 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 0/9] Various fixes for MAINTAINERS, s390x and tests
Date: Wed,  2 Jul 2025 19:01:55 +0200
Message-ID: <20250702170206.212303-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

The following changes since commit 7698afc42b5af9e55f12ab2236618e38e5a1c23f:

  Merge tag 'pull-target-arm-20250701-1' of https://gitlab.com/pm215/qemu into staging (2025-07-02 04:24:14 -0400)

are available in the Git repository at:

  https://gitlab.com/thuth/qemu.git tags/pull-request-2025-07-02

for you to fetch changes up to 01e2b1bc27bae874bfeb6978ce093deac5bb9639:

  tests/functional/test_aarch64_sbsaref_freebsd: Fix the URL of the ISO image (2025-07-02 18:29:57 +0200)

----------------------------------------------------------------
* Fix file names of renamed files in comments and MAINTAINERS
* Fix the "deprecated props" in QOM on s390x
* Fix URL of the aarch64_sbsaref_freebsd functional test
* Fix some trouble with trible

----------------------------------------------------------------
Collin L. Walling (1):
      target/s390x: set has_deprecated_props flag

Sean Wei (6):
      MAINTAINERS: update docs file extensions (.txt -> .rst)
      MAINTAINERS: fix vendor capitalization (Vmware -> VMware)
      MAINTAINERS: fix VMware filename typo (vwm -> vmw)
      treewide: update docs file extensions (.txt -> .rst) in comments
      treewide: fix paths for relocated files in comments
      MAINTAINERS: fix paths for relocated files

Thomas Huth (2):
      target/s390x: A fix for the trouble with tribles
      tests/functional/test_aarch64_sbsaref_freebsd: Fix the URL of the ISO image

 MAINTAINERS                                      | 23 ++++++++++-------------
 docs/spin/tcg-exclusive.promela                  |  4 ++--
 include/hw/acpi/pcihp.h                          |  2 +-
 include/hw/misc/ivshmem-flat.h                   |  2 +-
 target/s390x/cpu_features_def.h.inc              |  2 +-
 hw/acpi/nvdimm.c                                 |  2 +-
 hw/acpi/pcihp.c                                  |  2 +-
 hw/acpi/vmgenid.c                                |  6 +++---
 hw/misc/ivshmem-flat.c                           |  2 +-
 hw/nvme/ctrl.c                                   |  2 +-
 hw/ppc/spapr.c                                   |  2 +-
 target/arm/cpu.c                                 |  2 +-
 target/s390x/cpu_models_system.c                 |  3 +++
 tests/qtest/vmgenid-test.c                       |  2 +-
 target/loongarch/README                          |  2 +-
 tests/functional/test_aarch64_sbsaref_freebsd.py |  8 ++++----
 16 files changed, 33 insertions(+), 33 deletions(-)


