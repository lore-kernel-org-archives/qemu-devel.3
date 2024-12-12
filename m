Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8815E77183
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 11:52:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLhfR-0007iY-0X; Thu, 12 Dec 2024 06:47:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tLhfO-0007Zw-PY
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 06:47:38 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tLhfN-0007Ho-9u
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 06:47:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=shdo7YHp/+ED21TRvolahMP/Qxs7DCwuveWPKcORbzQ=; b=b7QwSsI9s37i3HsTlS3TBXqJfs
 pVQUIDiiat2UlRv0oa31KJpASlSZkGZ9hlNLFDtWKPZP8pl3gdSUFV3o3Gtprqxq9JDWG5nSZacY+
 cV72/p2Y6dj0jKsyqLcfmnF2+NvX/3EtqOCkAu3h4GVEln+Hl3XnQN67k0b5X4AmrrmzC/0pxlvv9
 BKN/DC7oVBEvgHaUFR69d4CJBXZVkF7Yg/5s1JWsecAVlIGv6ADB3U07KzfO41+7C/0C15ATWvJMa
 ZrXWp+ZcyTAZE3XeP8hFIbQHvq4IeeHHUvQCULAh8nGrj3iMO6wMW8uOB3y4sB55Ls4OxLqr2hheu
 i1dCJWXgpPdnAWs7/oWW0uI3Wh9IUj6wvfO1ibedzO2YhcL1xr+Gv7ZOI4Xxoc1liaBFdQ979JKjf
 YubF92j4VNF/AgB+OiyDEYBpWUogmsOCj7FzGQqnwFd1wKtdbX0rN+Jij/Tg0VKdd5tPRFt2SctS4
 oLgEatOC0SVKhLMke91nqsqdnixTXKmtMajcGteG0v9yo0AjhS6A0gCAmHSmBBugypvKBUFKCRqQQ
 LhIh2RTMw5MVLYc6h6Ivt0E3e+YrrhrWgF5iP6mtiSVP1q9EJuzuzJGyUWGpUrKHcGJd9v+ARcA37
 BzGw+vbWWRpdRszXx5itefvLTyzjM0M+6wPAHrKaM=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tLhed-00070a-Jd; Thu, 12 Dec 2024 11:46:55 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: huth@tuxfamily.org,
	qemu-devel@nongnu.org
Date: Thu, 12 Dec 2024 11:46:04 +0000
Message-Id: <20241212114620.549285-19-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241212114620.549285-1-mark.cave-ayland@ilande.co.uk>
References: <20241212114620.549285-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 18/34] next-cube: rename typedef struct NextRtc to NeXTRTC
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
index 4a11fe6b39..0b07cd1a75 100644
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
@@ -1111,13 +1111,13 @@ static const VMStateDescription next_rtc_vmstate = {
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
@@ -1133,7 +1133,7 @@ static const VMStateDescription next_pc_vmstate = {
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


