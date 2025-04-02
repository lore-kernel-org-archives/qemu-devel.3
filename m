Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D8ACC3601B
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Apr 2025 21:07:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u05Hq-0007jU-6O; Wed, 02 Apr 2025 17:06:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u05HP-0006fV-HH
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 17:05:47 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u05HI-0006WZ-2O
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 17:05:44 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-39ac56756f6so182987f8f.2
 for <qemu-devel@nongnu.org>; Wed, 02 Apr 2025 14:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743627938; x=1744232738; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=yZbL9HEXLhlzWM0wEEnYehKfsmjVyV6ys25T3H/AAyg=;
 b=hbJmOlUQQQxZXyCOv5j6YzF89pGVAJ6d44NkcYLNUDIq2ioqPbizJyqhcEpwwUuFTV
 bJyHwpNwwjjRWZqICSQGFMsVBq4iRFflh1embSDQkD2HQVzLKcAjYDccnhF3vfPNGgBr
 o77cMwN84NL8tvmnLk3b5AmCB4NVMi821q5PN1TJvJbgVPjZBD1hT119CLkOryD3/LR4
 jvDv891vBOpH2iEV9zsZZyUDwr/+NqNYsAhxTMpTQCZxTt5XoAQa1U6Bu8aMiA2E8TmN
 hNLWoncQGhJb1PQgETOArneGsHaP1CIzKeNSS2BFAQJQH24xGdHpbhrAfH7jxZMXbqIz
 yKUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743627938; x=1744232738;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yZbL9HEXLhlzWM0wEEnYehKfsmjVyV6ys25T3H/AAyg=;
 b=OMHBahMgTTNSoVzVrRVma9xX/QV1gQVs5rnXDazbnfDuOI7NlwZ8IjbpD1CBu537u7
 qVDG7FEGT4vIHUDxCDNS6+mKPZ5OxqnRhFoOlgFHxl0lMh9Asg34tqHG9zwH1zYf/Ba2
 A5kwrll+lnJoFaKF+glRhv+28EjUGCzcTi3ehxPkgCM27+sENSLXSv3+5J1h9idkiA3g
 30KhtPMDAD6luprwlnIR3q3C2O9ArXjIOEe2A3kaBLshzDxyJHASbTFf9JFUqcyjIhx0
 jpkH1lTAOxml9wLBpovMwHP3oiNqfoWMYJyRf2k+rgD3rkkTsvH3E9DXWFR6353Xomyt
 LdBw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUeKycKIYfI1gVhB98qzCWyw7JasGs72iJjD5kOSQ1bgdKYJtPYg/HNmKgefUrNFMoZzprCwBKVg9AB@nongnu.org
X-Gm-Message-State: AOJu0YwX5CNhieLcbLj1iF3aFWYiCCTSCJ3t91Bx4TamS/RhBhcluEWi
 j7CRL8QtpOhtgIROhV5KW1xNVvSdyZGd+fXzOhYWPoFvuxHsAHDjtIhy7Ekt+GXsrlpoMiGML6k
 K
X-Gm-Gg: ASbGncsaSFJTF5cCqa7fAd3oCd7K8miB/Q4vWWFUWyKtehRn975f6RI5MuR0Sk0CqVA
 1LX8VGwiKK6OhSqjq5ld3KHJWUv2OAQnE83sGRViBQD8i4URx7G1ZqOWABl+xbXsJ6A6kUKVH4p
 P6V1wmG4lpLZvBTwXLgeiQrdAn5kaGATrJVbDnlx2QcoMnO8scwxCdNt2vpCCswOS8Wz3v8PBz9
 /QxOf6198m+DkR+6Ce6mEpWeDwh7AJcrGdNsS0zidHiQBdest88KAatyb0teTzM/qJsCrFHdU05
 wd0t7cLX0lWBX7c1TZ+xVLvEDKcLA9BMk5nEokwjsmlVjVwNJt3uSm2GQWGj6CKFFO71cEDPW7I
 wUL8kJP6wW/Caffzr0Oo=
X-Google-Smtp-Source: AGHT+IFZYewMrZIU8iVT4Fjh9zvyR9NEHA+iVP1/21FedxSipl8M31ryniM+0s34Rxb7eC73txSz/w==
X-Received: by 2002:a05:6000:18a7:b0:39a:c6c4:f877 with SMTP id
 ffacd0b85a97d-39c2f8d5369mr117037f8f.20.1743627937839; 
 Wed, 02 Apr 2025 14:05:37 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec1795630sm2006255e9.29.2025.04.02.14.05.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 02 Apr 2025 14:05:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PATCH-for-10.1 26/43] hw/core/cpu: Remove CPUClass::mmu_index()
Date: Wed,  2 Apr 2025 23:03:11 +0200
Message-ID: <20250402210328.52897-27-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250402210328.52897-1-philmd@linaro.org>
References: <20250402210328.52897-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

All targets have been converted to TCGCPUOps::mmu_index(),
remove the now unused CPUClass::mmu_index().
Since this handler is now mandatory, add an assertion in
tcg_exec_realizefn().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu-mmu-index.h | 4 +---
 include/hw/core/cpu.h        | 2 --
 accel/tcg/cpu-exec.c         | 1 +
 3 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/include/exec/cpu-mmu-index.h b/include/exec/cpu-mmu-index.h
index 651526e9f97..a87b6f7c4b7 100644
--- a/include/exec/cpu-mmu-index.h
+++ b/include/exec/cpu-mmu-index.h
@@ -32,9 +32,7 @@ static inline int cpu_mmu_index(CPUState *cs, bool ifetch)
 # endif
 #endif
 
-    const TCGCPUOps *tcg_ops = cs->cc->tcg_ops;
-    int ret = tcg_ops->mmu_index ? tcg_ops->mmu_index(cs, ifetch)
-                                 : cs->cc->mmu_index(cs, ifetch);
+    int ret = cs->cc->tcg_ops->mmu_index(cs, ifetch);
     tcg_debug_assert(ret >= 0 && ret < NB_MMU_MODES);
     return ret;
 }
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 60b7abaf49b..10b6b25b344 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -104,7 +104,6 @@ struct SysemuCPUOps;
  *                 instantiatable CPU type.
  * @parse_features: Callback to parse command line arguments.
  * @reset_dump_flags: #CPUDumpFlags to use for reset logging.
- * @mmu_index: Callback for choosing softmmu mmu index.
  * @memory_rw_debug: Callback for GDB memory access.
  * @dump_state: Callback for dumping state.
  * @query_cpu_fast:
@@ -151,7 +150,6 @@ struct CPUClass {
     ObjectClass *(*class_by_name)(const char *cpu_model);
     void (*parse_features)(const char *typename, char *str, Error **errp);
 
-    int (*mmu_index)(CPUState *cpu, bool ifetch);
     int (*memory_rw_debug)(CPUState *cpu, vaddr addr,
                            uint8_t *buf, size_t len, bool is_write);
     void (*dump_state)(CPUState *cpu, FILE *, int flags);
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 6c6098955f0..5ced3879ac4 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -1076,6 +1076,7 @@ bool tcg_exec_realizefn(CPUState *cpu, Error **errp)
         assert(tcg_ops->cpu_exec_interrupt);
 #endif /* !CONFIG_USER_ONLY */
         assert(tcg_ops->translate_code);
+        assert(tcg_ops->mmu_index);
         tcg_ops->initialize();
         tcg_target_initialized = true;
     }
-- 
2.47.1


