Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A867EA8125
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Feb 2026 10:03:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vq73h-000225-2i; Wed, 11 Feb 2026 05:02:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vq73f-0001z4-BG
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 05:02:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vq73d-00030I-UM
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 05:02:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770804173;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v0SXmEDgt8/QS4j/02ba1AXKjoxQK3k0C6NOloFx5kw=;
 b=HOPtmjExq3GxvYKfZ8I3MyP4nzn25F/Ch+KWXwJiu2hU4jl74RGC31ZQmX+jfKfgG5z97O
 qqpGZ3w6Q8rlZlPYWut6BknVS9tCvo3h6OabwrR0VPOc7+xogUXrUVrm21a8EPiI7XjEsg
 5haNngKcxAiAE4/TyMsv6aYDoZst+qU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-530-7U8O4kaeMr6Hw4GPwh1cMw-1; Wed,
 11 Feb 2026 05:02:51 -0500
X-MC-Unique: 7U8O4kaeMr6Hw4GPwh1cMw-1
X-Mimecast-MFC-AGG-ID: 7U8O4kaeMr6Hw4GPwh1cMw_1770804171
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 197C11955F4A; Wed, 11 Feb 2026 10:02:51 +0000 (UTC)
Received: from localhost (unknown [10.45.242.6])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D040919560A3; Wed, 11 Feb 2026 10:02:49 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 11 Feb 2026 14:01:47 +0400
Subject: [PATCH 7/7] ui: drop spice-protocol < 0.14.3 support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260211-cleanups-v1-7-e63c96572389@redhat.com>
References: <20260211-cleanups-v1-0-e63c96572389@redhat.com>
In-Reply-To: <20260211-cleanups-v1-0-e63c96572389@redhat.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, John Snow <jsnow@redhat.com>, 
 Cleber Rosa <crosa@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3170;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=RmCRz9pwEdGph6yjFIISGk7vRZ5xaJGIfyeES2mQ2kM=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBpjFOVuYfCNcKHfqwcDptepKoG4SL4rJi4RIrCZ
 nCyatGyjs2JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaYxTlQAKCRDa6OEJdZac
 5RasD/4kFZnML0OJkYl1Q9NqTBWFx/1Lkm87tZ47P7wIP91jAmFwagI9LMMGtRuyU7mzLU7EOiW
 C7XlFYFWfblcTmhpBQ9m3rrLh4R/2Uc6hjqeu9qYzYM4vCKN9m9aL9PTB3D+zGXRUVlq1hFy8Fi
 7yxa3HdNIYYoflrz92tziik19wlOPdupzXZFPfPQmjmkgkWATeHm8UqVTWFe3thfBrL8862g4rR
 B0t55KazP/Nr6bUQML3qVh+k6/7wZUmhNjLuOcYfAppgfGKEPMeCxJhPXjyT5+bJedZO11gl4Ls
 DQT0aLAVN+Jw7ybQnDHXZOp5tDSutkArDdtgET6KsZYTllv8GzioiWR/TWyfYFxTtekcdVP2zdY
 wz0wPT2xUQWWF9ghKQ68Qr24x6yXVu55DYsA6qCxP2yv+mKyVe4GaBCAijynHPetxkwuXwNer2F
 PKcEKCjgfFqWt8G4foQoCo6QW3jebg9ynewefgltcaESz2X942kyqRZ0cqMQEYCSFDx8BxIHcKs
 gRM6F4b3Q6XThQC4OdW55XPxc2rXQrCEWezLd2ybVEut6Eg78WlxVfAgLvDVeDuatBaQ8YfJtbL
 DTtYqCBe3tW8WP6q2FML6dZBeKNUANAUp6D013d66V+l+CTEugdmDDc24dKcHkPrxCPlWd1kqbW
 LE8sbVs3W8mAJgQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

According to repology, all our supported distributions have 0.14.3.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 meson.build  |  2 +-
 ui/vdagent.c | 18 ------------------
 2 files changed, 1 insertion(+), 19 deletions(-)

diff --git a/meson.build b/meson.build
index 5c3e138309f..e8c0d02a839 100644
--- a/meson.build
+++ b/meson.build
@@ -1310,7 +1310,7 @@ endif
 
 spice_protocol = not_found
 if not get_option('spice_protocol').auto() or have_system
-  spice_protocol = dependency('spice-protocol', version: '>=0.14.0',
+  spice_protocol = dependency('spice-protocol', version: '>=0.14.3',
                               required: get_option('spice_protocol'),
                               method: 'pkg-config')
 endif
diff --git a/ui/vdagent.c b/ui/vdagent.c
index 142a3691ac9..d3534928617 100644
--- a/ui/vdagent.c
+++ b/ui/vdagent.c
@@ -17,14 +17,6 @@
 
 #include "spice/vd_agent.h"
 
-#define CHECK_SPICE_PROTOCOL_VERSION(major, minor, micro) \
-    (CONFIG_SPICE_PROTOCOL_MAJOR > (major) ||             \
-     (CONFIG_SPICE_PROTOCOL_MAJOR == (major) &&           \
-      CONFIG_SPICE_PROTOCOL_MINOR > (minor)) ||           \
-     (CONFIG_SPICE_PROTOCOL_MAJOR == (major) &&           \
-      CONFIG_SPICE_PROTOCOL_MINOR == (minor) &&           \
-      CONFIG_SPICE_PROTOCOL_MICRO >= (micro)))
-
 #define VDAGENT_BUFFER_LIMIT (1 * MiB)
 #define VDAGENT_MOUSE_DEFAULT true
 #define VDAGENT_CLIPBOARD_DEFAULT false
@@ -87,10 +79,8 @@ static const char *cap_name[] = {
     [VD_AGENT_CAP_FILE_XFER_DISABLED]             = "file-xfer-disabled",
     [VD_AGENT_CAP_FILE_XFER_DETAILED_ERRORS]      = "file-xfer-detailed-errors",
     [VD_AGENT_CAP_GRAPHICS_DEVICE_INFO]           = "graphics-device-info",
-#if CHECK_SPICE_PROTOCOL_VERSION(0, 14, 1)
     [VD_AGENT_CAP_CLIPBOARD_NO_RELEASE_ON_REGRAB] = "clipboard-no-release-on-regrab",
     [VD_AGENT_CAP_CLIPBOARD_GRAB_SERIAL]          = "clipboard-grab-serial",
-#endif
 };
 
 static const char *msg_name[] = {
@@ -125,9 +115,7 @@ static const char *type_name[] = {
     [VD_AGENT_CLIPBOARD_IMAGE_BMP]  = "bmp",
     [VD_AGENT_CLIPBOARD_IMAGE_TIFF] = "tiff",
     [VD_AGENT_CLIPBOARD_IMAGE_JPG]  = "jpg",
-#if CHECK_SPICE_PROTOCOL_VERSION(0, 14, 3)
     [VD_AGENT_CLIPBOARD_FILE_LIST]  = "files",
-#endif
 };
 
 #define GET_NAME(_m, _v) \
@@ -197,9 +185,7 @@ static void vdagent_send_caps(VDAgentChardev *vd, bool request)
     if (vd->clipboard) {
         caps->caps[0] |= (1 << VD_AGENT_CAP_CLIPBOARD_BY_DEMAND);
         caps->caps[0] |= (1 << VD_AGENT_CAP_CLIPBOARD_SELECTION);
-#if CHECK_SPICE_PROTOCOL_VERSION(0, 14, 1)
         caps->caps[0] |= (1 << VD_AGENT_CAP_CLIPBOARD_GRAB_SERIAL);
-#endif
     }
 
     caps->request = request;
@@ -318,11 +304,7 @@ static bool have_selection(VDAgentChardev *vd)
 
 static bool have_clipboard_serial(VDAgentChardev *vd)
 {
-#if CHECK_SPICE_PROTOCOL_VERSION(0, 14, 1)
     return vd->caps & (1 << VD_AGENT_CAP_CLIPBOARD_GRAB_SERIAL);
-#else
-    return false;
-#endif
 }
 
 static uint32_t type_qemu_to_vdagent(enum QemuClipboardType type)

-- 
2.52.0


