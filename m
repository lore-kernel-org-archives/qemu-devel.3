Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60A9FC48297
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 14:05:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXM3u-0006Dc-MD; Tue, 06 Feb 2024 09:04:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1rXM3r-0006DC-FH
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 09:04:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1rXM3p-0007uc-QK
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 09:04:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707228266;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=1zwSNPblTFu9Lu7ICtex6ohX2BBTdBGcFoFqeSJtNdk=;
 b=SakNNeweFkUmerTjswaiw85FpjZqCWut6rJnEvYM0F6Bo0PUQle72Bef1mUtXnQp3ckzye
 B8Radplkj9xloVl/vju965BO9Gm07+dRJJIeL/Az0fVF+YpqPN86S5y2LqUnj3y90I+vlk
 DCXsrJC2XDPwHgdjfYd08XQ+TIl9bW0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-455-KprnCSXuNfmrluKhahH_jA-1; Tue, 06 Feb 2024 09:04:18 -0500
X-MC-Unique: KprnCSXuNfmrluKhahH_jA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E4D5C185A795;
 Tue,  6 Feb 2024 14:04:17 +0000 (UTC)
Received: from localhost (unknown [10.39.208.3])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B815D2166B32;
 Tue,  6 Feb 2024 14:04:16 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: mjt@tls.msk.ru,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH] build-sys: add the D-Bus generated header to the dependency
Date: Tue,  6 Feb 2024 18:04:14 +0400
Message-ID: <20240206140414.1134857-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.294,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Fixes:
   rm -rf b; cd b
  ../configure --enable-modules --target-list=x86_64-softmmu
  ninja qemu-system-x86_64

   In file included from ../ui/dbus-chardev.c:34:
  ../ui/dbus.h:34:10: fatal error: ui/dbus-display1.h: No such file or directory
     34 | #include "ui/dbus-display1.h"
        |          ^~~~~~~~~~~~~~~~~~~~
  compilation terminated.

See also:
https://github.com/mesonbuild/meson/issues/12814

Reported-by: Tokarev, Michael <mjt@tls.msk.ru>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/meson.build | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/ui/meson.build b/ui/meson.build
index 376e0d771b..fa47360830 100644
--- a/ui/meson.build
+++ b/ui/meson.build
@@ -91,7 +91,9 @@ if dbus_display
                                           '--c-namespace', 'QemuDBus',
                                           '--generate-c-code', '@BASENAME@'])
   dbus_display1_lib = static_library('dbus-display1', dbus_display1, dependencies: gio)
-  dbus_display1_dep = declare_dependency(link_with: dbus_display1_lib, include_directories: include_directories('.'))
+  dbus_display1_dep = declare_dependency(link_with: dbus_display1_lib,
+                                         include_directories: include_directories('.'),
+                                         sources: dbus_display1[0])
   dbus_ss.add(when: [gio, dbus_display1_dep],
               if_true: [files(
                 'dbus-chardev.c',
-- 
2.43.0


