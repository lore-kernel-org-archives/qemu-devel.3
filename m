Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55405C98330
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Jan 2026 16:33:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vh9Bp-0004X7-9R; Sat, 17 Jan 2026 11:30:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vh9Bm-0004R1-GE
 for qemu-devel@nongnu.org; Sat, 17 Jan 2026 11:30:14 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vh9Bk-0006Uk-QC
 for qemu-devel@nongnu.org; Sat, 17 Jan 2026 11:30:14 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4801c731d0aso16349195e9.1
 for <qemu-devel@nongnu.org>; Sat, 17 Jan 2026 08:30:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768667411; x=1769272211; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DAVAZzpdqcWAjflTRJc0z0IisnYQy67T0tWSukHOWes=;
 b=Wr9rc1hyQ1C+3X39p+0YyI3+Jr29o0/aMucBpLee+7wi2M1qyjqIO9RxQ83ALC2kTq
 vepV4cz17lSE7Iqg1DucMa9mSOZaAig7hhhhTenKX6RHM37Tgp5e04y3MPC947+Atn+f
 D0XQwTSaZYxVQ7beUVhaU4ah4sph+OVx0Xmd/SBv3eUPcK4ZIVXLaEhjfZ167OD2HyZz
 5J6TGxXgDi6lnYydgKAj1clb/YHMnBfV7Wpmd8kjWJWzowFtO5aRixvV1QMY+7+JPsbd
 9aHvALtnhL+X0onFP+1SF4vZlFEjPx5v9ZqXcqJlSOxfbqvGZI/WQG2bIaI2sn7IsZBd
 vDtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768667411; x=1769272211;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DAVAZzpdqcWAjflTRJc0z0IisnYQy67T0tWSukHOWes=;
 b=OhcdevKbysWj/EXQV9JUBXOTL/MYvpoT5VEE+uGrMfjOh6g5KooKkWiZp9ROL95A4r
 /VfQopdwDKnohDJKvsSXn5utT7nuBaCy87VuP4AuST+9O9V3VqmbP2ww6ns59a2xuD63
 sy+YZyu39CMGQ63/8zQ+W2fvCosQ4fmOFicwloLObMW8yFWi0zDSdKmMJLe8ROkaddUh
 UInZyZiOnYgiuazbXYEZdrRkwFc1UrX0osJ+jrtQSZXbTRpvIVkuPjWYNwPwQ4HsJBmc
 sqtSibQiaiEkkNTswo3sD3Onn2H1IjfbPse1XTrp24k+6UOurcdUC2bYde8I32pm/dUi
 +eiA==
X-Gm-Message-State: AOJu0YzL5vUJpAqmwRYQz0Qc05n8qGly1M/sQNqh3gIIziwnohxRBrAt
 ZiGsZFTDT/7uOt11d3NYQotd1PGXUbulTaJDfUor9bcUegkLGJlj8e9IwUfwldwgmwB0uMt0pQF
 tzJL2aZk=
X-Gm-Gg: AY/fxX6q+vCKncv1lR6x2Xtw4Tjmy8TFsHfXwVe3MFTLFQCKbpMg68li9KzcDl2ibXz
 7xtzEXaJZNL3M3FZSgMG6nETlYZGkjRe4UxwoW6e1p6rEzh0iRSB3W5bx2LcqxqOmXtlnhQM9k3
 lEfcdZz5aV9oEN4XqN6mFpruQbNUhmmrsttHD0ojAZiF0bLuEErdvSYcjay03296jH3Cc8aXfHA
 EXUaYGrXdC+wHlx05g/RGihYUGP2o9eHMgGIxLJObIiaEIzKC44potEacBLR+y71VZKYdLNrbAc
 R8l7Q9SNaP8kyj6VJMxNm8tAVqO1pDEmZuDbzS2+OlfJYAhATSBQEtCfAbPC5eUAYa2PKRDtGwe
 eydi5OBqme34Gok7yx0Z6E0HtLt43popUv3IqMjwL6T8jfLBpi6SEX/DoDPi5B5PSXnobg8bWVP
 B+9c7dqqO3shlbJ06CpAIQtTCd7v/DYOUOYP4xzuriTPV9qzEGBujRbdVQmPyI
X-Received: by 2002:a05:600c:8286:b0:480:259b:3705 with SMTP id
 5b1f17b1804b1-480259b3772mr40982105e9.13.1768667410853; 
 Sat, 17 Jan 2026 08:30:10 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43569997f41sm11326816f8f.38.2026.01.17.08.30.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 17 Jan 2026 08:30:10 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 6/8] monitor: Truncate target register using ldn_he_p() API
Date: Sat, 17 Jan 2026 17:29:24 +0100
Message-ID: <20260117162926.74225-7-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260117162926.74225-1-philmd@linaro.org>
References: <20260117162926.74225-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

Rather than truncating with a target_long cast, use the
unaligned load/store API.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/monitor/hmp-target.h | 3 ---
 monitor/hmp-target.c         | 6 ++++--
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/include/monitor/hmp-target.h b/include/monitor/hmp-target.h
index bd9baeaa3ad..713936c4523 100644
--- a/include/monitor/hmp-target.h
+++ b/include/monitor/hmp-target.h
@@ -27,15 +27,12 @@
 
 typedef struct MonitorDef MonitorDef;
 
-#ifdef COMPILING_PER_TARGET
-#include "cpu.h"
 struct MonitorDef {
     const char *name;
     int offset;
     uint64_t (*get_value)(Monitor *mon, const struct MonitorDef *md, int val);
     int type;
 };
-#endif
 
 #define MD_TLONG 0
 #define MD_I32   1
diff --git a/monitor/hmp-target.c b/monitor/hmp-target.c
index ead195f5616..01be0a0b426 100644
--- a/monitor/hmp-target.c
+++ b/monitor/hmp-target.c
@@ -23,6 +23,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/bswap.h"
 #include "monitor-internal.h"
 #include "monitor/qdev.h"
 #include "net/slirp.h"
@@ -65,6 +66,7 @@ HMPCommand *hmp_cmds_for_target(bool info_command)
  */
 int get_monitor_def(Monitor *mon, uint64_t *pval, const char *name)
 {
+    const unsigned length = target_long_bits() / 8;
     const MonitorDef *md = target_monitor_defs();
     CPUState *cs = mon_get_cpu(mon);
     uint64_t tmp = 0;
@@ -87,7 +89,7 @@ int get_monitor_def(Monitor *mon, uint64_t *pval, const char *name)
                     *pval = *(uint32_t *)ptr;
                     break;
                 case MD_TLONG:
-                    *pval = *(target_ulong *)ptr;
+                    *pval = ldn_he_p(ptr, length);
                     break;
                 default:
                     *pval = 0;
@@ -100,7 +102,7 @@ int get_monitor_def(Monitor *mon, uint64_t *pval, const char *name)
 
     ret = target_get_monitor_def(cs, name, &tmp);
     if (!ret) {
-        *pval = (target_ulong)tmp;
+        *pval = ldn_he_p(&tmp, length);
     }
 
     return ret;
-- 
2.52.0


