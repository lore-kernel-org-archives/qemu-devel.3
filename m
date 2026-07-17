Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DDFBC44520
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 11:53:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkh7u-0003eD-0W; Fri, 17 Jul 2026 07:53:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wkh7s-0003e5-NG
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 07:53:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wkh7r-0003Nu-1b
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 07:53:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784289185;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=WkXipREj4zZ7uhBy3rcmEX1BB6UtKYN1cjy9qXkGKxQ=;
 b=YtwooIt+qIT0fe8KBC4492uymf85UmCMvlmh8SH6EzfC8PJLeto2BxrrQQM7Q8PQx5GbqS
 P7xO8+rTVeTAtur51Jc7DM0fFsgEK9XpYgdw/zq9GOeFwI5NQZGcWv/CStcTaqYDVZ7oSX
 Crn+CgrKMXYdusAUGagwwWha/2ZM4C4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-388-x8T35_5xNhOffOODs1pkJg-1; Fri,
 17 Jul 2026 07:53:04 -0400
X-MC-Unique: x8T35_5xNhOffOODs1pkJg-1
X-Mimecast-MFC-AGG-ID: x8T35_5xNhOffOODs1pkJg_1784289183
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7B9A518007FE
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 11:53:03 +0000 (UTC)
Received: from localhost (unknown [10.44.22.17])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3C4C7195604D
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 11:53:01 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [GIT PULL 00/15] Various UI/security-related fixes for 11.1
Message-Id: <20260717-fix-v1-0-cb9f7d49dc52@redhat.com>
Date: Fri, 17 Jul 2026 15:52:39 +0400
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=2444;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=JN3R1axexD51YS+9J8rXL5ULt7vSfr3pFr5dbXRJlDQ=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqWheZXZlCAmsk+BZori3o5wlgatgi6iMpOp8Ds
 cQNHD0paruJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaloXmQAKCRDa6OEJdZac
 5fW3D/9SNpmNSaT1VkZVPqp+APHPP01zjdRZk2eH9NnEbGI9bnT9tMpS05OJCW0hvesq/Z9IYIG
 Ar0mw1VqU1mh0U+wcKk44K3SytLrVBoYRo81yxdrtXcTqnNFSMQXG01Me3XSx8euO2vPp5CKpEb
 1lVz4G+6KGHBT8HnAApvImiEIlDhYWlP4deVNi2JdMIG5wRLHkYZNpXJNIrEmnRLwNWkisbA5ff
 2jn40SWeTCFsH32sk+zEKusHUAPDZN4n2LifWavRzUsysj5NaQ6pRET0S42ysTKnIsQO43C/xgc
 HrKBJl46MkNupVGTLTQlyjmLbWqvz7YIay9o5VpZldg8TeZKB5sBfozW30hCovwUbBUP6c3I0dT
 7Ipy5FQNgJJX1UWS5INisc5GHcz0xr2C1q2PiO8sVF8d3F9xrtCbb2hTo1ctvAwJ0LYMzCRaMIz
 iLJNxtLmrtK+/BdqO0TD+bfevPrba0EzxS5KRywFyey3cYO7PICT9HnYTrNFDuOSieaVcnC+DYs
 PG/mLwq1HtOklrG7i3V/OgNSGI8xPFq5NB0VNVqM4mlPg9qt5/0sSd8HZY5ZiDaEdchw8Upo5Tl
 +hG8aO9HyX7gI0ePndARWwh2PV6BJOrC+zv0RVA4FUF/0dnjQaSff+zmSykgULzwVQGfLqzhBIc
 ZG2gbYuTeekEWjQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: permerror client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

The following changes since commit eca2c16212ef9dcb0871de39bb9d1c2efebe76be:

  Update version for v11.1.0-rc0 release (2026-07-14 20:36:23 +0100)

are available in the Git repository at:

  https://gitlab.com/marcandre.lureau/qemu.git tags/fix-pr-v1

for you to fetch changes up to f1af81ba2aeec7b5a5ee8529ef55275865aea0c0:

  hw/display/virtio-gpu: Check pixman_image_create_bits() results (2026-07-17 15:52:31 +0400)

----------------------------------------------------------------
Various UI/security-related fixes for 11.1

To: qemu-devel@nongnu.org
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>

----------------------------------------------------------------
Akihiko Odaki (3):
      ui/gtk: Narrow DMA-BUF critical section
      hw/display/virtio-gpu: reject strides exceeding INT_MAX
      hw/display/virtio-gpu: Check pixman_image_create_bits() results

Marc-André Lureau (12):
      i386/tdx: fix uninitialized variable warning in tdx_check_features
      ui/vnc: fix OOB write in vnc_refresh_lossy_rect
      ui/vnc: validate color shifts in SetPixelFormat
      ui/vnc: use RFB wire types for client message handlers
      ui/input-barrier: fix off-by-one in keycode bounds check
      ui/vnc: fix out-of-bounds write in lossy refresh dirty marking
      ui/vnc: validate SetPixelFormat field ranges
      hw/display/virtio-gpu: fix dmabuf_fd leak on remap failure
      hw/display/qxl: fix TOCTOU in cursor chunk data_size handling
      hw/display/virtio-gpu: validate stride against width on scanout
      hw/display/virtio-gpu: cap submit_3d command buffer allocation
      hw/display/virtio-gpu: handle migration iov allocation failure

 contrib/vhost-user-gpu/vugpu.h   |  9 ++++++
 include/hw/virtio/virtio-gpu.h   |  9 ++++++
 contrib/vhost-user-gpu/virgl.c   |  7 +++++
 hw/display/qxl-render.c          | 28 ++++++++++-------
 hw/display/virtio-gpu-rutabaga.c |  8 +++++
 hw/display/virtio-gpu-udmabuf.c  |  1 +
 hw/display/virtio-gpu-virgl.c    |  8 +++++
 hw/display/virtio-gpu.c          | 57 ++++++++++++++++++++++++++++++++---
 target/i386/kvm/tdx.c            |  2 +-
 ui/gtk-egl.c                     |  6 ++--
 ui/gtk-gl-area.c                 | 23 +-------------
 ui/input-barrier.c               |  2 +-
 ui/vnc.c                         | 65 ++++++++++++++++++++++++----------------
 13 files changed, 157 insertions(+), 68 deletions(-)


