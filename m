Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FEC5FCB608
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 15:00:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyWek-0003sp-0c; Fri, 06 Mar 2026 09:59:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyWei-0003pv-FE
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 09:59:56 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyWeg-0002K4-TZ
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 09:59:56 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4836d4c26d3so73890645e9.2
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2026 06:59:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772809193; x=1773413993; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=PetfWaAVLrOraWUWdnGH3elFRocTA7E9gKRkC93rjbc=;
 b=OFt8I+z3wNyb0t60iB+c5xTqdH4nBScE8s3JvR8Fy7Lx8NfgySvAr+zd5IJrVy8OpQ
 qORdwMDIprmpaOPt3BM/g9BzZ9kWQnOIVaFegJWqEbfnUNKlDyWdwqvU6JDpAY/JPI97
 WveVP8KG/JuJxjYBMhdBReNqSrRPCA+8BiVgcJb6pF14at2RqbNfLz0EW6UDeTTEl6/n
 /ZbYABe0OsjVTxaSNRirpCc93hCXh92SyR68R8MYQQyDM1v0H6+w72uCUBt9B3yWUM3j
 re0ya3UzPWO9Ff1KRV6BNkQ3OjC9S0X6KjmMUl2YuaYgrDhzEzuuJdoKqsQBrU2UoWD9
 daww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772809193; x=1773413993;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=PetfWaAVLrOraWUWdnGH3elFRocTA7E9gKRkC93rjbc=;
 b=fBXr89/cURNymRaEfOgo8KYEMW3U8SyeiVL8OT7FCoMrr0K4G0YGPb76ckWh2CzZrd
 v90a9vuYh+cIcxvD4oJSuIPydbMMIELRJ/0NAwUmrzCIkfwfpLwuMZxDqpV2vm0WH4Am
 8DjsejcFw3jKxApD+1nkf87T/J9gw3ZVVyvKv0d1uaO+pG6avmNgedqtlJhpfegK81hW
 xK664qO9SN9yTB+YiJSx2wilVFJlrMW10OO2KtaBv6LgjPYJpUydnMsqSVRxRTljzTWa
 oB5gtfhiQKthVr6RlxIs8g1e+FtzQ+llcXLByIkbqQUukKkFor4Lam81tv/j0OOu64I1
 TVyg==
X-Gm-Message-State: AOJu0Yydr2UALgvxBDcMtHhsIXzTwwzLLC2lNSi1jQXGC21WbibWB3vL
 SXcSxJcAzJh/uLbeO+2ZM2+VMJmKxp0z1AeeEOHzHJPqTZXuToGsSfdV3Ffab8KDua0m0WECFzE
 ThPd7
X-Gm-Gg: ATEYQzyej+P0nyXjorOjC5r8j2PJEvz5mWSDBcUaCWSPsUzA5dSupuFYcvWEEi2PKj/
 xyiIYORYc+LGtrn4cHkLQW69YKuGJrDuh6Q5zaQeiVHH7XVY3Jda4OEUs4uqLE/+YNlLg02woAb
 owgwLcTACKbxp/lLdcEihUZ7ZkEcgXD7acmsMMfNSGU33kOIi/QRM99j/K0aVS4+QOOzJY8rOiq
 2xSeQXQkT9VxISWwPL8/H51DeFwpE6O34MjXZtIQagImF3i93LmoI1VtHCVCHBfeMsyQaL+4s8L
 okaPqnGOyZhXv9yBzsklE0rDGelfRBxxwZW1j0btOGa7U5NdeUMNS9dUQCULDcm1IeQHGp1CV4H
 xVWKIv2P6i9KmNngIAo6De7fJhj7uyBJdXdYk2/f0TJTSmyVUN3cAcVbPewDCBul1z9ij1AMYxD
 7p2g891G1i6wnipOIlA7hrblzScMkX8Qr27BIzh3gslylWnOc11pP7kfUcH/LgA+kVt1RL79qxk
 s0PWPafmNiftLh+TKbnUYlQV6Th4bM=
X-Received: by 2002:a05:600c:8b58:b0:477:a54a:acba with SMTP id
 5b1f17b1804b1-4852695af23mr42278935e9.17.1772809193326; 
 Fri, 06 Mar 2026 06:59:53 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-485246ece8bsm28681845e9.4.2026.03.06.06.59.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 06:59:52 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 13/49] MAINTAINERS: fix magnuskulke email-address
Date: Fri,  6 Mar 2026 14:59:03 +0000
Message-ID: <20260306145939.2162189-14-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306145939.2162189-1-peter.maydell@linaro.org>
References: <20260306145939.2162189-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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

From: Magnus Kulke <magnuskulke@linux.microsoft.com>

Consolidating email aliases.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4e428dca49..856181c375 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -586,7 +586,7 @@ F: include/system/whpx-common.h
 F: include/system/whpx-internal.h
 
 MSHV
-M: Magnus Kulke <magnus.kulke@linux.microsoft.com>
+M: Magnus Kulke <magnuskulke@linux.microsoft.com>
 R: Wei Liu <wei.liu@kernel.org>
 S: Supported
 F: accel/mshv/
@@ -601,7 +601,7 @@ F: accel/nitro/
 F: include/system/nitro-accel.h
 
 X86 MSHV CPUs
-M: Magnus Kulke <magnus.kulke@linux.microsoft.com>
+M: Magnus Kulke <magnuskulke@linux.microsoft.com>
 R: Wei Liu <wei.liu@kernel.org>
 S: Supported
 F: target/i386/mshv/
-- 
2.43.0


