Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A1A4E7BD8A
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 10:44:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrw4W-0001yL-3d; Mon, 16 Feb 2026 05:43:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vrw4F-0001rt-Rv
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 05:43:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vrw4B-00010M-4l
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 05:43:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771238577;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VuljhDTSEvIRuZWMVHmH3upAs1bYNZiEpsxb8H2Doiw=;
 b=g1LGkFIofSo2YcpksOqVIjTzfppHu5V9gAf55vR3asMZxHy+xV0SO7cFHg9Ba1Sb0CYTCi
 9bEoEcp5/lU1ClMiEBHlJ/7P05VUrGMU52anWnpEbbIW8v9UnCxeTVJrwbgYok5FFr9+qp
 JWVK3q2lsb0+Xi3YgWcJUXMeX1aiKBI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-395-DI8jQAtxNm2liszE9Jmi_Q-1; Mon,
 16 Feb 2026 05:42:54 -0500
X-MC-Unique: DI8jQAtxNm2liszE9Jmi_Q-1
X-Mimecast-MFC-AGG-ID: DI8jQAtxNm2liszE9Jmi_Q_1771238572
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CE95118005AD; Mon, 16 Feb 2026 10:42:52 +0000 (UTC)
Received: from localhost (unknown [10.45.242.26])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D9D901800464; Mon, 16 Feb 2026 10:42:51 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 16 Feb 2026 11:42:17 +0100
Subject: [PATCH 05/85] qemu-options.hx: clarify default audio backend selection
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260216-audio-v1-5-edcb25699381@redhat.com>
References: <20260216-audio-v1-0-edcb25699381@redhat.com>
In-Reply-To: <20260216-audio-v1-0-edcb25699381@redhat.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>, 
 Christian Schoenebeck <qemu_oss@crudebyte.com>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Thomas Huth <huth@tuxfamily.org>, Alexandre Ratchov <alex@caoua.org>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Laurent Vivier <laurent@vivier.eu>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, 
 Alistair Francis <alistair@alistair23.me>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Mark Cave-Ayland <mark.caveayland@nutanix.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2296;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=pQYsT12b6ItIPMgGRIh+ZR0w15tO/zqPK/vSleMzRTE=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBpkvSTBOfJ/9SFd00hU+d4HgN6JlR7V3z1yuoXo
 Lac8f6pwwmJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaZL0kwAKCRDa6OEJdZac
 5R+2D/0TLc+WTe4qBJYFVIDZIMkPAN1j2BU6sH0K53CF16dBBTyJUhiB4sqBlhzBWTvvhXN9pTj
 CVJ+CxN/vwy8ezQQD5+4cFJ6stUvBIdDxSxdwVxo0r96RXsJG7HcmxsEBSr4XgpW+CVQsf7vhrK
 41lud5X25QWwG50DnDGBzvObQ09YKvLz1INnfX6BnZyqhCG4ZyNgpONuc+z4GwPcZQ5CNSdih+A
 RuvNUTNkw0IMDoGzBu/MgdfJZ2Z5wigLnEytoONcw+jEweKJ9c326oabVfX8pgwlq92ro/0nai4
 nW+St4zidsLLBio6H3WeAEgm6pBlPFo/T5If/g3ky/WKGY8rB1TVHAbh5uQL6Dn7zwgsJnll9AL
 UdNxD8aVfJbG2JWKYgvfA0XBhlwJcNLp0CVb2VyoZcEmOJoOlzJRxvBh1HzoWn7rOAGpwstl/HN
 x66P3ZyWTgSCxCZ4o00iAtPyg38cjaG5zFArD+Iy7ameiBb5Ehy3DJaat2k8jJLbIAUwGwOJoqg
 puGZys1oRcgoeECV3nGVlMoxnkLypLUm1DJbZkEnIf+Foj5C7ApyWKD6HSZYm1DLWXI35sgp+SF
 j7zP3KlXgCITrmjD/+PeF54ZrMNSJebVGShZr01cWErbxvqRKlGhN+MykbXOvAnGXK+yeJGPBdG
 hRmqyM9XQRM7S6w==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 qemu-options.hx | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index 33fcfe7ce66..15a6f82043a 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -896,11 +896,16 @@ DEF("audiodev", HAS_ARG, QEMU_OPTION_audiodev,
     QEMU_ARCH_ALL)
 SRST
 ``-audiodev [driver=]driver,id=id[,prop[=value][,...]]``
-    Adds a new audio backend driver identified by id. There are global
-    and driver specific properties. Some values can be set differently
-    for input and output, they're marked with ``in|out.``. You can set
-    the input's property with ``in.prop`` and the output's property with
-    ``out.prop``. For example:
+    Adds a new audio backend driver identified by id.
+
+    If no audio backend is specified, QEMU will attempt to select a
+    default one. The ``-display`` option may influence which backend is
+    selected.
+
+    There are global and driver specific properties. Some values can be
+    set differently for input and output, they're marked with ``in|out.``.
+    You can set the input's property with ``in.prop`` and the output's
+    property with ``out.prop``. For example:
 
     ::
 
@@ -2198,8 +2203,11 @@ DEF("display", HAS_ARG, QEMU_OPTION_display,
     , QEMU_ARCH_ALL)
 SRST
 ``-display type``
-    Select type of display to use. Use ``-display help`` to list the available
-    display types. Valid values for type are
+    Select type of display to use. This may also influence the default
+    audio backend selection.
+
+    Use ``-display help`` to list the available display types. Valid values
+    for type are
 
     ``spice-app[,gl=on|off]``
         Start QEMU as a Spice server and launch the default Spice client
@@ -2209,6 +2217,9 @@ SRST
     ``dbus``
         Export the display over D-Bus interfaces. (Since 7.0)
 
+        If no audio backend is specified and the dbus display backend is
+        specified, the dbus audio backend is used by default.
+
         The connection is registered with the "org.qemu" name (and queued when
         already owned).
 

-- 
2.53.0


