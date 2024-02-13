Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7D64C48BC1
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 15:52:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZv4L-0003zS-B9; Tue, 13 Feb 2024 10:51:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rZv48-0003cF-RY
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 10:51:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rZv45-0005Zy-CC
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 10:51:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707839480;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6fPhdYHmbguZEq4Osn6fTiPYnqI5591O/00HvV3hHMI=;
 b=cNleEEp9/aqyIkLdCVUJ7CLP88NXp8mq7Me3bbeW/FFCe7yFG497vOAeTukhfPeBodqI/P
 1oQMQBWBBT/BpJALZj6RhGazVx+eD+HjezN1YHnRBG9QOEwxEOJdLlzSyyRSxcQEtkIjyt
 9GrszEVbHauxCPRbc09Ll7RY8vp//n0=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-IY4pRvqEMX6vsWsMMpnMYw-1; Tue, 13 Feb 2024 10:51:19 -0500
X-MC-Unique: IY4pRvqEMX6vsWsMMpnMYw-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a2bffe437b5so291655966b.1
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 07:51:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707839475; x=1708444275;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6fPhdYHmbguZEq4Osn6fTiPYnqI5591O/00HvV3hHMI=;
 b=IJZHXi4X47qb29SLbQQbwhbe+6J8Zl5JqUrpvvhGqko3rYys3gUXaMBxok22V8qMyj
 vIw1GHgN19HolZeFvXZDT80PknzLK/N5UmWiAz3X6APT2uYIELiFfsBnEVc2hHkCniF3
 6rYQwWPXsR6qhiNPc8+LhfQNPG3NZ/cCMbaSeQ7Y5AVCvlORqos6BK86gWdZUSuyi0Fd
 OouLbZL4AyQd6NZVXh1skD+80zCtZSLC+/AclZ1vZOlGU/GA3zyLCk/PTECH/jouvJwl
 BJAfn86uRXdbBm20VYM50q/hQEU3dybdqIEUvc6alGT1wNRFP0gNYwkTnsHjFdgO/TCV
 5FJQ==
X-Gm-Message-State: AOJu0Ywd2NIFT0X/d7zZWucPTh2jj6ijk5DzkHQD1p/oVOxEC4n5DYSn
 Tbd0bo1lF1n5tXAXCY8XWhqR5V+2u0NNWyhsfN58gIB1+hT57SdcTeDOx89QpIHWmU/VNt4bev0
 2fupGl2fL5P2ywCJA4UCKPVqsw4ErbNBy1qhBYoDQ5JFiiHBIRb3cvcJ5ZsuwsQbDKsBsxaYKAC
 oH0Ivbod5pXZQ4HnLcGCeUP8xt2T1db93wECRd
X-Received: by 2002:a17:906:3489:b0:a3c:e69:a62b with SMTP id
 g9-20020a170906348900b00a3c0e69a62bmr7423847ejb.26.1707839475386; 
 Tue, 13 Feb 2024 07:51:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFQBd1Y6ovA7tBVl+fOjZ+1etjg3fzweiF4kylultjC1Gyb+4lY++r2TgnePsAFbczPJxUiog==
X-Received: by 2002:a17:906:3489:b0:a3c:e69:a62b with SMTP id
 g9-20020a170906348900b00a3c0e69a62bmr7423821ejb.26.1707839474975; 
 Tue, 13 Feb 2024 07:51:14 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUAO2ky7L46qVqxFe/t281xYd/z49pm+amqHgiomK5VBhzKsURNPjzz3S8yicyOaQvN8dD/F+NCU9RlOs/ToFeFtdFZSc9HDyKPI6K2xbm9WTJuxjwV
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 s15-20020a17090699cf00b00a3d01eb9bb5sm743523ejn.96.2024.02.13.07.51.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Feb 2024 07:51:08 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	shentey@gmail.com,
	balaton@eik.bme.hu
Subject: [PATCH v3 7/9] mips: allow compiling out CONFIG_MIPS_ITU
Date: Tue, 13 Feb 2024 16:50:02 +0100
Message-ID: <20240213155005.109954-8-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213155005.109954-1-pbonzini@redhat.com>
References: <20240213155005.109954-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.504,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

itc_reconfigure() is referenced from TCG, compile out the helpers
that reference env->itu if CONFIG_MIPS_ITU is not defined.
This makes it possible to build a QEMU binary that only includes
boards without a CPS device (only Malta and Boston create one).

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/mips/tcg/translate.h         |  1 +
 target/mips/tcg/sysemu_helper.h.inc | 19 +++++++++++++------
 target/mips/tcg/sysemu/cp0_helper.c |  8 ++++++++
 target/mips/tcg/translate.c         | 10 ++++++++++
 4 files changed, 32 insertions(+), 6 deletions(-)

diff --git a/target/mips/tcg/translate.h b/target/mips/tcg/translate.h
index 93a78b81212..d5458f8690d 100644
--- a/target/mips/tcg/translate.h
+++ b/target/mips/tcg/translate.h
@@ -9,6 +9,7 @@
 #define TARGET_MIPS_TRANSLATE_H
 
 #include "cpu.h"
+
 #include "tcg/tcg-op.h"
 #include "exec/translator.h"
 #include "exec/helper-gen.h"
diff --git a/target/mips/tcg/sysemu_helper.h.inc b/target/mips/tcg/sysemu_helper.h.inc
index f163af1eac7..92d01c49bf6 100644
--- a/target/mips/tcg/sysemu_helper.h.inc
+++ b/target/mips/tcg/sysemu_helper.h.inc
@@ -9,6 +9,8 @@
  * SPDX-License-Identifier: LGPL-2.1-or-later
  */
 
+#include CONFIG_DEVICES
+
 /* CP0 helpers */
 DEF_HELPER_1(mfc0_mvpcontrol, tl, env)
 DEF_HELPER_1(mfc0_mvpconf0, tl, env)
@@ -31,8 +33,6 @@ DEF_HELPER_1(mftc0_tcschedule, tl, env)
 DEF_HELPER_1(mfc0_tcschefback, tl, env)
 DEF_HELPER_1(mftc0_tcschefback, tl, env)
 DEF_HELPER_1(mfc0_count, tl, env)
-DEF_HELPER_1(mfc0_saar, tl, env)
-DEF_HELPER_1(mfhc0_saar, tl, env)
 DEF_HELPER_1(mftc0_entryhi, tl, env)
 DEF_HELPER_1(mftc0_status, tl, env)
 DEF_HELPER_1(mftc0_cause, tl, env)
@@ -57,7 +57,6 @@ DEF_HELPER_1(dmfc0_lladdr, tl, env)
 DEF_HELPER_1(dmfc0_maar, tl, env)
 DEF_HELPER_2(dmfc0_watchlo, tl, env, i32)
 DEF_HELPER_2(dmfc0_watchhi, tl, env, i32)
-DEF_HELPER_1(dmfc0_saar, tl, env)
 #endif /* TARGET_MIPS64 */
 
 DEF_HELPER_2(mtc0_index, void, env, tl)
@@ -103,9 +102,6 @@ DEF_HELPER_2(mtc0_srsconf4, void, env, tl)
 DEF_HELPER_2(mtc0_hwrena, void, env, tl)
 DEF_HELPER_2(mtc0_pwctl, void, env, tl)
 DEF_HELPER_2(mtc0_count, void, env, tl)
-DEF_HELPER_2(mtc0_saari, void, env, tl)
-DEF_HELPER_2(mtc0_saar, void, env, tl)
-DEF_HELPER_2(mthc0_saar, void, env, tl)
 DEF_HELPER_2(mtc0_entryhi, void, env, tl)
 DEF_HELPER_2(mttc0_entryhi, void, env, tl)
 DEF_HELPER_2(mtc0_compare, void, env, tl)
@@ -189,3 +185,14 @@ DEF_HELPER_2(lcsr_drdcsr, i64, env, tl)
 DEF_HELPER_3(lcsr_wrcsr, void, env, tl, tl)
 DEF_HELPER_3(lcsr_dwrcsr, void, env, tl, tl)
 #endif
+
+#ifdef CONFIG_MIPS_ITU
+DEF_HELPER_1(mfc0_saar, tl, env)
+DEF_HELPER_1(mfhc0_saar, tl, env)
+DEF_HELPER_2(mtc0_saari, void, env, tl)
+DEF_HELPER_2(mtc0_saar, void, env, tl)
+DEF_HELPER_2(mthc0_saar, void, env, tl)
+#ifdef TARGET_MIPS64
+DEF_HELPER_1(dmfc0_saar, tl, env)
+#endif
+#endif
diff --git a/target/mips/tcg/sysemu/cp0_helper.c b/target/mips/tcg/sysemu/cp0_helper.c
index 62f6fb4bf65..dde890adf3f 100644
--- a/target/mips/tcg/sysemu/cp0_helper.c
+++ b/target/mips/tcg/sysemu/cp0_helper.c
@@ -21,6 +21,8 @@
  */
 
 #include "qemu/osdep.h"
+#include CONFIG_DEVICES
+
 #include "qemu/log.h"
 #include "qemu/main-loop.h"
 #include "cpu.h"
@@ -371,6 +373,7 @@ target_ulong helper_mfc0_count(CPUMIPSState *env)
     return (int32_t)cpu_mips_get_count(env);
 }
 
+#ifdef CONFIG_MIPS_ITU
 target_ulong helper_mfc0_saar(CPUMIPSState *env)
 {
     if ((env->CP0_SAARI & 0x3f) < 2) {
@@ -386,6 +389,7 @@ target_ulong helper_mfhc0_saar(CPUMIPSState *env)
     }
     return 0;
 }
+#endif
 
 target_ulong helper_mftc0_entryhi(CPUMIPSState *env)
 {
@@ -514,6 +518,7 @@ target_ulong helper_dmfc0_watchhi(CPUMIPSState *env, uint32_t sel)
     return env->CP0_WatchHi[sel];
 }
 
+#ifdef CONFIG_MIPS_ITU
 target_ulong helper_dmfc0_saar(CPUMIPSState *env)
 {
     if ((env->CP0_SAARI & 0x3f) < 2) {
@@ -521,6 +526,7 @@ target_ulong helper_dmfc0_saar(CPUMIPSState *env)
     }
     return 0;
 }
+#endif
 #endif /* TARGET_MIPS64 */
 
 void helper_mtc0_index(CPUMIPSState *env, target_ulong arg1)
@@ -1100,6 +1106,7 @@ void helper_mtc0_count(CPUMIPSState *env, target_ulong arg1)
     cpu_mips_store_count(env, arg1);
 }
 
+#ifdef CONFIG_MIPS_ITU
 void helper_mtc0_saari(CPUMIPSState *env, target_ulong arg1)
 {
     uint32_t target = arg1 & 0x3f;
@@ -1139,6 +1146,7 @@ void helper_mthc0_saar(CPUMIPSState *env, target_ulong arg1)
         }
     }
 }
+#endif
 
 void helper_mtc0_entryhi(CPUMIPSState *env, target_ulong arg1)
 {
diff --git a/target/mips/tcg/translate.c b/target/mips/tcg/translate.c
index 12094cc1e7c..b130222708b 100644
--- a/target/mips/tcg/translate.c
+++ b/target/mips/tcg/translate.c
@@ -49,6 +49,16 @@
 #ifdef CONFIG_USER_ONLY
 STUB_HELPER(cache, TCGv_env env, TCGv val, TCGv_i32 reg)
 #endif
+#if defined CONFIG_SYSTEM_ONLY && !defined CONFIG_MIPS_ITU
+STUB_HELPER(mfc0_saar, TCGv ret, TCGv_env env)
+STUB_HELPER(mfhc0_saar, TCGv ret, TCGv_env env)
+STUB_HELPER(mtc0_saari, TCGv_env env, TCGv val)
+STUB_HELPER(mtc0_saar, TCGv_env env, TCGv val)
+STUB_HELPER(mthc0_saar, TCGv_env env, TCGv val)
+#ifdef TARGET_MIPS64
+STUB_HELPER(dmfc0_saar, TCGv ret, TCGv_env env)
+#endif
+#endif
 
 enum {
     /* indirect opcode tables */
-- 
2.43.0


