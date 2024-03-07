Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D8A4C54E49
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 10:23:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riAs6-0004Uc-72; Thu, 07 Mar 2024 05:21:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1riAs2-0004TI-Ic
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 05:21:04 -0500
Received: from mail-il1-x12b.google.com ([2607:f8b0:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1riAs0-0006sS-3C
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 05:21:01 -0500
Received: by mail-il1-x12b.google.com with SMTP id
 e9e14a558f8ab-36524116e30so2167995ab.0
 for <qemu-devel@nongnu.org>; Thu, 07 Mar 2024 02:20:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1709806859; x=1710411659;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=uEl9gr+JRIy2uRLCAmnmdcgL5kP09OBXfeuQ6yoOxrY=;
 b=IlSgeCT+IgbWmhIYxtWxki7OzulPpSYYKhxo0cvNDcP3+eUpMK8ETeHPgb3kwYXzzy
 BbMuwwXM26y5Vpg+kxCtfLuD8iTLosbxQPqlWYtnJ5IqJvL6mN1vXkOCiMGZhN0NuQH5
 7PxaV9LWf005A0IndAACj94lTDgvS2e6Za71oDl+0newWk+NbIPMvzeR4iLXes2B2axv
 aMXZXzwku728mPOg+7RcZfH/eZi1JmnLR9hzkSI8XSjnxfkOHGT7fU3IheWYDtrvmFCA
 upK1M1Z6r3V7TWY4jMOCYGYwFr3Gx0+HE6xuNWkaupoSVtnLrIa6WWRl0VzaD4NoPuOF
 I0vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709806859; x=1710411659;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uEl9gr+JRIy2uRLCAmnmdcgL5kP09OBXfeuQ6yoOxrY=;
 b=KScGlt7/bCgYwqsyJ4AWg91BIln/O27TboMZkvjXVq7HhJzcKpV4JnHC9tHmDdUxGS
 hS9eXrY/d4cFgRMY30lY6rqC+z7It2w8DPsFWV/7mWcSQ9LiLG5CoV+3+fxBXkjFUl2a
 LjssJntmU5c7UoMJK6RdGy/abIGkS0g+ZPI0sOelK/gscYsyTPh4wFbb99lsBNHelA6y
 qMRTUTAlDELfSadSfyAt2TOIP9nwDdW7WExiCFLVkdU1otTSoGYJIuqpfRTt+QCLu8Z/
 2xkovHzU8XRVTQUpSgFOsWd/Ist8bkX+VSfPYdg/VbU1t26e2QcNbnFWJjeeA5vA6dDl
 EKHw==
X-Gm-Message-State: AOJu0YxL0ciVeijjs1adY4f85FWLChT6fR/V2QJ15DNHxGEHtf4IeYrE
 WT5OpWLTofwegDoTKqF74SQX8xBNez1qeKbWuUhFf4uNUB5w01sXdPqcDzLAg78=
X-Google-Smtp-Source: AGHT+IGRW0hSswWHM2ZEut1OSa1J0rnS3lDqIjbzvi7ENgqRHBtrlyAtis7Wf7vXWnsQab9lnxZijA==
X-Received: by 2002:a05:6e02:1d09:b0:365:1985:dda5 with SMTP id
 i9-20020a056e021d0900b003651985dda5mr21153102ila.14.1709806859024; 
 Thu, 07 Mar 2024 02:20:59 -0800 (PST)
Received: from localhost ([2400:4050:a840:1e00:9ac7:6d57:2b16:6932])
 by smtp.gmail.com with UTF8SMTPSA id
 bg1-20020a056a02010100b005dc9ab425c2sm10865270pgb.35.2024.03.07.02.20.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Mar 2024 02:20:58 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Thu, 07 Mar 2024 19:20:46 +0900
Subject: [PATCH v4 03/19] contrib/elf2dmp: Continue even contexts are lacking
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240307-elf2dmp-v4-3-4f324ad4d99d@daynix.com>
References: <20240307-elf2dmp-v4-0-4f324ad4d99d@daynix.com>
In-Reply-To: <20240307-elf2dmp-v4-0-4f324ad4d99d@daynix.com>
To: Viktor Prutyanov <viktor.prutyanov@phystech.edu>, 
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::12b;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-il1-x12b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Let fill_context() continue even if it fails to fill contexts of some
CPUs. A dump may still contain valuable information even if it lacks
contexts of some CPUs due to dump corruption or a failure before
starting CPUs.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 contrib/elf2dmp/main.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/contrib/elf2dmp/main.c b/contrib/elf2dmp/main.c
index 9b278f392e39..86e709e6da3a 100644
--- a/contrib/elf2dmp/main.c
+++ b/contrib/elf2dmp/main.c
@@ -336,8 +336,13 @@ static int fill_header(WinDumpHeader64 *hdr, struct pa_space *ps,
     return 0;
 }
 
-static int fill_context(KDDEBUGGER_DATA64 *kdbg,
-        struct va_space *vs, QEMU_Elf *qe)
+/*
+ * fill_context() continues even if it fails to fill contexts of some CPUs.
+ * A dump may still contain valuable information even if it lacks contexts of
+ * some CPUs due to dump corruption or a failure before starting CPUs.
+ */
+static void fill_context(KDDEBUGGER_DATA64 *kdbg,
+                         struct va_space *vs, QEMU_Elf *qe)
 {
     int i;
 
@@ -350,7 +355,7 @@ static int fill_context(KDDEBUGGER_DATA64 *kdbg,
         if (va_space_rw(vs, kdbg->KiProcessorBlock + sizeof(Prcb) * i,
                     &Prcb, sizeof(Prcb), 0)) {
             eprintf("Failed to read CPU #%d PRCB location\n", i);
-            return 1;
+            continue;
         }
 
         if (!Prcb) {
@@ -361,7 +366,7 @@ static int fill_context(KDDEBUGGER_DATA64 *kdbg,
         if (va_space_rw(vs, Prcb + kdbg->OffsetPrcbContext,
                     &Context, sizeof(Context), 0)) {
             eprintf("Failed to read CPU #%d ContextFrame location\n", i);
-            return 1;
+            continue;
         }
 
         printf("Filling context for CPU #%d...\n", i);
@@ -369,11 +374,9 @@ static int fill_context(KDDEBUGGER_DATA64 *kdbg,
 
         if (va_space_rw(vs, Context, &ctx, sizeof(ctx), 1)) {
             eprintf("Failed to fill CPU #%d context\n", i);
-            return 1;
+            continue;
         }
     }
-
-    return 0;
 }
 
 static int pe_get_data_dir_entry(uint64_t base, void *start_addr, int idx,
@@ -619,9 +622,7 @@ int main(int argc, char *argv[])
         goto out_kdbg;
     }
 
-    if (fill_context(kdbg, &vs, &qemu_elf)) {
-        goto out_kdbg;
-    }
+    fill_context(kdbg, &vs, &qemu_elf);
 
     if (write_dump(&ps, &header, argv[2])) {
         eprintf("Failed to save dump\n");

-- 
2.44.0


