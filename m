Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCBE8CEFCE3
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Jan 2026 23:54:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdGsE-0003RK-NK; Tue, 06 Jan 2026 18:54:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vdGsC-0003R2-Sf
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 18:54:00 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vdGsB-00043K-E1
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 18:54:00 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-42e2e77f519so915626f8f.2
 for <qemu-devel@nongnu.org>; Tue, 06 Jan 2026 15:53:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767743638; x=1768348438; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q/eN9Ritycd+ay5bl3VusSVzcL2B0EKh+JMcpk0P4xY=;
 b=DudmS5xFHPY4x37g9heL0XavoxH2+XudfMd8rafkSpO1lwFPXgljRniRrZBIyTf89n
 UlRZJ8Lg8DLw57DD6Umw1I6MooQ+r7l7p1KusscRtt9yq5oZEH5uk3yBwiOt9H4CyHU2
 /yEhFvMwC7TnP/MsKycBmEUWabt/KcaRIA7gprDtpMQzNVj0r19MG7JM4ZWdtWNKRFJS
 CyiW1C3f7+rKP2QDRa30rzy/1GHeCRO8rbKp+tycWU7vc43yEsYCX7ryHf4sddfqhhFY
 U6IW6J/+KJJNMmOlv6HpI/FWLBEeMNlHH/20RiLW/1vTcik6bE/kkF4f3as1Xygu7/e1
 Vmrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767743638; x=1768348438;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=q/eN9Ritycd+ay5bl3VusSVzcL2B0EKh+JMcpk0P4xY=;
 b=hEd0K779qialglEm6LxxVXSNRUZRgFde6IHwY64FbR9wruqlBmRaJvOjBVUyOR8DKf
 PBkkCT5fxltG6yTLcJmsxpE+vH+vn4qRpiQ/5POzEz0C1HMGT90gEAGkWUCY6s49cRdR
 rS4VYSlsLvxsqDUgWrKRs/+Fqh1ypwwdfZHwf3kXJ8gfmCupL0vxV212U92FwTxZzVgP
 BiXmbE9HzoPdUkEmTGXrL55A32zcr+TOCv2u3VLdl/X4XP+vYpAEAmZ0zPp0W15jMfWd
 r7MJQTPy8ZE+aZOcQx9hUpAEGbJH0lbMK7eqD01n9aGIibbB854J2K1jAh72mlwxsCRB
 vS6Q==
X-Gm-Message-State: AOJu0YwJXd6eb7erNr1r3d8aiBige0EFk85fR8/Ei9XmwsW0Tm3+H9R7
 jkHQDSwFVeLYhcF5wuKtDE/tOVL6bnfguYMrrnx4OASrF6qMy91V4YWT2ZDk2LURGi9YQCK26np
 sjsezY6c=
X-Gm-Gg: AY/fxX45xhqKR/d723eEITZOh4II7r6Zfi62xi2LGqajxhBMZuUdmu3eUO1Zxm1blJG
 4WeUZgyRDtMHoE8tQpvsdVE+Gi5josIrK/K4Dgf10GHN1Eq4gqyz9suAIt24DnaEMbaX5MgI/kh
 h1QD+q+OVgQeDdqbfqpgPCxN9dJPWDGgFD0EOTc5710kjTT1pPMx80HsKguJmygogQuvF202t38
 90BysUfIIcz17Bjj/MHoWMlBoPTxFZR5LrR1qpN4iP9LsmB7cEHrIlulmXzthdLSllBDJDHx4tg
 +TVuzT08cwjrfPQ063pxSDQ+5FZo4k0a/kSdyXg1MJ/HwZtGmv1WElRw1KjdcJCy6ihe79MSuND
 ljWT34VkuR4GgEwGQFAC8nYDPoVFx34eBHJBP9yOi7IUKmkdpUsmPzKzuZMk/iRlEeeUk5oK2Fu
 iCE0/L5gdu/cdxorHXRPQwCOtEy/KRCllz5/lDDF5fdLaBcEULlyD/0pobF+gC
X-Google-Smtp-Source: AGHT+IHK9zK7S2o46/V0+W8u15eQ1VgM8FvB2GRdk3BA6ANjEwI3rK1Hi6owIJewgIHENheAKB2cCg==
X-Received: by 2002:adf:fe8f:0:b0:430:f97a:6f43 with SMTP id
 ffacd0b85a97d-432c379f3c9mr662935f8f.53.1767743637660; 
 Tue, 06 Jan 2026 15:53:57 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd0e16ffsm7348054f8f.12.2026.01.06.15.53.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 06 Jan 2026 15:53:57 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 3/6] target/microblaze: Avoid target-specific migration
 headers in machine.c
Date: Wed,  7 Jan 2026 00:53:29 +0100
Message-ID: <20260106235333.22752-4-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260106235333.22752-1-philmd@linaro.org>
References: <20260106235333.22752-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

machine.c doesn't use any target-specific macro defined by
the "migration/cpu.h" header. Use the minimum header requiered:
"migration/qemu-file-types.h" and "migration/vmstate.h", which
are not target-specific.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/microblaze/machine.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/microblaze/machine.c b/target/microblaze/machine.c
index 48efa546d39..f930ff86091 100644
--- a/target/microblaze/machine.c
+++ b/target/microblaze/machine.c
@@ -19,7 +19,8 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "migration/cpu.h"
+#include "migration/qemu-file-types.h"
+#include "migration/vmstate.h"
 
 
 static const VMStateField vmstate_mmu_fields[] = {
-- 
2.52.0


