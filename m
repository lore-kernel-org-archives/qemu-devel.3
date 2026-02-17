Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A703BE83856
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Feb 2026 05:29:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsDcs-0002cc-68; Tue, 17 Feb 2026 00:27:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heifetz@yandex-team.com>)
 id 1vsDcm-0002ad-Pr
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 00:27:52 -0500
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heifetz@yandex-team.com>)
 id 1vsDcj-0006cW-17
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 00:27:52 -0500
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c37:8aa5:0:640:e6ae:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id AD5D788516;
 Tue, 17 Feb 2026 08:27:47 +0300 (MSK)
Received: from heifetz-lin.yandex-team.ru (unknown [2a02:6bf:8080:b54::1:2f])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (smtpcorp/Yandex) with ESMTPSA id eRRjrX2Ak0U0-a7MO7L5T; 
 Tue, 17 Feb 2026 08:27:47 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.com;
 s=default; t=1771306067;
 bh=hpaly3QuMCqYCSPy1XIc8jC8cujtpc/PHUO3JbzcXqo=;
 h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=fTjumWIlCOLbSUWS8ivAgqBn/UL45OoyWpVmiFBfwbUvjrKJ/t7mHeobo0uLA+qyz
 gHyc7K0yvi7dhVcRCBL1uzHhp2ufQ/L9ODdnT4wg81l0nhY16KqB5uvEXPWoJqYWJO
 2VN8uflETZ3Cq7S9LuVLSA61DGj/Ftpk9aYlD+bA=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.com
From: Sergei Heifetz <heifetz@yandex-team.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH 5/8] Kconfig: add AUDIO dependency to audio-related devices
Date: Tue, 17 Feb 2026 10:27:37 +0500
Message-Id: <20260217052740.114117-6-heifetz@yandex-team.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260217052740.114117-1-heifetz@yandex-team.com>
References: <20260217052740.114117-1-heifetz@yandex-team.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=heifetz@yandex-team.com; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
---
 hw/audio/Kconfig | 21 ++++++++++++---------
 hw/usb/Kconfig   |  2 +-
 2 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/hw/audio/Kconfig b/hw/audio/Kconfig
index daf060e1be..0479818e3f 100644
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
index de95686720..e370585892 100644
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


