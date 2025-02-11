Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75062C0219B
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 12:32:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thpQh-0005c7-LM; Tue, 11 Feb 2025 07:31:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1thpQg-0005bw-NG
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 07:31:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1thpQe-00008g-J2
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 07:31:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739277111;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=DtRDehF3IOMShnBDmD3Hmy1q9Qgm6IIukomYBRCaDsk=;
 b=gTIKKUNv35xlk9cgWywhacI9zQChNrd52wXcU1S6816C3hbhWAOM4tWMfPtpbcrEQTA1JD
 QxCb/MsCj/abxbZa+p3/3dQ+B5y5uIUMZ/w/5mrELVtLW6syF/DvDcRkdE8FtVVBHOiBvf
 ZxivPW2HQT7XClTRIOnPXUDa434Qv10=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-653-AASq78p4Ode2EUoQO72xAQ-1; Tue,
 11 Feb 2025 07:31:49 -0500
X-MC-Unique: AASq78p4Ode2EUoQO72xAQ-1
X-Mimecast-MFC-AGG-ID: AASq78p4Ode2EUoQO72xAQ
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4EE4E1800373
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2025 12:31:48 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.52])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BC8C01954B00; Tue, 11 Feb 2025 12:31:46 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 0/7] Functional tests and Gitlab-CI patches
Date: Tue, 11 Feb 2025 13:31:37 +0100
Message-ID: <20250211123144.37617-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.54,
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

The following changes since commit 54e91d1523b412b4cff7cb36c898fa9dc133e886:

  Merge tag 'pull-qapi-2025-02-10-v2' of https://repo.or.cz/qemu/armbru into staging (2025-02-10 10:47:31 -0500)

are available in the Git repository at:

  https://gitlab.com/thuth/qemu.git tags/pull-request-2025-02-11

for you to fetch changes up to 66a1b4991c32e370a4e0ddabf496aa1563aff286:

  gitlab-ci.d/cirrus: Update the FreeBSD job to v14.2 (2025-02-11 13:27:07 +0100)

----------------------------------------------------------------
* Convert more avocado tests to the functional framework
* Add a test for the sam460ex machine
* Fix the broken FreeBSD CI job by updating it to the latest version

----------------------------------------------------------------
Cédric Le Goater (1):
      tests/functional: Add a ppc sam460ex test

Daniel P. Berrangé (2):
      gitlab: don't fail cirrus CI jobs when credits are exhausted
      gitlab: use new(ish) cirrus-vars command for creating config

Thomas Huth (4):
      tests/functional: Convert the aarch64 xen test to the functional framework
      tests/functional/test_aarch64_virt: Fix vulkan test without egl-headless
      tests/functional: Convert the hotplug_blk avocado test
      gitlab-ci.d/cirrus: Update the FreeBSD job to v14.2

 MAINTAINERS                                 |  4 +-
 .gitlab-ci.d/cirrus.yml                     | 27 ++------
 .gitlab-ci.d/cirrus/build.yml               |  2 +-
 tests/avocado/boot_xen.py                   | 95 -----------------------------
 tests/avocado/hotplug_blk.py                | 69 ---------------------
 tests/functional/meson.build                |  3 +
 tests/functional/test_aarch64_virt.py       |  2 +
 tests/functional/test_aarch64_xen.py        | 90 +++++++++++++++++++++++++++
 tests/functional/test_ppc_sam460ex.py       | 38 ++++++++++++
 tests/functional/test_x86_64_hotplug_blk.py | 85 ++++++++++++++++++++++++++
 10 files changed, 228 insertions(+), 187 deletions(-)
 delete mode 100644 tests/avocado/boot_xen.py
 delete mode 100644 tests/avocado/hotplug_blk.py
 create mode 100755 tests/functional/test_aarch64_xen.py
 create mode 100644 tests/functional/test_ppc_sam460ex.py
 create mode 100755 tests/functional/test_x86_64_hotplug_blk.py


