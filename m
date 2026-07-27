Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97048C531D0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 12:52:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woKou-0008Su-J4; Mon, 27 Jul 2026 08:52:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1woKoa-0008OI-Hn
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 08:52:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1woKoY-0004XN-LX
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 08:52:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785156733;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=XcU9hNI93U5awBSFgTAMsBUOFLGSr8Kjn3JGiFCSwwc=;
 b=Lp8mlktO4em/P2Rj14o44Spf8VaozBgwQnKvvQEs7Lh9y04/lbDuS9ghUme5o1eFWh0SFy
 PQC9wHjmxVI6JYD48py9VAMne8+LpghYXnpQCzZWEWTvflOYFMGzeBqG32HyynQ/vaqy9U
 2ENHWQNmQ5QFvogD34LxZ3TuYd1CfbE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-593-eM9bJljQPkaj6Gw20ffDDA-1; Mon,
 27 Jul 2026 08:52:12 -0400
X-MC-Unique: eM9bJljQPkaj6Gw20ffDDA-1
X-Mimecast-MFC-AGG-ID: eM9bJljQPkaj6Gw20ffDDA_1785156731
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CE51D1955EA5
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 12:52:10 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.48.178])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9C3D61955F7F; Mon, 27 Jul 2026 12:52:09 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 0/5] Various fixes for 11.1-rc2
Date: Mon, 27 Jul 2026 14:52:02 +0200
Message-ID: <20260727125207.646148-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

 Hi Stefan!

The following changes since commit 6333226c2abb72f31648c251624c56e70993d625:

  Merge tag 'pull-9p-20260725' of https://github.com/cschoenebeck/qemu into staging (2026-07-26 08:30:07 -0400)

are available in the Git repository at:

  https://gitlab.com/thuth/qemu.git tags/pull-request-2026-07-27

for you to fetch changes up to 92abc3c51ebb3223a6fdb5bd3414b2943d7653b2:

  hw/usb/hcd-xhci: Check return value of xhci_xfer_create_sgl() for errors (2026-07-27 13:00:45 +0200)

----------------------------------------------------------------
* Validate bounds in CXL "Set Feature" payloads
* Fix guest-triggerable heap OOB access in "usb-uas" device
* Fix possible crash via NULL pointer in ide_cancel_dma_sync()
* Avoid possible assert() usb_packet_copy()
* Check return value of xhci_xfer_create_sgl() for errors

----------------------------------------------------------------
Feifan Qian (1):
      hw/cxl: Validate Set Feature payload bounds

Thomas Huth (4):
      hw/usb/dev-uas: Fix guest-triggerable heap OOB access
      hw/ide/core: Fix possible crash via NULL pointer in ide_cancel_dma_sync()
      hw/usb/core: Avoid possible assert() in do_parameter() --> usb_packet_copy()
      hw/usb/hcd-xhci: Check return value of xhci_xfer_create_sgl() for errors

 hw/cxl/cxl-mailbox-utils.c | 24 ++++++++++++++++++++++++
 hw/ide/core.c              |  9 ++++++++-
 hw/usb/core.c              | 10 ++++++++++
 hw/usb/dev-uas.c           | 29 ++++++++++++++++++++---------
 hw/usb/hcd-xhci.c          | 10 +++++++---
 5 files changed, 69 insertions(+), 13 deletions(-)


