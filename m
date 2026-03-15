Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AE3CF30282
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2026 20:20:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w1ruN-0006OZ-1J; Sun, 15 Mar 2026 16:17:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heifetz@yandex-team.com>)
 id 1w1ru8-0006Lq-B9
 for qemu-devel@nongnu.org; Sun, 15 Mar 2026 16:17:43 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heifetz@yandex-team.com>)
 id 1w1ru1-0002Lp-B4
 for qemu-devel@nongnu.org; Sun, 15 Mar 2026 16:17:36 -0400
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:a189:0:640:4da6:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 4B6FA8079D;
 Sun, 15 Mar 2026 23:17:01 +0300 (MSK)
Received: from localhost (unknown [2a02:6bf:8080:b49::1:d])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id wGRvdA1ABOs0-gpYltWPR; Sun, 15 Mar 2026 23:17:00 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.com;
 s=default; t=1773605820;
 bh=5nEpBPf/MP5gIN6vJYDPRg5uxeJQt+2s1OvZINfU+Yc=;
 h=Cc:Message-Id:References:Date:In-Reply-To:Subject:To:From;
 b=niOuSb8E8LIfHls6EP0TJ/wKiPZvgJGS5SPDnrhiIThSF7ltzU5gfzRNaAqytxAwC
 H1WBQ/V9FW/pYZfKRfrXF7XJxqTCMalSz89UZXbNvarSDmS6lgoV+5h6J/iy7nCr3c
 TU7LhiJiT2Tcqa/4PzzAtgfZaW1fty5eocbcutrI=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.com
From: Sergei Heifetz <heifetz@yandex-team.com>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Yanan Wang <wangyanan55@huawei.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Sergei Heifetz <heifetz@yandex-team.com>
Subject: [PATCH v3 05/11] Kconfig: add AUDIO dependency to audio-related
 devices
Date: Mon, 16 Mar 2026 01:16:40 +0500
Message-Id: <20260315201646.96862-6-heifetz@yandex-team.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260315201646.96862-1-heifetz@yandex-team.com>
References: <20260315201646.96862-1-heifetz@yandex-team.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=heifetz@yandex-team.com; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The idea of the `--disable-audio` option is to stop building audio-related
source files. Although this is not yet implemented, we can already make
the existing AUDIO Kconfig option a dependency for a number of devices so
that the build does not break when we remove `audio/` and other sources.

Note that some machines have embedded audio devices and therefore cannot
be used with `--disable-audio` at all. `-audio none` should be used for
such machines if audio needs to be muted.

The only device that is purposefully not included in this patch is PCSPK
(PC speaker), because its code has already been modified to work with
`--disable-audio`.

Signed-off-by: Sergei Heifetz <heifetz@yandex-team.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/audio/Kconfig | 21 ++++++++++++---------
 hw/usb/Kconfig   |  2 +-
 2 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/hw/audio/Kconfig b/hw/audio/Kconfig
index daf060e1be0..0479818e3f5 100644
--- a/hw/audio/Kconfig
+++ b/hw/audio/Kconfig
@@ -1,37 +1,37 @@
 config SB16
     bool
     default y
-    depends on ISA_BUS
+    depends on ISA_BUS && AUDIO
 
 config ES1370
     bool
     default y if PCI_DEVICES
-    depends on PCI
+    depends on PCI && AUDIO
 
 config AC97
     bool
     default y if PCI_DEVICES
-    depends on PCI
+    depends on PCI && AUDIO
 
 config ADLIB
     bool
     default y
-    depends on ISA_BUS
+    depends on ISA_BUS && AUDIO
 
 config GUS
     bool
     default y
-    depends on ISA_BUS
+    depends on ISA_BUS && AUDIO
 
 config CS4231A
     bool
     default y
-    depends on ISA_BUS
+    depends on ISA_BUS && AUDIO
 
 config HDA
     bool
     default y if PCI_DEVICES
-    depends on PCI
+    depends on PCI && AUDIO
 
 config PCSPK
     bool
@@ -40,18 +40,21 @@ config PCSPK
 
 config WM8750
     bool
-    depends on I2C
+    depends on I2C && AUDIO
 
 config PL041
     bool
+    depends on AUDIO
 
 config CS4231
     bool
+    depends on AUDIO
 
 config ASC
     bool
+    depends on AUDIO
 
 config VIRTIO_SND
     bool
     default y
-    depends on VIRTIO
+    depends on VIRTIO && AUDIO
diff --git a/hw/usb/Kconfig b/hw/usb/Kconfig
index de95686720c..e3705858926 100644
--- a/hw/usb/Kconfig
+++ b/hw/usb/Kconfig
@@ -98,7 +98,7 @@ config USB_STORAGE_UAS
 config USB_AUDIO
     bool
     default y
-    depends on USB
+    depends on USB && AUDIO
 
 config USB_SERIAL
     bool
-- 
2.34.1


