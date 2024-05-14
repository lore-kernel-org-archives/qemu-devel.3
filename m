Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DECBC25B75
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2024 13:18:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6s2Y-00047B-G5; Tue, 14 May 2024 09:17:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1s6s2S-00044U-KX
 for qemu-devel@nongnu.org; Tue, 14 May 2024 09:17:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1s6s2Q-0002I9-Hx
 for qemu-devel@nongnu.org; Tue, 14 May 2024 09:17:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715692668;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=4NGfDYR19txb4ZUJo2PMdaa5/SuSMw5/eYLlZoVwbxw=;
 b=NLCjCpgNzFgkpWtFTCAEOEaSFmnb8rFS5cD2GQsW8y1swXLcbDBInbnaw22eTADnrf+x0o
 dpKWKVgjL+c6pFKfGtpZVuIaOOh7MryHzHtzDYNruhEf/3/uLevEWED5n8DG6XAIgQF8yd
 6DxpvAm6h8YxahEWrZ9zJ5US3Nd0YOQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-435-ru63u0hFP1u-c39I10GBSw-1; Tue, 14 May 2024 09:17:29 -0400
X-MC-Unique: ru63u0hFP1u-c39I10GBSw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6F975800CA5;
 Tue, 14 May 2024 13:17:29 +0000 (UTC)
Received: from localhost (unknown [10.39.208.9])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 450CB400059;
 Tue, 14 May 2024 13:17:28 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
 =?unknown-8bit?q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Subject: [PULL 00/11] Ui patches
Date: Tue, 14 May 2024 17:17:14 +0400
Message-ID: <20240514131725.931234-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.974,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The following changes since commit 9360070196789cc8b9404b2efaf319384e64b107:

  Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging (2024-05-12 13:41:26 +0200)

are available in the Git repository at:

  https://gitlab.com/marcandre.lureau/qemu.git tags/ui-pull-request

for you to fetch changes up to 2e701e6785cd8cc048c608751c6e4f6253c67ab6:

  ui/sdl2: Allow host to power down screen (2024-05-14 17:14:13 +0400)

----------------------------------------------------------------
UI: small fixes and improvements

----------------------------------------------------------------

Bernhard Beschow (1):
  ui/sdl2: Allow host to power down screen

Dongwon Kim (7):
  ui/gtk: Draw guest frame at refresh cycle
  ui/gtk: Check if fence_fd is equal to or greater than 0
  ui/console: new dmabuf.h and dmabuf.c for QemuDmaBuf struct and
    helpers
  ui/console: Use qemu_dmabuf_get_..() helpers instead
  ui/console: Use qemu_dmabuf_set_..() helpers instead
  ui/console: Use qemu_dmabuf_new() and free() helpers instead
  ui/console: move QemuDmaBuf struct def to dmabuf.c

Sergii Zasenko (1):
  Allow UNIX socket option for VNC websocket

hikalium (2):
  ui/gtk: Add gd_motion_event trace event
  ui/gtk: Fix mouse/motion event scaling issue with GTK display backend

 include/hw/vfio/vfio-common.h   |   2 +-
 include/hw/virtio/virtio-gpu.h  |   4 +-
 include/ui/console.h            |  20 +--
 include/ui/dmabuf.h             |  49 +++++++
 hw/display/vhost-user-gpu.c     |  32 +++--
 hw/display/virtio-gpu-udmabuf.c |  27 ++--
 hw/vfio/display.c               |  32 ++---
 ui/console.c                    |   4 +-
 ui/dbus-console.c               |   9 +-
 ui/dbus-listener.c              |  71 +++++-----
 ui/dmabuf.c                     | 229 ++++++++++++++++++++++++++++++++
 ui/egl-headless.c               |  23 +++-
 ui/egl-helpers.c                |  59 ++++----
 ui/gtk-egl.c                    |  53 +++++---
 ui/gtk-gl-area.c                |  42 ++++--
 ui/gtk.c                        |  32 +++--
 ui/sdl2.c                       |   1 +
 ui/spice-display.c              |  50 ++++---
 ui/vnc.c                        |   5 -
 qemu-options.hx                 |   4 +
 ui/meson.build                  |   1 +
 ui/trace-events                 |   1 +
 22 files changed, 547 insertions(+), 203 deletions(-)
 create mode 100644 include/ui/dmabuf.h
 create mode 100644 ui/dmabuf.c

-- 
2.41.0.28.gd7d8841f67


