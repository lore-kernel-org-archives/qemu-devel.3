Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0215BCF2594
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2024 10:51:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0Iez-00040F-KD; Mon, 14 Oct 2024 06:50:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1t0Ier-0003z8-3x
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 06:50:37 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1t0Iep-0006Ui-5a
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 06:50:36 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a99f3a5a44cso192967266b.3
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2024 03:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728903033; x=1729507833; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=FqdRX8rWWQZot3qHzNkktBViXx6N2VJ6p90ru7IT+NI=;
 b=tPc/oLo0tGXTA8NjOUm0VZ2RBQJOxRkGa3Th/tQizfwwRsROfHRVg7HLbrR7RL3vlD
 WBQFXCwDt7YrZnPQ5L0ZuYaTemTc/c96eX83IhTpGApusce0pwU07DVBEPu8ZJmCzqqb
 2OWFrqLfkbY0rNLDsJzITteoDkL6VmAPDNCxvKSp17PGXDDwbgd6ow5H0cJTy2T/Q9OV
 Aff94DDdmLF3sGWtDCU5ZbLnMl5FxKQpueNQJZEwKORRP/s1ZQlzbv8lNusWqsYttdWH
 OZT+i25l3hZCyPdLkbteDfzxv/0N3Na6qkGp0CGl75VBt7VdwY0vCaPOMbyToGSidEGm
 0oNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728903033; x=1729507833;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FqdRX8rWWQZot3qHzNkktBViXx6N2VJ6p90ru7IT+NI=;
 b=HVknKbg6nt6VVrIiyNHBDcVJkJsx4bdN91jJxPWatuzHtE6/WUvyF8yikuL8Avn0y9
 nfuFPjZGyHlYbHbhWJBXCOjCVSnFOn7t80zVSYux2rBfIFA9s0kd4QpLeyhnhVq5Dtog
 hv5I44crLjOTKIT8vO1MThdsrzqTOoMA0OnkBK/kW+7RR8+sWcFDAPNksLilPmkF8GNi
 GLSQMADaLDRvkpG372gHq550JtUDYCCHpcWVVhmzCSWRWrMYgxVxf7FcfQzBLUQUXod9
 uJHIQQSMsqL87MjVDVvk47fynt/FOhQn4lDHQLEKxBwrY+hdpbd9SAO4vwver8yg3cK3
 FXKw==
X-Gm-Message-State: AOJu0Ywc2wgQDLDt3DbJU1hTshNsiUkWNJC75GataC75aVU022kewr0d
 qQFwrB/VNlbgcvGtiFRB9VkAyPjgWLzOdAIJIXVC+yaAMdoZnU9e1gWrNQeYe4o=
X-Google-Smtp-Source: AGHT+IF7a3gyonK7erAu2Lr80dwg2xpqsW1Q8UbXgei298s+csdB/pwENeHJR2f9OHuZsBLNOAV/TA==
X-Received: by 2002:a17:907:948b:b0:a99:8378:b939 with SMTP id
 a640c23a62f3a-a99b931457amr1176555366b.2.1728903033348; 
 Mon, 14 Oct 2024 03:50:33 -0700 (PDT)
Received: from [127.0.1.1] (adsl-161.109.242.225.tellas.gr. [109.242.225.161])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9a0b25226esm165504466b.59.2024.10.14.03.50.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2024 03:50:32 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Mon, 14 Oct 2024 13:48:57 +0300
Subject: [RFC PATCH 3/4] arm/tcg/cpu64: add FEAT_XS feat in max cpu
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241014-arm-feat-xs-v1-3-42bb714d6b11@linaro.org>
References: <20241014-arm-feat-xs-v1-0-42bb714d6b11@linaro.org>
In-Reply-To: <20241014-arm-feat-xs-v1-0-42bb714d6b11@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
X-Mailer: b4 0.15-dev-12fc5
X-Developer-Signature: v=1; a=openpgp-sha256; l=866;
 i=manos.pitsidianakis@linaro.org; h=from:subject:message-id;
 bh=2P48Fv5+Lkmmjb718r2nmwRh4AwjSWhQm01a98g8ng0=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0VCYlFLUy9aQU5Bd0FLQVhjcHgzQi9mZ
 25RQWNzbVlnQm5EUGQxUTdudkxadVgrUDVnTFJNbUxaUWMraGV6CjhmNVhNeEM4bDZ6VTRKdEdh
 U21KQWpNRUFBRUtBQjBXSVFUTVhCdE9SS0JXODRkd0hSQjNLY2R3ZjM0SjBBVUMKWnd6M2RRQUt
 DUkIzS2Nkd2YzNEowTkg4RC80a3JuSDZ4NVJ5NURFMXZNL2VuR25uNGtUSkNWWExQQUlHM3lYMw
 pKOVNxZFdvYi9WdFRraDMzalVlTFVVbU9WUnJjY1ByNXVXdEgxSmlEclFZNG82SnNsZnFIUnErQ
 nNoVmFNZzZNCjJGeEdMVUl4L0dzaFlyazBNTndKVjUxU3AwYWJHeHpyYjNTOHJxemh4YWxZN3Yy
 bXEwV1Ayb0hvVGdOcW5ZNisKNEZkVE5Nc09KMmJJYmUwODZ6Z2REVVMxeVY0N0pFWEZPaGZoc0R
 iMDYvNGNLMnJtY29ZS24zenkrak1NVmFmQgpGSDZ6OWdjVWxVcUhiL1h0bURFOWcrT1ZDbXZvSH
 FVZFFNbTZxdkxFVERNT1VPSnBjWUlIV1JNbkRIT0NIM0pECjIwUGdGYkdtM2FEQnVDcnBhZW1lU
 2Z5aVlRVlBkOXNXVldNYTdYNUJsaGhsM2IrOEZ6VnVTMStBSTM3Um9ZMncKVUNtL0JObkVaWVBr
 QXlwa1NaZzNCNWNUVmJtUWlOc1l3b1l0RG1mY1lYM0VkeXBucXJyanIraHhlMGJYSktEUApVQTJ
 0OFJWWmNDVTY1N0hWM1EzMzVSc2IyTkxNWWJ5RkJNeUhqeTBkVjhOTXY1emJSaXk0b0pzNTA2OH
 NSZS9RCm1JSHNyeXZOeTZwS2E5ektNZ3V1RUhtSE93MGQydzRCNmZIZk9MYnhHbUw4dXEvV0t5M
 FBLK2NYTFZCdERqYkUKdzZGQk5UQ0hKT3ZwemMzS0l5QkowZXZ1cm8vaTk3OFNQVGRBT1kxdHlV
 U3YwN1dWWVZvWHpDaTBwb1FPMUw2RAp3em8wSEwxNUVNWDFVcE1QLzFPQ0huMVdIM1NLRkFJNWh
 SRzhQMXFkQ3ZJNUx5UUM0UHhrT2t1aWMzcjFTQ2x2ClNXaTlsUT09Cj1HaWVMCi0tLS0tRU5EIF
 BHUCBNRVNTQUdFLS0tLS0K
X-Developer-Key: i=manos.pitsidianakis@linaro.org; a=openpgp;
 fpr=7C721DF9DB3CC7182311C0BF68BC211D47B421E1
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x632.google.com
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

Add FEAT_XS feature report value in max cpu's ID_AA64ISAR1 sys register.

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 target/arm/tcg/cpu64.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 0168920828651492b1114d66ab0fc72c20dda2a8..8c8f88d84151952872f1b1987e98d789b501fb23 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1163,6 +1163,7 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = FIELD_DP64(t, ID_AA64ISAR1, BF16, 2);     /* FEAT_BF16, FEAT_EBF16 */
     t = FIELD_DP64(t, ID_AA64ISAR1, DGH, 1);      /* FEAT_DGH */
     t = FIELD_DP64(t, ID_AA64ISAR1, I8MM, 1);     /* FEAT_I8MM */
+    t = FIELD_DP64(t, ID_AA64ISAR1, XS, 1);       /* FEAT_XS */
     cpu->isar.id_aa64isar1 = t;
 
     t = cpu->isar.id_aa64isar2;

-- 
2.45.2


