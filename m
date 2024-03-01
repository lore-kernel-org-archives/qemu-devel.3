Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FCDBC5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 23:18:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgC2c-0005Vp-6V; Fri, 01 Mar 2024 18:11:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgC1Z-0003uH-4D
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 18:10:44 -0500
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgC1X-0005jU-JM
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 18:10:40 -0500
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-6e09143c7bdso2082525b3a.3
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 15:10:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709334638; x=1709939438; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e+A2qkcrgjaI9rrkh97Ktn6PEwqN2bQkXlFCXE4NZ3E=;
 b=oeJcwtgTJX/V7lI6hZT0mCyUq2eAwP1+2UqSQvIyRvdxYHQjqliIBmWcFvtsN4s+qE
 CZ38ZAQ00r4dOFdlQbGIEhLu+lCjf8e3Cf6FJgL+j6IIyvIak4m/I/kzMR0tCISI2WjL
 AuwcG7wxFTt8AWLERUFZI7BXoyO1HuVK1nx3bZZ/rfE2x6eZajCl1GrI3qO6SIBN6TRe
 F0N87W6Hxln0vWQzESLC+gizBVAUXefAIN02EVHH3FKAkBmldXKDCnDPUP5tR5quMIbv
 Gnq6n8eRUkPPgp1JjvE88WpqyvuR9V8SqxzU//5a2n6zokBAIjNIUmVv6Dh+6Lo0K64E
 f7Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709334638; x=1709939438;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e+A2qkcrgjaI9rrkh97Ktn6PEwqN2bQkXlFCXE4NZ3E=;
 b=EQKBJ1NysGWbDyryifs+Yvcsgq54VJLmpqHNh7hYEjmFw+KHY3qtiat6W58Xp2326f
 Zwhq4GQ9yoBg6nVILyZJAlFqpOBdwJgI7D80b5cHh491zf8bwlvOro+GfzwXjiPJlVXW
 jy73tcKGF4/I2fbMnyVKJ1GQzfzAGhS8wDSNxIPCLyUC67hgf7ze+fFcFosmLddviyNj
 cdawZPycjTCOFnlhKcqILMrE88LLMW8xae2DLs+EuV1LhqjBIAASIdHWNVarZ+NVR7Y9
 gt3tZiccUQ/CHuwsIQrQ1gYbFfAyxLG6kC3xQd3+k7+Ci+6OCJbsUToNhYB+QvaysavM
 aKnw==
X-Gm-Message-State: AOJu0YxKYmL6XpS93/qMpSW6lQJdgCLJWbDELHOdOqOf70EVm3dZNJkt
 rBvTS8AqzuE0Q3tEiQWs8q5qtmm16wonH7ec0JT1vGZHWFX9SSZz+KdukPkmIGR2axxmFyLfVzY
 O
X-Google-Smtp-Source: AGHT+IHQ3csya4deJDlDyiOd0b6E14P832Qcv/3NhxZlQSbOZb8Fgaxn1pDc4nHrebqcbvlwWtaR2A==
X-Received: by 2002:a05:6a00:2188:b0:6e5:5c83:c459 with SMTP id
 h8-20020a056a00218800b006e55c83c459mr3027504pfi.29.1709334638207; 
 Fri, 01 Mar 2024 15:10:38 -0800 (PST)
Received: from stoup.. (098-147-055-211.res.spectrum.com. [98.147.55.211])
 by smtp.gmail.com with ESMTPSA id
 c2-20020a634e02000000b005e438fe702dsm3449407pgb.65.2024.03.01.15.10.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Mar 2024 15:10:37 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Helge Deller <deller@gmx.de>
Subject: [PATCH 51/60] linux-user: Bound mmap_min_addr by host page size
Date: Fri,  1 Mar 2024 13:06:10 -1000
Message-Id: <20240301230619.661008-52-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240301230619.661008-1-richard.henderson@linaro.org>
References: <20240301230619.661008-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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

Bizzarely, it is possible to set /proc/sys/vm/mmap_min_addr
to a value below the host page size.  Fix that.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
Acked-by: Helge Deller <deller@gmx.de>
Message-Id: <20240102015808.132373-32-richard.henderson@linaro.org>
---
 linux-user/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/linux-user/main.c b/linux-user/main.c
index 12bb839982..551acf1661 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -901,7 +901,7 @@ int main(int argc, char **argv, char **envp)
         if ((fp = fopen("/proc/sys/vm/mmap_min_addr", "r")) != NULL) {
             unsigned long tmp;
             if (fscanf(fp, "%lu", &tmp) == 1 && tmp != 0) {
-                mmap_min_addr = tmp;
+                mmap_min_addr = MAX(tmp, host_page_size);
                 qemu_log_mask(CPU_LOG_PAGE, "host mmap_min_addr=0x%lx\n",
                               mmap_min_addr);
             }
-- 
2.34.1


