Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A80D1F31E27
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2026 14:22:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAqGT-0002rs-M1; Thu, 09 Apr 2026 10:21:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wAqGT-0002rk-3V
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 10:21:49 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wAqGR-00035u-He
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 10:21:48 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4887ca8e529so6522135e9.0
 for <qemu-devel@nongnu.org>; Thu, 09 Apr 2026 07:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775744506; x=1776349306; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OKbtz4f+5v/65iIJiJd5lWSZcH3qpMnB3cJS1OM7LJg=;
 b=Vi26j2sgfUWqoXj6OkB+J7brChSTjPckNTcogdgnxlV2jrKqL/Dt84IgsU/ZCr6mqe
 d4Rbm5iPd/XHc9SqrCpSDaXxzaCKyspB6H5ijQhfu0B1+eyy99V3E1pfXevYqwfZyklk
 mCwQlCwNBE+Ty0MBS/020syiDIMcXwd9kGliS3C01eKZ4nvKNObKinLGbNxaAYuDatrS
 zPn6pI/DyVlThrlDtxrux+AANsPCXXqrLWRct5DehLkAJmk37WkxC9XP9qUqsUqKsuVs
 gXSS8Zf6GkKrPq6j49b+7ZP5t64Py3XkOS2P39F6XNuQZe8JSXsU3sEhEpYBKh85NYFI
 D1PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775744506; x=1776349306;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OKbtz4f+5v/65iIJiJd5lWSZcH3qpMnB3cJS1OM7LJg=;
 b=ah7Bpa4QZSaAj/0+BMvfmLTtTZOkXuVjeHSEu8WtVLufsrK8/Lr5n/YGLYQrGkLuZv
 p8040fl55kd8L0/zOsgNPGwCL9rwisCamxbdlIFLcrxEsGFuSMVRv1scuGSV3z11UcGn
 wQxFG6BGRuWkjX7qCFJ334l7QidFch31l+aVaO+7wBa0hpu869qlZV/We7dUa+/KCSsC
 cLrX35u4WYSh+4DQTfP+nNBr/1i+rVy/TCb9kG6/lLbWME7pci22VAVSqmlCiVBCRazv
 d+yP3VwsBmloHyrz0XBSbVfCrqNxgV0tbY1NZ73JFqECAqKrZ2JLtTb4+WrwLthKujwA
 dgOA==
X-Gm-Message-State: AOJu0YxGFZke4E5gcauOUPfzonRzgN85ygzTeY2jBsU9j9dfi/5LGMqL
 khduEKiZ112MI5DCRwf9F/C1oybuwCtCzTd+M+42ZgBqsMoOxdp2l4c+ezKq060sCqcCbthhrGv
 Rs8RQd58=
X-Gm-Gg: AeBDietTCv6Vw+a6hJBu3+KSqRtmZEiQVqFzJZG7gnwE9pesw/Q/RsOsLFBLhgmp4Yd
 on/zRGoAXB+ZEUshxsGzvfYcNgF7K2rFcjVlm8TPJ1HxoTDvu39GYRe34Gf68AMP0NFbOv5dVJt
 OtEtbJDIZRKK4KkMFEbGwxnwqZS/hxQY/Pfxlwo2dmJxHu430OaAxzeMDcmDucTZ3lrG99AHCz4
 DTn+al2MbUAju4taH3ocf9Z25OOZ2Hj1MsgYy1SnZUjAsJ1QdiEVD0WwGSBqYiCmxw1zgLLHZY9
 yKcPqGLRNLnxep7hB0Zn9vF+inA4CirATI28cTonNbprBhwna4rpGPDq0DKWbpzi9QOp1jmsRPP
 atGHq/p4lnhmKaxi4uo7D14P5uPBW3FGgvDxgTgY4DZUw58y01xsc+rOVHkoZfIW12A9iOccqgH
 GqgGzvuUuHyaull7o/dX1A3AW9ahww5INzMw7eCIUTE0eaLWW/afBeXFBQvgRRQjsna6SF4JOi
X-Received: by 2002:a05:600c:c087:b0:485:3c2e:60d5 with SMTP id
 5b1f17b1804b1-488cd50f45dmr35471385e9.2.1775744505650; 
 Thu, 09 Apr 2026 07:21:45 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488cd1999c6sm41405165e9.4.2026.04.09.07.21.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 09 Apr 2026 07:21:44 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 1/4] ati-vga: Fix pitch and offset registers mask
Date: Thu,  9 Apr 2026 16:21:33 +0200
Message-ID: <20260409142137.58349-2-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260409142137.58349-1-philmd@linaro.org>
References: <20260409142137.58349-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

From: BALATON Zoltan <balaton@eik.bme.hu>

Remove the Radeon specific masks for offset and pitch registers. While
the documentation is not clear about it I believe it is a copy&paste
error from the combined DST_PITCH_OFFSET register that has less bits
so more constrained than the individual registers which should not
have this mask.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Message-ID: <20260404111318.8334E596A22@zero.eik.bme.hu>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/display/ati.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/hw/display/ati.c b/hw/display/ati.c
index 7bb57c44d95..88a5bbbf07a 100644
--- a/hw/display/ati.c
+++ b/hw/display/ati.c
@@ -820,18 +820,12 @@ static void ati_mm_write(void *opaque, hwaddr addr,
         ati_cursor_define(s);
         break;
     case DST_OFFSET:
-        if (s->dev_id == PCI_DEVICE_ID_ATI_RAGE128_PF) {
             s->regs.dst_offset = data & 0xfffffff0;
-        } else {
-            s->regs.dst_offset = data & 0xfffffc00;
-        }
         break;
     case DST_PITCH:
-        if (s->dev_id == PCI_DEVICE_ID_ATI_RAGE128_PF) {
             s->regs.dst_pitch = data & 0x3fff;
+        if (s->dev_id == PCI_DEVICE_ID_ATI_RAGE128_PF) {
             s->regs.dst_tile = (data >> 16) & 1;
-        } else {
-            s->regs.dst_pitch = data & 0x3ff0;
         }
         break;
     case DST_TILE:
@@ -941,18 +935,12 @@ static void ati_mm_write(void *opaque, hwaddr addr,
         s->regs.dst_height = (data >> 16) & 0x3fff;
         break;
     case SRC_OFFSET:
-        if (s->dev_id == PCI_DEVICE_ID_ATI_RAGE128_PF) {
             s->regs.src_offset = data & 0xfffffff0;
-        } else {
-            s->regs.src_offset = data & 0xfffffc00;
-        }
         break;
     case SRC_PITCH:
-        if (s->dev_id == PCI_DEVICE_ID_ATI_RAGE128_PF) {
             s->regs.src_pitch = data & 0x3fff;
+        if (s->dev_id == PCI_DEVICE_ID_ATI_RAGE128_PF) {
             s->regs.src_tile = (data >> 16) & 1;
-        } else {
-            s->regs.src_pitch = data & 0x3ff0;
         }
         break;
     case DP_BRUSH_BKGD_CLR:
-- 
2.53.0


