Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B885E7BD9D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 11:24:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrwfT-0007Ik-8c; Mon, 16 Feb 2026 06:21:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vrwch-0006yi-Hz
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 06:18:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vrwcf-0008HF-4K
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 06:18:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771240716;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Xu6IN44Xl26WG365YIWkj0v11QMMjFBKKSOTEgL/OKo=;
 b=FqBjWRwrteoN+E5Z0hjQJLl0D+gnkrXp0AJcMqtSI63X+jDDNqs8aEUoUiJhpwi2zI8Pi/
 GTXZ6uamZ0nfyC9u+RIt2EprLZWI2k8ogdMKThxKniHB8XwUM2g9+2NQD34v0c3SG3i3nd
 Y8NLpe2/dioVb8pYYLVN08344BruRHE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-237-umqun_7oP1a-9wJU7Kk8ew-1; Mon,
 16 Feb 2026 06:18:33 -0500
X-MC-Unique: umqun_7oP1a-9wJU7Kk8ew-1
X-Mimecast-MFC-AGG-ID: umqun_7oP1a-9wJU7Kk8ew_1771240711
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 01B6D195FDD4; Mon, 16 Feb 2026 11:18:31 +0000 (UTC)
Received: from localhost (unknown [10.45.242.26])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0945230001B9; Mon, 16 Feb 2026 11:18:29 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 16 Feb 2026 12:15:50 +0100
Subject: [PATCH 61/85] audio/dbus: remove unused AUDIO_CAP macro
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260216-audio-v1-61-e676662e4514@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=697;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=HSzXlEvn+9Pqf0QhfGnLSVpr6ES9PhgZ8mYtZ/b8vd8=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBpkvxR6Oltzeluo61WTkvlTJwqAxD62sHuLolMK
 niVYaK69eSJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaZL8UQAKCRDa6OEJdZac
 5XeSD/9xOSekTswCUq3U/LjjLpbZPRbn82dmWjciigJyIRvhlLO+0hZsWCkr70PqxtDsZfjLOB4
 59YN9qyCVt7Eg//MJjtCBKWor5tXVuRgsCIIIhoKw368vhNKEGARM3CS6WirkMxkXi5KKNVswFB
 FB0jYId4jrTLwUFAtT56PQimwarhdHl9hlc5J0vlUAEbwAcMLJfIL/uGTj7BMbACxyKDdPUPP7T
 Imb3G3dybLp8FNJVIFYc866IZoAS51lkKHHppIvpCKanP8Ujg/5aKmDmV4BwVmbpj0fttZKHp/I
 GU7t914/BmqCjzKR2R9VWkO6p9NO/aXde2gsbLLlmSKzuHs0cW2Hs/zBwA82yo8LW5zLTMSVX8x
 Z4ImSE31FutttSdLEBhZ2POAP8kzau/K4/epu1MIEFAUiMaZHEX8HQ9rHihkK0kosG6z7Ww0CiT
 3zQ/7DOKoPjZy2fVyVWmWDtw5eC1BkxC4kDStfR6VWJDrocYe7u8x2RYVB9p/QoHDcBQ90drKYN
 BTTQp2gv5asZ4i6hhq6/ULe0c+3WY0pRoXTqE7N7FvuHnMLjvKrIWQyuhPyfjcH7vK4VStFYZrV
 HB6y08pmt2FPv69/jQ+9yGK/ZN4xpThR9M3lc+cFiKFZepfL0ea1EqQO0az4RjORvmpzd6wq7Gn
 Kj9A1YDsz6PGh9Q==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
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

The DBus audio backend already uses error_report() for error logging.
Remove the unused AUDIO_CAP macro which was left over from the old
logging infrastructure.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 audio/dbusaudio.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/audio/dbusaudio.c b/audio/dbusaudio.c
index d8e548bf469..5f65c043c16 100644
--- a/audio/dbusaudio.c
+++ b/audio/dbusaudio.c
@@ -36,7 +36,6 @@
 #include "ui/dbus-display.h"
 #include "ui/dbus-display1.h"
 
-#define AUDIO_CAP "dbus"
 #include "qemu/audio.h"
 #include "audio_int.h"
 #include "trace.h"

-- 
2.53.0


