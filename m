Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6B65CD342C
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 14:05:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKcrb-0001oD-Vc; Wed, 06 May 2026 10:04:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKcqW-0008Bj-Pr
 for qemu-devel@nongnu.org; Wed, 06 May 2026 10:03:28 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKcqS-00010z-Tk
 for qemu-devel@nongnu.org; Wed, 06 May 2026 10:03:28 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4891c00e7aeso55426585e9.2
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 07:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778076201; x=1778681001; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=dgC99C4QHuUTSka7Jdb/jzkeq+ba0Okc1oUiPSrq668=;
 b=PZejho8OC/gwUjv35N4UwznsCPOvwyrSrPmNF2Cc2Fer1oPPqNNQYLMw7dEsLefckm
 Glr0HyQ5opzN8W5wOZi2U/9O3uQ1+Bn+usuUXzCS+aXb1WwGeoEtlcGISxdbWSja7MN1
 mQqWWbF33NQQic9bGoAoqP/6F6ZUkG7D+z1LRP06rCgtrHpJXhwdnXkyyuCMQNNI/vkq
 xUL+LUIJZ2ZMucTDHg1g2/hDe6mJyXXp/AfeyywdFN83oVWjyvg2bhh9voWrxQXxVhLS
 HQQFXa35XRIYFB/dKWK+S1KbSQqwJvtlesg6Q8lVD5X88qsE901udId9Q7ntfPIm5iyQ
 BFag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778076201; x=1778681001;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=dgC99C4QHuUTSka7Jdb/jzkeq+ba0Okc1oUiPSrq668=;
 b=kvKvPbTIEwjv7dfdGJl9woolIUMJYXuK4CxwM7x/J75QPKWUDOGaJfclUItTcpS5in
 CubXCJPxwei/sD9K0INMhLvcnsMyR+6uzTodKauF0D65Pz2um/laiFiS0sPr7LAuNxrK
 4q2ywwbht6xxpEUdiG0HhkHzD4BFu9xuZqxSzZ6rG0JIiWBr/wcpt2KDBlFUYc4mWem6
 HEtAzIxnZ5LlXU1tqFhrdWetDT2bHBl3wpjhmn7OBYKPyKkzAt1q9nYqnQ35qREHAxaf
 pxXE1sjPKxGRj6MIwShgKQeou53lRzOebT2KEWBgxYWVqKgv8ISDhwk3N/jM6BjnlgCM
 iOmQ==
X-Gm-Message-State: AOJu0YwiohlWdOw9weeD+hkRhUz2azxUWbkgnDsyxnEuDhVLqprn+c+T
 7HE+EHPoOXwDbeSQluGF6r6oaJANhhPA7Egy+xvF1W4si9S4bJW18QssTCa7Igg5/vwYk3b8FL/
 wVKjgL0g=
X-Gm-Gg: AeBDieugfxWuEWUsqOGtJHc5sjJ4kGEyc46m/dXS39CCuBpuYNoGVUEJSekv7t61xmU
 xj9S7reXQ9blDgmd1Evf31L8uLxIjGainYbLcraH/wclWwC7RiP9S6P39+/zFO9Sea+Pf3BVwfU
 FmmFLYSWl1yQkQMekjfLmb2jUcGwdCyYhqOmmIsYFl5cYBKh0T/4rN1mCePNCUw/rZpcG4ly8pC
 35x1jM1gC+zuHc+DX7xCsRutg9S1T3ILBpR46+3Lwd/zROR37aRYXoA5McrPj9SNLWmjddyTguQ
 hJwqAR0xHBV7QpiIm8cVrwDJRuaG7kdDzcGAO82X4tT8FsQgyv43tVMvSecKJsMYq2M1X7AGEqE
 uzlr6YVX1rPxHm4JQS3ZuMLXpcRVyhN12e9bI9iUIHCNLqZkiJEvUs2X22MIdASmwxFY4JG91Yv
 R7+yGsSWrVApRu1mUxiEm1s5DO9+4Fz6+wM5j8NKNyATDKTwR7razG8GB0vOcGfBEX/bQvctDuj
 fwhp4hhUvM=
X-Received: by 2002:a05:600c:8115:b0:48a:53ea:1408 with SMTP id
 5b1f17b1804b1-48e51e1804amr57241575e9.8.1778076201271; 
 Wed, 06 May 2026 07:03:21 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e59b74277sm12014325e9.3.2026.05.06.07.03.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 06 May 2026 07:03:19 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 061/110] monitor: Forward-declare the MonitorDef type
Date: Wed,  6 May 2026 15:54:33 +0200
Message-ID: <20260506135524.20617-62-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260506135524.20617-1-philmd@linaro.org>
References: <20260506135524.20617-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Rather than having core header forced to include "monitor/hmp.h"
to get the MonitorDef type declaration, forward-declare it in
"qemu/typedefs.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20260427080738.77138-26-philmd@linaro.org>
---
 include/monitor/hmp.h   | 6 +++---
 include/qemu/typedefs.h | 1 +
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/monitor/hmp.h b/include/monitor/hmp.h
index 357fc972885..d423f54f904 100644
--- a/include/monitor/hmp.h
+++ b/include/monitor/hmp.h
@@ -24,11 +24,11 @@
         g_assert_not_reached(); \
     }
 
-typedef struct MonitorDef {
+struct MonitorDef {
     const char *name;
     int offset;
-    int64_t (*get_value)(Monitor *mon, const struct MonitorDef *md, int offset);
-} MonitorDef;
+    int64_t (*get_value)(Monitor *mon, const MonitorDef *md, int offset);
+};
 
 const MonitorDef *target_monitor_defs(void);
 
diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
index 416a8c9acea..07f2ae7c9f1 100644
--- a/include/qemu/typedefs.h
+++ b/include/qemu/typedefs.h
@@ -72,6 +72,7 @@ typedef struct MemoryRegionSection MemoryRegionSection;
 typedef struct MigrationIncomingState MigrationIncomingState;
 typedef struct MigrationState MigrationState;
 typedef struct Monitor Monitor;
+typedef struct MonitorDef MonitorDef;
 typedef struct MSIMessage MSIMessage;
 typedef struct NetClientState NetClientState;
 typedef struct NetFilterState NetFilterState;
-- 
2.53.0


