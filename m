Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83A2FD7237D
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 12:24:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjGA6-0004ov-0F; Fri, 23 Jan 2026 07:21:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1vjGA4-0004mF-Uv
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 07:21:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1vjGA3-0004zL-6o
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 07:21:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769170870;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=c7AMNOreiZtg9SPqVLdOdumwXoxdxDTqAnkNSqCTVOw=;
 b=PrIzULj64KC1wRnhEt/j5kNvCWHsn6TXo3hzFhFVkcNMEA0AqjsY/VzfOtQ/2qZOdRIdLD
 pwEQ5pi6+zf6UHJP2uXa55VYVS8qSDalB1rVWi5NaBYvCk8B6TOCgKq/IQ3IWx9ESIetrH
 rwIEl7K9CrEMXKwPgPUD3SGx9WXOx+o=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-153-uzDcAvPROa6_XJlgQgqZug-1; Fri,
 23 Jan 2026 07:21:08 -0500
X-MC-Unique: uzDcAvPROa6_XJlgQgqZug-1
X-Mimecast-MFC-AGG-ID: uzDcAvPROa6_XJlgQgqZug_1769170867
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 911B71955DB3
 for <qemu-devel@nongnu.org>; Fri, 23 Jan 2026 12:21:07 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.7])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DA8CA30002D1; Fri, 23 Jan 2026 12:21:05 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>
Subject: [PULL 00/13] Net patches
Date: Fri, 23 Jan 2026 20:20:49 +0800
Message-ID: <20260123122102.51422-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.079,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

The following changes since commit 2339d0a1cfac6ecc667e6e062a593865c1541c35:

  Merge tag 'hw-misc-20260120' of https://github.com/philmd/qemu into staging (2026-01-21 07:39:57 +1100)

are available in the Git repository at:

  https://github.com/jasowang/qemu.git tags/net-pull-request

for you to fetch changes up to 014c06435f96c82d0e0be67832d40be43133dc71:

  tests/qtest: Add test for filter-redirector rx event opened (2026-01-23 14:47:24 +0800)

----------------------------------------------------------------
-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEIV1G9IJGaJ7HfzVi7wSWWzmNYhEFAmlzZqsACgkQ7wSWWzmN
YhGITAf+I46cGYha4dE7Gepbqnk+/eHxURNhToX2yZwWsRBkn4LEWHxavWzYGhTk
acaVL7zPiHG7S33xSUT7Ie3yrLvbpATAlBsa5xbEKS26KAVIzVtsmMJA6jHyKXUX
RKBoX2zUkveMZCDtU0XSPjf/wzf7LyeFEDk/o9Agl5zzqfU3mfe58Zk+9MkpFJ9Y
HEGgocbW4Kuu65RJzesejbrBw0f3PMq8cfktUJ8rj0o5v5MX58hrijBAbE5JLrxG
Z2u1GvMFR4ZA3e+Mmgu5zg2/AZ4/ZrN9c8moxB9DWLVX8Psz4fJwyYm2Hx0ldhf4
4ETQ326nrAZ5REiUTea1FPACBSK7dw==
=TV7k
-----END PGP SIGNATURE-----

----------------------------------------------------------------
Houqi (Nick) Zuo (1):
      net/tap-linux.c: avoid abort when setting invalid fd

Jason Wang (5):
      net/filter-buffer: make interval change take effect immediately
      tests/qtest: add test for filter-buffer interval change
      net/filter-redirector: add support for dynamic status on/off switching
      qtest: add a test to test redirector status change
      tests/qtest: Add test for filter-redirector rx event opened

Vladimir Sementsov-Ogievskiy (7):
      net/tap: net_init_tap_one(): drop extra error propagation
      net/tap: net_init_tap_one(): move parameter checking earlier
      net/tap: pass NULL to net_init_tap_one() in cases when scripts are NULL
      net/tap: rework scripts handling
      net/tap: setup exit notifier only when needed
      net/tap: tap_set_sndbuf(): add return value
      net/tap: rework tap_set_sndbuf()

 net/filter-buffer.c                  |   6 +
 net/filter-mirror.c                  |  38 ++++-
 net/tap-bsd.c                        |   3 +-
 net/tap-linux.c                      |  28 ++--
 net/tap-solaris.c                    |   3 +-
 net/tap-stub.c                       |   3 +-
 net/tap.c                            |  94 ++++++------
 net/tap_int.h                        |   3 +-
 tests/qtest/meson.build              |   1 +
 tests/qtest/test-filter-buffer.c     | 169 ++++++++++++++++++++
 tests/qtest/test-filter-redirector.c | 288 +++++++++++++++++++++++++++++++++++
 11 files changed, 564 insertions(+), 72 deletions(-)
 create mode 100644 tests/qtest/test-filter-buffer.c



