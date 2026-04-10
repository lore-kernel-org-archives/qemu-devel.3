Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FC8DF45A08
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 19:56:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBHxN-0006Fr-2I; Fri, 10 Apr 2026 15:55:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wBHxL-00064f-6m
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 15:55:55 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wBHxH-0003N8-IQ
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 15:55:54 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-48896199cbaso25900715e9.1
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2026 12:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775850950; x=1776455750; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j1FsrkHiiVfTWUBHqJkrxULfXG6j6GR2S4+XnGN40SU=;
 b=Weo9G5EvHvy6O5IG4GSe0RjE58zSpZEThDd346JX8LS5B/a30XZAoOz3A1J5MErOsa
 liMqSzy15Bq22DXqj459EC3/Ch9kvrZD6He6oR/7xg927h//+ZG61lUWdwLj05904kf+
 GQcS93YHACunEVTl6MulLMiaLlsR9A+romv68N1xWT5YJYyG9Trnm9ad1SSQQV8sNUUC
 rQ6t0m5E1ZKsJH7SQnhLYmv9bxTjvoZDwFY1EYvfmfcFl9ig8mPieKRTPahlGwn6ttNa
 +bJq/PosKpcZfesPSHtzYWzPD2oZLaLLuBW32C/RJVOgFFmhYJejhUP7sbpg2+qSE1pi
 DXkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775850950; x=1776455750;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=j1FsrkHiiVfTWUBHqJkrxULfXG6j6GR2S4+XnGN40SU=;
 b=k6KROcqKFhAub5cqXFerRY1SehOFgU1pVKx4hZswvpV0G8FPrlGjhbCGrcUsoURfW6
 J/2FDXIKesJp+7EM49sK9HiBfX8HEKv7q4qQmp5tUBaBr/bA5fCJdrWWpdopWBvRpLhX
 DqVtbYyShk198le0dz4Bw/xjaj0GIplBAiAApHDyKTjcFWlP2c/BGICgq5i9HxRbk99i
 DhOTH7Pz6+AaoU+B/8WIDn9yuHpizILcbjAhtEiLuJaMhBguXngD8Ai1+1Pn99uuC+Is
 oaz8fypQAFBxT/61MMbO0aVbRYp6nWmCpFi1VnRSBp5ToaLIGwMzRXNuvHSKoIHV5XAH
 mxvA==
X-Gm-Message-State: AOJu0YxTiZ+IgFmyFZQujP8Gvga8Gm19Eei6Q/9R8u5O29idklPULWys
 ft3WRq0lDRsRd4U8s2vDP5gs8+nOO1B0RKwIdFf3TnrV1UYInnSjBKCwKXfPH3pebDcqmTdVRti
 pWf+PEnY=
X-Gm-Gg: AeBDietBq2KGirQfN6zFdBJy1rX2m4FlhzBRCP7bX9fGtBmHy20wi7ivtorkV0CQy5L
 Bnmt72WHFKoSZhIZ77LPIbrOuw7lO8UWBe/bALpeSpse+U1BQU3bNKKemVnvHLySL4wIQt+HqwG
 p9Y6B+w9pdaspUG+7/+RGMzkCpajbagws0Bf6kG/fhc+4tw/+viyKP1lmBGgJSHi4Eenbu7IHEV
 QVVWXMgvZizcshjdMIh+/BX/5nugIXYNkwY+LlwtzebQWRDUYUoTQcL0Q+P5qA5rx2P7CZPTeet
 mxwUe3HWTwnkXedLvnEfdkTB1HGYwbAi5TgyMTJMHuYNfnXPn3BEpBE5/ux6MjeZ81B+iLHYVug
 4hUtiRxuvFQBMKEPnJQG2MYyBZzWx27BuC+ywnl4zAwtmK7fcPBjuBhSeFNZk0cSUCUAa4f0IpV
 6Np6S4iQEDRs4gP7mE7LoRs3hD7V9yADHwOMe9bfUz4YrDf0YXqSpdE2YYk0Yfwy8CBa0DZQKx
X-Received: by 2002:a05:600c:871a:b0:488:c683:be89 with SMTP id
 5b1f17b1804b1-488d67f0b8fmr60065145e9.9.1775850949623; 
 Fri, 10 Apr 2026 12:55:49 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488d525c931sm98623515e9.0.2026.04.10.12.55.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 10 Apr 2026 12:55:49 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-riscv@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, qemu-s390x@nongnu.org,
 kvm@vger.kernel.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Jason Herne <jjherne@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Cornelia Huck <cohuck@redhat.com>
Subject: [PATCH v2 20/27] hw/s390x: Reduce 'monitor/monitor.h' inclusions
Date: Fri, 10 Apr 2026 21:53:14 +0200
Message-ID: <20260410195323.17937-21-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260410195323.17937-1-philmd@linaro.org>
References: <20260410195323.17937-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

We want to make the HMP commands available for all targets,
move the declarations to "monitor/hmp.h" where all other
are, and only include the monitor headers in the source files.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/s390x/storage-attributes.h | 4 ----
 include/hw/s390x/storage-keys.h       | 3 ---
 include/monitor/hmp.h                 | 5 +++++
 hw/s390x/s390-skeys.c                 | 2 ++
 hw/s390x/s390-stattrib.c              | 2 ++
 5 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/include/hw/s390x/storage-attributes.h b/include/hw/s390x/storage-attributes.h
index 66716a97c05..0305873b019 100644
--- a/include/hw/s390x/storage-attributes.h
+++ b/include/hw/s390x/storage-attributes.h
@@ -13,7 +13,6 @@
 #define S390_STORAGE_ATTRIBUTES_H
 
 #include "hw/core/qdev.h"
-#include "monitor/monitor.h"
 #include "qom/object.h"
 
 #define TYPE_S390_STATTRIB "s390-storage_attributes"
@@ -72,7 +71,4 @@ static inline Object *kvm_s390_stattrib_create(void)
 }
 #endif
 
-void hmp_info_cmma(Monitor *mon, const QDict *qdict);
-void hmp_migrationmode(Monitor *mon, const QDict *qdict);
-
 #endif /* S390_STORAGE_ATTRIBUTES_H */
diff --git a/include/hw/s390x/storage-keys.h b/include/hw/s390x/storage-keys.h
index 2d02936c31c..666c05e2996 100644
--- a/include/hw/s390x/storage-keys.h
+++ b/include/hw/s390x/storage-keys.h
@@ -13,7 +13,6 @@
 #define S390_STORAGE_KEYS_H
 
 #include "hw/core/qdev.h"
-#include "monitor/monitor.h"
 #include "qom/object.h"
 
 #define TYPE_S390_SKEYS "s390-skeys"
@@ -123,8 +122,6 @@ int s390_skeys_set(S390SKeysState *ks, uint64_t start_gfn,
 S390SKeysState *s390_get_skeys_device(void);
 
 void s390_qmp_dump_skeys(const char *filename, Error **errp);
-void hmp_dump_skeys(Monitor *mon, const QDict *qdict);
-void hmp_info_skeys(Monitor *mon, const QDict *qdict);
 
 #define TYPE_DUMP_SKEYS_INTERFACE "dump-skeys-interface"
 
diff --git a/include/monitor/hmp.h b/include/monitor/hmp.h
index b444095f684..a0a063db8e4 100644
--- a/include/monitor/hmp.h
+++ b/include/monitor/hmp.h
@@ -182,4 +182,9 @@ void hmp_gva2gpa(Monitor *mon, const QDict *qdict);
 void hmp_gpa2hva(Monitor *mon, const QDict *qdict);
 void hmp_gpa2hpa(Monitor *mon, const QDict *qdict);
 
+void hmp_dump_skeys(Monitor *mon, const QDict *qdict);
+void hmp_info_skeys(Monitor *mon, const QDict *qdict);
+void hmp_info_cmma(Monitor *mon, const QDict *qdict);
+void hmp_migrationmode(Monitor *mon, const QDict *qdict);
+
 #endif
diff --git a/hw/s390x/s390-skeys.c b/hw/s390x/s390-skeys.c
index d974d97b5e7..7dca67d6618 100644
--- a/hw/s390x/s390-skeys.c
+++ b/hw/s390x/s390-skeys.c
@@ -24,6 +24,8 @@
 #include "system/kvm.h"
 #include "migration/qemu-file-types.h"
 #include "migration/register.h"
+#include "monitor/hmp.h"
+#include "monitor/monitor.h"
 #include "trace.h"
 
 #define S390_SKEYS_BUFFER_SIZE (128 * KiB)  /* Room for 128k storage keys */
diff --git a/hw/s390x/s390-stattrib.c b/hw/s390x/s390-stattrib.c
index 2e83aa211cd..74b23b0a995 100644
--- a/hw/s390x/s390-stattrib.c
+++ b/hw/s390x/s390-stattrib.c
@@ -15,6 +15,8 @@
 #include "system/ram_addr.h"
 #include "migration/qemu-file.h"
 #include "migration/register.h"
+#include "monitor/hmp.h"
+#include "monitor/monitor.h"
 #include "hw/core/qdev-properties.h"
 #include "hw/s390x/storage-attributes.h"
 #include "qemu/error-report.h"
-- 
2.53.0


