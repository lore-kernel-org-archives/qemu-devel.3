Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 446D6C5CFDB
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 20:46:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuFoh-0003We-Va; Wed, 12 Aug 2026 16:44:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wuFoZ-0003Td-87
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 16:44:44 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wuFoX-0002E7-4O
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 16:44:43 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-8486672f03cso40690b3a.0
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 13:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786567479; x=1787172279; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3akShtEwH2yEkecYdy8M8JZlOVHw/AUW4gO3Tv3SW4w=;
 b=ZwVntx+wGi+WMJ9mjtpbUB5okbhdAV8EHl179RLS5y6fXwbr9jfVK0UcSQVAHUF7rj
 x9MuPKmzdyjrmC1uS5n1OQ4g1wCnBNlEmbmO4B5to5kITRTfTO5JTeA5fWke439jmaZm
 yIiWfnuUqY7TnCGjSO2h27KwJsi79twqSkdjs28h4RNjz7vLNxB5CSiNlAiNVTi33k/j
 MXI0XESHUqfrA8YlyYJd8VA45oLJY9ngZ5i/Hxs1xoRIWFjl2WtXsKCQ1xXxK4RFvJ6c
 zi76Bz881Gr2C5/P1d6MgByfuSVDsgNGZWgh4j9+FE4bPsCW79dOE1IcwntX1qAbnPlq
 oHSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786567479; x=1787172279;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=3akShtEwH2yEkecYdy8M8JZlOVHw/AUW4gO3Tv3SW4w=;
 b=PxqUl5wa7Y64d0lFkB3kNzUIwo05DXnxu5IfDV9DY2W0RsEvSEx6UdtjwfXGDhBQsM
 S/khcsOkTklju6ygznGwsg33OyL9JydogtQbzoMWU2z+DkFPpROeI/yfWUcrI6g4Fem/
 BsWOI3sITcQ1HmgbUKUkJapeSa5IRfZd3Ojy5h9MkuIpmn9R7fbBJYLXeE+ExKXhLDKa
 WY1W+KRk4P2UwjUZnZhv5XNoQZr/hhpzSo5YTgmXoW1iPLqmyBrCvjYw3uR2LZcr2SGV
 tKsgRGPNptoCSY7b4wavRIWbOqe201bkNfir4ENu6iUlMrowj+AmOVCEqpcJoUlS6B7x
 6HMw==
X-Gm-Message-State: AOJu0YwWqHpUpF/na/UeBCWSQEIX44ITSGRkjlHwCE8ct/+izf29H7pI
 9hQe1M/P08O55AO1RhvKYE5Fxv5QKlm8O1NjICvhJUON2kY0sAEfQWh6C20tuXwinETaausUXgb
 B4CZN
X-Gm-Gg: AR+sD11tJhLC/dVPTgLypYJGfCbR5DBtYRUeiupPAyFx36rGoJElOBL//WGRqW4aNli
 nlzq6B794GKYP6XAyzcwbu702ODrBlfr2AmMblYJIUstBS3On0nPASJtGoZEHyw7Za4173hW39b
 7seSHNv39Oe9zDo+Ao/BbxN13OKsskIVnuuvVCKhVGWurQ1qJ5543GW5rQBpDH2U09++MqTaOUq
 Gkax+xijj7JnDOIHQiXDtVpUNJnY+u9L2zh8jdaGI62/bf6bfspx2+z47otBTxyeflcYMD6g54u
 AY2wmc2oZzQ7zpoRzXmAPP7OEw26TsOAsJtaNf+cvQYBFYVExH1TbJjz8txXiq5/DXlAIQCAi5v
 l5OuXZMkA0CslUMXK5d7FVtvtC89zbp2zMTGOU/pGfsSpzngergZHc2+MWfWfw9IHnAXa3oH3QA
 Rvfit+B/IH17qDY7cWFT5DsHl6FPSB3J9mUMyl6ekfwIeDRXJ7aynnbdUYIoaCeGOfI/qGS4jaI
 UG425aKAoQacb0GATiFqYnUrhYJzho=
X-Received: by 2002:a05:6a00:bb0f:b0:837:f79d:909 with SMTP id
 d2e1a72fcca58-84fc75032c9mr511176b3a.39.1786567477627; 
 Wed, 12 Aug 2026 13:44:37 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84fc4787325sm125308b3a.23.2026.08.12.13.44.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 13:44:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v2 01/10] target/arm: Tidy cpu_max_initfn
Date: Wed, 12 Aug 2026 13:44:26 -0700
Message-ID: <20260812204435.295067-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260812204435.295067-1-richard.henderson@linaro.org>
References: <20260812204435.295067-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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

Once we have eliminated hwaccel_enabled, only tcg and qtest remain.
Separate tcg from qtest initialization.  Remove an assert on
aarch64_enabled that is directly protected by a preceding if.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu-max.c | 39 +++++++++++++++++++++------------------
 1 file changed, 21 insertions(+), 18 deletions(-)

diff --git a/target/arm/cpu-max.c b/target/arm/cpu-max.c
index 88b7c04633..0a310d1b15 100644
--- a/target/arm/cpu-max.c
+++ b/target/arm/cpu-max.c
@@ -203,29 +203,32 @@ static void cpu_max_initfn(Object *obj)
         return;
     }
 
-    if (tcg_enabled() || qtest_enabled()) {
-        aarch64_aa32_a57_init(obj, !aarch64_enabled);
-    }
-
-    if (!aarch64_enabled) {
-        aa32_max_features(cpu);
-#ifdef CONFIG_USER_ONLY
-        /*
-         * Break with true ARMv8 and add back old-style VFP short-vector
-         * support. Only do this for user-mode, where -cpu max is the default,
-         * so that older v6 and v7 programs are more likely to work without
-         * adjustment.
-         */
-        cpu->isar.mvfr0 = FIELD_DP32(cpu->isar.mvfr0, MVFR0, FPSHVEC, 1);
-#endif
-    } else if (tcg_enabled()) {
-        assert(aarch64_enabled);
+    if (tcg_enabled()) {
         /*
          * '-cpu max' for TCG: we currently do this as
          * "A57 with extra things"
          */
-        aarch64_max_tcg_initfn(obj);
+        aarch64_aa32_a57_init(obj, !aarch64_enabled);
+        if (!aarch64_enabled) {
+            aa32_max_features(cpu);
+#ifdef CONFIG_USER_ONLY
+            /*
+             * Break with true ARMv8 and add back old-style VFP short-vector
+             * support. Only do this for user-mode, where -cpu max is the default,
+             * so that older v6 and v7 programs are more likely to work without
+             * adjustment.
+             */
+            cpu->isar.mvfr0 = FIELD_DP32(cpu->isar.mvfr0, MVFR0, FPSHVEC, 1);
+#endif
+        } else {
+            aarch64_max_tcg_initfn(obj);
+        }
+        return;
     }
+
+    /* Ultimate fallback: -cpu max as cortex-a57. */
+    assert(qtest_enabled());
+    aarch64_aa32_a57_init(obj, !aarch64_enabled);
 }
 
 static const ARMCPUInfo arm_max_cpu = {
-- 
2.43.0


