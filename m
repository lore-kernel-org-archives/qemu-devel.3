Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EB50C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 07:37:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvBQ5-0006zl-EX; Fri, 12 Apr 2024 03:33:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rvBQ3-0006yh-Po
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 03:33:55 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rvBQ2-00076m-7N
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 03:33:55 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1e3e84a302eso4959245ad.0
 for <qemu-devel@nongnu.org>; Fri, 12 Apr 2024 00:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712907232; x=1713512032; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qyr/Ts8Rn5hOhvh/4SLos/fwt7+2NBBMVS+YXiC8DT0=;
 b=VvfbjnnzFXryrybZSXsWtuc97xkdxA3A9l6/f/WNc9652gAHjBunrhAOqgtv5gtm8w
 c7rZOo35DswuFVNIT03tigsEbiwuQCTSxkHWZae5Sj422mqiP1MK2xoSGDfqvNzJhW3q
 bGWB6pfF/HTilifFCuYHARFF2k3jVkSnILPaxDJlcJStTJICA0ZhGXkP0I9ngH+K9Fd9
 Mdqcrmjsy6rok338UG7tWxkC0uR5fNZf7Bry0ynMZwToqSdhjESrUerDcVrjYR5DmIUd
 7jS13ZVurCJ+BAzAJdRb2KuM51fRGjJYz1i/FPetX9Bga/3rKtnM+Zw9A8E7DE1Utiml
 H4tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712907232; x=1713512032;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qyr/Ts8Rn5hOhvh/4SLos/fwt7+2NBBMVS+YXiC8DT0=;
 b=TycboKdIINWdTPflxM/BBDqnn0ESC9REnPLHjWtsVlClWnhCXwuOhp8568EXofSAND
 sDe63JuL/rgqIkMQIl7+FC3b22fMx10iBvXgHfDz2jJHG/FouzcMAGcUUk7KXQK0MHao
 m0iKDVwmY+/auX3nzED1NEMjWWu6e2BMES3lQDZ+Y+d1gw386AQ2BIIyXwcBwKDyYa+A
 SCLQW/5QFDNeNMTI3VtgwJAx9Ym/My7ZO0O1UgOv9FiyFsAdcQ3fkp9gW/yh1By1PQ8I
 IAr1cv5Vj2dzvsZI7t3HJkURjpxXdh8yn9d/KqjoDHFTGaL+4JRDzoVViYcNiFuvzv06
 yCGA==
X-Gm-Message-State: AOJu0YzlupyETpjFLb1/UEdkN5xxN5C0DNEz2dLkEO6Kmrxq8NceXB6d
 oTZan4Z9HnnqdJvwN3QBmr/W3O51ujhawoe1b5TQYSgzbS3wn8dmOmZmpMw6O0+Bi5aPRG2/OWC
 G
X-Google-Smtp-Source: AGHT+IFywLt/S5guoQIEXM/568KzcCsZ2G+2Zsqnsoe2NUlN1r56usylDUOLQpM6d6ql/pJvx6G0nQ==
X-Received: by 2002:a17:902:c40b:b0:1e1:4806:79cb with SMTP id
 k11-20020a170902c40b00b001e1480679cbmr1948271plk.56.1712907232517; 
 Fri, 12 Apr 2024 00:33:52 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 e5-20020a17090301c500b001e556734814sm2206099plh.134.2024.04.12.00.33.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Apr 2024 00:33:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 06/27] hw/mips/malta: Add re-usable rng_seed_hex_new()
 method
Date: Fri, 12 Apr 2024 00:33:25 -0700
Message-Id: <20240412073346.458116-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240412073346.458116-1-richard.henderson@linaro.org>
References: <20240412073346.458116-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

sprintf() is deprecated on Darwin since macOS 13.0 / XCode 14.1.

Extract common code from reinitialize_rng_seed and load_kernel
to rng_seed_hex_new.  Using qemu_hexdump_line both fixes the
deprecation warning and simplifies the code base.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
[rth: Use qemu_hexdump_line.]
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/mips/malta.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/hw/mips/malta.c b/hw/mips/malta.c
index af74008c82..664a2ae0a9 100644
--- a/hw/mips/malta.c
+++ b/hw/mips/malta.c
@@ -26,6 +26,7 @@
 #include "qemu/units.h"
 #include "qemu/bitops.h"
 #include "qemu/datadir.h"
+#include "qemu/cutils.h"
 #include "qemu/guest-random.h"
 #include "hw/clock.h"
 #include "hw/southbridge/piix.h"
@@ -850,15 +851,18 @@ static void G_GNUC_PRINTF(3, 4) prom_set(uint32_t *prom_buf, int index,
     va_end(ap);
 }
 
-static void reinitialize_rng_seed(void *opaque)
+static GString *rng_seed_hex_new(void)
 {
-    char *rng_seed_hex = opaque;
     uint8_t rng_seed[32];
 
     qemu_guest_getrandom_nofail(rng_seed, sizeof(rng_seed));
-    for (size_t i = 0; i < sizeof(rng_seed); ++i) {
-        sprintf(rng_seed_hex + i * 2, "%02x", rng_seed[i]);
-    }
+    return qemu_hexdump_line(NULL, rng_seed, sizeof(rng_seed), 0, 0);
+}
+
+static void reinitialize_rng_seed(void *opaque)
+{
+    g_autoptr(GString) hex = rng_seed_hex_new();
+    memcpy(opaque, hex->str, hex->len);
 }
 
 /* Kernel */
@@ -870,8 +874,6 @@ static uint64_t load_kernel(void)
     uint32_t *prom_buf;
     long prom_size;
     int prom_index = 0;
-    uint8_t rng_seed[32];
-    char rng_seed_hex[sizeof(rng_seed) * 2 + 1];
     size_t rng_seed_prom_offset;
 
     kernel_size = load_elf(loaderparams.kernel_filename, NULL,
@@ -946,14 +948,13 @@ static uint64_t load_kernel(void)
     prom_set(prom_buf, prom_index++, "modetty0");
     prom_set(prom_buf, prom_index++, "38400n8r");
 
-    qemu_guest_getrandom_nofail(rng_seed, sizeof(rng_seed));
-    for (size_t i = 0; i < sizeof(rng_seed); ++i) {
-        sprintf(rng_seed_hex + i * 2, "%02x", rng_seed[i]);
-    }
     prom_set(prom_buf, prom_index++, "rngseed");
     rng_seed_prom_offset = prom_index * ENVP_ENTRY_SIZE +
                            sizeof(uint32_t) * ENVP_NB_ENTRIES;
-    prom_set(prom_buf, prom_index++, "%s", rng_seed_hex);
+    {
+        g_autoptr(GString) hex = rng_seed_hex_new();
+        prom_set(prom_buf, prom_index++, "%s", hex->str);
+    }
 
     prom_set(prom_buf, prom_index++, NULL);
 
-- 
2.34.1


