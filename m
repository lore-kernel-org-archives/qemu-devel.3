Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36814CD98CF
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2026 16:17:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wY4Zk-0001n4-2p; Fri, 12 Jun 2026 12:17:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1wY4ZG-0001lr-69
 for qemu-devel@nongnu.org; Fri, 12 Jun 2026 12:17:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1wY4ZE-0001n3-Rr
 for qemu-devel@nongnu.org; Fri, 12 Jun 2026 12:17:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781281032;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=scQ0eimbjpjPFjMueAcFXZUjcbQBhDWtI4ATPihBLp8=;
 b=Ng+/JOrNRH3BRdR4l+0zTPucbwyS38EjaDWSQwomk5ud28WTNp+NCazbyV+DaRovc1JjcE
 CRgH2Uz2c8WGMAk0FHa+A9NWEu+uV9qFn22iYm+t7xP0+eygBF4IUm4jKnflUznlcEhixG
 HOhAHlZn+elxrfrVNQ9HoyEanmHS/5E=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-211-yAHj5c6yMGi-n1F66S24uQ-1; Fri,
 12 Jun 2026 12:17:10 -0400
X-MC-Unique: yAHj5c6yMGi-n1F66S24uQ-1
X-Mimecast-MFC-AGG-ID: yAHj5c6yMGi-n1F66S24uQ_1781281029
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6659E1956067; Fri, 12 Jun 2026 16:17:09 +0000 (UTC)
Received: from dobby.home.kraxel.org (unknown [10.44.49.130])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B1D29180028B; Fri, 12 Jun 2026 16:17:08 +0000 (UTC)
Received: by dobby.home.kraxel.org (Postfix, from userid 1000)
 id 62BD781DED3; Fri, 12 Jun 2026 18:17:07 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 peter.maydell@linaro.org, Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v2] add a note on -shim to direct kernel boot docs
Date: Fri, 12 Jun 2026 18:17:07 +0200
Message-ID: <20260612161707.158029-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 docs/system/linuxboot.rst | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/docs/system/linuxboot.rst b/docs/system/linuxboot.rst
index f7573ab80a..c787481ccc 100644
--- a/docs/system/linuxboot.rst
+++ b/docs/system/linuxboot.rst
@@ -17,6 +17,23 @@ Use ``-kernel`` to provide the Linux kernel image and ``-append`` to
 give the kernel command line arguments. The ``-initrd`` option can be
 used to provide an INITRD image.
 
+The ``-shim`` option specifies the ``shim.efi`` binary.  This is needed
+when you are booting UEFI firmware and using the ``-kernel`` option to
+tell UEFI to boot a specific kernel image, and the UEFI firmware you
+are booting has UEFI secure boot enabled.
+
+When this option is specified, the guest UEFI firmware will first
+load, verify and run the shim binary, which is typically signed by
+Microsoft so the firmware accepts it.  The shim binary in turn will
+load and verify the Linux kernel.  The kernel is typically signed by
+the distro and the certificates needed to verify them are compiled
+into the shim binary, so shim + kernel must come from the same Linux
+distribution.
+
+Usually you can find shim.efi as ``EFI/BOOT/BOOT{X64,AA64}.EFI`` on
+distro install media.  You might find a second shim copy in the
+``EFI/$distro/`` directory.
+
 If you do not need graphical output, you can disable it and redirect the
 virtual serial port and the QEMU monitor to the console with the
 ``-nographic`` option. The typical command line is:
-- 
2.54.0


