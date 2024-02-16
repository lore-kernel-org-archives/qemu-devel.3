Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C420C48BEB
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Feb 2024 09:17:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rauKh-0007jq-4h; Fri, 16 Feb 2024 04:16:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rauKf-0007jO-Un
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 04:16:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rauKd-0005o0-Ob
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 04:16:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708074988;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=tqqDW39l+V/yPFeZxBUCWNqogR2/wN8JjWZ2Hv5ILfE=;
 b=Uapsw7OoYPTulDRoZzs2ts6OvBo2sBhPBnhEROWvSJuZ5UKzBQa62BmgYYOlaExJHHzC0A
 cCC35fp58PpcG2zIeNgn0maNTqk3fTvtyGtxU0cfLRDoeSonV9jXC9AuGrB8QGsPc4/oBH
 w+YyvV6kiLw8BUh1+WoaNZmAbTo7FQs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-505-iz1mgji0NimqQd_C8psgnw-1; Fri, 16 Feb 2024 04:16:24 -0500
X-MC-Unique: iz1mgji0NimqQd_C8psgnw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 77E72837234;
 Fri, 16 Feb 2024 09:16:24 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.46])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A0E10AC07;
 Fri, 16 Feb 2024 09:16:22 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org, Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	qemu-trivial@nongnu.org
Subject: [PATCH v2] hw/hppa/Kconfig: Fix building with "configure
 --without-default-devices"
Date: Fri, 16 Feb 2024 10:16:21 +0100
Message-ID: <20240216091621.32989-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.772,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
 v2: Keep "select SERIAL" instead of replacing it

 hw/hppa/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/hppa/Kconfig b/hw/hppa/Kconfig
index ff8528aaa8..dff5df7f72 100644
--- a/hw/hppa/Kconfig
+++ b/hw/hppa/Kconfig
@@ -7,6 +7,7 @@ config HPPA_B160L
     select DINO
     select LASI
     select SERIAL
+    select SERIAL_PCI
     select ISA_BUS
     select I8259
     select IDE_CMD646
@@ -16,3 +17,4 @@ config HPPA_B160L
     select LASIPS2
     select PARALLEL
     select ARTIST
+    select USB_OHCI_PCI
-- 
2.43.0


