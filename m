Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47833C41513
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 07:38:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEOkE-0008Gr-7o; Tue, 04 Jun 2024 03:38:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1sEOkB-0008G0-9s
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 03:38:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1sEOk9-0006IM-BG
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 03:38:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717486684;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=AOt5JHbAMCPIkltxISgzDGnurGl/u+SrTaXFBg2sdGg=;
 b=grQBr18kvWlVAa7laIRcfacVVwFusO7ut4rKKXdmBYFbaySlx+F3L93mF1rrL8P783tBWe
 f47pxMe+pHESHKBUKrSYquP6wGcUdhDJd4on/mxDA/zFR6cZg+frl034GtxFfiHsW0XVZd
 dIaKxOa8tUrStk8Q8Q80RhWUTV8l9Ec=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-505-nm2lVGr0PiKDauqAXIBmNQ-1; Tue,
 04 Jun 2024 03:38:02 -0400
X-MC-Unique: nm2lVGr0PiKDauqAXIBmNQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 150A23C025CE;
 Tue,  4 Jun 2024 07:38:02 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.238])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0989D492BD2;
 Tue,  4 Jun 2024 07:37:58 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>
Subject: [PULL 00/20] Net patches
Date: Tue,  4 Jun 2024 15:37:35 +0800
Message-ID: <20240604073755.1859-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

The following changes since commit 3ab42e46acf867c45bc929fcc37693e327a35a24:

  Merge tag 'pull-ufs-20240603' of https://gitlab.com/jeuk20.kim/qemu into staging (2024-06-03 08:18:14 -0500)

are available in the Git repository at:

  https://github.com/jasowang/qemu.git tags/net-pull-request

for you to fetch changes up to dcab53611191f50cf4feabc1d8794d04afe53407:

  ebpf: Added traces back. Changed source set for eBPF to 'system'. (2024-06-04 15:14:26 +0800)

----------------------------------------------------------------
-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEIV1G9IJGaJ7HfzVi7wSWWzmNYhEFAmZewo4ACgkQ7wSWWzmN
YhHhxgf/ZaECxru4fP8wi34XdSG/PR+BF+W5M9gZIRGrHg3vIf3/LRTpZTDccbRN
Qpwtypr9O6/AWG9Os80rn7alsmMDxN8PDDNLa9T3wf5pJUQSyQ87Yy0MiuTNPSKD
HKYUIfIlbFCM5WUW4huMmg98gKTgnzZMqOoRyMFZitbkR59qCm+Exws4HtXvCH68
3k4lgvnFccmzO9iIzaOUIPs+Yf04Kw/FrY0Q/6nypvqbF2W80Md6w02JMQuTLwdF
Guxeg/n6g0NLvCBbkjiM2VWfTaWJYbwFSwRTAMxM/geqh7qAgGsmD0N5lPlgqRDy
uAy2GvFyrwzcD0lYqf0/fRK0Go0HPA==
=J70K
-----END PGP SIGNATURE-----

----------------------------------------------------------------
Akihiko Odaki (18):
      tap: Remove tap_probe_vnet_hdr_len()
      tap: Remove qemu_using_vnet_hdr()
      net: Move virtio-net header length assertion
      net: Remove receive_raw()
      tap: Call tap_receive_iov() from tap_receive()
      tap: Shrink zeroed virtio-net header
      virtio-net: Do not propagate ebpf-rss-fds errors
      virtio-net: Add only one queue pair when realizing
      virtio-net: Copy header only when necessary
      virtio-net: Shrink header byte swapping buffer
      virtio-net: Disable RSS on reset
      virtio-net: Unify the logic to update NIC state for RSS
      virtio-net: Always set populate_hash
      virtio-net: Do not write hashes to peer buffer
      ebpf: Fix RSS error handling
      ebpf: Return 0 when configuration fails
      ebpf: Refactor tun_rss_steering_prog()
      ebpf: Add a separate target for skeleton

Alexey Dobriyan (1):
      virtio-net: drop too short packets early

Andrew Melnychenko (1):
      ebpf: Added traces back. Changed source set for eBPF to 'system'.

 ebpf/ebpf_rss.c          |    7 +
 ebpf/rss.bpf.skeleton.h  | 1558 +++++++++++++++++++++++-----------------------
 ebpf/trace.h             |    1 +
 hw/net/e1000e.c          |    1 -
 hw/net/igb.c             |    1 -
 hw/net/net_tx_pkt.c      |    4 +-
 hw/net/virtio-net.c      |  282 ++++-----
 hw/net/vmxnet3.c         |    2 -
 include/net/net.h        |    8 -
 net/dump.c               |    4 +-
 net/net.c                |   47 +-
 net/netmap.c             |    5 -
 net/tap-bsd.c            |    5 -
 net/tap-linux.c          |   20 -
 net/tap-solaris.c        |    5 -
 net/tap-stub.c           |    5 -
 net/tap.c                |   77 +--
 net/tap_int.h            |    1 -
 tools/ebpf/Makefile.ebpf |   15 +-
 tools/ebpf/rss.bpf.c     |   44 +-
 20 files changed, 968 insertions(+), 1124 deletions(-)
 create mode 100644 ebpf/trace.h


