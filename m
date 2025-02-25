Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72676C18E7C
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 18:47:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmzy5-0002fk-4S; Tue, 25 Feb 2025 13:47:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tmzx1-0002Bu-Id
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 13:46:43 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tmzww-0000HP-5t
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 13:46:37 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4394a0c65fcso60652275e9.1
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2025 10:46:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740509192; x=1741113992; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FbQf2cPMJ6YImQV1+hw0Op2lVZ36B/VbRboWjVjmjAI=;
 b=BDHQ1k4gPCnZYXo6oBjbr1lHeRgj4T5uVYiVNCkTeM60+vWRNUtdjPWg6ojykvWhfu
 31jmHtAhBZY+nmZMNTcf0fqykjqph15NpEtv8PNcz/KZUP5TRm0G2MwLooyf41vI0YpV
 lrZ/TQJ/dRQ5c8vwKuac3HAmaOTpjiNBVfu1WAz8LID3ckFlIFF/xA4xzzOjfmjPpdp3
 sn7hDG/ouMuUCZdDQ//nJ9KAy8wb5+MFl2X+RLvjTroRhXkLREkWoDZilcemCBX/bz5x
 GZv8AD32HAj++KAS4XLtDdLKDC0s4sngacSa+y1sEvnaZ/e4Ga4FidD2FzgAS4zUi9Bg
 OwEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740509192; x=1741113992;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FbQf2cPMJ6YImQV1+hw0Op2lVZ36B/VbRboWjVjmjAI=;
 b=N36HO3eZvEiv+h7KQ8n/N7y/f6fyMi5hNzA/jHTH65Y+1AtCSrd1hj9zDTEmCWOfkO
 tpE9E0wLAM4C+4sPFocmSAmgXpWSq90HaNPgA3Kf3tmlJPeRX1//yWcDN4Q6Bj6CVto/
 M1Otj0osOKgfk83dbBjRzyc0/sdVg1hKUuXjbUNxa38pvInGV9gcW32jo9/vZghz+dx5
 68EiemoWE9i9UqY+cJbAETpLThLWjn12tBv14tdRhbLw2ThFTI9Hp+ZObCtrF6Y7P6ET
 6nzVi2yJpP9LDencX0cHYaLFcfiWC0KUMoTGfko25HJHQnVkttOaemzX6LbCyAyXy/U1
 GMtw==
X-Gm-Message-State: AOJu0YxEduGm4HnSp7SiFfKXIOg/Cb11tMSa0QGqWix6B/nzm5ReUJJl
 J3z05vo2r3m4Mn8+lZgVRu1tGOAlQmxCbov4BirFZth6jeN+M6Cp0hhLztrUTXU=
X-Gm-Gg: ASbGncttMXJTLwv8IVnBiSq3wUHNpuDWb/KkOSVESD+06jQDo5mEIltG6l9+EYEnlig
 r9x0W5BWkqrPOeX8Bry0h4rs4EqareDIH1mbDPxNoGhqWtPI6faGdTG7FSZBScYVoSaSbK9/dv1
 m4ZUToVy0DdQzTmOUqhL+IxoovzAfsdApxr2nuYrGG3ZczcJ4SUy9OxJFFuOQOxdZDfZMGqgiKN
 +APU7hF6vAvILe+6rf2v8ozTnlAL55UZbNPbdt+Ctwzj2aEbHiquLopZIGwBBOHjo5Ihz7Dgf4j
 mgwjZhAX8xaRX0cq6P4GOLNSiSv/
X-Google-Smtp-Source: AGHT+IHon/W6vZRQ61+ptb2vCLc+aENikQGb6LrftS5FJ6cmGWUYzguPJeuxRXCh7w9syd4okplYxw==
X-Received: by 2002:a05:600c:5117:b0:439:86fb:7325 with SMTP id
 5b1f17b1804b1-43ab0f8dd49mr50464195e9.31.1740509191824; 
 Tue, 25 Feb 2025 10:46:31 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-439b02d854csm149295355e9.15.2025.02.25.10.46.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2025 10:46:29 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C83175FA34;
 Tue, 25 Feb 2025 18:46:28 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 4/4] tcg:tlb: use tcg_debug_assert() in assert_cpu_is_self()
Date: Tue, 25 Feb 2025 18:46:28 +0000
Message-Id: <20250225184628.3590671-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250225184628.3590671-1-alex.bennee@linaro.org>
References: <20250225184628.3590671-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Igor Mammedov <imammedo@redhat.com>

that will enable assert_cpu_is_self when QEMU is configured with
   --enable-debug
without need for manual patching DEBUG_TLB_GATE define.

Need to manually path DEBUG_TLB_GATE define to enable assert,
let regression caused by [1] creep in unnoticed.

1) 30933c4fb4f3d ("tcg/cputlb: remove other-cpu capability from TLB flushing")

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Suggested-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20250207162048.1890669-5-imammedo@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 accel/tcg/cputlb.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index fc16a576f0..65b04b1055 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -73,11 +73,8 @@
     } \
 } while (0)
 
-#define assert_cpu_is_self(cpu) do {                              \
-        if (DEBUG_TLB_GATE) {                                     \
-            g_assert(!(cpu)->created || qemu_cpu_is_self(cpu));   \
-        }                                                         \
-    } while (0)
+#define assert_cpu_is_self(cpu)                             \
+    tcg_debug_assert(!(cpu)->created || qemu_cpu_is_self(cpu))
 
 /* run_on_cpu_data.target_ptr should always be big enough for a
  * vaddr even on 32 bit builds
-- 
2.39.5


