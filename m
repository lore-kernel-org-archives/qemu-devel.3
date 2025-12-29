Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6DB5E94102
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 23:17:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaMTU-00078y-2t; Mon, 29 Dec 2025 18:16:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vaMTS-00078h-B9
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 18:16:26 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vaMTQ-0004UV-Od
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 18:16:25 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-42fbc305882so4504759f8f.0
 for <qemu-devel@nongnu.org>; Mon, 29 Dec 2025 15:16:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767050183; x=1767654983; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tRjjc7lfYQ8D8uomPsApNwxrP+NzSvQIdNMc+3yOG78=;
 b=ciNVhyZXI8E2v2vvO8jIWq9jjme0FtbNRGaM6tXLuGx5zt53OL45IpjtqRmpECJtIZ
 B6JqLaulASAaOkPU9IzFTKI/JCp2y3CpnxseTKeuz7DPlhvlceAqh0hzrxE/IYu+dObT
 giHQpsUZF0lWoo0/2c4uRhHzV1qKuuElBaDTDv8GpIwc1bmPQyW2UZ/MB1peQdhKZsI9
 HckRQyJnrV7I++zG0d+rmnIYt5hbqktWTovApF9jth4FsLMwlshtS9eJo5x5+qgHv0pj
 FUDPCR03qQ2yIe2ipXzYKD+yiv0bsfGn6Ku/XRAZv5C60CfqQYQztgVuH8obJ7ZjM0gQ
 Km3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767050183; x=1767654983;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tRjjc7lfYQ8D8uomPsApNwxrP+NzSvQIdNMc+3yOG78=;
 b=l4p2I1cTNdsGUd7Mg5c7MU8X3TIe8oHr8TOtvgIoSUOXmXtTTlg6KBpEYk6csZeKzc
 39TS2xKxaGiUVPUQdpjF//JFfQAvQloX3c8H0g59L+I0+sF3SKH9wqTXpN8HMZier/Zy
 PsE+2X1FSxPz0y8b5qdvFgE7ubgfX7Fl4NLRtl+8OX2XALmje0Ranax1eG5vZDFO6hkJ
 sLsGkdF4Y6sO48F8t/1XDLFcivpvVb4px8uNvlwbnM1ZQAph1T/enQ8FMWU8GDseLb+R
 Rrf/ueChwl2GTofO6SiJoaen84rHTCWYpT0tRz8BPBhgZVbhUBf7nZt5wsO49LJoJxBe
 xApQ==
X-Gm-Message-State: AOJu0YzSoRMEZ/zDe5ucTAgs6KYDPPgIUIGrku3ZWWBtCkrEGoY54kMM
 4Rc+55EN/cwjnNuSqe03DoB8t0FexShdV+cIYFOr+COepjf2mHp+YoaLJzlymFtDQNWioKk0LtA
 AKcPeXr0=
X-Gm-Gg: AY/fxX4Ur6Y1UTKg6QQJe90KUFZk5ThI9PuerytyvWIaFSQDFJy/8IISmnJMjXKR5Ve
 TqC5ZNzBFCiRRaQ85ACBuoctYr4td1RfqZEFqg6tbOvCtmbdWBXL4WRIHSTr/9Eoo938Z300gYV
 jDvEQ9tTHtWOhLMuznB0RM45kMUUWNtkJRBxAfTBORGJWXpcPV7mhOyEM1W7vIqv0abFyKBwvb+
 fAOAbh877xdfUURwsMH+pvv9eg8imFhgOXG+CI2f2hzZIX2rA/SQtXYfziUGueNrl3aFUiiMZPp
 DQ57JOgWqnYy3PrczWnj/jWfZLdqruu1J0MEez1S25LeTXFAwOqdP2y9qJlVdtGv9xzPDkX91LJ
 7AVMnn+fJfVQeyZCsZ5lRXRYr5O0e+4Cd8K6bu0yzIh8JhWxYcTk33o/jv/UQVEmG+26j3kcQ4m
 QMMFQCjsQaIbwk433T0DTJeO5t1qQ4adGP5a2SikvZP2saBrZjSJk9fHT8t3uB9Li5GI2sigk=
X-Google-Smtp-Source: AGHT+IHjeP8YnRf5hocqn3gvAip5bKbPQY15bYsOs9iw1ZPOJlasI7+rNcd7zRfvZKKQDeBB81A9Tg==
X-Received: by 2002:a05:6000:2404:b0:42f:bb3f:c5f1 with SMTP id
 ffacd0b85a97d-4324e506738mr38846097f8f.44.1767050182682; 
 Mon, 29 Dec 2025 15:16:22 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324ea227e0sm66584791f8f.17.2025.12.29.15.16.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 29 Dec 2025 15:16:22 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 5/7] monitor/hmp: Inline ld[uw, l,
 q]_p() calls in memory_dump()
Date: Tue, 30 Dec 2025 00:15:43 +0100
Message-ID: <20251229231546.50604-6-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251229231546.50604-1-philmd@linaro.org>
References: <20251229231546.50604-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

Remove the last target-specificity in this file.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 monitor/hmp-cmds-target.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/monitor/hmp-cmds-target.c b/monitor/hmp-cmds-target.c
index 7c8bddabbac..e782259c3e6 100644
--- a/monitor/hmp-cmds-target.c
+++ b/monitor/hmp-cmds-target.c
@@ -129,6 +129,7 @@ static void memory_dump(Monitor *mon, int count, int format, int wsize,
     uint64_t v;
     CPUState *cs = mon_get_cpu(mon);
     const unsigned int addr_width = is_physical ? 8 : (target_long_bits() * 2);
+    const bool big_endian = target_big_endian();
 
     if (!cs && (format == 'i' || !is_physical)) {
         monitor_printf(mon, "Can not dump without CPU\n");
@@ -192,13 +193,13 @@ static void memory_dump(Monitor *mon, int count, int format, int wsize,
                 v = ldub_p(buf + i);
                 break;
             case 2:
-                v = lduw_p(buf + i);
+                v = (big_endian ? lduw_be_p : lduw_le_p)(buf + i);
                 break;
             case 4:
-                v = (uint32_t)ldl_p(buf + i);
+                v = (uint32_t)(big_endian ? ldl_be_p : ldl_le_p)(buf + i);
                 break;
             case 8:
-                v = ldq_p(buf + i);
+                v = (big_endian ? ldq_be_p : ldq_le_p)(buf + i);
                 break;
             }
             monitor_printf(mon, " ");
-- 
2.52.0


