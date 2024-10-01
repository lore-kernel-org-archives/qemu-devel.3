Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50576CEACE8
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2024 16:40:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svfuJ-0005Iq-Dg; Tue, 01 Oct 2024 12:39:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1svfuH-0005Hp-UB
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 12:39:25 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1svfuG-00060R-Aw
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 12:39:25 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-42cb806623eso45069715e9.2
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2024 09:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727800763; x=1728405563; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=NJThQIRGnyNv6fVMTVsdHAI9ObKTczO5pYduCs81VQs=;
 b=zMneDgmnh4jP/qGJkqU8RJkyn3KnuFnb1DMSTnxffqJP0B9FWnsmgRy7h3Xw1JUSR6
 FvfrLFXrYWY9dGZJ/ZfZFcq1ZSYR+l3RrUNGZnINo/dTN7jaE8CJ9+szxZUELRKgzbYp
 nTKvb+UJDXK/4aa5+CqYBsrFeXlRRJxr4ldgqRVSk9sxeQtXOhVCXws1Xjn3Edv0/0wj
 bxxxSwZ/o1fuz+1XAxDmD26Vz390XBxU7xi22Fl21hiSxpUqrsPoKGoplys0nKkJLE71
 +Hlk21ARKmCK8LTrMe24IslVQvpOvEd7F4Ps1Bj6zr0BX667h7ikO6RkHeh8eO7A71oD
 2ioA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727800763; x=1728405563;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NJThQIRGnyNv6fVMTVsdHAI9ObKTczO5pYduCs81VQs=;
 b=kls83NO6yfoU0uDzyJij3OGXekEENJ9uHQl1fRNDarquDr+lgZbPsCiu7SXq2irnAL
 lBdymBy2Xde7jedWURei+N6EPakPkfT8uluHO5dyuwSb08rThfJ5TKun3bBO0EjJC41K
 h6mejmCTuxiQ/FhIo/51Y2CGHCXQr09aI2VNqZs+kq0IJjUfUtOA9d9qEVnhXJwKnBMB
 BrdOKUIT3qr6+YkPeLZ4vlh5Sk+zJri8AsbyAU7TlE6CeDIPh0SC4b1QRX4MsvHn78Z4
 q8JTlsctgiMEyYIml46KfW7b9Y2hB3m8dytpYy6iF7kb92MoUKtUPCzWQuj5gEVHjcOf
 JS7A==
X-Gm-Message-State: AOJu0Yy/rkYNMsgyv5qqMpRN21W3BP0g82g5pZYAaq17h14Mc6vaAKUI
 mTjjexNm3WMXri9vc0xn7WgfOxN84L0+gEdLWlZxADm+4vFpsbTaJ3KQdPjV+KtaNpQf8J+m5c5
 f
X-Google-Smtp-Source: AGHT+IHeRnI+tzWmE3tfhz4DVHA1hUnUh4oJQsmvk+vAVqmxvyUeOI7RC7nbPNjtu6Bshd4Khj3wNQ==
X-Received: by 2002:a05:600c:3b1a:b0:42c:b961:c902 with SMTP id
 5b1f17b1804b1-42f777b7a23mr799255e9.12.1727800762597; 
 Tue, 01 Oct 2024 09:39:22 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37cd56e6547sm12243771f8f.58.2024.10.01.09.39.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Oct 2024 09:39:22 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 05/54] hw/ssi/xilinx_spips: Fix flash erase assert in dual
 parallel configuration
Date: Tue,  1 Oct 2024 17:38:29 +0100
Message-Id: <20241001163918.1275441-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241001163918.1275441-1-peter.maydell@linaro.org>
References: <20241001163918.1275441-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
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

From: Shiva sagar Myana <Shivasagar.Myana@amd.com>

Ensure that the FIFO is checked for emptiness before popping data
from it.  Previously, the code directly popped the data from the FIFO
without checking, which could cause an assertion failure:

../util/fifo8.c:67: fifo8_pop: Assertion `fifo->num > 0' failed.

Signed-off-by: Shiva sagar Myana <Shivasagar.Myana@amd.com>
Message-id: 20240924112035.1320865-1-Shivasagar.Myana@amd.com
Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
[PMM: tweaked commit message]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/ssi/xilinx_spips.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/ssi/xilinx_spips.c b/hw/ssi/xilinx_spips.c
index 1595a887a1d..aeb462c3cec 100644
--- a/hw/ssi/xilinx_spips.c
+++ b/hw/ssi/xilinx_spips.c
@@ -620,7 +620,9 @@ static void xilinx_spips_flush_txfifo(XilinxSPIPS *s)
         } else if (s->snoop_state == SNOOP_STRIPING ||
                    s->snoop_state == SNOOP_NONE) {
             for (i = 0; i < num_effective_busses(s); ++i) {
-                tx_rx[i] = fifo8_pop(&s->tx_fifo);
+                if (!fifo8_is_empty(&s->tx_fifo)) {
+                    tx_rx[i] = fifo8_pop(&s->tx_fifo);
+                }
             }
             stripe8(tx_rx, num_effective_busses(s), false);
         } else if (s->snoop_state >= SNOOP_ADDR) {
-- 
2.34.1


