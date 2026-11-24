Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF037606A326
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 13:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=mQLgYCGm
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVqaL-0005Bv-3d; Tue, 24 Nov 2026 08:29:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xVqaF-000581-HJ
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 08:29:20 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xVqaD-0007Og-Cu
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 08:29:18 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-48e20ed3b9dso4029756f8f.2
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 05:29:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795526955; x=1796131755; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=le6CAWzblk/ZaadxjpMa8YiEp7vxRkoI9osBZvSK4i0=;
 b=mQLgYCGmzomrC1goDrojtAaoXog3bvvfSEGuCUqN+yBOFKska6jQcrcPFjTpZgSPPL
 YWlaKCaN/yaXDVC6/OmqquBKbGKa0v/xTYbpBc4WlZYz/+DSecvmCvk63c3WZzZ2dvcS
 vQQLeeF+OHroSvwz36Hhb0JQdEHuiAPSLoMjUaZ2BZJph+U0E0I7fpFTqmb3dY5rF21D
 vFGgxlzv5O2gJo8j7plA/Uvpv6/udY/NdXiWwxJ0h5eR5VCIScvSR1K7Pm0o7gkPsBZi
 RRDEOaOsaD+NQURCRI4EHGxkK/dgyeMLxSwgMTyv0ssLJ4lU4CpjY6JGokqHqRbEpx9W
 4BdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795526955; x=1796131755;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=le6CAWzblk/ZaadxjpMa8YiEp7vxRkoI9osBZvSK4i0=;
 b=khzri/qUwW3Fsnn1O+yQ8VNYIrGbEzd9Z5rLQaZdu9WysWk6Hak3dr0MDxNGtSL7ZO
 AL7sv67Phb4uiRaXJZUYDSONPj+HXpkus8fqxr9yOw56CWk2YOL/OGxPRfavSxNjEvGL
 8y37APs+OHnJwe2lmdpQXeVFW0FLWO9W6pUJSM8ehdFqAyyQ/WhkrOQ8akMc/+bSRFSp
 JLX+SWEyZiDf9g1payuR7ezTzI7Gtp3dXHwBjSqXm73VlLNFLnemCSZyxG+1s63kZ6/R
 FO/ZzHRiXkbT/u+INr1dkRbRmumORTTGphPYUFHOrNRDif+6fCwPHglWDSLvdzgRJHNB
 NGug==
X-Gm-Message-State: APuU4Z+RL4LVU/Jxm2zVjqJPoce8yuhy/1496zgUsDTSr0qhMTrdUD+c
 baZDrQSYwCmaY3lkyoVf59uYipPLFn1d4P8PaEDl3Nnrr7LFK5pCu6py0raPxCoYCmQnSAdK11B
 MRUai
X-Gm-Gg: AZFdTZf7MLIQsrFu/B9X4lG2zENsMVbXpNGvcy8t/uqZq6sB81ykRybMyr630XZSZ7a
 aZErBh+l2Hp9TJb0vrd3UCV3pyl/WL4Sq78TLrIqdtChxC6CqGjXVwxkdjZyc4HfA+deESVyjo5
 JZexn26VoaKJ9ewXu6qkLRffGn3dGq+WU5xiHbZmAEn36+JzOY6kNgaiIaM2x9xLRQumB3qceE1
 CXfIzuLr7lOzyKedzdn4jIz5+V1uTzxDEOaccpMJ+UCCM4ga6SQL3MpYqwN5sjEv++pDQ5Ja2yF
 rqdNoJ5W7SnVfCsrYJzA+uvG+jSyyfe8A1NbjtomH33W3vaFiJOIetu2Bob/zk8uCQAASo5Xhmr
 hGn2GtcTprTilMEX1e1/6uSu9zIfMpwwY1qP1bp3GLB+mzEVQdM40fmSKwfdpVuSU/neFDNSaHR
 r2RjH99Yyub7Q3bSHEzl3+YsPN+3Js1LDCzstIRqooh6d8NGTN5Q9uNCGPNGppHLG77sg/RJhx/
 CziCUh+b1vKxa+Nouh/1tEzdAPsD1wIkPFEEPFOp2UumpKM79wmqVkMayn3J2Kp/SxkOlAPJlmI
 wCj1YYjYymKj0N7Wwmi+reBx4MQnZIDxQ6ThzIx+0zTnEdl6+4Mo/mr8XsK6AC6NPxLJAAH0dRq
 5bWNbUv5cRYDuVwr+fNEq2cpXtXEruiFn8g==
X-Received: by 2002:a05:6000:4705:b0:48f:c4fb:6bb6 with SMTP id
 ffacd0b85a97d-4abb400bb83mr28002979f8f.12.1795526954761; 
 Tue, 24 Nov 2026 05:29:14 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6b10b2c9sm29098031f8f.31.2026.11.24.05.29.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 05:29:14 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 8/9] hw/watchdog/wdt_imx2: Fix migration when
 pretimeout-support not enabled
Date: Tue, 24 Nov 2026 13:29:03 +0000
Message-ID: <20261124132904.138731-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261124132904.138731-1-peter.maydell@linaro.org>
References: <20261124132904.138731-1-peter.maydell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42a.google.com
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
	autolearn=ham autolearn_force=no version=4.0.1
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
Tested-by: Karl Mehltretter <kmehltretter@gmail.com>
Message-id: 20261116114641.1799526-1-peter.maydell@linaro.org
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
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


