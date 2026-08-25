Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FE98C61DBE
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 11:29:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wypKk-0001hc-Sl; Tue, 25 Aug 2026 07:28:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wypKh-0001hB-Lr
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 07:28:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wypKf-0005TI-UA
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 07:28:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787657324;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Qsjnpt/8tOd6LjLY3EizJueZjQtAAVMIoJ1FxDCV5SI=;
 b=ezrtm10qXPk9kAc2khwuBh8+DPPITd2LTPAvqzo6YLYFsO8EcsLyMylOy6q/RRMAxUX2o0
 pZ75qtSYjuu/wnw9cHF+xH5qdxVR2rqo2l7CEQOqxG7Ri73cMeLS+zbQ6nJ3JnqRLuayX/
 9BU1n+DA06HEIDe3+2gflhlx30/TyZU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-623-ALQICBMDOm6gkTqXZ7h0Sw-1; Tue,
 25 Aug 2026 07:28:41 -0400
X-MC-Unique: ALQICBMDOm6gkTqXZ7h0Sw-1
X-Mimecast-MFC-AGG-ID: ALQICBMDOm6gkTqXZ7h0Sw_1787657320
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 66B861921EDE; Tue, 25 Aug 2026 11:28:40 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5E21A1955F08; Tue, 25 Aug 2026 11:22:05 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [GIT PULL 00/19] Various fixes
Message-Id: <20260825-fixes-v1-0-c59e8a620836@redhat.com>
Date: Tue, 25 Aug 2026 15:20:50 +0400
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=3393;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=WDQLN4xSQHCv4FND/OqOHYV2ZDG2ukzbQGcmMNn4V80=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqjXrTr+3tMfg40S1dTU7RbWEPwVfflGJq2stbf
 cUKGvAodVaJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCao160wAKCRDa6OEJdZac
 5Z+4EACs4ILexRhyxdtTupMc+3T/Nd2uXdOwIYRxxXVPlWzFhfqDRIedIrI9S/m+eiXocx1Ork3
 t8unspqEuD0wsL6MOhBIOXYmqwIxfqn82znFxT+XA7G/tNBhRP9TO4DsF+v0XmHqDKx/wOhGXPl
 edAUVpHWNMZFEkTLjgZMooeRrIZxwdO+IPr5eB9DlA20jdbexEr1S8E3wSquVkiY2xAjrLE+XO8
 qAjE6vgWYL48pZJJFyf1/1pu/llAXLltSd8fTReGHu2TOYUuTFW7ChJVNt9HqzbqaeUWmr2QzbS
 egwMxHTV+Shehcmy6nEr2gGZtydN/0P3tBY5GmzpmY1cWRSSgMtz83ve5e5lC6W3jE5XIxhP5HE
 MZXRgDnxho7IlttSyivJnZ+bmKoO7XJ6goIDu9Ssf0ZpInrGiYGeehDQHgo7Q0tPBJCZnWYKHg6
 0hSm4aCqMCqm8IcQCjWFCqFb8vxZNAPdKYi1aV5yKLbjD5mpWbBgyVoOG1CD94LV/WCytoh5XhH
 CrCo95c1n0cj5htXo4mAhP9DNX7BOB1kilYcNV2oR1QJvBfml726g36gqzx6PRCP05Kw55RozBX
 4Gs/1bmChTmI+z5XsGNEwxjIYi16sDSx6X7FcvIQ7bGX36VMZk7D8bmVeCAUYfYj79FDqdips31
 bN1Nyjv4uBfeAHg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The following changes since commit 2be159078ea26feac4c9c9902acf8906f1a05c2a:

  Merge tag 'pull-riscv-to-apply-20260824-1' of https://github.com/alistair23/qemu into staging (2026-08-23 23:04:09 -0700)

are available in the Git repository at:

  https://gitlab.com/marcandre.lureau/qemu.git tags/fixes-pr-v1

for you to fetch changes up to a88191a0caecdfba440682e3c120b439681ccaca:

  hw/input/ps2: say why unknown keyboard commands draw a resend (2026-08-25 15:20:44 +0400)

----------------------------------------------------------------
Various fixes

Collect various graphics & chardev fixes, and some others.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>

----------------------------------------------------------------
Akihiko Odaki (5):
      hw/display/virtio-gpu: Avoid creating empty udmabuf
      hw/display/virtio-gpu: Avoid mmap() for empty blob
      hw/display/virtio-gpu: Propagate udmabuf errors
      hw/display/virtio-gpu: Check cursor data presence
      hw/display/virtio-gpu: Validate resource per command

Christian Quante (2):
      hw/input/ps2: answer unknown mouse commands with a resend
      hw/input/ps2: say why unknown keyboard commands draw a resend

Fabiano Rosas (1):
      chardev: Don't unregister yank upon async path connection failure

Marc-André Lureau (10):
      hw/misc: fix trace-events
      migration/multifd: fix Error leak in multifd_recv_terminate_threads()
      hw/core/machine: fix fdt memory leak
      hw/display/qxl: validate primary surface stride against width
      virtio-gpu: use g_try_malloc to avoid guest-triggered abort
      crypto: fix build against nettle >= 4
      tests: tag slow tests with 'slow' suite for easy filtering
      ui/egl: fix render node cleanup order
      ui/egl: fix qemu_egl_display type
      tests/functional: fix pylint false positives for cv2 module

Warisjeet Singh (1):
      hw/display/vga: fix text-mode OOB write after a graphics surface switch

 chardev/char-socket.c                   |   5 -
 contrib/vhost-user-gpu/vhost-user-gpu.c |  25 ++--
 contrib/vhost-user-gpu/virgl.c          |   6 +-
 contrib/vhost-user-gpu/vugbm.c          |   5 +-
 crypto/hash-nettle.c                    |   3 +-
 hw/core/machine.c                       |   1 +
 hw/display/qxl-render.c                 |  66 +++++----
 hw/display/qxl.c                        |  59 +++++++++
 hw/display/qxl.h                        |   2 +
 hw/display/vga.c                        |  37 +++---
 hw/display/vga_int.h                    |   3 +-
 hw/display/virtio-gpu-rutabaga.c        |  14 +-
 hw/display/virtio-gpu-udmabuf-stubs.c   |   3 +-
 hw/display/virtio-gpu-udmabuf.c         |  17 ++-
 hw/display/virtio-gpu-virgl.c           |   6 +-
 hw/display/virtio-gpu.c                 | 228 ++++++++++++++++++++------------
 hw/input/ps2.c                          |  10 ++
 hw/misc/trace-events                    |   6 +
 include/hw/virtio/virtio-gpu.h          |   2 +-
 include/ui/egl-helpers.h                |   2 +-
 migration/multifd.c                     |   1 +
 tests/functional/pylintrc               |   6 +
 tests/qtest/meson.build                 |   3 +-
 tests/unit/meson.build                  |   9 +-
 ui/egl-helpers.c                        |  17 ++-
 25 files changed, 372 insertions(+), 164 deletions(-)


