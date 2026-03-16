Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83E14F46449
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 10:45:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w25PO-0001Zs-8T; Mon, 16 Mar 2026 06:42:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w25PL-0001RM-W1
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 06:42:48 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w25PK-0003fz-A5
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 06:42:47 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-485345e1013so38696385e9.1
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2026 03:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773657765; x=1774262565; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=TLMANJaYtmakghraNfyv62mr3wE3UT5K9PY5HJhOBc8=;
 b=UF5FNWY4jGPkdW6gLUcGi1qULE66gs9NgxjL65lkDFPpA5I48qr0JWscXQJKVehjb8
 c6m5hqaADDtIUWFnU6dQ565F0/xXAEmo/U+9cOKGgDNObdSQvOb3hC4OPjpPdrPoWR75
 9ztIb80xFRM9NgCXTCLFhXedEWFtnTzpfUJoEsPb8ctdcopvAQSBlTJYVnoAxxulLNTc
 BaSs7GeibgvpxpeR7ec4ALBjF2mzB6UbAZLB3TIM9dJ9S+3gyRUMCgfAcUNc+SRAn9Xd
 HraV1eyHi4VvvpQ3ZuYBSLd2Xklxg88AAs7RvcMRpUOkeEG9Nxiz6adTJ8nLsBhQJw2S
 EZiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773657765; x=1774262565;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=TLMANJaYtmakghraNfyv62mr3wE3UT5K9PY5HJhOBc8=;
 b=nlcbj5ESecgYGj7LIovSUVc8j0SA/JPxBRnGGr/TTumrwOniuSRBaGhibiuqtLcTdr
 7/X5fZ1+ZCAwQsCL0pmsHWm/HIS2fcTlvoSNUZ1pXuTIrB8wqn2ZOZcL7pq5x5gwldAw
 SAO7jqSRtG7g+sRBHjF+bllAIQX1blRO+r0QHJ4Z4VAM2GxrpJzkg0sTGLEsk1iDCOXx
 1suvkir828yVhRym0FN/GKXOvUTIChjzt8rZmRB00eDbB1Abg9HHppf81S8ndBR0Vd0D
 vga8Ug+j0FdfFW8u3vDJo9dUUJgznu5iKYstXnCaydOmGoI40pCOTPbAyVQQhGrFAD1j
 gF+A==
X-Gm-Message-State: AOJu0YxrBUf+MaLd+X66PAO5qfgawJ0mFOEUmLX3ZNzspPFacOrE0H9Z
 XHL1I2QAu8vPP9xOMJvNXDQeGSRSO7fGlbB7jEzXwZdqyAC7j6DeQECFsanKBn8mBzgscBagNS2
 XiuEL
X-Gm-Gg: ATEYQzydNOikyV4wyZUWLWPhG1nrkbJSaHoqy6zKt+HVTB9dn52R4akp3x/06m81hMJ
 apgEJvlkBboVCNrU4spfoB8AQBCFo1yn38GrsqcEGvyMfTAfoVZL7o4b0zSKrnCVNUVB9rT4yAN
 3ACnW4EzlbEtuSHeFmnE6tllsO7QkJWLBybKJVhe+ZeKWEDayKMIMnVgynb+A2zO0f0Ygh691xz
 faubdYFHhJI0X/fVs8WqM06nAzFnvL8DNYqiXOWH3akFiwQDwCQ42m+sdis/Ee0nygiBQlhe63q
 PQZIp+Pk4jWTVG/GJ2kJOcLCs4yujdGSM/q2rKNJU5fEhue4MkEG/vD2gk/nKqDlx4t62ACbnwD
 7mrkDWjzQtF098MsUldjqTzBatdZCbVwPbbjoRI8RYnLFveqvfkt1AaZAcM+EeaovxXXAnsBrV8
 fexaPHbgxEYjSdd/3rgpiJllxr6nMG8l/BCHWabNOvQAKLVMIzQMgdhqKm3MmehGzWcmrLsX7vg
 wz3800OMFU=
X-Received: by 2002:a05:600c:1907:b0:485:50ac:b8cf with SMTP id
 5b1f17b1804b1-48555a5689amr203121575e9.0.1773657764722; 
 Mon, 16 Mar 2026 03:42:44 -0700 (PDT)
Received: from lanath.. ([81.2.115.145]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48557a74266sm85519135e9.17.2026.03.16.03.42.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2026 03:42:44 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 10/17] MAINTAINERS: Remove Eduardo Habkost
Date: Mon, 16 Mar 2026 10:42:23 +0000
Message-ID: <20260316104230.836962-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260316104230.836962-1-peter.maydell@linaro.org>
References: <20260316104230.836962-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
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

Eduardo Habkost doesn't wish to be listed in MAINTAINERS any more;
remove his email, and also the git trees he used to use.

Move the QOM boilerplate conversion script scripts/codeconverter
to "Orphan" status, as it no longer has any listed maintainers.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20260306120555.2035421-4-peter.maydell@linaro.org
---
 MAINTAINERS | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index f2ee7988ed..71cd07acf1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -422,7 +422,6 @@ F: tests/tcg/sparc64/
 X86 TCG CPUs
 M: Paolo Bonzini <pbonzini@redhat.com>
 M: Richard Henderson <richard.henderson@linaro.org>
-M: Eduardo Habkost <eduardo@habkost.net>
 S: Maintained
 F: target/i386/tcg/
 F: tests/tcg/i386/
@@ -430,7 +429,6 @@ F: tests/tcg/x86_64/
 F: hw/i386/
 F: docs/system/i386/cpu.rst
 F: docs/system/cpu-models-x86*
-T: git https://gitlab.com/ehabkost/qemu.git x86-next
 
 Xtensa TCG CPUs
 M: Max Filippov <jcmvbkbc@gmail.com>
@@ -2015,7 +2013,6 @@ F: include/hw/i386/nitro_enclave.h
 F: docs/system/i386/nitro-enclave.rst
 
 Machine core
-M: Eduardo Habkost <eduardo@habkost.net>
 M: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
 R: Philippe Mathieu-Daudé <philmd@linaro.org>
 R: Yanan Wang <wangyanan55@huawei.com>
@@ -2038,7 +2035,6 @@ F: include/system/numa.h
 F: tests/functional/x86_64/test_cpu_queries.py
 F: tests/functional/generic/test_empty_cpu_model.py
 F: tests/unit/test-smp-parse.c
-T: git https://gitlab.com/ehabkost/qemu.git machine-next
 
 TargetInfo API
 M: Pierrick Bouvier <pierrick.bouvier@linaro.org>
@@ -3446,7 +3442,6 @@ S: Maintained
 F: backends/hostmem*.c
 F: include/system/hostmem.h
 F: docs/system/vm-templating.rst
-T: git https://gitlab.com/ehabkost/qemu.git machine-next
 
 Cryptodev Backends
 M: Gonglei <arei.gonglei@huawei.com>
@@ -3549,7 +3544,6 @@ T: git https://github.com/kostyanf14/qemu.git qga-win32
 QOM
 M: Paolo Bonzini <pbonzini@redhat.com>
 R: Daniel P. Berrange <berrange@redhat.com>
-R: Eduardo Habkost <eduardo@habkost.net>
 S: Supported
 F: docs/devel/qom.rst
 F: docs/qdev-device-use.txt
@@ -3572,8 +3566,7 @@ F: tests/unit/test-qdev-global-props.c
 F: tests/qtest/qom-test.c
 
 QOM boilerplate conversion script
-M: Eduardo Habkost <eduardo@habkost.net>
-S: Maintained
+S: Orphan
 F: scripts/codeconverter/
 
 QMP
-- 
2.43.0


