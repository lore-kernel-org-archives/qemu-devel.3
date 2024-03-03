Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E429C5478C
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Mar 2024 02:20:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgbRx-0003FD-05; Sat, 02 Mar 2024 21:19:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgbRw-0003Ep-1f
 for qemu-devel@nongnu.org; Sat, 02 Mar 2024 21:19:36 -0500
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgbRu-0002zW-Cg
 for qemu-devel@nongnu.org; Sat, 02 Mar 2024 21:19:35 -0500
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-5cfd95130c6so2164717a12.1
 for <qemu-devel@nongnu.org>; Sat, 02 Mar 2024 18:19:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709432373; x=1710037173; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8LKOglf5FLGNH3eaaGAUHPjoI3Xb2uqIPMKgbxeqQ8c=;
 b=tMTuZwmj10NM24NXStl1ew5nWUGdUiLvW9Ekyp0LTUoJ45nzuDEYAHUeNk6n4CB3oT
 l1v/WJcJkp4zjPDjx815fjJ9tf2BGBygqte4gOddtOxLF2IPKU8wD2iJsj9hzZe+WVBm
 KfcRl/sHowaYJLfoSHsXa4egdYGimc7mMVxBV9aSo4sJZ6JOPtJ2+tbb2Wiros1sfYGf
 yYqRtaggAF2KG+InYAFdnR1W+47TTI0VNj35lldVDW8DfnIBy+SmK0oG5ditiivLb78e
 dNTrD2rQmKS5sIpIdEwWR0g6gVTM+CFf1mnHmZgv8X6kqZAzxDSemN3/3Ov8D1nJX1Sn
 W3+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709432373; x=1710037173;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8LKOglf5FLGNH3eaaGAUHPjoI3Xb2uqIPMKgbxeqQ8c=;
 b=PYfUIp/EoIpOFY1kMaoRfPdM9w6ZAiXHrua0dOV0pzlmIGCFG4EZKea5TjQv164y/T
 zH5HZXnt3w3tFlvigcl4RGxpiUrsKq8FSv+hRp2bJN7EzDMJggCD0GvlpZHGXJo16hKL
 UcCSm6xR20bkoN7UP3vg3y4NIRR/8/cjzxnzf/cFtk1/acRFxBUWwzzfzhsUn4ZpjqQc
 Sh8cF0MeYlMTMSulWhIUSbj0PpuVFj1BOrt44OukT1w+rTm4i97bIZI80mobbS4jBLcs
 SiAEn8Rf/hucEkbKpnN8ODw3/CK2TjfoZ1xp1N/iN+6biYR1daV01sAkBo5miI+3tMFf
 Nn0Q==
X-Gm-Message-State: AOJu0YyyGeBondThlSV8rKh+EcemgBtswElRQdLcq4qfxaqifda1dl8H
 ClViyc3EvGX/89xSNskDK5uHDNXJK/yW/zwusEMojDLgnRd0Y94yye3KxZwd/PTVKMpAzlM1Trv
 p
X-Google-Smtp-Source: AGHT+IEg3WT16D6eeYcfUILo5mWONTVoGFB6rG8s0PKAN/gDTUynjPeLnvQvg+2J1QO2bHr9A3xsoQ==
X-Received: by 2002:a17:902:ccc2:b0:1dd:159:e2e7 with SMTP id
 z2-20020a170902ccc200b001dd0159e2e7mr1916922ple.39.1709432373142; 
 Sat, 02 Mar 2024 18:19:33 -0800 (PST)
Received: from stoup.. (098-147-055-211.res.spectrum.com. [98.147.55.211])
 by smtp.gmail.com with ESMTPSA id
 q15-20020a170902dacf00b001db5ecb2899sm3512578plx.162.2024.03.02.18.19.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Mar 2024 18:19:32 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: svens@stackframe.org,
	deller@gmx.de
Subject: [PATCH 3/3] target/hppa: Fix assemble_12a insns for wide mode
Date: Sat,  2 Mar 2024 16:19:25 -1000
Message-Id: <20240303021925.116609-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240303021925.116609-1-richard.henderson@linaro.org>
References: <20240303021925.116609-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x534.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Reported-by: Sven Schnelle <svens@stackframe.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/insns.decode | 27 ++++++++++++++++-----------
 target/hppa/translate.c  | 17 +++++++++++++++++
 2 files changed, 33 insertions(+), 11 deletions(-)

diff --git a/target/hppa/insns.decode b/target/hppa/insns.decode
index 9c6f92444c..5412ff9836 100644
--- a/target/hppa/insns.decode
+++ b/target/hppa/insns.decode
@@ -26,7 +26,7 @@
 
 %assemble_11a   4:12 0:1             !function=expand_11a
 %assemble_12    0:s1 2:1 3:10        !function=expand_shl2
-%assemble_12a   0:s1 3:11            !function=expand_shl2
+%assemble_12a   3:13 0:1             !function=expand_12a
 %assemble_16    0:16                 !function=expand_16
 %assemble_17    0:s1 16:5 2:1 3:10   !function=expand_shl2
 %assemble_22    0:s1 16:10 2:1 3:10  !function=expand_shl2
@@ -314,8 +314,9 @@ fstd            001011 ..... ..... .. . 1 -- 100 0 . .....      @fldstdi
 @ldstim14m      ...... b:5 t:5 ................          \
                 &ldst sp=%assemble_sp disp=%assemble_16  \
                 x=0 scale=0 m=%neg_to_m
-@ldstim12m      ...... b:5 t:5 sp:2 ..............      \
-                &ldst disp=%assemble_12a x=0 scale=0 m=%pos_to_m
+@ldstim12m      ...... b:5 t:5 ................          \
+                &ldst sp=%assemble_sp disp=%assemble_12a \
+                x=0 scale=0 m=%pos_to_m
 
 # LDB, LDH, LDW, LDWM
 ld              010000 ..... ..... .. ..............    @ldstim14  size=0
@@ -331,15 +332,19 @@ st              011010 ..... ..... .. ..............    @ldstim14  size=2
 st              011011 ..... ..... .. ..............    @ldstim14m size=2
 st              011111 ..... ..... .. ...........10.    @ldstim12m size=2
 
-fldw            010110 b:5 ..... sp:2 ..............    \
-                &ldst disp=%assemble_12a t=%rm64 m=%a_to_m x=0 scale=0 size=2
-fldw            010111 b:5 ..... sp:2 ...........0..    \
-                &ldst disp=%assemble_12a t=%rm64 m=0 x=0 scale=0 size=2
+fldw            010110 b:5 ..... ................        \
+                &ldst disp=%assemble_12a sp=%assemble_sp \
+                t=%rm64 m=%a_to_m x=0 scale=0 size=2
+fldw            010111 b:5 ..... .............0..        \
+                &ldst disp=%assemble_12a sp=%assemble_sp \
+                t=%rm64 m=0 x=0 scale=0 size=2
 
-fstw            011110 b:5 ..... sp:2 ..............    \
-                &ldst disp=%assemble_12a t=%rm64 m=%a_to_m x=0 scale=0 size=2
-fstw            011111 b:5 ..... sp:2 ...........0..    \
-                &ldst disp=%assemble_12a t=%rm64 m=0 x=0 scale=0 size=2
+fstw            011110 b:5 ..... ................        \
+                &ldst disp=%assemble_12a sp=%assemble_sp \
+                t=%rm64 m=%a_to_m x=0 scale=0 size=2
+fstw            011111 b:5 ..... .............0..        \
+                &ldst disp=%assemble_12a sp=%assemble_sp \
+                t=%rm64 m=0 x=0 scale=0 size=2
 
 ld              010100 ..... ..... .. ............0.    @ldstim11
 fldd            010100 ..... ..... .. ............1.    @ldstim11
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 6dcc74e681..1ef266c403 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -155,6 +155,23 @@ static int expand_11a(DisasContext *ctx, int val)
     return i;
 }
 
+/* Expander for assemble_16a(s,im11a,i). */
+static int expand_12a(DisasContext *ctx, int val)
+{
+    /*
+     * @val is bit 0 and bits [3:15].
+     * Swizzle thing around depending on PSW.W.
+     */
+    int im11a = extract32(val, 1, 11);
+    int sp = extract32(val, 12, 2);
+    int i = (-(val & 1) << 13) | (im11a << 2);
+
+    if (ctx->tb_flags & PSW_W) {
+        i ^= sp << 13;
+    }
+    return i;
+}
+
 /* Expander for assemble_16(s,im14). */
 static int expand_16(DisasContext *ctx, int val)
 {
-- 
2.34.1


