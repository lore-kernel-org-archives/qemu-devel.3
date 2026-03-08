Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0396FEA8543
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2026 22:38:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzMkd-0006RX-Dg; Sun, 08 Mar 2026 18:37:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzMkc-0006NS-34
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 18:37:30 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzMka-0003Wo-DL
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 18:37:29 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-48374014a77so131497605e9.3
 for <qemu-devel@nongnu.org>; Sun, 08 Mar 2026 15:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773009447; x=1773614247; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=rwK2gpRx4ZMM6baKIcixqp2pUxMSXROQNvBnKyoazTA=;
 b=ibDbooAIs+rTkzYmxOU19UvO5CCppIJI19BJ6b1l/kDcBFvyDPGpK8FYh0wJ/+st4V
 gL8zb/1WzHWTDe5PVzH0Pj4W1XOv8gfbfNotE1phEykGfrs12XhQaxZ/jOp70r/WxbcN
 WTEtMnP7Yl9sxooVqA1pEMhwfrhgvtkyuXpozqXZPY82cGNiQyiJwbgATRylwjN19Ows
 bU+DRhl2245sKkEKai5pjwU81uf0Wp2YPykeYVJEOZklAvAnGUHI8GCGwFWjopTjqB10
 gRDKk2ucItMsrd0TOjKYCFe3xkD9daFn1B11IwQzCKMl83NZDG6G4RiIv7UNdUjgGQsq
 XaIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773009447; x=1773614247;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=rwK2gpRx4ZMM6baKIcixqp2pUxMSXROQNvBnKyoazTA=;
 b=AnhsF7/Ee7xafXNqONkJzvtV15VRre6YK+ji4mUF1PuwMlGYDbSQebDMccfV0WILF9
 R4AmRoAp88enQOgXUADON9NoGfZXo1f85sQQ2gN8D7j8fFgdB8nCBRCFQX+Wsr5IQeoj
 bUz7mdo84lrw7lr4+NR6qYXORAZ/nmf5Pf7/5v7NM+TSIhlGAYpfyUpl9eKTxlY9GPHq
 SjXoXtZo3Grj7zqbSeDZjmzJHaKhiaYW3HRptOlC54taHxnIci7EtSO3AgngXGnuz17H
 pkHkY0WSKSxNa5FN7wBwJr3hYvUj70HsCqmMKaurpRvDCe0XM/+jzsSEJGYnpwSPEauk
 MsaA==
X-Gm-Message-State: AOJu0Ywv3cP7651DhJj1LR48QgqDNoE2utABFefqz2QKf74adYtfaEds
 +KrxlVOcnHapwljgf099a69D1RVYtNeOh0l0goAqA3U/3EC9BRBLz9NCm++c+iFYBoPD6k1TPSK
 r0wxd7KQ=
X-Gm-Gg: ATEYQzxDXyTaDdBIfAgC46in81XJ0n7rftbTEWyHCCTmA4sFU5P+KraI6ztX34PyUjs
 7TfbAaZOou2hpX6FIgQWsSQCsRx+9eYjRFTIiUdTWdcyOgPvX7rvhPPEioV4oa49SZMmnXuqqR4
 J8L2S/blxUBxZqyPnkT5q7Z6+aPu7cjnl0oPl7U9ZGr9J+XiCZAgntbZfNtlfNxuto5GY/Wsf2L
 oUDxaikUF7piwblt5ONRNKGsrHQRXoSNhDYyzqvv92dtwueA4ejsq99kNc6l4aJqfu9rv514EPp
 9BCbsQa4hVDRDjpjuuyNKoKS9wo2PmL1whNf05ThAvt6IzWDlKkTT5XYoi0CiJ6ppHnoeUaouji
 31zf6XLkWrezEvRwYsYOR28JB7F2bCl3bwXTTyT1SfT0DUXykOVeqx3Vy4oSZvWYkg7Sx6YQJvN
 5OpdPGlTBpBFhPhsciJrrEgL2TikcI2woIGNv8m+qdoQIzpf8Xli1j/IqR1vLCcWSAKnaPmAEAa
 Hwhig==
X-Received: by 2002:a05:600c:3e87:b0:485:3e00:9440 with SMTP id
 5b1f17b1804b1-4853e0094acmr902045e9.24.1773009446512; 
 Sun, 08 Mar 2026 15:37:26 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4851fae00absm290195735e9.4.2026.03.08.15.37.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 08 Mar 2026 15:37:26 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 25/49] hw/net/xilinx_ethlite: Check for oversized TX packets
Date: Sun,  8 Mar 2026 23:34:09 +0100
Message-ID: <20260308223433.25503-26-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260308223433.25503-1-philmd@linaro.org>
References: <20260308223433.25503-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

From: Peter Maydell <peter.maydell@linaro.org>

The xilinx_ethlite network device wasn't checking that the TX packet
size set by the guest was within the size of its dual port RAM, with
the effect that the guest could get it to read off the end of the RAM
block.

Check the length.  There is no provision in this very simple device
for reporting errors, so as with various RX errors we just report via
tracepoint.

This lack of length check has been present since the device was first
introduced, though the code implementing the tx path has changed
somewhat since then.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3317
Fixes: b43848a1005ce ("xilinx: Add ethlite emulation")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Message-ID: <20260303172718.437015-1-peter.maydell@linaro.org>
[PMD: renamed size -> tx_size to avoid shadow=compatible-local error]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/net/xilinx_ethlite.c | 12 +++++++++---
 hw/net/trace-events     |  1 +
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/hw/net/xilinx_ethlite.c b/hw/net/xilinx_ethlite.c
index ba3acd4c77c..7ea194475f1 100644
--- a/hw/net/xilinx_ethlite.c
+++ b/hw/net/xilinx_ethlite.c
@@ -162,9 +162,15 @@ static void port_tx_write(void *opaque, hwaddr addr, uint64_t value,
         break;
     case TX_CTRL:
         if ((value & (CTRL_P | CTRL_S)) == CTRL_S) {
-            qemu_send_packet(qemu_get_queue(s->nic),
-                             txbuf_ptr(s, port_index),
-                             s->port[port_index].reg.tx_len);
+            uint32_t tx_size = s->port[port_index].reg.tx_len;
+
+            if (tx_size >= BUFSZ_MAX) {
+                trace_ethlite_pkt_tx_size_too_big(tx_size);
+            } else {
+                qemu_send_packet(qemu_get_queue(s->nic),
+                                 txbuf_ptr(s, port_index),
+                                 tx_size);
+            }
             if (s->port[port_index].reg.tx_ctrl & CTRL_I) {
                 eth_pulse_irq(s);
             }
diff --git a/hw/net/trace-events b/hw/net/trace-events
index 23efa91d055..001a20b0e2a 100644
--- a/hw/net/trace-events
+++ b/hw/net/trace-events
@@ -527,3 +527,4 @@ xen_netdev_rx(int dev, int idx, int status, int flags) "vif%u idx %d status %d f
 # xilinx_ethlite.c
 ethlite_pkt_lost(uint32_t rx_ctrl) "rx_ctrl:0x%" PRIx32
 ethlite_pkt_size_too_big(uint64_t size) "size:0x%" PRIx64
+ethlite_pkt_tx_size_too_big(uint64_t size) "size:0x%" PRIx64
-- 
2.53.0


