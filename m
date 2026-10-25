Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BBA2606A31B
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 07:20:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKsW9-0006DD-B4; Sun, 25 Oct 2026 03:19:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKsVu-00069w-Fv
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:19:33 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKsVs-0003fl-UH
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:19:30 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4a20bdaf39cso21339705e9.1
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2026 00:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792912767; x=1793517567; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=b0vhxeYkB0f7jueslfslylyQdyNCvCfhhkGGRbqXwxU=;
 b=weuHVIVp+Pbf64NMF5aUl/KYNo5v/Vx4BsM6wFBIIKM7nZKJpafi2xqo0tnasL5qA7
 miCCIIpllQau0sxUHniCb34XB0+kzmR1xnIneCWVEPeawHXjM2hEm8HkpdmdeugFHVHB
 /lYrXBwQj6HVhbIw9tXNJvKRMwnt+0SKDnCzWOlAfRuT8c4ckjMFKG+Io9ecKOdl9Jhz
 UmyfRr3/EKTk3c4fQgyCY1gChfJDj8v30nbtq7ZwDtBOPGZIGflvi/4E6ygRVZC6pYHm
 WQYuBQd1SmesX+KkUFpkX75WmIRGi9KpLM5XV/I3l9ZmCKCOIeTsb4MpYPMZcb/fn0kF
 CJBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792912767; x=1793517567;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=b0vhxeYkB0f7jueslfslylyQdyNCvCfhhkGGRbqXwxU=;
 b=hkD18JyVxtwH+OlyqMrT5uMQn/o7Ddf3DBbHxXmaviuKrK6fP0CuDKTEOqhmjN+rBp
 LGwCuknF8y9hJYrGrwnWTRjpULlHZrFoy8VGg3/pWsIyLiFBk0pJI7OZzL4DpG8K5zdx
 O+DPhb5cEp8ofH7QFVJeVvJbezcrIm/4eGm8ZtYTRQWCFnknjkpvRjjR5bXhXIEbbK/1
 P8aIJbVJMIiPn1maQ1zGpE+tmh4ZATfdpYJoi0sf7shoUUizOTyyCg9P5N8R33Lkd62i
 TeiF7szOGXCe9sp4P4xZnKvXWKgb0XrHSzwTZEybiG1lAHfnf07YdtHAsMmPGebpsxoH
 /Jow==
X-Gm-Message-State: AFq9FYLPqkGpSiqA5w6EBkl5+KidIuQ6+yJE9+jvokiaiLRWP9GLkrZR
 5BUIO3YWZ6V8sj3YBkq2T1Fk92ynCFQxmzWD7CmuEJsI2qiuL0uQQJhpXjP0KXBvN4wADHMaiIk
 04UJN2rg=
X-Gm-Gg: AYBFou1C2KGpOwu32BowoxboTuUO4ChDnLh3YiKM6jLxX0xCdTg+NCWxOAMXGioFjtg
 LD/yzmh7xd/ohgJPM8OWQt8f+9dL348dniZud7CD9hD5zLYEwEk5mE/XrN+SuSCLZS8vpFr6yG+
 P33SKIjwdAGQXrQ4uxB8nNQkAaNDlsXt6LdKSU1RtzgP2PVkwcmC4FKFtwcY7nF/EAljVj4B/Yp
 liWk+fiYnlfNHouzEMMu09QNfia9rc8M3TSUFjm1a7uJXMWshI7gaR9X0rkm8pIFIJ4y5Ndjy6c
 NGTp589NhcVSSDEnG8ddnfIEU41puCouOGWJDYX3G9VDs+HRzpXzRJVa0PRiIjyZLBus7KO0ttE
 SLbRu0qfTbJsmXPwCj3haxRhtk7mwQpZVWA/49BkL83XP030eAquMeCZLENjNjMagKhllmV55YS
 /J5Bq6VVBlpeMzCimuHe24Sd9GdGJkSLpdO4QZ6BWM2YuawYM8DmLmerJiu5chP+EwzXcesRcEz
 TKbvCODOc9ZbCE6xuc3NdAoRHjAKbTjpIIXbPCXO/AFxGPbY5z9JmjEBg==
X-Received: by 2002:a05:600c:3b04:b0:4a2:8f4:96c with SMTP id
 5b1f17b1804b1-4a35acb6c17mr57580225e9.29.1792912766657; 
 Sun, 25 Oct 2026 00:19:26 -0700 (PDT)
Received: from stoup ([176.95.65.245]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e4806e208sm4006309f8f.40.2026.10.25.00.19.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 00:19:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Matt Turner <mattst88@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 005/100] tcg: Prepare for easy temp lifetimes
Date: Sun, 25 Oct 2026 08:17:40 +0100
Message-ID: <20261025071915.1123867-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261025071915.1123867-1-richard.henderson@linaro.org>
References: <20261025071915.1123867-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32f.google.com
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

Reviewed-by: Matt Turner <mattst88@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-temp-internal.h | 2 ++
 tcg/tcg-internal.h              | 5 +++++
 tcg/tcg.c                       | 4 ++++
 3 files changed, 11 insertions(+)

diff --git a/include/tcg/tcg-temp-internal.h b/include/tcg/tcg-temp-internal.h
index 98f91e68b7..932ad1aeeb 100644
--- a/include/tcg/tcg-temp-internal.h
+++ b/include/tcg/tcg-temp-internal.h
@@ -31,6 +31,8 @@
 
 void tcg_temp_free_internal(TCGTemp *);
 
+G_DEFINE_AUTOPTR_CLEANUP_FUNC(TCGTemp, tcg_temp_free_internal)
+
 void tcg_temp_free_i32(TCGv_i32 arg);
 void tcg_temp_free_i64(TCGv_i64 arg);
 void tcg_temp_free_i128(TCGv_i128 arg);
diff --git a/tcg/tcg-internal.h b/tcg/tcg-internal.h
index 2620c23b44..d480d10878 100644
--- a/tcg/tcg-internal.h
+++ b/tcg/tcg-internal.h
@@ -74,6 +74,11 @@ bool tcg_target_has_memory_bswap(MemOp memop);
 
 QEMU_RET_NONNULL TCGTemp *tcg_temp_new_internal(TCGType type, TCGTempKind kind);
 
+static inline TCGTemp *tcg_temp_new_ebb(TCGType type)
+{
+    return tcg_temp_new_internal(type, TEMP_EBB);
+}
+
 /*
  * Locate or create a read-only temporary that is a constant.
  * This kind of temporary need not be freed, but for convenience
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 65d3190a8e..c3fdcfbe68 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -2201,6 +2201,10 @@ void tcg_temp_free_internal(TCGTemp *ts)
 {
     TCGContext *s = tcg_ctx;
 
+    if (ts == NULL) {
+        return;
+    }
+
     switch (ts->kind) {
     case TEMP_CONST:
     case TEMP_TB:
-- 
2.53.0


