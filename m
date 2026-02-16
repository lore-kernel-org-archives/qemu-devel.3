Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7494E7BD98
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 11:22:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrwfe-0000Ia-Dv; Mon, 16 Feb 2026 06:21:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vrwcp-0007AM-Ia
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 06:18:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vrwcn-0008IF-Ql
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 06:18:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771240724;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ESVl7hrPW6399tVk+EQUGmjKjUQ+e3r5I81ZjO955hM=;
 b=WxitHbsmSjMM2b+49J3z7E4jeHExDlNL9YtJJgZqO1QJFooysCcqjYh1XCarugsXkxUVIG
 tjIrYTwCkTJI80UeEYIBiv7ZUXzALFiF5+K4BhJZ1+4mYR5FCFOzoWDyqi8104FcKpR50q
 aAMhDYU7pAtiIbZ7NgHTXYLvO0zQ6lY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-681-rlQ0flM9PCaOP741xb7FmQ-1; Mon,
 16 Feb 2026 06:18:40 -0500
X-MC-Unique: rlQ0flM9PCaOP741xb7FmQ-1
X-Mimecast-MFC-AGG-ID: rlQ0flM9PCaOP741xb7FmQ_1771240719
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EF0C71956094; Mon, 16 Feb 2026 11:18:38 +0000 (UTC)
Received: from localhost (unknown [10.45.242.26])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 533741955F43; Mon, 16 Feb 2026 11:18:38 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 16 Feb 2026 12:15:53 +0100
Subject: [PATCH 64/85] audio/noaudio: remove unused AUDIO_CAP macro
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260216-audio-v1-64-e676662e4514@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=508;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=JtGKRFxHxWAyAWIxjSqifHUPbgYk6YcOPZOxE1yLVOI=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBpkvxRVNsCBTWWg1tNNteGSBiz0njwgCY6FRIH3
 nMd4+9LO9CJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaZL8UQAKCRDa6OEJdZac
 5QxZEACzT4G4yQQQQRGAk7dVAbUYTLYD8UPVGICeTbv6NcHVunbOtcVdjjeOTrktoBGCXXro3L/
 s7pjtgyI2h9+nxdLlYqSgg58ggPdq1Eb0kF974IiaO+pqd+tZwr2btWOcPZLl9fa8rSpJjP2y3H
 5itX379LrSMcqd4J+OSzKwi76OYwzQaSYUnIJptdJKhp8WaWIVaeHcbTSGtFh/nK3y8glVAXj1+
 DRXaC62konBMk04aSuqcl7rOqykM0utLqBZNlwZdiCqfAvlKHln06SRKGgu3vIbSfZf3tX4MYah
 5F8B8Z1il+3ssIEnVdW+uAXi4oOBDTG60LeATSdoO+7jQ1mPVf0qCUIac2rknTiKtMjf+I91jR4
 d8Nl+hwVKrnLyZV6LtP4C+Ou19Jf32P/SJfjpMZ1HCwGKsNSZKFqWOCbK/9TRl88c0U3YZtdLRT
 0861nTq3twPkZaOsOlupjLpbnvmoB+pBq0BJFzUggW6jFNr90AjWQD+84XqhkBVWKvqOVRHCV9F
 mbbudDujqvRBkWg725+ANpP3AKbOnz29l1pC0vQ0+RTnWj0fpOzkC7CTfGxIasdXbSjaKSNhYbd
 qeUJE4YOT/A+fpMkB47QNgbu16fw+ieBBd7PkVZzS4lnV1+KXob6hcdNMZgsbdUHgwMqiaiaQR/
 cGGYVk6ZPANZvCw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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
 audio/noaudio.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/audio/noaudio.c b/audio/noaudio.c
index e056813181a..70316c572ec 100644
--- a/audio/noaudio.c
+++ b/audio/noaudio.c
@@ -27,7 +27,6 @@
 #include "qemu/audio.h"
 #include "qom/object.h"
 
-#define AUDIO_CAP "noaudio"
 #include "audio_int.h"
 
 #define TYPE_AUDIO_NONE "audio-none"

-- 
2.53.0


