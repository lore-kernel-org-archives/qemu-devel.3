Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE02AC0219D
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2025 13:52:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiZcY-0001dL-Fn; Thu, 13 Feb 2025 08:51:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchamart@redhat.com>)
 id 1tiZcN-0001cI-B8
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 08:51:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchamart@redhat.com>)
 id 1tiZcL-0001I9-6W
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 08:51:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739454660;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=9y3iX25JXzJV4LsWdCKwdpyFNIF9HsTeFE8wOHwrl9Y=;
 b=RT3KtGXrsQTa6od+wFQePFvPOTVnRTlo5tQrYd+MurHf7beuPI+zI/NoT7OXicE++w/C+j
 doILWU4R3gp4llXBBl55+ypPgj4LRsjMC8QgxD0Ucn6G3omFKI/3SPNtqzC1I7DtkYP4eE
 aRre0RXREv8dSVVkoz4mq4ppUm2qhIQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-278-ZyrfqnmMM5mP6QUbieqWpQ-1; Thu,
 13 Feb 2025 08:50:56 -0500
X-MC-Unique: ZyrfqnmMM5mP6QUbieqWpQ-1
X-Mimecast-MFC-AGG-ID: ZyrfqnmMM5mP6QUbieqWpQ_1739454654
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DF188180087C; Thu, 13 Feb 2025 13:50:51 +0000 (UTC)
Received: from gezellig.redhat.com (unknown [10.45.242.15])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B6A22300018D; Thu, 13 Feb 2025 13:50:34 +0000 (UTC)
From: Kashyap Chamarthy <kchamart@redhat.com>
To: qemu-devel@nongnu.org
Cc: maz@kernel.org, Joel Stanley <joel@jms.id.au>,
 Ninad Palsule <ninad@linux.ibm.com>, qemu-arm@nongnu.org,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Eric Auger <eric.auger@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 Hao Wu <wuhaotsh@google.com>, Tyrone Ting <kfting@nuvoton.com>,
 sebott@redhat.com, Steven Lee <steven_lee@aspeedtech.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Troy Lee <leetroy@gmail.com>, Alistair Francis <alistair@alistair23.me>,
 Kashyap Chamarthy <kchamart@redhat.com>
Subject: [PATCH v2 0/3] docs: Small changes to system/arm/cpu-features and more
Date: Thu, 13 Feb 2025 14:50:28 +0100
Message-ID: <20250213135032.2987289-1-kchamart@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kchamart@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.495,
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

In v2:

  - Add live-migration context to the PAuth docs (Marc Zyngier)

  - Fix the Arm capitlalization (Peter Maydell)
    (See:
    https://lists.gnu.org/archive/html/qemu-devel/2025-01/msg05137.html)

    * * *

v1 cover letter:

One is a trivial, mechanical change to consistenlty use "vCPU".  The
other updates some details about the "PAuth" (Pointer Authentication)
feature.

I replaced the "TCG vCPU Features" heading with "PAuth" because of this:
before this change, the section says, it is about "CPU features that are
specific to TCG".  But it has only PAuth-related parameters under it.
Since PAuth is relevant to both KVM and TCG, I moved them under a
separate PAuth section, instead of duplicating it.

But now we have a small inconsistency - there's a KVM-only CPU features
section, but no TCG-only section.  I thought when there are more
TCG-only CPU features, that section can be added back in.  Or I can add
that back in, if anyone feels strongly about it.

Kashyap Chamarthy (3):
  docs/cpu-features: Consistently use vCPU instead of VCPU
  docs/cpu-features: Update "PAuth" (Pointer Authentication) details
  docs: Fix "Arm" capitaliaztion

 docs/devel/testing/qgraph.rst        |  8 ++--
 docs/devel/vfio-iommufd.rst          |  2 +-
 docs/specs/fsi.rst                   |  2 +-
 docs/system/arm/aspeed.rst           |  6 +--
 docs/system/arm/b-l475e-iot01a.rst   |  2 +-
 docs/system/arm/cpu-features.rst     | 60 +++++++++++++++++++++++-----
 docs/system/arm/nrf.rst              |  4 +-
 docs/system/arm/nuvoton.rst          |  4 +-
 docs/system/arm/stm32.rst            | 12 +++---
 docs/system/arm/xlnx-versal-virt.rst | 12 +++---
 docs/system/arm/xlnx-zynq.rst        |  2 +-
 docs/system/guest-loader.rst         |  2 +-
 12 files changed, 77 insertions(+), 39 deletions(-)

-- 
2.48.1


