Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68F57C5478C
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 20:51:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdFvU-00080U-AM; Thu, 22 Feb 2024 15:44:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rdFvS-0007q3-Jo
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 15:44:14 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rdFvR-0002mK-2h
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 15:44:14 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1dc1e7c0e29so1599065ad.1
 for <qemu-devel@nongnu.org>; Thu, 22 Feb 2024 12:44:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708634652; x=1709239452; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e2NESTxnz6150SuLytNvY5Gmn2U5RKg4GfRtueQZH4I=;
 b=hZ/4CrhMaNF1HjeJrPF8OHuJNdFTLFA4fEx03C6PKPWV3gpdKvw5Kt9cMBDW8quEA8
 VvO3b4fReqsO3wVD+JP56u8Kw2FcSPqbrZwwWJHtywSPyQgpCfct7+KQbDin5ITkl+7c
 KM0jCBW56pvhEO6bTfjhNwDDhdpFf30lcxqRxilPBTEAXKD7uXyqJ8Fuzj7IFI3JUz5P
 5vqtUHb7fL1xcG42GcY/KNqr54sK1RgxEQpNrZch/FUdgLFjz222mZ2j/Am3gIDbNiSE
 bvjfEoBUBZNXVpplwge5cQ/qt9VD/vZN/PQZVenFTupjXYhHFGtFwMesL8/HqFDO7Raf
 orGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708634652; x=1709239452;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e2NESTxnz6150SuLytNvY5Gmn2U5RKg4GfRtueQZH4I=;
 b=FzWKKGIR2/ZNrtlRJhVKDZL9T/fsqBzKmueZa+jdflkyGbvBlPs0aYlIgvWhJdqf2i
 yaxTlnFSTIPMRbudyzhgQ0be9830XZgxiMSSRMrioniQgqw8IsESlJpZMLFKaGhmPczL
 OWiUbhxU6fRl6wGiFcpi/kkN1Lm4v/Hf2l7M/nx1qccJCy6e6PldCd+RE45l4fLgOkCi
 OgmMKsOlztdQqKIDdJw9EU2/wGlIgk7cNrrRYbWHLo1Ksz7+jGyhsV0B3Yi5MDFTJ1og
 QW0McetP23CXjmvev0bIft7s2oI5tyAaVRM3RAlbfLb2vB4D6EfGwc4xuiEC5+j7so4m
 6XLw==
X-Gm-Message-State: AOJu0YzDFbJ7VHwhJUxD0TGzaMO7TumttotucJHO5PUS8ctne56pNyeI
 8Fhi5elRaZhA3xU23xqXCvpqAW7RveA3Vhl3XqrHdCg2W0yhqNr0CJRF6fwHMzZVVOgJ0zCgppT
 M
X-Google-Smtp-Source: AGHT+IFcuTy8EJ2o76Foed3DNGOgF7w8raPHKOVmlAW1Wx8ej7Aaizp3M8y5OQxUMBQueKGRfvMBWA==
X-Received: by 2002:a17:902:ea0d:b0:1db:e792:bb38 with SMTP id
 s13-20020a170902ea0d00b001dbe792bb38mr15388661plg.63.1708634651868; 
 Thu, 22 Feb 2024 12:44:11 -0800 (PST)
Received: from stoup.. (173-197-098-125.biz.spectrum.com. [173.197.98.125])
 by smtp.gmail.com with ESMTPSA id
 l12-20020a170902d34c00b001d8f81ecebesm10275500plk.192.2024.02.22.12.44.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Feb 2024 12:44:11 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Helge Deller <deller@gmx.de>
Subject: [PULL 30/39] tests/tcg: Extend file in linux-madvise.c
Date: Thu, 22 Feb 2024 10:43:14 -1000
Message-Id: <20240222204323.268539-31-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240222204323.268539-1-richard.henderson@linaro.org>
References: <20240222204323.268539-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

When guest page size > host page size, this test can fail
due to the SIGBUS protection hack.  Avoid this by making
sure that the file size is at least one guest page.

Visible with alpha guest on x86_64 host.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
Acked-by: Helge Deller <deller@gmx.de>
Message-Id: <20240102015808.132373-26-richard.henderson@linaro.org>
---
 tests/tcg/multiarch/linux/linux-madvise.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/tcg/multiarch/linux/linux-madvise.c b/tests/tcg/multiarch/linux/linux-madvise.c
index 29d0997e68..539fb3b772 100644
--- a/tests/tcg/multiarch/linux/linux-madvise.c
+++ b/tests/tcg/multiarch/linux/linux-madvise.c
@@ -42,6 +42,8 @@ static void test_file(void)
     assert(ret == 0);
     written = write(fd, &c, sizeof(c));
     assert(written == sizeof(c));
+    ret = ftruncate(fd, pagesize);
+    assert(ret == 0);
     page = mmap(NULL, pagesize, PROT_READ, MAP_PRIVATE, fd, 0);
     assert(page != MAP_FAILED);
 
-- 
2.34.1


