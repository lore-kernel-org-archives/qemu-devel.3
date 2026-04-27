Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE6B9FF8860
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 12:55:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHLTX-0004kx-Ro; Mon, 27 Apr 2026 08:54:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHLNb-0007zP-Kl
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 08:48:13 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHLNX-0005dw-0N
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 08:48:02 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-488b8bc6bc9so73661105e9.3
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 05:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777294076; x=1777898876; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=R7h77WsAwsKJ8C6jkWRQ6EkruxaMVGzI14Ly1x3Rls4=;
 b=qQM28eUkz0juznKMubjYGxyUSyz2tAb2BB2UzLwehIWd3+Pbr3JdB94NZiL+4np4iF
 rq3vxyLm3bSlV54DBz/lMKJNexPCwACvHeRF1qYYKSnQ0m7pSYNO5jTcUkFmO83ces5a
 b7/JfVvEFSMliRgO9MJDj5kX1sWKszH+dylhxF44I/S575H/xYz0rzkEUCFDwAelRLhe
 /u7Mb1KcvBiSxIbNfnHWjkHs8oPYjvka4ywDi3Rx5ieydu71SKwxW5Vro+jZUGZv2QG2
 qLGyPiwTQ/QouiolHybZHWMkxG1Y02ITXQCxHwemwiV7IINnJD4egcZ+e/KBOHRpyMKx
 O/Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777294076; x=1777898876;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=R7h77WsAwsKJ8C6jkWRQ6EkruxaMVGzI14Ly1x3Rls4=;
 b=VZyhEr5FbLVG5bjaql5JrS2d4r1114hb2HoYDXpNVozVbBE98uCeO7Bk5XS8+iEMiw
 WX5aFmuyZuMsPEeXMvDMrFnnoSYQ9qcbr4rtnsEgJoveizVVmNVAylKIL6hZFUwXc2r3
 r+ea44nD/DWC0C2eTkrCz67THvdJ1xH3Wdy1CESE/A+irVHIm2HRYjCyi49jdiXC4eEv
 icEJej5qOwiL8j47uYcWFM+YQa1XR0fkCLkSW127J/KHA+tfkVScujqwI0nkrlXHo57t
 Ao5hVl/97siIwVOxZrEeloRGLLlEZGz6X3Y/ETyAz1LgE5tdRr4LdXI4pC8b6g3o44Sq
 9nWA==
X-Gm-Message-State: AOJu0Yw5QB360y51wXIg4xeigntj+YAWNO3BQTmCAXmRnwMtiVkkbdrP
 iknmGK21ka5m76qfVgeEuVS/Gv18cDCgwTjL/3Oobxr/ePrl7O9nGXLh0VMpb+uxLCO/8/dechQ
 rs/zS
X-Gm-Gg: AeBDievtMonuRK3Q2qvk/eHF8zzjU2Y28tNrj/6V5gutXjJ7TVWQHeJ4DHQt5jPXjXs
 kK9A4KBS2ViupYkJ/su41pp/4qgVu/m/sbxKMug2fT7HA13ZYOW9OqVkwKtqNcS90kx4QjgURbw
 0Z3j53UzrzaZYLTNKVHnPzlsdbWm4nGFlUQMijQS+aH7ZcRnyhOGiCvde7UWubhgdauI3SN1hM4
 jN9o9m2NHXdYSyRYFxr90tassHTkNHlf2JbYrjo+Z1074pPKngAJMbbg+0Mu61Nbfhw3Zx/DB+c
 pWzKMmcv9Q3JXV+FJ+U35yCOHeNuF9nDRxCccqz5sR2AWK/2CngLOo8T3MtLbjUBOV/m8uI5HKj
 gtR2vNKlzJaTssYcuornT9onVw3x9Rc3Y8CQ5Y2XFg385NaEiFzpvpQ2y2f1Dn7eyvq33ft0ebg
 mbQoxZzCM2IBNxSASaZoL1JnVgnTKvgdgmIrtuRvj1oGCYhSA3fIqTpboCW5V7Ch1EYW5+y5uKz
 RGNIay9La0oM82gWRpkpAslsFpjG/su3aLEGi8nQQ==
X-Received: by 2002:a05:600c:548a:b0:48a:75b9:b0bc with SMTP id
 5b1f17b1804b1-48a75b9b0c5mr15132205e9.29.1777294075990; 
 Mon, 27 Apr 2026 05:47:55 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488ffc5e3f4sm448974115e9.2.2026.04.27.05.47.55
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 05:47:55 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 19/63] target/arm: Hoist MO_TE into mve_advance_vpt()
Date: Mon, 27 Apr 2026 13:46:53 +0100
Message-ID: <20260427124738.966578-20-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260427124738.966578-1-peter.maydell@linaro.org>
References: <20260427124738.966578-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260414005348.4767-4-philmd@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/mve_helper.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/target/arm/tcg/mve_helper.c b/target/arm/tcg/mve_helper.c
index cc58e0502f..fbb64889bf 100644
--- a/target/arm/tcg/mve_helper.c
+++ b/target/arm/tcg/mve_helper.c
@@ -160,7 +160,8 @@ static void mve_advance_vpt(CPUARMState *env)
         uint16_t eci_mask = mve_eci_mask(env);                          \
         unsigned b, e;                                                  \
         int mmu_idx = arm_to_core_mmu_idx(arm_mmu_idx(env));            \
-        MemOpIdx oi = make_memop_idx(MFLAG | MO_ALIGN, mmu_idx);        \
+        MemOpIdx oi = make_memop_idx(MO_TE | MFLAG | MO_ALIGN,          \
+                                     mmu_idx);                          \
         /*                                                              \
          * R_SXTM allows the dest reg to become UNKNOWN for abandoned   \
          * beats so we don't care if we update part of the dest and     \
@@ -183,7 +184,8 @@ static void mve_advance_vpt(CPUARMState *env)
         uint16_t mask = mve_element_mask(env);                          \
         unsigned b, e;                                                  \
         int mmu_idx = arm_to_core_mmu_idx(arm_mmu_idx(env));            \
-        MemOpIdx oi = make_memop_idx(MFLAG | MO_ALIGN, mmu_idx);        \
+        MemOpIdx oi = make_memop_idx(MO_TE | MFLAG | MO_ALIGN,          \
+                                     mmu_idx);                          \
         for (b = 0, e = 0; b < 16; b += ESIZE, e++) {                   \
             if (mask & (1 << b)) {                                      \
                 cpu_##STTYPE##_mmu(env, addr, d[H##ESIZE(e)], oi, GETPC()); \
@@ -194,23 +196,23 @@ static void mve_advance_vpt(CPUARMState *env)
     }
 
 DO_VLDR(vldrb, MO_UB, 1, uint8_t, ldb, 1, uint8_t)
-DO_VLDR(vldrh, MO_TE | MO_UW, 2, uint16_t, ldw, 2, uint16_t)
-DO_VLDR(vldrw, MO_TE | MO_UL, 4, uint32_t, ldl, 4, uint32_t)
+DO_VLDR(vldrh, MO_UW, 2, uint16_t, ldw, 2, uint16_t)
+DO_VLDR(vldrw, MO_UL, 4, uint32_t, ldl, 4, uint32_t)
 
 DO_VSTR(vstrb, MO_UB, 1, stb, 1, uint8_t)
-DO_VSTR(vstrh, MO_TE | MO_UW, 2, stw, 2, uint16_t)
-DO_VSTR(vstrw, MO_TE | MO_UL, 4, stl, 4, uint32_t)
+DO_VSTR(vstrh, MO_UW, 2, stw, 2, uint16_t)
+DO_VSTR(vstrw, MO_UL, 4, stl, 4, uint32_t)
 
 DO_VLDR(vldrb_sh, MO_SB, 1, int8_t, ldb, 2, int16_t)
 DO_VLDR(vldrb_sw, MO_SB, 1, int8_t, ldb, 4, int32_t)
 DO_VLDR(vldrb_uh, MO_UB, 1, uint8_t, ldb, 2, uint16_t)
 DO_VLDR(vldrb_uw, MO_UB, 1, uint8_t, ldb, 4, uint32_t)
-DO_VLDR(vldrh_sw, MO_TE | MO_SW, 2, int16_t, ldw, 4, int32_t)
-DO_VLDR(vldrh_uw, MO_TE | MO_UW, 2, uint16_t, ldw, 4, uint32_t)
+DO_VLDR(vldrh_sw, MO_SW, 2, int16_t, ldw, 4, int32_t)
+DO_VLDR(vldrh_uw, MO_UW, 2, uint16_t, ldw, 4, uint32_t)
 
 DO_VSTR(vstrb_h, MO_UB, 1, stb, 2, int16_t)
 DO_VSTR(vstrb_w, MO_UB, 1, stb, 4, int32_t)
-DO_VSTR(vstrh_w, MO_TE | MO_UW, 2, stw, 4, int32_t)
+DO_VSTR(vstrh_w, MO_UW, 2, stw, 4, int32_t)
 
 #undef DO_VLDR
 #undef DO_VSTR
-- 
2.43.0


