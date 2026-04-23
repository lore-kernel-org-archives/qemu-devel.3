Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62F54F99368
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 10:06:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFqui-0008HE-FG; Thu, 23 Apr 2026 06:04:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wFqtp-0006Tq-GC
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:03:10 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wFqtm-0002Ar-W6
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:03:09 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-43cfce3a195so3770956f8f.2
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 03:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776938584; x=1777543384; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=K4l+IFtIAZGJNbd2OJKmbVo/QSAmTyKQLiCnarILlNU=;
 b=XWqUhNP3gDLVV6tjAKlMTVOsk9vM2lqSZ1SnzI0Wulap4/9+kEmb+cyZvUy729oRnX
 SNCxrrlK2jRehhKhLDIbKAMW8RwbXXHNIjiKKbPD8rK3Biuq6O+5ioy2AE7KbTeXcJoD
 vuoqoTvcsIz90h8jT+MzsZh7p/L9Ns4f9Xqj7/m3Ptq5XDgu3YEUh5H5Dc8vrt1lqsv6
 50zsZXVb0zaL/TBkiebmgoFwPRssleYI0aLeyT4hdV7pYt4f2EbEhYyjT8Ok61QYGUk3
 /LRP7ueiUuluShrMdhcKeHwYO2KRN7wjzEOlYA7MLKyyorHGxkHceCERLJfwMNjTaq9p
 qtRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776938584; x=1777543384;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=K4l+IFtIAZGJNbd2OJKmbVo/QSAmTyKQLiCnarILlNU=;
 b=jbTBK95NR/+fb2HCN1oEwv3FPRtvrS1IiQS7/BGcpsN7VBTpFwQ542YqmxTZpcu8kE
 8Hej8j5BPy2k7hl7NmV1XxVGsgkGpxGVvrHRR0ALN6g7SoLUZhv/GpG6uchDORB+Q4Aq
 ZBOS+SXnkeM5Co8yQq8E2UjjFyIIdE8ERTRloVhdTkZfu8bAd9ZT9XnnfpqdkxC4KvIN
 xSiRiPlbt1iaa5h7EjyVZFUTx1bDFpFCh2Z1IUaYFcXs26rFIQzScWkCiN+c4Pav4QHK
 6sW2F4zTpV1ePtxYJmyCEslG5y6YvE49kz1gcaypcUt+fG96+iMgisHFGn8Pkix+DMql
 ZdrA==
X-Gm-Message-State: AOJu0YxUFEgyZ5dTjQvIEB1FEPUI6WRkHqzEBWvBgYLm7wVfMRMMb+1Z
 Sj6z3arloDXz4fnLvww6zjc9K3doSLP1RIPQ396zakKKf2BqpE3Bi708lMoMc/o4cgdMeYALvq3
 BNg0I
X-Gm-Gg: AeBDiesfskGDbRbs5/4l76XF1GovrcTlHpaZryBjei1/rBjxVuNVXiPod1D1F+xsKh1
 qevBZX1RXxgoli/pWubaGMoaoYmF2BnDMeH3SHPDyjaA8UUyjoLhRFasdMu1CTWNbOThAJmCeV4
 I9CXuWIEHRIwbEp8zmr0b0BLAbmSYBHUvfYsLs+W3sDXifynBXvBaOWX8esLgU2VQSv7332igwy
 pLbk8YE5F+5NsXzv/GFbNZxCYaGGkmYB/ol7rfXdQhbih1EkEIqu9eysbnDG4SZH7depopPwjM4
 ygLK8wyi8XjOE4Te2AX0VGhSkXL+TtnNqP8wdskB6Od4fScSwVurryn9LlAlyE6YR8yBxGwM4Q9
 /6mANDci8pb+1q6MWxVnqYFoj5P8pNqLYCaehTZjFFDql6ddl5tZcmGgs3NmRV115fcWy0/p6AQ
 yu9dYhOr7WAJojN7aVe52dsuYBhoGGM4I1+y0sljo3YhfoM5MArk6bjC4KGSilx8ZyE5E1C8kML
 CvTHUbvLyf0MjTgfvPQKNgRoyiA8AUtrkwFOm+S+auWUih4EP2+
X-Received: by 2002:a5d:5d88:0:b0:43b:80a0:d92 with SMTP id
 ffacd0b85a97d-43fe3e0ba4bmr42161503f8f.45.1776938584225; 
 Thu, 23 Apr 2026 03:03:04 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e4eec9sm49323930f8f.34.2026.04.23.03.03.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 03:03:03 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 30/59] target/arm/tcg/translate.c: make compilation unit common
Date: Thu, 23 Apr 2026 11:02:00 +0100
Message-ID: <20260423100229.2941820-31-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260423100229.2941820-1-peter.maydell@linaro.org>
References: <20260423100229.2941820-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x434.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

We removed all target specifics, and can finally compile this file only
once.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-id: 20260407222208.271838-22-pierrick.bouvier@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/meson.build | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/target/arm/tcg/meson.build b/target/arm/tcg/meson.build
index 0740de92c1..506f031f1a 100644
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
2.43.0


