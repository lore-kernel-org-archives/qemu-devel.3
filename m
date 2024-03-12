Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE76FC54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 14:02:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk2iB-0000rA-7V; Tue, 12 Mar 2024 10:02:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1rk2i5-0000j9-53
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 10:02:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1rk2i3-0008QR-4o
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 10:02:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710252145;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=2vVYIDdk4CEcLLnqQabY3dlqGdMxTbpLFC4X24FiKSo=;
 b=ghZNEMBDs76WLOOo9O89LPOZwFBJ4w3t8/OTuAHr4oZjZidEAohe/eXRY31ClGlkRXFOjM
 8Pl4hk7uMmnlSjjHI/9DjJ09DmGkPrqX3zbAr4q58bcQD6X6QyQD/RYBwFzwN+fd6SroJ0
 HQa3DYPeTyNolaSkBTmlJYtXMXRnT0M=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-619-Kg-wmS36PIGneiXa1muuPw-1; Tue,
 12 Mar 2024 10:02:22 -0400
X-MC-Unique: Kg-wmS36PIGneiXa1muuPw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B3E02380350D;
 Tue, 12 Mar 2024 14:02:21 +0000 (UTC)
Received: from localhost (unknown [10.39.208.42])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BD18840735B2;
 Tue, 12 Mar 2024 14:02:19 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PULL 0/5] UI patches
Date: Tue, 12 Mar 2024 18:02:11 +0400
Message-ID: <20240312140216.313618-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

The following changes since commit 8f3f329f5e0117bd1a23a79ab751f8a7d3471e4b:

  Merge tag 'migration-20240311-pull-request' of https://gitlab.com/peterx/qemu into staging (2024-03-12 11:35:41 +0000)

are available in the Git repository at:

  https://gitlab.com/marcandre.lureau/qemu.git tags/ui-pull-request

for you to fetch changes up to dfcf74fa68c88233209aafc5f82728d0b9a1af5c:

  virtio-gpu: fix scanout migration post-load (2024-03-12 17:57:58 +0400)

----------------------------------------------------------------
display/ui: pending fixes

- ui/vnc: Respect bound console
- ui/dbus: optimize a bit message queuing
- virtio-gpu: fix blob scanout post-load

----------------------------------------------------------------

Akihiko Odaki (1):
  ui/vnc: Respect bound console

Marc-André Lureau (4):
  ui/dbus: factor out sending a scanout
  ui/dbus: filter out pending messages when scanout
  virtio-gpu: remove needless condition
  virtio-gpu: fix scanout migration post-load

 include/hw/virtio/virtio-gpu.h |  1 +
 hw/display/virtio-gpu.c        | 58 ++++++++++++++++++--------
 ui/dbus-listener.c             | 75 ++++++++++++++++++++++++++--------
 ui/vnc.c                       | 59 +++++++++++++-------------
 ui/trace-events                |  1 +
 5 files changed, 130 insertions(+), 64 deletions(-)

-- 
2.44.0


