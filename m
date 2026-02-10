Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0D0BEA8118
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 13:55:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpoAK-0002Dl-Hi; Tue, 10 Feb 2026 08:52:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vpoAE-00026y-2i
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 08:52:26 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vpoAB-0006Lt-A3
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 08:52:25 -0500
Received: by mail-wm1-x341.google.com with SMTP id
 5b1f17b1804b1-47edd9024b1so52439925e9.3
 for <qemu-devel@nongnu.org>; Tue, 10 Feb 2026 05:52:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770731541; x=1771336341; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=/ItqmxvT2sW8xeL1y52qhG/fYOf0Xbu2AAYt6A/1I0E=;
 b=xfBUfw6yHIoWTYzb42jdKaEVgkzllMF5sUdzDaD5fogKcRsjwUOZruDCqxCBEgQbRB
 1HGvpURe7uBi5ORkpZd+jfspO8UgvX840BN82qKtgVmmj/TqTjQp+jUX0TrP9/wuNzjI
 1SWFfjNSnQdKclVkdE7muozX8Ho6IdnN4qVQohXAAlPxdqVnmEMpSvEv4ybGaazNYUr6
 E3lhav47JI7pcziTy03CiPUWEPnIF3Nqoqurd4M9U+j4zY3IAieKzDEl2KzKUNtcOAOv
 kcfwu+PJ8tjQe+Yghg5MJdcXtII+ov1fyYaBOnCGXYI7XagKXDBni5jkE8b92EJ0jZAC
 56Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770731541; x=1771336341;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=/ItqmxvT2sW8xeL1y52qhG/fYOf0Xbu2AAYt6A/1I0E=;
 b=Y1cKuORmqzwq72B+vri5UneG8v3Lo67B6yzIZr+MsxjJkbm3H1VmU7YDa4nBxT0Vid
 1pHk0QnuPWPoB4X2xjk2d1ByLsmv1DnbCXWPl0SMvmwezk5IU9jQSnKWmA0ry5L+JxCn
 2+nVH1CLvI9q2y7XvsS4mXb+UKzUPRH5jmzSQqo2Ya/nN5EHr+5lgglsbnDn30r1o4U+
 4qGM64WWiR3o8sTDSuHYmSo+LxVEptsIU6+ZFqIlaTdDIF1/Ctw+ZN3Py/0DmmPxC+YR
 gMqM6t9NA3Am4Upfnj2aWA/gWOJY1kJUnHdVfpw/bW8HfzGTXAKSMGbHWQSn3Azf+Vgg
 ZOvw==
X-Gm-Message-State: AOJu0Yzsgtp4qs4BKSnkcSyr6yVFgW9lT9flzO/O+o4UuMgvFlZkRPwM
 tNpRQlqbsuuviW+E5BBOUmX3UgNG+Nk+dn1ciO5vJJUxaSHfzAasH+HOnA1vsdwuAAeybYip5h9
 I/Xgan8k=
X-Gm-Gg: AZuq6aIHlxP63xA11rHEhaqyqNZk1eghG0pKmbX++ept8ywKOztalAWNq7G9zonxWnc
 c0FVaIo6vGWLbT/8G2jGVi2dkWORVmHsIBiUDH+wHRDn2N1Yf1jK9qhta7S0CAA/YJPV3bH5qIu
 5NpgqyzrA30Z466KOvDe2RzR9ux3K7KLgmZ/fhBs+iWFcSXIiNfGRAGpw3JFMvlzubRflzuOPLY
 M0aiiBtuNmFbfGevAeAzDLQ60nFK+9YcfKgkqBa0LU3pcgLTDjL2jirCxdjDLAMTblkTiwXqRbJ
 qqN+ndfV5a5zjvruzjYSYmCxlmeJLpvloVlmN0SR32oH89qpOpFJBMG8JvRwwPytN78Hoc2Ly7T
 +MTaoosTmLfKpz9GxJl7z6fx6kMcL8wOHrwyJOSBjPXG1WwYeEWRTzNUbg7X4xoI/kBmCLnVjOJ
 Ymm4184D5/k7ICW33rA5aPQAB2f/TUTRFCde49d3Lw3Fh7eNqEw3BZYFsRJuy6gv8TYNnvo1+Wg
 ghdqklhU8kvzy/U4JtzBufC0yQNFk4=
X-Received: by 2002:a05:600c:5253:b0:480:6941:d38b with SMTP id
 5b1f17b1804b1-4832021cdcamr201941325e9.30.1770731541238; 
 Tue, 10 Feb 2026 05:52:21 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4834d5d77f9sm64344875e9.3.2026.02.10.05.52.20
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Feb 2026 05:52:20 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 16/26] target/arm: cpu: mark WHPX as supporting PSCI 1.3
Date: Tue, 10 Feb 2026 13:51:56 +0000
Message-ID: <20260210135206.229528-17-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260210135206.229528-1-peter.maydell@linaro.org>
References: <20260210135206.229528-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x341.google.com
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

From: Mohamed Mediouni <mohamed@unpredictable.fr>

Hyper-V supports PSCI 1.3, and that implementation is exposed through
WHPX.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index c535b292d9..077f1f9a74 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -23,6 +23,7 @@
 #include "qemu/timer.h"
 #include "qemu/log.h"
 #include "exec/page-vary.h"
+#include "system/whpx.h"
 #include "target/arm/idau.h"
 #include "qemu/module.h"
 #include "qapi/error.h"
@@ -1143,6 +1144,8 @@ static void arm_cpu_initfn(Object *obj)
     if (tcg_enabled() || hvf_enabled()) {
         /* TCG and HVF implement PSCI 1.1 */
         cpu->psci_version = QEMU_PSCI_VERSION_1_1;
+    } else if (whpx_enabled()) {
+        cpu->psci_version = QEMU_PSCI_VERSION_1_3;
     }
 }
 
-- 
2.43.0


