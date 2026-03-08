Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B7F3EA8543
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2026 22:37:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzMkQ-0005f7-PN; Sun, 08 Mar 2026 18:37:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzMkO-0005Z0-Ow
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 18:37:16 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzMkN-0003VZ-8I
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 18:37:16 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-48539d21b76so4242525e9.1
 for <qemu-devel@nongnu.org>; Sun, 08 Mar 2026 15:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773009433; x=1773614233; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=0NDQ7xzTuFz5bGabMlxPWKXWcVScfmHgx+o3wcMdHeg=;
 b=TxSTPewUnUfEWpCbveedPGMmw/v5oStZa4Iba0YEHV+2V8Lxy16muaCcqlQN27Mj92
 kbqyYRTFIqIfRKnaeU8uvrvD0cJBkqSPrzlJb2EN1k6CwMhgpYKwQaz0UNcwmwqo4TU0
 5B/2owMeh/C4Zy1tjzczR3Rv+yGQLhpPGnfdgeu53Y7zWh3ZCtGdrIys3SXdt/JnZesW
 WaFUVrWZ7v0IYHuqlkdajrtMjdL+PbfvXSyL4MowXK9/l+dtNeyvJ7W9uIVEXMIsHQLe
 05g5he/qJUpP2ZdItXJbyGCUFeJMS0FyUFU2PUbgLwmb4dpj6Kt/Yr2ABjbi+dFg8uT3
 PCEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773009433; x=1773614233;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=0NDQ7xzTuFz5bGabMlxPWKXWcVScfmHgx+o3wcMdHeg=;
 b=XiPDoOKXYKT/B1mwLXDrEsFI24HRDMOdKVqPCGwAJ+RCm3u4g1dc4GMAchKfAe69MM
 9jBid2GXFyPDW7jwnh0dBKnn99sNF2vNi6tqwY4cbSaCK6rV2/UKkgshaY0yNo/9t3YI
 NKKjqrQtxpqxFEY/hRcGiaDEWtS0tC3Eme3Kt5WstqiXnrJ85oXaCsKs0Ifa+QRUzlc4
 8cljNXMw0TagDcnK0dtFMfe/+SR8mQVkgQ9GyT08FE45iMvLGQ1UMXy9B3RvA5aXVADV
 VGz+AvrWWp+ypGP9hKSG0j9MWOoVgdvwnK3JL2L7p0pULF+L49f6Sljxqtsxgtr4+IsZ
 bcZg==
X-Gm-Message-State: AOJu0YzS7HOsELMR1XsuJ1UGVVk4gzgWA/tQFn/3+GFMvIsujmXdr41f
 +YyfczAN5D6sMLy5qIb+y6cKBve6Ngo9U75ztRv2D+rqnN7P5UpQLi9fHflUwgSbjl6F2iCGfhC
 O9/H5E1Y=
X-Gm-Gg: ATEYQzx/H2jpUt/3AVObnisSY9osyKwp2J+z57soX0UdblNLQ5xqOcEbJIOo5xeQfAN
 aG/Mxvrmz+u3t9nrjvrQBGvD7bxXkhvqTzQRv/GOZSfae8hx3QkQcYl5FSX2q5FioReIoGv/rwb
 bqdtcGrEM+WvhBE6/pagCZ4B+wbkyXiwQoVytLpUHyzrk6kKmtOSXNiwyImi+fjux4jUFEejTmj
 0ETB7GGuER/dsFbd+r9NfZzemWaJ3JNzAutaq2QF9fjUEUMK6oePvlRKA2Lui5O/t6UB7YbGoFn
 +LHN2bhjghIKfjrjMlv8xpUPz8kOBpHQODVpG7bgMUrx2vNct4z+4GyVSlXyIWVRnTJ/rreQZ1S
 BqlI3x6BlBAjwtVvoUBOFEhbctRjXi4yw5HlZx5C9PjHtGJPhonJ6OV0ypaOaxwzHWQvxM2RxcE
 we/TDx+hedQGd02POY4aPI130LC+sXv6Cp90yNwYa/P22UjeZUYcFDO25xOE9jq+IJ5YGAlmVLl
 nHEka6/o8YRISJ7
X-Received: by 2002:a05:600c:3b8e:b0:485:3ae8:2231 with SMTP id
 5b1f17b1804b1-4853ae824cemr33606175e9.30.1773009433445; 
 Sun, 08 Mar 2026 15:37:13 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439dae3d98asm23425939f8f.30.2026.03.08.15.37.11
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 08 Mar 2026 15:37:12 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 23/49] ati-vga: Remove dst_x/y updates after blit
Date: Sun,  8 Mar 2026 23:34:07 +0100
Message-ID: <20260308223433.25503-24-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260308223433.25503-1-philmd@linaro.org>
References: <20260308223433.25503-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

From: Chad Jablonski <chad@jablonski.xyz>

The Mobility M6 register reference (DST_HEIGHT_WIDTH) states that dst_y is
updated after a blit but this appears to not be the case.

Hardware testing revealed that both the R128 and R100 do not update
dst_x or dst_y after a blit, regardless of the source. This removes
the update.

Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
Message-ID: <20260303024730.1489136-8-chad@jablonski.xyz>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/display/ati_2d.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
index a8c4c534b94..cfc7bf97899 100644
--- a/hw/display/ati_2d.c
+++ b/hw/display/ati_2d.c
@@ -174,10 +174,6 @@ void ati_2d_blt(ATIVGAState *s)
                                     dst_y * surface_stride(ds),
                                     s->regs.dst_height * surface_stride(ds));
         }
-        s->regs.dst_x = (s->regs.dp_cntl & DST_X_LEFT_TO_RIGHT ?
-                         dst_x + s->regs.dst_width : dst_x);
-        s->regs.dst_y = (s->regs.dp_cntl & DST_Y_TOP_TO_BOTTOM ?
-                         dst_y + s->regs.dst_height : dst_y);
         break;
     }
     case ROP3_PATCOPY:
@@ -228,8 +224,6 @@ void ati_2d_blt(ATIVGAState *s)
                                     dst_y * surface_stride(ds),
                                     s->regs.dst_height * surface_stride(ds));
         }
-        s->regs.dst_y = (s->regs.dp_cntl & DST_Y_TOP_TO_BOTTOM ?
-                         dst_y + s->regs.dst_height : dst_y);
         break;
     }
     default:
-- 
2.53.0


