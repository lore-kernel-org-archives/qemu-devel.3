Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05891CD3447
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2026 02:15:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLtg9-000677-3Q; Sat, 09 May 2026 22:14:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wLtg6-00065x-93
 for qemu-devel@nongnu.org; Sat, 09 May 2026 22:13:58 -0400
Received: from mail-oo1-xc2a.google.com ([2607:f8b0:4864:20::c2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wLtg4-0002un-B6
 for qemu-devel@nongnu.org; Sat, 09 May 2026 22:13:58 -0400
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-6841e6a5e51so1619709eaf.3
 for <qemu-devel@nongnu.org>; Sat, 09 May 2026 19:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778379234; x=1778984034; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=DMtQ6otfSvVpuO6rahx7fwVTGsLSe4NmUYhcy52IxfI=;
 b=bV8w+M0kjwN/vorHfcubGIEsjwL7LrvL8GHr721App0qSP+EGPhNRHoX8G+k9OBfpc
 C4siBQbkw20v8zF+x8b0d8vuFz8WEd5hYMRIEXhwA9Fe9LPyUhuRJtgOz+HSZz0lxrbl
 y37TIjwfJf7AYwavVnPwQ35jwIrw4j3nQUWc8WtjHjmhpZpdiyPpsO/YFddDmx052lSI
 GbueAZqQ8aHbdn976uqpeaRgAMoEAt72uo04Yt6d/r7hpkCHFhEdRbXmzRdiZQ+TIF3n
 olWvY9B+AKqN59B++dRWCPHsLObtJevTDc+YeXmuW0XHitRm0A0VM2Brtp/SOvoA2lkA
 7JPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778379234; x=1778984034;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=DMtQ6otfSvVpuO6rahx7fwVTGsLSe4NmUYhcy52IxfI=;
 b=F4a8c88rtl5jbjpyqIYKzFlUI8X5xIoUsz1oPpG8211OqKTcLc9LKDH+S6orz3Rs+h
 /oseEUveL+zuECyyQ7QUiHWIwpNNlvysU7BjIW7OooPjQ1keRRMPfYOZuY3tOrD1+UTa
 I7SA0VQ1qGmIRBq2N+5etNK33Vst8JMQyFcFRv1ULs7WnMJFvTbLFQ9+CGxl3nPoDDYO
 ux6usXipIRak+aGtDrZX6GoQ1l0VDV3rj/pKIzXBkZ5JAymy4tqMJtOyYOtO5AoKnLgg
 pFudCW+/Pk2z5D9dfRkMlG21RP8asrLVpctdY9ONkej5ERzC1/gJ/Y2i47rCpRNBKPrz
 qLHQ==
X-Gm-Message-State: AOJu0Yzm6w0uuN/RebP4bis9/Naq7n6hB6PbjIQnSvra11+fyQaV4C8f
 rSw2QKLOE48ouXhAoPn0X86ZOFIRbYRgOrE1O8FQ6p/pNQEo2qdCNstM+CzBfxB3
X-Gm-Gg: Acq92OFodzrbe67ssYXLN4RxHADI8YgutZ+w+oeaHI+iaBXm3XrXRu86donvRFArmsn
 6DUXmPmOzt+zCOZLZCMysBc2Pvi8wJHLW+AaiN5ulMcb6bOVNYg7XJkbuwZxJcd7eHs1FZF6O1w
 wjvH1M3DzbJp/NCFJVdOIK4gpOi0S+7tTLSu0U6giK10+B9dE0NZbDKRFThD/cPz8+Hqgg/ZYd4
 7Bx8j0HOX3g6Cuer8PkXZYC576TXjhmA7Zi49wq9AUoGrAtlZIy2DeQ4y5ZajqMDut5YyT+nyQI
 814aEb2M4CsWIMEGkNt8RgFUXM+wj7ffjBuCCn5F32MxfEpuQhxAdPZsDWtOpHaEpBp/VjEQz03
 xkAV3mirCyK7NAk8JzTUY7N3S4hXyefd6lS0cAwqqGBuY4t6616O8z9x/ldTyPZ2qB++IUCO2i3
 GPX/VvFZpkAHoDbZkP08PIi0XiZRhCbdcxf0xyS4692qqjtAkFgrOdhr3hVKGwnRQfpnZ5fD2Nc
 R149KHS4Ua3CJIv6kbf6bVRmwcZ2b7sQR7tw9HEmev6ebq/i7lnaG1da9IvCcBky98I
X-Received: by 2002:a05:6820:4d0c:b0:696:93d3:e131 with SMTP id
 006d021491bc7-69998c9f9e9mr10241792eaf.7.1778379234407; 
 Sat, 09 May 2026 19:13:54 -0700 (PDT)
Received: from mac.localdomain (71-218-106-55.hlrn.qwest.net. [71.218.106.55])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69b25dbffdbsm3645643eaf.9.2026.05.09.19.13.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 May 2026 19:13:53 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sat, 09 May 2026 20:13:27 -0600
Subject: [PATCH v4 04/32] target/mips: fix Octeon arithmetic destination
 handling
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260509-mips-octeon-missing-insns-v2-v4-4-d669dcd05c2f@gmail.com>
References: <20260509-mips-octeon-missing-insns-v2-v4-0-d669dcd05c2f@gmail.com>
In-Reply-To: <20260509-mips-octeon-missing-insns-v2-v4-0-d669dcd05c2f@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Richard Henderson <richard.henderson@linaro.org>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2a;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oo1-xc2a.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

BADDU and DMUL write their results to rd, not rt.  Route writes through
gen_store_gpr() so rd == $zero is handled consistently.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v1 -> v2:
  - Split the BADDU/DMUL destination handling fix out of the Octeon
    arithmetic instruction patch.  (suggested by Philippe Mathieu-Daudé)

Changes v2 -> v3:
  - Remove the rd == $zero fast paths and let gen_store_gpr() discard
    writes to $zero.  (suggested by Richard Henderson)
---
 target/mips/tcg/octeon_translate.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index e1f52d444a..4dd7626835 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -45,18 +45,14 @@ static bool trans_BADDU(DisasContext *ctx, arg_BADDU *a)
 {
     TCGv_i64 t0, t1;
 
-    if (a->rt == 0) {
-        /* nop */
-        return true;
-    }
-
     t0 = tcg_temp_new_i64();
     t1 = tcg_temp_new_i64();
     gen_load_gpr(t0, a->rs);
     gen_load_gpr(t1, a->rt);
 
     tcg_gen_add_i64(t0, t0, t1);
-    tcg_gen_andi_i64(cpu_gpr[a->rd], t0, 0xff);
+    tcg_gen_andi_i64(t0, t0, 0xff);
+    gen_store_gpr(t0, a->rd);
     return true;
 }
 
@@ -64,17 +60,13 @@ static bool trans_DMUL(DisasContext *ctx, arg_DMUL *a)
 {
     TCGv_i64 t0, t1;
 
-    if (a->rt == 0) {
-        /* nop */
-        return true;
-    }
-
     t0 = tcg_temp_new_i64();
     t1 = tcg_temp_new_i64();
     gen_load_gpr(t0, a->rs);
     gen_load_gpr(t1, a->rt);
 
-    tcg_gen_mul_i64(cpu_gpr[a->rd], t0, t1);
+    tcg_gen_mul_i64(t0, t0, t1);
+    gen_store_gpr(t0, a->rd);
     return true;
 }
 

-- 
2.54.0


