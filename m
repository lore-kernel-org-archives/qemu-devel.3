Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A5E9C27C44
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 08:40:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBsMQ-0002ld-6o; Tue, 28 May 2024 04:39:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1sBsMO-0002iQ-2J
 for qemu-devel@nongnu.org; Tue, 28 May 2024 04:39:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1sBsML-0004ov-Kh
 for qemu-devel@nongnu.org; Tue, 28 May 2024 04:39:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716885545;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=weg/Aislz+ac3i6xP5IcD12fPi9JroAL+i9eQEcypP0=;
 b=CEwwdpeGY7n/Dq1Mz2Gk6cxSU8BUAIhe10ZdrWkK8eaHAGCFzYTMh1uP0Fa/OBhVmM0p42
 Lgntwy1HeWXnCnQYF7nOEwBchwfJKvxza+YFDcYXDjhIrCQBo6lgaBoInOMdFXJtTCQLd0
 5u5wZFWh1HKDXKuilzTZJzu9Ob5LXxM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-412-GwGKj21JN0W27Q8syR_TsQ-1; Tue,
 28 May 2024 04:39:01 -0400
X-MC-Unique: GwGKj21JN0W27Q8syR_TsQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F2C54380670C;
 Tue, 28 May 2024 08:39:00 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.232])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id ABFF7491032;
 Tue, 28 May 2024 08:38:59 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 542451800DCA; Tue, 28 May 2024 10:38:58 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Matias Ezequiel Vara Larsen <mvaralar@redhat.com>,
 Thomas Huth <huth@tuxfamily.org>
Subject: [PATCH v2 1/4] MAINTAINERS: drop audio maintainership
Date: Tue, 28 May 2024 10:38:53 +0200
Message-ID: <20240528083858.836262-2-kraxel@redhat.com>
In-Reply-To: <20240528083858.836262-1-kraxel@redhat.com>
References: <20240528083858.836262-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.034,
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

Remove myself from audio (both devices and backend) entries.
Flip status to "Orphan" for entries which have nobody else listed.

Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
Cc: Thomas Huth <huth@tuxfamily.org>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 MAINTAINERS | 30 ++++++++++--------------------
 1 file changed, 10 insertions(+), 20 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 448dc951c509..58e44885ce94 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1913,8 +1913,7 @@ F: include/hw/xtensa/mx_pic.h
 Devices
 -------
 Overall Audio frontends
-M: Gerd Hoffmann <kraxel@redhat.com>
-S: Odd Fixes
+S: Orphan
 F: hw/audio/
 F: include/hw/audio/
 F: tests/qtest/ac97-test.c
@@ -2389,8 +2388,8 @@ F: hw/virtio/virtio-mem-pci.c
 F: include/hw/virtio/virtio-mem.h
 
 virtio-snd
-M: Gerd Hoffmann <kraxel@redhat.com>
-R: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
+M: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
+R: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
 S: Supported
 F: hw/audio/virtio-snd.c
 F: hw/audio/virtio-snd-pci.c
@@ -2768,7 +2767,6 @@ F: include/hw/hyperv/hv-balloon.h
 Subsystems
 ----------
 Overall Audio backends
-M: Gerd Hoffmann <kraxel@redhat.com>
 M: Marc-André Lureau <marcandre.lureau@redhat.com>
 S: Odd Fixes
 F: audio/
@@ -2784,13 +2782,11 @@ X: audio/spiceaudio.c
 F: qapi/audio.json
 
 ALSA Audio backend
-M: Gerd Hoffmann <kraxel@redhat.com>
 R: Christian Schoenebeck <qemu_oss@crudebyte.com>
-S: Odd Fixes
+S: Orphan
 F: audio/alsaaudio.c
 
 Core Audio framework backend
-M: Gerd Hoffmann <kraxel@redhat.com>
 M: Philippe Mathieu-Daudé <philmd@linaro.org>
 R: Christian Schoenebeck <qemu_oss@crudebyte.com>
 R: Akihiko Odaki <akihiko.odaki@daynix.com>
@@ -2798,36 +2794,30 @@ S: Odd Fixes
 F: audio/coreaudio.c
 
 DSound Audio backend
-M: Gerd Hoffmann <kraxel@redhat.com>
-S: Odd Fixes
+S: Orphan
 F: audio/dsound*
 
 JACK Audio Connection Kit backend
-M: Gerd Hoffmann <kraxel@redhat.com>
 R: Christian Schoenebeck <qemu_oss@crudebyte.com>
-S: Odd Fixes
+S: Orphan
 F: audio/jackaudio.c
 
 Open Sound System (OSS) Audio backend
-M: Gerd Hoffmann <kraxel@redhat.com>
-S: Odd Fixes
+S: Orphan
 F: audio/ossaudio.c
 
 PulseAudio backend
-M: Gerd Hoffmann <kraxel@redhat.com>
-S: Odd Fixes
+S: Orphan
 F: audio/paaudio.c
 
 SDL Audio backend
-M: Gerd Hoffmann <kraxel@redhat.com>
-R: Thomas Huth <huth@tuxfamily.org>
+M: Thomas Huth <huth@tuxfamily.org>
 S: Odd Fixes
 F: audio/sdlaudio.c
 
 Sndio Audio backend
-M: Gerd Hoffmann <kraxel@redhat.com>
 R: Alexandre Ratchov <alex@caoua.org>
-S: Odd Fixes
+S: Orphan
 F: audio/sndioaudio.c
 
 Block layer core
-- 
2.45.1


