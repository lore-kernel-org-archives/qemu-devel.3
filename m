Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F571C5478C
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 23:16:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgByA-0005W0-8Q; Fri, 01 Mar 2024 18:07:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgBy2-00056R-Jn
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 18:07:03 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgBxy-0004HO-Mq
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 18:07:02 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1dc96f64c10so26797605ad.1
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 15:06:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709334416; x=1709939216; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=hEWtqWwf0Qk6NbmeI5cYzjl67d1WwUtptl/3wcrK9qU=;
 b=G2NsW8syPlqq2PlNEJRWj3Xg/sq9HQ6MyonVP/KTG85/C0osB28OiMSNziEH7eSVua
 FvQ/Z1a7Fh5l9gijQBGrMSmVJWS23LnW5wZuel5K3Eavdq7jIbJG5jpo3G9FPYVlT3U2
 mBSabzA4kxw+XC288fhA9zd1bRQ4vqAgu6mbshPVIoVZ5Lm4Y2wH1xGsViD8LZBoCt9q
 lSFWB48AzRsn85BNXAmKn+Eu1aKmHyOigaIQx6WgFy3mDjqMqhYjmcC+XaGz3I9hKWq/
 XQyI8fut6C6/JKbKek+VqGlGRdet7lNuanEHbqvntXKeXqKcuLH9V57Ob2fgqy1uIS2y
 qb6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709334416; x=1709939216;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hEWtqWwf0Qk6NbmeI5cYzjl67d1WwUtptl/3wcrK9qU=;
 b=gl6MqpnIK4HeS5KqvIflZL5x9jjL3CtGn3tWXsBXZRw+ZDEinLgPBzRs9amoKE2f3a
 xGc723bCumlj/5SQ258eac3ph6R1WAeU1j7SO8EJ5NXIuNmRFqQY3X6YiWbrQdhk0zPM
 +Xw6LMN/v7aYfcV8P8rasjEYMbDpVwLfS6dwfmcAvcFYqjShMcs/IMk2ispiW1nTbbXb
 1/9KtIe5aX5R0jvk3VMg1zDvnQ2ccJ/Z/mqqj4qMNWwzHpN1rd1R8G4tRBWwk5iEDFGJ
 FFQ2CMD81Bz4BhvXWxHUgRSLg0dU5oT3uvbSnDnqumNlKRjwORDYRUVdeaSix0nV2GhY
 2NsQ==
X-Gm-Message-State: AOJu0YyH4Ubsedi7FlEaNPkOSfGp0tQiYl14r55N5WcZU+PFGQ9LTcDO
 YSmz6heIN8IonSfFeSIsbaE4VJL7gs+a+VPSuU9U6Yv0EdLb80dCy23eOBElV1qfslS2eOZVcHq
 p
X-Google-Smtp-Source: AGHT+IHP/4u2QBFHg94sOfooQ1S4CnfdayInXwa+wNicst0mcB4JO5uVKnwWgc5unzy9nw50Du4d2w==
X-Received: by 2002:a17:903:2449:b0:1dc:b320:9475 with SMTP id
 l9-20020a170903244900b001dcb3209475mr3632998pls.13.1709334416593; 
 Fri, 01 Mar 2024 15:06:56 -0800 (PST)
Received: from stoup.. (098-147-055-211.res.spectrum.com. [98.147.55.211])
 by smtp.gmail.com with ESMTPSA id
 lc11-20020a170902fa8b00b001dc668e145asm3988580plb.200.2024.03.01.15.06.55
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Mar 2024 15:06:56 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 25/60] linux-user: Remove qemu_host_page_size from
 elf_core_dump
Date: Fri,  1 Mar 2024 13:05:44 -1000
Message-Id: <20240301230619.661008-26-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240301230619.661008-1-richard.henderson@linaro.org>
References: <20240301230619.661008-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

Used only once in wmr_page_unprotect_regions.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index d2919a411d..cc2013c7b4 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -4292,7 +4292,7 @@ static int wmr_page_unprotect_regions(void *opaque, target_ulong start,
                                       target_ulong end, unsigned long flags)
 {
     if ((flags & (PAGE_WRITE | PAGE_WRITE_ORG)) == PAGE_WRITE_ORG) {
-        size_t step = MAX(TARGET_PAGE_SIZE, qemu_host_page_size);
+        size_t step = MAX(TARGET_PAGE_SIZE, qemu_real_host_page_size());
 
         while (1) {
             page_unprotect(start, 0);
-- 
2.34.1


