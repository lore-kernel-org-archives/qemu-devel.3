Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1E74C52D7C
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Aug 2024 06:35:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sfZUL-0004lQ-Uc; Sun, 18 Aug 2024 02:34:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wsh@wshooper.org>) id 1sfZUB-0004kQ-Fu
 for qemu-devel@nongnu.org; Sun, 18 Aug 2024 02:33:57 -0400
Received: from mail-oi1-x236.google.com ([2607:f8b0:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wsh@wshooper.org>) id 1sfZU9-00048E-5K
 for qemu-devel@nongnu.org; Sun, 18 Aug 2024 02:33:55 -0400
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-3db23a608eeso2347416b6e.1
 for <qemu-devel@nongnu.org>; Sat, 17 Aug 2024 23:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wshooper-org.20230601.gappssmtp.com; s=20230601; t=1723962830; x=1724567630;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0OhiIxpJkNFluxrVI0ZxVzkgEYfQ9vkEsD6MIsBKeP0=;
 b=1A7XkQSkFTQaDn4Nq0VOu/nC83eBsCczO+n9hGluLygthcTB92rO/lHt0lJBPw8kWD
 3Q4uNNslY3kQrdTKFz0HbQIddCOoKx1A8Q/GB6aNOQCcekgdBb1lnHJKIJ45BGpJYLe1
 ANV6GtLjLwm7xil0dQKdoNiDmuTClI7EAwaz52pV+zur48C/wZV3QO6TaqaDdvXzL5xq
 ZdmlX61zTUJUiDkAXEkYTgCTzBx2SL02Yu80DVbayndTuk5fTM8siyPQikObgCGdaCAb
 lYZLFwVK2vIBg7S58Vqsq2AoLpg8/1YrE5OsKRz1Y6b2YoN66J1EuQBW7qrtbKu0cesZ
 rq2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723962830; x=1724567630;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0OhiIxpJkNFluxrVI0ZxVzkgEYfQ9vkEsD6MIsBKeP0=;
 b=r9E2J6CTswt0bwrIBs5ZDib2vUIFg8BcGvwsRqzy5bcy3i6+4LNAkI2W7F6obc7xlL
 sIwYXJEZgNh5wDMbIEEGie1AHn134QlmAOu/i9LWm0Sf4bgYhVpyaIMh48x+OzxlLu2A
 2PnnNq7PtsHxy85doC7/mGDqWtJFogPUdeMOFiTXAVW5dcjHbsErmAU7phSCeP+yyB5J
 vNOF5vq9mdbJxCYb6HKOqQU9rtNsTpWhMrRvJejvcTHfehIH6uuMxHldj0iHCWM3Ex5R
 iwc7qRWHEZIsrf2m6717XoTrPxlGVzEks5ov/2YQJHhT20/LfMbVks8QP+v1mLBMBAPq
 is8A==
X-Gm-Message-State: AOJu0Yz0ZOS5k4p4ER65U26qbVP6b7jjdLMJ2MkDhIY4Y+5oN76VrIIL
 CfqgIsLHLLQGIRA4XL/iqrFuZdOmU4CXYBfJYkeeQnLY0gGEX6mm8FpWe6LEzx0XFAl+x41M4gX
 dBos=
X-Google-Smtp-Source: AGHT+IGeUtJi3XMcbJpzSYZwb/yYFee94fQ8CzrMx5A40yCvFS/5GHeqbhyDRNRqbh5NfPGHz9gFiw==
X-Received: by 2002:a05:6808:3008:b0:3dd:2c1d:8d08 with SMTP id
 5614622812f47-3dd3add4edamr7386230b6e.31.1723962830188; 
 Sat, 17 Aug 2024 23:33:50 -0700 (PDT)
Received: from localhost.localdomain (syn-076-081-243-074.biz.spectrum.com.
 [76.81.243.74]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7c6b61ca26csm4859210a12.36.2024.08.17.23.33.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Aug 2024 23:33:49 -0700 (PDT)
From: William Hooper <wsh@wshooper.org>
To: qemu-devel@nongnu.org
Cc: Bin Meng <bin.meng@windriver.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2] net/vmnet: Pad short Ethernet frames
Date: Sat, 17 Aug 2024 23:33:44 -0700
Message-Id: <20240818063344.6969-1-wsh@wshooper.org>
In-Reply-To: <CANto9c6QV-KAuUau_CqK-rVsyNB=42HQ3AHuQPn34yMs2-iPkg@mail.gmail.com>
References: <CANto9c6QV-KAuUau_CqK-rVsyNB=42HQ3AHuQPn34yMs2-iPkg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::236;
 envelope-from=wsh@wshooper.org; helo=mail-oi1-x236.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

At least on macOS 12.7.2, vmnet doesn't pad Ethernet frames, such as the
host's ARP replies, to the minimum size (60 bytes before the frame check
sequence) defined in IEEE Std 802.3-2022, so guests' Ethernet device
drivers may drop them with "frame too short" errors.

This patch calls eth_pad_short_frame() to add padding, as in net/tap.c
and net/slirp.c. Thanks to Bin Meng and Philippe Mathieu-Daudé for
reviewing an earlier version.

Signed-off-by: William Hooper <wsh@wshooper.org>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2058
---
 net/vmnet-common.m | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/net/vmnet-common.m b/net/vmnet-common.m
index 30c4e53c13..bce1cc590d 100644
--- a/net/vmnet-common.m
+++ b/net/vmnet-common.m
@@ -18,6 +18,7 @@
 #include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "sysemu/runstate.h"
+#include "net/eth.h"
 
 #include <vmnet/vmnet.h>
 #include <dispatch/dispatch.h>
@@ -147,10 +148,25 @@ static int vmnet_read_packets(VmnetState *s)
  */
 static void vmnet_write_packets_to_qemu(VmnetState *s)
 {
+    uint8_t *pkt;
+    size_t pktsz;
+    uint8_t min_pkt[ETH_ZLEN];
+    size_t min_pktsz;
+
     while (s->packets_send_current_pos < s->packets_send_end_pos) {
-        ssize_t size = qemu_send_packet_async(&s->nc,
-                                      s->iov_buf[s->packets_send_current_pos].iov_base,
-                                      s->packets_buf[s->packets_send_current_pos].vm_pkt_size,
+        pkt = s->iov_buf[s->packets_send_current_pos].iov_base;
+        pktsz = s->packets_buf[s->packets_send_current_pos].vm_pkt_size;
+
+        if (net_peer_needs_padding(&s->nc)) {
+            min_pktsz = sizeof(min_pkt);
+
+            if (eth_pad_short_frame(min_pkt, &min_pktsz, pkt, pktsz)) {
+                pkt = min_pkt;
+                pktsz = min_pktsz;
+            }
+        }
+
+        ssize_t size = qemu_send_packet_async(&s->nc, pkt, pktsz,
                                       vmnet_send_completed);
 
         if (size == 0) {
-- 
2.37.1

