Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4464C606A332
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 11:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=X2bB9d77
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xSueZ-0003t8-WE; Mon, 16 Nov 2026 06:13:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xSueF-0003oy-IE
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 06:13:19 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xSueB-00028C-LZ
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 06:13:19 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4b467581b98so27278645e9.0
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 03:13:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794827594; x=1795432394; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=EkTO5OKhIvmjA8dCdWmtqg7FDtpodxdkVq2Or8ASgtw=;
 b=X2bB9d778RP+icoc5MZ4Q533/cc9dwiLtlBhti4pTP3ciOHWFmMeWdzlusxrgmbU0X
 j4jPAfKxNiBEy1Xd2jurttyDMaLxwnqmacZoHgwX1D27NvVc4D47BM/Z4vIivCLM+Xes
 Y9Xcb5bafTlCndSWRhMCGhDEgpKCcJRhQu+RAK0HcAYKncm4PzoVerj0Yo2pHUxr4mgV
 agZ6WHs97gcfPYndiG38vU81FsVoF/9myFCZJoPho5gZEDbgTyuiJCLq0N/AvFL7lOaQ
 EKxptJcGnKOo2TJchpcutYZPlgFEnOHnk2QhD27NqY+WHen/ppZNuxMHmJJiLX7s/9Pc
 rf5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794827594; x=1795432394;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=EkTO5OKhIvmjA8dCdWmtqg7FDtpodxdkVq2Or8ASgtw=;
 b=k4DA1LvR8zyVY+kxdOMNdGPsZpAFFjP1nyEfKur1Uvq5PfFksD11dsVoj5XFe9cu3d
 GJjyKZKLSOgsOQGfRrSrorviU6+bDYMTPi/RJAkXA68a5mfla0ZUEqMqNOoaV26mUTRG
 jfo5BAjU1Dtm6Y8XAclsX03zTOcu1+UO5xSP/waZiwcMYPLNbxdU+Fij4JIiv1yV6uGV
 CkaSO+wZ2Dy9ZoVVx23Jfc8jnwDnThw0t5H5+cfk/JBlT4jsV2UDpjcSTQmZXZK+UU5U
 0wwvOgr+FSSK4QBLOt2xxQZCf/Tx62vsNnkcBtteg1zQ61TCESL0v/eH3tz3rcr/7Xhk
 RSug==
X-Gm-Message-State: APuU4Z/Fa2xR3gyTle9mx1EFbME3NyUOVah4WRxUNULFedO32PSQzdrg
 fBNJYuOdPQBZbHy7/uK2fbr6bHmyEatXFSwigbPNCht1BifuyGUN8mEzMf4wX3Zn+NZs+jDYpW9
 vbmg5aW8=
X-Gm-Gg: AYBFou3b0qDjUHoFQCtgUcdH1KrDEWuhEju6DSH/XrHj0nRJHn/ibMTzb6APSTAoL/G
 ibcgMkmshGJMuTlOT5305F4GYhvonfWVxRZ51jhCyuGh/a9HGUJ2CaySfr5ouNpgiLVZWK/cAJy
 gCSBasgt9znPls61px9BEw7PNV2QksEg96gegLYv5TG54vCtNvhFH+sg/+qpoxkWaDNOEbO+WkD
 dnTlGo8AlX2cERRxxMRkJsrHIyybHJGt+DbDJH/6+daCoZ5+9j5cJVyXmbCb7XjKH/OmEer85jI
 fPE2zH8cVdmIwsIi7fo5+MMrP4NEQle+pphmSK+u6ap+EpgzYgE5I7QFVYF9PgU6MHNv1AT+E1U
 QFqIoPod3EfgwK3vE+PNcYLuGm401jrFM3n2a8J5CoNbi7JDOTbwStqWlm/hiEOu+xrtSP3bZwN
 VgJQicdP67Uu1mH76q86wBIlnGT/T1/4d61+XSmwTfTP777DTc8IWehqTYG6lyV8iIMTi1+/p41
 b3EmZ2NLM+OOuyAc59i+G2IST0TB/2HrDbbkjSjhH7cGvm+2UAvvwkLEwzRzYOvSucKPtrb0p59
 UF/MRrUk0vmD5gP53PP0rNfxN/dDm2yiLXWCQe1xvr+1iWC1iYKuAsjBB4tmKpESA2btg3MsYF3
 sTz3yGBliquB18mcjBqWRLmCfqt9d5HaSDA==
X-Received: by 2002:a05:600c:628c:b0:4ba:7e6:53d6 with SMTP id
 5b1f17b1804b1-4bb55ae78c1mr218033985e9.33.1794827593736; 
 Mon, 16 Nov 2026 03:13:13 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c6d079a2asm19490469f8f.16.2026.11.16.03.13.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 03:13:13 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 08/33] hw/watchdog/wdt_imx2: Set vmstate minimum_version_id to 1
Date: Mon, 16 Nov 2026 11:12:38 +0000
Message-ID: <20261116111303.1692832-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261116111303.1692832-1-peter.maydell@linaro.org>
References: <20261116111303.1692832-1-peter.maydell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

In commit d9abd0253be90 we made a non-compatible migration state
change, and set version_id to 1.  However we forgot to also set
minimum_version_id to 1, so the state struct now incorrectly claims
it can accept migrations from the old version 0 format.

Bump minimum_version_id also to 1, so that attempted migrations from
the old QEMU fail cleanly.

Fixes: d9abd0253be90280 ("hw/watchdog/wdt_imx2: Remove redundant attributes")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-id: 20261106163657.3825938-2-peter.maydell@linaro.org
---
 hw/watchdog/wdt_imx2.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/watchdog/wdt_imx2.c b/hw/watchdog/wdt_imx2.c
index f8129625e58..abb8edfae25 100644
--- a/hw/watchdog/wdt_imx2.c
+++ b/hw/watchdog/wdt_imx2.c
@@ -224,6 +224,7 @@ static const MemoryRegionOps imx2_wdt_ops = {
 static const VMStateDescription vmstate_imx2_wdt = {
     .name = "imx2.wdt",
     .version_id = 1,
+    .minimum_version_id = 1,
     .fields = (const VMStateField[]) {
         VMSTATE_PTIMER(timer, IMX2WdtState),
         VMSTATE_PTIMER(itimer, IMX2WdtState),
-- 
2.43.0


