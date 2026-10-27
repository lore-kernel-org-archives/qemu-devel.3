Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3574F606A31D
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 15:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Vh85ews8
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLjBh-00019O-AG; Tue, 27 Oct 2026 11:34:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dominik.m.weber@gmail.com>)
 id 1xLi2H-00043K-Cx
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 10:20:21 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dominik.m.weber@gmail.com>)
 id 1xLi2F-0004Cc-RX
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 10:20:21 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-48c45111bebso1926741f8f.0
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 07:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793110817; x=1793715617; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=yJVv3NphWhuHx3YFP1g3EpPxcAK/P8qic7nTBdWrDyA=;
 b=Vh85ews8Yi3u6zVn/8CYn3WJZ7XBUKZkPc0lr6nRC4izdNUjKsLvUIzp2AP+NV5WJo
 s4eYb6MMHjZoijSuthu9GgdByRzSa6+4rLF0NDdjwm4PXfEp3X8A+9KwSvDHng+Z4KL7
 Lx2HrCEbrjUAvKHGZZNTSI3NqJs6YX5DYSWNks0K9dvd+RjlDpb81QtOYUTSCJfyxRQ7
 lvk7cETZzTxUXdijfCpFbg1S1lb3/iW5IVS0zYMAxH79xhO5pwAAu4LA+9WvZuCKow5Y
 zepdjup/+0ndGWges3tuTVPn283OK3lby3ERa1cxXUIgWthdOVkvQanMBOVIOqYWGOAN
 FRbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793110817; x=1793715617;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yJVv3NphWhuHx3YFP1g3EpPxcAK/P8qic7nTBdWrDyA=;
 b=NXUv14K5N8Km2QbEu2pzS2U1XLF1nPphZ4Q8pob295vnf4a/vdIqWBb+5SeHzvzK5V
 MYoZYTPj6tRDazPv4/Q3zUU+RqW6V9NmG39KxEvIMAz6Y+gJKlJCUS6Ib52d5ymYVGNt
 swB4vhhtej4PuzfBqRzMoMdZZlAx7aP3ctieuXIpeR5/kTwNW/5VKZY39h6V9MXVOM8L
 OWRLCgl1znh+xmva9J08yj1O9A4cJYvtQSsGClBBQUI7y8xWP5z2AA7eT7vdTv8sigKv
 9dj6agoKnrpYeOyLSFKTEcSTFfzpqOTMYxoqFNsDu8fou26/O0hQXTbHi3WlcybntoRB
 n+gw==
X-Gm-Message-State: AFq9FYL6nZxonXeKL9f53f6JJgWQug0hIQFln2EeBJGOWlIPqKbnv4Q3
 iEKbp4wPlU4oP4uoevIthJeMKzeVDpnGPYEhAlyo7HlU6CwvUO7knFaE/HqP36znPhgG6A==
X-Gm-Gg: AYBFou1H66agWLYNvYTnugIBsJBA6Q+NZaXPQ/woNbWOPoxU+ls5lqY6EuoDeTtONX5
 9RJQv9UhZehI3m8iFQa5ijLsfbFC6Rva9SHIRFHxIL4hyw2mE02U/aRqMGWBpc9Wk8ZNmxUgbSE
 GkGq+K/H9YC6/AXutea8TdbC2dHVnhugPrcRnYLepK+aIVNfgO5r3uXc9L6arm9GObyy6AxAj6A
 A/MQj1OjBVuj4LUdOtSouec65pI9MeOBWwaxPFGO2nJrCABuliaIO0Kp8O0STC3dO7IQHZgdUQT
 Q1qIxsOJjsMU1u/GNk4ArPvrwDF6Kzcv5sc1cTZO+sU6hlOeZOuoU5U5LEc5qKaFnJOP0RbGVvo
 HDREor1Lnu3TcMCND12HYVuVzPrK0w9umNnFrQ2tro9fDfqAYtStAyPiIt1QKvT1HT2nyXYddn9
 kCTssDdwyr3envNGzJh5JAYHkFhg/zmCUxhLwU4HO3+MpvlvFiexZtgUD7+KAntM2vHtcVYbZoQ
 exI2fsrV5CfQAMAwJNJrYWPFC3WJZ6T91LZqDpWF5uS8vZGzTJtpoLDwv2c/QaQmvHh4phfsakq
 b2exdQsf3xhE
X-Received: by 2002:a5d:5f44:0:b0:48b:10af:f85c with SMTP id
 ffacd0b85a97d-48e3eb9da68mr19395936f8f.37.1793110817344; 
 Tue, 27 Oct 2026 07:20:17 -0700 (PDT)
Received: from Ageleia.localdomain ([119.13.72.105])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebcb8e0sm22364730f8f.29.2026.10.27.07.20.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 07:20:16 -0700 (PDT)
From: "Dominik M. Weber" <dominik.m.weber@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 "Dominik M. Weber" <dominik.m.weber@gmail.com>
Subject: [PATCH] hw/core/loader: Fix range checks in rom_copy()
Date: Tue, 27 Oct 2026 15:20:15 +0100
Message-ID: <20261027142015.192997-1-dominik.m.weber@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=dominik.m.weber@gmail.com; helo=mail-wr1-x430.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 27 Oct 2026 11:34:07 -0400
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

When a ROM blob runs past the end of the destination, rom_copy()
clamps the length to "dest - d" instead of "dest + size - d". The
result is negative, so memcpy() gets a huge size_t and QEMU crashes.
The same mistake is in the memset() path.

This is easy to hit with a crafted -kernel image. For example, a
multiboot ELF whose last segment ends right where the BIOS starts
(0xfffc0000 with the default SeaBIOS) crashes qemu-system-i386 at
startup.

While at it, treat the range as half-open at both ends: a blob that
starts at addr + size now ends the loop, so rom_copy() no longer
reports a full copy when nothing was copied, and a blob that ends
exactly at addr no longer stops the loop before the blobs inside the
range.

Commit e423455c4f23 fixed a similar problem at the start of the
range.

Fixes: 235f86ef0147 ("Introduce rom_copy")
Fixes: d60fa42e8bae ("Save memory allocation in the elf loader")
Signed-off-by: Dominik M. Weber <dominik.m.weber@gmail.com>
---
 hw/core/loader.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/core/loader.c b/hw/core/loader.c
index 5cbfba0a86..d293603cad 100644
--- a/hw/core/loader.c
+++ b/hw/core/loader.c
@@ -1529,10 +1529,10 @@ int rom_copy(uint8_t *dest, hwaddr addr, size_t size)
         if (rom->mr) {
             continue;
         }
-        if (rom->addr + rom->romsize < addr) {
+        if (rom->addr + rom->romsize <= addr) {
             continue;
         }
-        if (rom->addr > end || rom->addr < addr) {
+        if (rom->addr >= end || rom->addr < addr) {
             break;
         }
 
@@ -1541,7 +1541,7 @@ int rom_copy(uint8_t *dest, hwaddr addr, size_t size)
         l = rom->datasize;
 
         if ((d + l) > (dest + size)) {
-            l = dest - d;
+            l = dest + size - d;
         }
 
         if (l > 0) {
@@ -1560,7 +1560,7 @@ int rom_copy(uint8_t *dest, hwaddr addr, size_t size)
                 /* Rom size doesn't fit in the destination area. Adjust to avoid
                  * overflow.
                  */
-                l = dest - d;
+                l = dest + size - d;
             }
 
             if (l > 0) {
-- 
2.43.0


