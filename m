Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EF50F55449
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 03:47:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vv5s0-0006Wf-Py; Tue, 24 Feb 2026 22:47:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vv5ry-0006Vt-T6
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 22:47:26 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vv5rw-0007kO-CV
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 22:47:25 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4834826e5a0so76411465e9.2
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 19:47:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771991242; x=1772596042; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=vJq942fD/Df/iDSp0RynXY9ETFe2sy1oPhW/bPRR88I=;
 b=Sgcc1SfWAOKANBHhvu9gWjBtyScTMqPZkXtxJcpyhJfUTyD3/VltWZXb4+ED4SX52L
 2DkudMW5zxLxs2f+q2EEd8/5j1psOYkZNMxCew28SpnQ4V+v+XowpK4gFFviI9U9i4g/
 mgqu9ry0EnQm3szDJnL2OWtNeXneVocGBDCmHAE3XrHI//fKVdm594t1UBv237hDExtL
 LPimTQdMTpBDWYqPwquFK4N4BGjOFO4aUiJDHcKLULwfQ4FAV4HmSrrwjmdsPytyO1oe
 +hQpLLLOZCAt6UFcaw/WpjA6Li9DpIkVbdqYvI4w9xaY93CW09Kdj2StXt8i3nRbW2en
 xUxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771991242; x=1772596042;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vJq942fD/Df/iDSp0RynXY9ETFe2sy1oPhW/bPRR88I=;
 b=goA+XMyWcQRycjoNi8zMfYbDYNkHDl3RP5qO6InzHSmGkdGsa95NoZRU76vx9l4a/6
 v8UiUV1PUHaBTEtTTiyi6a4V+4z/5Y/ibmaiI0a2HZTLa/B32JdD3EWUqbqGGwP4w+5W
 JK+mifEo2tN1xOsI11ePCh3IOdJmWUIMuygvWr+gtUv252gWlFbnb/n5HRtO3SM/48+E
 zI75fjYkw8uBOEKIxEZThqU7v9ug9dci2S+CFleT9ismt3J1Z/326CK5mOLjLsmxSUtw
 AP2RxSZV2yIWHw0j2NXULB62wzwjiGhYZRlrnabJEjY73AQEyVzdik3ej5c/1OYzhUOZ
 K78Q==
X-Gm-Message-State: AOJu0YxDyngVSPGuIA8aZ/exiGmrwiMoC+jTsiI6AKKWzufGG6b8zqhi
 V9PV7gtioVujFMzX137fk1P7bVKgJ/4KxSW7jA6mCocRBOAAipSt11Mbjhq8ZmySNYlte4iy5El
 z32zbjSQ=
X-Gm-Gg: ATEYQzxJZH/+VsETzfj3pvyQ3OHHAgpSf7fstHmp31O7BD0AczvzCgr2xOgKcsHfpDG
 R8zFo5Uv/k9iRBhPB1L15ALKzrVnq8VnEOb1ksA4IUk/Q8aOO258FSv+wo0OQn3ZChKAMaUsO9E
 MLzYHaO4wsdh1mZPOZ2gvmycLIc0P6ARJzvZEnV/TOtGegzVQaWrlF3xBndJfbUv1ylObhBY0Qq
 Rvjar6nTijtCn2OSbBEoRX3FpuWhWlvAEiK4J3Nm0LrZGaPzNFFhnVBNQouGpBX0ycf50qUgVgU
 ZzEtosRuvt9DQi4BpNFPBmtxqDUu1Be6fYuV2KGBJfijvvayvLyu9i1+ErgSjuqdlY7uiCYioFi
 k54QqwrU/wG7Pl37RgcFXqxi4WUpKoXgiBDC/HKcMAaGyUfnH++KFURqbBIp3x8liNtk4pBLPsp
 efKWS2BEB32sSWQskU7DyxuDHGUoKSKh9qY0s8P59k9PAErLX52FhaytdDRXewXfBeCoB6YkpI
X-Received: by 2002:a05:600c:821b:b0:483:71f7:2794 with SMTP id
 5b1f17b1804b1-483a95c9e73mr259568975e9.15.1771991242277; 
 Tue, 24 Feb 2026 19:47:22 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bd72bd66sm37582405e9.11.2026.02.24.19.47.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 24 Feb 2026 19:47:21 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Beniamino Galvani <b.galvani@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] hw/misc/allwinner-cpucfg: Remove use of ARM_CPU() cast macro
Date: Wed, 25 Feb 2026 04:47:20 +0100
Message-ID: <20260225034720.41495-1-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

allwinner_cpucfg_cpu_reset() doesn't access ARM CPU internal
fields: no need to cast, pass a generic CPU pointer along.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/misc/allwinner-cpucfg.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/misc/allwinner-cpucfg.c b/hw/misc/allwinner-cpucfg.c
index 3a1526bda0d..f8dbfdd120c 100644
--- a/hw/misc/allwinner-cpucfg.c
+++ b/hw/misc/allwinner-cpucfg.c
@@ -84,7 +84,7 @@ static void allwinner_cpucfg_cpu_reset(AwCpuCfgState *s, uint8_t cpu_id)
 
     trace_allwinner_cpucfg_cpu_reset(cpu_id, s->entry_addr);
 
-    ARMCPU *target_cpu = ARM_CPU(arm_get_cpu_by_id(cpu_id));
+    CPUState *target_cpu = arm_get_cpu_by_id(cpu_id);
     if (!target_cpu) {
         /*
          * Called with a bogus value for cpu_id. Guest error will
@@ -92,7 +92,7 @@ static void allwinner_cpucfg_cpu_reset(AwCpuCfgState *s, uint8_t cpu_id)
          */
         return;
     }
-    bool target_aa64 = arm_feature(&target_cpu->env, ARM_FEATURE_AARCH64);
+    bool target_aa64 = arm_feature(cpu_env(target_cpu), ARM_FEATURE_AARCH64);
 
     ret = arm_set_cpu_on(cpu_id, s->entry_addr, 0,
                          CPU_EXCEPTION_LEVEL_ON_RESET, target_aa64);
-- 
2.52.0


