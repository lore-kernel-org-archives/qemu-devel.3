Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73BEEC43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 10:48:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whmId-0007cg-33; Thu, 09 Jul 2026 06:48:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1whmIb-0007bR-73
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 06:48:09 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1whmIZ-0002kN-Ig
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 06:48:08 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-47362928f65so655398f8f.2
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 03:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783594084; x=1784198884; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=opvFLLf6H/WX2lBzUeG9w4tupmTnctUuF+VIkiQ5Kz8=;
 b=hvHZDGp1lrB3/5eLeoAqlSwkBBMPQbp9/ZMgkXUFbTSncrRJpDEb2GHoez636/d967
 oibIC1hdd9iTYhaVfal1kSpFtoqMOHrBHZWJGGEoFu9gRiTKkndauTob9Sm4Z3rj8hIj
 8yeT66PXoHzyGOoxAyRgvBxzStDdjYOysLws7Qv7vaf+8pdMedWM1xQ2d+zBOKmdl8AY
 8P0H9R8C3vvxmWxInA4SClFPhJ5teWMsnaIxIOs7HS8qCFJCZXbbf7Xq9hlRnhb38deV
 c3nXoysXKG6bDMyFK1i0O6jvge+j/r9ewR3D9S/e/qg4BYu/SXqYCFGrs3JzbIPaHbFW
 2Dtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783594084; x=1784198884;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=opvFLLf6H/WX2lBzUeG9w4tupmTnctUuF+VIkiQ5Kz8=;
 b=LX35JZGC/X2zI8mbkc2Gu/Qvhi+MpV/2T2UuihQ/SxKHFyo+waNGZdAfhzB99pgO8y
 oQwkeTSdLVMK5SDosenIflDRwEEGJHsJLVEBtOAozhvxzEMmwxSct+Sc1knJUOTMJyQq
 tzrTi6qzEoo/aY+SlvKscW1mLZPCe+/DPy2xhkaoYsMd5KJhrck5/xyW3JSNw+zebZXJ
 zO7p5J+fiLTz9lpoSf5qMntuLzBLwseXfQCbaPlDX4BlAFPsOJzoGRzXZpqnn5RaxPhX
 8+td0VCtLw5XPNVrHtI2TbsFFOpykneWBFTxYL+9Dvk2x5XmiYjIGBFid6TbdWm2/UhR
 1JsA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoJIbJY9nR0jWZidU5JRJWnsOXPUPtnL4mwp61PByHCw8nga9cz3IJ0KukGSphNm7pMXiUs+hBINMrB@nongnu.org
X-Gm-Message-State: AOJu0YxOzBab11219CinrCVa0Q5fiTePbmE8NObO76tb4FB5b+hfU2V+
 7QTPc5v8J1IUJroSfX7W5t8n93xdw7MdyeP+NSXHQZE9y8qj5jXEk7rgfhaiy1WAFGc=
X-Gm-Gg: AfdE7cmwg4uQVfxvor3671HxQpgk9s2Do5cqc5I+7No3azEp55zzt5rkWvC/Cz+ospp
 yjNXOzkcZu8T34DJH4d1eOaOw8OQmnp1l5gFsg1BoeVuulNP/HVEj+/ar1fDSe+DAa/eak7625K
 QlLxDW2gNOs183BCiEoaK25wom/tYn4BJL+g4GzciOXI8Z+2hrefDoDivBg56WQ9XuffZ88E+5H
 T54xxFNwNmrQvE4C9YB3pffvApTjRvBTF/Ex2OqKy77vejHmi/GEuf/njNop0glZ3xr450GJ5v1
 LrwEh9gzML7L2hZbZdPZJyVg1XfSiP3/FquqeEQLmuqoYdXE4HcJ7OWloObBf6C92LGmtJeOPJS
 0ujWsxg6sTDO+3HgTvv8WP2cGf4HG3OmaNAH68tupJmHwI7nY3plTW05wKhR3ocFrnqvMwDeGe9
 eyolOfnp+S4i4xgmHltfYKxO0XSBjXlYOdbSvKMMPyj4g5TmOWxj3EIWTAe3n5JqTRB8R/7FNIw
 PDdhBS8JCE1N5pVxjnHPg==
X-Received: by 2002:a05:6000:2209:b0:45e:f8d0:d22c with SMTP id
 ffacd0b85a97d-47df076518emr7106340f8f.25.1783594084238; 
 Thu, 09 Jul 2026 03:48:04 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47a9de1e736sm54110243f8f.7.2026.07.09.03.48.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 03:48:03 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Strahinja Jankovic <strahinja.p.jankovic@gmail.com>
Subject: [PATCH] hw/misc/allwinner-r40-ccu.c: Correct handling of out of range
 accesses
Date: Thu,  9 Jul 2026 11:48:02 +0100
Message-ID: <20260709104802.1989086-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42a.google.com
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

In allwinner_r40_ccu_write() we handle writes to a MemoryRegion of
size AW_R40_CCU_IOSIZE, and the register array is sized accordingly
at (AW_R40_CCU_IOSIZE / sizeof(uint32_t)).  However, one of the cases
in the switch is a range up to AW_R40_CCU_IOSIZE, which makes
Coverity think we might index off the end of the array. We also
have a similar case in the read function, but since that returns
early it doesn't have the same issue.

Adjust the handling of out of range accesses:
 - use AW_R40_CCU_IOSIZE - 4 as the upper bound, as this is the
   largest value we will actually see
 - return early in the write case, as we do in the read case

Coverity CID: 1663687
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/misc/allwinner-r40-ccu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/misc/allwinner-r40-ccu.c b/hw/misc/allwinner-r40-ccu.c
index 8ba4e7aa42..00840e9850 100644
--- a/hw/misc/allwinner-r40-ccu.c
+++ b/hw/misc/allwinner-r40-ccu.c
@@ -71,7 +71,7 @@ static uint64_t allwinner_r40_ccu_read(void *opaque, hwaddr offset,
     const uint32_t idx = REG_INDEX(offset);
 
     switch (offset) {
-    case 0x324 ... AW_R40_CCU_IOSIZE:
+    case 0x324 ... AW_R40_CCU_IOSIZE - 4:
         qemu_log_mask(LOG_GUEST_ERROR, "%s: out-of-bounds offset 0x%04x\n",
                       __func__, (uint32_t)offset);
         return 0;
@@ -113,10 +113,10 @@ static void allwinner_r40_ccu_write(void *opaque, hwaddr offset,
             val |= REG_PLL_LOCK;
         }
         break;
-    case 0x324 ... AW_R40_CCU_IOSIZE:
+    case 0x324 ... AW_R40_CCU_IOSIZE - 4:
         qemu_log_mask(LOG_GUEST_ERROR, "%s: out-of-bounds offset 0x%04x\n",
                       __func__, (uint32_t)offset);
-        break;
+        return;
     default:
         qemu_log_mask(LOG_UNIMP, "%s: unimplemented write offset 0x%04x\n",
                       __func__, (uint32_t)offset);
-- 
2.43.0


