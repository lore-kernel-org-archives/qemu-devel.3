Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5B42C4828F
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 15:39:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVvb1-0000Jz-4Y; Fri, 02 Feb 2024 10:36:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rVvaw-0000CS-QZ
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 10:36:46 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rVvav-0004SQ-7D
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 10:36:46 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-40fcb4ef7bcso3124685e9.0
 for <qemu-devel@nongnu.org>; Fri, 02 Feb 2024 07:36:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706888203; x=1707493003; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=yhQX2lsO6sUMNlz849ghUPa03+uYKB43z4lr+2t+Z6I=;
 b=gX/lDcsEJwwg8hCxnTaBQ6o1cGLATxsb4aOkRP9a7AN8x01yZlR2S0LxxDZKOTJPcG
 wlDxk+0jdP5SX/L+Fi5tPj9bWTPYzcPgLOMiYXSL3ztOA8NRYINqjqEFZp1tiZHhS7ct
 PcA6HYcw6zqCZqMRvXAo0Y3Iit2id93Od/YzEygICUeohky6Okb2NVG24VErXzjaxmFH
 ShNVz3df2Hdo76IJBQnNHy9NRkGddEX+V5CHeOW/9jnRondXYCenhS2pqJp5dX8RW3vL
 THF+DLB3trSuTx7EmfvK+FIrbpRx5QTERoWoFvkbK6BpqqbVvrA0S5whwfK8Fz3tK8im
 C+fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706888203; x=1707493003;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yhQX2lsO6sUMNlz849ghUPa03+uYKB43z4lr+2t+Z6I=;
 b=bXHYelEBKtv8bf/OCP0g6BYdz1ia/ulLU0G+guSQBPZcSBZHdcpz856MuvNR6wHTPy
 DE88HMXA6/UTO9HHxbq9+14nASrPcnAo+RRoMExSdW4ERTw80XQ/Qn08jjATDRKMm5ez
 raxsuha71w3Hg0h3tIfmPziillCbdDct6Hh4/dZPkODOOBUBoTWkUkSsSGB52BEs+unY
 bAI2FfvXH+78+W9jLiSSanood8V/ttn3JD7FB1ZkUab7g/bnxdm+Xr6uMYBQhx6M1PHq
 v64IkdjtmsZSTLZNa2J2429Um3iX/BheigOimJ5V8RWQsAinMkCN3ehivNtEgEQAnr9O
 p0ig==
X-Gm-Message-State: AOJu0YxdSnW/n3nX2xf1J8O8dNF9PbUoO4vIsoiZjGadRFU/5OAu9jco
 +OAf2j6ad9flZI0w8N0ZKeLUMZ78qKsHl2F9B8fyIdjmGXVZKKiZWIIRgXj4bd4eeE1uZxEYy4N
 T
X-Google-Smtp-Source: AGHT+IGr9rlgGS/EPQPRmOZ/rsqBL+RwLgZr17qhF4E/XsAI9DNXwPB7XoCyqI3Z6BDcapfOo7JNpA==
X-Received: by 2002:a05:600c:470c:b0:40e:fa18:f888 with SMTP id
 v12-20020a05600c470c00b0040efa18f888mr4062171wmo.14.1706888203589; 
 Fri, 02 Feb 2024 07:36:43 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 k2-20020a05600c1c8200b0040fafd84095sm214735wms.41.2024.02.02.07.36.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Feb 2024 07:36:43 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 10/36] tests/qtest/xlnx-versal-trng-test.c: Drop use of
 variable length array
Date: Fri,  2 Feb 2024 15:36:11 +0000
Message-Id: <20240202153637.3710444-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240202153637.3710444-1-peter.maydell@linaro.org>
References: <20240202153637.3710444-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This test program is the last use of any variable length array in the
codebase.  If we can get rid of all uses of VLAs we can make the
compiler error on new additions.  This is a defensive measure against
security bugs where an on-stack dynamic allocation isn't correctly
size-checked (e.g.  CVE-2021-3527).

In this case the test code didn't even want a variable-sized
array, it was just accidentally using syntax that gave it one.
(The array size for C has to be an actual constant expression,
not just something that happens to be known to be constant...)

Remove the VLA usage.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Message-id: 20240125173211.1786196-2-peter.maydell@linaro.org
---
 tests/qtest/xlnx-versal-trng-test.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/tests/qtest/xlnx-versal-trng-test.c b/tests/qtest/xlnx-versal-trng-test.c
index cef4e575bba..ba86f39d13c 100644
--- a/tests/qtest/xlnx-versal-trng-test.c
+++ b/tests/qtest/xlnx-versal-trng-test.c
@@ -298,10 +298,13 @@ static size_t trng_collect(uint32_t *rnd, size_t cnt)
     return i;
 }
 
+/* These tests all generate 512 bits of random data with the device */
+#define TEST_DATA_WORDS (512 / 32)
+
 static void trng_test_autogen(void)
 {
-    const size_t cnt = 512 / 32;
-    uint32_t rng[cnt], prng[cnt];
+    const size_t cnt = TEST_DATA_WORDS;
+    uint32_t rng[TEST_DATA_WORDS], prng[TEST_DATA_WORDS];
     size_t n;
 
     trng_reset();
@@ -343,8 +346,8 @@ static void trng_test_autogen(void)
 
 static void trng_test_oneshot(void)
 {
-    const size_t cnt = 512 / 32;
-    uint32_t rng[cnt];
+    const size_t cnt = TEST_DATA_WORDS;
+    uint32_t rng[TEST_DATA_WORDS];
     size_t n;
 
     trng_reset();
@@ -370,8 +373,8 @@ static void trng_test_oneshot(void)
 
 static void trng_test_per_str(void)
 {
-    const size_t cnt = 512 / 32;
-    uint32_t rng[cnt], prng[cnt];
+    const size_t cnt = TEST_DATA_WORDS;
+    uint32_t rng[TEST_DATA_WORDS], prng[TEST_DATA_WORDS];
     size_t n;
 
     trng_reset();
@@ -415,8 +418,8 @@ static void trng_test_forced_prng(void)
     const char *prop = "forced-prng";
     const uint64_t seed = 0xdeadbeefbad1bad0ULL;
 
-    const size_t cnt = 512 / 32;
-    uint32_t rng[cnt], prng[cnt];
+    const size_t cnt = TEST_DATA_WORDS;
+    uint32_t rng[TEST_DATA_WORDS], prng[TEST_DATA_WORDS];
     size_t n;
 
     trng_reset();
-- 
2.34.1


