Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8379EC369D5
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 22:23:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u84wp-0004UU-2l; Thu, 24 Apr 2025 18:21:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u84wn-0004U8-2j
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 18:21:34 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u84wk-0000ww-Ot
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 18:21:32 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43d2d952eb1so11456015e9.1
 for <qemu-devel@nongnu.org>; Thu, 24 Apr 2025 15:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745533289; x=1746138089; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dgsGUsD9TKc38NlyU74exCU5XyvbS6uZfF8RzMtuwOk=;
 b=sFcJ3R+rsoWk24M+Pbl/hYQ28KRAqp4zs65LZJnB5eM4/CZRHO8dQoeY5T2Na8UM5m
 P9LX75Nk9lUaZ3T2qoosn44Vke9XIfNeQT6h/dnEaydVk1OhVXaeP6wGcIlmZO9msKpI
 5AfipbZS0zx6wigtAkYrACp4MkjycZ0s7BhJ4e62sjpqKegBMAqndKt12RWWIdLy9w1e
 rFzpsvyDR9ocHT+9T8u1w2GTei17VvcxmpTx2vmQEui8amdz8il4GimXB1s26DHs1eT6
 ZxEVUOt23Nn0LIKjH1d6QWy+5JTIy8pjBKp0m2XZeAF53C2HrW7XvrcsbDxy828kaLa9
 jVHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745533289; x=1746138089;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dgsGUsD9TKc38NlyU74exCU5XyvbS6uZfF8RzMtuwOk=;
 b=t9vBnMqO0FLunzADGRBQVJK2yj0w8JusDE37BkyWk5qjbatjHmGtL1+T+7kK9neaFC
 d/Ln2BhnnWCqtcYFI9DEcJxw9YNyZv/7Qv5F/PuZ6wlXWuhHRb5r2lv4BW1WPBogPrXD
 uDEt+uWut8+eGT9F6hZfCZrIrIy64YNFV8a7cy08pKYbUfK2u3ACJLqdXoz9zVTCoZKV
 5pOrYj/+LqNXxwZPMN8+vFBfq0qMXrbao8iVkvyetZYY6MPSgsCNpkRprDInTxMzbTSP
 3cL3O9CLAFiVEVuqjCjLYgK4G1RMVnd02lcnj9fZP7OKUqZue0JW/9moafgkDm9KGRBr
 MuBg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVe7jzPBBLW55Cfk1mx9Ea5XzRdwj5MTTj3/EiiAx/n/c/ZA62XmdcggiUzouAkYUL6tC2QSc+YDRTe@nongnu.org
X-Gm-Message-State: AOJu0YyvfH0vJbMeF0lvqG8m4U0mgVUCVjMpq0ca4286KgXYAFoY4cC2
 NaOr+SUA70n+qrzb5NTRLISHtPjY2I6Fpsd6JADkY+fXAN3vYYBzwthGUQGkEiV3AFRbMgwaJj9
 i
X-Gm-Gg: ASbGncuMhvxybUuV8JaReAfWRPfPUtH0PQmoqwzCeLi4MEMP0FOLErFEHrOLjLZKTC6
 lEjlnnOjnBTsca3GHUEGYe9PPTW8Ovs/yv2hjTv/SZVt1YxPV5YJrpEN/82aJ0hibnGVHTn5O5k
 TdHMsQt6+QG/F3qKOstVMo7C9Ax7AVBW3O2trPzwpO6hpM/VZeZ6QOyHLHXTb9pd+Hkd4eQtMbD
 ksyQ3P8llZ120LqeXKmvAkspqUZlKC7Um1T3VHO4/DiTHqeiAk2ZPlocRlDMFfO/3bP5wXEQlGj
 LtJiwvDbL4c3krcFSYU1wCPoBE0nGuVdZd7e7o6m950LiH8H24nqjlZqb5CfeoYK+PyYz4/X8jZ
 yZ+MYO5uLLmZvjqNP3u652e7xqg==
X-Google-Smtp-Source: AGHT+IE3sqcGE2giccXkvx0tRgKdi/r3SAXUBhELk8FJcZp5A2O5YcgbSmh8w0LO6TXjqLDjsQeF2A==
X-Received: by 2002:a05:600c:3154:b0:43d:79:ae1b with SMTP id
 5b1f17b1804b1-4409bd23b36mr41148345e9.14.1745533288932; 
 Thu, 24 Apr 2025 15:21:28 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4409d29ba29sm37164625e9.7.2025.04.24.15.21.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 24 Apr 2025 15:21:28 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH v5 03/21] system/vl: Filter machine list available for a
 particular target binary
Date: Fri, 25 Apr 2025 00:20:54 +0200
Message-ID: <20250424222112.36194-4-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250424222112.36194-1-philmd@linaro.org>
References: <20250424222112.36194-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

Binaries can register a QOM type to filter their machines
by filling their TargetInfo::machine_typename field.

This can be used by example by main() -> machine_help_func()
to filter the machines list.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/qemu/target-info-impl.h | 2 ++
 include/qemu/target-info.h      | 8 ++++++++
 system/vl.c                     | 3 ++-
 target-info-stub.c              | 2 ++
 target-info.c                   | 5 +++++
 5 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/include/qemu/target-info-impl.h b/include/qemu/target-info-impl.h
index d30805f7f28..d0e8c86176c 100644
--- a/include/qemu/target-info-impl.h
+++ b/include/qemu/target-info-impl.h
@@ -14,6 +14,8 @@
 typedef struct TargetInfo {
     /* runtime equivalent of TARGET_NAME definition */
     const char *target_name;
+    /* QOM typename machines for this binary must implement */
+    const char *machine_typename;
 } TargetInfo;
 
 /**
diff --git a/include/qemu/target-info.h b/include/qemu/target-info.h
index 1007dc9a5e4..0224b35b166 100644
--- a/include/qemu/target-info.h
+++ b/include/qemu/target-info.h
@@ -16,4 +16,12 @@
  */
 const char *target_name(void);
 
+/**
+ * target_machine_typename:
+ *
+ * Returns: Name of the QOM interface implemented by machines
+ *          usable on this target binary.
+ */
+const char *target_machine_typename(void);
+
 #endif
diff --git a/system/vl.c b/system/vl.c
index cdf6eb9ee49..e8706a9ce87 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -27,6 +27,7 @@
 #include "qemu/datadir.h"
 #include "qemu/units.h"
 #include "qemu/module.h"
+#include "qemu/target-info.h"
 #include "exec/cpu-common.h"
 #include "exec/page-vary.h"
 #include "hw/qdev-properties.h"
@@ -1564,7 +1565,7 @@ static void machine_help_func(const QDict *qdict)
     GSList *el;
     const char *type = qdict_get_try_str(qdict, "type");
 
-    machines = object_class_get_list(TYPE_MACHINE, false);
+    machines = object_class_get_list(target_machine_typename(), false);
     if (type) {
         ObjectClass *machine_class = OBJECT_CLASS(find_machine(type, machines));
         if (machine_class) {
diff --git a/target-info-stub.c b/target-info-stub.c
index 076b9254dd0..218e5898e7f 100644
--- a/target-info-stub.c
+++ b/target-info-stub.c
@@ -8,9 +8,11 @@
 
 #include "qemu/osdep.h"
 #include "qemu/target-info-impl.h"
+#include "hw/boards.h"
 
 static const TargetInfo target_info_stub = {
     .target_name = TARGET_NAME,
+    .machine_typename = TYPE_MACHINE,
 };
 
 const TargetInfo *target_info(void)
diff --git a/target-info.c b/target-info.c
index 84b18931e7e..0042769e3a2 100644
--- a/target-info.c
+++ b/target-info.c
@@ -14,3 +14,8 @@ const char *target_name(void)
 {
     return target_info()->target_name;
 }
+
+const char *target_machine_typename(void)
+{
+    return target_info()->machine_typename;
+}
-- 
2.47.1


