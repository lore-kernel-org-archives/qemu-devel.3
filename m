Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7C63CD11C2
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2024 07:05:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruS1H-0001H3-Qi; Wed, 10 Apr 2024 03:05:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ruS1E-0001Gd-HX
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 03:05:18 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ruS14-0000bL-8R
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 03:05:15 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a51c37a5025so445575266b.1
 for <qemu-devel@nongnu.org>; Wed, 10 Apr 2024 00:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712732703; x=1713337503; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=YLfaseF0Qifr+4CL6TXFTt+PjBV/O4wfW8krU74Swcw=;
 b=xV/FSumckurx5rN1SFh0hFwrXpDMmFzRxZDe5DCIP8XkraSDOSCkiXoV6xn3EIY/hM
 4PjutnSJ5O20kQpzsbAFxxsNAJNDJ6BG1wSOYSWf4nc1cpqA15UDwFJOvvZne+EqbBK4
 zWCle3C6yHO7cTPqEQVaG8voZBmliff9t7eLVitSDmsuM/TfVTcphoXmsAsE7juzEFqE
 7IGzXHK4GB9/fZjcZFjXKmdA1mHYkDpjIUWjsr/lKVYm3sIiuzf4d6NBe3L4XXLzokL+
 xKFn6Bu542xVDZUpZTjQl8GxE8XNJCPQs425+mMlxC45S3c3Hf8ylAyR0TCdKKumxwe4
 XtJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712732703; x=1713337503;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YLfaseF0Qifr+4CL6TXFTt+PjBV/O4wfW8krU74Swcw=;
 b=Nmzow8obOEMb4KPD0x6Kt+FmolXPfNq2CCOrTuVBc8Md9eWqyW1gl9t4C/6nEZ6V8d
 T1PWdwacc0i376F1LumsJHS/Lcecjh2OqDjvhgLuncGvHpxcKrRjLJWQgneum113EuRQ
 qPyL0KdThQXI7Kwjx1X4w1uMEjHhN7Zj4uaqwCG5zUDrPLVeo++KcPMitAxqup6GEv12
 uS12STGK1x/OwKzKG4S1RyAQ1D6bNFP26LX7rUUfMZ8rvh2tMYZSV8b/Uu8TPP59cSmD
 JQTjwnfu+DIvD9yDFR1Xjacy6nppzM2iewaeT0EY/yXYYGzSR2JMsmMT7HwCRsddNHsX
 1ycg==
X-Gm-Message-State: AOJu0YxuMpM9137PHy1knTdJZqjingjxvLmvWqdyt0UXwxbh+n7eVa4U
 tXRZEWK6aXCRO9rcZBEP/1X+fhR3bQKOoQMn5X9cog02L+9XjX3sa/7rpBRMI7/CiBseVRjuXYC
 X
X-Google-Smtp-Source: AGHT+IFlth8MGZfmzKM6DjnXuZ5UxHCeS8alc2JcdegkwVDACbK0lcxK5fCYyTBpj3rR5enWAhEdOw==
X-Received: by 2002:a17:907:3183:b0:a51:b36e:61c7 with SMTP id
 xe3-20020a170907318300b00a51b36e61c7mr1175383ejb.13.1712732702737; 
 Wed, 10 Apr 2024 00:05:02 -0700 (PDT)
Received: from m1x-phil.lan (arl95-h02-176-184-34-173.dsl.sta.abo.bbox.fr.
 [176.184.34.173]) by smtp.gmail.com with ESMTPSA id
 oz7-20020a1709077d8700b00a46a9c38b16sm6572575ejc.138.2024.04.10.00.05.01
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 10 Apr 2024 00:05:02 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Jason Wang <jasowang@redhat.com>, Akihiko Odaki <akihiko.odaki@daynix.com>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Mauro Matteo Cascella <mcascell@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-stable@nongnu.org, Zheyu Ma <zheyuma97@gmail.com>
Subject: [PATCH-for-9.0? v2] hw/net/net_tx_pkt: Fix overrun in
 update_sctp_checksum()
Date: Wed, 10 Apr 2024 09:04:59 +0200
Message-ID: <20240410070459.49112-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

If a fragmented packet size is too short, do not try to
calculate its checksum.

Reproduced using:

  $ cat << EOF | qemu-system-i386 -display none -nodefaults \
                                  -machine q35,accel=qtest -m 32M \
                                  -device igb,netdev=net0 \
                                  -netdev user,id=net0 \
                                  -qtest stdio
  outl 0xcf8 0x80000810
  outl 0xcfc 0xe0000000
  outl 0xcf8 0x80000804
  outw 0xcfc 0x06
  write 0xe0000403 0x1 0x02
  writel 0xe0003808 0xffffffff
  write 0xe000381a 0x1 0x5b
  write 0xe000381b 0x1 0x00
  EOF
  Assertion failed: (offset == 0), function iov_from_buf_full, file util/iov.c, line 39.
  #1 0x5575e81e952a in iov_from_buf_full qemu/util/iov.c:39:5
  #2 0x5575e6500768 in net_tx_pkt_update_sctp_checksum qemu/hw/net/net_tx_pkt.c:144:9
  #3 0x5575e659f3e1 in igb_setup_tx_offloads qemu/hw/net/igb_core.c:478:11
  #4 0x5575e659f3e1 in igb_tx_pkt_send qemu/hw/net/igb_core.c:552:10
  #5 0x5575e659f3e1 in igb_process_tx_desc qemu/hw/net/igb_core.c:671:17
  #6 0x5575e659f3e1 in igb_start_xmit qemu/hw/net/igb_core.c:903:9
  #7 0x5575e659f3e1 in igb_set_tdt qemu/hw/net/igb_core.c:2812:5
  #8 0x5575e657d6a4 in igb_core_write qemu/hw/net/igb_core.c:4248:9

Cc: qemu-stable@nongnu.org
Reported-by: Zheyu Ma <zheyuma97@gmail.com>
Fixes: f199b13bc1 ("igb: Implement Tx SCTP CSO")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2273
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
Since v1: check at offset 8 (Akihiko)
---
 hw/net/net_tx_pkt.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/net/net_tx_pkt.c b/hw/net/net_tx_pkt.c
index 2134a18c4c..b7b1de816d 100644
--- a/hw/net/net_tx_pkt.c
+++ b/hw/net/net_tx_pkt.c
@@ -141,6 +141,10 @@ bool net_tx_pkt_update_sctp_checksum(struct NetTxPkt *pkt)
     uint32_t csum = 0;
     struct iovec *pl_start_frag = pkt->vec + NET_TX_PKT_PL_START_FRAG;
 
+    if (iov_size(pl_start_frag, pkt->payload_frags) < 8 + sizeof(csum)) {
+        return false;
+    }
+
     if (iov_from_buf(pl_start_frag, pkt->payload_frags, 8, &csum, sizeof(csum)) < sizeof(csum)) {
         return false;
     }
-- 
2.41.0


