Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECB4DC4829E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 06:21:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raV7J-0002WL-EB; Thu, 15 Feb 2024 01:21:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1raV7G-0002SA-SQ
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 01:21:02 -0500
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1raV7F-0005Zk-64
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 01:21:02 -0500
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-6e0aa4bb62fso311220b3a.1
 for <qemu-devel@nongnu.org>; Wed, 14 Feb 2024 22:21:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707978060; x=1708582860; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e2NESTxnz6150SuLytNvY5Gmn2U5RKg4GfRtueQZH4I=;
 b=jocrHhZXXPVXVOKXM8tf6O7U7e4f8XwGD5NfISYkl7L+JBquBlR8OOPE0Veo0DIpzg
 EQsMO4OmhDSyfiV+8V0u2f6SzEbmSR0A0qo5jKImc5xC7GHNdpp7nWgbrZOo1oQM3//8
 PFUYGWBZkMdUJjuKyuZdunF1cBI/z2lBOUCFyHPPmsRZWJzsLCOlX5qc0Ie/MnM/KPtA
 BoYhEXbWf31pYkzlMtx0l2hO94xTjjODg2YkFz9ZtVIR66xQsl9bXnPeaavHvheVFXf6
 wlw3FK8ZheX1K71wwbViAidcRh3zszGfxs7DSuPAerevO6CLffmI1IsUEkrZ2IYJsmuO
 5DYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707978060; x=1708582860;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e2NESTxnz6150SuLytNvY5Gmn2U5RKg4GfRtueQZH4I=;
 b=a8rTCODNJRUTZ8d/40bxX11mNR55kQbO4LHOAIgkDeBhlg84fPlHOWnVaIC93gdNrp
 ekGWZ+UaBCWqkROKX99H5bn26at2Q1VOzduBLnzAZhR0zCdWIBLfkrjuuTpkUwqwS9+f
 ThIlqw68ruqapOPiFntxr+Dz4MUBTfw5ySDDVz1jHMmj7+zy8BoMa7cdUK4U5pO1kDyV
 6qDJ8dA62/Q4Ut09ISgzSvWTW/jhJOU/fwtjGJJI9dhqTyZxDVWtk0hus7E2m4yYC4nB
 ho9YX40JpOzNQbp8+vZL6ttMXHFtp4M3LXSrhJkH1DNJVSNiIyVaINqmwTqR1XTczpEs
 92JQ==
X-Gm-Message-State: AOJu0YxpbaE8yIQ9lYfAv14tC9vsOPnqM5/jbaz6Qlnorom5vli5bsqs
 WwWE/4enEcuti39YyZxHHD9/CqIw17uxdeiew0BzZYRZJ/0tHZSVXSZvFU9lDIagmWIBuZMhucb
 5
X-Google-Smtp-Source: AGHT+IFJ9sDjEXtUETUm3ReyUQZDUaqmowhrRS8qjEoX1WAOvwlmCisk/xV50ygaQVkQUzzfnDWLMQ==
X-Received: by 2002:a17:903:445:b0:1db:917f:5a42 with SMTP id
 iw5-20020a170903044500b001db917f5a42mr75351plb.3.1707978059832; 
 Wed, 14 Feb 2024 22:20:59 -0800 (PST)
Received: from stoup.. (173-197-098-125.biz.spectrum.com. [173.197.98.125])
 by smtp.gmail.com with ESMTPSA id
 d5-20020a170902b70500b001d6f29c12f7sm464418pls.135.2024.02.14.22.20.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Feb 2024 22:20:59 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Helge Deller <deller@gmx.de>
Subject: [PATCH v4 27/36] tests/tcg: Extend file in linux-madvise.c
Date: Wed, 14 Feb 2024 20:20:09 -1000
Message-Id: <20240215062018.795056-28-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240215062018.795056-1-richard.henderson@linaro.org>
References: <20240215062018.795056-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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


