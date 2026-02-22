Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46EAFE68179
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Feb 2026 23:08:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuIYM-0004ts-OL; Sun, 22 Feb 2026 18:07:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vuIYG-0004Yg-Sg
 for qemu-devel@nongnu.org; Sun, 22 Feb 2026 18:07:48 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vuIYE-00061E-S4
 for qemu-devel@nongnu.org; Sun, 22 Feb 2026 18:07:48 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-48329eb96a7so20555485e9.3
 for <qemu-devel@nongnu.org>; Sun, 22 Feb 2026 15:07:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771801665; x=1772406465; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=F9o91NXnN55Qgm8cd9PGuHzTDVifQlajjk4xjvK6WQo=;
 b=IgNgE9JzdldJ4fY11e8r0qsEMb8aqqpitz9tYqnMMG0SDKxVyMZb3wluvQSV659Ams
 PCJFYkf7Es6D6wWrn0KgHFc5clZFfp6R8mRCIb3BfIag8d8en2EvNezw1a/aZ81fx+Dg
 tmVD7tJ6n3nf+FWBT9sZMp2/RyOT7lfH8DgyHJpsRqcWArSYci0Vuun1AlRoWJSCxE4d
 91uwUB0pe+o03G7oHbZTjtDG0Z0ufO4/8DDi5fO7MrRT6EAM8z85ebjIadeuNpqJpaPo
 n+MeWGIGDmTgPknfyMw5cneDBdDUD5YRWynUZ39gT50gYUFKANWfKjMn2ZbCqUtROrGo
 DeYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771801665; x=1772406465;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=F9o91NXnN55Qgm8cd9PGuHzTDVifQlajjk4xjvK6WQo=;
 b=N0r0SxBOxhjSpX2v/UrMzNxmGDyF8+jrVo6YT+NrQomqNmd3/YAFDCUSCsGNyIjrAJ
 SNWA8/prWdNzx4/rWFyStHUab8dnTcoJcd7dMjy/Wo+n1pV/kFg8Z7+KA6wwD23dThz/
 +Z0NCxrDcVaceCBGy4+aS5/ZBlfUThRyk2SACW2+vxM70XVRUYp60BCzhPcoB5Rm4/ji
 vlAepb9+QjkXkgypH3TnkCFOX361sQpLmqmTlzmI55ntVok2Ocx57SXM66esVOPgcN3C
 B+bz4qQL0qMep/Bz/UgKXVIj0tcyxLY1uibbiY9DVQvHl6iJYMBS/vOolPPyQjXTGOsO
 Ymug==
X-Gm-Message-State: AOJu0Yw7KtDfGuLBCmYF3Oo+zbCqUuQQEYpSWsOo9hslb/oxocG2xnWL
 IkS8keefMHI5eGusXLIIa1HEBzwUl+k0eKp8jSDeg9hf/HtX6X6tJDeUltB0ANEwmr0dog1ALnq
 f9sDcFPU=
X-Gm-Gg: AZuq6aIj/tCkU+d9e5EQzJx9CbIx8vN5cSugfRbjDj/0JCPNu+82/UQkdFf2lhYah+z
 xjQfKXhM8Whh2/MZh+i1rw9/6njLOfaXGtx8bUadePBsJLSnzeSQ4+Zbix7W+CCVgiVrrPrmZY3
 XQszLov2gSjWde8meHPOCenXef/m5kxnPlw6NBS9UxJBPigFnEn4l99e478YOrksutawfzUpIW6
 iK+DiyDWpZJYkVX31gE8A4ATXtVEPw943VfRn6igi+V530xETDUgDsOvShM9n3qj3lJJFyXslnm
 DcCevo+UQjs+9J13xw8mKOf7nKtkg1oxs4naos29LGX9WrfivS86RAZ4s3/0irPKdBaHaruAJZi
 rlauJyIFu/e0WBAfh9e8TjYBvTPgJf7e6Ujw4nijm3gqkEkR0MQBZCCvVdLjHd12M6iSjJuXrQX
 f0aKKG4ZDhIZyYS3A3JSqMcgVhRVBKEGKCGpGNCL6eVh9p5Xw6Rju71mCoIUqyjQC+g7F7pxEp
X-Received: by 2002:a05:600c:8b82:b0:483:8062:b2f with SMTP id
 5b1f17b1804b1-483a95b3e0dmr107278135e9.6.1771801664690; 
 Sun, 22 Feb 2026 15:07:44 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483a3df4859sm130017965e9.2.2026.02.22.15.07.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 22 Feb 2026 15:07:44 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 15/20] hw/net/rtl8139: Remove ineffective parameter
Date: Mon, 23 Feb 2026 00:05:56 +0100
Message-ID: <20260222230602.5756-16-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260222230602.5756-1-philmd@linaro.org>
References: <20260222230602.5756-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: BALATON Zoltan <balaton@eik.bme.hu>

The do_interrupt parameter for rtl8139_do_receive was originally added
in commit 6cadb320c7 to avoid generating interrupt when receiving in
loopback mode. Later commit 5311fb805a changed this so that this
parameter became ineffective and now this parameter is unused and
always 1. If this turns out to be a problem maybe there's a better way
to fix this so remove the do_interrupt parameter for now to simplify
code.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20260127173849.588F25969F0@zero.eik.bme.hu>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/net/rtl8139.c | 24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/hw/net/rtl8139.c b/hw/net/rtl8139.c
index 9fd00574d29..2ad6338ebee 100644
--- a/hw/net/rtl8139.c
+++ b/hw/net/rtl8139.c
@@ -815,7 +815,8 @@ static bool rtl8139_can_receive(NetClientState *nc)
     return avail == 0 || avail >= 1514 || (s->IntrMask & RxOverflow);
 }
 
-static ssize_t rtl8139_do_receive(NetClientState *nc, const uint8_t *buf, size_t size_, int do_interrupt)
+static ssize_t rtl8139_receive(NetClientState *nc,
+                               const uint8_t *buf, size_t size_)
 {
     RTL8139State *s = qemu_get_nic_opaque(nc);
     PCIDevice *d = PCI_DEVICE(s);
@@ -1173,20 +1174,11 @@ static ssize_t rtl8139_do_receive(NetClientState *nc, const uint8_t *buf, size_t
     }
 
     s->IntrStatus |= RxOK;
-
-    if (do_interrupt)
-    {
-        rtl8139_update_irq(s);
-    }
+    rtl8139_update_irq(s);
 
     return size_;
 }
 
-static ssize_t rtl8139_receive(NetClientState *nc, const uint8_t *buf, size_t size)
-{
-    return rtl8139_do_receive(nc, buf, size, 1);
-}
-
 static void rtl8139_reset_rxring(RTL8139State *s, uint32_t bufferSize)
 {
     s->RxBufferSize = bufferSize;
@@ -1745,7 +1737,7 @@ static uint32_t rtl8139_RxConfig_read(RTL8139State *s)
 }
 
 static void rtl8139_transfer_frame(RTL8139State *s, uint8_t *buf, int size,
-    int do_interrupt, const uint8_t *dot1q_buf)
+                                   const uint8_t *dot1q_buf)
 {
     struct iovec *iov = NULL;
     struct iovec vlan_iov[3];
@@ -1828,7 +1820,7 @@ static int rtl8139_transmit_one(RTL8139State *s, int descriptor)
     s->TxStatus[descriptor] |= TxHostOwns;
     s->TxStatus[descriptor] |= TxStatOK;
 
-    rtl8139_transfer_frame(s, txbuffer, txsize, 0, NULL);
+    rtl8139_transfer_frame(s, txbuffer, txsize, NULL);
 
     DPRINTF("+++ transmitted %d bytes from descriptor %d\n", txsize,
         descriptor);
@@ -2246,7 +2238,7 @@ static int rtl8139_cplus_transmit_one(RTL8139State *s)
                     DPRINTF("+++ C+ mode TSO transferring packet size "
                         "%d\n", tso_send_size);
                     rtl8139_transfer_frame(s, saved_buffer, tso_send_size,
-                        0, (uint8_t *) dot1q_buffer);
+                                           (uint8_t *)dot1q_buffer);
 
                     /* add transferred count to TCP sequence number */
                     stl_be_p(&p_tcp_hdr->th_seq,
@@ -2323,8 +2315,8 @@ skip_offload:
 
         DPRINTF("+++ C+ mode transmitting %d bytes packet\n", saved_size);
 
-        rtl8139_transfer_frame(s, saved_buffer, saved_size, 1,
-            (uint8_t *) dot1q_buffer);
+        rtl8139_transfer_frame(s, saved_buffer, saved_size,
+                               (uint8_t *)dot1q_buffer);
 
         /* restore card space if there was no recursion and reset offset */
         if (!s->cplus_txbuffer)
-- 
2.52.0


