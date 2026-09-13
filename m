Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48715C88E65
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2026 10:43:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5hfk-0005bd-13; Sun, 13 Sep 2026 06:42:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x5hfh-0005bL-Q5
 for qemu-devel@nongnu.org; Sun, 13 Sep 2026 06:42:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x5hff-0008AW-PT
 for qemu-devel@nongnu.org; Sun, 13 Sep 2026 06:42:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789296169;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=HWAAEytrMkX2W6y3/rg63DuF5EjasjEyw34ZX62Bs7Q=;
 b=iJ4qiZf/GjHoP+6FezHx3c8GoYXajNkYPmdnRFTkaZuQwVUv8+6WgC5UkU0s+MQlQWOum+
 Guemr0iR6bPJXItclXOd/FOTcx1FI3vdvn3qrKtlc3DSYYkwVUCLNy0bvufgM1OtVJ5T1I
 T5FqDbJLAFREeKobb4FExOlddFAYDf0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-473-78FI9Cp0O1Of1w-oEaQBeQ-1; Sun,
 13 Sep 2026 06:42:47 -0400
X-MC-Unique: 78FI9Cp0O1Of1w-oEaQBeQ-1
X-Mimecast-MFC-AGG-ID: 78FI9Cp0O1Of1w-oEaQBeQ_1789296167
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F32A818011ED
 for <qemu-devel@nongnu.org>; Sun, 13 Sep 2026 10:42:46 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1EF411800446
 for <qemu-devel@nongnu.org>; Sun, 13 Sep 2026 10:42:45 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [GIT PULL 00/14] UI/display queue
Message-Id: <20260913-ui-v1-0-7a8d89d0423a@redhat.com>
Date: Sun, 13 Sep 2026 14:41:18 +0400
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=2461;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=+GP65J4qscqaL2H+X6pn70EbX3Ibx6wgg2EHk4bc3Mw=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqpn4iip3FIB1I1crUYAwsul6y/k5c9ilFBHsgF
 Vsse0mLFEOJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaqZ+IgAKCRDa6OEJdZac
 5QQjD/4+9sb2lnuG0udfh8+pS+yNy4QwUXy++S+m6e75zC3JkwEf7hMTCSSebkFnvG7sMETZoBC
 uaH8fCpSUSIH9g/DB2JKGSRTl260k9dZoQv3yxJKnfIYTyXU4CndwNtGtYKaxFPfGDbOkAwZJfH
 ieOgH3I6IbZPxlyMADqWzsjQuyAj/KGzXaC+K+byB0YgXyxsVopU5AJiaXsLSdVPlqK3emSYQE5
 oYtPAyW28sxtPTJVuH8IJHHMBQgZZBQnPqRmT8xhd5KP2/612MHT8EuFR31DMDoQOkDrs/DzSYx
 dKhHntYBp8wGBsEJp7Zed594IUmPLJiTibhYjdhkKJQsngqnRLYsdKYc/J43gzgIFs3HrAMgMEc
 XAiWAHttLDZ2KgFt5Rx4z+g7IMq1YvKr2J4hb5XEy3o/QMn+pQ+NYaHj7KC5iHBkvHd0XXhPNb8
 CAOwadBXZwB9JtgR0sq8KdG1hZZN0jpCQh9ILUai5Vna/rXOc68oDx0h36p8E655IRFDUm1/tp8
 TpdsCLGdobX2Qe1GOxR1FynCgDnhrbEo4fRibRtzQx8SVi7w8w9rGAcHfe8+944ci7uTD1AUdLN
 ueOyavgz/uTuD7gVTTRDxGAGbtH3AtVAqAoI5L0sOJGD0H0phM5W4K3FXTO+iFterVyoKYTVQnf
 vvZTTIowP5AGmpA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The following changes since commit d43c2d5f89db70359a7b3a7e2ad7098fcc0165ef:

  Merge tag 'for_upstream' of https://git.kernel.org/pub/scm/virt/kvm/mst/qemu into staging (2026-09-11 12:04:42 -1000)

are available in the Git repository at:

  https://gitlab.com/marcandre.lureau/qemu.git tags/ui-pr-v1

for you to fetch changes up to 78809254f367cec04d68afd4c90115d9cc15a2e4:

  ui/gtk: Clean up GL resources on tab detach, re-attach, and VC free (2026-09-13 14:41:12 +0400)

----------------------------------------------------------------
UI/display queue

- cursor data races fixes
- qxl migration harderning
- add org.qemu.Display1.UIInfo
- gtk fixes

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>

----------------------------------------------------------------
Akihiko Odaki (2):
      ui/gtk: Remove glFlush() after eglSwapBuffers()
      ui/gtk: Work around the gtk-menu-bar-accel leak

Andrey Drobyshev (3):
      hw/display/qxl: factor out qxl_guest_phys2virt()
      hw/display/qxl: validate replayed commands in qxl_post_load
      hw/display/qxl: trace skipped stale loadvm commands

Chengyang Zhu (1):
      ui/dbus: add org.qemu.Display1.UIInfo interface

Denis V. Lunev (2):
      hw/display/qxl: hold ssd.lock while replacing ssd.cursor
      ui/cursor: make the cursor refcount atomic

Dongwon Kim (2):
      ui/gtk: Handle empty notebook state in menu handlers
      ui/gtk: Clean up GL resources on tab detach, re-attach, and VC free

Marc-André Lureau (4):
      ui/dbus: fix cursor race, copy cursor data
      docs/sphinx/dbus: register build dependency
      vhost-user-gpu: validate command buffer size in submit_3d
      virtio-gpu-virgl: guard new_blob with VIRGL_VERSION_MAJORS>=1

 contrib/vhost-user-gpu/virgl.c |  12 ++--
 docs/sphinx/dbusdoc.py         |   1 +
 hw/display/qxl.c               | 134 ++++++++++++++++++++++++++++++-----------
 hw/display/trace-events        |   1 +
 hw/display/virtio-gpu-virgl.c  |   2 +
 include/ui/console.h           |   9 +++
 ui/cursor.c                    |  17 ++++--
 ui/dbus-console.c              | 106 ++++++++++++++++++++++++++++++++
 ui/dbus-display1.xml           |  55 +++++++++++++++++
 ui/dbus-listener.c             |   8 +--
 ui/gtk-egl.c                   |   3 -
 ui/gtk.c                       | 125 ++++++++++++++++++++++++++++----------
 12 files changed, 387 insertions(+), 86 deletions(-)


