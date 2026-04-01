Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86AF5107639C
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 19:27:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w81Dl-0003xF-Nd; Wed, 01 Apr 2026 15:27:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w81Dj-0003wO-QV
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 15:27:20 -0400
Received: from mail-qk1-x72a.google.com ([2607:f8b0:4864:20::72a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w81Dh-00041F-In
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 15:27:18 -0400
Received: by mail-qk1-x72a.google.com with SMTP id
 af79cd13be357-8cfbfdabf3fso13409885a.3
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 12:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775071636; x=1775676436; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RHueK+jQ5chjrKpFFnR9MSU7a1nsMemCFdXKqJS5w6c=;
 b=dj1yzxEzJRGeC7QT83Xujb+avLiAcRzaNSn8yD78dxkWNCuVv9jFeEP/SaPnlQEzcn
 P50LEjasC7tN0T72n3+AeZYlPIYb2ug301eRBmyNufCxfD5YVNgc2g5AQ+rEoQCdxl0j
 6JuP7xTj737xrdDMDgnyf1TEO4nS5mUkw+PKzhh/DGVn17oAd6GXlu+A881jmXUJTkfZ
 j4QH6RVcVILwikVstRF/aNUZEIAqOdZvr+aZFWkPBN7zpdnrkC0hOrDz5xKaOLdrsixE
 ChUiVDpwUCZR+dl463K6UQmrcFhSidzKrxRxo1SoYjohOsuUW0a+fe7L8ZNtzhD2NoHm
 YNag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775071636; x=1775676436;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RHueK+jQ5chjrKpFFnR9MSU7a1nsMemCFdXKqJS5w6c=;
 b=YOFhp8oXJzrSrqGDb0Sp/128HipSzBk/MEW8A0tdJ8TPNx55ZO57Z7PneB/cNO1lvG
 FqCbuUWGtuNgB1cOOCLhM/CgKBLhlbf5d/4aw942h2D/dYR1oBjAw9ItPlJl3txXk/eh
 0o3CX5v5Jx598Uz5wgOV8IyFNxsjeZ0ZdYELJthD/nR4/ndQuYzmQUmQBjYPZQiWhfLK
 KnGB5HSFcWTXd+5hPm+SjjH8Q5ivxEKnJB82mv/HRRqcWEUCT5735Xze9/NyiiBVWIBi
 irx9ZX0r2ODvxsVm5m4Pn+s4KThhUASULrxQ3XHhthJBHABEsLUjiJjBoI28KItzqZLd
 ypqw==
X-Gm-Message-State: AOJu0YwnRtFGhqJugEJOYcs+YdOzJYSUa+VKvSHB2GMHzU7CBRt1TfUa
 RO6kjdg/F0q9pA/4Ck9q+45OD9/OK29pJC07RA3YYc1IADrT72us2gQpJT7pqSI4AwoTuHhe8rm
 eKVK0o8Ytmw==
X-Gm-Gg: ATEYQzxYqy/BO2opKvLUJUWAMi4vrJMtThFPYwpoIeWCBKCRQXl4r9l3eJgv24HiEiX
 qzyXYfxQlKttjkNCeGNtN/B1z4Ej0s3ogcFaGvZVesKNjTVbzTFxFzSgrNPw/fePu1Dbxno8u7h
 M2ensMEA8zbRjUIR10HJz08+O3T9FpLiP0XalDXAGVq7r1zXj3HFfOXxAXk7hkZrcZbRUVvY9T0
 vh1IG4LVbCEESL6C87hQtsYUoFyA/H8iXUPCPhUUuT6xNAHREAP5rJ63kU9JZfjohjfE56uN730
 GVj4FZ5RlUPhgXVEQpsSGpdVojMOvQWhI99hERupyMCPybVli3E2HQAja0Rb4NJ1IY/JHMXYPon
 PZyDUCovgqd91aD4Lk+IiOKmXWMeNtb/kqP1qTHK9SnohB2QQxwOBO3d/MByLiojgtbh9u1cY3s
 qLC8p04vDLpZnEF1YZKghiTu0PM+/a54W0BybyvETfn7NXMbFXP6qNmobqGERZLLF2s1Qaxh5Mx
 yNtGLoK8EfkNz0=
X-Received: by 2002:a17:90b:3f44:b0:354:a57c:65db with SMTP id
 98e67ed59e1d1-35dc6f0128amr4069105a91.20.1775071270461; 
 Wed, 01 Apr 2026 12:21:10 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35dbe41b11fsm5633113a91.0.2026.04.01.12.21.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Apr 2026 12:21:10 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 jim.macarthur@linaro.org, Richard Henderson <richard.henderson@linaro.org>,
 philmd@linaro.org, Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v6 07/12] target/arm/tcg/translate-mve.c: make compilation
 unit common
Date: Wed,  1 Apr 2026 12:20:52 -0700
Message-ID: <20260401192057.1182724-8-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260401192057.1182724-1-pierrick.bouvier@linaro.org>
References: <20260401192057.1182724-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::72a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-qk1-x72a.google.com
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/tcg/meson.build | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/target/arm/tcg/meson.build b/target/arm/tcg/meson.build
index 8d9112f6da2..89c3b476822 100644
--- a/target/arm/tcg/meson.build
+++ b/target/arm/tcg/meson.build
@@ -16,9 +16,10 @@ neon_d = [
   decodetree.process('neon-ls.decode', extra_args: '--decode=disas_neon_ls'),
 ]
 
+mve_d = decodetree.process('mve.decode', extra_args: '--decode=disas_mve')
+
 gen_a32 = [
   decodetree.process('m-nocp.decode', extra_args: '--decode=disas_m_nocp'),
-  decodetree.process('mve.decode', extra_args: '--decode=disas_mve'),
   decodetree.process('a32.decode', extra_args: '--static-decode=disas_a32'),
   decodetree.process('a32-uncond.decode', extra_args: '--static-decode=disas_a32_uncond'),
   decodetree.process('t32.decode', extra_args: '--static-decode=disas_t32'),
@@ -34,7 +35,6 @@ arm_ss.add(files(
   'gengvec.c',
   'translate.c',
   'translate-m-nocp.c',
-  'translate-mve.c',
   'm_helper.c',
   'mve_helper.c',
   'op_helper.c',
@@ -65,6 +65,7 @@ arm_common_ss.add(files(
 ))
 
 arm_common_system_ss.add(
+  mve_d,
   neon_d,
   vfp_d,
   files(
@@ -75,12 +76,14 @@ arm_common_system_ss.add(
   'psci.c',
   'tlb_helper.c',
   'tlb-insns.c',
+  'translate-mve.c',
   'translate-neon.c',
   'translate-vfp.c',
   'vec_helper.c',
   'vfp_helper.c',
 ))
 arm_user_ss.add(
+  mve_d,
   neon_d,
   vfp_d,
   files(
@@ -88,6 +91,7 @@ arm_user_ss.add(
   'hflags.c',
   'neon_helper.c',
   'tlb_helper.c',
+  'translate-mve.c',
   'translate-neon.c',
   'translate-vfp.c',
   'vec_helper.c',
-- 
2.47.3


