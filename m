Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 088DCC8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 16:43:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXjEA-0008R5-1S; Fri, 04 Jul 2025 12:25:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjE6-0008OM-FJ
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:25:26 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjE4-000697-Sz
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:25:26 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4530921461aso8141495e9.0
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 09:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751646323; x=1752251123; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ukiMxm1q7KGMfog7S/dwQl9pKFVx23/cCJZwFH1nOIw=;
 b=WlkNBCwJ0g9me59WWnxX5jigumOUn/zf2lD6jVmUH2jR+ppHROITU2LgJ+5L7MeEmN
 +C61vRC/+fFsAl41JUzVOF83Tc9N+v9JdAB8QSsFlR4t9pvWWrwAJojYQO5lcVCrkaE1
 sTNRA8y8st/yMR4XwEH+pXLgZhMlGySBsiPcb9YGJSl/Efisx3nJ6hlBogEOnzIBATR7
 CKjs9CYv3jtntzEaVi2eAcBw/cWTmvAZDgbbke8a6fVCEpydqES1bSpfnVMSFhNsYv44
 mcE99wBckCuYooYOusRjHZA2YwqeuQ1+gISG7NqL4VahDQ/sA+joZfSLdgKuWz3sthmq
 cMfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751646323; x=1752251123;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ukiMxm1q7KGMfog7S/dwQl9pKFVx23/cCJZwFH1nOIw=;
 b=OIQ26MBWofbLpbjnpZarpM2nDLxf7aJzIte/flwHnfr1Z7FqO0zh4NrnEdWfigwwUL
 Gi18pZux7UeSp1p/6rPd5BsnghuvLd1sXN7iWkklA4PD2FrPAM45MVsK5bw5bnxkJnLe
 dUCnFBvIWrw2j9cfVKwZZPBkRvhUYB9lDnqlt5D1IZJynq2pNxQA+4FCgTKyImwqgQ0U
 OJeg3oCx8x9ZB/+cdbeRLLmqEVhB/aK/Z4PUppkXPuy1TUjdcNIQ4PUy0HvgVd4Hn5jl
 YVtwurfbMYpEefKTQMcK8jGGfkiCmPIzJ78in13YR8RfxIku7qsn6Fh6pYmXrdB2LDV5
 D4dQ==
X-Gm-Message-State: AOJu0Yy0uX/FNKSrAVUG7hwkshsLlX+qVas638wT+VsWMN+EI7OqMQvp
 qU0FX8s6DHdsPMUDkgKowql/8teFvfPCDOU5XRe/hBPWZXo0aZxJ/36TAUdjgQ/V4FUVZkgD/lK
 xXTQi
X-Gm-Gg: ASbGncvcPf05m1cSaQaj1lxfxphNkO1380G+kTdvh+kdKA5yUpsM9TKu02tmExTalYG
 X82JhU2jl9ByE8iIoldQDwf9dViEhSL0D0yq5mcSM1aNXqYVLKKnB79zXmTb5R9Q93govenU0hT
 HBhHbdUivJKV1jGmtw51d3PZqTKm8RFdAiVInxpQueWZgHr1M5lb1pBhnjOOP0OYPBQR9ihix40
 rIOqOWHddvGQMWn2DmPJrmwET9PQteEDBcAQgWt7BCo5jI09M2O2nRM+4C4phuybISlwsFQWD9z
 Mcv9vI12DPXQilOwernupEvgWmIRj3fZTUn9Qvf2AqJpxKlibuiESKbu/Se0Gi+DDwMuaOmjxUm
 /v6M=
X-Google-Smtp-Source: AGHT+IEh/nGDsTe8Kpg/hNtIdCrsaGb80cDcaEPyN4DUHjNNQAsKXnhVQhR2D0gu6IJwX7LdZl5OCA==
X-Received: by 2002:a05:600c:3b12:b0:442:d5dd:5b4b with SMTP id
 5b1f17b1804b1-454b3126091mr36589785e9.31.1751646323321; 
 Fri, 04 Jul 2025 09:25:23 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b471b96534sm2816857f8f.48.2025.07.04.09.25.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 09:25:22 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 022/119] target/arm: Remove CPUARMState.vfp.scratch
Date: Fri,  4 Jul 2025 17:23:22 +0100
Message-ID: <20250704162501.249138-23-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704162501.249138-1-peter.maydell@linaro.org>
References: <20250704162501.249138-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

The last use of this field was removed in b2fc7be972b9.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250704142112.1018902-11-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 03381539238..96a49072665 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -669,9 +669,6 @@ typedef struct CPUArchState {
 
         uint32_t xregs[16];
 
-        /* Scratch space for aa32 neon expansion.  */
-        uint32_t scratch[8];
-
         /* There are a number of distinct float control structures. */
         float_status fp_status[FPST_COUNT];
 
-- 
2.43.0


