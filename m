Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4ED6C6FD1F
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 13:54:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmwOL-0003xu-V4; Wed, 20 Mar 2024 09:54:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1rmwOJ-0003xS-KB
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 09:54:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1rmwOH-00007l-Tz
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 09:54:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710942840;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=/Wok9lDpeQGSmTT4Pw8SdIq2MQoDAd2OBb0sQT882cc=;
 b=Y2haENotLMBTY69zO/Kqt42iEWqJNKqr1G64mNW+Frr9BdaaMPZnPDgkL3+84FKZuDFlj2
 V/fQ7FRiaJ3n8QbCsychi2YmHkkdKTqu2h23SZo7+1cvBWSLEi6ahsgdlcKGtOApJDsHiH
 3haPdAX6haQDkJ8RsunL4n0Z9VWm31s=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620-GUagkDzCMo20EKaRyC8G8w-1; Wed, 20 Mar 2024 09:53:57 -0400
X-MC-Unique: GUagkDzCMo20EKaRyC8G8w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 40562887E41;
 Wed, 20 Mar 2024 13:53:57 +0000 (UTC)
Received: from localhost (unknown [10.39.208.32])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E0FAA2166B33;
 Wed, 20 Mar 2024 13:53:55 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 0/5] Ui patches
Date: Wed, 20 Mar 2024 17:53:44 +0400
Message-ID: <20240320135349.2139402-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.417,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

The following changes since commit c62d54d0a8067ffb3d5b909276f7296d7df33fa7:

  Update version for v9.0.0-rc0 release (2024-03-19 19:13:52 +0000)

are available in the Git repository at:

  https://gitlab.com/marcandre.lureau/qemu.git tags/ui-pull-request

for you to fetch changes up to d4069a84a3380247c1b524096c6a807743bf687a:

  ui: compile dbus-display1.c with -fPIC as necessary (2024-03-20 10:28:00 +0400)

----------------------------------------------------------------
UI: fixes

- dbus-display shared-library compilation fix
- remove console_select() and fix related issues

----------------------------------------------------------------

Akihiko Odaki (4):
  ui/vc: Do not inherit the size of active console
  ui/vnc: Do not use console_select()
  ui/cocoa: Do not use console_select()
  ui/curses: Do not use console_select()

Marc-André Lureau (1):
  ui: compile dbus-display1.c with -fPIC as necessary

 include/ui/console.h   |   2 +-
 include/ui/kbd-state.h |  11 ++++
 ui/console-priv.h      |   2 +-
 ui/console-vc-stubs.c  |   2 +-
 ui/console-vc.c        |   7 +--
 ui/console.c           | 133 ++++++++++-------------------------------
 ui/curses.c            |  48 ++++++++-------
 ui/kbd-state.c         |   6 ++
 ui/vnc.c               |  14 +++--
 ui/cocoa.m             |  37 ++++++++----
 ui/meson.build         |   3 +-
 11 files changed, 119 insertions(+), 146 deletions(-)

-- 
2.44.0


