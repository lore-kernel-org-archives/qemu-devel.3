Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 835C9C54798
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Mar 2024 02:20:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgbRu-0003EM-F0; Sat, 02 Mar 2024 21:19:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgbRt-0003Dr-6W
 for qemu-devel@nongnu.org; Sat, 02 Mar 2024 21:19:33 -0500
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgbRr-0002z7-Ll
 for qemu-devel@nongnu.org; Sat, 02 Mar 2024 21:19:32 -0500
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-5e4613f2b56so3105703a12.1
 for <qemu-devel@nongnu.org>; Sat, 02 Mar 2024 18:19:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709432370; x=1710037170; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yvtR6Tkj4Ql8rJP4IqTS1f67x9pt9hVmnIoNey13RNI=;
 b=nzS9LAC1hGCjGIfps6I0hNMDLqgL7Jy6Yza1fpJxuhOVT97WPB3LMb2pfSZ7RhKYXt
 JQ/OnNC6Gni86ZMfh4cUIhfVYbLqQJG9SxXF6EgFn4IW+9I+c5l12CI81PUabN8JRaa3
 7nSDp+kQZEW8zN9UQuan5jsLid2u69128N9bUy0gvya0qYojlwDZbGgaBZJZ3R9eiLNa
 ATRHFrBBim33ED4Y5wRUINpN6T6rfumNitw7d1JnLRkwXjsBlhExKcOCyAWS0UloOjWY
 b5ziS9Lzy0ANRkzfLwwf3AMmDVTIBOXAQzyHc+952ezEWvLTh+CdAb5U5RBXnyKMX08+
 ujAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709432370; x=1710037170;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yvtR6Tkj4Ql8rJP4IqTS1f67x9pt9hVmnIoNey13RNI=;
 b=W4lxu9UDM5uSov64Kb91drgNopRC2Mo2km9yq3STOmXD5Yl27MKdyq2UrGRM9+qHuC
 JqMZb2oUUT9w6Xv+In8cljf5NWHynAnTo9OOAVUNlx3C5ZyjsNRSignmZbZb5qycvc17
 01jGkb1G/Llv2v1jiClVRSkBrX0JO4xi2ppFNLKnP/ec0IwwhELP6HuNp3JzmXYTveeD
 T5DgS4m1rJmf1PY6bjmyzlYQ5cy49Ekyu/txIT5zHN7JCukp5M/2tjELw8aOR4RsazOq
 pZ1DCMbOmCUGKgAwcbne9UXkxD1gDDgqFVJtxQVo3pRV4aCRgOD8Wt54cUICcBP7z4cp
 /luA==
X-Gm-Message-State: AOJu0Yx3BRElAxhR5O8c1aDS9SnoDR+eojbGkLtNA4IUwjBBCJ6OTadf
 tsb9cSA2gNMqi3tzPFmsyqW0z7cqy7VTX8CYp06EFNvLLkYpWxbHd3eIYC34IyHnXNb713qxhdd
 /
X-Google-Smtp-Source: AGHT+IG8vuGEtK0QyLQyhmkK9NBKviJX9Jc4VLuWd90fa2U0URgC5uaT057RuLn9SWStXPVpRnXwgg==
X-Received: by 2002:a17:902:e748:b0:1dd:d0b:6c07 with SMTP id
 p8-20020a170902e74800b001dd0d0b6c07mr28890plf.68.1709432370202; 
 Sat, 02 Mar 2024 18:19:30 -0800 (PST)
Received: from stoup.. (098-147-055-211.res.spectrum.com. [98.147.55.211])
 by smtp.gmail.com with ESMTPSA id
 q15-20020a170902dacf00b001db5ecb2899sm3512578plx.162.2024.03.02.18.19.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Mar 2024 18:19:29 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: svens@stackframe.org,
	deller@gmx.de
Subject: [PATCH 1/3] target/hppa: Fix assemble_16 insns for wide mode
Date: Sat,  2 Mar 2024 16:19:23 -1000
Message-Id: <20240303021925.116609-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240303021925.116609-1-richard.henderson@linaro.org>
References: <20240303021925.116609-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x532.google.com
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
 target/hppa/insns.decode | 15 +++++++++------
 target/hppa/translate.c  | 21 +++++++++++++++++++++
 2 files changed, 30 insertions(+), 6 deletions(-)

diff --git a/target/hppa/insns.decode b/target/hppa/insns.decode
index f5a3f02fd1..0d9f8159ec 100644
--- a/target/hppa/insns.decode
+++ b/target/hppa/insns.decode
@@ -27,13 +27,14 @@
 %assemble_11a   0:s1 4:10            !function=expand_shl3
 %assemble_12    0:s1 2:1 3:10        !function=expand_shl2
 %assemble_12a   0:s1 3:11            !function=expand_shl2
+%assemble_16    0:16                 !function=expand_16
 %assemble_17    0:s1 16:5 2:1 3:10   !function=expand_shl2
 %assemble_22    0:s1 16:10 2:1 3:10  !function=expand_shl2
+%assemble_sp    14:2                 !function=sp0_if_wide
 
 %assemble_21    0:s1 1:11 14:2 16:5 12:2  !function=expand_shl11
 
 %lowsign_11     0:s1 1:10
-%lowsign_14     0:s1 1:13
 
 %sm_imm         16:10 !function=expand_sm_imm
 
@@ -221,7 +222,7 @@ sub_b_tsv       000010 ..... ..... .... 110100 . .....  @rrr_cf_d
 
 ldil            001000 t:5 .....................        i=%assemble_21
 addil           001010 r:5 .....................        i=%assemble_21
-ldo             001101 b:5 t:5 -- ..............        i=%lowsign_14
+ldo             001101 b:5 t:5  ................        i=%assemble_16
 
 addi            101101 ..... ..... .... 0 ...........   @rri_cf
 addi_tsv        101101 ..... ..... .... 1 ...........   @rri_cf
@@ -306,10 +307,12 @@ fstd            001011 ..... ..... .. . 1 -- 100 0 . .....      @fldstdi
 
 @ldstim11       ...... b:5 t:5 sp:2 ..............      \
                 &ldst disp=%assemble_11a m=%ma2_to_m x=0 scale=0 size=3
-@ldstim14       ...... b:5 t:5 sp:2 ..............      \
-                &ldst disp=%lowsign_14 x=0 scale=0 m=0
-@ldstim14m      ...... b:5 t:5 sp:2 ..............      \
-                &ldst disp=%lowsign_14 x=0 scale=0 m=%neg_to_m
+@ldstim14       ...... b:5 t:5 ................          \
+                &ldst sp=%assemble_sp disp=%assemble_16  \
+                x=0 scale=0 m=0
+@ldstim14m      ...... b:5 t:5 ................          \
+                &ldst sp=%assemble_sp disp=%assemble_16  \
+                x=0 scale=0 m=%neg_to_m
 @ldstim12m      ...... b:5 t:5 sp:2 ..............      \
                 &ldst disp=%assemble_12a x=0 scale=0 m=%pos_to_m
 
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 01f3188656..585d836959 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -144,6 +144,27 @@ static int assemble_6(DisasContext *ctx, int val)
     return (val ^ 31) + 1;
 }
 
+/* Expander for assemble_16(s,im14). */
+static int expand_16(DisasContext *ctx, int val)
+{
+    /*
+     * @val is bits [0:15], containing both im14 and s.
+     * Swizzle thing around depending on PSW.W.
+     */
+    int i = (-(val & 1) << 13) | extract32(val, 1, 13);
+
+    if (ctx->tb_flags & PSW_W) {
+        i ^= val & (3 << 13);
+    }
+    return i;
+}
+
+/* The sp field is only present with !PSW_W. */
+static int sp0_if_wide(DisasContext *ctx, int sp)
+{
+    return ctx->tb_flags & PSW_W ? 0 : sp;
+}
+
 /* Translate CMPI doubleword conditions to standard. */
 static int cmpbid_c(DisasContext *ctx, int val)
 {
-- 
2.34.1


