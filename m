Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7D5FE77188
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Dec 2024 13:11:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tPLda-0003FV-GZ; Sun, 22 Dec 2024 08:04:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tPLaX-0005qt-TG
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 08:01:43 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tPLaW-0000lC-C9
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 08:01:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=eNjdiGDp4478LUOvu3hohCwXoWVqzRRbe3HSYuHi6OA=; b=sjdYtER7mevbQTAhcuq65eSYyx
 56+aErM+w2VtmR/UWj4aVRPTb7c5wkz577qADNOrkbU8CwgOBW5lmRvIBV9GowJMBLN50BGfPix6f
 XxkwkxuShKdR4GsDPBIRmM1DILClX1shju0P7ylwnv6NJ5yBxzkEkz3mUwMlVwf9cLgqgLktwv1FA
 Oh29Jy9o7ZQAEoKr4hmsAl9aa6ysm8BOPmbjwuQZ543ZfnCIwlhXizDilxhQv0rowx86PCfwQBB9W
 BdBQSE3eolsq1Rnvw2w5CEJKnE5fydBBh/T4FRfwI7csTREvMwNqV16m2HhpNT/mutXTe9VqggsLl
 P1AOx/PV4wsgwmkgKLfyltUamKqzdoxNLUWbaV+sxavym7D5cLwzUs+HFGTDF6uWNljfGFFthtavq
 I8CdDWI171hv54x6f0FHkjHoe7AFuXucHHBMUwuTFMuIJxgsUM2uRUcXaet/Rzhm24F8WyOxHwmos
 ehWudTmKM2VNVH7wp4TzZwne7QUfpCAwOmqDNbvK4qASiT/QWdnWFak7ISqwVZ+hQov+kBznQGjnI
 uCmIA0m25VIH33RFu+syvxRC+TVcZcFvjxUJlOiOhMZVM/FGYNF4EbqMizPoMOEIozGHk28FzUilL
 +iwOjGYLif9ynvStoGk2rzWTO+/feaFCdkvMhU+7k=;
Received: from [2a02:8012:2f01:0:33a9:475d:1cd9:884]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tPLZl-0002L7-Rn; Sun, 22 Dec 2024 13:00:54 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: huth@tuxfamily.org,
	qemu-devel@nongnu.org
Date: Sun, 22 Dec 2024 12:59:57 +0000
Message-Id: <20241222130012.1013374-19-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241222130012.1013374-1-mark.cave-ayland@ilande.co.uk>
References: <20241222130012.1013374-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:2f01:0:33a9:475d:1cd9:884
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v3 18/33] next-cube: rename typedef struct NextRtc to NeXTRTC
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This brings the capitalisation in line with the other NeXTCube definitions.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Thomas Huth <huth@tuxfamily.org>
---
 hw/m68k/next-cube.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
index 61d0cb8327..830ed17e68 100644
--- a/hw/m68k/next-cube.c
+++ b/hw/m68k/next-cube.c
@@ -42,7 +42,7 @@
 #define RAM_SIZE    0x4000000
 #define ROM_FILE    "Rev_2.5_v66.bin"
 
-typedef struct NextRtc {
+typedef struct NeXTRTC {
     int8_t phase;
     uint8_t ram[32];
     uint8_t command;
@@ -50,7 +50,7 @@ typedef struct NextRtc {
     uint8_t status;
     uint8_t control;
     uint8_t retval;
-} NextRtc;
+} NeXTRTC;
 
 #define TYPE_NEXT_SCSI "next-scsi"
 OBJECT_DECLARE_SIMPLE_TYPE(NeXTSCSI, NEXT_SCSI)
@@ -97,7 +97,7 @@ struct NeXTPC {
 
     ESCCState escc;
 
-    NextRtc rtc;
+    NeXTRTC rtc;
 };
 
 typedef struct next_dma {
@@ -167,7 +167,7 @@ static void next_scr2_led_update(NeXTPC *s)
 static void next_scr2_rtc_update(NeXTPC *s)
 {
     uint8_t old_scr2, scr2_2;
-    NextRtc *rtc = &s->rtc;
+    NeXTRTC *rtc = &s->rtc;
 
     old_scr2 = extract32(s->old_scr2, 8, 8);
     scr2_2 = extract32(s->scr2, 8, 8);
@@ -1110,13 +1110,13 @@ static const VMStateDescription next_rtc_vmstate = {
     .version_id = 2,
     .minimum_version_id = 2,
     .fields = (const VMStateField[]) {
-        VMSTATE_INT8(phase, NextRtc),
-        VMSTATE_UINT8_ARRAY(ram, NextRtc, 32),
-        VMSTATE_UINT8(command, NextRtc),
-        VMSTATE_UINT8(value, NextRtc),
-        VMSTATE_UINT8(status, NextRtc),
-        VMSTATE_UINT8(control, NextRtc),
-        VMSTATE_UINT8(retval, NextRtc),
+        VMSTATE_INT8(phase, NeXTRTC),
+        VMSTATE_UINT8_ARRAY(ram, NeXTRTC, 32),
+        VMSTATE_UINT8(command, NeXTRTC),
+        VMSTATE_UINT8(value, NeXTRTC),
+        VMSTATE_UINT8(status, NeXTRTC),
+        VMSTATE_UINT8(control, NeXTRTC),
+        VMSTATE_UINT8(retval, NeXTRTC),
         VMSTATE_END_OF_LIST()
     },
 };
@@ -1132,7 +1132,7 @@ static const VMStateDescription next_pc_vmstate = {
         VMSTATE_UINT32(int_mask, NeXTPC),
         VMSTATE_UINT32(int_status, NeXTPC),
         VMSTATE_UINT32(led, NeXTPC),
-        VMSTATE_STRUCT(rtc, NeXTPC, 0, next_rtc_vmstate, NextRtc),
+        VMSTATE_STRUCT(rtc, NeXTPC, 0, next_rtc_vmstate, NeXTRTC),
         VMSTATE_END_OF_LIST()
     },
 };
-- 
2.39.5


