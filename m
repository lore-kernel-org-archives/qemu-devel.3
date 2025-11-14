Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8DB9CDE000
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Nov 2025 03:49:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJknS-0003oY-Hz; Thu, 13 Nov 2025 22:48:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1vJknP-0003Zh-Ab
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 22:48:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1vJknL-0002op-T3
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 22:48:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763092098;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=jFcBCSiH6VaRI6yNeGGWboucHOYpRjr/hSHqb2tj7Wk=;
 b=F97N85K90mHqoIEnOlrgRRvvZs+32u7wytlYsZLvrhb08so7o5nrT9YfZmrr99jxgqy2kW
 +dYo9Z83wYwxB1nlhAoT5D3A+sa8zz6l2ubXEAboUh02a/w7qLu/jCTye4eugzjEqgt98+
 U5RueUPWrglT8t92j1nDlwhd9Zc1V5Q=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-320-G2Ayxy9PNxmON38KhTAV_w-1; Thu,
 13 Nov 2025 22:48:16 -0500
X-MC-Unique: G2Ayxy9PNxmON38KhTAV_w-1
X-Mimecast-MFC-AGG-ID: G2Ayxy9PNxmON38KhTAV_w_1763092095
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 636F919373D8
 for <qemu-devel@nongnu.org>; Fri, 14 Nov 2025 03:48:15 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.120.9])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 489811800451; Fri, 14 Nov 2025 03:48:10 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>
Subject: [PULL 0/5] Net patches
Date: Fri, 14 Nov 2025 11:48:01 +0800
Message-ID: <20251114034806.2440-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The following changes since commit 9febfa94b69b7146582c48a868bd2330ac45037f:

  Merge tag 'for-upstream' of https://repo.or.cz/qemu/kevin into staging (2025-11-12 11:47:42 +0100)

are available in the Git repository at:

  https://github.com/jasowang/qemu.git tags/net-pull-request

for you to fetch changes up to a01344d9d78089e9e585faaeb19afccff2050abf:

  net: pad packets to minimum length in qemu_receive_packet() (2025-11-14 09:59:55 +0800)

----------------------------------------------------------------
-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEIV1G9IJGaJ7HfzVi7wSWWzmNYhEFAmkWo9EACgkQ7wSWWzmN
YhHargf/Uf801PmKskryVENF9sVe6u5NxJZlT3BUJVsSTGitucBIHWZ5J7MMR1lw
If4tfMho3BX5Wrtl5GuCEzolk9pCz3wmSN6nyOU25C5tKaoJ/uR135K25D0CwVmD
eTOyg+gKktVfogXxJ/zwZpRHMq4XXrk/C2ZP41r/CdcLyaeuDS9GIbd/q4N7f3vv
bEsVqECzjEwWr2JBY9SD0xlIRp3nWwEvRsgRZPzBiQzfjSTlImqGLUsxIpF5V2LV
1BU0V/FShWyrwckBXSqCWBUh6uBUGgEl6qKnK4vH7+ed4Kd9giyp1vWAFEjHgIg+
gZtPaT/MJQOtLyCuzfuSdUpAzz5Sfw==
=Is8a
-----END PGP SIGNATURE-----

----------------------------------------------------------------
Jonah Palmer (1):
      net/hub: make net_hub_port_cleanup idempotent

Peter Maydell (4):
      hw/net/e1000e_core: Don't advance desc_offset for NULL buffer RX descriptors
      hw/net/e1000e_core: Correct rx oversize packet checks
      hw/net/e1000e_core: Adjust e1000e_write_payload_frag_to_rx_buffers() assert
      net: pad packets to minimum length in qemu_receive_packet()

 hw/net/e1000e_core.c | 85 ++++++++++++++++++++++++++++++++++++----------------
 net/hub.c            |  8 ++++-
 net/net.c            | 10 +++++++
 3 files changed, 76 insertions(+), 27 deletions(-)



