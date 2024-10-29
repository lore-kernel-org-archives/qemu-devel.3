Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C95CDD5B164
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 08:09:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5hG7-00078Y-WB; Tue, 29 Oct 2024 04:07:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1t5hG5-00077y-7M
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 04:07:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1t5hG3-0003vJ-IH
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 04:07:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730189233;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=xRGU1/PKHnT+zecFiTMSRSVysT1vsqIO0bA5hROvo5I=;
 b=RxXW7q7eosGePrq5hwyGs79t/hnjeMXebld6LAJNkdLgFb4x8Iez7wD8dwqMFZ/WNEnbiU
 N2bia9fmqFciZ8V9XKK7LvCiEeGEPIRWXwjVsDEks8lzeXZDAORsiigGtRrH15xANfqTZG
 ql1hYurdDoiQxw5zKtX4YNOGv4OmuiM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-479-HpUasczWPByrchTzLtMj6w-1; Tue,
 29 Oct 2024 04:07:12 -0400
X-MC-Unique: HpUasczWPByrchTzLtMj6w-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D32091955BD0
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2024 08:07:10 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.36])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 24D241956086; Tue, 29 Oct 2024 08:07:07 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>
Subject: [PULL 00/14] Net patches
Date: Tue, 29 Oct 2024 16:06:51 +0800
Message-ID: <20241029080705.3238-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.373,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

The following changes since commit cea8ac78545a83e1f01c94d89d6f5a3f6b5c05d2:

  Merge tag 'pull-aspeed-20241024' of https://github.com/legoater/qemu into staging (2024-10-25 13:35:22 +0100)

are available in the Git repository at:

  https://github.com/jasowang/qemu.git tags/net-pull-request

for you to fetch changes up to cd76e8fcbe1a340776ae61b4e182be3a45b26219:

  virtio-net: Avoid indirection_table_mask overflow (2024-10-29 15:53:29 +0800)

----------------------------------------------------------------
-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEIV1G9IJGaJ7HfzVi7wSWWzmNYhEFAmcglKYACgkQ7wSWWzmN
YhEm/wf/cYA7i3asKMUoYqlff5mBiY3aFCWzTR5qHLBcWfnB33f9FYpAW6RgDwMa
3aFAJm1VZAynmUWgz+f537+e+7900M+P54zbD7kHCthAy7l/E7t9SkKNpe6jZHEA
P4hB09CSKm/TY1XtsFMvO5tkF9IgY51VEO+mZJesO1H2X2+3ulJYusx9fh/P6yST
bG8sbXr55v23R3z4UOovqfkuskPETwRh3qoiOLPPBy8CWkBVze8J+siC7HC+eFIo
KrQ+jhUYpIK8CAgHV09ZnlurLo6UZ0+vlo9IcJN+GQp/gsmg8OErjvzPdKKbynC/
1zjvkgyW27aHsei+baTMXGCE0P8dIw==
=6+yo
-----END PGP SIGNATURE-----

----------------------------------------------------------------
Akihiko Odaki (2):
      net: Check if nc is NULL in qemu_get_vnet_hdr_len()
      virtio-net: Avoid indirection_table_mask overflow

Bernhard Beschow (1):
      net/tap-win32: Fix gcc 14 format truncation errors

Daniel P. Berrangé (8):
      net: fix build when libbpf is disabled, but libxdp is enabled
      hw/net: fix typo s/epbf/ebpf/ in virtio-net
      ebpf: drop redundant parameter checks in static methods
      ebpf: improve error trace events
      ebpf: add formal error reporting to all APIs
      hw/net: report errors from failing to use eBPF RSS FDs
      ebpf: improve trace event coverage to all key operations
      hw/net: improve tracing of eBPF RSS setup

Daniil Tatianin (2):
      net/stream: deprecate 'reconnect' in favor of 'reconnect-ms'
      chardev: finalize 'reconnect' deprecation

Stefan Weil (1):
      Fix calculation of minimum in colo_compare_tcp

 docs/COLO-FT.txt              |   4 +-
 docs/about/deprecated.rst     |  10 ++++
 docs/system/ppc/powernv.rst   |   2 +-
 ebpf/ebpf_rss-stub.c          |   8 +--
 ebpf/ebpf_rss.c               | 118 +++++++++++++++++++++++++++---------------
 ebpf/ebpf_rss.h               |  10 ++--
 ebpf/trace-events             |   8 ++-
 hw/net/trace-events           |   8 +--
 hw/net/virtio-net.c           |  75 +++++++++++++++++----------
 meson.build                   |  10 +++-
 net/colo-compare.c            |   3 +-
 net/meson.build               |   2 +-
 net/net.c                     |   4 ++
 net/stream.c                  |  34 +++++++-----
 net/tap-win32.c               |  15 +++---
 qapi/net.json                 |  13 ++++-
 qemu-options.hx               |  46 ++++++++--------
 tests/qtest/ipmi-bt-test.c    |   2 +-
 tests/qtest/netdev-socket.c   |   2 +-
 tests/qtest/vhost-user-test.c |   2 +-
 tests/unit/test-char.c        |   8 +--
 21 files changed, 245 insertions(+), 139 deletions(-)



