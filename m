Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52456C25B75
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2024 19:39:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBJfx-00083G-NW; Sun, 26 May 2024 15:37:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBJfs-00080m-Oh
 for qemu-devel@nongnu.org; Sun, 26 May 2024 15:36:56 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBJfn-0006Un-Vu
 for qemu-devel@nongnu.org; Sun, 26 May 2024 15:36:56 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2bd816ecaf5so3887774a91.2
 for <qemu-devel@nongnu.org>; Sun, 26 May 2024 12:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716752207; x=1717357007; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GEBoMRZh+rveSplqLYLI6+ctFatZbLOW7sw1XZCiSUU=;
 b=UM4wH2byL0p20Re2t/ND9+zNxjWVF2m8wwDoKnXV7RJGqcG4FQ37EEVpXPbNkvMsL5
 GO5xiX/mQmVqtokMv6SF7DtVRhkYpNQ8ZHGQIfnBRkYf4JKBqqltsi4WBeqm58P1q+YZ
 5A96xcwDMgzNed3/dmIZ5/pZU6HwkX6BHmX18mAJivXGEm4ZtSeiz1bF7QIP3B9nSZVB
 Dw8zT7EcxXkzF9tGSCxWwX94Sjc02UNZwiaiZjjoZDJwRGXmfjDKya5osmCgJamI4XkU
 m3yWxi5G0AaK5MP6U9O3K9+wF83moVkL1IaFMKXV7uT3u20Lq2p343+YC77q5p0Sj6uv
 KHBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716752207; x=1717357007;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GEBoMRZh+rveSplqLYLI6+ctFatZbLOW7sw1XZCiSUU=;
 b=Bt1udPzwZmZC9BJYuqPXWklxVExGhASfnqumkT9kZzBKZ7QRYTj1nQqw9xx9PhPjGB
 vXBfABkFMnvodNKhGjVhwow4IHaQ/p0u994rqjSUW1a841y+QQzabaO2kOPIbW/tVSPv
 V/ygTUg+KUwKb3lXm7b+oFyxxkTrKk7DQi+sfQUln2f08RyLds72iUvQHetbNKXyHaHD
 Ok/PyyAExUTf/++qTyCQRvNU67CT5qdHEWsUgKc4ErZrKA5uE13ldYCFdXS4RrTOEG7j
 bIT4ej5jv1Rt6nLA7IJCGzrccCn30AskY7WYdILhfyeZ2sMmQxulMGNIS7VIeHLvwRXh
 AF8g==
X-Gm-Message-State: AOJu0YxvlfCrmsoUsFYoTYufi4shSurIOe4Z1ldY7wN/WtGp6IRnDiTA
 Sn2azFrlwyozyfaA+E6e8useQMlT4LnMc0rvL1sm55s1ti8fJUSyxZix2N4QE1S7LZEiCxe3xXh
 w
X-Google-Smtp-Source: AGHT+IFaBMiGQR/FqIIB0AMESRc6w8CGBO54oGIjC7Lkp4b3ppaj6xX0zIHNLGqt5Nmg5oD6cX+MwA==
X-Received: by 2002:a17:90a:bc92:b0:2bd:f1d5:8e3f with SMTP id
 98e67ed59e1d1-2bf5f4073bcmr5977013a91.41.1716752207086; 
 Sun, 26 May 2024 12:36:47 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2bf5f6155b6sm4943761a91.29.2024.05.26.12.36.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 May 2024 12:36:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH RISU v2 10/13] sparc64: Add VIS2 and FMAF insns
Date: Sun, 26 May 2024 12:36:34 -0700
Message-Id: <20240526193637.459064-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240526193637.459064-1-richard.henderson@linaro.org>
References: <20240526193637.459064-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102f.google.com
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
 sparc64.risu | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/sparc64.risu b/sparc64.risu
index 10a8510..5b90b70 100644
--- a/sparc64.risu
+++ b/sparc64.risu
@@ -119,3 +119,39 @@ FEXPAND         VIS1 10 rd:5 110110 00000 0 0100 1101 rs2:5
 # ALIGNADDRL    VIS1 10 rd:5 110110 rs1:5 0 0001 1010 rs2:5 \
 #     !constraints { reg_ok($rd) && reg_ok($rs1) && reg_ok($rs2); }
 # FALIGNDATAg   VIS1 10 rd:5 110110 rs1:5 0 0100 1000 rs2:5
+
+#
+# VIS2
+#
+
+EDGE8N          VIS2 10 rd:5 110110 rs1:5 0 0000 0001 rs2:5 \
+    !constraints { reg_ok($rd) && reg_ok($rs1) && reg_ok($rs2); }
+EDGE8LN         VIS2 10 rd:5 110110 rs1:5 0 0000 0011 rs2:5 \
+    !constraints { reg_ok($rd) && reg_ok($rs1) && reg_ok($rs2); }
+EDGE16N         VIS2 10 rd:5 110110 rs1:5 0 0000 0101 rs2:5 \
+    !constraints { reg_ok($rd) && reg_ok($rs1) && reg_ok($rs2); }
+EDGE16LN        VIS2 10 rd:5 110110 rs1:5 0 0000 0111 rs2:5 \
+    !constraints { reg_ok($rd) && reg_ok($rs1) && reg_ok($rs2); }
+EDGE32N         VIS2 10 rd:5 110110 rs1:5 0 0000 1001 rs2:5 \
+    !constraints { reg_ok($rd) && reg_ok($rs1) && reg_ok($rs2); }
+EDGE32LN        VIS2 10 rd:5 110110 rs1:5 0 0000 1011 rs2:5 \
+    !constraints { reg_ok($rd) && reg_ok($rs1) && reg_ok($rs2); }
+
+# %gsr not handled by risu
+# BMASK         VIS2 10 rd:5 110110 rs1:5 0 0001 1001 rs2:5 \
+#     !constraints { reg_ok($rd) && reg_ok($rs1) && reg_ok($rs2); }
+# BSHUFFLE      VIS2 10 rd:5 110110 rs1:5 0 0100 1100 rs2:5
+# SIAM          VIS2 10 00000 110110 00000 010000001 00 mode:3
+
+#
+# FMAF
+#
+
+FMADDs          FMAF 10 rd:5 110111 rs1:5 rs3:5 0001 rs2:5
+FMADDd          FMAF 10 rd:5 110111 rs1:5 rs3:5 0010 rs2:5
+FMSUBs          FMAF 10 rd:5 110111 rs1:5 rs3:5 0101 rs2:5
+FMSUBd          FMAF 10 rd:5 110111 rs1:5 rs3:5 0110 rs2:5
+FNMSUBs         FMAF 10 rd:5 110111 rs1:5 rs3:5 1001 rs2:5
+FNMSUBd         FMAF 10 rd:5 110111 rs1:5 rs3:5 1010 rs2:5
+FNMADDs         FMAF 10 rd:5 110111 rs1:5 rs3:5 1101 rs2:5
+FNMADDd         FMAF 10 rd:5 110111 rs1:5 rs3:5 1110 rs2:5
-- 
2.34.1


