Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26D20CD6E4A
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2026 13:45:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wV8N7-0001EL-FZ; Thu, 04 Jun 2026 09:44:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1wV8N6-0001D5-6L
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 09:44:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1wV8N3-0008NG-Uo
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 09:44:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780580668;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=LV7sqLezgygBgSV+xK0D2dlwQJaZS+1+3eYN++koRdY=;
 b=ObnZU1VZZtoFlE1Q5b3osOTmi46wIxwqsKGbIOZFWyHqztpEQ9gfIZfEVmU5vu/u6ArdfK
 lFHcR9VPiDKtCkDr3tBTsrqWaypFlbqokrncTnPdRXvwsc5jiFkqXUj/w8P0xHU1m/hvUe
 CDts6qUFuZN84XCg9iQqPOrYuCsouRQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-272-uaYxHzO0Pe-0npzXUrXDFQ-1; Thu,
 04 Jun 2026 09:44:25 -0400
X-MC-Unique: uaYxHzO0Pe-0npzXUrXDFQ-1
X-Mimecast-MFC-AGG-ID: uaYxHzO0Pe-0npzXUrXDFQ_1780580664
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2122018004D4; Thu,  4 Jun 2026 13:44:24 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.33.85])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8CD2530001A1; Thu,  4 Jun 2026 13:44:23 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 783B118003B4; Thu, 04 Jun 2026 15:44:22 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH] add a note on -shim to direct kernel boot docs
Date: Thu,  4 Jun 2026 15:44:22 +0200
Message-ID: <20260604134422.359214-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 docs/system/linuxboot.rst | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/docs/system/linuxboot.rst b/docs/system/linuxboot.rst
index f7573ab80aa2..72af18ce1b5e 100644
--- a/docs/system/linuxboot.rst
+++ b/docs/system/linuxboot.rst
@@ -17,6 +17,15 @@ Use ``-kernel`` to provide the Linux kernel image and ``-append`` to
 give the kernel command line arguments. The ``-initrd`` option can be
 used to provide an INITRD image.
 
+The ``-shim`` option specifies the shim.efi binary.  This is needed
+when using direct kernel boot with UEFI secure boot enabled.  The
+verification chain used by linux distros requires shim.efi.  Typically
+shim.efi is signed by micsosoft and verified by the firmware.  The
+linux kernel is signed by the distro and is verified by shim.efi.  So
+without shim.efi in the loop secure boot verification will not work.
+Usually you can find shim.efi as ``EFI/BOOT/BOOT{X64,AA64}.EFI`` on
+distro install media.
+
 If you do not need graphical output, you can disable it and redirect the
 virtual serial port and the QEMU monitor to the console with the
 ``-nographic`` option. The typical command line is:
-- 
2.54.0


