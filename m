Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C3D910D14A4
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 11:50:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7B7f-0002OJ-7a; Mon, 30 Mar 2026 07:49:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1w7B7K-0002Kj-Et
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 07:49:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1w7B7G-0005b4-M1
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 07:49:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774871339;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=4jE+ZYiBrnOR0/wEXwh1m8IxQyar2F5yvKNyUAoO6L0=;
 b=gsAjBC3DJXcVR5E8iAhWEn9toizKs7lPV3ZwqwtkBVVyCw9CGHU10KHeB1vDj2+AXhSW2z
 bkziVXRqaq+b6K+sEpKt+goPxQJxmpuQDn+olDWzsa1L83pMoZhQH63HuiDSBjEIkQn9wU
 n9CP+Um2YQg1q/fwA3VXaGm2zEACNjI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-649-LyNTwu3oMZafzkVwBLkd1g-1; Mon,
 30 Mar 2026 07:48:57 -0400
X-MC-Unique: LyNTwu3oMZafzkVwBLkd1g-1
X-Mimecast-MFC-AGG-ID: LyNTwu3oMZafzkVwBLkd1g_1774871337
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E42531800BEA; Mon, 30 Mar 2026 11:48:56 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.47])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 815021800361; Mon, 30 Mar 2026 11:48:55 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 0/2] aspeed queue
Date: Mon, 30 Mar 2026 13:48:51 +0200
Message-ID: <20260330114853.638753-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The following changes since commit 91f6a9cb1b0f11afa74ef7fb20d5579d9dfbe020:

  Merge tag 'qga-pull-2026-03-27' of https://github.com/kostyanf14/qemu into staging (2026-03-27 18:41:05 +0000)

are available in the Git repository at:

  https://github.com/legoater/qemu/ tags/pull-aspeed-20260330

for you to fetch changes up to 9160305d92d2750e6ca3ada8f048305c9290f03c:

  net/ftgmac100: preserve full VLAN TCI in TX tag insertion (2026-03-30 07:36:25 +0200)

----------------------------------------------------------------
aspeed queue:

* Complete lost interrupts fix in the Aspeed I2C model
* Fix a vlan tag insertion issue in the ftgmac100 model

----------------------------------------------------------------
GuoHan Zhao (1):
      hw/i2c/aspeed_i2c: reset and migrate pending_intr_sts

linhuang (1):
      net/ftgmac100: preserve full VLAN TCI in TX tag insertion

 hw/i2c/aspeed_i2c.c | 4 +++-
 hw/net/ftgmac100.c  | 2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)


