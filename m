Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE61BF46C66
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2026 18:27:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9oet-0007bU-0J; Mon, 06 Apr 2026 14:26:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w9oer-0007ag-QX
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 14:26:45 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w9oen-0002SX-2A
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 14:26:45 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-c741692db4cso717213a12.1
 for <qemu-devel@nongnu.org>; Mon, 06 Apr 2026 11:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775499999; x=1776104799; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Wjwprsq2bUgWU2oNx7oeoEWsXfRXKdt6nUjzLzY0Nco=;
 b=D2oNxEts6MiK+j4DGa3KHgc+ub0+zIzxpjQCpw7ehCUwFQuIL+I5mXK2ZIPmMPXFFM
 BHR0IBHKSCDEKPA8iwnVpPtrYZAu2kOu5zYQJ57rfY825nyGM7JvSPAGbq1r0n005LN7
 NwKIboQ8zZ4BExcqNr9ObrGJdllPwIPySf9ZaSjz4mVOVQRKRlXiPuJ2VsO6aAiPEFeF
 yRNYTqobaeMMDsPG+9RZ9m3JJXZZfowyIxatprGjNKseekEiVhOHU7PbUpvRiOCjsrJ0
 FCBO8akAkzRsQkiC0WwWt7mnhBlWFASUOgRaGN7SPKEn6qwRWfvrVAzqVlJS5Nb9Ezv7
 nd9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775499999; x=1776104799;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Wjwprsq2bUgWU2oNx7oeoEWsXfRXKdt6nUjzLzY0Nco=;
 b=AqaVRr/QIWTjrvmknnubz5IISv9Ib/42ppe5NdWZPawd0iFqz34ripkhzHgeB/Gz//
 9ex0a0D3kVi98k7bGaeRH26KKBIl1lqsWNBi/2n7hRBMuPADlfmdf5hl4+DgmzZF1YQ8
 gn+5FRgeXTwJeh9i3W4rOXFA3nN51v5z5y0pSiYGpUO7kjTDGa1+Kz/g3TqSzDpCBHZb
 NvrfcSfpob/rfciNoGQTCHXwlDjn+kGNKkUkKbs7vyKmsPCDiK5WZsUdEyWIngiCcizm
 IXRCod43/twOBdCIp+pJr8QMLgvF08L1CDsLTAGBm4f7lBRrmsdQDC3jZM71b23oMw4t
 JnLw==
X-Gm-Message-State: AOJu0YzbEbln5Tw53BFPm3U9qVWmF8hNF++/j+HSQgBKj0Q1gkbQ8Aqa
 WwKOir1RXzbM0SPlbz5a6FPVQEYif1vJdXHV2/TmKyxq20U7GJKhyyFCapAVKbhdmafMuEo98ao
 2X5QW9ZV8WQ==
X-Gm-Gg: AeBDievxE+E5OsKTI0zXFQ5xN0Q9JceU1Xan7q0k3rLhiO9FXGFWJ4gLMPoVbTzyliv
 Ozq4vgGKHvBdDcKQkSt1mX91+/FjiEEeK15+r39dEi6mceRZ33wDf/dtOROckcSc9+HlJd4bzYu
 cvTsKVzd1l0RLUTX4eAysGBiyvZ8BjUYnZtcSfFzNfcRMnHFyQu+itptOwCbgMLjPdMmH1ve3WC
 PUegVWD7bjqEdfoBlxKVm0zYHgh0xRDDn9f53Tjefr+p1j9+FFeUjDePC1i8OOotEKUf3EBfxvl
 O/QJPru8vjp0f75h9UFnn5MMhevIcE/TknSmg5n3GlgvQ+v8t7EQz0tBLY82JIvB12sBjyOnknn
 nSlJ3gay/bi/T6RRX/8bVm10Uj8V/m/lb3uYM96b73F96FoOJK2Dkdllhjz4785ItplyOPcLcuN
 23/Vxlb38frbM/WBVst1ptArNQZqY0AqzQJPlJxIOauP8DMnFV4CSAyawL1+zDIHSvA0mWx/8sQ
 9XR
X-Received: by 2002:a05:6a20:918d:b0:39b:ca34:96e3 with SMTP id
 adf61e73a8af0-39f171a3f3emr16331130637.37.1775499999560; 
 Mon, 06 Apr 2026 11:26:39 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c76c6561fe9sm12765080a12.15.2026.04.06.11.26.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2026 11:26:38 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, jim.macarthur@linaro.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, philmd@linaro.org, qemu-arm@nongnu.org
Subject: [PATCH v8 20/20] target/arm/tcg/translate.c: make compilation unit
 common
Date: Mon,  6 Apr 2026 11:26:09 -0700
Message-ID: <20260406182609.193886-21-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260406182609.193886-1-pierrick.bouvier@linaro.org>
References: <20260406182609.193886-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x536.google.com
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

We removed all target specifics, and can finally compile this file only
once.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/tcg/meson.build | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/target/arm/tcg/meson.build b/target/arm/tcg/meson.build
index 0740de92c1a..506f031f1aa 100644
--- a/target/arm/tcg/meson.build
+++ b/target/arm/tcg/meson.build
@@ -20,20 +20,18 @@ mve_d = decodetree.process('mve.decode', extra_args: '--decode=disas_mve')
 
 m_nocp_d = decodetree.process('m-nocp.decode', extra_args: '--decode=disas_m_nocp')
 
-gen_a32 = [
+translate32_d = [
   decodetree.process('a32.decode', extra_args: '--static-decode=disas_a32'),
   decodetree.process('a32-uncond.decode', extra_args: '--static-decode=disas_a32_uncond'),
   decodetree.process('t32.decode', extra_args: '--static-decode=disas_t32'),
   decodetree.process('t16.decode', extra_args: ['-w', '16', '--static-decode=disas_t16']),
 ]
 
-arm_ss.add(gen_a32)
 arm_ss.add(when: 'TARGET_AARCH64', if_true: gen_a64)
 arm_ss.add(when: 'TARGET_AARCH64', if_false: files('stubs32.c'))
 
 arm_ss.add(files(
   'cpu32.c',
-  'translate.c',
   'm_helper.c',
   'mve_helper.c',
 ))
@@ -66,6 +64,7 @@ arm_common_system_ss.add(
   m_nocp_d,
   mve_d,
   neon_d,
+  translate32_d,
   vfp_d,
   files(
   'cpregs-at.c',
@@ -77,6 +76,7 @@ arm_common_system_ss.add(
   'psci.c',
   'tlb_helper.c',
   'tlb-insns.c',
+  'translate.c',
   'translate-m-nocp.c',
   'translate-mve.c',
   'translate-neon.c',
@@ -88,6 +88,7 @@ arm_user_ss.add(
   m_nocp_d,
   mve_d,
   neon_d,
+  translate32_d,
   vfp_d,
   files(
   'debug.c',
@@ -96,6 +97,7 @@ arm_user_ss.add(
   'neon_helper.c',
   'op_helper.c',
   'tlb_helper.c',
+  'translate.c',
   'translate-m-nocp.c',
   'translate-mve.c',
   'translate-neon.c',
-- 
2.47.3


