Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B69E606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 08:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=wdV40zej
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKAvD-0005nb-W6; Fri, 23 Oct 2026 04:46:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xKAv4-0005kv-OG
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 04:46:37 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xKAv1-0002gl-Q7
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 04:46:34 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-48e20ed3b9dso504970f8f.2
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 01:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792745188; x=1793349988; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=D6qAmQw1v40FmaaCYxocryhRTXKhVgPq3CvD3sqy214=;
 b=wdV40zejM0ZNqyVoaELhNFXk92LNpBVr9iEmxHXE4akCSHWwFWHc6qXKCFpEBhQBGs
 bXE5lTP6o/uJDDhUg+tjxnWM0Pycd6g6cTJ0EFNUKakDUcyUxTmWE126XMG73VrALs0z
 SdVmliTACqoU+fEJuvyFsh3weAs+S8YU0g5Gl7drgYiNYXlym4ERgB+5trMe73jDAP8o
 1WPYm9wuXF/4rmQP4Yzdh5RCCI30HMsNA2b00qTS1s3C0Kw/K2PW3SxNYkTb1XvjFK70
 ykkeWNJxOg0m+2xQM/bz4ajArhf4YuPF/oF9PSL2FCsW/dkXd8XN2yaLPU59FSPapAU9
 /4Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792745188; x=1793349988;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=D6qAmQw1v40FmaaCYxocryhRTXKhVgPq3CvD3sqy214=;
 b=vAgClzT3yKrBKbf1XRz/PMEAadY01sihAj7F+4vpaj0RMMKz6O6OepL5l6Dvouiwsv
 8JLNyVFDO3nPH6yfkJ5aHzVXo6mrEhPDDL6hmW8B/wzRVImel4wcWQR2eGaO3Zyn/ef1
 brqtDz9B2DkjzgBGUiJRcGuyhGJjK+b6zbQBHKHf7FjTptd2YmVv0Ym8L/Yvp3jxXzP0
 +j8pT7fQs+wwE7+zCDO4XRzvHV8fhpnksfSvMZtO3CsQCbbiZlO4B/adl5D/8OJQlTCv
 Cvl+0iXMw6NJ6vsNl3ZwNifWRfz7i07CGIZs2xkM8SqPxR/qFwNZQ967cmKEwqhyri+L
 Ij4Q==
X-Gm-Message-State: AFq9FYI2Kf59EA6Y6zgOkk+vBcvjjw4xRilXaEeSPFdIPN4ZdEGYoUQa
 CdbBtOngZ9848+TcU/X/bAisp2e7P663OrkfCcEK7ujDUFuHJ1IJyK7smrBE8reujoZjz+RgggW
 bgzSIylw=
X-Gm-Gg: AYBFou1aLVnsSl0blrjBMGu8YKg7BuRbfRfTYDpQ3M4QqXpjtzQDuq94wJB3/t5To4n
 UAyd8hXv4db2D1aXGQ2+3OFyOgHGedu+UxK8IkUFVYvzQVhp43hv9+K/aes7F91/pNKkXxW7dWF
 fB4cs5ipZM7TVXCu9kJayToXkWyVZ9xvjpUlVXyzAI9RT4jdavqdYsSr2eV/1f7RytQ8YGKhSyg
 ArRMNSKlbrvVFpZ83hGtHVsVgWugD1EwkZahYbWcUVGdTgCDdANuziHg37QJUEPgM9IxL3DQVhe
 A+H8fXSXaxxu+NDt7qs2IbYF+j2hh5byJ27gvB57IPEkVaVWs7X0A+ffELna8V+mO867wS2xyB5
 Zvdn+qMMcZ2cCtdPnwexECQd2WhkWX3orZTHTw9xmtQhHaySoNwil629ul9OJREReK2EGI019qz
 xal9QFaMK5yPXgoSJzgj1EpOhtzLPuvhimlwKyFXgVfrAc/XJtOcwFJq2X2pR8KrVuXOAFRRlDB
 l3VFP7f+dPkhBjL747y6tt5NjQEAzt5dcqmHCpT3ap1m0mUywkpBFHPv41yaRt5WQkzz8ioH/Qn
 RpYgjjAEdMVGkjx2BNVN/GVkXVZyXEgqA3ngXHwlibNzdyvwZIhFnXuURbX6
X-Received: by 2002:a05:6000:220d:b0:48e:1e03:687f with SMTP id
 ffacd0b85a97d-48e385a79c6mr2731472f8f.31.1792745188234; 
 Fri, 23 Oct 2026 01:46:28 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3805c596sm3848197f8f.49.2026.10.23.01.46.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 01:46:26 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH] hw/intc/hex-l2vic: avoid shift into sign bit
Date: Fri, 23 Oct 2026 09:46:24 +0100
Message-ID: <20261023084624.1063258-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42c.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

In fastl2vic_write() we do:
   val = 1 << (irq % 32);

Because '1' is a signed integer, this can shift into the sign
bit of 'int'; the cast to uint64_t to assign to 'val' then
results in all the high bits being set. This happens to cause
no visible problems because l2vic_write never looks at those
bits, but it's obviously not intended. Use 1ULL so that we
do the shift as 64 bits unsigned.

Resolves: Coverity CID 1685261
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/hex-l2vic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/intc/hex-l2vic.c b/hw/intc/hex-l2vic.c
index 736f1be3b1d..89b44200928 100644
--- a/hw/intc/hex-l2vic.c
+++ b/hw/intc/hex-l2vic.c
@@ -381,7 +381,7 @@ static void fastl2vic_write(void *opaque, hwaddr offset, uint64_t val,
         uint32_t cmd = (val >> 16) & 0x3;
         uint32_t irq = val & 0x3ff;
         uint32_t slice = (irq / 32) * 4;
-        val = 1 << (irq % 32);
+        val = 1ULL << (irq % 32);
 
         if (cmd == FASTL2VIC_ENABLE) {
             l2vic_write(opaque, L2VIC_INT_ENABLE_SETn + slice, val, size);
-- 
2.43.0


