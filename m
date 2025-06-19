Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67405C7115C
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Jun 2025 13:15:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSF6o-0005gv-Hw; Thu, 19 Jun 2025 09:15:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSF6W-0004g3-F8
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 09:14:58 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSF6U-00046S-IB
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 09:14:55 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-453398e90e9so5585665e9.1
 for <qemu-devel@nongnu.org>; Thu, 19 Jun 2025 06:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750338892; x=1750943692; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jKb7+45W8wr+DNWypSxWBKVEj0bAIAzVgg/1Er2vy8s=;
 b=rxr+yNa5eBF0qgIw/DtjD31RT+nWC5fRCsQ6qa5h2TmeOu0tuqr2Coo/tUjc144Yni
 hKuzft6AcywGlBl6ji0ynb8P2dMHlfqkwqUOGwBpoejkq13g3oEabGb8/0fIiNom3Wzk
 DbUg9ht1gtZYK8YDBaMfap2FsoXnCGrBGXQMXCpscfYmLcSNaz9irY+tD7WVPff8AVZQ
 pD5PRNDJIzLyTVoUT5bSJSmy4QBn41Db97yC7kT5Wa0nLnvj/J7WIbU8Hnno42utwoex
 hag4/HavIxmK2NnRwspBVpgwr777xee8KqDcZbTQqgCdexi2movhgJcUWfsMAnYO6YzX
 9Gfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750338892; x=1750943692;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jKb7+45W8wr+DNWypSxWBKVEj0bAIAzVgg/1Er2vy8s=;
 b=XRBlXTinRI/r6esw4BPb5fwNwOeTih+4loZtKZfaOHKlvCQWDk050qFPdPfWl4C2vK
 JXLDprFVZfvEBMxkoZlJQOJMapcz4TPw+4Y7p7U0trbT5Cjf+BogSaSdyQx+g88xQC4W
 EcyFC6Q5LXYseqIZKZF8bdGEnJsOuGMFGjBbChY91rsfnF77GwzxhjAUPfcjaOTrqNK7
 abCVtSnReBsjRT9yja5uyhgdjwvmJvg+4djLC73bgoyCi4Yzqy2Q955t0/fo1o52k2Nn
 M6o34Hem7N63/wHObW3ROYUsug64jGbj+6vaF27HkP5DRDMN9bhUti3fYGXuIRhXci1J
 teTw==
X-Gm-Message-State: AOJu0YzPkx9uF8KEZu2mwhGS2WNu5aqkHEo8JE3sqJvSdnPsJK9HNKrA
 6BgGar3xQUSxQQLUJas+BqcwydU1bIFHW8kP3TGBmmEuLOPL1JaV0WcA++x70RLyvNZyDBJlqwN
 G079gipc=
X-Gm-Gg: ASbGnctrL5rxTnmfBPIvokPhL1QD5iRpgZCQk3krkLmMs/uvTKX1nwLq1l17I7/aAAS
 tvcMw3CbCA4zGYi/fJ2FOLM/p9EFuys2efGs117l4cXGPwp+eF3lVz6/olr1sbSe3sewqn+YFj7
 Ai0oH+0el39yv18I6gH0eiGWQJBpj3O0m1gJdWGhNkTJwq4fCwMRkbdN085lcsXd7kN2SGPKLtT
 OPACCUau39C/n3LUvn0SiFXdmy3NQyCVILhZ6KT5yDLi4PCTDhyjRn9+YKsbdxwB7R3QeMZFf9Z
 9oed2TpNLsg0ulBFKs8Ql1EfOCkhKZ69K3117scqt4IA0Qgd+kryDqNcAnMGWsvYuQGuD7cTR8a
 O3EUX30GvHhFUjhtnzjF8skkESxVjyj3D27Hn
X-Google-Smtp-Source: AGHT+IFRzQ9UxBLRQDMQufclV3QAFXCf4Tt17IF9sdJksupv+14Rk4NJ6wBb4VS4a8pKINqsmbco+Q==
X-Received: by 2002:a5d:64ce:0:b0:3a3:6b07:20a1 with SMTP id
 ffacd0b85a97d-3a572e8c1dfmr16026113f8f.40.1750338892503; 
 Thu, 19 Jun 2025 06:14:52 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a568b08a2bsm19821758f8f.62.2025.06.19.06.14.51
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Jun 2025 06:14:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Cameron Esfahani <dirty@apple.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Julian Armistead <julian.armistead@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Leif Lindholm <leif.lindholm@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Roman Bolshakov <rbolshakov@ddn.com>, Alexander Graf <agraf@csgraf.de>
Subject: [PATCH 17/20] hw/arm/virt: Only require TCG || QTest to use
 virtualization extension
Date: Thu, 19 Jun 2025 15:13:16 +0200
Message-ID: <20250619131319.47301-18-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250619131319.47301-1-philmd@linaro.org>
References: <20250619131319.47301-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

We can not start in EL2 / EL3 with anything but TCG (or QTest);
whether KVM or HVF are used is not relevant.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
---
 hw/arm/virt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index b49d8579161..a9099570faa 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -2210,7 +2210,7 @@ static void machvirt_init(MachineState *machine)
         exit(1);
     }
 
-    if (vms->virt && (kvm_enabled() || hvf_enabled())) {
+    if (vms->virt && !tcg_enabled() && !qtest_enabled()) {
         error_report("mach-virt: %s does not support providing "
                      "Virtualization extensions to the guest CPU",
                      current_accel_name());
-- 
2.49.0


