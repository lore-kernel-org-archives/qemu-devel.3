Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 787BBC28B23
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 19:11:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqd5O-0002Sh-1m; Fri, 07 Mar 2025 14:10:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tqd5L-0002RP-QT
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 14:10:15 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tqd5J-0005sw-TI
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 14:10:15 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-224341bbc1dso14051625ad.3
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 11:10:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741374612; x=1741979412; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UGch4Y0Ix8wHfMNh+EmB6vJG8JHgkY01LTyS9A7oXr0=;
 b=rhxR7tKpR2+NcVwaeu8WxL28PGcN+f8aahT2BytdDWyW/ohzG4WE4dBvyMeskP73cL
 47zvNihPmIEsfKFMQxipiIuAx0R5K38XEPPTvxRQ7V0Xk+FJ3ew8+uOwLcrkXP3e818p
 Utv1n8YJtdyHMc0bTrABMhsEDjG3mwyV/K3iFhLlQwHYtQQjUwFahzqkM9mlnn2cnTea
 CREfqVayGgy7yW/JcwuLfX2Ux+SBRKf8l93A8gBiuRY9NFOKrbltNLFJL0IL8L8Zgx6U
 EFWs4+0Vx/eh15/QFWdg5HMhB25QQr+8MzuyX00VebgQCxwnYzBg8iN2D8VoI5KdMyBl
 PN9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741374612; x=1741979412;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UGch4Y0Ix8wHfMNh+EmB6vJG8JHgkY01LTyS9A7oXr0=;
 b=E8dHDYenu30o0oD/DqlLinX8Gf9uiuE+4WOm00AdBOk0n+sk/P3Ec+KbLXbLAjLEgm
 0BNrpFSSk0D1NAKJjz1KLkV7YAl/EtHlqH7jVPdVyG0aM1w99fpMhlpV+fOATLwLGADf
 /y1jpe6pH8JSwGOvqnpWmdPWIv5BtKJ+mvP88GvNFGKUxQ63ui2pbw4Wr9VKRU9WX/H4
 efg4XVY2b9qe2jlyZtULAIStNkW4tYvUJbo+2o6RNOpxPReHNUiox54QipxDJAMQHSsn
 BKCzRG0utlJ6Hyc42gWHDRSUcgok4bnLbOeCaR9rpPXJUEm+88OdCYWvFJgRTAxgLp/a
 vk/w==
X-Gm-Message-State: AOJu0YwdfM72xfxOcimV3Mc3nhCCUlW4Syls43xOilz34upM6qeA9r0O
 mFHSzC5TBTofrtrm9bilY40vy2HisQSkuKXajaHrNrWuFi/unwjs9XiuUnUxJh7DcXSbTPPKbwI
 9
X-Gm-Gg: ASbGncvnA7kW36T09SDNAXXCwdMfYDIiVc3dOe4GIO7dX/OmuBc0MTzuVctr7PiODsf
 yWoEP03DyByn20gAs0YzaDi8jqUmAuvM/A3yoUTtiesSotwoPwM3q8tR2mxwfO5FebZG/vKPtyh
 7ygILc4E4LVxXlt39eSE9KQ46GQLVDs/zP8Ks6bny8gFkti+7HuEorF7Tr8Ut8qp3YwOUH5Z6zt
 hPIHay0Ed4yOrikJMypMNYPXVzj+EebVXm4oo9GPCI1cGwZHV99krDTVLfHTpoWJ17wChgn8UQ2
 FwgzeCzIF6ZdwtSf5yQgQRo9GdPDHndH3G5onDdWWkYT
X-Google-Smtp-Source: AGHT+IHuC+PNa1SmzqJI0M4CoWasSHWXoq4grtPPWkbR5pKc5S8Z5/JOsqXNjYzvCEePHATvEPGVWw==
X-Received: by 2002:a05:6a20:a11f:b0:1f2:f1a8:fbc8 with SMTP id
 adf61e73a8af0-1f544ad7265mr8852497637.2.1741374612398; 
 Fri, 07 Mar 2025 11:10:12 -0800 (PST)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-736b2da32c6sm1449895b3a.149.2025.03.07.11.10.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Mar 2025 11:10:11 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org, "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 pierrick.bouvier@linaro.org, alex.bennee@linaro.org, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 richard.henderson@linaro.org, manos.pitsidianakis@linaro.org
Subject: [PATCH v2 2/7] hw/hyperv/hyperv.h: header cleanup
Date: Fri,  7 Mar 2025 11:09:58 -0800
Message-Id: <20250307191003.248950-3-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250307191003.248950-1-pierrick.bouvier@linaro.org>
References: <20250307191003.248950-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62f.google.com
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/hw/hyperv/hyperv.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/hw/hyperv/hyperv.h b/include/hw/hyperv/hyperv.h
index d717b4e13d4..63a8b65278f 100644
--- a/include/hw/hyperv/hyperv.h
+++ b/include/hw/hyperv/hyperv.h
@@ -10,7 +10,8 @@
 #ifndef HW_HYPERV_HYPERV_H
 #define HW_HYPERV_HYPERV_H
 
-#include "cpu-qom.h"
+#include "exec/hwaddr.h"
+#include "hw/core/cpu.h"
 #include "hw/hyperv/hyperv-proto.h"
 
 typedef struct HvSintRoute HvSintRoute;
-- 
2.39.5


