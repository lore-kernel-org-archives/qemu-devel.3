Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89707CA1013
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Sep 2025 11:53:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uuUzC-0001eQ-J2; Fri, 05 Sep 2025 07:52:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uuUyy-0001bF-IH
 for qemu-devel@nongnu.org; Fri, 05 Sep 2025 07:51:56 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uuUyi-0003Yq-JE
 for qemu-devel@nongnu.org; Fri, 05 Sep 2025 07:51:56 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-45b89147cfbso22028815e9.3
 for <qemu-devel@nongnu.org>; Fri, 05 Sep 2025 04:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757073094; x=1757677894; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tmFgSmczyo5Sgsms5P8rKy808EH5x+SNkSDEiE+RR/Q=;
 b=X4fRcVNvfizf8pFd5dgaQJT39RTcb4fZkjMQZ1BBQsw2DVegHX00DY8wtiJYTdXg1V
 C4By/nsEM+cg+nMaXjNjiCZwh69lLOEBUU14kpLiIXrfkEPfNBBcUtsOvfyTF3AFOOBk
 9woXHPR9o4n+un8oEU34xQmpYiuRYsTE0hxQxe4K9E3dHEEE/rkFuC0IYMkC53tJWzdK
 peynfbpVAyQlWfJDDkchjhFiDOVMdpYPy7jC1q6SLZ625etmHFtaejgYQl7TQbOWQ9AS
 Ja+e+QzZKkjcPIR4Qzw15nSC8WLzMCqFRCUu4nJDBTAyw1SSRiBXzmKjZ4AcDDiZ/Wnh
 59OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757073094; x=1757677894;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tmFgSmczyo5Sgsms5P8rKy808EH5x+SNkSDEiE+RR/Q=;
 b=ZGt4UTVu1EcDc/Wnv8/4mWK8XdDf/MmIlXTXInA72vy3WDlhbX8dcR1vbB61HgzAAB
 N/H02Fd6nv8/Crh/Ib5jjl0dRxxdSyINmPA+RSBV7CmXW3uxWBDpOk71kwxnQZpQvceP
 IBs7h/NcWHw8fVGgvZTsc97uGF0zjR5ZJaEBPVabtGhQ4ApXkDS6WMUrVjUdoaMDZkAy
 rsJzyNWi5/SuNpsR4JLs5sqKOApKT/Ir+us9yQSxhN02t4R5y1Jv7/xFwDM3D8pstwvJ
 ZFcc4I+0s/6atP6BR8vYmm0VymqckY4OSx+dHCiAkk2lh5TpluSgSwvAbOGRwc0wrFsQ
 GqTQ==
X-Gm-Message-State: AOJu0Yxp9ex/8QqvorEIWBJGOmFiL0o5vlyVAvHtlPwN1pBu7kGvt6xv
 3sw593HZR+Tc/9rF2l4zymTgnJyAGKNC15qNPxWELwoczAdcwS4WQfx9Vg70EWcc1fXMMGpiT01
 bmLa3OKI=
X-Gm-Gg: ASbGnctVdaTZcG+tRaJyIxOalaOpRxwYy5ZKL7L9MzP1Ik1qolifhcGwu3rkJfNWb61
 4uSd0cjB3bTJH03tEsk76Ppsa+WrG49ENQa3j6eacmmiHZBmNE8EfFHf/OTa/8LlqtqIcVdE6n2
 SWYRgcX4IrseOAQ6Ur7J/mgAAycDwdNY3jQ7v0/SSlofc4VFSu7R8rw0aDoz03O1imaue21xsxK
 cqqgjltobiSE80JB02FlRzRGihCDPgV8Md9Kmsov/iz43SpgbQB0GCKHbaaVoo4Qp58iKyeUQNt
 N/1+B0sPo8/jPP+an1ppib0bEhQGEh+usk19Ag5HAM3sb6SgXZ+FTdaLK9tT3FaS3Wi661Tax+F
 5HT48WRpFMzg1l2rmQC1oHVwH46FIB9JSQtcveV8TIKpXYWvvkifelVeW
X-Google-Smtp-Source: AGHT+IFyGXYhD20UtGaA5U0F9zMDVVkyRZsSiLNMSLCeuF4/KYtNxfutMPtKdbxW0eKig8fQpF9mPA==
X-Received: by 2002:a05:600c:a43:b0:459:d3ce:2cbd with SMTP id
 5b1f17b1804b1-45b8556a7acmr186011435e9.13.1757073094158; 
 Fri, 05 Sep 2025 04:51:34 -0700 (PDT)
Received: from stoup.dot1x.polimi.it ([131.175.126.3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b8f2d3c88sm194285115e9.19.2025.09.05.04.51.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Sep 2025 04:51:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk,
	atar4qemu@gmail.com
Subject: [PATCH v2 5/7] target/sparc: Loosen decode of RDWIM for v7
Date: Fri,  5 Sep 2025 13:51:26 +0200
Message-ID: <20250905115128.376295-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250905115128.376295-1-richard.henderson@linaro.org>
References: <20250905115128.376295-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32b.google.com
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

For v7, bits [18:0] are ignored.
For v8, bits [18:14] are reserved and bits [13:0] are ignored.

Fixes: 5d617bfba07 ("target/sparc: Move RDWIM, RDPR to decodetree")
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/insns.decode | 40 ++++++++++++++++++++-------------------
 1 file changed, 21 insertions(+), 19 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 1c6403ad8a..77b2f54fdf 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -180,26 +180,28 @@ RESTORED            10 00001 110001 00000 0 0000000000000
 # UA2005 INVALW
 
 {
-  RDWIM             10 rd:5  101010 00000 0 0000000000000
-  RDPR_tpc          10 rd:5  101010 00000 0 0000000000000
+  [
+    RDPR_tpc            10 rd:5  101010 00000 0 0000000000000
+    RDPR_tnpc           10 rd:5  101010 00001 0 0000000000000
+    RDPR_tstate         10 rd:5  101010 00010 0 0000000000000
+    RDPR_tt             10 rd:5  101010 00011 0 0000000000000
+    RDPR_tick           10 rd:5  101010 00100 0 0000000000000
+    RDPR_tba            10 rd:5  101010 00101 0 0000000000000
+    RDPR_pstate         10 rd:5  101010 00110 0 0000000000000
+    RDPR_tl             10 rd:5  101010 00111 0 0000000000000
+    RDPR_pil            10 rd:5  101010 01000 0 0000000000000
+    RDPR_cwp            10 rd:5  101010 01001 0 0000000000000
+    RDPR_cansave        10 rd:5  101010 01010 0 0000000000000
+    RDPR_canrestore     10 rd:5  101010 01011 0 0000000000000
+    RDPR_cleanwin       10 rd:5  101010 01100 0 0000000000000
+    RDPR_otherwin       10 rd:5  101010 01101 0 0000000000000
+    RDPR_wstate         10 rd:5  101010 01110 0 0000000000000
+    RDPR_gl             10 rd:5  101010 10000 0 0000000000000
+    RDPR_strand_status  10 rd:5  101010 11010 0 0000000000000
+    RDPR_ver            10 rd:5  101010 11111 0 0000000000000
+  ]
+  RDWIM                 10 rd:5  101010 ----- - -------------
 }
-RDPR_tnpc           10 rd:5  101010 00001 0 0000000000000
-RDPR_tstate         10 rd:5  101010 00010 0 0000000000000
-RDPR_tt             10 rd:5  101010 00011 0 0000000000000
-RDPR_tick           10 rd:5  101010 00100 0 0000000000000
-RDPR_tba            10 rd:5  101010 00101 0 0000000000000
-RDPR_pstate         10 rd:5  101010 00110 0 0000000000000
-RDPR_tl             10 rd:5  101010 00111 0 0000000000000
-RDPR_pil            10 rd:5  101010 01000 0 0000000000000
-RDPR_cwp            10 rd:5  101010 01001 0 0000000000000
-RDPR_cansave        10 rd:5  101010 01010 0 0000000000000
-RDPR_canrestore     10 rd:5  101010 01011 0 0000000000000
-RDPR_cleanwin       10 rd:5  101010 01100 0 0000000000000
-RDPR_otherwin       10 rd:5  101010 01101 0 0000000000000
-RDPR_wstate         10 rd:5  101010 01110 0 0000000000000
-RDPR_gl             10 rd:5  101010 10000 0 0000000000000
-RDPR_strand_status  10 rd:5  101010 11010 0 0000000000000
-RDPR_ver            10 rd:5  101010 11111 0 0000000000000
 
 {
   WRWIM             10 00000 110010 ..... . .............  @n_r_ri
-- 
2.43.0


