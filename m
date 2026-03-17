Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D7BFFEDA1B
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 19:44:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2aJh-0007U3-Jr; Tue, 17 Mar 2026 15:43:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w2aJb-0007PI-RF
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 15:42:56 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w2aJX-0007Fx-Pu
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 15:42:55 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-35a288a2c00so2124080a91.2
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 12:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773776570; x=1774381370; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D7SBLNkZfE70Q4c4n8fHx6puQVux00Zu8cChd4QK9u4=;
 b=Yy2rrqs7bVERQq7xEWkdksQ8pr4XbIMTtqP3Pog9y771goCKS2jtwaBEStRAK3pKAT
 flQO6/gzAeMiOxb0Qh5ijrAesiX2wLHpXZC1Plu8ID029VzHOKDh7Hmd2zdD72jpOHIA
 ORJlk8Sf9ZolUKR9Ss/bSJYyEe5wgsfSzFa2b+mx3PhoRZfqa/3wxdu+XsPK/AKs3+rF
 NCAt255siBBTvV/8BfSkrA3yUmJihkX1qkQxEfe3oX3PyvsYGuklUoQDRRAdOV7FeLhw
 3Jzq/qDPhy35JXQ2LrDqmgy2mWtC6CExUa/gQEksUZ9UueHLU+wOx/xjXefLFE8xTtLw
 PXSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773776570; x=1774381370;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=D7SBLNkZfE70Q4c4n8fHx6puQVux00Zu8cChd4QK9u4=;
 b=mD01IfZvEX6Cq9oGAr8rlIYYSJ8GJONOfWZOzi0+b4jZF2lV+msLGkoqpoMp2dATFV
 R0MPYx+26B7FElutjejYRWHv4LM0eU2SVDkKWHMw1tjg6wN1eCC+piB9g1HLvHrfavNA
 +gx3+2XUM8ahccoME0Rj+H4GX7SL7LOdo6Q3fE8rB3Gj3ezZ3sxOoCKshsSWmmnh7meH
 E3vlZveuqAAHREImKG1jFkLikxTI/h6JuCDkNEEE/oyQau69xhuOlVcE5YTSM+e4mVhn
 NbeyfRg3SII1r3EmlvSncHc6eot/KS90sbt/aDJdXG+vTub9Uvl6FCNkoVOjr+4tmRrn
 ZXJw==
X-Gm-Message-State: AOJu0Yw1ab6HGOmJdUnl+ZU32q4DvDA7E3eF878jXHrgfLGdgYhTXu28
 nszu8HJajZDBH4chOsRX61jZerOAYXyziF2gKLHGAVO8KUuVC00uvY7tdSIhJQVqFNkSltmZlzm
 75Xxfodw=
X-Gm-Gg: ATEYQzy8iEE/Rc3J8JKqbnzOjN+ULRg7aslxrmlFBG2ZnDvayR8zuIiXe3L9VmV+ns1
 AUTJn3NVsnDDOmBLjKYG9k7yS+8hAt0ukyAvq2z2miBze62E71LtQ3TvA6zMejGsRd4UH2ceGM9
 s2MBoeXjwsEkG33gmjVqCgEQD5ZVt1T/8YtxRfHXaK2rw/zmHfurrZAwyp08k6HSG7TAnLg7HOE
 RNFVNdZ99limtfTTOLMZqtqllMjkFkUD9Tg6BngzhCxXHbd35i67ESd4Y2GW7TkKBXi/EaLELvS
 Uoln64w7YKZYKLGBhkm16P144T8xWm7MQdhFsrxyKx4xXoabQcVmYPvIlrHM8LVq3wYMTudPKRZ
 RPMy7OWzNiZYtqD6niXuYWJjBRvUlLbJPYI02tIWDtYW4b+Dhhb93y3aIAW937yAX7J4871ta5h
 ZN5LFWg0gZoSyYSekKMtf9zWtFrCVCtapLse3CQc3iYdVdpLIOJ+i2SHU7rV3eLhiZ+j0HRwc4p
 aMj35Mnoafp8yE=
X-Received: by 2002:a17:90a:e708:b0:35b:a44f:b8a with SMTP id
 98e67ed59e1d1-35bb9e8cfb9mr530941a91.6.1773776570122; 
 Tue, 17 Mar 2026 12:42:50 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35bba5b8606sm239907a91.14.2026.03.17.12.42.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 12:42:49 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, eric.auger@redhat.com,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, philmd@linaro.org
Subject: [PATCH v4 6/8] hw/vfio/ap.c: use full path for target specific header
Date: Tue, 17 Mar 2026 12:42:39 -0700
Message-ID: <20260317194241.869568-7-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260317194241.869568-1-pierrick.bouvier@linaro.org>
References: <20260317194241.869568-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1033.google.com
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

In addition, we fix target/s390x/kvm/kvm_s390x.h cpu-qom include also.

Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/s390x/kvm/kvm_s390x.h | 2 +-
 hw/vfio/ap.c                 | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/s390x/kvm/kvm_s390x.h b/target/s390x/kvm/kvm_s390x.h
index 649dae5948a..7b1cce3e60d 100644
--- a/target/s390x/kvm/kvm_s390x.h
+++ b/target/s390x/kvm/kvm_s390x.h
@@ -10,7 +10,7 @@
 #ifndef KVM_S390X_H
 #define KVM_S390X_H
 
-#include "cpu-qom.h"
+#include "target/s390x/cpu-qom.h"
 
 struct kvm_s390_irq;
 
diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
index 856fa2678cd..3fae9ae9814 100644
--- a/hw/vfio/ap.c
+++ b/hw/vfio/ap.c
@@ -25,7 +25,7 @@
 #include "qemu/module.h"
 #include "qemu/option.h"
 #include "qemu/config-file.h"
-#include "kvm/kvm_s390x.h"
+#include "target/s390x/kvm/kvm_s390x.h"
 #include "migration/vmstate.h"
 #include "hw/core/qdev-properties.h"
 #include "hw/s390x/ap-bridge.h"
-- 
2.47.3


