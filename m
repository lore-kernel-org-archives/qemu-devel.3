Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E649BE7BD92
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 11:17:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrwaC-0004oZ-7b; Mon, 16 Feb 2026 06:16:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vrwaB-0004oD-7f
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 06:16:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vrwa9-0007L3-Lb
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 06:16:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771240560;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6VfogaPHf/Z+L9b7Y13bG+eABGPqx21qH8NhHT2gnNM=;
 b=ZRdcPn2HvthbVQ/y7WN6l6RlTIIwsqkvkUHLfGzuhl0iSsDOq1BilCLmqU/7/hpzPoJqKl
 aFah+7n/2D02jMisj2XUp7CfItOYAM5eVMrWzrTjFLyr3GPqTVAVMWcf5EpMBEsDayrU50
 Ao4H9/9+gXKamFHXPZV5WLX/cf1dvgU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-372-1y5fjROjOhSx0_O4i7YO0g-1; Mon,
 16 Feb 2026 06:15:56 -0500
X-MC-Unique: 1y5fjROjOhSx0_O4i7YO0g-1
X-Mimecast-MFC-AGG-ID: 1y5fjROjOhSx0_O4i7YO0g_1771240554
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 827551955D88; Mon, 16 Feb 2026 11:15:54 +0000 (UTC)
Received: from localhost (unknown [10.45.242.26])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D7F7D1955F43; Mon, 16 Feb 2026 11:15:53 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 16 Feb 2026 12:14:55 +0100
Subject: [PATCH 06/85] qemu-options.hx: document -audiodev dbus
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260216-audio-v1-6-e676662e4514@redhat.com>
References: <20260216-audio-v1-0-e676662e4514@redhat.com>
In-Reply-To: <20260216-audio-v1-0-e676662e4514@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1123;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=4z4LECFy6R6KVgt/u7UO4ATuY8GKjOnvDAw3YOWYVi0=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBpkvxOX9kHbpwVs6KRYut1JR49y+n4qjf3d4FLe
 Uq3KmX5bW6JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaZL8TgAKCRDa6OEJdZac
 5fVjD/0QMFFJ51oD2c3FzFYpoiB86kipeqVkr7ZkvssaX1+/e9cy2N40gzdDpNZbaG4pQ+7qIsR
 OjFz+Luvr77Tu9a9M8Hd9/eGHmCf0OxR7cmnbX/dIGUCMpAC9u+gb3SYYZscprQy/CkeGvglvfC
 nEBF0JcPWy3kJeMLREXG5fGnqzxV5BB++G3jRsX0Fsug+rNrKcKADcgbc07xcZt9CQ1NFq08srv
 rSKx8eGoWqMARcf6dEUC/25ANxwPrvSxF3Zo6HWC479TX/rSz1/9VvchbT2QC5ieCr6/45DfBG+
 eU4yY6E55P+D6QH6sAG4qI7r0xgXF+0HZJGQdXjooYldcW7IW/bAekD3jI+uWDycRXTsboQur/O
 CQBUh+w+nv/F9iCxTz5vgWhisJEJSUvt8VlzA+wAcUH4LPwygVP/zTv0Wi9fOxQ1FU++qcDPbrl
 5ilGfjW6JYJncutW9Oxgm9QRPJVp09vlQKhcJgh+GkT2p0T7iISVDMk+awSGgu0Idf2yN9TpT4O
 Pv65ULbh97FeWsb0eBpOGbxERK6r+WRxMZpOFobBKI5u3y9lLnAnF3SGhNxA/FDm2WPp1wvh41z
 5KuAWeAKVz4awzixS7Ykxz6TezB4eH6Bns8jee86JnUw8Qxm5W8bqCVkDiCBaWpdtNMj/7kWK0i
 eUeORBX/6QEveLQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Document the backend introduced in commit 739362d420 ("audio: add dbus
audio backend").

Reported-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 qemu-options.hx | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/qemu-options.hx b/qemu-options.hx
index 15a6f82043a..4043e8ca22b 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -991,6 +991,16 @@ SRST
     ``in|out.buffer-count=count``
         Sets the count of the buffers.
 
+``-audiodev dbus,id=id[,prop[=value][,...]]``
+    Creates a D-Bus backend. It must be associated with the display
+    (as ``-display dbus,audiodev=id``). (Since 7.0)
+
+    D-Bus specific options are:
+
+    ``nsamples``
+        Number of samples per read/write (default to 480, 10ms at 48kHz)
+        (Since 10.0)
+
 ``-audiodev dsound,id=id[,prop[=value][,...]]``
     Creates a backend using Microsoft's DirectSound. This backend is
     only available on Windows and only supports playback.

-- 
2.53.0


