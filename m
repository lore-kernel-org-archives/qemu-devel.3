Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6362EC54E4A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 15:53:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ricUK-0007L0-H1; Fri, 08 Mar 2024 10:50:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ricUI-00079q-35
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 10:50:22 -0500
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ricUF-0004GV-Jn
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 10:50:21 -0500
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-512f54fc2dbso2061716e87.1
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 07:50:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709913018; x=1710517818; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ZyiPy5xXJ/X9HqSi2OgP9Ewz4kgyfIfLY+4hqUdEidI=;
 b=Z1op39Wz6tWsy7PND3kxeTOVG8Mms8V9S/yDVNGbNbMwCco+VwOT+RAf1x1htgKLSa
 Ayde+R1ySjnnZqaBVKs0w1OMw+aOuBW8MIrtUy2bt2hKP52CTTf1llCb1EU5QCDq+Jcs
 B/5uXVJepBUayKp+2r1fsQx80aa0Wdh8gCq0ZxjElF26Fk4znU8sWehegpiR2zVPb3oP
 A3Tuqsqs5HDhhx1uyegcAwsYfa0WgjSr58HD5AREQJ+cZpFf4vv8e4hxPMq5QUiz4nB9
 WCpA/vUItB0J/n+myDcbTfWVO81VYDYA4HkUnJANhvm+mto7soHV3JQcqYveJWItz+Ia
 Y3Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709913018; x=1710517818;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZyiPy5xXJ/X9HqSi2OgP9Ewz4kgyfIfLY+4hqUdEidI=;
 b=ZZo+3BOhO/97tNtpe34K+fXrRn3Pk5V7SJg2vH/sj8WbO2Tt7uCsQ0guzKcl7JWoLX
 MLfwID39YFc+ja4eU3m7ApTlol27n0SLgVQxGTk25vOXxmjWx8rIpddtOIOAN+6MmVqy
 xDXMWfbFhjymlKiZSMam1S5fo2cuRU+h/Ur1dkglGKWptdvvBjI5lG6JqonJoEkKKgKl
 b7X5t/0IPMxZTIvFmHRqId8/q4kshKFc3nnESJ/5F4V59IpVrtJ54XGXy0jVbiZZR/de
 Ub4eOnMYnTRiMa6Ik41wr91RleFWS1dg0nXFTk8q/gHE2+gsAWDArrYzJ0gERdz4DP5U
 EN/A==
X-Gm-Message-State: AOJu0YzpqtSdahUgfAbMpxOhSuq22nsuFLnFubwsiSrVP4sQz3ikjhjd
 0jbHx6ogfbQxL2yN8bckSdC9cgbtbXPhMfwVV4xthRfgLHGzqucBEjmHDtkqysnP9MNAW+byqtB
 L
X-Google-Smtp-Source: AGHT+IF1dMWes94BUnn2CbgmcQZHL52j20gP8oMqEvF/lX4zUe1GEzPVq957t4CU/LHLpjqy/VKklw==
X-Received: by 2002:ac2:5b44:0:b0:513:3e22:6e01 with SMTP id
 i4-20020ac25b44000000b005133e226e01mr3393952lfp.16.1709913017639; 
 Fri, 08 Mar 2024 07:50:17 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 f2-20020adff8c2000000b0033e7a204dc7sm856080wrq.32.2024.03.08.07.50.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Mar 2024 07:50:17 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/14] target/arm: Timer _EL02 registers UNDEF for E2H == 0
Date: Fri,  8 Mar 2024 15:50:03 +0000
Message-Id: <20240308155015.3637663-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240308155015.3637663-1-peter.maydell@linaro.org>
References: <20240308155015.3637663-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x129.google.com
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

The timer _EL02 registers should UNDEF for invalid accesses from EL2
or EL3 when HCR_EL2.E2H == 0, not take a cp access trap.  We were
delivering the exception to EL2 with the wrong syndrome.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20240301183219.2424889-3-peter.maydell@linaro.org
---
 target/arm/helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 90c4fb72ce4..978df6f2823 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6551,7 +6551,7 @@ static CPAccessResult e2h_access(CPUARMState *env, const ARMCPRegInfo *ri,
         return CP_ACCESS_OK;
     }
     if (!(arm_hcr_el2_eff(env) & HCR_E2H)) {
-        return CP_ACCESS_TRAP;
+        return CP_ACCESS_TRAP_UNCATEGORIZED;
     }
     return CP_ACCESS_OK;
 }
-- 
2.34.1


