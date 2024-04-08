Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 885A3CD1292
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 17:56:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtt8X-0002B8-AV; Mon, 08 Apr 2024 13:50:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rtt8T-0002AQ-5K
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 13:50:25 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rtt8R-0003ov-Is
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 13:50:24 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-6ed3cafd766so874090b3a.0
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 10:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712598622; x=1713203422; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=bh4lWnPe+YOgpHGdevl5r/TyXWqM+m5cBerY0p6p+5U=;
 b=Z840WH6h/v144lDoCxL9vxqP1V8DWb9SZlhSjPEoY7CzLXAKCVcL4Xch+kCsSjXHO3
 jsQDNQ0QZnw2AEEiLVAYBliIBLW+bq3P40/E/XwOXXEjuobuwLi34NgjOAPLW+hVdNpn
 OPAndHgJfzgWDRO+PY97O6dACSmaTIJBTqS4cdZpJ8nFCmidmqvnXE6o6zUY892ce/bg
 Lusbk2kNfKG9FCgOA+hJ97HEflcL7s/DizJZqjpFXNfAVDvLfNGLG3PHdmZnN3muq4Ex
 vDodPXGMT9r4OD2l4iGMzk/ketqxUp+kaugvBhKa54SwzSnNrmUoeyJ/JpVWZ2ONv4uH
 OWLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712598622; x=1713203422;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bh4lWnPe+YOgpHGdevl5r/TyXWqM+m5cBerY0p6p+5U=;
 b=GiTqvTLehqLnYO/+co1OE3Ux5YeORfsTN1lLXUpULM9w2Y5Ay0z+jflXwwyYwPfCaX
 ANmPEcUXG+dg5LUnfTDQHlyTGSTGwPYEVyUO1M2ubA6hH8eQ0SQUTZatt4u3Up/B7rxw
 YoMWM3ObzylOTjmUgQmKdBKKAlXvnA9RknjPILS31nyFBGXjlozjwhr+o7h7ytwu2LI3
 k2P6qVFjcaEJCn/jcQ/9EktouOkF9IfIcVNMx1mTQlG7MhlpDwOrwWP5cE41MnuZn6o9
 qXRixfSaljeWOIN6dPkJ/096ekP8YjOsHZFifuK8i7oY5C+dyZmmrSmyXW0xj0gJOIMk
 mkyA==
X-Gm-Message-State: AOJu0Yy1KQz7AC26kiFTqUw3KyK4EwFmNqFYNP/KVQd2ZftqnXiI9MfD
 FrmVtfbExnfAm0bBCQI6EDPfZ5dG62siOTpH4RKsDU8qtDDWYshCF3yuBz9TAZ4+wxpDtnOSWUP
 A
X-Google-Smtp-Source: AGHT+IESSFg2VG28jnzKXP/OTmyZaPwy3MG2nlIIzHytJwZ2sTMbr6jhfp/2eCybIckHFuqUokMGcA==
X-Received: by 2002:a05:6a21:32a0:b0:1a5:6bfb:76de with SMTP id
 yt32-20020a056a2132a000b001a56bfb76demr9501508pzb.2.1712598622246; 
 Mon, 08 Apr 2024 10:50:22 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 ga15-20020a17090b038f00b0029c3bac0aa8sm8658432pjb.4.2024.04.08.10.50.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Apr 2024 10:50:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 34/35] util/bufferiszero: Introduce biz_accel_fn typedef
Date: Mon,  8 Apr 2024 07:49:28 -1000
Message-Id: <20240408174929.862917-35-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240408174929.862917-1-richard.henderson@linaro.org>
References: <20240408174929.862917-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 util/bufferiszero.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/util/bufferiszero.c b/util/bufferiszero.c
index c9a7ded016..eb8030a3f0 100644
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
@@ -178,13 +179,15 @@ buffer_zero_avx2(const void *buf, size_t len)
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
@@ -231,7 +234,7 @@ bool test_buffer_is_zero_next_accel(void)
 #define INIT_ACCEL buffer_is_zero_int_ge256
 #endif
 
-static bool (*buffer_is_zero_accel)(const void *, size_t) = INIT_ACCEL;
+static biz_accel_fn buffer_is_zero_accel = INIT_ACCEL;
 
 bool buffer_is_zero_ool(const void *buf, size_t len)
 {
-- 
2.34.1


