Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9745FC54E4A
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 23:16:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgC2C-0004Gb-2q; Fri, 01 Mar 2024 18:11:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgC1R-0003kN-0J
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 18:10:35 -0500
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgC1O-0005gI-LY
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 18:10:32 -0500
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-6e4560664b5so2238581b3a.1
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 15:10:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709334629; x=1709939429; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e2NESTxnz6150SuLytNvY5Gmn2U5RKg4GfRtueQZH4I=;
 b=zvbezarZ2naOe+xWDLmcprnW0NF10+bLiTDva0y7/3hnWQdqGHRSbtcBbOWLUJJWJe
 OVYor7mvwc92cGcWa9YJ643pcajYQBrkvzStgB7TezWbc6S4P3CSIluf2j9AA+ylHUSC
 Hyko3Ga/eCAuSGxkqD0MHyAqJK6wkU69AhTq5lGIu1cDbrycaIbPlqA7YTX11g985Gi2
 B6sZaAVcZh0fqCcfIzNFhX31lzxGc5IgQNcG8NggSac8ZtqkqgETzCkvOUEp2UkB+C4l
 HS0jEXbmAKzSDXjttdT3M1+S8hqkioSdrGYGlgC5oHUxqHdyt2rpXM63OwsVTOzVLelv
 0ACw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709334629; x=1709939429;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e2NESTxnz6150SuLytNvY5Gmn2U5RKg4GfRtueQZH4I=;
 b=rev3FRgQNve7/ecc7vmqtfoDnPCtBAQzKkX68Lqv2x0T1YIaXfTXgcg15iXkBYM29g
 DTMIDoIqHEFFB342P0qh/NU1wM+QhyEzq0+15lhlQ7EkDe+VCaBHRk5PNXm4nn/pzzMx
 bIEbgWb97GM++RqvwMvUnsOqo0/hCWUgFsbcIlw+9FaEBY37Ewdbd0Xz0LsAetqQfk+g
 YOlwzwn+fEZ/gpp8ll0GOuHNbgjDtflERFb3audYl67L5T+qNKoJpQ1L9EQjqGkZ2Y09
 aaMzkqSu/a52LBDO2B7rZLliEcZC39S1zVK3UVzZZDPCcV+cAzG/QpTLWdv0frnfg+nI
 QVtQ==
X-Gm-Message-State: AOJu0Yw6TQMwTZ+0aBUuQ7deXPGtzBOQnJGFg4RhEbIhPxl8DcOuPtun
 q2WzSQgoZnpSwBbP3hTgJd56IGaNtDSzWyhZJtexHvwZuyRA1ZhjxaG0+b5426sQgHJoyK6mhG1
 X
X-Google-Smtp-Source: AGHT+IHY/0d+h3bIcosmTBOnD95JmCAtaLe3WAale33AqA0CfsL53G3Xs4n4IZcXfr8Z7b6+HdBkog==
X-Received: by 2002:a05:6a00:2352:b0:6e5:adb9:b955 with SMTP id
 j18-20020a056a00235200b006e5adb9b955mr3834774pfj.23.1709334628978; 
 Fri, 01 Mar 2024 15:10:28 -0800 (PST)
Received: from stoup.. (098-147-055-211.res.spectrum.com. [98.147.55.211])
 by smtp.gmail.com with ESMTPSA id
 c2-20020a634e02000000b005e438fe702dsm3449407pgb.65.2024.03.01.15.10.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Mar 2024 15:10:28 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Helge Deller <deller@gmx.de>
Subject: [PATCH 45/60] tests/tcg: Extend file in linux-madvise.c
Date: Fri,  1 Mar 2024 13:06:04 -1000
Message-Id: <20240301230619.661008-46-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240301230619.661008-1-richard.henderson@linaro.org>
References: <20240301230619.661008-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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


