Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06CFFC54E49
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Mar 2024 05:21:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgHk0-00030I-G6; Sat, 02 Mar 2024 00:16:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgHjz-0002za-0y
 for qemu-devel@nongnu.org; Sat, 02 Mar 2024 00:16:55 -0500
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgHjx-0007ah-GV
 for qemu-devel@nongnu.org; Sat, 02 Mar 2024 00:16:54 -0500
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-5e152c757a5so1988100a12.2
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 21:16:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709356611; x=1709961411; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2pIlJxFLyrRgHEnS/zal5GTDruioP6mNtA/lWa/a6+4=;
 b=yb1xk0z+x//86oxFVwhRNL+cYsbMhitaBN1j6X+PHye3Q7+JlVmyq1gONT5qkbtwOj
 fin9ktE6gCdEK7EeaGqbxXlLdu+ZulFLs/ATykTsReexkBHZe1FwgeA1JYwfkjwN/8MF
 I4lFgyvQ5kdWYo+bgSl8vzdVMPMGDGkVxCEd3Gp9QxGpPtb+B0H3DPPnSB/aLLW01I4m
 geEtMNUYUHDVtNX+o3/Pul3w2UGtAlh3FgaftaQyCjEVE+kevxhEHn2T0gYFIy5EbJO5
 QynTtdDl0iq+9p50gm+wu9mYudvFrtlwTE4FJrZFRTnv4/PQ4WsNn/tV0dwoAAHhHWEI
 HO5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709356611; x=1709961411;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2pIlJxFLyrRgHEnS/zal5GTDruioP6mNtA/lWa/a6+4=;
 b=bp8ocj2J1/+rFpP6t9St4Jx/yvQTnj4DIFHRlOsF4G6fYVNzBvftDfVJg25jUtnMsV
 pz7OvHRp0nUv7jiP189enJHR6rVw2Xhwequdrgtamr1ILDsxDwG9FaEnPcRZsFAW8O6I
 uhP6cEDuG1hw3pn1oHPzd4McKnTghFAOOcMwH8aOt2CTY5dXnVwkh78RAGUrQt5SSQE7
 mE3CHUM+uZ0f1EoYUSEKbxMYKKEi2IN8CQYn9yQr7or5qiT1a/1CkMOmYBndUMvdtZBT
 e1m/WRK6G4OltRM7h0Yp1AJImzmRkeWTdQKP4HmzpBjz++0Bn+O1BwIq0zXsxJD6oHOi
 3Plw==
X-Gm-Message-State: AOJu0YyuTzqdFg14X/dQslc0rGO9FsDeTMwDyNDUniDwe9yPxcGDOKTG
 Z4Bl8uAyIoaR8lPkIdNi7AxtPIoWC9ft/KKBXKknOna0qzeN1lqZZ1KN4qIHr4Pv2tlimBO/F2R
 n
X-Google-Smtp-Source: AGHT+IGQajDWi6yv+DjC7TFQTBvHwBbphNrV3oLlqka8vhCRanxEA5CU2RdCR0IgkVxPCVeZ49eSqg==
X-Received: by 2002:a17:90b:3c1:b0:29a:6903:e6d4 with SMTP id
 go1-20020a17090b03c100b0029a6903e6d4mr3342057pjb.39.1709356611575; 
 Fri, 01 Mar 2024 21:16:51 -0800 (PST)
Received: from stoup.. (098-147-055-211.res.spectrum.com. [98.147.55.211])
 by smtp.gmail.com with ESMTPSA id
 v8-20020a17090a458800b0029af67d4fd0sm4034901pjg.44.2024.03.01.21.16.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Mar 2024 21:16:51 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk,
	atar4qemu@gmail.com
Subject: [PATCH 29/41] target/sparc: Implement UMULXHI
Date: Fri,  1 Mar 2024 19:15:49 -1000
Message-Id: <20240302051601.53649-30-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240302051601.53649-1-richard.henderson@linaro.org>
References: <20240302051601.53649-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52e.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/translate.c  | 8 ++++++++
 target/sparc/insns.decode | 1 +
 2 files changed, 9 insertions(+)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 8241676174..2d697d2020 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -590,6 +590,12 @@ static void gen_op_smul(TCGv dst, TCGv src1, TCGv src2)
     gen_op_multiply(dst, src1, src2, 1);
 }
 
+static void gen_op_umulxhi(TCGv dst, TCGv src1, TCGv src2)
+{
+    TCGv discard = tcg_temp_new();
+    tcg_gen_mulu2_tl(discard, dst, src1, src2);
+}
+
 static void gen_op_sdiv(TCGv dst, TCGv src1, TCGv src2)
 {
 #ifdef TARGET_SPARC64
@@ -3915,6 +3921,8 @@ TRANS(ARRAY32, VIS1, do_rrr, a, gen_op_array32)
 TRANS(ADDXC, VIS3, do_rrr, a, gen_op_addxc)
 TRANS(ADDXCcc, VIS3, do_rrr, a, gen_op_addxccc)
 
+TRANS(UMULXHI, VIS3, do_rrr, a, gen_op_umulxhi)
+
 static void gen_op_alignaddr(TCGv dst, TCGv s1, TCGv s2)
 {
 #ifdef TARGET_SPARC64
diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index e46c5f7dc4..0cd1cffe18 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -389,6 +389,7 @@ FCMPEq      10 000 cc:2 110101 .....  0 0101 0111 .....    \
 
     ADDXC       10 ..... 110110 ..... 0 0001 0001 .....    @r_r_r
     ADDXCcc     10 ..... 110110 ..... 0 0001 0011 .....    @r_r_r
+    UMULXHI     10 ..... 110110 ..... 0 0001 0110 .....    @r_r_r
     LZCNT       10 ..... 110110 00000 0 0001 0111 .....    @r_r2
 
     ALIGNADDR   10 ..... 110110 ..... 0 0001 1000 .....    @r_r_r
-- 
2.34.1


