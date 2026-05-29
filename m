Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12B27CD6E4A
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 11:49:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSvge-0001Uw-1O; Fri, 29 May 2026 07:47:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wSvgb-0001SE-Jp
 for qemu-devel@nongnu.org; Fri, 29 May 2026 07:47:33 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wSvgZ-0008BJ-VZ
 for qemu-devel@nongnu.org; Fri, 29 May 2026 07:47:33 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-45ef189aa1cso506545f8f.0
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 04:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780055250; x=1780660050; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=sOULCKuZ0Ankmv2c1oUma3WTrs+lcFUEcIGWJpCYKiM=;
 b=b7ywUWxVZBwmtNiz2cM9dtzKGV2e9D+uCMk0VuFeK+QE53TzUmYLKXjXdYRQ2c4UVh
 x1rJAKxmJU2xAtZtleZA+cpe87/5U2b3QuCIOtXrQU2C6lHxrs0k6Pc0UJJc/aewC4jD
 eaYXLJ1A3vzsoRiJL9zK3lOcmfo5fQOlW9TYpvxgka/UDOx4FU+UzA6chrfJJ9FvrR6K
 rjM/bXQ32uotax7qnMqXob4nYmWwldmMXShr4METp504ixJLycVGV0PwUcfFQ44BpmZD
 aSUL/agIY8ECqzXkqSzaLbO2GL36qmkYstgkMKheCv/XXBak9IixStKAlK4Fp70JUxsI
 CC9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780055250; x=1780660050;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=sOULCKuZ0Ankmv2c1oUma3WTrs+lcFUEcIGWJpCYKiM=;
 b=IvagReb/NCbznRR3mOUaYK+1H/6A/o3215I8iUuW3c7UPfw4H64EiuMExesKqarqEl
 dBD0BSCxvUCAoho22+Y8r62umKKbavIfg/tiLPYLMpiQDekZkY5s37vwjobyAaf07wlF
 YGqxa94b+vReppP1h+QfCN6TQlPVClqmOPG9RKVyI+4wAErYSra/Qp6OXZ0JrVxqBlAz
 37KRZoGIGk+EGXBqe9wF7MoRK/r2oY2e0+KJlAPUT/VY/r9uTAAF9l0rTH5iGCsqqQlm
 od5E6id+/8Z5imRL6E0gVp67BAHN2ALchmfIgrYkgVB7dFkuelCdYOp/pWEkuNM4w8GM
 SEdw==
X-Gm-Message-State: AOJu0Yx3asAm2ehIxxIriR0BBvQNzoTpQECVCW0pHs0GHIk9WRgTmMOa
 J3ZPu4lRs/VT6KjRRCl+18bZwgvvunohM8IWUnduqbhL6J5oPu1UhdybEHsX/zfGhoFS3s0pC0p
 arnXo
X-Gm-Gg: Acq92OHU2wzCxzOngJPXcSD1rGKGcY+7qX/x/TrGjsTjzu5jVWNGHqy/CxFhtO0jv2B
 YlwjoA/4pixg8Zvq369kFUisqsXANTwy3+jZpJumEO3aM2JekBmounHULyfmGFXUZN66godsbFw
 38m73PZd7uG6hA0bgwkJu7grSzKHTe93wD0BDciOiMzGPNjpLyDYs9u29+P8GBiyfvgRadHo2bD
 5uHf7fH6nteO93CDFXKXiVNA1Ev2MfV6uC3JcsdeoV7ajOEtmBZurx2VySHKj4NEfznvG+7uneW
 c7GZtOT+KtOmjNFDN/95TK0yLG50/2uCTsYFRt1dQ8145y31h568ZKRNeKYGgic/XD11cD5rtjI
 XH9uc13HqhpW3vhRbQ2lTx9TY4HuIJcZCmXk+no5LSF5NwHIMoZF3WopU6oCxkCfn7REzIzVNJq
 tZyia0TMn9g2ZZbdmrvgzkPLrNAdnseaExpebzllt6K0mWNAbcRnJlYxdZvKk/hxsLiIVn9dIrP
 +SEZQY5aWgQegMVLK4NiBrwq33WS+rdt+erX7I1VQ==
X-Received: by 2002:a05:6000:250f:b0:45d:77f4:1ac2 with SMTP id
 ffacd0b85a97d-45ef138e388mr5316789f8f.0.1780055250443; 
 Fri, 29 May 2026 04:47:30 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45ef3563cb9sm3007358f8f.29.2026.05.29.04.47.29
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 04:47:29 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 05/21] hw/dma/zynq-devcfg: Simulate dummy PL reset
Date: Fri, 29 May 2026 12:47:06 +0100
Message-ID: <20260529114723.42040-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260529114723.42040-1-peter.maydell@linaro.org>
References: <20260529114723.42040-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42c.google.com
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

From: YannickV <Y.Vossen@beckhoff.com>

Setting PCFG_PROG_B should reset the PL. After a reset PCFG_INIT
should indicate that the reset is finished successfully.

In order to add a MMIO-Device as part of the PL in the Zynq, the
reset logic must succeed. The PCFG_INIT flag is now set when the
PL reset is triggered by PCFG_PROG_B. Indicating the reset was
successful.

Signed-off-by: YannickV <Y.Vossen@beckhoff.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Message-id: 20260518073401.11279-5-corvin.koehne@gmail.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/dma/xlnx-zynq-devcfg.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/hw/dma/xlnx-zynq-devcfg.c b/hw/dma/xlnx-zynq-devcfg.c
index 7370ab941f..6b1d96ff80 100644
--- a/hw/dma/xlnx-zynq-devcfg.c
+++ b/hw/dma/xlnx-zynq-devcfg.c
@@ -49,6 +49,7 @@
 
 REG32(CTRL, 0x00)
     FIELD(CTRL,     FORCE_RST,          31,  1) /* Not supported, wr ignored */
+    FIELD(CTRL,     PCFG_PROG_B,        30,  1)
     FIELD(CTRL,     PCAP_PR,            27,  1) /* Forced to 0 on bad unlock */
     FIELD(CTRL,     PCAP_MODE,          26,  1)
     FIELD(CTRL,     MULTIBOOT_EN,       24,  1)
@@ -116,6 +117,7 @@ REG32(STATUS, 0x14)
     FIELD(STATUS,   PSS_GTS_USR_B,      11,  1)
     FIELD(STATUS,   PSS_FST_CFG_B,      10,  1)
     FIELD(STATUS,   PSS_CFG_RESET_B,     5,  1)
+    FIELD(STATUS,   PCFG_INIT,           4,  1)
 
 REG32(DMA_SRC_ADDR, 0x18)
 REG32(DMA_DST_ADDR, 0x1C)
@@ -204,6 +206,13 @@ static uint64_t r_ctrl_pre_write(RegisterInfo *reg, uint64_t val)
             val |= lock_ctrl_map[i] & s->regs[R_CTRL];
         }
     }
+
+    if (FIELD_EX32(val, CTRL, PCFG_PROG_B)) {
+        s->regs[R_STATUS] |= R_STATUS_PCFG_INIT_MASK;
+    } else {
+        s->regs[R_STATUS] &= ~R_STATUS_PCFG_INIT_MASK;
+    }
+
     return val;
 }
 
-- 
2.43.0


