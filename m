Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CDF7F483CC
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 16:54:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4iX8-0003li-GJ; Mon, 23 Mar 2026 12:53:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w4iX4-0003JP-1P
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 12:53:38 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w4iX2-0000YR-7N
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 12:53:37 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4852c9b4158so33740755e9.0
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2026 09:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774284814; x=1774889614; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=/YhwIk60da2oTQuJc0jryc1bfNTZEuAJTxikVRlrD0Q=;
 b=uVlgd+74ol0GcCOf9ssu3EvsNE8sUXZvB5zoSXS2OanF93wpIKVFeuvPTXJvyLO2b8
 sKvabCHU0Sch3BK69A4fym9VMQ/zxiP4+8CxWVYDT25rXtrdRpYQVt/kOz4IR7IJnqie
 KLvKg/ydszmpx9Q13gofe9hzUez3M0WsPJmIEWUp3ptMttJkqTvNNzzOsCPpwUBh9t5z
 jnODPUPB3bhd17VjYvuiglso4s66+sSd1+p/lnB79DB+rzwqsuLpBHNCqskA2xQ/HAsZ
 9hhSvzeLgqS1nREeUo44eK9dHvNn+10rrdjo5qHx5MWOQjl0iqEc3omoji1158RZ+C6v
 n7jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774284814; x=1774889614;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=/YhwIk60da2oTQuJc0jryc1bfNTZEuAJTxikVRlrD0Q=;
 b=cc9NNjkExlGo4C/ZMXLiqtCKvbm4ikKkRrqryGrPmICfwOHbJ486FliWrHyEHxpqmH
 qmrCq4tPnfvp9Jhoj9nu2kU1HQN/H9D2c/rAWwfJ8+Vi7A1GYagE7ZDBs6ojmDn1Zcg4
 pv/vKdBO7A/8Dklfe7vFMTzzhObIjgO6n8GAaEFyBhFa/1Zd/HCPMnsFduG6xU2GUrk2
 8/RVh9oFRKuOG8CjLRlBqlE4kbfkr5pR5wSE29M5YGhbZmAa1y10TfHjcujiRtfhJV20
 bHr+gyic4LNNB7WoExfySbKltl7mJEHgH2VPriOdt+vsVla/lJE3k0aBAaXgTWdjdetJ
 73bQ==
X-Gm-Message-State: AOJu0YwPPOOR3iQzmFyTDOBpmoN4gyphQVv2x+emZ8Q7e+8uzPNocV2u
 N+UJHNGjAM+C23Yz0cbbGg1fLtRxoKEXuQskpces+mowMfG/qFX+NQfSIrFhCMQ6YjUEVtY3m3R
 rQzt9tug=
X-Gm-Gg: ATEYQzx3CKHBB2DrEHbeh9RKGKhNRrw3n2WPM5S7oir+i4zfKzK0iQ5AMHYPUjBejAF
 lTtasGDEJErKGk4C4W3kg7DiiR4VFYj6ZUkm+Youa+7ILrE22bA1C2o6YXt7xIyoeVcJnR6Xuhx
 1OR6VoQXlYqjmojRC4vGVhNOnPaDkHkmUcWexzmOzrG1LJd4J5GtNsWN1JHDPwTjOoMZZxng3lR
 0GC83b1lPWM0yt/bm1NNRoo1+/NF/A9LC6aP7dU63dyYcNwrIyutITvoRuMMRpq21errbfsQMV/
 Yi1qmgdymp7aLrFv9IwH54EUXZjlQmbSDZZnvadn4oIUQwtUs7j1fOoLQBfZ4ZYHjKXMc3ga26m
 Y72rMNntE50pZZjBPpFafanhIr3OS3hYkcENBgM5RR3K15/J51OBVR5V++hD914FiHUhqfCq+6X
 BoM/txv7pUAHreHNoK1v2ISf76z7sRN9/Bq32F6/WjziUZPm1MWUzBhR8WoG0To3hXtRW/V5a2
X-Received: by 2002:a05:600c:1d1b:b0:485:3cf3:1010 with SMTP id
 5b1f17b1804b1-486febb5fefmr189242445e9.2.1774284813981; 
 Mon, 23 Mar 2026 09:53:33 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-486fe8367d8sm345405025e9.14.2026.03.23.09.53.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 23 Mar 2026 09:53:33 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/27] hw/cxl: Respect Media Operation max ops discovery
 semantics
Date: Mon, 23 Mar 2026 17:52:02 +0100
Message-ID: <20260323165218.96607-12-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323165218.96607-1-philmd@linaro.org>
References: <20260323165218.96607-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

From: Davidlohr Bueso <dave@stgolabs.net>

The Discovery rejects requests where start_index + num_ops
exceeds the total number of supported operations. Per CXL 4.0
Table 8-332, num_ops is the "Maximum number of Media Operation to
return" - a maximum, not an exact count. The device should return
up to that many entries, not reject the request.

Cap num_ops to the available entries from start_index instead of
erroring the command.

Fixes: 77a8e9fe0ecb ("hw/cxl/cxl-mailbox-utils: Add support for Media operations discovery commands cxl r3.2 (8.2.10.9.5.3)")
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
Message-ID: <20260319184256.3762391-2-dave@stgolabs.net>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/cxl/cxl-mailbox-utils.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index c83b5f90d4d..a5b70cd01c0 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -2675,6 +2675,7 @@ static CXLRetCode media_operations_discovery(uint8_t *payload_in,
     } QEMU_PACKED *media_op_in_disc_pl = (void *)payload_in;
     struct media_op_discovery_out_pl *media_out_pl =
         (struct media_op_discovery_out_pl *)payload_out;
+    int total = ARRAY_SIZE(media_op_matrix);
     int num_ops, start_index, i;
     int count = 0;
 
@@ -2691,24 +2692,20 @@ static CXLRetCode media_operations_discovery(uint8_t *payload_in,
      * sub class command.
      */
     if (media_op_in_disc_pl->dpa_range_count ||
-        start_index + num_ops > ARRAY_SIZE(media_op_matrix)) {
+        start_index >= total) {
         return CXL_MBOX_INVALID_INPUT;
     }
 
     media_out_pl->dpa_range_granularity = CXL_CACHE_LINE_SIZE;
-    media_out_pl->total_supported_operations =
-                                     ARRAY_SIZE(media_op_matrix);
-    if (num_ops > 0) {
-        for (i = start_index; i < start_index + num_ops; i++) {
-            media_out_pl->entry[count].media_op_class =
-                    media_op_matrix[i].media_op_class;
-            media_out_pl->entry[count].media_op_subclass =
-                        media_op_matrix[i].media_op_subclass;
-            count++;
-            if (count == num_ops) {
-                break;
-            }
-        }
+    media_out_pl->total_supported_operations = total;
+
+    num_ops = MIN(num_ops, total - start_index);
+    for (i = 0; i < num_ops; i++) {
+        media_out_pl->entry[count].media_op_class =
+                media_op_matrix[start_index + i].media_op_class;
+        media_out_pl->entry[count].media_op_subclass =
+                media_op_matrix[start_index + i].media_op_subclass;
+        count++;
     }
 
     media_out_pl->num_of_supported_operations = count;
-- 
2.53.0


