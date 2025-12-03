Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FAD8D1268E
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Dec 2025 04:09:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQeA6-0002Ct-Sx; Tue, 02 Dec 2025 23:08:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <bounce.9ot15psxo03ay46=czmyygxm8oxv=0gczprgkdhs2gn@em483429.getutm.app>)
 id 1vQeA4-0002CU-IT
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 23:08:16 -0500
Received: from a4i956.smtp2go.com ([158.120.83.188])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <bounce.9ot15psxo03ay46=czmyygxm8oxv=0gczprgkdhs2gn@em483429.getutm.app>)
 id 1vQeA2-0000Pz-RS
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 23:08:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=getutm.app;
 i=@getutm.app; q=dns/txt; s=s483429; t=1764734881; h=from : subject :
 to : message-id : date;
 bh=w+PGv34ufTyfNwTz/5E0WbkIAR6l27kn+dhUuw3EabQ=;
 b=J5i2xzjeorAmbaw+Dgx3zdoNq8XuKMSEhoZ+aeQ0D+rAdRtP7N9zJI06sdW+mny/AKOKz
 c5KxI3LvtnfA+WNTwmGKwMnUYlQHzg1Nx9XH3KAHW1CEBcT0vkdDFHC4ZopmxJRiQRyHxVr
 y6GHO5s+KbMzp5glfw8ibDhWdnvzH6g4LlkbcBDcZUSPtVXj5BVt1/CRf96clyx+JrfLIIJ
 M1ze9ffjjp7CQb4jf3Qth+c5i4NSznBZd/tvmgdzRuXsUVNf+FAmvW+/xwOunyPMHHQHKH8
 AQQL5QOM67yRn2SIhldHKouGOFVhdlk2ynsrDCw1QWW7NFVIW799YnmQFRFA==
Received: from [10.159.238.187] (helo=localhost.localdomain)
 by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA512__CHACHA20_POLY1305:256)
 (Exim 4.98.1-S2G) (envelope-from <j@getutm.app>)
 id 1vQe9l-FnQW0hPv7oK-WEm2 for qemu-devel@nongnu.org;
 Wed, 03 Dec 2025 04:07:58 +0000
From: Joelle van Dyne <j@getutm.app>
To: qemu-devel@nongnu.org
Subject: [PATCH RFC 0/7] virtio-gpu-virgl: introduce Venus support for macOS
Date: Tue,  2 Dec 2025 20:07:47 -0800
Message-ID: <20251203040754.94487-1-j@getutm.app>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>
Feedback-ID: 483429m:483429abrvJvs:483429sep1CPAI28
X-smtpcorp-track: gfzeeXQIFiWy.dJ0mDHaKpjUC.uTmdQgIKWn5
Received-SPF: pass client-ip=158.120.83.188;
 envelope-from=bounce.9ot15psxo03ay46=czmyygxm8oxv=0gczprgkdhs2gn@em483429.getutm.app;
 helo=a4i956.smtp2go.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This brings Vulkan guest paravirtualization to macOS hosts. The bulk of the work
is being submitted to the virglrenderer project so this is a RFC for now.

In addition to Vulkan, we also introduce Metal texture scanout for GLES guests
as well. We also added Metal texture rendering in the Cocoa backend but that
builds upon the GLES work by Akihiko Odaki which is not currently upstream.

Fork with all dependent changes:
  https://github.com/utmapp/qemu/tree/submit/macos-venus
Instructions for building and testing with all related projects:
  https://gist.github.com/osy/a8f705050eed1c8421ad1a0855a8faa9

Joelle van Dyne (7):
  egl-helpers: store handle to native device
  virtio-gpu-virgl: check page alignment of blob mapping
  console: rename `d3d_tex2d` to `native`
  virtio-gpu-virgl: update virglrenderer defines
  virtio-gpu-virgl: support scanout of Metal textures
  console: add cleanup callback for ScanoutTexture
  virtio-gpu-virgl: add support for native blob scanout

 meson.build                   |   9 +++
 include/ui/console.h          |  31 ++++++++-
 include/ui/egl-helpers.h      |   2 +-
 include/ui/gtk.h              |   4 +-
 include/ui/sdl2.h             |   2 +-
 hw/display/virtio-gpu-virgl.c | 126 +++++++++++++++++++++++++++++++---
 hw/display/virtio-gpu.c       |   2 +
 ui/console.c                  |  60 +++++++++++++---
 ui/dbus-console.c             |   2 +-
 ui/dbus-listener.c            |   8 +--
 ui/egl-headless.c             |   2 +-
 ui/egl-helpers.c              |   4 +-
 ui/gtk-egl.c                  |   2 +-
 ui/gtk-gl-area.c              |   2 +-
 ui/sdl2-gl.c                  |   2 +-
 ui/spice-display.c            |   2 +-
 16 files changed, 225 insertions(+), 35 deletions(-)

-- 
2.41.0


