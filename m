Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8233BF46C69
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2026 18:30:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9oej-0007R5-BB; Mon, 06 Apr 2026 14:26:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w9oeY-0007L4-Qw
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 14:26:28 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w9oeX-0002MO-14
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 14:26:26 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-c76b9efc299so1658639a12.0
 for <qemu-devel@nongnu.org>; Mon, 06 Apr 2026 11:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775499983; x=1776104783; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uukBbBYYNyrggNOyo7VdnlUk/PBaz4ldLT648BT7MPc=;
 b=JdoyJ59I+Ot9fdvJUjNsEH9saVBqHnqbHc3p1Vz2ro/74nVDoGON8zEvA77c8Nlsmi
 qXwLgin6Rr731HmyzgBij+pjlg38QxsBf6TUzHCKgO+sdAVaVN749CAqAxpe/KOehZ2S
 jG4YxTwFkeLffDCDJZteXixo9rHAVRJo3bNHhkr9bHUNk6UguegSG4LteBzX2lkp+4S7
 JJbNAk3YuPA6xZh59QrLJfWfe3mpL4j58ZJsjAHcPajLnBREwxw3kRI7qYfUyIcR+fB0
 iSyBA7p5eTsF1LwNGBljmppNTsJcDg6+WFfqZV9zdCQ5tyWu09Q4/T8YdxHgf+yAioOS
 QcZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775499983; x=1776104783;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uukBbBYYNyrggNOyo7VdnlUk/PBaz4ldLT648BT7MPc=;
 b=o6WS6ZFieaRWnvcWt1xdducYq50+m1c06oNAnmBmZ2+DocYwAdeHJHFtneB2vLRHUW
 gbi0MR/rLRtYyglrg0FGS5aspR8NnKlJkOBNdsLDtNzYePLarOfCKoVeevMTAUm1RzxW
 FK5joDhcsQvaz+fIP1RZijHiLLOvoiZjNfddaLlNmwNsGyXQSCWYGrkbA7bp2WFW6WV4
 PWXpsrX0yXBTG3TM6AKtoldeKcFQjpOhRzQlmQrVET9UoeOjUKm8rICxyyPhvrX4Ofgx
 UtZ9G1TfJtTp0FME3v0RXw1tp7F6CmhK9filEWjvviNqIbnz8tJEDn9V8PbRJAca/1VX
 bK+g==
X-Gm-Message-State: AOJu0Yz+VI2qeLEYI98VrWq/7g67xJVPzINNgqj7wVf6rqDh24UlGTEL
 uZ0TTP7emIWzsRaEGsAi62BsgmyRjTpfh3cbid5/axSTSYuo5Z/O1p9RdhlafquRRrPGxW3Dx8u
 US0vxpZTgmQ==
X-Gm-Gg: AeBDieu8EsjkgWWEfdGYerMefuxoJ+SoSggrteTL+Cr6ZUWjW9B7Od8+H5pJ+RgcrWU
 NvzXOJwZ1LYfXIkIubWL7AWTXnSfUACRGFu+4Th8kAZDTLM+Jh3XQqHKabVm6AqhtaNFgxT9kMG
 NRLpzcEZgjceBYRxIEpdTXm1jdys54OFjQZTvpA6NEF8q43HzSXR4G6cqtnki7JAxTxNHsQ2eHZ
 jom5Ei1t5UDM9ASQ18ZhFKLKl4MMkv60mdWjZfkltlJV0ATnBn6C06uDxT5HzUVEr2YALLtzxUt
 1a8hIE/4apwB5AXDY+YLXTQBsdod53wNxO9AaksyMSffm54BRgmBIhXJ4ZarMCpYfME+Z0DaDIE
 OzbUYuxXeHhhsiGaA/DN3aLJ/NViqCf9xZL8EZGbS9dIeNdJ7EOSMoTNe5QSdfg2E0T7x13uhfn
 mESYJqzLUImoLOTVhgKD5xf6jES/yys3PF4W0DzlZ8tyBk+oHBMZokJ0R3w1LO6HIzVJpoQqRe7
 D/w
X-Received: by 2002:a05:6a21:3285:b0:39c:235:c5d7 with SMTP id
 adf61e73a8af0-39f2f01ecadmr14259282637.39.1775499983483; 
 Mon, 06 Apr 2026 11:26:23 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c76c6561fe9sm12765080a12.15.2026.04.06.11.26.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2026 11:26:22 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, jim.macarthur@linaro.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, philmd@linaro.org, qemu-arm@nongnu.org
Subject: [PATCH v8 06/20] target/arm/tcg/translate-neon.c: make compilation
 unit common
Date: Mon,  6 Apr 2026 11:25:55 -0700
Message-ID: <20260406182609.193886-7-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260406182609.193886-1-pierrick.bouvier@linaro.org>
References: <20260406182609.193886-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x530.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 TVD_SPACE_RATIO=0.001 autolearn=unavailable autolearn_force=no
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


