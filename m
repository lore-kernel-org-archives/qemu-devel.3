Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C314C36010
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Apr 2025 12:14:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzaVL-0007cy-ME; Tue, 01 Apr 2025 08:14:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tzaV3-0007YH-LX
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 08:13:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tzaV1-0007rk-FE
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 08:13:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743509625;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=z7YzhWpL1hJtAG+D+c5L3yyWhN/Mh1HbDqfui5xAhHY=;
 b=O3/QoQrjU/ry8WhToPD2z6riSzO0Co4h0owojuB9WfKbjUoYU5JOicWN3a9C191lWEbuEm
 EmALZ88533m0wrwZ65ISSwec4j41ODP+qB4g5yizyzY7RBlL9Gc+B+lnYArlv4I41yYQyF
 2+cdTwQwu0+bNgHelnFSTDo0HcO20OQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-62-Xz8e8imqO2iU_mShv7Rxag-1; Tue,
 01 Apr 2025 08:13:42 -0400
X-MC-Unique: Xz8e8imqO2iU_mShv7Rxag-1
X-Mimecast-MFC-AGG-ID: Xz8e8imqO2iU_mShv7Rxag_1743509621
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 142EA19560B3; Tue,  1 Apr 2025 12:13:41 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.20])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3ECC6180A803; Tue,  1 Apr 2025 12:13:38 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 0/2] aspeed queue
Date: Tue,  1 Apr 2025 14:13:34 +0200
Message-ID: <20250401121336.788924-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.997,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The following changes since commit 0f15892acaf3f50ecc20c6dad4b3ebdd701aa93e:

  Merge tag 'pull-riscv-to-apply-20250328' of https://github.com/alistair23/qemu into staging (2025-03-28 08:06:53 -0400)

are available in the Git repository at:

  https://github.com/legoater/qemu/ tags/pull-aspeed-20250401

for you to fetch changes up to 20ab88a9066bcacc28acbd7cbe2c617d90bfb27e:

  hw/misc/aspeed_scu: Correct minimum access size for AST2500 / AST2600 (2025-04-01 11:29:25 +0200)

----------------------------------------------------------------
aspeed queue:

* Fixed SCU access size on AST2500 and AST2600 SoCs

----------------------------------------------------------------
Joel Stanley (1):
      hw/misc/aspeed_scu: Correct minimum access size for AST2500 / AST2600

Philippe Mathieu-Daudé (1):
      hw/misc/aspeed_scu: Set MemoryRegionOps::impl::access_size to 32-bit

 hw/misc/aspeed_scu.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)


