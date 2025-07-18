Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47732C83F34
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Jul 2025 20:03:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucrI5-0001mZ-Me; Fri, 18 Jul 2025 16:02:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1ucqzz-0006Ut-Rt
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 15:44:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1ucqzw-0000Iq-8h
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 15:44:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752867839;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=iZ34fFgdW/kB6BkmBz6HWhxJ/R9s9L86g6Nh3VJWRVw=;
 b=ABy6ZZWMwnU0cUs78KsCKug+jbdvzEsir9EaXxgYEUXxs+ZINwEpa8idJ3ij/RnUi/1COb
 2cP32WL0rLIPZuj8jZQOUXJmtis1PsKz1yEWRzHmmPLtGRw6csT6L06xItih0dL6UAy0tV
 QZ835klhCd0IvB97Kg34Rhg7Ce59rJs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-288-AhNIyl43MD6cDbaa5o_poQ-1; Fri,
 18 Jul 2025 15:43:55 -0400
X-MC-Unique: AhNIyl43MD6cDbaa5o_poQ-1
X-Mimecast-MFC-AGG-ID: AhNIyl43MD6cDbaa5o_poQ_1752867834
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A789518002B1; Fri, 18 Jul 2025 19:43:53 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.32.25])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 96BD930001B9; Fri, 18 Jul 2025 19:43:51 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 678391800082; Fri, 18 Jul 2025 21:43:49 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Sergio Lopez <slp@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Zhao Liu <zhao1.liu@intel.com>, Yanan Wang <wangyanan55@huawei.com>
Subject: [PULL 0/3] Display 20250718 patches
Date: Fri, 18 Jul 2025 21:43:46 +0200
Message-ID: <20250718194349.65771-1-kraxel@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The following changes since commit c079d3a31e45093286c65f8ca5350beb3a4404a9:

  Merge tag 'pull-10.1-rc0-maintainer-140725-1' of https://gitlab.com/stsquad/qemu into staging (2025-07-15 00:12:07 -0400)

are available in the Git repository at:

  https://gitlab.com/kraxel/qemu.git tags/display-20250718-pull-request

for you to fetch changes up to d5fcf0d960d893b1765e6388cefca9c690839267:

  hw/i386: Add the ramfb romfile compatibility (2025-07-18 21:41:57 +0200)

----------------------------------------------------------------
Load ramfb vgabios on x86 only.

----------------------------------------------------------------

Shaoqin Huang (3):
  ramfb: Add property to control if load the romfile
  vfio: Move the TYPE_* to hw/vfio/types.h
  hw/i386: Add the ramfb romfile compatibility

 hw/vfio/pci.h                 | 11 ++---------
 hw/vfio/types.h               | 21 +++++++++++++++++++++
 include/hw/display/ramfb.h    |  2 +-
 hw/core/machine.c             |  2 ++
 hw/display/ramfb-standalone.c |  5 ++++-
 hw/display/ramfb-stubs.c      |  2 +-
 hw/display/ramfb.c            |  6 ++++--
 hw/i386/microvm.c             |  3 +++
 hw/i386/pc_piix.c             | 10 ++++++++++
 hw/i386/pc_q35.c              |  3 +++
 hw/vfio/display.c             |  4 ++--
 hw/vfio/pci.c                 |  2 ++
 12 files changed, 55 insertions(+), 16 deletions(-)
 create mode 100644 hw/vfio/types.h

-- 
2.50.1


