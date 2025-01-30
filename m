Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4941EC0218A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2025 18:25:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdZCT-0003zB-HO; Thu, 30 Jan 2025 13:23:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tdZCK-0003u4-MZ
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 13:23:30 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tdZCH-0000Xq-Kw
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 13:23:28 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4361dc6322fso8230115e9.3
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2025 10:23:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738261404; x=1738866204; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UzWUoCV36n6hAnw3YSCmnofxu0Xpqe1BV6caUwzw2Oc=;
 b=MVfEXVAmUTLMODntJQPY3PjKsyHzPn5QfOGEVpdLRQuORY9KLNgJHSbn4R4QGY2KOU
 AUDSAmYCPNpBUwJQYo7sLZMqxjyuHYB18PgFaW9PKdbaWy5UpdHaTQkTdwxStnLoOhel
 UW3/fynh7USZ8Dke5HCac+IRgJEJYAvrIGsWnHTRFktQo91VDCvKubcwsWqkzbPYt3fc
 TySpsl4fFgbJAdfShVBifII/EqqCQ7BAaYN+g861+fBwQxMHL8BBh1is53dzz7eqp5jZ
 9TCc7fmCFCBPcCxzZcTEfiz3+2jQ68oCO1/ys9fP/C/Vjb3XT+o0mlmPig502ZjpKNIp
 OXqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738261404; x=1738866204;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UzWUoCV36n6hAnw3YSCmnofxu0Xpqe1BV6caUwzw2Oc=;
 b=F/mZvh+2D93uxdlyJU9PRsblxt/cNDt8w32W2ycbJBeku0PrNbGP7nnnR5Eu3DOnmV
 8x2aj9yeYtmtg58nL+rNVzgMaM5vFjfIQl/fzp59PwdR8s6MSLZ6xQi18ZAqHwBOaEk/
 LqlYpMYpjZ03mg6e0O9zwrnM0kJ+TxvRKDIotsQkZzMAyRUywOKbgkkvXGfHBUIa3RcB
 uz5zMJNRCvwIosZx8vEGrjUNFkIdLHqDgLEK+/02Md+AGxc48npt9NbDi5Ui5OXn4zae
 GYvbdxSZImkYiLxp2ioGhd4L25yUMNBosWwQ7clTi6slvAktCSwN0qvC24qSs3CW3evk
 18Qg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUUf6rw+KUL95v60ZEtk+cNtZ60/9Ed3ElACBkggOVgf1Wqb6dgErBjhrxGK6Qxj5wyolGXbK5CUJ0o@nongnu.org
X-Gm-Message-State: AOJu0YyyTpNRXq3q94v4JzZItNXxCN4KgxAJB8lwqGlhSugTL1vGxWwN
 WEcXjurQjI+8yLmagvGmsBwREdvloEZ/cwd7CTXdeJs4Sw6o9ddf6wk2PtT+5HI=
X-Gm-Gg: ASbGncv34XY0uiHV9/JqblhDvBcveYHl6LIQamkmUWrZ6i65dPIlx5I2ydH8zfbZK2Q
 +Gl2+GUaxga7rAHnv/+xx9aydjEKDjds60oqTP2EatR7hQTazlOeTpK5YQPGkvqgKcOHjVtoms9
 emsDRerNC9dzUq2qXfyWBXXiY8ezD+M6XCmJjhpwGX3mD4vppFeRhVpQ+W2EGcoLHOF1ZMy3/Em
 sooONtabrwM7hpreLEGxOFZWmoYrWZeGn1msrcp8sk3AqILKke9XhE3z61RskhzN9C1m3dXVlwB
 7FcWBiiD/+Mm9rPYH95OZA==
X-Google-Smtp-Source: AGHT+IHv5gF70a4Mqx8gdcoaCrYuQ74X9HkaiJE7S7DYI8dtyyZsPjQ0YXE5YOYaMCY55s/ktOPz4w==
X-Received: by 2002:a5d:64c3:0:b0:38a:a117:3da1 with SMTP id
 ffacd0b85a97d-38c51946048mr7119768f8f.5.1738261403930; 
 Thu, 30 Jan 2025 10:23:23 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c5c101599sm2634426f8f.23.2025.01.30.10.23.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jan 2025 10:23:23 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 12/14] target/arm: Remove CP_ACCESS_TRAP handling
Date: Thu, 30 Jan 2025 18:23:07 +0000
Message-Id: <20250130182309.717346-13-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250130182309.717346-1-peter.maydell@linaro.org>
References: <20250130182309.717346-1-peter.maydell@linaro.org>
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

There are no longer any uses of CP_ACCESS_TRAP in access functions,
because we have converted them all to use either CP_ACCESS_TRAP_EL1
or CP_ACCESS_TRAP_UNCATEGORIZED, as appropriate. Remove the handling
of bare CP_ACCESS_TRAP from the access_check_cp_reg() helper, so that
it now asserts if an access function returns it.

Rename CP_ACCESS_TRAP to CP_ACCESS_TRAP_BIT, to make it clearer
that this is an internal-only definition, not something that
it makes sense to return from an access function. This should
help to avoid future bugs where we return the wrong syndrome
value by mistake.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpregs.h        | 11 ++++++-----
 target/arm/tcg/op_helper.c | 13 ++++++++-----
 2 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/target/arm/cpregs.h b/target/arm/cpregs.h
index fbf5798069d..fb3b84baa1e 100644
--- a/target/arm/cpregs.h
+++ b/target/arm/cpregs.h
@@ -328,12 +328,13 @@ typedef enum CPAccessResult {
      * Access fails due to a configurable trap or enable which would
      * result in a categorized exception syndrome giving information about
      * the failing instruction (ie syndrome category 0x3, 0x4, 0x5, 0x6,
-     * 0xc or 0x18).
+     * 0xc or 0x18). These traps are always to a specified target EL,
+     * never to the usual target EL.
      */
-    CP_ACCESS_TRAP = (1 << 2),
-    CP_ACCESS_TRAP_EL1 = CP_ACCESS_TRAP | 1,
-    CP_ACCESS_TRAP_EL2 = CP_ACCESS_TRAP | 2,
-    CP_ACCESS_TRAP_EL3 = CP_ACCESS_TRAP | 3,
+    CP_ACCESS_TRAP_BIT = (1 << 2),
+    CP_ACCESS_TRAP_EL1 = CP_ACCESS_TRAP_BIT | 1,
+    CP_ACCESS_TRAP_EL2 = CP_ACCESS_TRAP_BIT | 2,
+    CP_ACCESS_TRAP_EL3 = CP_ACCESS_TRAP_BIT | 3,
 
     /*
      * Access fails and results in an exception syndrome 0x0 ("uncategorized").
diff --git a/target/arm/tcg/op_helper.c b/target/arm/tcg/op_helper.c
index c69d2ac643f..fcee11e29ad 100644
--- a/target/arm/tcg/op_helper.c
+++ b/target/arm/tcg/op_helper.c
@@ -853,21 +853,24 @@ const void *HELPER(access_check_cp_reg)(CPUARMState *env, uint32_t key,
 
  fail:
     excp = EXCP_UDEF;
-    switch (res & ~CP_ACCESS_EL_MASK) {
-    case CP_ACCESS_TRAP:
+    switch (res) {
+        /* CP_ACCESS_TRAP* traps are always direct to a specified EL */
+    case CP_ACCESS_TRAP_EL3:
         /*
          * If EL3 is AArch32 then there's no syndrome register; the cases
          * where we would raise a SystemAccessTrap to AArch64 EL3 all become
          * raising a Monitor trap exception. (Because there's no visible
          * syndrome it doesn't matter what we pass to raise_exception().)
          */
-        if ((res & CP_ACCESS_EL_MASK) == 3 && !arm_el_is_aa64(env, 3)) {
+        if (!arm_el_is_aa64(env, 3)) {
             excp = EXCP_MON_TRAP;
         }
         break;
+    case CP_ACCESS_TRAP_EL2:
+    case CP_ACCESS_TRAP_EL1:
+        break;
     case CP_ACCESS_TRAP_UNCATEGORIZED:
-        /* Only CP_ACCESS_TRAP traps are direct to a specified EL */
-        assert((res & CP_ACCESS_EL_MASK) == 0);
+        /* CP_ACCESS_TRAP_UNCATEGORIZED is never direct to a specified EL */
         if (cpu_isar_feature(aa64_ids, cpu) && isread &&
             arm_cpreg_in_idspace(ri)) {
             /*
-- 
2.34.1


