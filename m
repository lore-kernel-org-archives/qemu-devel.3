Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7927F45A08
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 20:07:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBI8F-0002WL-Qa; Fri, 10 Apr 2026 16:07:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wBI86-0002Rt-Pm
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 16:07:03 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wBI84-0008N4-0u
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 16:07:02 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-43d43e09de5so1351597f8f.1
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2026 13:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775851618; x=1776456418; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sFNUoiA4sxZwl6xj/mdiLyn6pnaVAmuY4imjREEEq4w=;
 b=XhQffmLddO740ypkcvp9LJ57gTmolehmQaXaBBwAkaPjjKKv9A4PJjb+9JsrJGDhty
 bEmIScpCc+WerCq28GZtnNbglofT68XG367U/WjqGlx5oaosLS3pry1FdRaK2eFi62KF
 EXC516vorR0y8AEse+JhmxpFpd34AuGCSken2FOrbaUZjBBNl0sb3pGHY6Sz2tJOoOCM
 /ZjLs2luxm+HkQ/JYuitXx/o/P6Si2o+50GOGbdT0H3Pqr7OsB59UAyHCVrlrRleI11N
 dbhNthVx266GZ4gCXW9U71mbQG2cvF3auXU3OwfjBffdoeCPQxEOYDQxEq7dyNBRl+ag
 A2RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775851618; x=1776456418;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sFNUoiA4sxZwl6xj/mdiLyn6pnaVAmuY4imjREEEq4w=;
 b=qJr5u8KdEurhGxUVGLvRPXjWXHj1so7/lVjciaj6G6s9LMflxiXK/9ij1NZbFmoXKh
 sgrD5bSkN9vvKfj4+2bxxtC30qyKPL2QIVWw643L9nHQclZTSc7OVXLhIHQEOGomCQ85
 dgCWVhVnQPXf71lfUZW4lkjWrQyr9MWvag6L577sYv9dSCyici8KcXausIV4fpBm2dXD
 ZVeiU1PiIXjMSlUzDipisfwPdH5ZAQ+/xU59wBqEy4KySiZbYj7phZV3O9R+QvuQIwH6
 wR7xp5pQScCSqy8EcLhox27+gpniHQRFyt5pFSJUoUi08QFRWR46/+dbQ+w8jPRIUGgS
 fiAA==
X-Gm-Message-State: AOJu0YxM5e5hJ4m1gLr3moS00JC+LtGvL6HjhhE/+zHFHm6G+j7ILTDS
 vhzNZA4HE0sUVn/5+hkX60+gDabotT3RKSx4YMTNg4aGAZOZvwDdP+xqAKuRYjcH4gxwkF5dQAj
 tt7WB9oo=
X-Gm-Gg: AeBDietwfTr1kyeSMNgrO+u6WQAy3drBZP41Gz5r3mSZymTw7XcijCRywurzk6bLv7z
 RuC3jG42a5cAGXmAYRorRuQpREsjs8VjI5K72b0FwEmr9VF4YIYjwLB9OllOMiwb4TYHJ9gNkj7
 Ga5ZwC3W3UqyTNuKSxOECR1pqV9OZzJbDG4i8JSlTkBZLVj4KqiZOLrqUBqnRCT8ClSp9BC+rNr
 UHS1iVVpfce+2Bx1VQC3nSRgK8Peufmie5RUJYgvtyzDnEhh7uIuJ5ew65IHiuoq8C7EyAlpsZz
 0AFEQfBUa+KxjY0E5Jf9VyquOuw/jcAsefiiV96pE6146PDXwqGXXlGZZ3tH/Qec5ibSxmReL1l
 gMAVgdYp5m6G7zGU/bsRtfwdY2bUkXXFVWJRiBZi+fIdGyb3HHirhi4ZttuYU9S/4WGCYY652lG
 OKA2n/ozsct6yNXp+MnRF+OJjMASEBaGKhp9hbURFpYXLUtCDxAvPTsvjIzgeRh0wOoXB79agt
X-Received: by 2002:a5d:5f86:0:b0:43b:445f:3177 with SMTP id
 ffacd0b85a97d-43d642ba100mr6855105f8f.31.1775851617631; 
 Fri, 10 Apr 2026 13:06:57 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d63e46a90sm9221024f8f.19.2026.04.10.13.06.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 10 Apr 2026 13:06:57 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 4/9] target/arm: Conceal MO_TE within MVE DO_VSTR() macro
Date: Fri, 10 Apr 2026 22:06:23 +0200
Message-ID: <20260410200628.19378-5-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260410200628.19378-1-philmd@linaro.org>
References: <20260410200628.19378-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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


