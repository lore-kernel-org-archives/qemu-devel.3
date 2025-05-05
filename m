Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F15FC369DC
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 01:57:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBl1N-0005EG-V0; Sun, 04 May 2025 21:53:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBl11-000471-IW
 for qemu-devel@nongnu.org; Sun, 04 May 2025 21:53:08 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBl0y-0002fP-Qm
 for qemu-devel@nongnu.org; Sun, 04 May 2025 21:53:07 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-afc857702d1so3830384a12.3
 for <qemu-devel@nongnu.org>; Sun, 04 May 2025 18:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746409982; x=1747014782; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oONThx//EO5WSiuREF023HuwIIuJ5yNwT7cwhGAiXZE=;
 b=zuhunsr6M/6SqdJKsEQXsoXFiZ7pW7P4hxZ4cul78YEpyxLbDPUgQyUo++2HC7CU95
 938GQr7xbF7+baPmGnTbWHtGCmZdy9jDBISoU14sdzvzVlCLI85xaAwezzLWG3ZHTEuT
 4TAGeT1gWhhggUp4X4T+7dq2xkB9smYmD1HC28w5rNVaKs1aVPUxJUv6C/lB+pDv52bR
 92YIK55bPcMh/oj7XI34YqH9QF3o9fDcKvb4ny3f+6HMa0oFBPMb5gcv45CsRLurzf2K
 +aQkwFSLrGfkE/ZtyZLQyD0loxcOkyzh0+BEsdVG5mGgQ801v3tJYvc3dgcrrOlmKFoD
 xfaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746409982; x=1747014782;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oONThx//EO5WSiuREF023HuwIIuJ5yNwT7cwhGAiXZE=;
 b=mbKFqiNsZnXEXmfqUru8GfUEBkWWBnFW0Vp0qGcRBJs0iEkWMu4oEQN8i5kJMt26ee
 2IH8/ctafovbozqgPlG1Tl5SKdP03AWdHO1D8s06TwoxFPgUsKkT/t+3iPPZ0yIotHqt
 VNbaSNwwSd1tXV0m8XO4kNW7M3QI8zU/JDXotesPF2CKfUWsIkzwUAxOf25A+fQiG6aX
 PumuR8q1HvpLpf9M/ubWzdjvYLAhgJqZV/nDjo5zGWx1L4Ewedf1tcKo1W8V9kRe2iCq
 38N1Ody39kwi+scjEc9krWfHSZ+BCKbZ2HIRzK1jm5OcpB3iZqyGBKGqNqv0qvlOib8I
 tEGg==
X-Gm-Message-State: AOJu0YxM5kAfMqMrp8hk+ewKaakOZK367hgKVUGqSE4+TUJ4QRypDuJF
 e1qc7WzKAFkyuZasbhsHV+UFYMvxg+ezUEtc9eRZv8qJOKAnAjbEZvVllDpBf1kBHbJEJrxUjDa
 OzmM=
X-Gm-Gg: ASbGncsf7ZoFEcgYiIVCVYt83oysf9H7u5icarDGbxSFfoH7VJUyW16Vo84AuM3Kbru
 IoKx+7pBlZW+hO82fayS6TnZcYjyFeaJfFadOZdAC3YoGQQesQsZTDA1NFJnXorkJ88dh7nMwTk
 yvrFw3T64FSZrP5qbu2rQkaU4KQ7uIxQEdfxqPJNNR4LeDvWLQWQH8iByFQke/yGKeWT8XIv3cX
 hz75fOeb4hUJsoPD1Wr68VUZpCmvDwmBOBk4/8nGG4QFBlTwzhcxkCQRdLJxhwlFG0JBiSaih6o
 FRyoMyCZTMdLF+zJ+348gkXz2fdLKq3sNOSGejVH
X-Google-Smtp-Source: AGHT+IHr0qzcLKdRFzKhMCewLOWMtdB62i1QsUpnVafjImETUYvckCkVS/LSQ7CJAssIR78evsGItQ==
X-Received: by 2002:a05:6a20:3950:b0:1f5:8b9b:ab54 with SMTP id
 adf61e73a8af0-20e06823c71mr10780816637.23.1746409981839; 
 Sun, 04 May 2025 18:53:01 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b1fb3920074sm4462101a12.11.2025.05.04.18.53.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 May 2025 18:53:01 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 richard.henderson@linaro.org, alex.bennee@linaro.org, kvm@vger.kernel.org,
 Peter Maydell <peter.maydell@linaro.org>, anjo@rev.ng,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v5 36/48] target/arm/machine: reduce migration include to
 avoid target specific definitions
Date: Sun,  4 May 2025 18:52:11 -0700
Message-ID: <20250505015223.3895275-37-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250505015223.3895275-1-pierrick.bouvier@linaro.org>
References: <20250505015223.3895275-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x531.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/machine.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/arm/machine.c b/target/arm/machine.c
index 978249fb71b..f7956898fa1 100644
--- a/target/arm/machine.c
+++ b/target/arm/machine.c
@@ -6,7 +6,8 @@
 #include "kvm_arm.h"
 #include "internals.h"
 #include "cpu-features.h"
-#include "migration/cpu.h"
+#include "migration/qemu-file-types.h"
+#include "migration/vmstate.h"
 #include "target/arm/gtimer.h"
 
 static bool vfp_needed(void *opaque)
-- 
2.47.2


