Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69A81D6B09D
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 16:41:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlV5K-0001OY-4C; Thu, 29 Jan 2026 11:41:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vlV5H-0001LM-VN
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 11:41:31 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vlV5G-0005JU-Ev
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 11:41:31 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-42fbc305882so843441f8f.0
 for <qemu-devel@nongnu.org>; Thu, 29 Jan 2026 08:41:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769704888; x=1770309688; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=70PrN5oP3fnguScyTi6SybftFcNtq8z4NK4DbniE0B4=;
 b=cXGQrNyVkCoxH+PyI6SFruOaSxxJE+s/sGI7rtyDvGR7sp1+eESAo9m7h4t0rTJqFk
 h1Fn+J/f7ts9RuLqWv5iWTUAOL8p0pbYVXnW9t1DeM3+L1PpB2ZO1wi+umbDYVgF6xRc
 zwp5TMysIjJKVbbHZvewU+O9oadTzg1MCVPMq1ndlQ8cq2HUl8tF4MFXJhn6oadBq8aF
 CUo6r008/6FtUNOh0QBRbCyiFGU9lVQIU4dmiugpJkalwLtnn5agT4q8zk5kGU6FNTF9
 xtb3XAWBVjE52LyNO2tjJwuA7m0REXkO0k8kr1xIYEBC+VQTlcB7Igp0NXH62Umqr7Rq
 FSgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769704888; x=1770309688;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=70PrN5oP3fnguScyTi6SybftFcNtq8z4NK4DbniE0B4=;
 b=e2/Jarmc4eJ5QRdvPZkO89TaCFVRRPeFsIQWN/5uIM2w1+XSY10C2N0pEgDLZru4Ad
 pqDbNomhwNh9rktHWQ5YB5g+DawNBlv6uW97AIKkd3UnqV0/b17bM3CspUbTUs6HBtAW
 GhyY75rp/45HW4iyvl2z9Zs8SVbMQNfp9t9r1++dAv3TwbWEreglsASmu39/yKYhxlfi
 0RYaBafnC2uyMYS5nMfl9s/SjAiLO9+o4ieLinemSmmjtnCkHohkJ0ms2B47NQLz1+ZD
 a0phVxz03za8HpZ1dINolb60hzvjcfA8pWZinUxaLzhtGJ4AjrcmhT4v9ta2Na5aPm2K
 NZaw==
X-Gm-Message-State: AOJu0YywHbpPQLV+wGmRRFavIaRlNdqyl5YRepJA8S4o0AoEXTM94Saw
 jkVZSNcxHD1b5F7XTrOF7z3QKfifRi0syH/Vez/EuZ/crCN/88uLdPk/iasz8G4txm7zJFmpKLh
 JgzotheQ=
X-Gm-Gg: AZuq6aL8Ye9YQoBvFPAw7u2yVcGoOSWhtP99UxYef8i6+AYw+0OZQpyah821xrnd3kN
 kTvnkbE1JTIIJ1f2mrDyP1rSrZdYsKr2z8IAnQV+8shnV4n9fmVVpWvu9aETPjGdXi/ZHpf+fDf
 OuPIDISQjo2W2i9d64/I9uVZcBEXe4uow+hOjwtH2Zk4t9Ntz6BMBA3fdB3s9JYwfzUXdszv0LV
 lWKp7ZF6nqRtBDI9pECLpyukIBP0vRk1NjZMvYZdNdO53d76/Gjy7y0dedJOd4fLNnOTwce1brp
 ezjpXc+TzsmeHFkjvqRnbHHjdsyQOZKYcf2J2B0Nq2a6i/DFuwb4c0FR5UP/5Ovq8rEdW7YrwBS
 5PsvfQS2sREp6fFLT0nAAbhyzLZdp9cx9NgBxsfwFzfnpUj/9whn/i5uBDW87NylhguBHEB0+Hi
 u/xuegzXJHdzcIMqp2/0sy6iV7qDwsrFOiw3hY8+A2SJjMxKP7wlonl+z0Ur9D
X-Received: by 2002:a05:6000:2dc9:b0:435:9d70:f2a2 with SMTP id
 ffacd0b85a97d-435f3a880edmr334811f8f.25.1769704888205; 
 Thu, 29 Jan 2026 08:41:28 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e131cfc9sm15677547f8f.21.2026.01.29.08.41.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 29 Jan 2026 08:41:27 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-riscv@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org
Subject: [PATCH v5 7/9] monitor: Truncate target register using ldn_he_p() API
Date: Thu, 29 Jan 2026 17:40:36 +0100
Message-ID: <20260129164039.58472-8-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260129164039.58472-1-philmd@linaro.org>
References: <20260129164039.58472-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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
index 6d6653aee6e..788bc9e330a 100644
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
 
 #define MD_TULONG 0
 #define MD_U32    1
diff --git a/monitor/hmp-target.c b/monitor/hmp-target.c
index 5738b47bb03..4472c122108 100644
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
                 case MD_TULONG:
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


