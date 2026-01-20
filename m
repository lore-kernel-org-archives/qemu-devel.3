Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35385D2629E
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Jan 2026 21:12:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viJ0W-0007AM-SY; Tue, 20 Jan 2026 16:11:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3d-9vaQwKCmgTGHONKYZKLGTMUUMRK.IUSWKSa-JKbKRTUTMTa.UXM@flex--nabihestefan.bounces.google.com>)
 id 1viJ0V-0007A6-Ma
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 16:11:23 -0500
Received: from mail-dl1-x124a.google.com ([2607:f8b0:4864:20::124a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3d-9vaQwKCmgTGHONKYZKLGTMUUMRK.IUSWKSa-JKbKRTUTMTa.UXM@flex--nabihestefan.bounces.google.com>)
 id 1viJ0U-0003l8-4Q
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 16:11:23 -0500
Received: by mail-dl1-x124a.google.com with SMTP id
 a92af1059eb24-123377038f9so557403c88.0
 for <qemu-devel@nongnu.org>; Tue, 20 Jan 2026 13:11:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1768943480; x=1769548280; darn=nongnu.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=o4RAqyXrLAo+0kHfcx+F4yi90mTR8p4gv7hKCzK+Od4=;
 b=Mrcl2c6mfRE+8IKr5/MNnHGufgvQiRhRLmlL/aJCGtm3UPEtrOvLJLDNxxKkpmJkuE
 m4+LkRSsJ513iJVfgGZoWNjv7yB/XWndOsIn6LuGMf+4DDQd76cYawS5H8kKLKGsQ7k1
 r+S584fjOoc08wOrP4lluvPFbDq/JC6ZgxadYUvyJET9RH98/NFxxHZeRfzAKZcAgPok
 9mE2wupUo0IMWpD+oy1o526/qC9fg9aXNigiVBJM0qedh+83aI+9T/b8ewO2PJN2lKUA
 JI/UJAVSO/p8b1/E5icvJ5aLYettJ4OgdkUVYTvBsuUQD9MKR82FdGqX/sPbunv/TOrn
 okGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768943480; x=1769548280;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=o4RAqyXrLAo+0kHfcx+F4yi90mTR8p4gv7hKCzK+Od4=;
 b=u9SJGYZdAHMOJVZwoDZdD08zZghEE8KCNxM3GPYA+56v0JCH6/FGfOB2Zngl89r7aB
 3K2WRcRYWAAhby/GnRjhYgVoqbN/4kW0aBGI+M1IuNJMXCrq1q+ptFB3+EM3Lph3Eqj8
 y5Q5c4f4/SQ3l5nhXqpg4rZUV5Zp5vGtVF+AYceVBBb535aEqPeXNFnk3wMtn6ycPTJ1
 /uBbhlIFo7SDcep8hmEK4x4di0eD8B188XnFCqaTt7Np4rXMclNKANGSvc0COC8yxCcA
 XCxLEN/k7ONmAW0QmkDqkt8X/PCnULbkUR7Rqgc7/43jdbyPgci7Dqf2MvZ+ifcCzru2
 sWJw==
X-Gm-Message-State: AOJu0YzqOR/zLhVTZFHsWsiBeA9X4/G50xjhXgCCvqgWanxRmXgBd0Jw
 LRE2KtF8h9W1DM7fp6Rv3WK4BFnAmafzvGLpFKyvk24k+q0gHM1IuLRtNZKL1a1Z0yvP+j7Uj72
 3pprPZZ3PVnpp1q94644NPdgbCxD0KC5FAXF3Hqq801r6I6SxO5pTamiSjNrlXTbRpJ+QFO8dbC
 2Y2Wd9I/l7uCV+xylMcmyjH6foyMIr02Jm3Zov61Y9cQAVymO0Nt4hyEem0glKPF6Mtpg=
X-Received: from dlbur6-n2.prod.google.com
 ([2002:a05:7022:ea46:20b0:119:78ff:fe0f])
 (user=nabihestefan job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7022:f90:b0:123:2d4f:ef1d with SMTP id
 a92af1059eb24-1246aad1621mr2228767c88.30.1768943479968; 
 Tue, 20 Jan 2026 13:11:19 -0800 (PST)
Date: Tue, 20 Jan 2026 21:11:16 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260120211116.1367476-1-nabihestefan@google.com>
Subject: [PATCH] hw/i2c/aspeed_i2c.c: Add a check for dma_read
From: Nabih Estefan <nabihestefan@google.com>
To: qemu-devel@nongnu.org
Cc: clg@kaod.org, peter.maydell@linaro.org, steven_lee@aspeedtech.com, 
 leetroy@gmail.com, jamin_lin@aspeedtech.com, andrew@codeconstruct.com.au, 
 joel@jms.id.au, qemu-arm@nongnu.org, Nabih Estefan <nabihestefan@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::124a;
 envelope-from=3d-9vaQwKCmgTGHONKYZKLGTMUUMRK.IUSWKSa-JKbKRTUTMTa.UXM@flex--nabihestefan.bounces.google.com;
 helo=mail-dl1-x124a.google.com
X-Spam_score_int: -97
X-Spam_score: -9.8
X-Spam_bar: ---------
X-Spam_report: (-9.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.168,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

If aspeed_i2c_dma_read fails in aspeed_i2c_bus_send currently, we get
stuck in an infinite retry loop. Add a check for the return value of
aspeed_i2c_dma_read that will break us out of said loop.

Signed-off-by: Nabih Estefan <nabihestefan@google.com>
---
 hw/i2c/aspeed_i2c.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/i2c/aspeed_i2c.c b/hw/i2c/aspeed_i2c.c
index 1b8ac561c3..3de72db652 100644
--- a/hw/i2c/aspeed_i2c.c
+++ b/hw/i2c/aspeed_i2c.c
@@ -272,7 +272,11 @@ static int aspeed_i2c_bus_send(AspeedI2CBus *bus)
         }
         while (bus->regs[reg_dma_len]) {
             uint8_t data;
-            aspeed_i2c_dma_read(bus, &data);
+            ret = aspeed_i2c_dma_read(bus, &data);
+            /* Check that we were able to read the DMA */
+            if (ret) {
+                break;
+            }
             trace_aspeed_i2c_bus_send("DMA", bus->regs[reg_dma_len],
                                       bus->regs[reg_dma_len], data);
             ret = i2c_send(bus->bus, data);
-- 
2.52.0.457.g6b5491de43-goog


