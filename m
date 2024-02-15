Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFB09C48BEB
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 08:16:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raWu9-0007hR-FJ; Thu, 15 Feb 2024 03:15:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1raWtb-0007Cj-PI
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 03:15:06 -0500
Received: from mail-oi1-x22b.google.com ([2607:f8b0:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1raWta-0001PV-4M
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 03:15:03 -0500
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-3bd72353d9fso450614b6e.3
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 00:15:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707984901; x=1708589701; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+5kI9i1T4g1qlGS3lxQuuu2LwuYBA3jGXjmyocvfHSc=;
 b=bNRaOfVoxaup6DdFdTBI/FTE4rnKVKD2x3aHfXpQhC27t5Jx2az7s5ItLAPAgIEzX8
 6sJqvvCDt5CL4dy2fVO4u07hvcl46scWgIpf/C4EyuQbguJYuFTRfn/qSErW7Q8LQKao
 +g4M7i3lx4kwgBFu0J84mml2mGOSWuECZ4KOZCU28e1FGPfRH4KB5vvRP/9IGBE2M27L
 OLYMANsL3K92mW96tqQ7flgZEaa6/595TFE0h8T/r2AuzBW7lwN+0e0KrZwZ/BnVWiWi
 O/ecElTi+IgIVpb6SO374SWqyzPIbCbXNrj9B+paPiXwAeZaYhJKExq2CORN+vRCLECW
 n1ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707984901; x=1708589701;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+5kI9i1T4g1qlGS3lxQuuu2LwuYBA3jGXjmyocvfHSc=;
 b=BFdBjqY3S9MFjoG3RHS/+nHQLXGFRG0ONzh6g3ITFLW4FRkjJWu9X6qn2RSorKJ1Yv
 Wx/H6PRwezTfWxDeRxebi0u1g6FrdRJQWVzI4ny8nVvGlL9+codVzQ3AFQa+gT1uJtks
 8MPgtw3HViFH7/geq23W6AwgG+AbWH47EuYF9yDdTEDFamFK/LmYIOWWRPROWbdemdzA
 lv4eh2rd9/UhVVc2El7wKAMKlN/BH+6klfG+EH8U/DiRgVOGdPkTP1sQXPKq8eAWxym0
 2hQW8NRzSgIpJ8mvridmUt/5yih1nPPfHYxhnEdLQhcnAmGi0VsTjGBSRWvd2FThGTX/
 ehtw==
X-Gm-Message-State: AOJu0YzCLFSy2M2tmZDrEBNToLX6TPICHE/AQAIWz/LkcgwVe1qJqaas
 0tRGXGGmZwe7H+xCtf7y36DsZclWBsttabXW4LkVyHdAlInldPza3Wsf9pVF7w07o9+TfH1Yi2f
 A
X-Google-Smtp-Source: AGHT+IF9spF03LMpTCCog7Hsal4zoowWZXji4owaG+gTb7KneARWWa/QnD0bTLE0Nim9dq/y/BWhIQ==
X-Received: by 2002:a05:6358:6f0b:b0:178:688e:fb21 with SMTP id
 r11-20020a0563586f0b00b00178688efb21mr1068454rwn.7.1707984901019; 
 Thu, 15 Feb 2024 00:15:01 -0800 (PST)
Received: from stoup.. (173-197-098-125.biz.spectrum.com. [173.197.98.125])
 by smtp.gmail.com with ESMTPSA id
 qc14-20020a17090b288e00b0029900404e11sm807755pjb.27.2024.02.15.00.14.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Feb 2024 00:15:00 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: amonakov@ispras.ru,
	mmromanov@ispras.ru
Subject: [PATCH v4 07/10] util/bufferiszero: Introduce biz_accel_fn typedef
Date: Wed, 14 Feb 2024 22:14:46 -1000
Message-Id: <20240215081449.848220-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240215081449.848220-1-richard.henderson@linaro.org>
References: <20240215081449.848220-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22b;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22b.google.com
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
 util/bufferiszero.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/util/bufferiszero.c b/util/bufferiszero.c
index ce04642c67..ce80713071 100644
--- a/util/bufferiszero.c
+++ b/util/bufferiszero.c
@@ -26,7 +26,8 @@
 #include "qemu/bswap.h"
 #include "host/cpuinfo.h"
 
-static bool (*buffer_is_zero_accel)(const void *, size_t);
+typedef bool (*biz_accel_fn)(const void *, size_t);
+static biz_accel_fn buffer_is_zero_accel;
 
 static bool buffer_is_zero_int_lt256(const void *buf, size_t len)
 {
@@ -179,13 +180,15 @@ buffer_zero_avx2(const void *buf, size_t len)
 }
 #endif /* CONFIG_AVX2_OPT */
 
+
+
 static unsigned __attribute__((noinline))
 select_accel_cpuinfo(unsigned info)
 {
     /* Array is sorted in order of algorithm preference. */
     static const struct {
         unsigned bit;
-        bool (*fn)(const void *, size_t);
+        biz_accel_fn fn;
     } all[] = {
 #ifdef CONFIG_AVX2_OPT
         { CPUINFO_AVX2,    buffer_zero_avx2 },
@@ -232,7 +235,7 @@ bool test_buffer_is_zero_next_accel(void)
 #define INIT_ACCEL buffer_is_zero_int_ge256
 #endif
 
-static bool (*buffer_is_zero_accel)(const void *, size_t) = INIT_ACCEL;
+static biz_accel_fn buffer_is_zero_accel = INIT_ACCEL;
 
 static inline bool buffer_is_zero_sample3(const char *buf, size_t len)
 {
-- 
2.34.1


