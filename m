Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB89710F2853
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 16:52:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w6AOh-0006Am-Q9; Fri, 27 Mar 2026 12:50:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w6AOg-00069j-6q
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 12:50:58 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w6AOe-0005GO-3x
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 12:50:57 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-c74244dc0b3so1628211a12.2
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2026 09:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774630255; x=1775235055; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YgQl5yPsWs4mu3exjzDTSuGdX6yFtjVmfC62Efiw0bA=;
 b=LwVO8iq2iIYfwscUODF5kdu661Ke12nYM/Dx3xiVnqL77cxc31RT2D4LwUhiJFeHes
 uVH2caorOjpAHI2uO5sfZHQzV/jYkOLX612loezGRNqndtPfuirieEB+6m5nLPnuoQr1
 iGOtWSfkLO0HShMlhppvKw0aEfKrJS7slhAWjCCGIPfjBo2h3VUga29gJT4vWbRBvfCM
 NgIwfGdbHCXZs9qFYyqrj2s6j4e4hjTVcHrvpE77sMct9byxn8TK8yjGW20h0LC0ZIzq
 2DoD40ZwYmWoZlTYJmdJ8x7W9XS6m43lpzBLCGjT8u5TGOBNqrBrVOrJ3SMmUtH+IoUn
 MMGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774630255; x=1775235055;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YgQl5yPsWs4mu3exjzDTSuGdX6yFtjVmfC62Efiw0bA=;
 b=Fw4NtFEn42ZZE7RCFvYEqtPDgtqdRCVB0zclaInte9QH7bzCtxIQHCSFIsXMhLnHYv
 6wCN7hrvLb6ynXLDzflZ3TFy4sbMmKj3m3lKBo0SdT32cLXQLPh6UaDtRRYzYviPhUcT
 43c+NPk8/ri5X17Iw16/TzFXmIukJqCftVb2X9JJdbDhwPnAKq+D/QP7E6NPTk4RAQtb
 do5WGlNyKhMx6tFjDp3JoNxHGuBP4/awhDe5fDwtbbmnHZW8m3vIwYNVnid2MnTm9Mvi
 l2AfM8bJ5YvkNWiVRMizUqyGcXuTFhRM2rpyoO/XDuNoxWW4ZtHFT110KV6yl7xS5/9R
 n1bw==
X-Gm-Message-State: AOJu0Yx9McvtkLYz38fp8qeRx9kmRZ4Fnrk00f2IE4zkOg1KXOV26JZR
 Eg8Q7oG7K72PhiS4D1/W0gJEq7/cYD6ysWZtCWoXr03XmVHtW1wEDFH2DseUNkvuj1DHkf5StI9
 apMTRJsc=
X-Gm-Gg: ATEYQzySsFzr0R+xmPUfz5fyM1pS/S2qtOirEofBWEc8upDcO8gLmQiHefG72lYcFDM
 SakodbB6eTYPqoZW5ZJYxP1a7FbUDuFX+wkk1z9UK2VFuxPvDbnBsW589cOeUTR2nQmWeNYbws3
 rMMwRAW3V4L/+5EMlDZCAXbLdWOUzW/lFF8zOeYmf4zXOi00N3WZd/f7NS9ULEv7/9Qe6h9kkoR
 ZZ6TAq9NKe/zv49IfqqUcAqhtNB2ymd4udRP9hqfBY0l+uq4U43ikCxchvz78kO5Wa0IbtZcjpt
 UkBiAKykoDBEkp3kJy9WC2SV23KJK3a803wq/KN7f9EPbAo6QMDz5PV13d+sl8G6RTXJG+Fc/S8
 4WtWgfe4ZHa+Jah5upCx4HW8eFUZqanKJx3XQFJcu+makYudQi7NJ+ESUaPpn8HCzuX0WK1N4rx
 ZikewWjunsi/mBwazmT5KvPRhAAkb8unZo9WkDNKJQpWg3olrkcw5Ngrz6RTjwVJQNwQIN8epKT
 iFZxte1lv3Aae0=
X-Received: by 2002:a05:6a20:914a:b0:398:b5c0:583 with SMTP id
 adf61e73a8af0-39c87a9e9bcmr3613389637.40.1774630254652; 
 Fri, 27 Mar 2026 09:50:54 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c767399e0casm5514038a12.31.2026.03.27.09.50.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 09:50:53 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, philmd@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, jim.macarthur@linaro.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v5 07/12] target/arm/tcg/translate-mve.c: make compilation
 unit common
Date: Fri, 27 Mar 2026 09:50:37 -0700
Message-ID: <20260327165042.604105-8-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260327165042.604105-1-pierrick.bouvier@linaro.org>
References: <20260327165042.604105-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x52f.google.com
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/tcg/meson.build | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/arm/tcg/meson.build b/target/arm/tcg/meson.build
index c14c9242df5..1e9c147e4d2 100644
--- a/target/arm/tcg/meson.build
+++ b/target/arm/tcg/meson.build
@@ -28,7 +28,6 @@ arm_ss.add(files(
   'gengvec.c',
   'translate.c',
   'translate-m-nocp.c',
-  'translate-mve.c',
   'm_helper.c',
   'mve_helper.c',
   'op_helper.c',
@@ -59,6 +58,7 @@ arm_common_ss.add(files(
 ))
 
 arm_common_system_ss.add(
+  decodetree.process('mve.decode', extra_args: '--decode=disas_mve'),
   decodetree.process('neon-shared.decode', extra_args: '--decode=disas_neon_shared'),
   decodetree.process('neon-dp.decode', extra_args: '--decode=disas_neon_dp'),
   decodetree.process('neon-ls.decode', extra_args: '--decode=disas_neon_ls'),
@@ -72,6 +72,7 @@ arm_common_system_ss.add(
   'psci.c',
   'tlb_helper.c',
   'tlb-insns.c',
+  'translate-mve.c',
   'translate-neon.c',
   'translate-vfp.c',
   'vec_helper.c',
@@ -82,6 +83,7 @@ arm_user_ss.add(files(
   'hflags.c',
   'neon_helper.c',
   'tlb_helper.c',
+  'translate-mve.c',
   'translate-neon.c',
   'translate-vfp.c',
   'vec_helper.c',
-- 
2.47.3


