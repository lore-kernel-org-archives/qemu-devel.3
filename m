Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBFFCC83F09
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 16:28:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXjF8-0002X9-3u; Fri, 04 Jul 2025 12:26:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjEo-0001Qw-Ue
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:26:11 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjEm-0006Wr-PD
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:26:10 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-453066fad06so7825685e9.2
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 09:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751646367; x=1752251167; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=GLTs7NrGcuBQI/bwBvnL5DbR65mtOHfwnrEp9sy1wk4=;
 b=z6QBiw0el6rMsppLO/fgbuoKWxRMLaxtGUbYFFTdUK3gerkogdPuZrrDJglYqpl1/n
 Ocr8ETtikKGb0uAn50pqMXQQz7CtWVWTsBSnGTFh3eH/cFbRMBHyeUMXVzaEEp1yD+cZ
 GRWAvTWrVBOoUZzd1PKmAl+8I0ZUxQ2qOhYI18Wdk4vz1uiz0PWYztrUAkqn3U7LsUrK
 naBQCPajBiq1PqXoww4M/NQQhmE9YZXfWA9Un7oUB+oz7IOzV5ZLxgCfBwceVMMcCuQ2
 p7zitQbCSnTQJL/dxnpFcy0u7oR/MphdmdG3JstUhM9yny6+PUHwqRm0EWtgKvWkDgMd
 Ty+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751646367; x=1752251167;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GLTs7NrGcuBQI/bwBvnL5DbR65mtOHfwnrEp9sy1wk4=;
 b=WBYLeGU86WT5GFCmMq5wc2Gk0UiExdIY6TxmawIYLZwZK/O61WwgbuyBtxB5LTQBIF
 /KNvhHTBu0wbmwOWmA29KMBZM+YUVLTu4fQkS38CC/NLLu7oarFCyPUz+2hxmrW61ajN
 GntEcwCZbQfletCBzc+xM0DdO93VLNqBLCgtVdTbf9ofJtPNf4DFc+nBYK6kcuFO9nQc
 +1e6JYq451Ca3xHRUoP1PCJ4+epNXVZE3Hl6EYC9RIyOpeGAyTPVCIxkUCcPxtcv2YnM
 beCrFg2JjFqwVA95fbWQGkYdy0rWLksKUvAZpXxDvMIvaom2TY0nJNQbLpyuzzF3fy81
 iitw==
X-Gm-Message-State: AOJu0YyHeEUI1YAWuFIyRBre5rraO2jqLvNkDWWmKqXoxPCUD4fS1jcV
 h39/Mnk4JgTRrbmGSj7OOqaRQHJz3I08Gh1VNtOjyOHmkr94Mf9qACGYcVFYRNtXSOyQfCJ5L9U
 MtT5z
X-Gm-Gg: ASbGncthEM+NY8y1KMimx1arV/+lfQ3zLPVma3QFtBMeVbEzVvutvAibMNgcK8wuWvF
 7nLnzuKIcYVXEP64yrO4MWy6rxA9b63WnWiqteiliuyK5kZs/Jmsukv0VfwcmaP7yED1VaFYFRX
 55WZTAt4UBoist9TTZPCJHm5TbDXJXR6iEd9Fnk5XDc8RI7FnQUmlEI8uX9ovI2cXOl0exmnU53
 ym/JwyIq/gUGOlM7nKkFSxYes2tp1gR5suRMNU6OFYUxLmxihIRg+KroNZi22wRpATPk1EZoSjR
 +LHOpbfGM/IhBpqXcRpfsjQohvMBBQ4+cM57TfzyhYWGVcn/34op7vF1bV9OwdqWpK8l
X-Google-Smtp-Source: AGHT+IFdNAEHs18NEH85te2Im29CN5cEyTbMYbFw7HQpg7iP1qDl9zam7I0rxlPTt1PNtAH8v8swLw==
X-Received: by 2002:a05:6000:2890:b0:3a4:cbc6:9db0 with SMTP id
 ffacd0b85a97d-3b4966046e2mr3240398f8f.51.1751646367331; 
 Fri, 04 Jul 2025 09:26:07 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b471b96534sm2816857f8f.48.2025.07.04.09.26.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 09:26:06 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 068/119] target/arm: Implement SME2 FRINTN, FRINTP, FRINTM,
 FRINTA
Date: Fri,  4 Jul 2025 17:24:08 +0100
Message-ID: <20250704162501.249138-69-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704162501.249138-1-peter.maydell@linaro.org>
References: <20250704162501.249138-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250704142112.1018902-57-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/sme.decode      | 9 +++++++++
 target/arm/tcg/translate-sme.c | 9 +++++++++
 2 files changed, 18 insertions(+)

diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index 449d97bd28b..9cc25622d4c 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -751,3 +751,12 @@ SCVTF           11000001 001 00010 111000 ....0 ....0       @zz_2x2
 SCVTF           11000001 001 10010 111000 ...00 ...00       @zz_4x4
 UCVTF           11000001 001 00010 111000 ....1 ....0       @zz_2x2
 UCVTF           11000001 001 10010 111000 ...01 ...00       @zz_4x4
+
+FRINTN          11000001 101 01000 111000 ....0 ....0       @zz_2x2
+FRINTN          11000001 101 11000 111000 ...00 ...00       @zz_4x4
+FRINTP          11000001 101 01001 111000 ....0 ....0       @zz_2x2
+FRINTP          11000001 101 11001 111000 ...00 ...00       @zz_4x4
+FRINTM          11000001 101 01010 111000 ....0 ....0       @zz_2x2
+FRINTM          11000001 101 11010 111000 ...00 ...00       @zz_4x4
+FRINTA          11000001 101 01100 111000 ....0 ....0       @zz_2x2
+FRINTA          11000001 101 11100 111000 ...00 ...00       @zz_4x4
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index dce3b56de2f..4fbc61ae272 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -1375,3 +1375,12 @@ TRANS_FEAT(SCVTF, aa64_sme2, do_zz_fpst, a, 0,
            FPST_A64, gen_helper_sme2_scvtf)
 TRANS_FEAT(UCVTF, aa64_sme2, do_zz_fpst, a, 0,
            FPST_A64, gen_helper_sme2_ucvtf)
+
+TRANS_FEAT(FRINTN, aa64_sme2, do_zz_fpst, a, float_round_nearest_even,
+           FPST_A64, gen_helper_gvec_vrint_rm_s)
+TRANS_FEAT(FRINTP, aa64_sme2, do_zz_fpst, a, float_round_up,
+           FPST_A64, gen_helper_gvec_vrint_rm_s)
+TRANS_FEAT(FRINTM, aa64_sme2, do_zz_fpst, a, float_round_down,
+           FPST_A64, gen_helper_gvec_vrint_rm_s)
+TRANS_FEAT(FRINTA, aa64_sme2, do_zz_fpst, a, float_round_ties_away,
+           FPST_A64, gen_helper_gvec_vrint_rm_s)
-- 
2.43.0


