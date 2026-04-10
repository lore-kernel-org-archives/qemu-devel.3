Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9E32F459EB
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 15:06:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBDQ8-0006TY-Mb; Fri, 10 Apr 2026 11:05:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wBDQ4-0006Jw-3l
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 11:05:16 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wBDQ2-0001zX-Lu
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 11:05:15 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-35da1af3e10so2247647a91.3
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2026 08:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775833513; x=1776438313; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B2QC7hLfF9zjfQ04CPizme4X1fY5wq+GdA4jvJ9NH8A=;
 b=NSFIk5H5CA5PqAvF7LQHNWQ5rVRunjvS2KBTRikjER2/kL3UjS7s6AQfr+K20CzCw8
 /+FZbYD5ZUc4cwpuhxd7Xg9QoXYy66vqYVHZAWTeD33ZQzDN0sh12sm+YSk+bvrYyXOl
 F2sqksNIrC4BEvuWrgYFatzZCifl3nF2/LgNwAkAF6fhBN/xIaVIDNLLlS3InF/qbitD
 FMCrGros/McjM/+Xf5x1S7BH8CSU34lrU+8ptV7ieYtgvug6OuzXEB1mvQbWkQdNWHAl
 NSelYMfUxqVDWzxePpCuqPKPEHjcM9rpGMdnRDh1WFTo9IHB0P9oVU3n+b6hX8tLQ8nT
 mSHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775833513; x=1776438313;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=B2QC7hLfF9zjfQ04CPizme4X1fY5wq+GdA4jvJ9NH8A=;
 b=bZKDln1KpOhBcPhNT1ZtG5wguChsDWzYS3JsLGscMgrpeSUH5f6oM8Okp+y0ulHD+x
 dHW5Ulsxvxo1GH6yH4FRlWKnu0+p0QsVczs25oEJkbHxDSLU04+z9menlpDs6WCB16+B
 QLw7rNH1KTMXMbhppsuRL6BQeK1/9nEgs8kvXBETWOz4CNFisnDglldY8aVWowQUTWyC
 kmpXRCIe3Btm/zuK1gNzPRCb9FKymoWYVWhNOp7vmx/Ljp3bJnG4IDwPENd33hvhZD07
 euEw88UXw9v9c+wvuoqn2rVoI9bjgsb2TJqMSIueTwkI3/6h+sJ15GfmcW7Gmhv+m9Sr
 p+JQ==
X-Gm-Message-State: AOJu0Yw0f+NnkRiftctKpffspwqZo0pvszAwTlg6ytgtI1SbkXtKvogR
 7l2qZziUm12clyCnU2Bvz/YSL4YK4BKC89MfFbH7YK4SoEr1QnEAgOcJhLi/3bhn
X-Gm-Gg: AeBDietpzai4703K83RpNqDrJ816S+XFOy10WSmpip4HnCVw5DyXDVvYt+gEhMRSF0B
 n+UiqZHK/iig8i9fWFnsrySXCCKn53xw3mPoeyOgRboNuSs2AwsTeQ0Bh4ANnaEYbkUp89xeNFM
 yKjydjv/V5O0vtUWAEyC7uItF8P51hhk7Ombgr2EythvRJm7IyLI3KDpnF+SyDPNZhm6WoclkoD
 QOuQF4Js4ddX7Q1lFSlFid4ZSL4yheCRuy/sFqkmnsyswVRTnsL463LlIiOIW8lFBwZDU3r6uUA
 lKSKGuMTRostjjk/vjjFE6JTr/v1nha6jmsEgoj904HNm9h7/E/2YzHZSyXPyqGQBxWSNhDeXAr
 /zOHN36+66PQW9sKI7FgFBylwMvytSN+F2y8eP31d8MZnACIwQGRVv6UPNTeytPcLS13ghgdPtE
 x535MzD86wjpujrzREtJ+4iCZEhDYRs76PYop7QaNBB6oSBE3e9xTD
X-Received: by 2002:a17:90b:28d0:b0:35c:30a8:31f with SMTP id
 98e67ed59e1d1-35e4276a26cmr3554636a91.2.1775833512341; 
 Fri, 10 Apr 2026 08:05:12 -0700 (PDT)
Received: from ZBMac-LWN10QXKQ0.taila0cd24.ts.net ([104.168.88.121])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35e4131cfacsm3565785a91.10.2026.04.10.08.05.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 10 Apr 2026 08:05:11 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Cc: Zhang Chen <zhangckid@gmail.com>,
	qemu-stable@nongnu.org
Subject: [PATCH V6 01/14] qapi/misc: Fix missed query-iothreads items
Date: Fri, 10 Apr 2026 23:04:44 +0800
Message-ID: <20260410150457.85190-2-zhangckid@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260410150457.85190-1-zhangckid@gmail.com>
References: <20260410150457.85190-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=zhangckid@gmail.com; helo=mail-pj1-x102f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

The example is incomplete: it misses members @poll-max-ns, @poll-grow,
@poll-shrink, @aio-max-batch.  Messed up in commit 5fc00480ab1
(monitor: add poll-* properties into query-iothreads result) and
commit 1793ad0247c (iothread: add aio-max-batch parameter).

cc: qemu-stable@nongnu.org

Reviewed-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Zhang Chen <zhangckid@gmail.com>
---
 qapi/misc.json | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/qapi/misc.json b/qapi/misc.json
index 28c641fe2f..1f5062df2a 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -117,11 +117,19 @@
 #     <- { "return": [
 #              {
 #                 "id":"iothread0",
-#                 "thread-id":3134
+#                 "thread-id":3134,
+#                 "poll-max-ns":32768,
+#                 "poll-grow":0,
+#                 "poll-shrink":0,
+#                 "aio-max-batch":0
 #              },
 #              {
 #                 "id":"iothread1",
-#                 "thread-id":3135
+#                 "thread-id":3135,
+#                 "poll-max-ns":32768,
+#                 "poll-grow":0,
+#                 "poll-shrink":0,
+#                 "aio-max-batch":0
 #              }
 #           ]
 #        }
-- 
2.49.0


