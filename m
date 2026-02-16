Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF259E7BD92
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 11:23:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrwfP-0006iP-6Z; Mon, 16 Feb 2026 06:21:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vrwd4-0007T9-Pc
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 06:19:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vrwd3-0008QH-6H
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 06:19:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771240740;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KAKt4CvCFG4mzYabTt4mTrA6Ft2BKrJ6zjij58RhywI=;
 b=WbaZA+hZvZYNQCRebrRamKW6qmueZupDti499s0u3u1ja+6Xqoop8jbVcQocHZUsB/LwCS
 PdVs7L71WAOjGJ21xs2S5rCpIlMzUauPqpdsq7aK+tabvOYmNJ8Gx7ZB2wjOAd0AXp1Wll
 UZUcHXBRMnhv0Whgme7bGng/89KJb6s=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-711-AQUHFmnfNzyCJtRKh0ofKg-1; Mon,
 16 Feb 2026 06:18:57 -0500
X-MC-Unique: AQUHFmnfNzyCJtRKh0ofKg-1
X-Mimecast-MFC-AGG-ID: AQUHFmnfNzyCJtRKh0ofKg_1771240735
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 47DE51956060; Mon, 16 Feb 2026 11:18:55 +0000 (UTC)
Received: from localhost (unknown [10.45.242.26])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 01CD51955F22; Mon, 16 Feb 2026 11:18:53 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 16 Feb 2026 12:15:59 +0100
Subject: [PATCH 70/85] audio/spice: remove unused AUDIO_CAP macro
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260216-audio-v1-70-e676662e4514@redhat.com>
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
 Thomas Huth <thuth@redhat.com>, 
 Mark Cave-Ayland <mark.caveayland@nutanix.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=598;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=MqZZlsSA5odZdvc1Tj/JSrGEReLFTmuCGtE0H89M0aU=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBpkvxRq4+gwTPcAd8pPhRDmKamOxBfo6hpEYoxU
 th3CL7Fh7yJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaZL8UQAKCRDa6OEJdZac
 5ReJD/oDDMnZtfu+31bPvGH23DEWjsilPkIZqvDFleSu1VWYCqFLa2EesvLSR4rTt7xDDitfaU7
 WV98YXuj+ZssBOXHXBKDtpFCSTSPMHwjFHqa1vmCeAxOPd/x5Ju0U2ZQddJxsdRWv2Lrjq5yL3X
 n+o3ddftwnrnxp3VaIJcqlFVVe3bVvqckIlubggbsnfq/EBOQ6ibGk4KDx5zJmw7LtjVeiJfIoy
 XPfOkx8kvvATM7KMBEfvf5inrxjx+txca2YQmnaNzHWXPmqL0wzj9pHELL2yKGpf6YGtg2H4WHc
 b+3oK/EfKC11tQANh0JKngnTFCEV/COfXS0CXgdrgGRSF7mv8xO9PuqyqHzH9ahntyWTHMLZuur
 Eitpb6fmcKCYGM06dMFHZDCe8ROCM6godaS/Fpnbf40EH9EQrZEcenDc2Ol2IHMWQSYIsttbc1y
 JntkUsTcqTfkvYqb7HnndX0Dql6ErjCSlboMA6EWr/X41NbFhG4/WL0k6gGotsVCcx/l7RLu20q
 gz2o7l+5aszzEKMa76YKUliQgUQyW3Fd0wkweJBgtxzsOCDFgy8Icl3LseE8nDAD2STK+hUOyG/
 I7JHo0u1164yCzQx3XZMukynLckdTdM/qxqIlFtK3ifkTUwmBdhxqEb9zWU1xOlFkaEdTPP240+
 17eWOOQHjc147EQ==
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

The AUDIO_CAP macro is no longer used.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 audio/spiceaudio.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/audio/spiceaudio.c b/audio/spiceaudio.c
index 0d188e974df..81b897e13e0 100644
--- a/audio/spiceaudio.c
+++ b/audio/spiceaudio.c
@@ -26,7 +26,6 @@
 #include "ui/qemu-spice.h"
 #include "qom/object.h"
 
-#define AUDIO_CAP "spice"
 #include "qemu/audio.h"
 #include "audio_int.h"
 

-- 
2.53.0


