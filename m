Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19FD7C369DC
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 05:44:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCXa2-0002gt-IF; Wed, 07 May 2025 01:44:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1uCXZz-0002gK-5z
 for qemu-devel@nongnu.org; Wed, 07 May 2025 01:44:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1uCXZx-0004Hq-CE
 for qemu-devel@nongnu.org; Wed, 07 May 2025 01:44:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746596662;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=LKkizkquZsilri/px2yWLZR6hhRq6Uwzdc3Dj2YpjZQ=;
 b=UKc1zIHhEoxER8IvJv7EvjPXk8ut5ewpArB/ALpCUVNP8vBV6HH7pwBMW6CWGs8BnOyiUl
 djfvh+OYvfGZk2vllj1YdXZn8lpWKh0/ii31aW6SDlo1eipJlwNTxrcZGx6MYqilCY8TTu
 88VmiRnxmfbmijMIMgivGCqQRF1Cz7g=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-632-FPBxpp28N72Pz2ejIEhGGA-1; Wed,
 07 May 2025 01:44:21 -0400
X-MC-Unique: FPBxpp28N72Pz2ejIEhGGA-1
X-Mimecast-MFC-AGG-ID: FPBxpp28N72Pz2ejIEhGGA_1746596660
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ADAEF18011CB; Wed,  7 May 2025 05:44:20 +0000 (UTC)
Received: from localhost (unknown [10.45.242.19])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id F086C180045B; Wed,  7 May 2025 05:44:18 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 stefanha@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 0/6] Ui patches
Date: Wed,  7 May 2025 09:44:08 +0400
Message-ID: <20250507054414.2284129-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

The following changes since commit 5134cf9b5d3aee4475fe7e1c1c11b093731073cf:

  Merge tag 'block-pull-request' of https://gitlab.com/stefanha/qemu into staging (2025-04-30 13:34:44 -0400)

are available in the Git repository at:

  https://gitlab.com/marcandre.lureau/qemu.git tags/ui-pull-request

for you to fetch changes up to 98a050ca93afd8686b78c3a71cbeef23e0bc420b:

  ui/spice: support multi plane dmabuf scanout (2025-05-06 13:40:09 +0400)

----------------------------------------------------------------
ui: support multi plane texture

----------------------------------------------------------------

Qiang Yu (6):
  ui/dmabuf: extend QemuDmaBuf to support multi-plane
  ui/egl: require EGL_EXT_image_dma_buf_import_modifiers
  ui/egl: use DRM_FORMAT_MOD_INVALID as default modifier
  ui/egl: support multi-plane dmabuf when egl export/import
  ui/dbus: change dbus ScanoutDMABUF interface
  ui/spice: support multi plane dmabuf scanout

 meson.build                     |   5 ++
 include/ui/dmabuf.h             |  20 +++--
 include/ui/egl-helpers.h        |   5 +-
 hw/display/vhost-user-gpu.c     |   9 ++-
 hw/display/virtio-gpu-udmabuf.c |   8 +-
 hw/vfio/display.c               |   7 +-
 ui/dbus-listener.c              | 129 ++++++++++++++++++++++++++++----
 ui/dmabuf.c                     |  80 ++++++++++++++------
 ui/egl-helpers.c                | 103 ++++++++++++++++++-------
 ui/spice-display.c              | 108 +++++++++++++++++++-------
 ui/dbus-display1.xml            |  45 +++++++++++
 11 files changed, 409 insertions(+), 110 deletions(-)

-- 
2.49.0


