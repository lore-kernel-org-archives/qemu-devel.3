Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06A7AFB5184
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2026 02:29:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9wAi-0007XD-LM; Mon, 06 Apr 2026 22:28:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w9wAh-0007WP-Of
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 22:28:07 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w9wAd-0006xC-Lg
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 22:28:06 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-c76b9efc299so1784688a12.0
 for <qemu-devel@nongnu.org>; Mon, 06 Apr 2026 19:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775528881; x=1776133681; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n0wgNLa9n9Vgc0kuCG4RsEiFVidf8BLE6jw9JT+iAmc=;
 b=QLjscXNceVDXHto3POfEb4Lp8VGuHcyw+ELHXNOg1cbrcp+tOxzZHmJTy6aLI0LHsA
 AEihgmnz8cJ7r+YZ6zBLLDlUAPfmDQ6x6S9UOpSy64q0CV3aXKByjBTIK82dLKQjOkYm
 l1l3VkEIdp7P6Q47BHKYkufv4w+VEeNsrafFG/vmDOUOOhW7+5o5t4A4u30JZyotK9FY
 TRbbxwKUgAwNUh/bnW7/UK7mD4OULhFUvYk9CLyyFJTncHjX4N37UJKcpVthMkgHAVT2
 /xhSZYfz3YsDw68pA4G4yepG6EcrxqjIuEHRHdutxV+49Lwfm8eTTxWb+yjsFwRX8bow
 TRsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775528881; x=1776133681;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=n0wgNLa9n9Vgc0kuCG4RsEiFVidf8BLE6jw9JT+iAmc=;
 b=WwOI2yca9YPpR7//n/c9TLXLR99DB2IQwJjMy6OyRZiACN3RGbqyW878nQVdREnoGG
 cHV+cb2lKRNlk6VAephpIZJyy8p2DXTCst3gNvjosDxCDgOzJ2JC22eIwdLQZdSUIP7k
 JEWt2FS2QTEnXvySJUGcXXPsexTo6len7azH4cQwDTb+UGixgzh+/ikBaq08LK4HA/UI
 qUvY8QzXmv5EEz6zaXtdysGJFz/n55TQ0eU4jrjIoeYCZpKHUch7OJEBhN+cBnlLVinN
 p8qSZhhDcaQDpGMbaJJE5KoKohVKOZw/o34UDkvve0dnm3f6Mwm7JLEq/FSimPvL3ggN
 p9EA==
X-Gm-Message-State: AOJu0YyHE0GMcvdrGWNZ3kLqZg0sexTibpQBkqFpEjS+uhNLHSy4it0m
 BszF+iMKjT+7ixyREsGpfMMDM8OqJM4qmvF7CCCEyR5zHPIYEQ2zrDyWAtrfPeWJzty+g1uoJDp
 /NG4LJw3cWA==
X-Gm-Gg: AeBDievZx1LmfEQWPK7ElzPu1PYr3a3BLDzmSogr7JLHdZBdTT6aQtSJ2xeSBosDpyu
 LiegYrgtU0w3JAJ1MJ9iheZTrQNPh1YJYa7YG9pq6QixF5Mp6siisRSj/1VtTc6kxgwsxDtscY1
 tILBfMh26HW6cywpMJlg/HWOIzwzJ6pFAiU7jqQ/s9+6oPH8oXK+xlJd3ee4gqqv2OGfHbADto5
 YFTaM1NHNGcRYg5OdHfrheLCJRu++KR5oY2WAKZUwaz8TMCvBW0aG4JHdXMhui1FvX1OS5ixblU
 SSuA6IPWLJLM0PqU1R1cIsgGHzNZ2XRcIhUTe0CWrMtu1ZZggKoWaMcpMs9ZiqsUnmfb+klq48p
 2hIJ8H10BZ+SfuTTp8NksTFxKyAnPjtDmwqiqzCmw/4AqRur98S8Md+7IGsj+xRf6zfGHFnAg9m
 0Xb4LTwyJNQHRJ8gYB/cukZZtzEJIbUgcTepx5tdMh5lAFkHrdhAKkwAeCNF4Womlh4VBE1v3i2
 D45
X-Received: by 2002:a17:903:1450:b0:2b2:45b7:3078 with SMTP id
 d9443c01a7336-2b2817ced5bmr151149645ad.3.1775528880966; 
 Mon, 06 Apr 2026 19:28:00 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b2749794e8sm161423685ad.53.2026.04.06.19.28.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2026 19:28:00 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, jim.macarthur@linaro.org,
 qemu-arm@nongnu.org
Subject: [PATCH v9 05/20] target/arm/tcg/translate-vfp.c: make compilation
 unit common
Date: Mon,  6 Apr 2026 19:27:33 -0700
Message-ID: <20260407022748.57629-6-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260407022748.57629-1-pierrick.bouvier@linaro.org>
References: <20260407022748.57629-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x535.google.com
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

Generated decode files must be duplicated between user and system, as
they are generated in private folders per libs, and can't be included
otherwise, as meson does not give control on output folder.
Indeed, meson generator is a different approach than custom_target, and
this is a limitation by design.

They were already duplicated between arch variants anyway, so nothing
new here. They will now be compiled once for system binaries, and still
per target for user binaries.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/tcg/meson.build | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/target/arm/tcg/meson.build b/target/arm/tcg/meson.build
index 3e96c77df73..5f33ecd76e0 100644
--- a/target/arm/tcg/meson.build
+++ b/target/arm/tcg/meson.build
@@ -5,12 +5,15 @@ gen_a64 = [
   decodetree.process('sme-fa64.decode', extra_args: '--static-decode=disas_sme_fa64'),
 ]
 
+vfp_d = [
+  decodetree.process('vfp.decode', extra_args: '--decode=disas_vfp'),
+  decodetree.process('vfp-uncond.decode', extra_args: '--decode=disas_vfp_uncond'),
+]
+
 gen_a32 = [
   decodetree.process('neon-shared.decode', extra_args: '--decode=disas_neon_shared'),
   decodetree.process('neon-dp.decode', extra_args: '--decode=disas_neon_dp'),
   decodetree.process('neon-ls.decode', extra_args: '--decode=disas_neon_ls'),
-  decodetree.process('vfp.decode', extra_args: '--decode=disas_vfp'),
-  decodetree.process('vfp-uncond.decode', extra_args: '--decode=disas_vfp_uncond'),
   decodetree.process('m-nocp.decode', extra_args: '--decode=disas_m_nocp'),
   decodetree.process('mve.decode', extra_args: '--decode=disas_mve'),
   decodetree.process('a32.decode', extra_args: '--static-decode=disas_a32'),
@@ -30,7 +33,6 @@ arm_ss.add(files(
   'translate-m-nocp.c',
   'translate-mve.c',
   'translate-neon.c',
-  'translate-vfp.c',
   'm_helper.c',
   'mve_helper.c',
   'op_helper.c',
@@ -60,7 +62,9 @@ arm_common_ss.add(files(
   'crypto_helper.c',
 ))
 
-arm_common_system_ss.add(files(
+arm_common_system_ss.add(
+  vfp_d,
+  files(
   'cpregs-at.c',
   'debug.c',
   'hflags.c',
@@ -68,14 +72,18 @@ arm_common_system_ss.add(files(
   'psci.c',
   'tlb_helper.c',
   'tlb-insns.c',
+  'translate-vfp.c',
   'vec_helper.c',
   'vfp_helper.c',
 ))
-arm_user_ss.add(files(
+arm_user_ss.add(
+  vfp_d,
+  files(
   'debug.c',
   'hflags.c',
   'neon_helper.c',
   'tlb_helper.c',
+  'translate-vfp.c',
   'vec_helper.c',
   'vfp_helper.c',
 ))
-- 
2.47.3


