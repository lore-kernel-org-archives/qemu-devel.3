Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3442BC5DF7D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 00:28:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ww7fI-0002Mu-Vh; Mon, 17 Aug 2026 20:26:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <simonxhy0404@gmail.com>)
 id 1ww7fA-0002Lm-5c
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 20:26:44 -0400
Received: from mail-oa1-x2d.google.com ([2001:4860:4864:20::2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <simonxhy0404@gmail.com>)
 id 1ww7f7-0004J6-P9
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 20:26:43 -0400
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-448cf99c133so385204fac.1
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 17:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787012800; x=1787617600; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OTzIri0K2EBOOrjDLSbxGdoN7JEhLQTywy7UlpcJE7A=;
 b=ajFPrN20Vugp7T8gXtcX88M0XaZtjIepkzeJRZEv/ag5wLgzmgy0h2yAm9K0lUt6jE
 dItzHtiTCH8duHZe0QrglPwyVUhJQwSfmvDE7fWpG5HolVRx96FirsYHw3O8BqGSdth3
 UMR2/GGekgJSd5rRc6rqIebelvexfm+lH03fLCuvQHM7IWU8oU/Cfeyko4cV8yQp4fcs
 9xeNNaG/i1nhiFZAWvjQiBbkpDpiBgECQK7iTvvOP3xLhSqSr+TigvFfwgrvNyqwcAQW
 wmZCUDDqLuZd1wdqC5PPPOtWqz0ted10l3NNWNGjgRLdnlSECwd8kbVc0absq1trnpt0
 KkfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787012800; x=1787617600;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=OTzIri0K2EBOOrjDLSbxGdoN7JEhLQTywy7UlpcJE7A=;
 b=bsbvRIQaib1CxuBGZRLOFvEZsmgWZTIbyIxkhhmiQDgj9s6H5KvmjtIFUFe8AWcz6U
 b1c8dF9soeOQjZJI92QWBaQQdn36bG6i3FDtUF4xWj8VtVy62MJsviKgGTwp2zQMXW9x
 XP2VAVE9ZI9WRn5dOiGwLtd+AKnLjGVa1pWdr6mjOhO/5p65olFukpguSdjrnLVTbEhg
 OHZp0+Og+GaR9NZCVcTG3qXn6yE4F29e+H8Rt0qqhbZYhyZXceU1suH8Aa8RMYvwB1Wt
 oLT/1ZT3mq1LcEJX2Tc+LjXRtc2Qm7Z0E1NQPe+UzGj8wKV3Ecnl+LTwVETlAyt/80Mi
 r7Kw==
X-Gm-Message-State: AOJu0YxzZ6ufYaHpGZe1K7av5C0xxVZBCF6syGl3Da3iDOhTJNC4cwtL
 crOuQ5H4faUfI+l6Ywdi2PVqgQtbIxI+c4QqnEjZL7zrWsTHNx/JmQsoeqcMkI0V
X-Gm-Gg: AR+sD11TNxdORJyYZheyirfZVdnosEXc+AGQ3aLhF0SmNJkqnYaXNYJlPvQmXEyxpDJ
 OjvosiLKagz5pbcyEoOflUBzeP6ju4RHJQSH2IBW1aFxa0nR99Lb1zGtKYpAdTLfdYXnEBqKPwP
 fJrFfa4Nv1ojN944d4GiHjBp73Scyx/v7cwo6Yn52/NzC1ngh9CUwIwzSki3Hyj7ZpIErRBCtkv
 v+djfj9rkf641YHxHxGeej21YP2wNk9gyVrp+FUE6LeLm7mjoc7Ja3LqzHswid+uZ0pxLwR4AlI
 o23Nps19yO42uI9rodtThWrIS3F5dPUItLzTahdV8nft8zuJwhtvSFDQOOUx/0VGbU14JkRXSX4
 fih+6fUc6HSopUa8zXt7MI9EX9lbRJugGk7kEzWCTcWKeKkFnv4Xyo9rtt6sNrk+bWqVSM58lmU
 ZvcU4+t9Sb06aOa9DE54RMOY/Cbk5FYDA46GsWbJPgWrk0cvcrNa4KTiKz9UrnMZ7dZ3jXGWRBA
 ZHShTb6hNQ=
X-Received: by 2002:a05:6808:158f:b0:4b2:8dbe:fff3 with SMTP id
 5614622812f47-4b29dfa5a7bmr1073553b6e.0.1787012800533; 
 Mon, 17 Aug 2026 17:26:40 -0700 (PDT)
Received: from LAPTOP-86EU4LQA.home.local ([23.124.244.239])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4b2960dfc9bsm1715165b6e.14.2026.08.17.17.26.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 17:26:40 -0700 (PDT)
From: Simon Xu <simonxhy0404@gmail.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Simon Xu <simonxhy0404@gmail.com>, Owen Giles <owen.giles@hpe.com>,
 Robert Elliott <elliott@hpe.com>
Subject: [PATCH v3 7/9] hw/misc/iotkit-sysinfo.c: add SSE-310 support
Date: Mon, 17 Aug 2026 19:26:27 -0500
Message-ID: <20260818002629.172827-8-simonxhy0404@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260818002629.172827-1-simonxhy0404@gmail.com>
References: <20260818002629.172827-1-simonxhy0404@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2d;
 envelope-from=simonxhy0404@gmail.com; helo=mail-oa1-x2d.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Add SSE-310 PIDR and CIDR registers. Add sys_config2 register and
always report 0 on read as we do not implement the NPU.

Reviewed-by: Owen Giles <owen.giles@hpe.com>
Reviewed-by: Robert Elliott <elliott@hpe.com>
Signed-off-by: Simon Xu <simonxhy0404@gmail.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20260805153005.9989-8-simonxhy0404@gmail.com>
---
 hw/misc/iotkit-sysinfo.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/hw/misc/iotkit-sysinfo.c b/hw/misc/iotkit-sysinfo.c
index 19f089e6ee..f3d07f3247 100644
--- a/hw/misc/iotkit-sysinfo.c
+++ b/hw/misc/iotkit-sysinfo.c
@@ -31,6 +31,7 @@
 REG32(SYS_VERSION, 0x0)
 REG32(SYS_CONFIG, 0x4)
 REG32(SYS_CONFIG1, 0x8)
+REG32(SYS_CONFIG2, 0xc)
 REG32(IIDR, 0xfc8)
 REG32(PID4, 0xfd0)
 REG32(PID5, 0xfd4)
@@ -58,6 +59,12 @@ static const int sysinfo_sse300_id[] = {
     0x0d, 0xf0, 0x05, 0xb1, /* CID0..CID3 */
 };
 
+static const int sysinfo_sse310_id[] = {
+    0x04, 0x00, 0x00, 0x00, /* PID4..PID7 */
+    0x58, 0xb8, 0x2b, 0x00, /* PID0..PID3 */
+    0x0d, 0xf0, 0x05, 0xb1, /* CID0..CID3 */
+};
+
 static uint64_t iotkit_sysinfo_read(void *opaque, hwaddr offset,
                                     unsigned size)
 {
@@ -68,13 +75,22 @@ static uint64_t iotkit_sysinfo_read(void *opaque, hwaddr offset,
     case A_SYS_VERSION:
         r = s->sys_version;
         break;
-
     case A_SYS_CONFIG:
         r = s->sys_config;
         break;
     case A_SYS_CONFIG1:
         switch (s->sse_version) {
         case ARMSSE_SSE300:
+        case ARMSSE_SSE310:
+            return 0;
+            break;
+        default:
+            goto bad_read;
+        }
+        break;
+    case A_SYS_CONFIG2:
+        switch (s->sse_version) {
+        case ARMSSE_SSE310:
             return 0;
             break;
         default:
@@ -84,6 +100,7 @@ static uint64_t iotkit_sysinfo_read(void *opaque, hwaddr offset,
     case A_IIDR:
         switch (s->sse_version) {
         case ARMSSE_SSE300:
+        case ARMSSE_SSE310:
             return s->iidr;
             break;
         default:
@@ -95,6 +112,9 @@ static uint64_t iotkit_sysinfo_read(void *opaque, hwaddr offset,
         case ARMSSE_SSE300:
             r = sysinfo_sse300_id[(offset - A_PID4) / 4];
             break;
+        case ARMSSE_SSE310:
+            r = sysinfo_sse310_id[(offset - A_PID4) / 4];
+            break;
         default:
             r = sysinfo_id[(offset - A_PID4) / 4];
             break;
-- 
2.53.0


