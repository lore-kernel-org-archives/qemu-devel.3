Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64F7ECD4F25
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 06:25:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMgYA-0004LJ-9C; Tue, 12 May 2026 02:25:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wMgXX-0003Fh-Co
 for qemu-devel@nongnu.org; Tue, 12 May 2026 02:24:28 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wMgXR-0005sw-CS
 for qemu-devel@nongnu.org; Tue, 12 May 2026 02:24:19 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-488ab2db91aso55777355e9.3
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 23:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778567053; x=1779171853; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+RyBTcXhGSgLGCVPmzWdJm9D7f8yrjL4XCYOfxRcoaQ=;
 b=opnQIFHKwKgO5wmc+jIVj7H25Mn3jS7MOi2maALY+JLbyv5+/05UKTsc0yIDJpBDIA
 1ATWDbVlxvwWJ1miVlZIUrKqIzjfMlc61+og5uov++F5mMl6Hgmu4DZp22sPXGcEnYd8
 XiXGONId9Pd+IuWeTC7Ncj8M9ODPwJph6sW86u1I3lRyQEnmaVwr78aAlf+7LHA/asik
 epqOieZuozsumEm6uuWnPL95fvZ+S2/paDPGCyBlMU56TYDjIydqSPMAEjPchxL+RuJa
 MDiVavaTzJHzSWOnAG62suPx9Hde2hHsDeZFuFwIU8iwXVn+0lQWTISUED9qVtjRpN8x
 DJ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778567053; x=1779171853;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=+RyBTcXhGSgLGCVPmzWdJm9D7f8yrjL4XCYOfxRcoaQ=;
 b=ifX3zEoM8n8wDQdF0+LJJeh0PtWU1FNpG4hhegbNmXLCLwpeIQkviwMvkroKqqTGTO
 BCwvXEQCgbPngu3D7oq3URRfxhXvArlXBuWeSX3o2GZowsvZ9XiitSx+gyyCLfbQPyKC
 zmDP5yiaRchV9Fakz1Pa5KIfRWCeZ40RoJco9kGdEr0ySOxzDZk4iOoJSr1Shni3nVvl
 AcQIz4ilogrJQ9sEz1jwxcQiiC2TN9IyWwp+z32NTJ9wr+d12cvFZQ9ZIPAC15hXJi8O
 3hTR6BTl6NVf8hlPPbXMK+RyFbjzY0z/1MOgHjNPeEiFC/NLQbN7YNM/cEhrSzeGXoO9
 laOQ==
X-Gm-Message-State: AOJu0Yx8cxcY98ThG/GIVxS5qWp4U4mPsNYuMhLCFHiCzs17NAAj3eG9
 uRq/PhjhIc3KOLuXwoXL729kvztyi9FhT2nAMsH3rJq8HTPyct94lf/01tu4kqy+TWf4jiCl5ul
 DFPq5Yn8=
X-Gm-Gg: Acq92OGbmbO4W6+s53llpBtJbxLSnQKdrBrGbbdcX3wG7z1moL9SI3oGNYSqFhff2CB
 dMpXKz70iP39+JNKXMrlJpR7jQG6jTU7hIWtlCnPjqXGn/5O5MGusR563SgTqA/eHvbLtZqHd+F
 iyqlURNrbMbQfqlugsRuM5OTrhrJUhrciUemcBgXiVew3ZiJOGp4qDMyz3M3PaO/DItwk/il2pD
 yZPAx4b42S+bypPlGynGpgsP/dAKCeoT/Y2qEwmA5XWHnTfyeRggsnasvspRfOorATC7egXZg54
 vB3gCi5S89qUPd6XdrEhblq2iPyelpPV9xN2o+2v4M22xn/KyO1ZwXlfcmj4lE8bEoPZLK6jWJS
 Gp5T6W5KEW251t/rPrF3qGYiYaS4hBbjDu/ziZRKIlNv4VPnWEU4mhdUs+DWzHk9dvsCa36j4Hi
 60qzBX+SmP4Aa2QQmpSfRA35yHAmE6UXylq/VTTgbfLUnHXQtKbM9wVLsiC4udzK+DVxMnbdGV
X-Received: by 2002:a05:600c:3151:b0:48a:7605:751e with SMTP id
 5b1f17b1804b1-48e51e0837amr411315585e9.4.1778567053218; 
 Mon, 11 May 2026 23:24:13 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e8e62a2desm12246395e9.9.2026.05.11.23.24.11
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 11 May 2026 23:24:12 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 21/41] target/arm: Rename arm_cpu_get_phys_page()
Date: Tue, 12 May 2026 08:21:22 +0200
Message-ID: <20260512062142.67998-22-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260512062142.67998-1-philmd@linaro.org>
References: <20260512062142.67998-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

From: Peter Maydell <peter.maydell@linaro.org>

The internal helper function arm_cpu_get_phys_page() is named that
way because of its use in the get_phys_page_attrs_debug method.  Now
we've renamed the method, rename the helper to match, since it can
handle non-page-aligned addresses.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20260417173105.1648172-12-peter.maydell@linaro.org
Message-ID: <20260430093810.2762539-13-peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/ptw.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 7dd3a7a3ede..24656b1a062 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -3942,7 +3942,7 @@ bool get_phys_addr(CPUARMState *env, vaddr address,
                              memop, result, fi);
 }
 
-static hwaddr arm_cpu_get_phys_page(CPUARMState *env, vaddr addr,
+static hwaddr arm_cpu_get_phys_addr(CPUARMState *env, vaddr addr,
                                     MemTxAttrs *attrs, ARMMMUIdx mmu_idx)
 {
     S1Translate ptw = {
@@ -3970,7 +3970,7 @@ hwaddr arm_cpu_get_phys_addr_attrs_debug(CPUState *cs, vaddr addr,
     CPUARMState *env = &cpu->env;
     ARMMMUIdx mmu_idx = arm_mmu_idx(env);
 
-    hwaddr res = arm_cpu_get_phys_page(env, addr, attrs, mmu_idx);
+    hwaddr res = arm_cpu_get_phys_addr(env, addr, attrs, mmu_idx);
 
     if (res != -1) {
         return res;
@@ -3984,10 +3984,10 @@ hwaddr arm_cpu_get_phys_addr_attrs_debug(CPUState *cs, vaddr addr,
     switch (mmu_idx) {
     case ARMMMUIdx_E10_1:
     case ARMMMUIdx_E10_1_PAN:
-        return arm_cpu_get_phys_page(env, addr, attrs, ARMMMUIdx_E10_0);
+        return arm_cpu_get_phys_addr(env, addr, attrs, ARMMMUIdx_E10_0);
     case ARMMMUIdx_E20_2:
     case ARMMMUIdx_E20_2_PAN:
-        return arm_cpu_get_phys_page(env, addr, attrs, ARMMMUIdx_E20_0);
+        return arm_cpu_get_phys_addr(env, addr, attrs, ARMMMUIdx_E20_0);
     default:
         return -1;
     }
-- 
2.53.0


