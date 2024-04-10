Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37881CD1296
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2024 09:16:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruU3X-0007ub-Vp; Wed, 10 Apr 2024 05:15:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ruU33-00077N-7W
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 05:15:19 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ruU2y-0005t1-PN
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 05:15:15 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-566e869f631so6401267a12.0
 for <qemu-devel@nongnu.org>; Wed, 10 Apr 2024 02:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712740509; x=1713345309; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t0Ig4tCUv+CoSBcmjY5cMZ6OdlOyTnZul85SObM22NQ=;
 b=AqXOk2nSJNtVk7lVzgdGLctPUkUHw/ofTtSfjpDdzGbImbg48YZ08pknkddPF/PX9e
 BN6VyepUDyTl/hRpV+Vsr++ZA7OBitXVuns90+DCDkSgOCO9rbj4ZxHvPeq3he2b6W6J
 RglxVrXQMEVpfwrzFJK0XJjJd47FopKgrd/5ZG4pvkn4oYUs8cg3yjefTGZJPXmr/bg0
 hA+dttDdFwivgQhHkF5WbDMKXPl20tvRW7031uLXOZkvMtDgp/pSn+L+6Y3w+kKHjg8Y
 Q1LM2cswYAE/D8vhjiAa1hVVFZyvzzHNFiqxNyKQV8o+Of7hF2Q8nTFb98VhWpIFsWXD
 D+0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712740509; x=1713345309;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t0Ig4tCUv+CoSBcmjY5cMZ6OdlOyTnZul85SObM22NQ=;
 b=I12hMFXZPqgP96aRPGpOPYdt2qx7UUDPgTEtrfA8jT1T+Aj/cHXFieqQeO+H2TAfyV
 ZO9Pawk7Pn04j//g6jK1V2F2XxHrg2WQ31YzicQ+c6S+H/Tjs6tMcZlBJ42Bc/poYKyj
 Fb/K5BmmahzdkCteps5iLDGZ0cLubyZgYiVblsEqf/Kz5YK07eS5CTvOFS54T6K+/Tvu
 Mg8oCXgU+BKh3AxIgrafDzNFipAsfHJKjMA7AWpFqfGxfFCbDJ7FhVsssiwzy87nmpHH
 X5S9rTNI9p7kb8QrboRaJJQ8MOFXClis5FSLSaVFNbCx5n8+0webLPiANEgkGz/5juRb
 7C/w==
X-Gm-Message-State: AOJu0YxlHY781gNBDiA34q32h/qXtAGBfapWVFRb60/bM9dTWNwaTr8Y
 lFgN2gUe2a9fCeoVqTvlwAyuaMQdzgZTGFCnbYpNQAT0vhchgIB26imtwWGOwfncmFxZHTawo03
 E
X-Google-Smtp-Source: AGHT+IEDuM948sjn4KH2bfPGevG8GxP4WUqHqyIlhX+AT6ruXCgMx1gnBPx4pLsgfXrXkfREtRwieQ==
X-Received: by 2002:a50:d78f:0:b0:56c:522f:53e1 with SMTP id
 w15-20020a50d78f000000b0056c522f53e1mr1601603edi.17.1712740509553; 
 Wed, 10 Apr 2024 02:15:09 -0700 (PDT)
Received: from m1x-phil.lan (arl95-h02-176-184-34-173.dsl.sta.abo.bbox.fr.
 [176.184.34.173]) by smtp.gmail.com with ESMTPSA id
 p6-20020a05640210c600b0056e719a9a1bsm1797741edu.16.2024.04.10.02.15.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 10 Apr 2024 02:15:09 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-stable@nongnu.org, Zheyu Ma <zheyuma97@gmail.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, Jason Wang <jasowang@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>
Subject: [PULL 15/16] hw/net/net_tx_pkt: Fix overrun in update_sctp_checksum()
Date: Wed, 10 Apr 2024 11:13:14 +0200
Message-ID: <20240410091315.57241-16-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240410091315.57241-1-philmd@linaro.org>
References: <20240410091315.57241-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x529.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Fixes: CVE-2024-3567
Cc: qemu-stable@nongnu.org
Reported-by: Zheyu Ma <zheyuma97@gmail.com>
Fixes: f199b13bc1 ("igb: Implement Tx SCTP CSO")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2273
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Message-Id: <20240410070459.49112-1-philmd@linaro.org>
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


