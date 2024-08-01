Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93497C52D54
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 14:07:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZWRl-0006Iq-C2; Thu, 01 Aug 2024 10:06:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1sZWRi-000684-S6
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 10:06:22 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1sZWRf-0006r4-Rh
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 10:06:21 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1fc49c0aaffso52714455ad.3
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2024 07:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1722521178; x=1723125978; darn=nongnu.org;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to;
 bh=FLUVpm7q4t3wLyhn54TwgrrVNxCRL3GBe3+Zpe/mX4s=;
 b=N8R6XY3xvjr01FT2dfyPzdSofOFlB/EMTaUogvoV43XAY08mLcvJqPF7XOmkDh/jH7
 k0YB72H6i4qAaYFOvvInEKeeCl19J13a80k3nw05ZBzLpEgP1dLgQCY6mJhkHgppf/PT
 xvBygTFkBDEYsYo6pkxRGuaSqKwHlCFCDCU2F3cBbqwFvxVLWI3oW///N6yuAyx2haXM
 fwJCMr0+ZCBeZrxjnuTGbBS3LXn5G5+nbQy76VLyiRJs96k344Dn910IGoxoGzc05W/c
 FZpg3d8gw9JHu6xZ/PiC3FOKWx0tD92amla/fxy0gLgb7tca7fhECI3FIZ+gJPbG66jA
 8hCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722521178; x=1723125978;
 h=references:in-reply-to:message-id:date:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FLUVpm7q4t3wLyhn54TwgrrVNxCRL3GBe3+Zpe/mX4s=;
 b=SGC808D50MA/huxgorpbYb21LxXyQc3bEKVCg9NE+aTv0HX1EwA5/pymR/jpD27TNH
 mdaRsa1CD6b+j/QiZWmQLluGW+w8l4vfQqskrunaCaHLDdndsd9A36HZvBrDzCGN7P34
 OGzOH4xG3L2+FfaOcoMYL+zkZN+RtUArVYttyRdAH3NIIENHgBPTSEEQxmIjX85k/lYP
 jpI74FDy19sHSSzAA5Mhg2i5QSTBbBiMWI/qdsoii5Rno+fOMyRGI3PiPtKrc17jkPml
 14gtCpsEunj2+NS5AOrwZHumF7GJmUV8nzTp8mEykIvSNAQ6gwpVuGEN4IKty0LifZgx
 lWWw==
X-Gm-Message-State: AOJu0Yz28sCPl2UOygSO1Vuw5R9VbsEE+ELvqSNqGKDnfU1I/q9EaMke
 ay40HHyIWA0ZLlpRcOHvoKNAO+Qd2zouZSNVVFd7Os8QrLl2N6Ct+WrMSuV3APmvhaHaBMh1l9O
 bNq8vIkmD+PhIqLGcZuG5BrOjYDtZxVqu8lhKjQZ1954ZfU4giH2kJNi7rf31waqGXAgpWdhlTF
 7V686Vr78UlIrebrPMVEP3ZK+V9IBOeFT7Rijs
X-Google-Smtp-Source: AGHT+IFZXMf6uWKao/QznG8kHjC4gK5FTMlxjrncQVt6vsfVD0jr+3sOFI36WWIo5nqryY8Vwc6IQw==
X-Received: by 2002:a17:902:c402:b0:1fd:8f14:a109 with SMTP id
 d9443c01a7336-1ff5732be1fmr2920615ad.32.1722521177461; 
 Thu, 01 Aug 2024 07:06:17 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com
 (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fed7cc0213sm142631275ad.72.2024.08.01.07.06.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Aug 2024 07:06:17 -0700 (PDT)
From: Jim Shu <jim.shu@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Jim Shu <jim.shu@sifive.com>
Subject: [PATCH v2 1/3] hw/dma: xilinx_axidma: Correct the txlen value in the
 descriptor
Date: Thu,  1 Aug 2024 22:06:07 +0800
Message-Id: <20240801140609.26922-2-jim.shu@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240801140609.26922-1-jim.shu@sifive.com>
References: <20240801140609.26922-1-jim.shu@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=jim.shu@sifive.com; helo=mail-pl1-x632.google.com
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


