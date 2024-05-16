Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5C63C41513
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2024 12:04:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7Zq3-000541-DG; Thu, 16 May 2024 08:04:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1s7Zpv-0004ou-Lw
 for qemu-devel@nongnu.org; Thu, 16 May 2024 08:03:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1s7Zpt-0002MZ-NU
 for qemu-devel@nongnu.org; Thu, 16 May 2024 08:03:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715861028;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=btascmwPfzshfylir9GHZPwnSspZ6zjAl2C6mlFN2Ok=;
 b=ePaGnK6Y2mIP4BX4khOMFCYoNITM0hkjgfSgaZIITVJTRPzbB/mylD/UT3+cOK812wVJu6
 N1j8RLBj12DiZIFduKtaBFu73A4yN4m7HbFcqJRjuGY27EWExC3DJVxtBUYewIOG6oSV9z
 WUKMleSKVJNHHOvx7xAoPEimi9bp2T4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-682-q-miH_zwMJKFNMRDOXbJjw-1; Thu,
 16 May 2024 08:03:47 -0400
X-MC-Unique: q-miH_zwMJKFNMRDOXbJjw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 683EC3C025BF
 for <qemu-devel@nongnu.org>; Thu, 16 May 2024 12:03:46 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.119])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0966DC15BC3;
 Thu, 16 May 2024 12:03:45 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id CFDAA1800DFD; Thu, 16 May 2024 14:03:44 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH 1/4] MAINTAINERS: drop audio maintainership
Date: Thu, 16 May 2024 14:03:38 +0200
Message-ID: <20240516120344.531521-2-kraxel@redhat.com>
In-Reply-To: <20240516120344.531521-1-kraxel@redhat.com>
References: <20240516120344.531521-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.022,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 MAINTAINERS | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1b79767d6196..7f52e2912fc3 100644
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
@@ -2388,7 +2387,6 @@ F: hw/virtio/virtio-mem-pci.c
 F: include/hw/virtio/virtio-mem.h
 
 virtio-snd
-M: Gerd Hoffmann <kraxel@redhat.com>
 R: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
 S: Supported
 F: hw/audio/virtio-snd.c
@@ -2767,7 +2765,6 @@ F: include/hw/hyperv/hv-balloon.h
 Subsystems
 ----------
 Overall Audio backends
-M: Gerd Hoffmann <kraxel@redhat.com>
 M: Marc-André Lureau <marcandre.lureau@redhat.com>
 S: Odd Fixes
 F: audio/
@@ -2783,13 +2780,11 @@ X: audio/spiceaudio.c
 F: qapi/audio.json
 
 ALSA Audio backend
-M: Gerd Hoffmann <kraxel@redhat.com>
 R: Christian Schoenebeck <qemu_oss@crudebyte.com>
 S: Odd Fixes
 F: audio/alsaaudio.c
 
 Core Audio framework backend
-M: Gerd Hoffmann <kraxel@redhat.com>
 M: Philippe Mathieu-Daudé <philmd@linaro.org>
 R: Christian Schoenebeck <qemu_oss@crudebyte.com>
 R: Akihiko Odaki <akihiko.odaki@daynix.com>
@@ -2797,34 +2792,28 @@ S: Odd Fixes
 F: audio/coreaudio.c
 
 DSound Audio backend
-M: Gerd Hoffmann <kraxel@redhat.com>
-S: Odd Fixes
+S: Orphan
 F: audio/dsound*
 
 JACK Audio Connection Kit backend
-M: Gerd Hoffmann <kraxel@redhat.com>
 R: Christian Schoenebeck <qemu_oss@crudebyte.com>
 S: Odd Fixes
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
 R: Thomas Huth <huth@tuxfamily.org>
 S: Odd Fixes
 F: audio/sdlaudio.c
 
 Sndio Audio backend
-M: Gerd Hoffmann <kraxel@redhat.com>
 R: Alexandre Ratchov <alex@caoua.org>
 S: Odd Fixes
 F: audio/sndioaudio.c
-- 
2.45.0


