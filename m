Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8556C677C4
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Jun 2025 07:51:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPGEW-0002zP-GR; Wed, 11 Jun 2025 03:50:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1uPGEQ-0002yg-CK
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 03:50:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1uPGEO-0005uJ-Dk
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 03:50:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749628243;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3ayC/Yn8lHuEDaclWUygLWgjTbSCMn9SpbsvbpcLpz0=;
 b=AbNOxDtbfDTGwJAzqFX5KqT4eaqprJgRnfQMBFicLpMW67/m0Ny+QRbYyWLigioIBFpTFH
 SuA37b54/KSAEBF1MRmIygXum9Qob374km+jSh9ISliDmOoDQOQLS8g8NUdXM3YCP2MneE
 Mwe8poGZCQdV36G6FdU1X5PDSlIl09k=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-540-XHwFAPdtMvq-rGOwZEE9kw-1; Wed,
 11 Jun 2025 03:50:41 -0400
X-MC-Unique: XHwFAPdtMvq-rGOwZEE9kw-1
X-Mimecast-MFC-AGG-ID: XHwFAPdtMvq-rGOwZEE9kw_1749628241
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A16C419560B5
 for <qemu-devel@nongnu.org>; Wed, 11 Jun 2025 07:50:40 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.32.69])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 334E01800284; Wed, 11 Jun 2025 07:50:40 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id B444518007A6; Wed, 11 Jun 2025 09:50:37 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL 1/2] seabios: update submodule to 1.17.0
Date: Wed, 11 Jun 2025 09:50:36 +0200
Message-ID: <20250611075037.659610-2-kraxel@redhat.com>
In-Reply-To: <20250611075037.659610-1-kraxel@redhat.com>
References: <20250611075037.659610-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

git shortlog rel-1.16.3..rel-1.17.0
-----------------------------------

Andrej Kruták (1):
      Add AHCI Power ON + ICC_ACTIVE into port setup code

Daniel Khodabakhsh (2):
      boot: Force display of the boot menu when boot-menu-wait is a negative number
      usb-hid: Support multiple USB HID devices by storing them in a linked list

Daniel Verkamp (3):
      vbe: Add VBE 2.0+ OemData field to struct vbe_info
      vgasrc: round up save/restore size
      vbe: implement function 09h (get/set palette data)

Daniil Tatianin (1):
      pciinit: don't misalign large BARs

Gerd Hoffmann (6):
      limit address space used for pci devices, part two
      drop obsolete acpi table code
      drop acpi tables and hex includes
      add romfile_loadbool()
      update pci_pad_mem64 handling
      ahci: add controller reset

Igor Mammedov (1):
      fix smbios blob length overflow

Jiaxun Yang (1):
      ahci: Fix hangs due to controller reset

Kevin O'Connor (14):
      vgasrc: Use curmode_g instead of vmode_g when mode is the current video mode
      vgasrc: Rename vgahw_get_linesize() to vgahw_minimum_linelength()
      stdvgamodes: No need to store pelmask in vga_modes[]
      stdvgamodes: Improve naming of dac palette tables
      stdvga: Rename CGA palette functions
      stdvga: Add comments to interface functions in stdvga.c
      stdvga: Rename stdvga_toggle_intensity() to stdvga_set_palette_blinking()
      stdvga: Rework stdvga palette index paging interface functions
      stdvga: Rename stdvga_set_text_block_specifier() to stdvga_set_font_location()
      stdvga: Rename stdvga_set_scan_lines() to stdvga_set_character_height()
      stdvga: Rename stdvga_get_vde() to stdvga_get_vertical_size()
      stdvga: Add stdvga_set_vertical_size() helper function
      stdvgaio: Only read/write one color palette entry at a time
      docs: Note v1.17.0 release

Mark Cave-Ayland (2):
      esp-scsi: terminate DMA transfer when ESP data transfer completes
      esp-scsi: indicate acceptance of MESSAGE IN phase data

Max Tottenham (1):
      Add LBA 64bit support for reads beyond 2TB.

Steven Price (1):
      vgabios: Fix generating modes list for static_functionality

nikolar via SeaBIOS (1):
      kconfig: fix the check-lxdialog.sh to work with gcc 14+

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 roms/seabios | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/roms/seabios b/roms/seabios
index a6ed6b701f0a..b52ca86e094d 160000
--- a/roms/seabios
+++ b/roms/seabios
@@ -1 +1 @@
-Subproject commit a6ed6b701f0a57db0569ab98b0661c12a6ec3ff8
+Subproject commit b52ca86e094d19b58e2304417787e96b940e39c6
-- 
2.49.0


