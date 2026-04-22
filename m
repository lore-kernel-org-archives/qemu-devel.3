Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 953D3F9B607
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 10:18:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFUes-0007QQ-Ep; Wed, 22 Apr 2026 06:18:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wFUeN-0006z0-RZ
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 06:17:45 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wFUeJ-0002Pn-KP
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 06:17:42 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4891cd41959so33540935e9.3
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 03:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776853054; x=1777457854; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yq/bGIVh38nrtfwG2BReGAMOSU3dNrWCtccK7bpObt0=;
 b=R/Hnzk4LIMg5tAbF/6UzousfLH4uiWqR5BUnfAMyCjwhhdqiqSdIO/gpj8nnxuc7qx
 CrcmzgfswyC6nBNVWsGjpAnGNYcbgRkQBBAb8l527kmFK2M/NlLxq+8U7n0E7r22xXiC
 W7zUIGnkVOgMk2r7j4kHnqFH2cMlnKdnefDs0LYeh1uLdvKYK4DDVn6YG5pfB+VcczM7
 84Aw8CKY4NQhujS7lHt1eb/wk+iyuftiQ4Diei19eRrjyFgEOZyFCRBQxMZqqfx7zZRQ
 to0EUAuim/apqZOWRd2qjiO5vShK03c10z8BnP1jNhjdH8ZJBn/7o+z032IDFwjW4b0o
 yqYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776853054; x=1777457854;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yq/bGIVh38nrtfwG2BReGAMOSU3dNrWCtccK7bpObt0=;
 b=EUiSVslQlDNdhuLTRbf5WFurjETPwT/x+zStcCiysLDShRHJD7jqe9p4sjVoIC4Aqu
 DhKk26a5PkUL5UDB/Mkl5UBp6sZfEx9cCPk76Uo/psUpqLLLEYOSCyNITah7ySnSnOjB
 wcQ6ZOOD2hS8TfGUL9x2r8LGCS2ouN3SPYlTtFGJ9v7HwJLz9jZBWuI4r5TDf8V1Myn6
 yLZqQYv6zCRq1cxrE+EEdjc1QmlxKAotaiARkjxRgi3/lIvxpazZlcgSy3maKBL2hgKk
 W+13N8r9WeDkaS74saSSrBzl2y6WdIviDfO3sprsk1AEz2MwJubE+XIsBIw6JtDt8kEs
 XzGQ==
X-Gm-Message-State: AOJu0YyJIjMbhhUGo2l3fvkJgzc42ZHBUVuchJXlUAipmnzD9w2LmGqf
 b8gDuukcTnaZ8qRNT7sRV6gSj0LmRbA+21wYA3U06xRTpLGhZB7nF28nSp/TUA8zMw8=
X-Gm-Gg: AeBDietoW5DN4wA4WpJONu79fPruOOKSfjqp+Q9N15M2NUQfi2UlZj1lPT1/iHG/rWA
 niNgOYn1m6JSDvhXUPw25mXq4ezMe8oG7/4hMrtmTRESmfi2QSbsKkRDz+lxSugsJ9G3JZ3WM++
 WkzVte7CTHOrIWWl1EQXN5Oq5m/KGf/9mwBfUeNebHcVWB6zpjpRfWVrPKwlDkdRYXKNDdDUVAD
 OjppyUH8USpyTj3I2X4BuuUIHp8FqXk82pECC7XgjJsp6YLpt2FxkhouarYEx4qZO5/781ffrOT
 WkclQzf1ZZZYkUf7UR+nyhPDR22860GIAQ9opao2fQBL1eh7K3kX3bPp5RqFqOaXg+NYNh27zQM
 UsHFkm7sR55YCahFkOHvmw5V7ctO9YAfR8bOTlGK2VTHUyhnlKAqNe/nASt4MfSiYCvYLC9gosJ
 9ueEc7IDXSBpGVnBVBMqzcpZ+WQdqK03RqXw==
X-Received: by 2002:a05:600c:c0d5:b0:488:c683:be89 with SMTP id
 5b1f17b1804b1-488fb74dffemr240575745e9.9.1776853053932; 
 Wed, 22 Apr 2026 03:17:33 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a55dc9f58sm266237205e9.6.2026.04.22.03.17.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 03:17:33 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E967F611CD;
 Wed, 22 Apr 2026 11:10:44 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>, kvm@vger.kernel.org,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 19/31] target/arm: make hvf use syndrome helpers for decode
Date: Wed, 22 Apr 2026 11:10:30 +0100
Message-ID: <20260422101043.1234229-20-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260422101043.1234229-1-alex.bennee@linaro.org>
References: <20260422101043.1234229-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x329.google.com
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

Rather than open coding a bunch of shifts and masks we can use the
syndrome definitions.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/hvf/hvf.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 5fc8f6bbbd9..1c1c31f0b15 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -2123,14 +2123,14 @@ static int hvf_handle_exception(CPUState *cpu, hv_vcpu_exit_exception_t *excp)
         break;
     }
     case EC_DATAABORT: {
-        bool isv = syndrome & ARM_EL_ISV;
-        bool iswrite = (syndrome >> 6) & 1;
-        bool s1ptw = (syndrome >> 7) & 1;
-        bool sse = (syndrome >> 21) & 1;
-        uint32_t sas = (syndrome >> 22) & 3;
+        bool isv = FIELD_EX32(syndrome, DABORT_ISS, ISV);
+        bool iswrite = FIELD_EX32(syndrome, DABORT_ISS, WNR);
+        bool s1ptw = FIELD_EX32(syndrome, DABORT_ISS, S1PTW);
+        bool sse = FIELD_EX32(syndrome, DABORT_ISS, SSE);
+        uint32_t sas = FIELD_EX32(syndrome, DABORT_ISS, SAS);
         uint32_t len = 1 << sas;
-        uint32_t srt = (syndrome >> 16) & 0x1f;
-        uint32_t cm = (syndrome >> 8) & 0x1;
+        uint32_t srt = FIELD_EX32(syndrome, DABORT_ISS, SRT);
+        uint32_t cm = FIELD_EX32(syndrome, DABORT_ISS, CM);
         uint64_t val = 0;
         uint64_t ipa = excp->physical_address;
         AddressSpace *as = cpu_get_address_space(cpu, ARMASIdx_NS);
-- 
2.47.3


