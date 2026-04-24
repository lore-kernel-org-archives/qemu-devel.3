Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A759FB44A5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 04:32:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wG8Bu-0006BT-IE; Fri, 24 Apr 2026 00:30:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wG8Br-000619-Ti
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 00:30:55 -0400
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wG8Bq-0002eM-B9
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 00:30:55 -0400
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7dccda31d3eso1538823a34.3
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 21:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777005053; x=1777609853; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VfNScWpB7q780oJkpTFR+sWvykva2u51oGRZh7kaCOI=;
 b=xp6UhYhlET2looQkNefUAs4LkaItHUEbKzM2/qbfFbAYjg62fexR9i/kfftICRWlsT
 q33zact+hwsnE+8Cj7rwEO/C9v3Qn3rrArJn9Qe/AaeoIq1DfKt/qElx0rf2N37B07HZ
 51tXpt5rM3acxZG5UoQEze9+zj2oSrGk3kKzlm3+jl1QrFUhjGvBoJJ/otjgUIvhNpqi
 3+W03dPF5IlC999zzTB7KoTUI6FLN+Ckky8cYSjkTrcOCMjeDfN9mcQ/e/gSNh4x1Ew0
 EBMS5THrp0xJ5R5NTi2uZNfgq7mIW+SOlUxohihMbXjm57L9/JFWpt4TBYrjyvYbYQ1+
 JEEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777005053; x=1777609853;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VfNScWpB7q780oJkpTFR+sWvykva2u51oGRZh7kaCOI=;
 b=Gc86kwr7FhWjAfVSkcZJQ6F8BbkrOEffzSG7O0fymoCCWlJJy3lAKEQfg5fCy0i9D7
 bUn7vNsaX3gBs4C/V4x99De0YZd2LZhjQ7UZ/F6NK+ag4QyFYQb5MMwAueODqkwfpdbE
 Y0qUdwXApTNCiMYcGJZ8S3q8dsXeC4mU+rBi3r9xw37xZLgxI3UNWwz5X+A7op/947u0
 ipZz7pW/t1B1IuI3E2rPgJhCt/lCIEyhzvIC28xx0OAGGH2yuMnCNg7apj0Lw8Ft4Du4
 ChK2yajr5G7us0sUldW+vlR4kHdTVw+JEaVRMH9jOWL1i+RwQyqfWScvCO/lKeM+nJIu
 4dCw==
X-Gm-Message-State: AOJu0YyhlWd0GquSohw6XcCJSq6rA9RBpAREmEipW4qEiJc2/3SBDyGP
 qNeFlBIg+S8IuSUclboYt05j7JVEGtuRjBTxmY8CJ8j9kwa5gaxMCb9DD9fh+y5CSxnojIKm3Re
 u4K4kDMM=
X-Gm-Gg: AeBDietuNhD6Id5gIyhRFlYjz3rcewdOCYziGwVCnQq0tuWL3LUTZARuitfmuT2NijD
 OwVIPFPaUHkCT8XaEe3yD0AE/0TrjAZah8ye1OT8K37ojVPfhAYopn3VEMfTyC7pdms2RMSjWfH
 9YVB2c3VJ270pgAV43OnO4+hXI7TOyWtQnXvPvn7q8znICZtbfjHZkvSwPGAy1hoLhwOU1dKxGt
 30iKckeXOmxndkhktIbGciWixk6hiOzMwz8UvZclOKIRmyIJ4nFxdXWaqGGRc1e8aj+6VdFVpAU
 rfXQLEM2274L2tIfczLLjVGClaCn/L7BRDLxwDdiI6pWdQc1bTszvsislzNY7uMmgFC4DHQ0q/+
 5WrQPL0UUN69hY3NPsdbVsulLOBQvWrLe4/50P1PUjdg0SlYV3NOjteuxHJ+BL+EyuhxO0bflUq
 Rn8YFAfXmpN80D/m4hphwBjd6++tRUrpQSB9tHsOxsFxlA7bDd29+TZpz0/xeE+w==
X-Received: by 2002:a05:6820:992:b0:694:a30f:a6d8 with SMTP id
 006d021491bc7-694a30faa61mr6335968eaf.55.1777005052754; 
 Thu, 23 Apr 2026 21:30:52 -0700 (PDT)
Received: from stoup.. ([172.58.183.19]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-42b9ac54ec5sm18880864fac.13.2026.04.23.21.30.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 21:30:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v2 07/40] target/arm: Update HCRX bits for Arm ARM M.a.a
Date: Fri, 24 Apr 2026 14:29:41 +1000
Message-ID: <20260424043014.46305-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260424043014.46305-1-richard.henderson@linaro.org>
References: <20260424043014.46305-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::335;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x335.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
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
 target/arm/internals.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 85980f0e69..b0f6bfa62c 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -252,7 +252,9 @@ FIELD(VSTCR, SA, 30, 1)
 #define HCRX_TCR2EN   (1ULL << 14)
 #define HCRX_SCTLR2EN (1ULL << 15)
 #define HCRX_GCSEN    (1ULL << 22)
-
+#define HCRX_ENFPM    (1ULL << 23)
+#define HCRX_PACMEN   (1ULL << 24)
+#define HCRX_SRMASKEN (1ULL << 26)
 #define HPFAR_NS      (1ULL << 63)
 
 #define HSTR_TTEE (1 << 16)
-- 
2.43.0


