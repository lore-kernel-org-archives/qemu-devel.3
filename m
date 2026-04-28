Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 626BDFF8868
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2026 16:03:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHktb-0003VR-6f; Tue, 28 Apr 2026 12:02:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1wHksM-00034m-T7
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 12:01:31 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1wHksJ-0003iD-IU
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 12:01:30 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-82f83bd32efso8551640b3a.2
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2026 09:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1777392083; x=1777996883; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VQANHWAgJWbGUByZ7ElwjIusOl7UBvMVgDS40O+mI7E=;
 b=ZXIVJ875aOHo8ahR0OmL9EmBFf7Tk3O2bbuA54yhMzsen8pPj2q67Bs9fZsDyo/X3W
 AdrVRmmYNhpY7a2VYL0xfrCgHAI6yqy1z90bIaAVIhWUbisM1FXqp2b6F+w1PeHabgil
 9U9nq3Tx3BXbkgZlKU7wpc2LnT8mqwhbxQRNTTBTD7iC6mdUW/P5T64ZX9CkEjnv3Y/O
 Yk+2DpwMcQ63xADcwjZzAWraQ9JBmL4h513C05WPM/vhcl9A2EFHEZCiNxc3bbWn1tta
 Zrj98t+aZEuCTOxvjPd2x+TOKfNMcXbdEhhgdy/XHXxq6yWWMvPBGZuiNjl6ig3qqkgD
 HCEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777392083; x=1777996883;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VQANHWAgJWbGUByZ7ElwjIusOl7UBvMVgDS40O+mI7E=;
 b=GMVN9q0dp8bUmZDlk9q0IvHOIUF3J3yatxYtUIqsfxrb2zCrFzCjwLrkt05C8vXP37
 mN6uUC5ju/Bv49sjkGAIcEaFRqDWjP13AUO1Ua0fwOqkebof2r3QRYGqKFd7EmFFDlGa
 cN+CuHEIG/Iu9WfCMnnL9HMWwmEFkF68AZqGvwYcCJlCCLu/ag++V8cnsizyvXxwAwr2
 X4Rqb0G+dhITEY/hOgWPxwLCrX+W1T6NokdAGZyXPuE0VLUHDnajp3L0jAA76/MNdO3p
 GyPAP4iIHJQxY3OdTbxd5T1dLymOeZ20ZhaDsISUqdxY5lrDEz579bv0lmHY9mw+DzEc
 nNFA==
X-Gm-Message-State: AOJu0YzI99pd/g+yLjL0kNXG5EAJrT67bO961+zkvw4zazWj/o66mf0A
 1r9T5oY9qSATAvPBJTRQhTnuIqiNGIiqvW8LX9XaMskqJ9bSTEbbLkdOdzNmXuND+FHCoSSCsr9
 tjf19xS8Xo7h6YYoBfJD/1QVH9QfMVFF0azn2aHBQcrHqg/LHvJbPYCh9Jhs9SRQ3Aj2k6wzkOu
 M+HFca+kwP76djYcDDs+CM8xHDvO+OhfyEXZyaFnTH
X-Gm-Gg: AeBDieumyvVEh1b1MVn1140mROmy5apA9WtrYcV1xNnc8+DX1+kqYVssBO6IIqQHXGZ
 xJrbGnrHtGUodkla7tbPXjHCvhozA3VIiGc6geylEJltuFpWSQha9KZu4SFE48oUi7Bji3AXY9L
 cPfiTDTqKw/kYicsPshNc8LBs6vDOf0V2vtvjtOVAqH6710yFtCjBf2/p1kMBJXzoyfuDUyuBQt
 msQg4NiK8hKYzLd2PX+/90a5J3pBUSz9qHD4hQ8ldk4a+WZxHHX3EFu60MMX4znBtZzybLj+5TT
 Tj5FnOCPUo3YpAAW/Z0AQwuxMFtIc0rt78NdVha5BBTkQnyc5DK3hrW4K6eRQPkTcY+oboqvNoW
 5RrapFLWg9Uj8+9w2bPaIAjfGQPv3b54Efm+LhWJ/4l9SD4jonDDyceABmVBjxqBbDYTy0xaCAw
 VEToj9qNPGj6cR8AQPV22S1a573kq4EeWg6iDHdP5Bgb0eG2ImZq5uGG4=
X-Received: by 2002:a05:6a00:2191:b0:82f:6e9:d1ba with SMTP id
 d2e1a72fcca58-834ddc09748mr3996747b3a.37.1777392081770; 
 Tue, 28 Apr 2026 09:01:21 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-834daf30fbfsm3002331b3a.33.2026.04.28.09.01.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 09:01:20 -0700 (PDT)
From: Jim Shu <jim.shu@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Jim Shu <jim.shu@sifive.com>
Subject: [PATCH 1/4] hw/intc: riscv_aplic: Fix level trigger IRQ in direct
 delivery mode
Date: Wed, 29 Apr 2026 00:01:00 +0800
Message-ID: <20260428160103.3551125-2-jim.shu@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260428160103.3551125-1-jim.shu@sifive.com>
References: <20260428160103.3551125-1-jim.shu@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=jim.shu@sifive.com; helo=mail-pf1-x42d.google.com
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

According to the AIA spec ch4.7 ("Precise effects on interrupt-pending
bits"), pending bit of APLIC should be set/cleared whenever the
rectified input value is high/low in the both level-trigger mode
and direct delivery mode.

Currently, QEMU APLIC only clears the pending bit when interrupt is
claimed in APLIC, but not clears it when the rectified input value is
low. (e.g. IRQ source signal is low in the LEVEL_HIGH/Level1 mode).
The software may receive an additional IRQ if the peripheral
triggers one after the software clears the APLIC IRQ but before it
clears the peripheral's IRQ.

Thus, we also clear the pending bit via the rectified input value in the
level-trigger mode.

This change doesn't affect MSI delivery mode. Calling
riscv_aplic_msi_irq_update() when IRQ pending is low will do nothing.

Signed-off-by: Jim Shu <jim.shu@sifive.com>
---
 hw/intc/riscv_aplic.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/intc/riscv_aplic.c b/hw/intc/riscv_aplic.c
index 8f700431114..791e0b01b96 100644
--- a/hw/intc/riscv_aplic.c
+++ b/hw/intc/riscv_aplic.c
@@ -591,14 +591,14 @@ static void riscv_aplic_request(void *opaque, int irq, int level)
         }
         break;
     case APLIC_SOURCECFG_SM_LEVEL_HIGH:
-        if ((level > 0) && !(state & APLIC_ISTATE_PENDING)) {
-            riscv_aplic_set_pending_raw(aplic, irq, true);
+        if ((level > 0) != !!(state & APLIC_ISTATE_PENDING)) {
+            riscv_aplic_set_pending_raw(aplic, irq, level > 0);
             update = true;
         }
         break;
     case APLIC_SOURCECFG_SM_LEVEL_LOW:
-        if ((level <= 0) && !(state & APLIC_ISTATE_PENDING)) {
-            riscv_aplic_set_pending_raw(aplic, irq, true);
+        if ((level <= 0) != !!(state & APLIC_ISTATE_PENDING)) {
+            riscv_aplic_set_pending_raw(aplic, irq, level <= 0);
             update = true;
         }
         break;
-- 
2.43.0


