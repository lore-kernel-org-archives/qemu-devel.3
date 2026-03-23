Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A33BEC01C5
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 10:30:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4cXO-0002z5-SW; Mon, 23 Mar 2026 06:29:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1w4cXJ-0002y8-Dk
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 06:29:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1w4cXG-0008BI-VC
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 06:29:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774261766;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=1rZ2RZ8Na1PWikvdmjM3OJhRUMjMkVshjYUU558Lu6k=;
 b=JroCCul02WWafPfmI8Ghscr67cKSYQbakw2ppLf5FOIkvMTB0VbFYz35AK38gqUuyoT67t
 Lat1KEISt3hw0XJwOFsoey7CXPc5fF83g1Z/w8gFQA06EiUaSFvPutoFDIxJgpNIIAe2Y9
 xargK/UcWG7uEC8DpiQrUcAXTvCtx3c=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-437-e-SN77SGO2ys5MTxBLP2aA-1; Mon,
 23 Mar 2026 06:29:24 -0400
X-MC-Unique: e-SN77SGO2ys5MTxBLP2aA-1
X-Mimecast-MFC-AGG-ID: e-SN77SGO2ys5MTxBLP2aA_1774261763
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8E0701956046; Mon, 23 Mar 2026 10:29:23 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.32.50])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 053B1300019F; Mon, 23 Mar 2026 10:29:21 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: [PULL 0/6] Various fixes for QEMU v11.0-rc1
Date: Mon, 23 Mar 2026 11:29:14 +0100
Message-ID: <20260323102920.25170-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The following changes since commit 8e711856d7639cbffa51405f2cc2366e3d9e3a23:

  Merge tag 'hppa-fixes-for-v11-pull-request' of https://github.com/hdeller/qemu-hppa into staging (2026-03-20 10:04:48 +0000)

are available in the Git repository at:

  https://gitlab.com/thuth/qemu.git tags/pull-request-2026-03-23

for you to fetch changes up to b86eff44ba09b4baea17d2b002afa221de753cc4:

  tests/functional: remove heuristics for finding build dir (2026-03-23 08:16:07 +0100)

----------------------------------------------------------------
* Fix various crashes that can happen when running QEMU with -device xyz,help
* Improve detection of build directory in the functional patches

----------------------------------------------------------------
Daniel P. Berrangé (2):
      tests/functional: fix log placement when run directly
      tests/functional: remove heuristics for finding build dir

Thomas Huth (4):
      hw/pci-host/raven: Fix crash when introspecting raven-pcihost from the CLI
      hw/display/cg3: Fix crash when introspecting cgthree from the CLI
      hw/sparc/sun4m_iommu: Fix crash when introspecting sun4m-iommu from the CLI
      hw/sparc64/sun4u_iommu: Fix crash when introspecting sun4u-iommu from the CLI

 hw/display/cg3.c                     | 18 ++++------
 hw/pci-host/raven.c                  | 68 ++++++++++++++++--------------------
 hw/sparc/sun4m_iommu.c               | 11 +++---
 hw/sparc64/sun4u_iommu.c             | 11 +++---
 tests/functional/meson.build         |  3 +-
 tests/functional/qemu_test/config.py | 13 +++----
 6 files changed, 55 insertions(+), 69 deletions(-)


