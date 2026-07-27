Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 562B9C53219
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 11:52:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woJrv-00055c-RT; Mon, 27 Jul 2026 07:51:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1woJru-00055Q-BK
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 07:51:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1woJrs-0003dh-M4
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 07:51:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785153095;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=spIwDhi84FOynyRLbA1TkwObj3vyLQCNadXo0WSRpuA=;
 b=P7BfWaLnfnxotWa3TQqR+NdefpPuKZxAAZfCYxhSdXv0PgviHejqFBoFG/+2HqQDNeCxYs
 i3yHIk37SdKoVkWUg9XL9vBYm6qfQSn6ksJ34YUtsixDcYDTq8dfnspSLgh65hENUlON7+
 pTtlQY1IPEO8k0bkfgXnf2DWJ2oEuho=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-630-o4OrcGVZMCiTxTpA4ChN1g-1; Mon,
 27 Jul 2026 07:51:34 -0400
X-MC-Unique: o4OrcGVZMCiTxTpA4ChN1g-1
X-Mimecast-MFC-AGG-ID: o4OrcGVZMCiTxTpA4ChN1g_1785153093
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3350E195607C
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 11:51:33 +0000 (UTC)
Received: from localhost (unknown [10.44.24.5])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 284F7180025A; Mon, 27 Jul 2026 11:51:31 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [GIT PULL 00/23] Fixes for 11.1-rc2
Message-Id: <20260727-fix-v1-0-ca3fa3851347@redhat.com>
Date: Mon, 27 Jul 2026 15:51:09 +0400
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3651;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=+J2SDkYbHI1yYKgMAh/vg5/8DP/melYWcisFLymsB1c=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqZ0Y+UyuK7NNRrEm7fE3IAamTWJK1CvMHpLhMj
 E/y73G8lA2JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCamdGPgAKCRDa6OEJdZac
 5TeDD/4t0DoLiKHGkV10EECcudpFfZPKpjg+NoehCw28mH9T3uWwTNCRzof2vSMdZP7fdWmPtVi
 5oGwwW4k4QeK8OT5nOeBB+u13hP7zPlKOa9xamyuWrI+/UfM3pBQY+dkVjJe9iS1iHQOt8A3I7w
 LagO5VgedSyidtl2MckKN9D+KT/+ymgrNnH7dlTjxbGCuvRC9eB53H6uO/rG3TjgJXQbJ1pJaKb
 23AUhJBAYsPkluUiJQRu0BLGjCenp5+gLQUwvvDzThUTqb4ec6HQJSiggdJasyN/U0llcHM+neO
 Xo/Vk38O8UGdka/ePTCMzAcRaFFeUH4wurEUbdI1xZZbs4LICQkoxAPCZlB0zGq6OhrGK2Ie6zD
 nu6czXBBhDvWCMsIYtY5Fi7qByrEcUoDUoRkg4btITgr8tnDlja3BA+eQgFAi+E7RSwQ8tb0c5u
 n9gZOdXXIkawb5mzY6BZG8gwc53du31WMFgwq/y8JHMMn3mJAIPI/3bibmuddS8uWlRRbO6Qn++
 PMeeAzTQF6fg9FUWJXUVJMHQ9RjH+T0V4ND6rLEMQTuKES+kDsbxtmZjcavVPphmXzjybYGl3KA
 1igfYlzf3tOBWWJ/OrTFhfl1GhZ2XExOdb10VPoWIKRIxFzufnEoMY+3alvql6Fi9sJi/b7rPdb
 hf6ADwEj47YHDvw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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

The following changes since commit 6333226c2abb72f31648c251624c56e70993d625:

  Merge tag 'pull-9p-20260725' of https://github.com/cschoenebeck/qemu into staging (2026-07-26 08:30:07 -0400)

are available in the Git repository at:

  https://gitlab.com/marcandre.lureau/qemu.git tags/fix-pr-v1

for you to fetch changes up to 0e83d6894534cfe4cf071381ea8466cc689e044e:

  migration/rdma: annotate and simplify wait_comp_channel() (2026-07-27 15:51:03 +0400)

----------------------------------------------------------------
Fixes for 11.1-rc2

To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>

----------------------------------------------------------------
Akihiko Odaki (5):
      hw/display/virtio-gpu: Remove the bytes_pp field
      hw/display/virtio-gpu: Fix empty blob discrimination
      hw/display/virtio-gpu: Initialize blob mapping for ATTACH_BACKING
      hw/display/virtio-gpu: Avoid leaking migration blocker
      hw/display/virtio-gpu: Block Rutabaga migration

Haotian Jiang (2):
      hw/display/qxl: unregister vm_change_state handler and BHs
      virtio-gpu: fix NULL deref in rutabaga set_scanout

Marc-André Lureau (16):
      hw/display/vhost-user-gpu: validate message payload sizes
      ui/vnc: remove redundant rows computation
      net/colo: fix g_hash_table_destroy assertion on uninitialized filter
      target/i386/sev: fix MemoryRegion reference leaks in gpa2hva callers
      docs/hyperv: fix misleading hv-crash shutdown description
      hw/display/virtio-gpu-rutabaga: zero-init capset info response
      hw/cxl: fix invalid free on early return
      hw/hexagon: fix machine->fdt leak in qom-test
      block/blkio: fix compiler false-positive warning
      monitor: annotate monitor_qmp_dispatcher_pop_any() as coroutine
      migration: fix qemu_get_counted_string annotation
      io: add missing coroutine annotation
      block: add missing coroutine annotation
      qcow2: remove invalid qcow2_check_refcounts calls
      hw/9pfs: annotate V9fsTransport callbacks as coroutine_fn
      migration/rdma: annotate and simplify wait_comp_channel()

 docs/system/i386/hyperv.rst      | 12 ++++++----
 hw/9pfs/9p.h                     | 26 ++++++++++++---------
 hw/display/qxl.h                 |  1 +
 include/hw/virtio/virtio-gpu.h   |  1 -
 include/io/channel.h             |  4 ++--
 include/system/memory.h          |  2 ++
 block/blkio.c                    |  5 ++--
 block/commit.c                   |  5 ++--
 block/qcow2-snapshot.c           | 18 ---------------
 hw/9pfs/9p.c                     | 31 +++++++++++++++----------
 hw/9pfs/virtio-9p-device.c       | 24 +++++++++++---------
 hw/9pfs/xen-9p-backend.c         | 34 ++++++++++++++--------------
 hw/cxl/cxl-host.c                |  2 +-
 hw/display/qxl.c                 | 16 ++++++++++++-
 hw/display/vhost-user-gpu.c      | 38 +++++++++++++++++++++++++++++++
 hw/display/virtio-gpu-base.c     | 37 +++++++++++++-----------------
 hw/display/virtio-gpu-rutabaga.c | 21 ++++++++++++++---
 hw/display/virtio-gpu.c          | 49 ++++++++++++++++++++++++----------------
 hw/hexagon/virt.c                |  9 +-------
 io/channel.c                     |  5 ++--
 migration/qemu-file.c            |  2 +-
 migration/rdma.c                 | 12 ++++------
 monitor/qmp.c                    |  3 ++-
 net/filter-rewriter.c            |  2 +-
 target/i386/sev.c                |  4 ++--
 ui/vnc.c                         |  1 -
 26 files changed, 214 insertions(+), 150 deletions(-)


