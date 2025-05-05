Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1E94C3ABAC
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 01:58:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBl1O-0005Md-R8; Sun, 04 May 2025 21:53:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBl0o-0003wu-Qz
 for qemu-devel@nongnu.org; Sun, 04 May 2025 21:52:58 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBl0i-0002Yf-EK
 for qemu-devel@nongnu.org; Sun, 04 May 2025 21:52:54 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-7376dd56eccso4378410b3a.0
 for <qemu-devel@nongnu.org>; Sun, 04 May 2025 18:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746409967; x=1747014767; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oU3hP1IM611C1WkYpOLE6kbCej9Cg8bXJlI25SZwxm4=;
 b=xXEJwTvGO1U6ya4J/S/55LFRHM32NnfZQERytoOgo35Wv3EKhp9GAxla/FenuBIkK5
 wxh8qEYYYcGif1g3r09yWT3e1OzsBkM1Zqf9GKJ61bSPG7GaDr4jky/OevgheAKcx9fP
 ozr3Akqm7dgbhfF2fhVH/GkH3jL+c1ELOotkI1gopl194YVPy52cwCSHwmKNutIB/6ns
 ONSwUSRb2CWsTdW6M7Z9S5uwxp8M4pgb9AN92jphib6yp+/H5rHFXoY71jpH2egYBp6n
 VgWnWovPldTSwj2pXLC4K4ocbdMEzdbtw00VhrIUnVAxNXv2raIwUul4qJhpfw/wQPj/
 2M9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746409967; x=1747014767;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oU3hP1IM611C1WkYpOLE6kbCej9Cg8bXJlI25SZwxm4=;
 b=ko4AI/hHQD9/SA8eo0euo7/JudM7tq4kKZMGyWvO0V3urtNusH6Lwha3OMXO9/hMxI
 ZQZl9fDHF3jDKR/Vui4q2xPkPnFxaSci6ibRpOcqMoo+7lYOKk1NJ26S15VP0BdyPNGl
 F/dVyuZthkhZzdxj7cUBFH6lCrhcu8njv8xY6MIoHJkgoYz+n0slFOILsYTKBl22hZaX
 7OCza7Lk3Elrd1rDDjG4QbhLWxrGPAsxLO9mKGgRnCe/wxW/BqtA1lwsOLsf8e7ASEia
 lRZEghmQv4ZMGYmLjAKnY/LiQuQdvu8dqSQxfe1wtOxobNl+4PVN+lBKMt/B7SeLM9bw
 c7Sw==
X-Gm-Message-State: AOJu0Yy7E2ahO7VcQs2O4T4vR24GoWThhstQp7zDqbT5InXCvze4yH2s
 p22g7X3NXPVWqzBOe6lJNTByJry3DAmOCKcX7QYF8dN74pJDU8QHv+gdiRx0IetfncVU2QKa5yo
 uFAM=
X-Gm-Gg: ASbGncuQy42FiXM1Rn3lzq6xXjfcpz921N6STlkNK10No7BuKLiy8r5z8BxZvlkWqym
 CE5lqv4oGHG3lwr3gFN8ZExFSGqZSZ0uw7Wzn4k6ISo5hgL8h9KuI+V1eNEWKxhfuokOH2XeqQT
 gRizDt9gsRbw8F0g4Km/NCVM8gEb73P7idaFwcEMtw25BaqMMo5gUkNuFKLjb9nXpPY6whr7D8G
 E4B8qKXD3U2P7djBoHILChzgAIoAgXMtzKofHObXfUBXVnccpx5IQ7idfqAdxF6R/JbVps2i5CR
 +0qGqh2MmATy9tccbwpU9Rwge9w44yQRrdLj5lOy
X-Google-Smtp-Source: AGHT+IHKmbEWF+VHflNjPvijvEBJAUUzF3e0M7kh8BDmwXSHYHajkN4Dx8oq8wRS2zFmDBQdPm3PdQ==
X-Received: by 2002:a05:6a20:c995:b0:1f5:8153:9407 with SMTP id
 adf61e73a8af0-20e96ae202cmr7538095637.20.1746409967316; 
 Sun, 04 May 2025 18:52:47 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b1fb3920074sm4462101a12.11.2025.05.04.18.52.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 May 2025 18:52:46 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 richard.henderson@linaro.org, alex.bennee@linaro.org, kvm@vger.kernel.org,
 Peter Maydell <peter.maydell@linaro.org>, anjo@rev.ng,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v5 21/48] target/arm/helper: restrict include to common helpers
Date: Sun,  4 May 2025 18:51:56 -0700
Message-ID: <20250505015223.3895275-22-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250505015223.3895275-1-pierrick.bouvier@linaro.org>
References: <20250505015223.3895275-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42c.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/helper.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 7fb6e886306..10384132090 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -12,7 +12,6 @@
 #include "cpu.h"
 #include "internals.h"
 #include "cpu-features.h"
-#include "exec/helper-proto.h"
 #include "exec/page-protection.h"
 #include "exec/mmap-lock.h"
 #include "qemu/main-loop.h"
@@ -35,6 +34,9 @@
 #include "cpregs.h"
 #include "target/arm/gtimer.h"
 
+#define HELPER_H "tcg/helper.h"
+#include "exec/helper-proto.h.inc"
+
 #define ARM_CPU_FREQ 1000000000 /* FIXME: 1 GHz, should be configurable */
 
 static void switch_mode(CPUARMState *env, int mode);
-- 
2.47.2


