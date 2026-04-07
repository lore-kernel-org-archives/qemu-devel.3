Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B016FFF5138
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2026 20:00:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wACaP-00046H-QS; Tue, 07 Apr 2026 15:59:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1wACaL-00042W-Gc
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 15:59:42 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1wACaH-0007KI-I3
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 15:59:39 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-356337f058aso3085611a91.2
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2026 12:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775591976; x=1776196776; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pt4XMBpnPMV9xBPksdczSsyXltFdkMDiM7rgCsFJ8VA=;
 b=Zu8ktgEZfcMJQBZcC243T9Zttw31n6JR4uGV3TZ0TSV+tdP/sPANjaEoCB6PXPIanL
 a37r96hdsObzLWWCcNv0BEGKSdQInJvaHVfpljwN3KGd1L7WDYh+neOFYt1aDxXnwwob
 yAid5ht7BGlDTxsQ/2yAvGrebnqrYNgCWUvBfoYoTrXMB/oxhHNUyvb/Y35BQMNyFaui
 gUMwqs+gYzvca2iw5fpmDa8HRB5KWQHcECpyQqTzLmgpwUHWmGkoMuuxsBGESH/B6f1R
 S9agG8+F19/M3ev+K5mxxc/oaIytKW0Acam9YqDElwkNXomqvXh8tLzZJHrAWiDjSHXf
 oN7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775591976; x=1776196776;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pt4XMBpnPMV9xBPksdczSsyXltFdkMDiM7rgCsFJ8VA=;
 b=e6xrx7q+m6G0OUCzYDdUA8v1OvVQqX14sKHmhdwj0hmZEPuVvlQ+2vptUeIre1QGvK
 p6Lv1CLRITEcknRygr9gBPdQqWtoDuBxgPwet8Qc2/mF8N6uSmUO/uGS3uBunfk/e92v
 biZo8wI24b2N7TlRfqgJO3ewBfiXySKtUkmjL8jSnLyXEOPyNzpl21f8TGrIY0c1zYbn
 +ZnQNGHTVv3s1/pTOS3bGBLDvI7sh0yn+fgS/OkGvXCWIcO2yCvLJv50UBCiVmM6L5HB
 gOYHYdqSCKIqzdnRFkH6jWE+nuxAfp2qzA5PSrNwX19dgMvXcRRKa2vJcIplHujXXF3j
 GAuQ==
X-Gm-Message-State: AOJu0Yx6K1DrmTaeKhpkctS4YxT/LoFfQPtl+2Op664nlcPkNMqhBweN
 XP4eavKe+eIlG01UBE3ZLOdvJ9S2A8uw6gB5v6wFNtBQOOKLrjHr2HFWJY7vuiJkMKDhZ/tDDnC
 M2ua2KxQ=
X-Gm-Gg: AeBDiet9o9rGRm6+kH28037LLbwHYgBaUEdZEscGPo+28kXxYfm5qHZsSpOgyJWFlHI
 D3aa0QYF82e9nZgh8Sy1u+wZLg3sft5cj/QGEoYqoyiEGH/tm/w0qtW2CDIvPBtFeD7VYtPhfZe
 9hUY1UpgQ/NW4M7nltZaAPMqPA7o61O/HK1aoN6EqtH7ZN2aHwRAg+IuY816mC2MQ+aewlJfLG/
 XdSS+e3LY3+iBREtMgjf1N0Zjf/p4oawMyKCZP8OLKJHOHO4UjDEBFyHSNgWgPzP9fRwIIt9/7t
 URthx17cYXmiCvBsxQp//LlZGFroxxFya0o4BGt7hWeGheitk0yh9x7nK8dHJgwF0GgtBWxf9C4
 bclerTWKVg756S2/3ytMoB8IeRV/Vh/CWy8+SPzsyXT0cePHv8KdHi6usQe/3XvZ8LzTMILszdu
 womSo6T7WvMEo6zW6RpXJuoVwVOyZ0Lt1VXkLrJrZohST0tf7cjLUwzawQT6yymjp0R4tNOl9Dx
 TKp
X-Received: by 2002:a17:90b:314e:b0:35b:e551:90d2 with SMTP id
 98e67ed59e1d1-35de69b28c7mr17435284a91.28.1775591976159; 
 Tue, 07 Apr 2026 12:59:36 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35e27c9855csm126911a91.3.2026.04.07.12.59.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2026 12:59:35 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, jim.macarthur@linaro.org,
 Richard Henderson <richard.henderson@linaro.org>, philmd@linaro.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v10 06/21] target/arm/tcg/translate-neon.c: make compilation
 unit common
Date: Tue,  7 Apr 2026 12:59:07 -0700
Message-ID: <20260407195922.196410-7-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260407195922.196410-1-pierrick.bouvier@linaro.org>
References: <20260407195922.196410-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1030.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 TVD_SPACE_RATIO=0.001 autolearn=ham autolearn_force=no
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/tcg/meson.build | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/target/arm/tcg/meson.build b/target/arm/tcg/meson.build
index 5f33ecd76e0..8d9112f6da2 100644
--- a/target/arm/tcg/meson.build
+++ b/target/arm/tcg/meson.build
@@ -10,10 +10,13 @@ vfp_d = [
   decodetree.process('vfp-uncond.decode', extra_args: '--decode=disas_vfp_uncond'),
 ]
 
-gen_a32 = [
+neon_d = [
   decodetree.process('neon-shared.decode', extra_args: '--decode=disas_neon_shared'),
   decodetree.process('neon-dp.decode', extra_args: '--decode=disas_neon_dp'),
   decodetree.process('neon-ls.decode', extra_args: '--decode=disas_neon_ls'),
+]
+
+gen_a32 = [
   decodetree.process('m-nocp.decode', extra_args: '--decode=disas_m_nocp'),
   decodetree.process('mve.decode', extra_args: '--decode=disas_mve'),
   decodetree.process('a32.decode', extra_args: '--static-decode=disas_a32'),
@@ -32,7 +35,6 @@ arm_ss.add(files(
   'translate.c',
   'translate-m-nocp.c',
   'translate-mve.c',
-  'translate-neon.c',
   'm_helper.c',
   'mve_helper.c',
   'op_helper.c',
@@ -63,6 +65,7 @@ arm_common_ss.add(files(
 ))
 
 arm_common_system_ss.add(
+  neon_d,
   vfp_d,
   files(
   'cpregs-at.c',
@@ -72,17 +75,20 @@ arm_common_system_ss.add(
   'psci.c',
   'tlb_helper.c',
   'tlb-insns.c',
+  'translate-neon.c',
   'translate-vfp.c',
   'vec_helper.c',
   'vfp_helper.c',
 ))
 arm_user_ss.add(
+  neon_d,
   vfp_d,
   files(
   'debug.c',
   'hflags.c',
   'neon_helper.c',
   'tlb_helper.c',
+  'translate-neon.c',
   'translate-vfp.c',
   'vec_helper.c',
   'vfp_helper.c',
-- 
2.47.3


