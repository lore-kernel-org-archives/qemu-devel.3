Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00122D16261
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2024 13:40:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0LIb-0000Zk-1n; Mon, 14 Oct 2024 09:39:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1t0LIZ-0000ZB-VW
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 09:39:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1t0LIY-0003bJ-BZ
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 09:39:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728913184;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=w617wUgTbXtxtuoUR2uNefdmB3J0uSRbGffjps8S74w=;
 b=ZfWP0fMPTHyYm2Synba6aNgOM4Cv3+NdQMWBU8ADVZ6X7j2800oOtbGEV+fS1XR2FANbq7
 IrUuq9XB9xQ7ttOFbNcAt6NZdiUD4+badCLU5f4HOQgsnMEUfQWm/b3s9/q4LIBxO3xJS+
 FXnK/IZTm0C0x/s1IAyNQFZTA7g3T2Y=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-34-H_srHPVoP72yqcLsjztrvQ-1; Mon,
 14 Oct 2024 09:39:43 -0400
X-MC-Unique: H_srHPVoP72yqcLsjztrvQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2558D19560B4; Mon, 14 Oct 2024 13:39:41 +0000 (UTC)
Received: from localhost (unknown [10.39.208.12])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C04FB1956088; Mon, 14 Oct 2024 13:39:38 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 00/20] UI patches
Date: Mon, 14 Oct 2024 17:39:15 +0400
Message-ID: <20241014133935.470709-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.076,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The following changes since commit 3860a2a8de56fad71db42f4ad120eb7eff03b51f:

  Merge tag 'pull-tcg-20241013' of https://gitlab.com/rth7680/qemu into staging (2024-10-14 11:12:34 +0100)

are available in the Git repository at:

  https://gitlab.com/marcandre.lureau/qemu.git tags/ui-pull-request

for you to fetch changes up to 4cd78a3db2478d3c1527905a26c9d3fbee83ccac:

  audio/pw: Report more accurate error when connecting to PipeWire fails (2024-10-14 17:35:24 +0400)

----------------------------------------------------------------
UI-related fixes & shareable 2d memory with -display dbus

----------------------------------------------------------------

Marc-André Lureau (19):
  hw/audio/hda: free timer on exit
  hw/audio/hda: fix memory leak on audio setup
  ui/dbus: fix leak on message filtering
  ui/win32: fix potential use-after-free with dbus shared memory
  ui/dbus: fix filtering all update messages
  ui/dbus: discard display messages on disable
  ui/dbus: discard pending CursorDefine on new one
  util/memfd: report potential errors on free
  ui/pixman: generalize shared_image_destroy
  ui/dbus: do not limit to one listener per connection / bus name
  ui/dbus: add trace for can_share_map
  ui/surface: allocate shared memory on !win32
  meson: find_program('gdbus-codegen') directly
  ui/dbus: make Listener.Win32.Map win32-specific
  ui/dbus: add Listener.Unix.Map interface XML
  ui/dbus: implement Unix.Map
  virtio-gpu: allocate shareable 2d resources on !win32
  ui: refactor using a common qemu_pixman_shareable
  tests: add basic -display dbus Map.Unix test

Michal Privoznik (1):
  audio/pw: Report more accurate error when connecting to PipeWire fails

 meson.build                     |   2 +-
 include/hw/virtio/virtio-gpu.h  |   4 +-
 include/ui/qemu-pixman.h        |  24 +++++
 include/ui/surface.h            |  14 ++-
 audio/pwaudio.c                 |   8 +-
 hw/audio/hda-codec.c            |  33 ++++---
 hw/display/virtio-gpu.c         |  69 ++++----------
 tests/qtest/dbus-display-test.c |  72 ++++++++++++++-
 ui/console.c                    |  78 ++++++----------
 ui/dbus-console.c               |  23 +----
 ui/dbus-listener.c              | 159 ++++++++++++++++++++++++++++----
 ui/qemu-pixman.c                |  71 ++++++++++++++
 util/memfd.c                    |   9 +-
 ui/dbus-display1.xml            |  49 ++++++++++
 ui/trace-events                 |   1 +
 15 files changed, 444 insertions(+), 172 deletions(-)

-- 
2.47.0


