Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0AD606A320
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 17:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Sl1YfHVP
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xU5if-0007XY-M3; Thu, 19 Nov 2026 12:14:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xU5iX-0007Ws-9Q
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 12:14:40 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xU5iP-0001NJ-ET
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 12:14:34 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4a2153c8525so19086705e9.3
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 09:14:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795108467; x=1795713267; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=lpvWYMwp0TsV4MHcEs4e2IgMJEKTJw3Kk55W69mntzo=;
 b=Sl1YfHVPRiJF+6ruMSm5j39C++Km8+6RdzZONEKEkbrEBzzaTI5l95O95PtF8neSOY
 jbGtFep7M/X+18wDV+cLcq8xJaNKSDtSrNXxvgRVPJrjjwor/IBmz6Y7/9zgTWwLdMNH
 TZbsU6Hjub4CMdklFEZkkelAtCkLZW2bEfFCeDdCKt5B3mPWvtzr+OhHLrzAFWBn1pPl
 NfYkkydswVL+4LksCSX+v70VxmTLFQWJz0datkv9S0UB9ZcRZrXShSvvlX+IhRcrgOPN
 71N2S9k45fiBmrxB1sivUaMo1Bc4BgG5ffvewwU5pLgDmx2mjk1SmAeOA2yyLG6tY2/6
 rcRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795108467; x=1795713267;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lpvWYMwp0TsV4MHcEs4e2IgMJEKTJw3Kk55W69mntzo=;
 b=faldWKMyzlsd0adriwvv8C0Q3a6hSZLPzpMChJP0KLDuh71AR7o5+EoDanbS6W+pUb
 s39qx/5wBdI8pissu0xUJW6OqFqVPP1gxK38IopGaoquXuvXYh+D0wkUbXkfj2LyIeiI
 lQdYdzCR2jlJ6qgVtB1+ku3UpqbNU929K0UIerWpzwEyNOzyfxxYLjh8KpGInXhyDM/h
 qcFuSbwlpqZ6x3Zjz903HhU9o0rW/ArVDJRj2tLiCUP7Z2qjNWth7jXXCqD++0kBE1iL
 /FhBZhy6amGgzK5tU3ha0VcLvf57tEvOBcTDkobeyQYTLb3q6cg0SidUVrQ/ckXj1jsg
 PxiQ==
X-Forwarded-Encrypted: i=1;
 AL+hErFiLp86Z4uGZ9cQskQjXhjyWKXKhRuQwO/IDDBjpv60tYSOPAZ5Qicou6+ti6pASe4/+6tgjuUWEvv/@nongnu.org
X-Gm-Message-State: APuU4Z+GVkgpW5q5VeFDQbDem3kISuUXT7qIRxfXPAtFqcuiH852OdE3
 SJnWAbS7Yav4rZVALX4l6d4ccT4AHw4iLvJJgaDUs7fYELw9Td4iAdVPQ2MWxM3jkIY=
X-Gm-Gg: AYBFou0L9EeQY5UV1HuhohHsAG2rk6yXHjP6czrgSHdKwup4ApoyRghbyQX0HfpQRf6
 HMaoS7+cGp1Nz+EDRIJzcni/YjEPh22dpZUhry13/K/WUfp83Cvec6B0hbUkILxFGVCOT5l+V/S
 mqN/eMgqAh6bAiLrzFLcMMOxBCzwGwkDojIiUXckMijI1frCV5NxpwqvYf2/WLXixi3zMfdNJ70
 H0VxdXFBw+fTcsWpqgkuBJLFVKg+DUW3FtjL7kARXmG/k0qzG/U6h1BwZsgRFiVpMM+W9VAXusC
 J69ipcfpnzmWBhbzk5XcEQmErERUaqdbnNSbnSkbQOv/h8frjtqpOep2oZ2q80Ypib/9X9l9AcW
 JCbSgcs4UNiz9ppdkJCxR2yMBVgJeFfU/ql+bYAZ2p/Wzv9bKyYxUI7U8WSp0oAKGzMK77Moz1e
 VqH/bFCMx1TNO66vhnNAldrNnmSoKDCGg5CCcrcs4A62u78VVehuEaJT1D/U3DWNNS09f9nFdNw
 skk6GcEyVShPhYYI9XRmud2TXhkFdyGlEI//pmHRReLIcDkDQM4rLDMnVsgYaO8hkHRwOWqgrMK
 xAns7ofDejyZX4xlHUW6fnUtJdC17LMedzN+BN31+Iop7/I87prAuP4/7+Kbo0SMqIH86t/9T2l
 B61N9przYY2d4tg6nc4qG3NBMCSbTFg9NzA==
X-Received: by 2002:a05:600c:6218:b0:4a0:1b14:e283 with SMTP id
 5b1f17b1804b1-4bb887c341dmr5093475e9.1.1795108466904; 
 Thu, 19 Nov 2026 09:14:26 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb884ab091sm15717655e9.11.2026.11.19.09.14.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 09:14:26 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>
Subject: [PATCH for-11.2] hw/ssi/aspeed_smc: Correct minimum_version_id in
 vmstate
Date: Thu, 19 Nov 2026 17:14:25 +0000
Message-ID: <20261119171425.3186790-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
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

In commit 29139270d8ad70f2 we made an incompatible change to the
migration state for the aspeed_smc device, and bumped the version_id
and minimum_version_id: this is because we increased ASPEED_SMC_R_MAX
and so the regs array is bigger.

However, the old vmstate was handling migration from a range of
vmstate versions, with version_id = 3 and minimum_version_id = 1.
The change to ASPEED_SMC_R_MAX is (intentionally) not compatible with
any of those older versions, and so it should have moved
minimum_version_id up to 4 (matching the new version_id), not merely
increment it.

The effect of this is that trying a migration save on v11.1.3 and
then a load on the current head of git fails in a confusing way
("Missing section footer for aspeed.smc") rather than clearly ("error
while loading state for instance 0x0 of device 'aspeed.smc':
aspeed.smc: incoming version_id 3 is too old for local minimum
version_id 5").

Since we now don't need to try to handle migration from versions 2
and 3 at all, we can drop the complications in the vmstate struct (an
unused field, and field only present in version 3 and up). Clean
these up and set the version_id and minimum_version_id to 5
accordingly.

Fixes: 29139270d8ad70f2 ("hw/ssi/aspeed_smc: Add Data FIFO-based flash access support for AST2700")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4880
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/ssi/aspeed_smc.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c
index ec9ad0f747e..f82947e752e 100644
--- a/hw/ssi/aspeed_smc.c
+++ b/hw/ssi/aspeed_smc.c
@@ -1218,12 +1218,11 @@ static void aspeed_smc_realize(DeviceState *dev, Error **errp)
 
 static const VMStateDescription vmstate_aspeed_smc = {
     .name = "aspeed.smc",
-    .version_id = 4,
-    .minimum_version_id = 2,
+    .version_id = 5,
+    .minimum_version_id = 5,
     .fields = (const VMStateField[]) {
         VMSTATE_UINT32_ARRAY(regs, AspeedSMCState, ASPEED_SMC_R_MAX),
-        VMSTATE_UNUSED_V(2, 2), /* was snoop_index/snoop_dummies */
-        VMSTATE_BOOL_V(unselect, AspeedSMCState, 3),
+        VMSTATE_BOOL(unselect, AspeedSMCState),
         VMSTATE_END_OF_LIST()
     }
 };
-- 
2.43.0


