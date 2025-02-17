Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65355C021A9
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 16:38:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tk48H-000078-7D; Mon, 17 Feb 2025 11:38:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchamart@redhat.com>)
 id 1tk48E-00006V-98
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 11:38:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchamart@redhat.com>)
 id 1tk48B-0007EI-M7
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 11:38:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739810281;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=6tmWoQnR31ab0SOfOf/zp0XJOqEY62yB1ZfgBQboIKg=;
 b=gcjqo3Dwo87EIb0ygESTBphk7VaI+9SQ5+DaSP11+lUWEv4QaIZNECoHlcmWNGgXLoBdQt
 qKTl5zgLRuVyHWJMNoGaUHn/9aUE+8kUQqi/5zAo56FPmMlMe9rz5hpUnruBaYSZ7SJhup
 gO2DHRskNso1qO5ThdP7asQLBd705S8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-93-Fk4vEc8sOrSUDOs_SISWKg-1; Mon,
 17 Feb 2025 11:37:55 -0500
X-MC-Unique: Fk4vEc8sOrSUDOs_SISWKg-1
X-Mimecast-MFC-AGG-ID: Fk4vEc8sOrSUDOs_SISWKg_1739810271
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8358F190F9C9; Mon, 17 Feb 2025 16:37:49 +0000 (UTC)
Received: from gezellig.redhat.com (unknown [10.44.32.23])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C8DF119560AA; Mon, 17 Feb 2025 16:37:34 +0000 (UTC)
From: Kashyap Chamarthy <kchamart@redhat.com>
To: qemu-devel@nongnu.org
Cc: Ninad Palsule <ninad@linux.ibm.com>, sebott@redhat.com, maz@kernel.org,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Tyrone Ting <kfting@nuvoton.com>, Hao Wu <wuhaotsh@google.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Joel Stanley <joel@jms.id.au>, Eric Auger <eric.auger@redhat.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>, Yi Liu <yi.l.liu@intel.com>,
 qemu-arm@nongnu.org, Alexandre Iooss <erdnaxe@crans.org>,
 Kashyap Chamarthy <kchamart@redhat.com>
Subject: [PATCH v2 0/3] docs: Small changes to system/arm/cpu-features and more
Date: Mon, 17 Feb 2025 22:07:26 +0530
Message-ID: <20250217163732.3718617-1-kchamart@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kchamart@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

[
    Resending v2, Peter pointed out that only patches 1 and 2 made it to
    the list; so I'm re-sending with a commit message touch-up:
    s/capitalization/capitaliaztion.

    Alex Bennée reviewed the first two patches that did show up:
    - https://lists.nongnu.org/archive/html/qemu-devel/2025-02/msg02838.html
    - https://lists.nongnu.org/archive/html/qemu-devel/2025-02/msg02837.html
]

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
  docs: Fix "Arm" capitalization

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


