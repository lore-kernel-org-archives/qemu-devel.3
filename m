Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E79DDC54E71
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 00:33:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmjse-0008Ut-6F; Tue, 19 Mar 2024 20:32:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rmjsc-0008UK-Kz
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 20:32:30 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rmjsb-0005WK-2g
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 20:32:30 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-6e6ee9e3cffso284120b3a.1
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 17:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710894747; x=1711499547; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k5PnQhFXfvSe92fnLRbZ5TBOd12ifIZn+pMwnRQCRuU=;
 b=QYV+A2ssMwBE2QTBfTdLU5Io6vlELcb3AleNKYzcBEy42TbLrrX+xahpfZad5g314i
 gU8kzxQJ7Iu6bkn6wrYJdWdboz/jrzIMKSSQwr+T1dOUZu0Pt5OOcwaMMb1GMrT5oztR
 YOxWpZbIrPYsV0yHsXjX4XX9EJ2WI5d0gOTzALFEk9Dt0zC7PUX6S5jJOeombmC86CiU
 6CJjqE7nF91Tkr4yIeufC7ba6YYts0idUH7RSZ6wxDv9qPaeBFnkLoJTghIG2+uPN/Jz
 Yy1UNdvqxaCfYqYlKGXVz9WL85a6L/dY1J0l/OxuumjXF+QkOiQ2TC7rqwT6Ny+7G3iq
 7wFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710894747; x=1711499547;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k5PnQhFXfvSe92fnLRbZ5TBOd12ifIZn+pMwnRQCRuU=;
 b=KysUkeNrYET6YS9LtqfaKDo/zdLicihLpsBr64lE87FriyEUotVf+eT8tPr9JFyiFw
 n2SMa7/E05un/wrZwY52T4Bu97cM5eD2u2YdtQi8bqAnH6Rrug8UWcQ+mqH+HihYRPcM
 8kSTGSJ/Y7pSLj+66kbJT2zJvQtJyUSZ6Bn/eydpzhG14BErfjp+UqIVuP61py8Rb8W0
 TWqQT8rFjEs3zkd7eBY50X+PaH5agiZXeMf/2CfxXH9XCrVnPJWXeJSJJ3r2NwhBtYrA
 fsXRydNqiEeqWGk0C77vsKKtTMRHyCeExn1P2n/5Bz2qzNdkURtqb2hnMGTZCnSI34q9
 VdrA==
X-Gm-Message-State: AOJu0Yxsz90cQHd++zCg4gI3M6NaUP932ps9K6ligfzWHAnzerjRaP1C
 OvzVKO8lpoqLglk2O/hBe7Vi1aA9aPGLGdiyo4AJbNbWYknQsdPrwz57c2cAr4+zl5Hd1IuV+vz
 O
X-Google-Smtp-Source: AGHT+IFazcmXmkIAnebDR0MNuliLyA9I7FbSYPpSL3vIP6YOI1ryk0Tao0WnU84+j/Gy77dczbxaqw==
X-Received: by 2002:a05:6a00:14c4:b0:6e6:ba5a:2c4e with SMTP id
 w4-20020a056a0014c400b006e6ba5a2c4emr5668979pfu.7.1710894747394; 
 Tue, 19 Mar 2024 17:32:27 -0700 (PDT)
Received: from stoup.. (173-197-098-125.biz.spectrum.com. [173.197.98.125])
 by smtp.gmail.com with ESMTPSA id
 d19-20020a63d653000000b005d553239b16sm8475645pgj.20.2024.03.19.17.32.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Mar 2024 17:32:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Sven Schnelle <svens@stackframe.org>,
	Helge Deller <deller@gmx.de>
Subject: [PULL 1/9] target/hppa: Fix assemble_16 insns for wide mode
Date: Tue, 19 Mar 2024 14:32:15 -1000
Message-Id: <20240320003223.554145-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240320003223.554145-1-richard.henderson@linaro.org>
References: <20240320003223.554145-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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
Reviewed-by: Helge Deller <deller@gmx.de>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/insns.decode | 15 +++++++++------
 target/hppa/translate.c  | 22 ++++++++++++++++++++++
 2 files changed, 31 insertions(+), 6 deletions(-)

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
index eb2046c5ad..cbe44ef75a 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -144,6 +144,28 @@ static int assemble_6(DisasContext *ctx, int val)
     return (val ^ 31) + 1;
 }
 
+/* Expander for assemble_16(s,im14). */
+static int expand_16(DisasContext *ctx, int val)
+{
+    /*
+     * @val is bits [0:15], containing both im14 and s.
+     * Swizzle thing around depending on PSW.W.
+     */
+    int s = extract32(val, 14, 2);
+    int i = (-(val & 1) << 13) | extract32(val, 1, 13);
+
+    if (ctx->tb_flags & PSW_W) {
+        i ^= s << 13;
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


