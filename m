Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0B11C369DC
	for <qemu-devel@archiver.kernel.org>; Sun,  4 May 2025 05:46:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBRuy-00025N-T1; Sun, 04 May 2025 01:29:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBRus-00020Z-Ee
 for qemu-devel@nongnu.org; Sun, 04 May 2025 01:29:30 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBRuq-0004IL-OZ
 for qemu-devel@nongnu.org; Sun, 04 May 2025 01:29:30 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-72d3b48d2ffso3620641b3a.2
 for <qemu-devel@nongnu.org>; Sat, 03 May 2025 22:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746336567; x=1746941367; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Gch+3DQ1xFSIgoe8nsFHA95PeotLzKWriKqshNx+4Kc=;
 b=w/qK4Ob77xSO5QHeDQDF0ka/ZhTeAYGyjJrdUnAI/rRVO1dkQ0xS0Ni5NSkt7OlUbb
 QvmPG4ofqAU6B36apNuy9BigIpoNZRG81hGuxs1JWZvxZ3SxLN+Oaao331PCGu87cWE0
 ZlEXu6Xsy95/E9qXTSuPnKswLy5mO7MHz2OWN7gXMOug830/Fw5wql1P/yVsJwRm6aTv
 k+Rugpd24skro8ufQ/0dpbTaxpkSDoLmmrE3N5/+4MyE7pVty8dUTBFaZ72AKTLcEUMl
 ziUh2AfuAJeE8xFe9IyCVES+oFx5Mdv5AODkPeUBne1GPNgFvhur8gjcpm8uM9pgi8Bm
 4G8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746336567; x=1746941367;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Gch+3DQ1xFSIgoe8nsFHA95PeotLzKWriKqshNx+4Kc=;
 b=W9m+gKAg/EDkJwstgiegDaqZxJ7VWxwjotpiINb1XPc0yDxkWc7UDzKlTRV2siaiwO
 PqTfhKyvc4bmzDNGi8hib608Ewrbn/v6x5IdsKrpk2OBN4VMIMxpFyiVXwbd9gcilfoj
 BTNxHUSrqdkKfJ7a6u+nsrvc8mcf9se0OpJMx0AXbp0ekjQ9189F0eMK7iazuHPceMqn
 AbLDs9ZRWZzBZIu956vVh+ibfUOcD1uKbaz0Om6ENNEwLXQCKu3PYxwH4sR/UE4s4dBJ
 rFZcxzhvKMQADWGfhatXq193tO7oh3tGrUoj/QMTCU80CpCCxFw7R70vEfspZWqfEVle
 okGA==
X-Gm-Message-State: AOJu0YxW4mvS5QrsAeUXESlzwZH7ogmAaGzp2J7Gcu3IB9D/ifPQzNsJ
 lfAQjj1ZzlS5OuM04XFu4wQ37k8dkHlxciK676B1e1DtSimZrId8bSOefMH7otdP1XOxkThkEMo
 vG9o=
X-Gm-Gg: ASbGncunANZqraxKeC8UM+kgwp69jfaJT7MbA5utsHDeMuHC2DOzGaBe4f5U2YQyUmo
 FgN504aiK+TJn3fDdPYhrjWWt9FCB477rXy1Nr8W6JRshPhX1CDmuwd1GKQJ5Qtrn1qWYHaBic8
 LyneYHd1cHI5Kq8s9+4Af/Ebo9YbRFV/FZqfMO5yPK1kp8344RGcSXAUgjh6fc4GDekCKQS5UMX
 iiFH69Lo7w3O888aVNLD1YSuJw2iw7eI49B3tWLqb1Amp5X6oFpWAPCSFjN3u6c52SiagceSGyW
 14vu6dI4wMIhuaNJRygAHsfKUtTHFxRRj5/XL3Nn
X-Google-Smtp-Source: AGHT+IGXuGRVL3Kp8Tbnh2lq0xrBRJpVKeq6VuZp/yqp7m4DrchYSA4CAHT6B8T4OdtYK0I45HTlWA==
X-Received: by 2002:a05:6a21:158a:b0:1ee:d06c:cddc with SMTP id
 adf61e73a8af0-20e979c95eamr4856736637.30.1746336567495; 
 Sat, 03 May 2025 22:29:27 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-740590207e3sm4400511b3a.94.2025.05.03.22.29.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 May 2025 22:29:27 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org, anjo@rev.ng,
 kvm@vger.kernel.org, richard.henderson@linaro.org,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 alex.bennee@linaro.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v4 08/40] accel/hvf: add hvf_enabled() for common code
Date: Sat,  3 May 2025 22:28:42 -0700
Message-ID: <20250504052914.3525365-9-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250504052914.3525365-1-pierrick.bouvier@linaro.org>
References: <20250504052914.3525365-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x433.google.com
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

Other accelerators define a CONFIG_{accel}_IS_POSSIBLE when
COMPILING_PER_TARGET is not defined, except hvf.

Without this change, target/arm/cpu.c can't find hvf_enabled.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/system/hvf.h  | 14 +++++++++-----
 accel/hvf/hvf-stub.c  |  5 +++++
 accel/hvf/meson.build |  1 +
 3 files changed, 15 insertions(+), 5 deletions(-)
 create mode 100644 accel/hvf/hvf-stub.c

diff --git a/include/system/hvf.h b/include/system/hvf.h
index 356fced63e3..1ee2a4177d9 100644
--- a/include/system/hvf.h
+++ b/include/system/hvf.h
@@ -19,15 +19,19 @@
 
 #ifdef COMPILING_PER_TARGET
 #include "cpu.h"
+# ifdef CONFIG_HVF
+#  define CONFIG_HVF_IS_POSSIBLE
+# endif
+#else
+# define CONFIG_HVF_IS_POSSIBLE
+#endif
 
-#ifdef CONFIG_HVF
+#ifdef CONFIG_HVF_IS_POSSIBLE
 extern bool hvf_allowed;
 #define hvf_enabled() (hvf_allowed)
-#else /* !CONFIG_HVF */
+#else
 #define hvf_enabled() 0
-#endif /* !CONFIG_HVF */
-
-#endif /* COMPILING_PER_TARGET */
+#endif /* CONFIG_HVF_IS_POSSIBLE */
 
 #define TYPE_HVF_ACCEL ACCEL_CLASS_NAME("hvf")
 
diff --git a/accel/hvf/hvf-stub.c b/accel/hvf/hvf-stub.c
new file mode 100644
index 00000000000..7f8eaa59099
--- /dev/null
+++ b/accel/hvf/hvf-stub.c
@@ -0,0 +1,5 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#include "qemu/osdep.h"
+
+bool hvf_allowed;
diff --git a/accel/hvf/meson.build b/accel/hvf/meson.build
index fc52cb78433..7745b94e50f 100644
--- a/accel/hvf/meson.build
+++ b/accel/hvf/meson.build
@@ -5,3 +5,4 @@ hvf_ss.add(files(
 ))
 
 specific_ss.add_all(when: 'CONFIG_HVF', if_true: hvf_ss)
+common_ss.add(when: 'CONFIG_HVF', if_false: files('hvf-stub.c'))
-- 
2.47.2


