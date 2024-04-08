Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA6D7CD1292
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 17:55:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtt8X-0002B4-9m; Mon, 08 Apr 2024 13:50:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rtt8T-0002AS-Ah
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 13:50:25 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rtt8O-0003lO-GE
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 13:50:25 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-5ce6b5e3c4eso2695080a12.2
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 10:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712598618; x=1713203418; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RPMJ9Fq7Hagw2E+aglC+ITwqURcRV1FccXRLb5FLQFU=;
 b=FynA4AtMkYEVC7OeZdGIHPP6PEz2FjFtX935cJlSWbiQudtdxsmgQCYLLcE7SQgF6A
 GgGFr476Ji7NJDnJ14zLxDFupF5tuflymHSNDobTSGjOFa1JnnJ1jENsUT/0TJ65tJ/a
 9tkp5iHEsBSthLBE80BpSF5WD9B0TYUku/6F6bumqXFcWby/7Iu74qyaEqd99G8Rt+uY
 yMz15/jpjwutUIh7GfD1tuo1UNV/usLpXMkGY1NfldA254gheuvcLTocCEN8gGbdBHTq
 7htTdHhIeUPDnYOFow7/Gv+kwkevQSc+3o2bAuR+FoC8tFyYUzd7hQfQQbcjl7K3VU0y
 s4bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712598618; x=1713203418;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RPMJ9Fq7Hagw2E+aglC+ITwqURcRV1FccXRLb5FLQFU=;
 b=uTOl3rttEUp9Zp5Ord8VtFCESVcdhVjz0DD/mmp3dBGlUUg19eWflae6UVbkAQzkBC
 vxEVyIhsSlTanvzU18qEt2gfkvtlvx9xAhbEnqyUK1T4ikrVUANN24MZLhyxShUsBwbw
 Ni6Ud1lvt8nKRX1Are14Gg6egPaG2SUmDxCcooNtHviWsTTgIBSjCR6wiUa0umcUGK1u
 FetBfTBEIhMD4/rl0EtNtd2sS7IZhSJgqgg0l1/ubI/9ECy9g7fmACJR7TMiNpMr2Vd7
 HZIwjmW+UpLHVu7JSgv07N2QK+ilWiOjlRYtCRdaQudrhMm1pbp4l/OLcRKTnvZF1g6i
 Nefg==
X-Gm-Message-State: AOJu0Yxy0uVdLQf4wLQukwOnbGp7Ckyliso9U+dT6+3qBFkxIdqOW0yZ
 ieOUdbN+TuMsia27bUsKl9ZoXmRHyTcoYTB1IU8cKT0t22t0rsF9qMT+ZTUyapkxGAPdoNY2WMo
 V
X-Google-Smtp-Source: AGHT+IE9QPMDe9/21wXGUioD4qlf/j3g0y5TvVs7pPUO7oCH1UmweM3nXFIXgtqHmo1PzhVkmeBACQ==
X-Received: by 2002:a17:90a:7c01:b0:2a5:1fcf:efb7 with SMTP id
 v1-20020a17090a7c0100b002a51fcfefb7mr2721307pjf.21.1712598617875; 
 Mon, 08 Apr 2024 10:50:17 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 ga15-20020a17090b038f00b0029c3bac0aa8sm8658432pjb.4.2024.04.08.10.50.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Apr 2024 10:50:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexander Monakov <amonakov@ispras.ru>,
 Mikhail Romanov <mmromanov@ispras.ru>
Subject: [PULL 31/35] util/bufferiszero: Remove useless prefetches
Date: Mon,  8 Apr 2024 07:49:25 -1000
Message-Id: <20240408174929.862917-32-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240408174929.862917-1-richard.henderson@linaro.org>
References: <20240408174929.862917-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x532.google.com
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

From: Alexander Monakov <amonakov@ispras.ru>

Use of prefetching in bufferiszero.c is quite questionable:

- prefetches are issued just a few CPU cycles before the corresponding
  line would be hit by demand loads;

- they are done for simple access patterns, i.e. where hardware
  prefetchers can perform better;

- they compete for load ports in loops that should be limited by load
  port throughput rather than ALU throughput.

Signed-off-by: Alexander Monakov <amonakov@ispras.ru>
Signed-off-by: Mikhail Romanov <mmromanov@ispras.ru>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240206204809.9859-5-amonakov@ispras.ru>
---
 util/bufferiszero.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/util/bufferiszero.c b/util/bufferiszero.c
index 972f394cbd..00118d649e 100644
--- a/util/bufferiszero.c
+++ b/util/bufferiszero.c
@@ -50,7 +50,6 @@ static bool buffer_is_zero_integer(const void *buf, size_t len)
         const uint64_t *e = (uint64_t *)(((uintptr_t)buf + len) & -8);
 
         for (; p + 8 <= e; p += 8) {
-            __builtin_prefetch(p + 8);
             if (t) {
                 return false;
             }
@@ -80,7 +79,6 @@ buffer_zero_sse2(const void *buf, size_t len)
 
     /* Loop over 16-byte aligned blocks of 64.  */
     while (likely(p <= e)) {
-        __builtin_prefetch(p);
         t = _mm_cmpeq_epi8(t, zero);
         if (unlikely(_mm_movemask_epi8(t) != 0xFFFF)) {
             return false;
@@ -111,7 +109,6 @@ buffer_zero_avx2(const void *buf, size_t len)
 
     /* Loop over 32-byte aligned blocks of 128.  */
     while (p <= e) {
-        __builtin_prefetch(p);
         if (unlikely(!_mm256_testz_si256(t, t))) {
             return false;
         }
-- 
2.34.1


