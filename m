Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 508C7C4829C
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 18:56:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYW1w-0000lf-Ql; Fri, 09 Feb 2024 13:55:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rYW1v-0000lB-BD
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 13:55:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rYW1p-0001Wa-Sl
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 13:55:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707504911;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=3+KWLMqcyHzWRv7NZSsj5IzznoIvlcNWC67gfs3HkAY=;
 b=jILqld6dA4OmskWZUDdEoxC2Qi2vwhv34S3YHOzf62ZpxvhbKQU9Ql9uedi7c3U1Oawf1H
 VE3xW5or2tYFzQnXlVK1sYnIwKB/YWjWaZWgwLdtyV1vYcxvPnM1vQryAbof6o2+EneaB5
 DDEDXztDcIP7OxleCIgqU85c1Dtdf/c=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-336-QyB1EcPINrGTwJvu6GSw0g-1; Fri,
 09 Feb 2024 13:55:10 -0500
X-MC-Unique: QyB1EcPINrGTwJvu6GSw0g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B10BE282D3CB;
 Fri,  9 Feb 2024 18:55:09 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.170])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F25A611218;
 Fri,  9 Feb 2024 18:55:07 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org, Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-stable@nongnu.org,
 qemu-trivial@nongnu.org
Subject: [PATCH] hw/hppa/Kconfig: Fix building with "configure
 --without-default-devices"
Date: Fri,  9 Feb 2024 19:55:06 +0100
Message-ID: <20240209185506.248001-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.269,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

When running "configure" with "--without-default-devices", building
of qemu-system-hppa currently fails with:

 /usr/bin/ld: libqemu-hppa-softmmu.fa.p/hw_hppa_machine.c.o: in function `machine_HP_common_init_tail':
 hw/hppa/machine.c:399: undefined reference to `usb_bus_find'
 /usr/bin/ld: hw/hppa/machine.c:399: undefined reference to `usb_create_simple'
 /usr/bin/ld: hw/hppa/machine.c:400: undefined reference to `usb_bus_find'
 /usr/bin/ld: hw/hppa/machine.c:400: undefined reference to `usb_create_simple'
 collect2: error: ld returned 1 exit status
 ninja: build stopped: subcommand failed.
 make: *** [Makefile:162: run-ninja] Error 1

And after fixing this, the qemu-system-hppa binary refuses to run
due to the missing 'pci-ohci' and 'pci-serial' devices. Let's add
the right config switches to fix these problems.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/hppa/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/hppa/Kconfig b/hw/hppa/Kconfig
index ff8528aaa8..124d5e9e47 100644
--- a/hw/hppa/Kconfig
+++ b/hw/hppa/Kconfig
@@ -6,7 +6,7 @@ config HPPA_B160L
     select ASTRO
     select DINO
     select LASI
-    select SERIAL
+    select SERIAL_PCI
     select ISA_BUS
     select I8259
     select IDE_CMD646
@@ -16,3 +16,4 @@ config HPPA_B160L
     select LASIPS2
     select PARALLEL
     select ARTIST
+    select USB_OHCI_PCI
-- 
2.43.0


