Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AA50C282DE
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 16:41:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqEG5-0006qG-Hd; Thu, 06 Mar 2025 11:39:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tqEFx-0006kj-SK
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 11:39:36 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tqEFu-0004W5-8P
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 11:39:33 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-43bdcd0d97dso5396765e9.3
 for <qemu-devel@nongnu.org>; Thu, 06 Mar 2025 08:39:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741279168; x=1741883968; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Q+T7VuurGO0f901MDk6f8XYzX0X5BpbcVrzC5rBMrok=;
 b=Shj7twNxNso0/7igM+cnhcekdGRnwcLGR3N1/f+epBdrzzpaJEGYfo7CXWMI2yY6vr
 zX+khxiK2mQcZDks6DKw3Zlk89+tr5wR5nddI17pEvMN2Jn/YSJHEADjnT0WRFJwib/l
 xp3IZmRrKyfgFD9Y1l9DVqrFIlR3Fx/S5RpnGNNe/xT6jnqNaOpOi9E8Q8DvmhUuhmoW
 wZZekJv7WfhOMMVOobk3N0JkQxY509o/d3QcfWXQye4GMwqjTfdE9p4Nhh30jmUug/yA
 o1Rj61+kbgwGuLRg/7213RJg0LxWj/StoSzbGhXxnbsJ7udxXa9I2vRhfjiBXvyfkRku
 246Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741279168; x=1741883968;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q+T7VuurGO0f901MDk6f8XYzX0X5BpbcVrzC5rBMrok=;
 b=OFdKuW8p+rB0/YuCdU2d8gg41CLxfhh6Qq1bID1cp7YMLuSSEmG9rGZesprvf1ANGx
 MlZ6Q4PBGFH3BYwGu2fKs7RpEDBd/yxghS0HiS69VE/E5zM14WzrtnxpaaO88k13NcWE
 doG7WDntky+VFKOT0wDw1yF3CP6rFDfi0rJg/2rkbkNExR6TxHT27Sy8ubQa+vtlDkPA
 czwi+js6anyUaympuHzblL7iFcXJWjo6VoxFR2PXhXgAbsTSW1ivB85DIaJaQ/Nhi9dA
 TwG4bz+uqKAz6YWc9TEWR4IrQXU3Lb3jq7zbvjb22u7UgLh/e1HOjocOhL/4FuZ58buQ
 iKew==
X-Forwarded-Encrypted: i=1;
 AJvYcCVTWjbpIHw8DZNGWwUNEMLLjEosUS/HBRzJ22M6nxwd2r5JkNRObZ0sw2F4LWyFrzM4mloL8jrpLXc3@nongnu.org
X-Gm-Message-State: AOJu0Yzv524eKggLZNQ5i30eZQX3yNbM3t/gXa1F+mVifXNDTngs3uBN
 sH8VTOvvzXSl1+L7bPUb1eeQc1c4GvyBBkLTjU6DJDeEFIYrrw9C1uKmhfycTWU=
X-Gm-Gg: ASbGnctXd6ggFAwepnY1R1dQu26uWTSeJ1a2boA09sI2yXx8UlCzZFNxZAPXlsYRz7g
 Fz5ujqToyc5N30oJSG+e3uS4ZoCpaY0q+7NMRrwO9Xba2eJkA0wsjVozcAQfxkCCGVcJ9EkIsoW
 uUuiWIl3q7eMkhu43j9dMW7NM++tSX+AIaHRxSfAhb2UbvH3hxmN14PJlJUueonnw21VUwiiFjf
 ZR7mZd3XustFxkVBljuj7rq5FlqdZE6rfIbtcENqC+8+Dds5FH6/VL3+FJI2HKUEcmLmk3CFyZG
 FGjP7vVYSEkPJ1UB0nF+aQAjY2THIV2TJhf2LBAEye4JnMgptbg=
X-Google-Smtp-Source: AGHT+IHbC7FFo3TvqgJ+WqBlkcSvP24OU++PPGVTKay20fczsXHko4p3Yn+1YpwWW6u1IcBz3J0INA==
X-Received: by 2002:a05:600c:17d1:b0:439:8e95:795b with SMTP id
 5b1f17b1804b1-43c68729939mr716785e9.31.1741279168451; 
 Thu, 06 Mar 2025 08:39:28 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bdd94913fsm23999905e9.37.2025.03.06.08.39.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Mar 2025 08:39:27 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 01/10] target/arm: Move A32_BANKED_REG_{GET,
 SET} macros to cpregs.h
Date: Thu,  6 Mar 2025 16:39:15 +0000
Message-ID: <20250306163925.2940297-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250306163925.2940297-1-peter.maydell@linaro.org>
References: <20250306163925.2940297-1-peter.maydell@linaro.org>
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

The A32_BANKED_REG_{GET,SET} macros are only used inside target/arm;
move their definitions to cpregs.h. There's no need to have them
defined in all the code that includes cpu.h.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpregs.h | 28 ++++++++++++++++++++++++++++
 target/arm/cpu.h    | 27 ---------------------------
 2 files changed, 28 insertions(+), 27 deletions(-)

diff --git a/target/arm/cpregs.h b/target/arm/cpregs.h
index 52377c6eb50..2183de8eda6 100644
--- a/target/arm/cpregs.h
+++ b/target/arm/cpregs.h
@@ -1157,4 +1157,32 @@ static inline bool arm_cpreg_traps_in_nv(const ARMCPRegInfo *ri)
     return ri->opc1 == 4 || ri->opc1 == 5;
 }
 
+/* Macros for accessing a specified CP register bank */
+#define A32_BANKED_REG_GET(_env, _regname, _secure)                     \
+    ((_secure) ? (_env)->cp15._regname##_s : (_env)->cp15._regname##_ns)
+
+#define A32_BANKED_REG_SET(_env, _regname, _secure, _val)       \
+    do {                                                        \
+        if (_secure) {                                          \
+            (_env)->cp15._regname##_s = (_val);                 \
+        } else {                                                \
+            (_env)->cp15._regname##_ns = (_val);                \
+        }                                                       \
+    } while (0)
+
+/*
+ * Macros for automatically accessing a specific CP register bank depending on
+ * the current secure state of the system.  These macros are not intended for
+ * supporting instruction translation reads/writes as these are dependent
+ * solely on the SCR.NS bit and not the mode.
+ */
+#define A32_BANKED_CURRENT_REG_GET(_env, _regname)                          \
+    A32_BANKED_REG_GET((_env), _regname,                                    \
+                       (arm_is_secure(_env) && !arm_el_is_aa64((_env), 3)))
+
+#define A32_BANKED_CURRENT_REG_SET(_env, _regname, _val)                    \
+    A32_BANKED_REG_SET((_env), _regname,                                    \
+                       (arm_is_secure(_env) && !arm_el_is_aa64((_env), 3)), \
+                       (_val))
+
 #endif /* TARGET_ARM_CPREGS_H */
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 215845c7e25..c360b74ded9 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2682,33 +2682,6 @@ static inline bool access_secure_reg(CPUARMState *env)
     return ret;
 }
 
-/* Macros for accessing a specified CP register bank */
-#define A32_BANKED_REG_GET(_env, _regname, _secure)    \
-    ((_secure) ? (_env)->cp15._regname##_s : (_env)->cp15._regname##_ns)
-
-#define A32_BANKED_REG_SET(_env, _regname, _secure, _val)   \
-    do {                                                \
-        if (_secure) {                                   \
-            (_env)->cp15._regname##_s = (_val);            \
-        } else {                                        \
-            (_env)->cp15._regname##_ns = (_val);           \
-        }                                               \
-    } while (0)
-
-/* Macros for automatically accessing a specific CP register bank depending on
- * the current secure state of the system.  These macros are not intended for
- * supporting instruction translation reads/writes as these are dependent
- * solely on the SCR.NS bit and not the mode.
- */
-#define A32_BANKED_CURRENT_REG_GET(_env, _regname)        \
-    A32_BANKED_REG_GET((_env), _regname,                \
-                       (arm_is_secure(_env) && !arm_el_is_aa64((_env), 3)))
-
-#define A32_BANKED_CURRENT_REG_SET(_env, _regname, _val)                       \
-    A32_BANKED_REG_SET((_env), _regname,                                    \
-                       (arm_is_secure(_env) && !arm_el_is_aa64((_env), 3)), \
-                       (_val))
-
 uint32_t arm_phys_excp_target_el(CPUState *cs, uint32_t excp_idx,
                                  uint32_t cur_el, bool secure);
 
-- 
2.43.0


