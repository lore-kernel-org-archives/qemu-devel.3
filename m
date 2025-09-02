Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29F3DCA1005
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 10:30:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utOHl-0006pY-DZ; Tue, 02 Sep 2025 06:30:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1utOHS-0006iR-3D
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 06:30:26 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1utOHM-00012b-Kw
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 06:30:24 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-45b87bc67a4so17204155e9.3
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 03:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756809018; x=1757413818; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=on4A+GT89TCdUZSaNdrGf23a3e80Lqu5mz2DsnpTu8Q=;
 b=SSfNhHn+UoEFrqvU2Z4VEehC2hmePm8HmCb63q+zL87JOLuFrIX45fGlH9BzLczvCH
 szvO+Kk8AuKpMsiGWH9ERzBMZejjqPoB1kwqqNE1ZKqj02mEURo6Zc7UCbSlhXHIe+//
 thfWV6C35j1NGAPGigK0rbHlyNATUmY0vDnt8CgYl8mIWp5B+jJ24lLKsxtkn0DVkbyX
 SpkASxZWMaz8y4uidtQd9eQpWUofRHqJd9u2Sc1Kkb/axtMXjBw1bEC4VHZUK1t477SN
 0X2SWd1ZvenIHBuKdgChdSrg+7tl33RjIjNWfZGbWVzhC1zg2AmuseOk++xuMsnwMeCD
 n4rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756809018; x=1757413818;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=on4A+GT89TCdUZSaNdrGf23a3e80Lqu5mz2DsnpTu8Q=;
 b=ZqGVYQodNNmYtLhjdMGGI4vI/KgN5FQGBT5MhX2G875/slPoeo+aP6TSiiBVB+5U9d
 kp9Wq82Dqj/tCXPN7var5A0V3raCg/dIn/OdscOgXG7r7YTbbm6O5XbqOtUuS7V3DSQF
 cQoNDnxGw3mDNNON4Ci2n3XLZY1rDffKcZ7UH2kc9Y3g1/ECg9WdUYr18gJmrxZckT26
 rEfRWq8e/GF0bXGovveGk1w38yzP8PvEjOVN/57ZgubXHowNeOAvHADHcESMWk6StLaa
 luF/s0OEsA7B6Ta6egmUF2kjVrfdkNbS6W1xF7J+wP13S32xA2lM0YjZhqYdmSDfDtng
 mcZg==
X-Gm-Message-State: AOJu0YzBDz5xEZqds5HzLoocz2/pSKKH+wBf0ua5GIS/KMeHJeTsUFyZ
 u2OJdFGjAm25Ysmdgnq+nZYpddyTVyy4AthQ+M39dtlQH+pPUWlNNM6qu4kC8YbhcO2RJ3x8mGh
 +OrSujSU=
X-Gm-Gg: ASbGncubVrFsHDlE5ssPelwMJs4829oZVbexpv3iVLZYCSfYFoWFHRQnNlkzKqs6cni
 IsNkNHGPBFlepEdSwzOKOCYks9StROhJ6JxkIl6+zPPc1GytX7y5hvPFYnhnbK8b+RBANNrExL6
 HAoADYfr1KRTmIafvTjgCxKLYkNaJxLBRrG1A12pjS0cL9eX7v4FYuGgcc9cUaigtB0LFtD14A5
 Gac2bK4l4Hm06B7ywNc9WW1gE9AT8FvqCfiGGcjqDZ5LNhLl/SrJcJTyd/0QsVRoG/xG8wV3ulE
 +51dj1iZVOoW4FyGUELojCF0zW1iCl5blcDJL+STZMsD1iyJiTdKdR+Xx2y+VqKFTzOzvET3LWo
 iVDlQeYvPjPcBdQEdYmD/nV7sTtdyNz2n99zbuPhlbEUiX6i25FvzesQ94KAXHrHWMtamyJDq3A
 ==
X-Google-Smtp-Source: AGHT+IHKA6ZKsCdycg+Bp/Lv1UkvlSmjtEiQckLuBdmim4eFtGtcAEeKqym7Cdj1TP2FNKZjQH1s9A==
X-Received: by 2002:a05:600c:474f:b0:459:ea5d:418b with SMTP id
 5b1f17b1804b1-45b85532b10mr89518435e9.9.1756809018375; 
 Tue, 02 Sep 2025 03:30:18 -0700 (PDT)
Received: from stoup.. (151-0-205-164.ip282.fastwebnet.it. [151.0.205.164])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b6f0d32a2sm296470665e9.9.2025.09.02.03.30.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Sep 2025 03:30:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com
Subject: [RFC 4/4] util/error-report: Use LogOutput in vreport
Date: Tue,  2 Sep 2025 12:30:10 +0200
Message-ID: <20250902103010.309094-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250902103010.309094-1-richard.henderson@linaro.org>
References: <20250902103010.309094-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32a.google.com
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

Merge print_loc.  Use the LogOutput callbacks instead of
error_printf and error_vprintf.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 util/error-report.c | 72 +++++++++++++++++++++------------------------
 1 file changed, 34 insertions(+), 38 deletions(-)

diff --git a/util/error-report.c b/util/error-report.c
index 6ef556af5f..db5b2c1608 100644
--- a/util/error-report.c
+++ b/util/error-report.c
@@ -132,36 +132,6 @@ void loc_set_file(const char *fname, int lno)
     }
 }
 
-/*
- * Print current location to current monitor if we have one, else to stderr.
- */
-static void print_loc(void)
-{
-    const char *sep = "";
-    int i;
-    const char *const *argp;
-
-    switch (cur_loc->kind) {
-    case LOC_CMDLINE:
-        argp = cur_loc->ptr;
-        for (i = 0; i < cur_loc->num; i++) {
-            error_printf("%s%s", sep, argp[i]);
-            sep = " ";
-        }
-        error_printf(": ");
-        break;
-    case LOC_FILE:
-        error_printf("%s:", (const char *)cur_loc->ptr);
-        if (cur_loc->num) {
-            error_printf("%d:", cur_loc->num);
-        }
-        error_printf(" ");
-        break;
-    default:
-        error_printf("%s", sep);
-    }
-}
-
 /*
  * Print a message to current monitor if we have one, else to stderr.
  * @report_type is the type of message: error, warning or informational.
@@ -172,28 +142,54 @@ static void print_loc(void)
 G_GNUC_PRINTF(2, 0)
 static void vreport(report_type type, const char *fmt, va_list ap)
 {
-    if (!monitor_cur()) {
-        void *opaque;
-        const LogOutput *l = error_log_output(&opaque);
+    void *opaque;
+    const LogOutput *l = error_log_output(&opaque);
 
+    if (!monitor_cur()) {
         qmessage_context(l, opaque);
     }
 
-    print_loc();
+    switch (cur_loc->kind) {
+    case LOC_CMDLINE:
+        {
+            const char *const *argp = cur_loc->ptr;
+            const char *sep = "";
+
+            for (int i = 0; i < cur_loc->num; i++) {
+                l->print(opaque, "%s%s", sep, argp[i]);
+                sep = " ";
+            }
+            l->print(opaque, ": ");
+        }
+        break;
+    case LOC_FILE:
+        {
+            const char *file = cur_loc->ptr;
+
+            if (cur_loc->num) {
+                error_printf("%s:%d: ", file, cur_loc->num);
+            } else {
+                error_printf("%s: ", file);
+            }
+        }
+        break;
+    case LOC_NONE:
+        break;
+    }
 
     switch (type) {
     case REPORT_TYPE_ERROR:
         break;
     case REPORT_TYPE_WARNING:
-        error_printf("warning: ");
+        l->print(opaque, "warning: ");
         break;
     case REPORT_TYPE_INFO:
-        error_printf("info: ");
+        l->print(opaque, "info: ");
         break;
     }
 
-    error_vprintf(fmt, ap);
-    error_printf("\n");
+    l->vprint(opaque, fmt, ap);
+    l->print(opaque, "\n");
 }
 
 /*
-- 
2.43.0


