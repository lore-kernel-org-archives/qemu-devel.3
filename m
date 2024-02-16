Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BA6AC48BC4
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Feb 2024 13:33:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rayKg-0008Cd-1C; Fri, 16 Feb 2024 08:32:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1rayKC-00084n-Ad
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 08:32:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1rayK6-0006L4-GS
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 08:32:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708090333;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9xERhRwKbIVSH1kZ3wUuvCZ99kxdJayCqnBZCzWQc+g=;
 b=WYYu4/zxOI7XyTEQZG36fNFsl8aCUw+xo4Xn+sd8qPpYPYO9L6PwBMFlCkPg1W+7uMZTcl
 Ko3DwR3kfHUNWoj4DAXABH+e2MBHYbVFIw6sCOgcjteweUfLRaPputerq0ruI+quKrjoTI
 iPnK+PSDz1c3Ig1Wg/cLE5B74O7HLD0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-684-b7K0WYAKORWRct-aDh5jSA-1; Fri,
 16 Feb 2024 08:32:12 -0500
X-MC-Unique: b7K0WYAKORWRct-aDh5jSA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C92B4380406C;
 Fri, 16 Feb 2024 13:32:11 +0000 (UTC)
Received: from localhost (unknown [10.39.208.8])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 85CB7C1596E;
 Fri, 16 Feb 2024 13:32:10 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, peter.maydell@linaro.org,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 5/7] audio: Depend on dbus_display1_dep
Date: Fri, 16 Feb 2024 17:31:38 +0400
Message-ID: <20240216133140.3611100-6-marcandre.lureau@redhat.com>
In-Reply-To: <20240216133140.3611100-1-marcandre.lureau@redhat.com>
References: <20240216133140.3611100-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.364,
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

dbusaudio needs dbus_display1_dep.

Fixes: 739362d4205c ("audio: add "dbus" audio backend")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20240214-dbus-v7-1-7eff29f04c34@daynix.com>
---
 audio/meson.build | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/audio/meson.build b/audio/meson.build
index c8f658611f..608f35e6af 100644
--- a/audio/meson.build
+++ b/audio/meson.build
@@ -30,7 +30,8 @@ endforeach
 
 if dbus_display
     module_ss = ss.source_set()
-    module_ss.add(when: [gio, pixman], if_true: files('dbusaudio.c'))
+    module_ss.add(when: [gio, dbus_display1_dep, pixman],
+                  if_true: files('dbusaudio.c'))
     audio_modules += {'dbus': module_ss}
 endif
 
-- 
2.43.1


