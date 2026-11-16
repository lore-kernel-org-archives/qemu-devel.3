Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1FD1606A31C
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 11:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Qe+dOynG
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xSvAh-00029D-S2; Mon, 16 Nov 2026 06:46:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xSvAd-00028k-7J
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 06:46:47 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xSvAb-0002bf-9P
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 06:46:46 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4a35d5d4a20so41515705e9.2
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 03:46:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794829603; x=1795434403; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=OWDEm1TDlLJPZkbYtICoVOpb9/mEHmAgIkvbbARcZcE=;
 b=Qe+dOynG+gUMCuu5YaoAntmvMkSFY7YlYixsU8XPCgeJVrQDmndFxdAHIpv0tkSuCH
 bIe3VZ9F6ZQsPM4pPoehJy5TzOldZeZiM2DOnsEhFQivckXbaQVsq5JAVHL3OeoQWCIv
 84P4WiL3FZAC77J+b3STHzVAg3Y/KC0gkRkOGTuibpj3z0Wq+h4rlelbqnCL8ZBY6N5/
 dD1numRP0lSGcDBIU7Rk0GC9a9TwK1EhiqCTY4bytOQnVs2NL1sZVCVdxdgSFJfZ052C
 1fSOTF3zRzI3peYLWsrowYs4/XOgU9NlQAGiqa6aaX1B0AVlHjsib2OZvOMHO7R6ZgPa
 qTqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794829603; x=1795434403;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OWDEm1TDlLJPZkbYtICoVOpb9/mEHmAgIkvbbARcZcE=;
 b=0YuqThptBbNYIrn83H7IOKpp2hsf3WvUfkbeve3zTJC8UA4edty4ndQWdZTlA6uQKX
 H1oBx11UuamAXdC3BYEFBt9J25rONsYEW/fPjxz0AwNsrht+H20irw6XOYXj3GKfJG1/
 XKNrDmEWCDWC1Tqm8XnqvroOAFaLk4IJkupFVRRnXz6z6OziuIVHxvQWs1kjOwHPjBYm
 ZFS+jW7OSvW2ZKG31owCO0EQzyywYr4QeIS0PN88vElM98fggOwC2BkE4u/0SZCDAf5g
 11yT5Pk4mqGnGazUmR03UH60DoqRFnW2rv1onVsFPUU8i10oLPl2k26FgyPt32bk6Wwd
 1yFw==
X-Forwarded-Encrypted: i=1;
 AL+hErHIe3caKku7+G0iVnjfE/5eZIR+Nh1INpR1N8eYEDgRq+KV2z3VUu6X9hXtAIBy2LEjzQUCUAKT1NcD@nongnu.org
X-Gm-Message-State: APuU4Z9bz5VRvYP3FdGr0tSTPjfhEnlGQK9w8YTIaHwlpv2FYgVILTQv
 w/jefrEWAuhgG1boMAIfEpX75RijtipxyT3J58R7QtFCcOo47yVgklCXzHS45KGx+n0=
X-Gm-Gg: AYBFou1WuOPvFg+yq5G/owKvXiLdZQ3g8CgtxvBRBOiChn4N0DqnSi9KTG3kxht/d2y
 7XuW3RiHxr7M5lgnuHE687YG1uv8p7FxlwzG8ZHOe4xSL+L5PZx1TwSG10Jh9mMJK690yWBYu9I
 MP8Nh5pd2eRq+6+uFQeYmnSsctACklDvx24SZTV3JInR/yRAfSvNvNhXAXn4siIEeyuf4xyRjHR
 YGsDGAjaJbjR0Yg1XsTlyHEqHYugKq+gFMVwpV4LCPtioy6/yAQzqWkKedlZ9CB/Tg+DhpMXe7T
 J43tYjN80VQCCUzCsd1q1IrWVJ1AqODB291ZfX2Z7RXtkJEC2xdLZlfrnOAGGptCugXdFTiUA8F
 t/3jofvWinsLZy1s3a/bymq+hd8zitMn9Fjw0mpFZUvCXS+nqA0HwShPbgs4mAHOByDRC9YlzMH
 9anlTbVY8rVQUDs8kyPeLnBHEMa3xMZieBRoT1g8JX6lkpQARniGj1I4CJLvJO9Xi+TGcVVUyDH
 NGirJwAkI1kZuo5hGrYHriJvNp3z5/X1Y60PxHJt84xtplqLo5ifHq+15e38o7OGd1ByQVkE0if
 jIAurO1oB3pnmQHvojxYg2VJNdxbUvkJcmmTqUTKSsrzFNDhiKxHHN1iAkBJgFj5+z54Tj181cH
 Wod72AwEEnilJC30U9uPGDIIFbL39A9p4Ng==
X-Received: by 2002:a05:600c:4e45:b0:4bb:56bb:1196 with SMTP id
 5b1f17b1804b1-4bb56bb49f3mr207881485e9.23.1794829603391; 
 Mon, 16 Nov 2026 03:46:43 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb679b7e1asm277105995e9.6.2026.11.16.03.46.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 03:46:42 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jean-Christophe Dubois <jcd@tribudubois.net>
Subject: [PATCH for-11.2] hw/watchdog/wdt_imx2: Fix migration when
 pretimeout-support not enabled
Date: Mon, 16 Nov 2026 11:46:41 +0000
Message-ID: <20261116114641.1799526-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The wdt_imx2 device has optional support for pretimeouts, which are
present on most i.MX SoCs but not on i.MX31.  If the QOM property
'pretimeout-support' is not set to true then we don't create the
ptimer associated with that feature.  However, the migration vmstate
unconditionally lists that ptimer, with the result that trying to
save the vmstate of an i.MX31-based machine like "kzm" will hit an
assertion.

Move the migration of 'itimer' into its own subsection which we only
send when pretimeout support is enabled.

This bug has existed in the code for a long time, but it was hidden
until commit d9abd0253be ("hw/watchdog/wdt_imx2: Remove redundant
attributes)" because a bug in the VMSTATE_PTIMER() macro together
with the fact that the vmstate_imx2_wdt version_id was 0 meant that
we weren't trying to migrate the device's ptimers at all, and so
we avoided the assertion (but didn't migrate correctly).

This is a migration compatibility break for this device, but it isn't
used in any versioned machine types, and we've already decided to
break compat on it this release cycle.

Fixes: daca13d495a11 ("hw/watchdog: Implement full i.MX watchdog support")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4876
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
Based-on: 20261106163657.3825938-1-peter.maydell@linaro.org
("Fix 'version' arg of VMSTATE_PTIMER")
 -- the patch in that which sets minimum_version_id to 1 in
    the wdt_imx2 vmstate would otherwise be a conflict
---
 hw/watchdog/wdt_imx2.c | 28 +++++++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/hw/watchdog/wdt_imx2.c b/hw/watchdog/wdt_imx2.c
index abb8edfae25..b4196de7021 100644
--- a/hw/watchdog/wdt_imx2.c
+++ b/hw/watchdog/wdt_imx2.c
@@ -221,13 +221,31 @@ static const MemoryRegionOps imx2_wdt_ops = {
     },
 };
 
-static const VMStateDescription vmstate_imx2_wdt = {
-    .name = "imx2.wdt",
+static bool pretimeout_state_needed(void *opaque)
+{
+    /* The itimer is only present if pretimeout-support is enabled */
+    IMX2WdtState *s = opaque;
+
+    return s->pretimeout_support;
+}
+
+static const VMStateDescription vmstate_imx2_wdt_pretimeout = {
+    .name = "imx2.wdt/pretimeout",
     .version_id = 1,
     .minimum_version_id = 1,
+    .needed = pretimeout_state_needed,
+    .fields = (const VMStateField[]) {
+        VMSTATE_PTIMER(itimer, IMX2WdtState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static const VMStateDescription vmstate_imx2_wdt = {
+    .name = "imx2.wdt",
+    .version_id = 2,
+    .minimum_version_id = 2,
     .fields = (const VMStateField[]) {
         VMSTATE_PTIMER(timer, IMX2WdtState),
-        VMSTATE_PTIMER(itimer, IMX2WdtState),
         VMSTATE_BOOL(wicr_locked, IMX2WdtState),
         VMSTATE_BOOL(wcr_locked, IMX2WdtState),
         VMSTATE_UINT16(wcr, IMX2WdtState),
@@ -236,6 +254,10 @@ static const VMStateDescription vmstate_imx2_wdt = {
         VMSTATE_UINT16(wmcr, IMX2WdtState),
         VMSTATE_UINT16(wicr, IMX2WdtState),
         VMSTATE_END_OF_LIST()
+    },
+    .subsections = (const VMStateDescription * const []) {
+        &vmstate_imx2_wdt_pretimeout,
+        NULL
     }
 };
 
-- 
2.43.0


