Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98F94E9A03B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 11:03:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt1nm-0003yd-Rv; Thu, 19 Feb 2026 06:02:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vt1nl-0003yP-R6
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 06:02:33 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vt1nk-0004dh-7s
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 06:02:33 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-435a11957f6so661712f8f.0
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 03:02:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771498950; x=1772103750; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=9Gy5U0HG/xNgrXivum+nhASnmAiunCrfWJbQ244sE4s=;
 b=vLCaklMa4wlU0365OhAF7i8lmjMwfx9YUmrz7qlir08zbuK2q8+9Z0tecx/cF+c1wY
 gAo18ySf/cCu4B7DohnoKwSh06ygyJbQHuqv0/fPI+Ky2P5n7DQ8ReXn6RevQGVr52oL
 pMKHSzVTSrPq2AaOef92loMwNcD3LwUlyfA/fRejrsFF+bxTeodM1pFNfz26DIGOKQBb
 VGjFZupkmwovRfuUecXPJ1BvRuHwA1lawwlfiDQXwZOCEy7qfsSTjYQ5/DFmu4akcLGc
 Bu9hvQDcb49Z06/ngWifb2cmrOfLe3jzgpamNvdsv03HbCV0u8WU882w2sINFgGg0gKv
 vD0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771498950; x=1772103750;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9Gy5U0HG/xNgrXivum+nhASnmAiunCrfWJbQ244sE4s=;
 b=l8hwG6GezJT9SkVuGOABzvn+ytihUACjv18/EXvM3YjOqicox2XTA+F+ZBEdw+Ul2V
 XYb1xVbeipcpbr8gf/VM7z2HJ0L7OBJPOJpVssgkjCJI1V4YXDv6XQLndu+jLl26hgpY
 +vRK2KGQZXzzIp+Yqd59bI10ec8xIBYJdZuiVW/sajLW9URR8QydFuwzyMIv8QCdWkat
 bTEGD7Imr/eDJBu/7dpnu+fCwqFOhDd7W6SMOJIrpgAJknnvyJfmgy1qwSdVPRV/r2ke
 zuSS6Txrnugm0s2o3wdhMhXuTGx/vQnMp53EOKcfi/caGMv+FUQPkogjWX+cS+0G5b14
 Osbg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWIULbCAOZhXmZymVuSXSZrM+n1SD5SqZaD9YGkwNXvNaWdwQrVB89JVjMn3BO6lYMBZJV8TYz8+VSU@nongnu.org
X-Gm-Message-State: AOJu0YyTUMx1V9lkTXXyEAocMhDaBnjJM3dgUgZHo/Hap6bPmVQYXejv
 zMW+jfRzEMdYO7+js3IlRcb7JuOuz5AqbM/eTdbBl/NmZKwxlz4d0Lk9oxCsCPAM6GMmbKfGNtJ
 GZm3l
X-Gm-Gg: AZuq6aIBiktAc42mbInmXXRTp7auNrHZL7k9xIF+gSD4sspAWiMj3lD1nKLoLEtYZPI
 TKkpjzCr6BvfmvPDixPaGV5n3Mhhw+Pc6imFhiSYzKJtd67LhhLYw8/KZcw931/xfVT2Sxl7xr8
 RMcLu0J19Km+1+W9AtVrBnhO0ww3SPq4x3HXEe85J1cHbToAYRV9Lp+tvEGjW9Mc9r1fKRVuMcp
 Zx3UnfqcpjMii7jzL16V+at8eN50kyB6WedEq90fDeLpiKLJEAv0htM2PU0Db2gyGxOPKsNijsP
 EYqc7aOmNZSWqyATIWocvVGTsVRMCdvZwjsCiRBPQdoSRkqzUzDYz2D56AomyTVupNTru4yg26l
 R2I49ijdpcylGoFGSnNs6cX2vE/TBgXfCHLBBG7CYzMzrl6GXLNJ+yM90bSD1nGqbt2NswnHOtz
 xsvoRRdZ3Xkk1Fic8AUwNT7dVSL744/UdDPnf3emgSeeKfoxMD7BrkqZCqJnUwrsoMCYClX7JRT
 yKi0B2nwK0da3NKQ8LNSuy8QXNsPnI=
X-Received: by 2002:a5d:5d11:0:b0:436:34c0:c9c8 with SMTP id
 ffacd0b85a97d-43797941daamr33860376f8f.60.1771498950020; 
 Thu, 19 Feb 2026 03:02:30 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796abc21dsm50997201f8f.20.2026.02.19.03.02.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Feb 2026 03:02:29 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH] hw/arm/virt: Update error message for bad gic-version option
Date: Thu, 19 Feb 2026 11:02:28 +0000
Message-ID: <20260219110228.3804482-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42b.google.com
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

As we added different valid gic-version option settings,
we forgot to update the hint in the error message produced
when the user specifies an invalid value:

$ qemu-system-aarch64 -M virt,help | grep gic-version
  gic-version=<string>   - Set GIC version. Valid values are 2, 3, 4, host and max
$ qemu-system-aarch64 -M virt,gic-version=bang
qemu-system-aarch64: Invalid gic-version value
Valid values are 3, 2, host, max.

Update the error string to match the one we use in the help text
for the option.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/virt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 50865e8115..8dc999712c 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -2971,7 +2971,7 @@ static void virt_set_gic_version(Object *obj, const char *value, Error **errp)
         vms->gic_version = VIRT_GIC_VERSION_MAX; /* Will probe later */
     } else {
         error_setg(errp, "Invalid gic-version value");
-        error_append_hint(errp, "Valid values are 3, 2, host, max.\n");
+        error_append_hint(errp, "Valid values are 2, 3, 4, host, and max.\n");
     }
 }
 
-- 
2.43.0


