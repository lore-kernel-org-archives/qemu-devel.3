Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9925CD11DD
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 13:56:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rp7GR-00049E-E1; Tue, 26 Mar 2024 09:54:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rp7GP-00047y-Ni
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 09:54:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rp7GO-0001O3-0q
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 09:54:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711461291;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Xr1F5MnnKq3YaOXm655zwchlibK1SjVBcFkXGpCrKXk=;
 b=bRhlH+OUuwCz6+NEVbJma0kKamClfIU5QoXId8svWpb5dC5mZ/s9zuOUhTYD9JxomOCJH+
 1hxcLnoaUOiQLIireUuaAblhJe+C7cme7ivvs6xrJSrDNDKs3OBUO/sUEHd8KukZ0kM2X6
 ZbOxZr0WIeblaXh537bUPpybnzv9xcA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-119-tdzYvptKNBKMzcnqp8m5Hg-1; Tue,
 26 Mar 2024 09:54:47 -0400
X-MC-Unique: tdzYvptKNBKMzcnqp8m5Hg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 665CD3C0EAAE;
 Tue, 26 Mar 2024 13:54:47 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.193.60])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 827A1112132A;
 Tue, 26 Mar 2024 13:54:46 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 0/6] Block layer patches
Date: Tue, 26 Mar 2024 14:54:34 +0100
Message-ID: <20240326135440.421609-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The following changes since commit 096ae430a7b5a704af4cd94dca7200d6cb069991:

  Merge tag 'pull-qapi-2024-03-26' of https://repo.or.cz/qemu/armbru into staging (2024-03-26 09:50:21 +0000)

are available in the Git repository at:

  https://repo.or.cz/qemu/kevin.git tags/for-upstream

for you to fetch changes up to 12d7b3bbd3333cededd3b695501d8d247239d769:

  iotests: add test for stream job with an unaligned prefetch read (2024-03-26 14:21:26 +0100)

----------------------------------------------------------------
Block layer patches

- Fix crash with unaligned prefetch requests (e.g. in stream jobs)
- vdpa-dev: Fix initialisation order to restore VDUSE compatibility
- iotests fixes

----------------------------------------------------------------
Fiona Ebner (3):
      block-backend: fix edge case in bdrv_next() where BDS associated to BB changes
      block-backend: fix edge case in bdrv_next_cleanup() where BDS associated to BB changes
      iotests: add test for stream job with an unaligned prefetch read

Kevin Wolf (1):
      vdpa-dev: Fix initialisation order to restore VDUSE compatibility

Stefan Reiter (1):
      block/io: accept NULL qiov in bdrv_pad_request

Thomas Huth (1):
      tests/qemu-iotests: Test 157 and 227 require virtio-blk

 block/block-backend.c                              | 18 ++---
 block/io.c                                         | 33 +++++----
 hw/net/vhost_net.c                                 | 10 +++
 hw/virtio/vdpa-dev.c                               |  5 +-
 hw/virtio/vhost-vdpa.c                             | 29 +++++++-
 hw/virtio/vhost.c                                  |  8 +-
 hw/virtio/trace-events                             |  2 +-
 tests/qemu-iotests/157                             |  2 +
 tests/qemu-iotests/227                             |  2 +
 tests/qemu-iotests/tests/stream-unaligned-prefetch | 86 ++++++++++++++++++++++
 .../tests/stream-unaligned-prefetch.out            |  5 ++
 11 files changed, 167 insertions(+), 33 deletions(-)
 create mode 100755 tests/qemu-iotests/tests/stream-unaligned-prefetch
 create mode 100644 tests/qemu-iotests/tests/stream-unaligned-prefetch.out


