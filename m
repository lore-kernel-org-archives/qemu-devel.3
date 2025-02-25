Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F792C021BE
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 20:05:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tn1AW-0005Yw-GH; Tue, 25 Feb 2025 15:04:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tn1AU-0005YJ-B9
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 15:04:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tn1AS-0003zp-4y
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 15:04:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740513875;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=iuWHyO8bxl5mtkUxjUyRQaGhT8WtBJ55DaYKzmJrinU=;
 b=P9WZMm3roySftSKSqMJ5k+fjUjy/M3LaR5yJUYLVZgfpmItvkv/wIM/3pbEqG8m9K5+1Av
 8gJF6+cbY7Wq5/MTkxE+rkBCh1ZllYTrvU+897fc4R4disJI2C4X6iwyPb8mwcFbqgFPZS
 W7gspNpGEzrOXs4P7/Q8TwawD1m42us=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-614-x-d9V9wlPxauEJCRCPAhXQ-1; Tue,
 25 Feb 2025 15:04:30 -0500
X-MC-Unique: x-d9V9wlPxauEJCRCPAhXQ-1
X-Mimecast-MFC-AGG-ID: x-d9V9wlPxauEJCRCPAhXQ_1740513869
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DD95619039C6; Tue, 25 Feb 2025 20:04:28 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.59])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E61D71800357; Tue, 25 Feb 2025 20:04:24 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 0/4] docs: automated info about machine deprecation/removal
 info
Date: Tue, 25 Feb 2025 20:04:19 +0000
Message-ID: <20250225200423.2350471-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
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

Since we deprecate and remove versioned machine types on a fixed
schedule, we can automatically ensure that the docs reflect the
latest version info, rather than requiring manual updates on each
dev cycle.

The first patch in this series fixes the logic to ensure dev snapshots
and release candidates don't have an off-by-1 error in setting
deprecation and removal thresholds - they must predict the next formal
release version number.

The remaining patches deal with the docs stuff.

The first two patches can be applied in this release (10.0) if desired.

The third patch documents deletion logic that doesn't come into effect
until the 10.1.0 release is out, so we shouldn't include that commit
in 10.0.0. It can be applied after the following is reverted:

  commit c9fd2d9a48ee3c195cf83cc611b87b09f02f0013
  Author: Daniel P. Berrangé <berrange@redhat.com>
  Date:   Thu Jun 20 17:57:37 2024 +0100

    include/hw: temporarily disable deletion of versioned machine types

    The new deprecation and deletion policy for versioned machine types is
    being introduced in QEMU 9.1.0.

    Under the new policy a number of old machine types (any prior to 2.12)
    would be liable for immediate deletion which would be a violation of our
    historical deprecation and removal policy

    Thus automatic deletions (by skipping QOM registration) are temporarily
    gated on existance of the env variable "QEMU_DELETE_MACHINES" / QEMU
    version number >= 10.1.0. This allows opt-in testing of the automatic
    deletion logic, while activating it fully in QEMU >= 10.1.0.

    This whole commit should be reverted in the 10.1.0 dev cycle or shortly
    thereafter.

Daniel P. Berrangé (4):
  include/hw/boards: cope with dev/rc versions in deprecation checks
  docs/about/deprecated: auto-generate a note for versioned machine
    types
  docs/about/removed-features: auto-generate a note for versioned
    machine types
  include/hw/boards: add warning about changing deprecation logic

 docs/about/deprecated.rst       |  7 ++++++
 docs/about/removed-features.rst | 10 +++++----
 docs/conf.py                    | 39 ++++++++++++++++++++++++++++++++-
 include/hw/boards.h             | 39 +++++++++++++++++++++++++++++++--
 4 files changed, 88 insertions(+), 7 deletions(-)

-- 
2.47.1


