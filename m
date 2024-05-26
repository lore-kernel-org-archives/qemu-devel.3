Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32CE3C25B75
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2024 19:44:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBJmH-0000dC-6w; Sun, 26 May 2024 15:43:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBJmD-0000R4-7x
 for qemu-devel@nongnu.org; Sun, 26 May 2024 15:43:29 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBJm7-0007lr-G5
 for qemu-devel@nongnu.org; Sun, 26 May 2024 15:43:27 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1f4a52b9413so445585ad.2
 for <qemu-devel@nongnu.org>; Sun, 26 May 2024 12:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716752602; x=1717357402; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hcyoZD3anU/IH/PLJOi2XftX4jEwUCrYWawOxmyODIk=;
 b=Yuah1sJvshy/L9SmbwmFTB35sLyqSAYAE7TAl8sxoxzxzDPGtwGqbYdev2B/ErXavX
 Ks0EqVrWXHx7JyMsk6h4bk3KQzBsafPqJFRee1KQnUYLkSPhvyY8RCmFnCuib+lMQw0F
 6l9HZsnfmGrLMIKNMlWoVBgGtyep2qXq+Suou1nve4ZuYRY6U3mIr//7/58jE2ULjHx+
 cQ3ntjfiDuPQRHQ21Vk/9o1iQ/fFt9DvX8EoBgHIBg5wXqYSIRiv6A2PRO2cfv+II7BN
 4y+kgo+GsMOsPwENd9S4PW5y7D/wckuxIT64S8kh1+Sou3W1pGDSk9Yjvd+dNXGp1Z2e
 mpfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716752602; x=1717357402;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hcyoZD3anU/IH/PLJOi2XftX4jEwUCrYWawOxmyODIk=;
 b=AS5B2CehF+agmgm2178zShBxjZ7LuMrTNnMZPcWYRWnbDf2Pd375LhGhuCKwRl/NKZ
 SHk05a6wj8URFMoa721qZpQcxbbdiw2SQU4Tkw/q/SMgUi96eWLh8N2j3sF0XSUJUXOZ
 WGkxUIRRa3n+ni2BnMIT75mgVG+LIzY1hMkg+O8/w/HZhWRAdL9yxrTGqZqwyXfVgGyR
 1eQq0KXQ85qoyCI64Ll9PbIsZEKHYFkRtD2eJo6Iscc+0FxmOOjigzhGla6jZ9h5QWEs
 AngxeDeUsZC2J5d/0bGNh54/ngEypwVipHowu/dVvb2tFD5FZEGp77Pes8asmMJyOoW+
 Zh7Q==
X-Gm-Message-State: AOJu0Yy8uP032wUFxwtHt8bXeOOQNCGSji73vDJkHfpodv+Nb1Xv1w74
 25iMkFWiyPxqU0Z2+Kcg/rRZTudfX9tyTzs1dq3lBgv6kQuXExbmJ/euCBWZZllnuzn/nVYoswC
 Y
X-Google-Smtp-Source: AGHT+IEEQ9497rFlz3wvKwFu4uHyBhqIn9IjmFYQLEjeZGUoNDHCLlNip5knLDz6H/b4S2cLV9t/Ng==
X-Received: by 2002:a17:902:c40d:b0:1f3:121e:e3cd with SMTP id
 d9443c01a7336-1f44872bc0fmr90028035ad.15.1716752602186; 
 Sun, 26 May 2024 12:43:22 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f46ad93c2esm28165935ad.263.2024.05.26.12.43.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 May 2024 12:43:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 34/37] target/sparc: Implement SUBXC, SUBXCcc
Date: Sun, 26 May 2024 12:42:51 -0700
Message-Id: <20240526194254.459395-35-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240526194254.459395-1-richard.henderson@linaro.org>
References: <20240526194254.459395-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/insns.decode |  2 ++
 target/sparc/translate.c  | 14 ++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 2ebee5a1ca..a7720560f8 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -447,6 +447,8 @@ FCMPEq      10 000 cc:2 110101 .....  0 0101 0111 .....    \
     PDISTN      10 ..... 110110 ..... 0 0011 1111 .....    @r_d_d
 
     FMEAN16     10 ..... 110110 ..... 0 0100 0000 .....    @d_d_d
+    SUBXC       10 ..... 110110 ..... 0 0100 0001 .....    @r_r_r
+    SUBXCcc     10 ..... 110110 ..... 0 0100 0011 .....    @r_r_r
     FCHKSM16    10 ..... 110110 ..... 0 0100 0100 .....    @d_d_d
     FALIGNDATAg 10 ..... 110110 ..... 0 0100 1000 .....    @d_d_d
     FPMERGE     10 ..... 110110 ..... 0 0100 1011 .....    @d_r_r
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 242f483fd2..e3e92bcf83 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -515,6 +515,17 @@ static void gen_op_subccc(TCGv dst, TCGv src1, TCGv src2)
     gen_op_subcc_int(dst, src1, src2, gen_carry32());
 }
 
+static void gen_op_subxc(TCGv dst, TCGv src1, TCGv src2)
+{
+    tcg_gen_sub_tl(dst, src1, src2);
+    tcg_gen_sub_tl(dst, dst, cpu_cc_C);
+}
+
+static void gen_op_subxccc(TCGv dst, TCGv src1, TCGv src2)
+{
+    gen_op_subcc_int(dst, src1, src2, cpu_cc_C);
+}
+
 static void gen_op_mulscc(TCGv dst, TCGv src1, TCGv src2)
 {
     TCGv zero = tcg_constant_tl(0);
@@ -3963,6 +3974,9 @@ TRANS(ARRAY32, VIS1, do_rrr, a, gen_op_array32)
 TRANS(ADDXC, VIS3, do_rrr, a, gen_op_addxc)
 TRANS(ADDXCcc, VIS3, do_rrr, a, gen_op_addxccc)
 
+TRANS(SUBXC, VIS4, do_rrr, a, gen_op_subxc)
+TRANS(SUBXCcc, VIS4, do_rrr, a, gen_op_subxccc)
+
 TRANS(UMULXHI, VIS3, do_rrr, a, gen_op_umulxhi)
 
 static void gen_op_alignaddr(TCGv dst, TCGv s1, TCGv s2)
-- 
2.34.1


