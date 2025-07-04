Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54B9AC83F03
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 13:26:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXgPf-0007p1-Ua; Fri, 04 Jul 2025 09:25:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXgPb-0007nu-NB
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 09:25:08 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXgPa-0004zf-15
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 09:25:07 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-451d7b50815so7175185e9.2
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 06:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751635504; x=1752240304; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=WW9Q+1Ychm1T/OrkD3pPeF361asFBCHUsKp/U4TTPHE=;
 b=MOxkIL96LF6fljMBKFLFROPtp+2he+8T8uuPk/c1IM0RdGDQbrBdCHyiySko+Rx4mZ
 OJEf2SCgZWGw3GDSYqTq9xnzBl9Zr6Wm0fHQ8qofiQLJTGyrsZiLwv19jHe6rTDWqYL6
 dE2sxOGBRVwtLedHsY+wMJ+RFpidwbvGrq4haijsXsUyaA4ChbO2eIGQT4xEoxKPmkAu
 jdOpcW2I3jfX4rGZisW8DxGfoplc4KINQeaNpjWEUnHNF1cqqEqi3mSDeAkzjh9d+wgo
 njpTKZWlJHM/jUBpk/WdR7ClbVSCvSHELr+TNl7urpUmko9NuxOjoZ0fYbW7rQj5fHO6
 SZ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751635504; x=1752240304;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WW9Q+1Ychm1T/OrkD3pPeF361asFBCHUsKp/U4TTPHE=;
 b=LokT5JZUKJ1hYWu+WzkGtSlp3sMFbWd6azG6b35Ur7CwS5i6mO2Enokv3W2nPRDsDa
 fiU5jABCT6DBnal9Gs1++Mx9OHmC1E+hAdH9vHbqDgw4kFPPpPxGN5gzp9Qji2DGWzBX
 flbbpeiBAUQ6r9gpgKuaGmJ8SbpnXZc/jCZVtojOklTnb+l7LM+TZ1wOGOyRykj+Zuj/
 9uj/JEBB32n8ykA3O1HI8aKvFphDQMubEeJmZr+xG8TTNgwM2OPjBUG6oMNiKGEu0fxV
 uzUawFsmO5Ap3c5ZaWm//FpLGTtSmbsA5cNKC6HLVKDMycvCFxUjkZB+5bqY9ZmBtRRM
 0tkQ==
X-Gm-Message-State: AOJu0YzgBEf9RRy69i7scpwct3tOu4C1V0RffkjV93/SJhRBcFT9ASjK
 I51HVOqYnjM2HSjeYIBqw2MDGiCX20C7pwVMd8tmNO9gZOnYLw+A2q8X7w66su1G150px++xhKA
 ninnk
X-Gm-Gg: ASbGncvv3iLpAnCTByVJnpMe4LbnqTXYcrSH9zBtRNXER7hI8nSUm5N2bRUB+Z1SrLr
 FCt0NzV9ihqlvR2WUH/DBinYl/omfoCdJYjqexaLa44mEOWqJQ57fckz3wyBpL9o7WdbQ6slHbP
 kz4tO1bhFhmz3671ZVE3PGwSdhol/rLuJQWaWJua5+PuYF4oyYavpUMYhGPyYV7bJJKWdHFNXg5
 P/PdNBwaCerNtde3RE79McntI1j07/hziRZ3q3fLo3jof0RYbAC+QCz340ZifMBeRYXxhdMYhBN
 Vfqeb/Hdt8A7R7+RvEaULlvuqebJUslRDEMF8i9Smi70As7RaegHCPNq+FEFXi/w7QlvdirgQip
 QdsqPpqrULSa7rFoZC9eHTdh1PhvSL8Q6c+rQAlKi2Q==
X-Google-Smtp-Source: AGHT+IHWyc7l6fB1/OjsFh6tNcjcF3ZX87EUB0ejEOCq1gKYFGov54N9uuvu6iaoMT75N8bVFdsCAg==
X-Received: by 2002:a05:6000:3104:b0:3a4:ead4:5ea4 with SMTP id
 ffacd0b85a97d-3b4964c6243mr1942265f8f.24.1751635503974; 
 Fri, 04 Jul 2025 06:25:03 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b47030bd90sm2529450f8f.15.2025.07.04.06.25.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 04 Jul 2025 06:25:03 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL v2 27/36] accel/hvf: Re-use QOM allocated state
Date: Fri,  4 Jul 2025 15:24:38 +0200
Message-ID: <20250704132439.25743-6-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250704132439.25743-1-philmd@linaro.org>
References: <20250704132439.25743-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250606164418.98655-8-philmd@linaro.org>
---
 accel/hvf/hvf-all.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/accel/hvf/hvf-all.c b/accel/hvf/hvf-all.c
index 9e4012e2d10..df95ba74d6e 100644
--- a/accel/hvf/hvf-all.c
+++ b/accel/hvf/hvf-all.c
@@ -251,7 +251,7 @@ static int hvf_accel_init(AccelState *as, MachineState *ms)
 {
     int x;
     hv_return_t ret;
-    HVFState *s;
+    HVFState *s = HVF_STATE(as);
     int pa_range = 36;
     MachineClass *mc = MACHINE_GET_CLASS(ms);
 
@@ -270,8 +270,6 @@ static int hvf_accel_init(AccelState *as, MachineState *ms)
     }
     assert_hvf_ok(ret);
 
-    s = g_new0(HVFState, 1);
-
     s->num_slots = ARRAY_SIZE(s->slots);
     for (x = 0; x < s->num_slots; ++x) {
         s->slots[x].size = 0;
-- 
2.49.0


