Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B9A8C41513
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2024 17:59:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGjIP-0005HI-SN; Mon, 10 Jun 2024 13:59:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sGjIO-0005Gx-T7
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 13:59:04 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sGjIN-0001aI-7h
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 13:59:04 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-421a1b834acso11227295e9.3
 for <qemu-devel@nongnu.org>; Mon, 10 Jun 2024 10:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718042341; x=1718647141; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xJyIGRy7KVzvmUcZdC1VviPw8AK09jMHFagaK3CiBV0=;
 b=EPCNZ/3v1aqrGlIwloX5WpmJDBS7PzTc2o6hx1KfFBP9z4Lc8D4I/NnHqstNzNPvlD
 EqG8N/Clj90o0rtWJKNoNDvarC3oiyU5SgAXd1lfE6+FNsPcINg9QcOA7AsKPKqaYg6t
 Pjd+KJDew3i68DyoDk+2bHc0jOWxl7GIcVziPoqijtooFJEXIiOE65S8NBZJWWCS5dv0
 ZQhHYUK0qjKJ8HLRN8dWacd2Qn48NI+uFHOHHRrPbZNtFDnI4Ld/B3cUor+mcmoLVrRQ
 mZtCoV98LQitbbw2JvNwa2fyV7sHqRSUJhoojYzNlXYYqvSJEOYJntuST7CF7ZW2ePbM
 kQDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718042341; x=1718647141;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xJyIGRy7KVzvmUcZdC1VviPw8AK09jMHFagaK3CiBV0=;
 b=JZUZUV8K5U+OsJavxow+31pAysNB9g6TWmOw8MPQuf/Tzne214mieFRQKSqbzGzsII
 wpEVQTfdCq5g2rhvehpRRPYp76G2L19Ek51wmC535EdVNKVYRoHl3y5HW7+2S25Bb50z
 T85mXx1ScX2QcY706g64PcvBvFaZfRl/iVVL8zogH7Jj42cpbYHD97PWr2qvDcjVklG8
 eFKYdpCVhJ9K4Qim7g3l5vp0PCmROd3ha9w93dA9a9qr77KDg9aWT70F7EH5oiL0AM2c
 FWvw6wc+vhU30chajAaana9kX5DPCq46qdT/Mp34PTEbL5APHzVvI7exGwTlA6btmVe3
 UeaA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV1YpZF9F0dOEg8DIvzmn/WBmKA9qaRquIXu9vSkbGv3XRd22/cJ44fqHy8Xl4/mttv9uxjo4BmS1rOWx527uWRZtLnpAI=
X-Gm-Message-State: AOJu0YwZ8vwQnuFFsxpHsML7zlOjDQyOMarulfdDanzkBmPc2pVZ4YRl
 YeYOaxpM0XqNVZki+yeLJ2uSmzvKzvRsEcio9lOYgYiC4rKnu5YHUE6AjRqMFmsRbDh6UImWVBn
 k
X-Google-Smtp-Source: AGHT+IGC0r8r4U+5H74xP3OZhqO9lPcJMPCNVuVWC/c+jvvBOZ/P6BClNiksnEjDXQnmUd0cnSeucg==
X-Received: by 2002:a05:600c:4f93:b0:421:f441:e7e7 with SMTP id
 5b1f17b1804b1-421f441eae3mr19894315e9.19.1718042341622; 
 Mon, 10 Jun 2024 10:59:01 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.129.242])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4217ab6199bsm89965205e9.13.2024.06.10.10.58.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 10 Jun 2024 10:59:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>, qemu-devel@nongnu.org
Cc: Yanan Wang <wangyanan55@huawei.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eric Farman <farman@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, qemu-s390x@nongnu.org,
 Eduardo Habkost <eduardo@habkost.net>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 1/3] hw/s390x: Declare target specific monitor commands in
 hmp-target.h
Date: Mon, 10 Jun 2024 19:58:50 +0200
Message-ID: <20240610175852.21215-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240610175852.21215-1-philmd@linaro.org>
References: <20240610175852.21215-1-philmd@linaro.org>
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

"monitor/hmp-target.h" is meant to hold target-specific commands.
Move s390x specific commands there, slightly simplifying hmp-target.c.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/s390x/storage-attributes.h | 4 ----
 include/hw/s390x/storage-keys.h       | 4 ----
 include/monitor/hmp-target.h          | 5 +++++
 hw/s390x/s390-skeys.c                 | 2 ++
 hw/s390x/s390-stattrib.c              | 2 ++
 monitor/hmp-target.c                  | 5 -----
 6 files changed, 9 insertions(+), 13 deletions(-)

diff --git a/include/hw/s390x/storage-attributes.h b/include/hw/s390x/storage-attributes.h
index 8921a04d51..4916c75936 100644
--- a/include/hw/s390x/storage-attributes.h
+++ b/include/hw/s390x/storage-attributes.h
@@ -13,7 +13,6 @@
 #define S390_STORAGE_ATTRIBUTES_H
 
 #include "hw/qdev-core.h"
-#include "monitor/monitor.h"
 #include "qom/object.h"
 
 #define TYPE_S390_STATTRIB "s390-storage_attributes"
@@ -73,7 +72,4 @@ static inline Object *kvm_s390_stattrib_create(void)
 }
 #endif
 
-void hmp_info_cmma(Monitor *mon, const QDict *qdict);
-void hmp_migrationmode(Monitor *mon, const QDict *qdict);
-
 #endif /* S390_STORAGE_ATTRIBUTES_H */
diff --git a/include/hw/s390x/storage-keys.h b/include/hw/s390x/storage-keys.h
index aa2ec2aae5..1d9b7ead44 100644
--- a/include/hw/s390x/storage-keys.h
+++ b/include/hw/s390x/storage-keys.h
@@ -13,7 +13,6 @@
 #define S390_STORAGE_KEYS_H
 
 #include "hw/qdev-core.h"
-#include "monitor/monitor.h"
 #include "qom/object.h"
 
 #define TYPE_S390_SKEYS "s390-skeys"
@@ -114,7 +113,4 @@ void s390_skeys_init(void);
 
 S390SKeysState *s390_get_skeys_device(void);
 
-void hmp_dump_skeys(Monitor *mon, const QDict *qdict);
-void hmp_info_skeys(Monitor *mon, const QDict *qdict);
-
 #endif /* S390_STORAGE_KEYS_H */
diff --git a/include/monitor/hmp-target.h b/include/monitor/hmp-target.h
index b679aaebbf..024cff0052 100644
--- a/include/monitor/hmp-target.h
+++ b/include/monitor/hmp-target.h
@@ -61,4 +61,9 @@ void hmp_gva2gpa(Monitor *mon, const QDict *qdict);
 void hmp_gpa2hva(Monitor *mon, const QDict *qdict);
 void hmp_gpa2hpa(Monitor *mon, const QDict *qdict);
 
+void hmp_dump_skeys(Monitor *mon, const QDict *qdict);
+void hmp_info_skeys(Monitor *mon, const QDict *qdict);
+void hmp_info_cmma(Monitor *mon, const QDict *qdict);
+void hmp_migrationmode(Monitor *mon, const QDict *qdict);
+
 #endif /* MONITOR_HMP_TARGET_H */
diff --git a/hw/s390x/s390-skeys.c b/hw/s390x/s390-skeys.c
index 5c535d483e..7b2ccb94a5 100644
--- a/hw/s390x/s390-skeys.c
+++ b/hw/s390x/s390-skeys.c
@@ -23,6 +23,8 @@
 #include "sysemu/kvm.h"
 #include "migration/qemu-file-types.h"
 #include "migration/register.h"
+#include "monitor/hmp-target.h"
+#include "monitor/monitor.h"
 
 #define S390_SKEYS_BUFFER_SIZE (128 * KiB)  /* Room for 128k storage keys */
 #define S390_SKEYS_SAVE_FLAG_EOS 0x01
diff --git a/hw/s390x/s390-stattrib.c b/hw/s390x/s390-stattrib.c
index c4259b5327..9b4b8d8d0c 100644
--- a/hw/s390x/s390-stattrib.c
+++ b/hw/s390x/s390-stattrib.c
@@ -19,6 +19,8 @@
 #include "exec/ram_addr.h"
 #include "qapi/error.h"
 #include "qapi/qmp/qdict.h"
+#include "monitor/hmp-target.h"
+#include "monitor/monitor.h"
 #include "cpu.h"
 
 /* 512KiB cover 2GB of guest memory */
diff --git a/monitor/hmp-target.c b/monitor/hmp-target.c
index 1eb72ac1bf..0466474354 100644
--- a/monitor/hmp-target.c
+++ b/monitor/hmp-target.c
@@ -36,11 +36,6 @@
 #include "qapi/error.h"
 #include "qemu/cutils.h"
 
-#if defined(TARGET_S390X)
-#include "hw/s390x/storage-keys.h"
-#include "hw/s390x/storage-attributes.h"
-#endif
-
 /* Make devices configuration available for use in hmp-commands*.hx templates */
 #include CONFIG_DEVICES
 
-- 
2.41.0


