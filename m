Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A126DE7BD94
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 11:17:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrwa9-0004nm-BF; Mon, 16 Feb 2026 06:16:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vrwa7-0004n6-Pj
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 06:15:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vrwa6-0007KO-7g
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 06:15:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771240557;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VuljhDTSEvIRuZWMVHmH3upAs1bYNZiEpsxb8H2Doiw=;
 b=Pvdao70vnUO5Uq4/o4mOlg8qdnWuODknYCMzaIaoWP5Exm36a2iyRwTgbpuCqzrza3PgIF
 qd2+xQgut0bEf4d0T/S55e+xizEwKOc3ZvPHfZFtNY3VW6YbxlVoOmPHPnG7GujrgZyPII
 KAeIY1QRNyU3GoKeXtKrrNICW08FIWY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-216-iZtgyr17M0iD3JE5wpsMFA-1; Mon,
 16 Feb 2026 06:15:54 -0500
X-MC-Unique: iZtgyr17M0iD3JE5wpsMFA-1
X-Mimecast-MFC-AGG-ID: iZtgyr17M0iD3JE5wpsMFA_1771240552
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D401E1956053; Mon, 16 Feb 2026 11:15:51 +0000 (UTC)
Received: from localhost (unknown [10.45.242.26])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 495551800465; Mon, 16 Feb 2026 11:15:50 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 16 Feb 2026 12:14:54 +0100
Subject: [PATCH 05/85] qemu-options.hx: clarify default audio backend selection
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260216-audio-v1-5-e676662e4514@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2296;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=pQYsT12b6ItIPMgGRIh+ZR0w15tO/zqPK/vSleMzRTE=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBpkvxOb9dt2y32Y/FDaf8C1TrhPWMaFY/kg3NdL
 ZeMYcpsaAeJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaZL8TgAKCRDa6OEJdZac
 5QFRD/0edP1XArxaXBfn+guGHQ9iSZrkUsjvktz6g29yhu91BAjerkh21m2hmdaNTn0rblFj6hP
 g1PYUDV0Kya38dRGf82Hxt45XAn/gU27TaKYSQitnN3fsJOMpXysc0aTdQ15YEPuIxoFKHei0gD
 fN/obH8fBgabgIm4jag4XLFOV5qB8lNgLVPElYY7NEEgi2Y8qYYP0iIZK5+2tIXeHiRMIpfbCYR
 SResGMpbD3IAoJiKJgCgJbxwloo9GkF4xzIJFX9iJ7g9DiX7oU+LZBsvgjg2hcZ7uQZKHENjaUM
 bz/BearoPvN6awCZlUwzAZZycoKil5OE1gXId2Hw2G8sbpGc0Nuto7KA3W1qYBhb+lrd07W3y1f
 ZRJfsWB5qOtRxurDzaaByrok3+zLPh1AbQNU+0itoggb453jM2dnRVSVyfE1dGyhwKMPGm8+ZOc
 KIyJsVCoWfp8JLzRxjbSNJ+7hW7pl+nvxbXSOC/W2K23tnudLFNR2R/v2uTG+fZFtmbxCBzEmf5
 Ii/ycc8ww3VfEtS7g4G8Yf21074CrL+COEtE6ozf501RKT8UOn5guFGOkPB3tJlB4hCoB38p49D
 KlPy0kAaNMwTn5rwVrqSXj0TC2HAQ05cMDLrSBcEhJf8orqXhPnSgH+Ei1aVVrjbd+jwHzDtTk5
 dNtTYqoOOaTP2dQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
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


