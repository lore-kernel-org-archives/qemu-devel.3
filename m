Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6859EF531DE
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 00:31:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCRgS-0001pp-9T; Mon, 13 Apr 2026 20:31:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wCRgK-0001fQ-R4
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 20:31:10 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wCRgI-0003B5-8q
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 20:31:07 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-488e1a8ac40so34952325e9.2
 for <qemu-devel@nongnu.org>; Mon, 13 Apr 2026 17:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776126663; x=1776731463; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iqT5An8t/Rup8MOLjBq+qy6AZymRqDsPAbrkKupI24o=;
 b=Q6MhdpYxb4x1S+qHUdXHuDdMr6C06GtAMCXyHk3WE0ik4NlGKlt579ARBDvNbcD0BO
 8kAmsNP6/mrupJlM/g4/U4j87iZsypmSz5xwX1lJfMZ74gOeXlZ+UbJYdt0Q+phsjur9
 BftCAekaimrNpL+b+TJY4yTD+ks7nARSLwOGfzm09MSsX3Y7YfrKfnneZGZrpBgfxTg+
 XTixRiN5SLa4oA5WCdBAVfXX7CqPHPU2RhC0XHHMp5G8vozBymqsVgjSZLNObvQ80wFf
 djZqB7xS1dotd7l+C/NVyoVX8Sv10AcUP7i5NmQrfR8FJthHdRZi9sfqvotumZ3sDshi
 WBxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776126663; x=1776731463;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iqT5An8t/Rup8MOLjBq+qy6AZymRqDsPAbrkKupI24o=;
 b=Ze1oj6TYGeI4geh0a8NTg8iGu2LDsLSS5Cq1PtvyvUWskFuLU3TqcNGfohe7X9JwKv
 KALsGuqr1epp4yTqIhegrY+SykW6kT8ugFaU4Q4cFvYI/EfsxF3+guZG2BSF/H66FbRM
 +EmGWfgZAzyVDKfEgZi3TBNAIGGowPIu+6mwqjHBm1YNztCMLbyC3qC6bRXBxErOKw8k
 ixpCa9+H+0pmWytJ3dt1itAePLLYGMb+FeCy849nhpjZCpD9dQrJAyVo1fQoAWN67V8o
 GAyIknc9Wc9Vy2Y/ql832cncE4LoVGVgvvbTHpzwXH4X9XqeYVBZf8AFqnHpkecSC3dt
 +cTA==
X-Gm-Message-State: AOJu0Yycr0MCgw3nQs7OLlcr+bKcOXQ/+xank0sfTz5NHEvEr3e1FT+b
 HVTGYRB4lGORZMkQ9GrbOVtwbBsSGLWUfYp2BzcmHDbcCKsgPtWjk9Nc/UIT5plThKHDixalu+p
 gOXbvdR0=
X-Gm-Gg: AeBDiesEq4V2McfrTc9x/GRROkx3abNC5K8RbQdSIPCt7d2KYSKmKzAZmOh/ZjyGpqP
 d0T8cu05lFB5J83eXPDxtKwSsCLVUQlA7ANExh5l+Z4xys49Xztn6iJM70MicM4X9TJl3/Zg2B0
 KdHCiZPKaCh1PVmGbmIaQboTxIHzTKzXFomGa8Es89ZcRzA44Ah9PX/8XJkgQmBqxiAE+1Ipjm4
 D9ETi7P5jyZO51VyOl1Yjc3Dul4YzF8DuUOi60fOHkJOLrfUGP9faxUsyneP7H9RdRIN5eEBDz4
 wEYpj0jPgPWQefZqqz8P4ma6wtDBFqi+XtAxJr0dgBzWAlIBDk0OTCO6QsIjgSTL4hC8uuPoNWb
 xxV/1fyXFTcdHiwBVd+zS6XzPHxm011yWRCBS8KPDgOVHPNi36EiS+Uzt0TnByGl+TU4VbNskV+
 9gEwTODpJrciuptZYEhhwDAkAYnJ7qZmx+gVjqmO1A9hDkwyISObgdhwOGr1gQlCLVgXKrEUo8
X-Received: by 2002:a05:600c:43d5:b0:488:d8b6:abda with SMTP id
 5b1f17b1804b1-488d8b6acdfmr118139995e9.19.1776126663425; 
 Mon, 13 Apr 2026 17:31:03 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488d68479b2sm105283705e9.25.2026.04.13.17.31.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 13 Apr 2026 17:31:02 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Jason Herne <jjherne@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 qemu-s390x@nongnu.org
Subject: [PATCH v3 08/27] hw/s390x: Reduce 'monitor/monitor.h' inclusions
Date: Tue, 14 Apr 2026 02:29:40 +0200
Message-ID: <20260414003001.97571-9-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260414003001.97571-1-philmd@linaro.org>
References: <20260414003001.97571-1-philmd@linaro.org>
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Acked-by: Cornelia Huck <cohuck@redhat.com>
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
index 9c2330205fc..d694bfdf768 100644
--- a/include/monitor/hmp.h
+++ b/include/monitor/hmp.h
@@ -173,4 +173,9 @@ void hmp_gva2gpa(Monitor *mon, const QDict *qdict);
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


