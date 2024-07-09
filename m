Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7022DC3DA41
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 11:54:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sR9Ou-0000g5-AN; Tue, 09 Jul 2024 07:52:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sR9Os-0000Fn-01
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 07:52:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sR9On-0006UB-UN
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 07:52:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720525955;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=tFbZlbAPq14JSYGSgHWHrMHgaSNG1BMaQNHUf1dKK/M=;
 b=dOTw+bQD6qPrm8mCNpBfGvpaI9vtWD0PNRM+x98WRauHwOv3nVM5fhq/+RUHchOa4+6F9r
 1D5Uh4H1RHHVtevKZLCEzkGYSUKxk5NZafgSV4PpRD9hn6dRb2+eodxUCvOwNpi2rjQcER
 h2lajoWY38n4OoxGcikV1dPqcZDWE5Y=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-477-ieJyBd8oOl6ls5KWyNOMoQ-1; Tue,
 09 Jul 2024 07:52:33 -0400
X-MC-Unique: ieJyBd8oOl6ls5KWyNOMoQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5593D1955F43; Tue,  9 Jul 2024 11:52:32 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.193.243])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E6B7F3000183; Tue,  9 Jul 2024 11:52:30 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 0/8] aspeed queue
Date: Tue,  9 Jul 2024 13:52:20 +0200
Message-ID: <20240709115228.798904-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The following changes since commit 44b7329de469c121555a1acf9b288f3ae71b8e61:

  Merge tag 'pull-qapi-2024-07-06' of https://repo.or.cz/qemu/armbru into staging (2024-07-07 13:23:28 -0700)

are available in the Git repository at:

  https://github.com/legoater/qemu/ tags/pull-aspeed-20240709

for you to fetch changes up to d847ea7cfc6321e2519f587d4077428d90557178:

  machine_aspeed.py: update to test network for AST2700 (2024-07-09 08:05:44 +0200)

----------------------------------------------------------------
aspeed queue:

* support AST2700 network

----------------------------------------------------------------
Jamin Lin (8):
      hw/net:ftgmac100: update memory region size to 64KB
      hw/net:ftgmac100: update ring base address to 64 bits
      hw/net:ftgmac100: introduce TX and RX ring base address high registers to support 64 bits
      hw/net:ftgmac100: update TX and RX packet buffers address to 64 bits
      aspeed/soc: set dma64 property for AST2700 ftgmac100
      hw/block: m25p80: support quad mode for w25q01jvq
      machine_aspeed.py: update to test ASPEED OpenBMC SDK v09.02 for AST2700
      machine_aspeed.py: update to test network for AST2700

 include/hw/net/ftgmac100.h      |  17 +++--
 hw/arm/aspeed_ast27x0.c         |   3 +
 hw/block/m25p80.c               |  16 +++++
 hw/net/ftgmac100.c              | 147 +++++++++++++++++++++++++++++++++-------
 tests/avocado/machine_aspeed.py |  12 ++--
 5 files changed, 162 insertions(+), 33 deletions(-)


