Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC498F30946
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 12:13:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vy7aR-0000gV-6m; Thu, 05 Mar 2026 07:13:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1vy7aP-0000gC-3i
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 07:13:49 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1vy7aN-00080u-Ba
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 07:13:48 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-439b8a3f2bcso3495358f8f.3
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2026 04:13:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772712821; x=1773317621; darn=nongnu.org;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=o9ySsJCPRrRpMMsEvO5GNe2voaD7Aa2RjkICMkm45GA=;
 b=Usa2+eSqRF7NZkQzoX3tTsQBIz9ILFkyUpJ5CEHKe76v03rseP0xXuXrrtnSrzYMXi
 XzUp9gKDHggthSBOVBhg02Dm12RAQ37RZO528tQoARjNg3oRVk4toUaNCbKn+p5J/91g
 gKIxmgN0HavK3qpo9CqVX7boprd76GGF15JEYANc5EaInMx11y2/Z9eDhokWEnMk4ERT
 YkrXFxAGfIQ/yQO3/eFtvCZRVqRQXUzzYSx33/UOS70NZ3+XDG+h4Xy+/vzomIppoYNC
 ZQvHXm+xu0IOa8ukv1/+EznXBjgMT2Pxz0UrqvCxc47M36XBrji8Ql6JLJ5nZdoLvXXN
 6LMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772712821; x=1773317621;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o9ySsJCPRrRpMMsEvO5GNe2voaD7Aa2RjkICMkm45GA=;
 b=i6kaUrFOCL6GG8AOaz0/R+Vt8gJghanVvaTZQ4rLzZyI8u22yprOPk2YN7Z1OZ/lv+
 93Zp+YCbmbC5C0CgjE2LO9kCdqho2nkYITzZzcPawV76BX3OyEm298SsrB7bFYQtsTqu
 s/y4IGBdXjyHT6aH6s2JW5Q4etyCgpU6vYhkXqY/ld3VTgfh/rK0zxujXBjhhQLRMRV2
 rHqr53kG9EsMBVPZkrkJ8Bz5egXxZq/GILzOQCikdj07K1QnIArX/a5vhvyx5cQgG3mz
 kbBK9CM4dJqsMP4GkcjhWTPzQGfkt/EOjCm/CvblfBO4s8ZGtW3t0+6UMojLoFr11X/P
 GnhQ==
X-Gm-Message-State: AOJu0YybrqpPGUUlDHwHe4JlXgm6VgRa2jPovqOhAWDPP8/KmkWtL2Pi
 oq++lS+bo58wXm/chn4a/+1i327IU47YpfEgguZCW7QQk4pvCIN7nulPzPlE41+X130=
X-Gm-Gg: ATEYQzwIvdZ1q69STscFEjYhzMmy353qyh414HJOmaSGsP4/1c8A0+ZOW4HDuTnHOXq
 9n0pa/HdcNyNnL2GNasS8JqPG93eW/HZiA0KoDbRXndmAf5RklZriRt6DGblgb5S+09Ahj8u3RR
 4qZ5lbPlsRkFom9p2jt1OeATe1wgLrsQY1h5ONZwnwViCQPvw7viGdsQl7ujlQ7i9rzei864rwc
 Vv6FLLfuA2SdJ14TLLDeetizsaAJglnyRRrYKNo9aV7wHhkt28jt29NAkXDkKx6UlYDIhr3La1J
 ZumXgGOKEgAt7rOzz9O02iwt7MnB7d2thVMAOTRJlq2dXwh8PZqhrfOrvyo4bhEBe2sdtF0IEaz
 yj27/I7DPXRrOnresPtFRv4i3gV/YFN2n2YklkmWP2WLW8m5qsEAtKsyJWWN89gywn9n7+Jhr4Y
 Ys7ZXUNSqvxhzx
X-Received: by 2002:a05:6000:3113:b0:439:b541:a088 with SMTP id
 ffacd0b85a97d-439c801f74dmr10840149f8f.54.1772712820859; 
 Thu, 05 Mar 2026 04:13:40 -0800 (PST)
Received: from [127.0.1.1] ([2a10:d582:31e:0:e891:67d5:3e8b:cb48])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439ac9f3e5bsm40337904f8f.37.2026.03.05.04.13.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2026 04:13:40 -0800 (PST)
From: Jim MacArthur <jim.macarthur@linaro.org>
Date: Thu, 05 Mar 2026 12:13:03 +0000
Subject: [PATCH] hw/net/xilinx_axienet.c: Prevent writes to PHY
 Identification registers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260305-xilinx-phy-protection-v1-1-ffc9edd84e58@linaro.org>
X-B4-Tracking: v=1; b=H4sIAE5zqWkC/x3MTQqAIBBA4avIrBswI/u5SrQQm2ogTFTCiO6et
 HyL7z0QKTBFGMUDgS6OfLoSdSXA7sZthLyUBiWVlo1sMfPBLqPfb/ThTGRTEWibQRvd9ovsFBT
 rA62c/+80v+8HXwiGYGcAAAA=
To: qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Alistair Francis <alistair@alistair23.me>, 
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>, 
 qemu-arm@nongnu.org, Jim MacArthur <jim.macarthur@linaro.org>
X-Mailer: b4 0.13.0
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=jim.macarthur@linaro.org; helo=mail-wr1-x42e.google.com
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

There are other registers in the PHY model which should be partially or
entirely read-only, but this solves the immediate issue.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3297

Signed-off-by: Jim MacArthur <jim.macarthur@linaro.org>
---
See:

https://gitlab.com/qemu-project/qemu/-/issues/3297

https://lore.kernel.org/qemu-devel/CAJy5ezqTAMr=A3uAfmuWLepK66AdLRu4Q8AmFMh4+4q2HtDrkA@mail.gmail.com/

IEEE 802.3-2022 does not explicitly state that these registers
should be read-only, but suggests it in 22.2.4.3.1 which says this
information should be entirely manufacturer-supplied information.

The standard does mention several other registers in the set which
should be partially or entirely read-only, so further work may be
required.
---
 hw/net/xilinx_axienet.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/net/xilinx_axienet.c b/hw/net/xilinx_axienet.c
index d85f8bb23f..970732b162 100644
--- a/hw/net/xilinx_axienet.c
+++ b/hw/net/xilinx_axienet.c
@@ -141,6 +141,10 @@ tdk_write(struct PHY *phy, unsigned int req, unsigned int data)
     regnum = req & 0x1f;
     DPHY(qemu_log("%s reg[%d] = %x\n", __func__, regnum, data));
     switch (regnum) {
+        case 2:
+        case 3:
+            /* Writes to PHY Identification registers are disallowed */
+            break;
         default:
             phy->regs[regnum] = data;
             break;

---
base-commit: 3fb456e9a0e9eef6a71d9b49bfff596a0f0046e9
change-id: 20260305-xilinx-phy-protection-c396a658d072

Best regards,
-- 
Jim MacArthur <jim.macarthur@linaro.org>


