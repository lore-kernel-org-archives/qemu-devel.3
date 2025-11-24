Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4A02CFD31C
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Nov 2025 07:07:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNQeM-0001Yr-4M; Mon, 24 Nov 2025 02:06:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vNQdz-0001Ss-C0
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 02:05:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vNQds-00033A-Sg
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 02:05:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763967934;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=gIUlSKS9XZiz3+fgOeSkoIgHFzFDNH0vEB6TzK4uR6U=;
 b=Cvo2Lefef8iSFSORvD7GSimQ7QSS5mLX2hwhI2LWuxD0KnKPbUvxPbGbTIqd4BbX8dg6EP
 AHUcwnAP9dZN1TLVgMzm+MmqloHL2SCnpCkNxkU48mBIa5UDbmUOGKCWHy7UdJEOBsiOID
 GqDupBXXeBV9wDZ3n4YFr6QzynIRemU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-157-T2UWoswzPKCVXuouMjQ3kg-1; Mon,
 24 Nov 2025 02:05:30 -0500
X-MC-Unique: T2UWoswzPKCVXuouMjQ3kg-1
X-Mimecast-MFC-AGG-ID: T2UWoswzPKCVXuouMjQ3kg_1763967930
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C07091956096; Mon, 24 Nov 2025 07:05:29 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.24])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 249E618004A3; Mon, 24 Nov 2025 07:05:27 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 0/3] aspeed queue
Date: Mon, 24 Nov 2025 08:05:21 +0100
Message-ID: <20251124070524.240618-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.161,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The following changes since commit fb241d0a1fd36a1b67ecced29d8b533316cf9e2d:

  Merge tag 'staging-pull-request' of https://gitlab.com/peterx/qemu into staging (2025-11-23 11:46:53 -0800)

are available in the Git repository at:

  https://github.com/legoater/qemu/ tags/pull-aspeed-20251124

for you to fetch changes up to e9a8b04dbb98fba7942b23b3ac5c35f2f0b9c4a0:

  hw/pci-host/aspeed_pcie: Update ASPEED PCIe Root Port capabilities and enable MSI to support hotplug (2025-11-24 07:52:42 +0100)

----------------------------------------------------------------
aspeed queue:

* Fixed typo in the AST2700 LTPI device
* Fixed missing wiring of the SPI IRQ in AST10x0, AST2600, AST2700 SoCs
* Updated ASPEED PCIe Root Port capabilities and MSI support

----------------------------------------------------------------
Jamin Lin (2):
      hw/arm/aspeed: Fix missing SPI IRQ connection causing DMA interrupt failure
      hw/pci-host/aspeed_pcie: Update ASPEED PCIe Root Port capabilities and enable MSI to support hotplug

Nabih Estefan (1):
      hw/arm/ast27x0: Fix typo in LTPI address

 hw/arm/aspeed_ast10x0.c   |  2 ++
 hw/arm/aspeed_ast2600.c   |  2 ++
 hw/arm/aspeed_ast27x0.c   |  4 +++-
 hw/pci-host/aspeed_pcie.c | 40 +++++++++++++++++++++++++++++++++++++++-
 4 files changed, 46 insertions(+), 2 deletions(-)


