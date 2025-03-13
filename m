Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB28CC28B28
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 08:02:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsdVi-00045A-4D; Thu, 13 Mar 2025 04:01:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tsdVf-000450-Qp
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 04:01:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tsdVd-0007gd-Vc
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 04:01:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741852900;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=x4xTcEnJS4yA0jJP5uf9PTlIf90UvF/iCAJGWeJ6KWw=;
 b=SyyzKlozh6gF8/bwRyuXqOazx9sJ9o77w6gr1URJFNf+8NatFtR7iksDXT4Feacme2WNBg
 4e82l6TDwBkVH1sJ+SdDiieabVmDHI/VTDOaYpleCo0QCN59fKPxvlltFno82nBFcOmu3x
 68oUbTjSCZ+6uFFPEcLZk28rqlR9Jjs=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-498-stMakKJrP-y68yl267gNOg-1; Thu,
 13 Mar 2025 04:01:37 -0400
X-MC-Unique: stMakKJrP-y68yl267gNOg-1
X-Mimecast-MFC-AGG-ID: stMakKJrP-y68yl267gNOg_1741852897
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EDFFE180AF5E
 for <qemu-devel@nongnu.org>; Thu, 13 Mar 2025 08:01:36 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.26])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8E75B1955F2D; Thu, 13 Mar 2025 08:01:33 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 0/8] Fixes for functional tests
Date: Thu, 13 Mar 2025 09:01:24 +0100
Message-ID: <20250313080132.1467625-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

The following changes since commit 825b96dbcee23d134b691fc75618b59c5f53da32:

  Merge tag 'migration-20250310-pull-request' of https://gitlab.com/farosas/qemu into staging (2025-03-11 09:32:07 +0800)

are available in the Git repository at:

  https://gitlab.com/thuth/qemu.git tags/pull-request-2025-03-13

for you to fetch changes up to b3c03666fb10b4900e5bbff0a2b403731730e637:

  tests/functional: skip vulkan test if missing vulkaninfo (2025-03-13 08:18:26 +0100)

----------------------------------------------------------------
* Various fixes for functional tests
* Fix the name of the "configs" directory in the documentation

----------------------------------------------------------------
Alex Bennée (1):
      tests/functional: skip vulkan test if missing vulkaninfo

Cédric Le Goater (1):
      tests/functional: Require 'user' netdev for ppc64 e500 test

Greg Kurz (1):
      docs: Rename default-configs to configs

Nicholas Piggin (3):
      tests/functional/asset: Fail assert fetch when retries are exceeded
      tests/functional/asset: Verify downloaded size
      tests/functional/asset: Add AssetError exception class

Peter Maydell (1):
      tests/functional: Bump up arm_replay timeout

Thomas Huth (1):
      docs/system: Fix the information on how to run certain functional tests

 docs/devel/build-system.rst               | 10 +++---
 docs/devel/kconfig.rst                    | 16 ++++-----
 docs/system/arm/bananapi_m2u.rst          |  5 ++-
 docs/system/arm/orangepi.rst              |  6 ++--
 docs/system/devices/igb.rst               |  4 +--
 tests/functional/meson.build              |  1 +
 tests/functional/qemu_test/asset.py       | 58 +++++++++++++++++++++++--------
 tests/functional/test_aarch64_virt_gpu.py |  1 +
 tests/functional/test_ppc64_e500.py       |  1 +
 9 files changed, 67 insertions(+), 35 deletions(-)


