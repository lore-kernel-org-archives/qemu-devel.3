Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBB7DF99344
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 10:04:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFqtb-0006Ou-72; Thu, 23 Apr 2026 06:02:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wFqtW-0006LX-Qw
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:02:51 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wFqtV-00022T-1u
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:02:50 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-43d0deb7ad5so5317688f8f.2
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 03:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776938567; x=1777543367; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=0vNlwteVDyyNcps1mz9G0iinQOOD/sdH2jkjzeJDXMU=;
 b=CpuMrOP8C71Sup5+YkdhUp0sCGaP36s7d84c7N6EbuRPeiHCQinnJT9UJ5scJiby9y
 ml2cqDC06E22SNCkJq36zmt9DHlmh81OexvoK5aEpuXbHy+5amkclDSs5htCf743lKoK
 wwtZdFxK+D5FjqzmKhdnSsXUyrQTPHjkqaFtziutdm219/0i3EVSbknmObRlyvz/eDyD
 dhWRZHtWhjbIvsNScETB+c1uBEIaQVR7Q/tAZTmjT6eXx26s1sz8xCLlpw3HlJFxSnyu
 UGcb7NwFgFGAad/FKKk5tDoYh7FubnONghweszAEKZEomfCeISh8XQEPsO9FWqNxSCFX
 QMRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776938567; x=1777543367;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=0vNlwteVDyyNcps1mz9G0iinQOOD/sdH2jkjzeJDXMU=;
 b=c9HQGBT6RqLDUkzLhWYnCds5zdJY3F0fMnuB+OcYwkd9w+4l5s+dEhtL3GVs3+TbNp
 p2qbcBjhil3VZf7HMCEwT3UMMK5z+L9xGaF+8UP3uvSm+vTltE2Zqwro7JkbeVKtdOOE
 wX1B9HsKi3aqcKwbOxDD4LfS10MiVv7LixczibliEGe1YVamzma0rUHAhWcDlzHEHgQL
 Zy0+9QgH5QDo5MB/Aa+LNtPC55SPjZi5u26Vk04IFenwSYRccPACuAml47liozYDrOdX
 K7GMbuZPbK3M6koTJW05AgZGuS4H5Vlu2UOxdTFYx6Q8P4iWWCwHuwJlJ1zxhu7CxPbZ
 dvzQ==
X-Gm-Message-State: AOJu0YyxaHKUF3CkW1DXlGjeghjx5yrWI5ZgMPLqkVjrc9hNoim4k5aR
 TgNfIOK6ntQm08dfZ6uV3y/WXluOHrgbiWN/qAChjkDSvLYRlppktsn6m4N4Si/BqE9MwChjxEU
 WFdWR
X-Gm-Gg: AeBDievjwpiWrvkk8p/Jp9lkN03cxopXpv7fwg7BcN99ilhjrfowJCbKhFFtOpDZGkn
 Ejn8eyQPxTULK4LiApRJA/j6+75OL/FGoaNWLtsoBFIQaiEZsvSRcInGlwlrtYcGUYReU2fyi9b
 wYsbJzetbsjqLBRzS5tRjSoHqAfCib3iAuNw3odOWl7hWrYFujeiK88teURmNJZVyiswyxlCn8S
 yLkL4aCKE6BOVFA/yyNCrt+geB+9L2A6tUSYthk39lfgPyjG6E/INhNOkOhQeWZ+0enGNDJiVs6
 +1IObj4P8R6sU9KEY4TAHi9DGSF2P0cpIK84XrJKWYd2j9nXofcCP3qT+wxboZRKg4Mb+DLH6S3
 mUa4DlPxiHoQIU9h5qBgJ5FjooLCTYpEt0Tf6ZVFsS2u3qvajlnzOjm7p9Q9cEU1FeZU79xdrTN
 QSyPy2qG1I6TDnMvjgKh6slc7ttIHJdZRdMck9RN2tBHor7gZTxomRTHxWZmeazxnPdABgb5Dgt
 QLtV/m1uAysEe1bIm1lbQP9CC9fsU3fp55qH4aOTA==
X-Received: by 2002:a05:6000:2312:b0:43e:aa88:f1a6 with SMTP id
 ffacd0b85a97d-43fe3e12c58mr41258783f8f.45.1776938567253; 
 Thu, 23 Apr 2026 03:02:47 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e4eec9sm49323930f8f.34.2026.04.23.03.02.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 03:02:46 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 15/59] target/arm/tcg/translate-neon.c: make compilation unit
 common
Date: Thu, 23 Apr 2026 11:01:45 +0100
Message-ID: <20260423100229.2941820-16-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260423100229.2941820-1-peter.maydell@linaro.org>
References: <20260423100229.2941820-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x429.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-id: 20260407222208.271838-7-pierrick.bouvier@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/meson.build | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/target/arm/tcg/meson.build b/target/arm/tcg/meson.build
index 5f33ecd76e..8d9112f6da 100644
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
2.43.0


