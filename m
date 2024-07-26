Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B03A1C3DA49
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2024 06:01:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sXDzX-000166-NM; Fri, 26 Jul 2024 01:59:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1sXDzW-00012F-NK
 for qemu-devel@nongnu.org; Fri, 26 Jul 2024 01:59:46 -0400
Received: from mail-oi1-x233.google.com ([2607:f8b0:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1sXDzV-0006bO-4i
 for qemu-devel@nongnu.org; Fri, 26 Jul 2024 01:59:46 -0400
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-3db1d4dab7fso98885b6e.1
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2024 22:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1721973583; x=1722578383; darn=nongnu.org;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to;
 bh=FLUVpm7q4t3wLyhn54TwgrrVNxCRL3GBe3+Zpe/mX4s=;
 b=R9zl//GyxMe8oyjZPl8u5Z60nm25EVq3emsmzXYFpfml/VBw1ZTqgkXQsXNPopOj/P
 YrfyKdIibvX1CwmtMn4f8+n1A+Hv4OD/ouf4gf5LKQp0jk+d/RNQlqtaypvqKQYsw0f8
 UhpGNjfV/klp8xgKDNv4OaSsAihu8+71zrt84gSC23SPxUKvZGkr+2aB66OwujGSTpT4
 86B2y1sOv7YJCIUWk+8JYn9nP7n65rGm/9M8hT+eS136W2+TzqNoJJMwAaT8OzOkyECI
 RanreEgUYxmfOW+Gesvlp0gkrsckVVK+RNRdz4LTKPmaL6nEFrqK3Ehhg6pMjfkmssyr
 z+rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721973583; x=1722578383;
 h=references:in-reply-to:message-id:date:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FLUVpm7q4t3wLyhn54TwgrrVNxCRL3GBe3+Zpe/mX4s=;
 b=pSjN7OTpH2jqaW/3XKzB0FIZt6ZEUcpTvrFv7wa+JgrYaOpGwCb0Z6MGp7PSY79ORF
 CHRV5/HVwY5S3Nl8/LNSr0mY+FDVb+Asb8huyDyx5hLDHKa/rqBpeeZ3VsK77ATvq8i/
 MLGJH3NLY9wqwgihydB/n4I1RygG7CezjeRJyF4d1CsGtk+aJcCOM63b7T04h2Wh1eRa
 /bc/Ld+cBG3sMOb9uXYodZpIlL/UMDrM2Q4RuLpUFbnquNeZGGtRbqlkJcr1JmF0zdaz
 kxaWKhqV1QYvuWbFzXstcDDCGzX82SD9CHRcLj0fNg7V9sXimu8LuNqDL/UMHdi81xUM
 J/3g==
X-Gm-Message-State: AOJu0YyasHYZmpsbVpH9b8/xG3kMFJ39S05UNR7fBkfR+2bopr6bm3qj
 sXzViUODTBtY6VO3u4ZPH/a/27hHqlTD77XVJuV9OJWM5EFoU/Hc2LEnJ57jdgFxh/F11GpG1K8
 bh3hJal2M/fyF/yTSxPb2V7eLxOOH34nExhbTgVlrYKQDPiWzKHFWVACb3SQfOga/4pcEMxCyiP
 +QfD5d3lrg+zx70pBteHWd6I4GAEIj1/m6ZA==
X-Google-Smtp-Source: AGHT+IHEGqtwPvIMzxD5kT3T1o/3W1YlzNZIhHuqum5ELuoyyjRYDxjZBikFuS73jKDvepGoCr7HNg==
X-Received: by 2002:a05:6808:170a:b0:3d9:2b24:5b2 with SMTP id
 5614622812f47-3db10cf0ae0mr6044971b6e.0.1721973583078; 
 Thu, 25 Jul 2024 22:59:43 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com
 (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70ead6e1a4bsm2002128b3a.5.2024.07.25.22.59.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 22:59:42 -0700 (PDT)
From: Jim Shu <jim.shu@sifive.com>
To: qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 qemu-arm@nongnu.org (open list:Xilinx Zynq), Jim Shu <jim.shu@sifive.com>
Subject: [PATCH 1/4] hw/dma: xilinx_axidma: Correct the txlen value in the
 descriptor
Date: Fri, 26 Jul 2024 13:59:30 +0800
Message-Id: <20240726055933.817-2-jim.shu@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240726055933.817-1-jim.shu@sifive.com>
References: <20240726055933.817-1-jim.shu@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::233;
 envelope-from=jim.shu@sifive.com; helo=mail-oi1-x233.google.com
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

Currently, txlen is always decremented to 0 before filling to the
descriptor. Keep the origin txlen value to have the correct value of
descriptor status field.

It will fix the 'tx_bytes' statistic value in linux axi-ethernet driver.

Signed-off-by: Jim Shu <jim.shu@sifive.com>
---
 hw/dma/xilinx_axidma.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/dma/xilinx_axidma.c b/hw/dma/xilinx_axidma.c
index c9cfc3169b..6aa8c9272c 100644
--- a/hw/dma/xilinx_axidma.c
+++ b/hw/dma/xilinx_axidma.c
@@ -291,7 +291,7 @@ static void stream_process_mem2s(struct Stream *s, StreamSink *tx_data_dev,
                                  StreamSink *tx_control_dev)
 {
     uint32_t prev_d;
-    uint32_t txlen;
+    uint32_t txlen, origin_txlen;
     uint64_t addr;
     bool eop;
 
@@ -314,6 +314,7 @@ static void stream_process_mem2s(struct Stream *s, StreamSink *tx_data_dev,
         }
 
         txlen = s->desc.control & SDESC_CTRL_LEN_MASK;
+        origin_txlen = txlen;
 
         eop = stream_desc_eof(&s->desc);
         addr = s->desc.buffer_address;
@@ -334,7 +335,7 @@ static void stream_process_mem2s(struct Stream *s, StreamSink *tx_data_dev,
         }
 
         /* Update the descriptor.  */
-        s->desc.status = txlen | SDESC_STATUS_COMPLETE;
+        s->desc.status = origin_txlen | SDESC_STATUS_COMPLETE;
         stream_desc_store(s, s->regs[R_CURDESC]);
 
         /* Advance.  */
-- 
2.17.1


