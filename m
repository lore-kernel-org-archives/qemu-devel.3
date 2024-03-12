Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F980C54E60
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 11:37:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk0RW-0007Ib-RG; Tue, 12 Mar 2024 07:37:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rk0RF-0007Eu-5m
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 07:36:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rk0R9-00037g-Gb
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 07:36:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710243408;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=XUnJ9YXC8+JVl4R7Ep7cwjws40H8qie0n58QFF04tJQ=;
 b=g+3O2WoxyGqA5n624qi3NDR3XVrG+ypdQeISAabtBpZ43B/grNsQQIX17ws58ZMcd8Ibhm
 cbgzcd2BHe9ziS+qXoqRNf0KJBcP4o1npZt5pTxGDMHtSv3/2ch5YlOGPeKUQdXGsFqPDW
 sRUYfYmL8Rq4GCi1w8Hq0w2rpn7bGy0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-255-ZGpOXUiKOC6PRzjMfN-raw-1; Tue,
 12 Mar 2024 07:36:47 -0400
X-MC-Unique: ZGpOXUiKOC6PRzjMfN-raw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BC18E2800C40;
 Tue, 12 Mar 2024 11:36:46 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.61])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E7E30492BC7;
 Tue, 12 Mar 2024 11:36:44 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Cc: Jason Wang <jasowang@redhat.com>
Subject: [PULL 0/8] Net patches
Date: Tue, 12 Mar 2024 19:36:34 +0800
Message-ID: <20240312113642.36862-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The following changes since commit 05ec974671200814fa5c1d5db710e0e4b88a40af:

  Merge tag 'm68k-for-9.0-pull-request' of https://github.com/vivier/qemu-m68k into staging (2024-03-11 18:42:53 +0000)

are available in the Git repository at:

  https://github.com/jasowang/qemu.git tags/net-pull-request

for you to fetch changes up to 0cc14182aba961f4c34a21dd202ce6e4a87470f5:

  ebpf: Updated eBPF program and skeleton. (2024-03-12 19:31:47 +0800)

----------------------------------------------------------------
-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEIV1G9IJGaJ7HfzVi7wSWWzmNYhEFAmXwPUAACgkQ7wSWWzmN
YhFnIwgAgctDniJwlRxXB01eVlzXz7IulHnpSby07XEJxENSpGB8ufaeE4eK5gJy
NVK6C2+1EU2vRxm4oIdcvtN4C4/jtRbYYjiSTx7eE4FmSkqshSnR5XCV72LDqG3i
WbzInjMvYfysmcMXLfrWgxOnVew9WqEzlpEWlc7FfNKnkzBVf+JDztfqCUx0XM7H
qefw4ImjqQw993QxJpipXC7aEGUyouB0RIBB71FkCa9ihlh9x7W68evbOI/jTn5q
HWuStgS02sKHjRFliMbdbMY77FNUz4Yroo/GKSvGt64atxkQSJqPNAV+/9n18LNy
QAH5eK6cXFPOIAaYpADU5kHDVVAFiw==
=iBdx
-----END PGP SIGNATURE-----

----------------------------------------------------------------
Andrew Melnychenko (5):
      ebpf: Added eBPF map update through mmap.
      ebpf: Added eBPF initialization by fds.
      virtio-net: Added property to load eBPF RSS with fds.
      qmp: Added new command to retrieve eBPF blob.
      ebpf: Updated eBPF program and skeleton.

Laurent Vivier (2):
      igb: fix link state on resume
      e1000e: fix link state on resume

Nick Briggs (1):
      Avoid unaligned fetch in ladr_match()

 ebpf/ebpf.c                    |   69 +++
 ebpf/ebpf.h                    |   29 +
 ebpf/ebpf_rss-stub.c           |    6 +
 ebpf/ebpf_rss.c                |  149 ++++-
 ebpf/ebpf_rss.h                |   10 +
 ebpf/meson.build               |    2 +-
 ebpf/rss.bpf.skeleton.h        | 1343 ++++++++++++++++++++--------------------
 ebpf/trace.h                   |    1 -
 hw/net/e1000e_core.c           |   60 +-
 hw/net/e1000e_core.h           |    2 -
 hw/net/igb_core.c              |   51 +-
 hw/net/igb_core.h              |    2 -
 hw/net/pcnet.c                 |    2 +-
 hw/net/virtio-net.c            |   54 +-
 include/hw/virtio/virtio-net.h |    2 +
 meson.build                    |   10 +-
 qapi/ebpf.json                 |   66 ++
 qapi/meson.build               |    1 +
 qapi/qapi-schema.json          |    1 +
 tools/ebpf/rss.bpf.c           |    7 +-
 20 files changed, 1058 insertions(+), 809 deletions(-)
 create mode 100644 ebpf/ebpf.c
 create mode 100644 ebpf/ebpf.h
 delete mode 100644 ebpf/trace.h
 create mode 100644 qapi/ebpf.json


