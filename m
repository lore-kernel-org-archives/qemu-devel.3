Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15247F531DE
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 00:54:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCS2t-0000aA-Nl; Mon, 13 Apr 2026 20:54:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wCS2r-0000Tr-Op
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 20:54:25 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wCS2q-0000LC-4X
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 20:54:25 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-488c2690057so48374645e9.0
 for <qemu-devel@nongnu.org>; Mon, 13 Apr 2026 17:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776128062; x=1776732862; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ONR1+56gVpg1r3bZ3HhUvk4b2Pj6ORP2nsgYQ1YlG/g=;
 b=Lxmb+MyeW7HzOpVKOxbntf4UmDSR8yO+kW69sK4rGSA26QSfyAjbWg5PdNnM5o1zbY
 tMQbBpGAHNCloIERqaJoqwkaLCskSFonqP9xaXfy58SoNqNaY0gFmrH5B8Kph9CM9+mn
 oCvzKJF94hT1khLzNLf0exOxXEwVRZl00A2ixKO0Kry0rDu4XCe+kzlgkUq+tGWKUA3/
 tWr+H0v4QrYEcpufn4KHsweZnT0FWn2tZr4nepmzb54tWKQRw59az6AjeIfhR1o7U4qC
 CuvbFHYbxgPA8AKFwmj9dzUhhHhH4enpn5MIZ3qGWqmnyoZTpDqWUxnyqBBEOo7Q4jru
 NtDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776128062; x=1776732862;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ONR1+56gVpg1r3bZ3HhUvk4b2Pj6ORP2nsgYQ1YlG/g=;
 b=WEOLYMI4sCBa60jaPuUgIjOFHD3s90jhj79D/Og+toOX6PsGmozeTlLqrNZYW7TgeQ
 uBOBKYkMGNj9aqxDtdC/0ViOhr1a5T7QjSo+3LWh8ibjkAmF4dkyoo3e78L/UwVe+DPD
 meX5/fbAC6vRwQdwTRGYxEYP18IZLOENj7R8yrxW+y80nPmIo2Pra+GzPun6Oi9qilKa
 Qxc+3mdb9EwZYuT4X/pq6Z6nDZnuflTHdI3ovRChjws1tsqzz9Fva1LVWOTAlicSGCnZ
 YYK0KyhlsLnw2Yhg72RfZh+wMjzzqJft9ifPxft/weADnVL+Ensqx/jH6gT2bCroZICx
 bmQQ==
X-Gm-Message-State: AOJu0YwVSgbuqY7+Zw1tLWDxMQvRGtd5bVMYZau3J6XSZGGgdTZMTctX
 2Kpv9N/ISVTNQoRD5WkArybSfx4xgAVBH4egkoV4ecia6zI/I6Un+2bj63ncuCe+cdXsLGRFjHo
 g558EgR0=
X-Gm-Gg: AeBDieuU92A73AgMkurRTu4rHvAdt3MDeqFiveHCDtdNDFvhy/iG1JpEClt98NHVkTV
 nU9y79BC37IWwshN2QY2zfRS1Am/PSqSxQ0Q6rxZq0xzFpmx3cJkE3c1YXKXY9p1q+50yG/YBzu
 3C97ZDkgrb9EQXhL9hmMyDWhe4KUhVtuT63rVeJf13mJphVAmYuEB81QmWuNfRPN3uWwa70/lyU
 UdUb6MMWeu0f6lVVJGJ0u77LGVZ2iR+x9oj5ew500Hligg6Qvzf/K9yLF2OFA3A8DB3vviE5RJ9
 WHSZSlF0Q/TrSJ8geWJChAEE36ztJaQ62KXMBUHnDOAanphETpUix6LAGBY4Lfj9tTol0TCCTuw
 iTjJW3PSOnicsdPlfHlT/WhxNtOC9rNXAkvgVefKvECYO6pl45zJ8fpjdRhnVPronDAptES/aVM
 7TlMBI6Ar1Qsvh5j2bnNZxaM5smdSB9TCrkN7PbL8jaDcUdkW1vfMKNGGLw0smEHOUoV5cI6Vx
X-Received: by 2002:a05:600c:4ecf:b0:486:fd5c:2b35 with SMTP id
 5b1f17b1804b1-488d68685aemr219801815e9.13.1776128062444; 
 Mon, 13 Apr 2026 17:54:22 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488ede1513csm7711025e9.2.2026.04.13.17.54.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 13 Apr 2026 17:54:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 4/9] target/arm: Hoist MO_TE into MVE DO_VSTR() macro
Date: Tue, 14 Apr 2026 02:53:43 +0200
Message-ID: <20260414005348.4767-5-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260414005348.4767-1-philmd@linaro.org>
References: <20260414005348.4767-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/mve_helper.c | 43 +++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 23 deletions(-)

diff --git a/target/arm/tcg/mve_helper.c b/target/arm/tcg/mve_helper.c
index fbb64889bf7..4bea0991de9 100644
--- a/target/arm/tcg/mve_helper.c
+++ b/target/arm/tcg/mve_helper.c
@@ -235,7 +235,8 @@ DO_VSTR(vstrh_w, MO_UW, 2, stw, 4, int32_t)
         unsigned e;                                                     \
         uint32_t addr;                                                  \
         int mmu_idx = arm_to_core_mmu_idx(arm_mmu_idx(env));            \
-        MemOpIdx oi = make_memop_idx(MFLAG | MO_ALIGN, mmu_idx);        \
+        MemOpIdx oi = make_memop_idx(MO_TE | MFLAG | MO_ALIGN,          \
+                                     mmu_idx);                          \
         for (e = 0; e < 16 / ESIZE; e++, mask >>= ESIZE, eci_mask >>= ESIZE) { \
             if (!(eci_mask & 1)) {                                      \
                 continue;                                               \
@@ -262,7 +263,8 @@ DO_VSTR(vstrh_w, MO_UW, 2, stw, 4, int32_t)
         unsigned e;                                                     \
         uint32_t addr;                                                  \
         int mmu_idx = arm_to_core_mmu_idx(arm_mmu_idx(env));            \
-        MemOpIdx oi = make_memop_idx(MFLAG | MO_ALIGN, mmu_idx);        \
+        MemOpIdx oi = make_memop_idx(MO_TE | MFLAG | MO_ALIGN,          \
+                                     mmu_idx);                          \
         for (e = 0; e < 16 / ESIZE; e++, mask >>= ESIZE, eci_mask >>= ESIZE) { \
             if (!(eci_mask & 1)) {                                      \
                 continue;                                               \
@@ -347,47 +349,42 @@ DO_VSTR(vstrh_w, MO_UW, 2, stw, 4, int32_t)
 
 DO_VLDR_SG(vldrb_sg_sh, MO_SB, int8_t, ldb, 2, int16_t, uint16_t, ADDR_ADD, false)
 DO_VLDR_SG(vldrb_sg_sw, MO_SB, int8_t, ldb, 4, int32_t, uint32_t, ADDR_ADD, false)
-DO_VLDR_SG(vldrh_sg_sw, MO_TE | MO_SW, int16_t, ldw, 4,
-           int32_t, uint32_t, ADDR_ADD, false)
+DO_VLDR_SG(vldrh_sg_sw, MO_SW, int16_t, ldw, 4, int32_t, uint32_t, ADDR_ADD, false)
 
 DO_VLDR_SG(vldrb_sg_ub, MO_UB, uint8_t, ldb, 1, uint8_t, uint8_t, ADDR_ADD, false)
 DO_VLDR_SG(vldrb_sg_uh, MO_UB, uint8_t, ldb, 2, uint16_t, uint16_t, ADDR_ADD, false)
 DO_VLDR_SG(vldrb_sg_uw, MO_UB, uint8_t, ldb, 4, uint32_t, uint32_t, ADDR_ADD, false)
-DO_VLDR_SG(vldrh_sg_uh, MO_TE | MO_UW, uint16_t, ldw, 2,
-           uint16_t, uint16_t, ADDR_ADD, false)
-DO_VLDR_SG(vldrh_sg_uw, MO_TE | MO_UW, uint16_t, ldw, 4,
-           uint32_t, uint32_t, ADDR_ADD, false)
-DO_VLDR_SG(vldrw_sg_uw, MO_TE | MO_UL, uint32_t, ldl, 4,
-           uint32_t, uint32_t, ADDR_ADD, false)
+DO_VLDR_SG(vldrh_sg_uh, MO_UW, uint16_t, ldw, 2, uint16_t, uint16_t, ADDR_ADD, false)
+DO_VLDR_SG(vldrh_sg_uw, MO_UW, uint16_t, ldw, 4, uint32_t, uint32_t, ADDR_ADD, false)
+DO_VLDR_SG(vldrw_sg_uw, MO_UL, uint32_t, ldl, 4, uint32_t, uint32_t, ADDR_ADD, false)
 DO_VLDR64_SG(vldrd_sg_ud, ADDR_ADD, false)
 
-DO_VLDR_SG(vldrh_sg_os_sw, MO_TE | MO_SW, int16_t, ldw, 4,
+DO_VLDR_SG(vldrh_sg_os_sw, MO_SW, int16_t, ldw, 4,
            int32_t, uint32_t, ADDR_ADD_OSH, false)
-DO_VLDR_SG(vldrh_sg_os_uh, MO_TE | MO_UW, uint16_t, ldw, 2,
+DO_VLDR_SG(vldrh_sg_os_uh, MO_UW, uint16_t, ldw, 2,
            uint16_t, uint16_t, ADDR_ADD_OSH, false)
-DO_VLDR_SG(vldrh_sg_os_uw, MO_TE | MO_UW, uint16_t, ldw, 4,
+DO_VLDR_SG(vldrh_sg_os_uw, MO_UW, uint16_t, ldw, 4,
            uint32_t, uint32_t, ADDR_ADD_OSH, false)
-DO_VLDR_SG(vldrw_sg_os_uw, MO_TE | MO_UL, uint32_t, ldl, 4,
+DO_VLDR_SG(vldrw_sg_os_uw, MO_UL, uint32_t, ldl, 4,
            uint32_t, uint32_t, ADDR_ADD_OSW, false)
 DO_VLDR64_SG(vldrd_sg_os_ud, ADDR_ADD_OSD, false)
 
 DO_VSTR_SG(vstrb_sg_ub, MO_UB, stb, 1, uint8_t, ADDR_ADD, false)
 DO_VSTR_SG(vstrb_sg_uh, MO_UB, stb, 2, uint16_t, ADDR_ADD, false)
 DO_VSTR_SG(vstrb_sg_uw, MO_UB, stb, 4, uint32_t, ADDR_ADD, false)
-DO_VSTR_SG(vstrh_sg_uh, MO_TE | MO_UW, stw, 2, uint16_t, ADDR_ADD, false)
-DO_VSTR_SG(vstrh_sg_uw, MO_TE | MO_UW, stw, 4, uint32_t, ADDR_ADD, false)
-DO_VSTR_SG(vstrw_sg_uw, MO_TE | MO_UL, stl, 4, uint32_t, ADDR_ADD, false)
+DO_VSTR_SG(vstrh_sg_uh, MO_UW, stw, 2, uint16_t, ADDR_ADD, false)
+DO_VSTR_SG(vstrh_sg_uw, MO_UW, stw, 4, uint32_t, ADDR_ADD, false)
+DO_VSTR_SG(vstrw_sg_uw, MO_UL, stl, 4, uint32_t, ADDR_ADD, false)
 DO_VSTR64_SG(vstrd_sg_ud, ADDR_ADD, false)
 
-DO_VSTR_SG(vstrh_sg_os_uh, MO_TE | MO_UW, stw, 2, uint16_t, ADDR_ADD_OSH, false)
-DO_VSTR_SG(vstrh_sg_os_uw, MO_TE | MO_UW, stw, 4, uint32_t, ADDR_ADD_OSH, false)
-DO_VSTR_SG(vstrw_sg_os_uw, MO_TE | MO_UL, stl, 4, uint32_t, ADDR_ADD_OSW, false)
+DO_VSTR_SG(vstrh_sg_os_uh, MO_UW, stw, 2, uint16_t, ADDR_ADD_OSH, false)
+DO_VSTR_SG(vstrh_sg_os_uw, MO_UW, stw, 4, uint32_t, ADDR_ADD_OSH, false)
+DO_VSTR_SG(vstrw_sg_os_uw, MO_UL, stl, 4, uint32_t, ADDR_ADD_OSW, false)
 DO_VSTR64_SG(vstrd_sg_os_ud, ADDR_ADD_OSD, false)
 
-DO_VLDR_SG(vldrw_sg_wb_uw, MO_TE | MO_UL, uint32_t, ldl, 4,
-           uint32_t, uint32_t, ADDR_ADD, true)
+DO_VLDR_SG(vldrw_sg_wb_uw, MO_UL, uint32_t, ldl, 4, uint32_t, uint32_t, ADDR_ADD, true)
 DO_VLDR64_SG(vldrd_sg_wb_ud, ADDR_ADD, true)
-DO_VSTR_SG(vstrw_sg_wb_uw, MO_TE | MO_UL, stl, 4, uint32_t, ADDR_ADD, true)
+DO_VSTR_SG(vstrw_sg_wb_uw, MO_UL, stl, 4, uint32_t, ADDR_ADD, true)
 DO_VSTR64_SG(vstrd_sg_wb_ud, ADDR_ADD, true)
 
 /*
-- 
2.53.0


