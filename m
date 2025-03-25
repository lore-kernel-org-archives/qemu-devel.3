Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AB6BC35FFC
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 05:05:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twwQk-0007oa-3i; Tue, 25 Mar 2025 01:02:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1twwOH-0004Bq-EP
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 00:59:53 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1twwOE-00060K-IK
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 00:59:53 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2ff6cf448b8so11961506a91.3
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 21:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742878788; x=1743483588; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7C1awJz84K192Xls/S9mWSPpF8Y3H6ZCzb0fk03waGc=;
 b=cVm/wR0GrjU4GUzX/UJby62C+2nyYYvQcDkn4Fc0I8FrsMBclN9xbCVihFbEKxikzh
 3EFlB/SXvHHZ9kW7ESwT7SEJmxoR1u06nBreh1mERKbbzZ5Y2JoiF506OuS79cjT+ubN
 SYqc2jikCzOBHvWEKJovjHCUqtB8BnwJ/uTbcpivfCp9LcpmmpITZVZeo0yra6k3lJa5
 z60DpdYIqvwixdcLxcE50WDBVrj1eln5UGjt0LwkmpSBnFMCl+311M3A25eFbpQpyAhW
 rzmC5Ikh1LgaUYuXguYBaGndgRVbV7MhUR4bKeGXiKTl0jcN1xHBJEeoRv7UNJevsRKH
 CfqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742878788; x=1743483588;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7C1awJz84K192Xls/S9mWSPpF8Y3H6ZCzb0fk03waGc=;
 b=bPQWgQWL9dRlGNo9Zl2e6zFzmS7Xia51tZ/UqOgpCMZiqfna0bvNfiymn7cNIknMdh
 yUKazwb574SNYMZKHP39O7oFUtTnQi9V7y0hLp+m2Rb67gLG4CxXxMRA2SsCLvpI+z2S
 mHeP0AuyS3NyDFRitne9/H2o56UdKwwAaQDXKPmksgYlBjg7vQ/Hl7i66IlA4GzXtTox
 GhgbitRLXkhQ3jgomJX+d3bhoHSN/kMmsbcB4Igd/PWAF8GpPvPVCWfc9jCuVRvjNXiH
 0eta7sWLpDeTxFPcjkuaX6wbC0HIeQWXPcBG/Gt3tA3Fzlerr9wCqU++84oR67Fg3pw6
 5cZA==
X-Gm-Message-State: AOJu0YzYAqJ1NsDV2cvbcixSpnWdBCU7iGR8D75xNMPO/22iaI6pDBBM
 JnMEOQb2Q5+JD9x3zsbqMoeKiPk6LcM9ND1y3OQbs17NkpRH2+P3faqTVKe99EGNID16Uk/FKna
 G
X-Gm-Gg: ASbGncsUF7Ac/cYGNSBBhltly4dbWdu7eRCEnjdyaDARVMo/uKtXnZ4NiezemnFou1B
 zBVlcwG+oq6yIy2wVL1RoesMPLa9vg4ypKF++79NwJ31GWBN3iOLTEiPJhd1g/TK469sNhJZjD2
 YtHVUJC+q3TB05+o1eLPc0L+ons5SDgwaIY72FcS0NwlDkQJ/u5Cd1FNAa5QJByruilCgpxwBxB
 SVozKN/8hf+mSRIex4XUuijtHbghM5jlX0DeXP5RZgB7u+vHCBY2YKWWb5R9p9XkT4w+TRZsaGr
 F4TBv/JtO/StxRisO9wQYF4IT3RdB59bEHAWH4KtnLsK
X-Google-Smtp-Source: AGHT+IHSXNPp3Q2e8oDSf/SNPDReLESf+MJRHhmLcAh+DyIr5z05CoANzbsKkecUcyVNZ39qvJN20w==
X-Received: by 2002:a17:90b:2cc6:b0:2fe:a79e:f56f with SMTP id
 98e67ed59e1d1-3030fe9e9c3mr24748768a91.13.1742878788216; 
 Mon, 24 Mar 2025 21:59:48 -0700 (PDT)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-301bf58b413sm14595120a91.13.2025.03.24.21.59.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Mar 2025 21:59:47 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 28/29] hw/arm/xlnx-versal: prepare compilation unit to be
 common
Date: Mon, 24 Mar 2025 21:59:13 -0700
Message-Id: <20250325045915.994760-29-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250325045915.994760-1-pierrick.bouvier@linaro.org>
References: <20250325045915.994760-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102f.google.com
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

Remove kvm unused headers.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 hw/arm/xlnx-versal.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
index 278545a3f7b..f0b383b29ee 100644
--- a/hw/arm/xlnx-versal.c
+++ b/hw/arm/xlnx-versal.c
@@ -17,9 +17,7 @@
 #include "hw/sysbus.h"
 #include "net/net.h"
 #include "system/system.h"
-#include "system/kvm.h"
 #include "hw/arm/boot.h"
-#include "kvm_arm.h"
 #include "hw/misc/unimp.h"
 #include "hw/arm/xlnx-versal.h"
 #include "qemu/log.h"
-- 
2.39.5


