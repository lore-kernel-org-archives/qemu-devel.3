Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF6FCFD88D9
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 01:40:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w08XO-0003zd-PS; Tue, 10 Mar 2026 21:39:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w08XL-0003xY-33
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 21:38:59 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w08XJ-0004q7-7E
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 21:38:58 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2ad4d639db3so60209365ad.0
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 18:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773193135; x=1773797935; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=svowva0ABp9HYKqRY27vri3pWPCVq+NsD0KSRtTlAy0=;
 b=L9WHQiCU1nkN/FYoD5iPvPlVUDVz0E2KC5KUQBaB+T49jZ11kO5mCjMoOvckzZ/cKS
 4oQ+h/FQUDmTf7J/qLR070fDhh3NupHKojYICFysqqWWiTeTl7UZ8IGrdj0aCtEeSTaM
 R1q9/Z123GWcOzLm0E7gx3qnHEvNdb5yc6fqmM3T0OJSbqIsrXRpbrlF72nhPSIqTtCs
 7xC6gLNHnAF8dPBFV9MDV2f7AIdpTOYhcNpwOw6tppekMuSgZ3uAJe5WPvikrgQB2ss4
 5doi5xHh4qlegjYbXvGVQeypa6iO2S2F0roh9DbX0Tj79phitN6ciFyLGsnmF4cZkPSc
 /wcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773193135; x=1773797935;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=svowva0ABp9HYKqRY27vri3pWPCVq+NsD0KSRtTlAy0=;
 b=nAnYi2CWewxYGTMA7l0junYWzaQG9inFljV2HSGAoyQY8JMo1TRtKIzxDWCJW491MH
 A7VK9Jw7tNcmpA4lwn51/NEBJHLhHAvvM8/yYJX6KOPzzYX7eu20d7gNChib3dwNBXNv
 ttY9MmGSfwhVCltK/DxUUVmZpzYUHKJOtGTmjKONHbZZV4dTgci9P+gf7cA6lt5KFq9y
 /Z/8bN+Vwy9ahqFUzZFOnLdpVNunOJKt9U744S6We0/p+Wew7jpulj25xmThCbG0D6Dq
 05wkdHiJ/16Q7zklx6PKmjy79EQREJyBPFbMyzrH3gMzqHJ2Fc+1YbFV8/xVaavoFYQ8
 cJnQ==
X-Gm-Message-State: AOJu0YyJdWK8536KGFPRk9E7JHcxFhogkaH5WzPzAftv2oK4UW3W5fpK
 kwro5M5dO5Og9IsxQrhuFNqWM/dw5nvYmfFNspWvjb54E1CH4oBYh79WATOTegwaIdAlXkSNIdA
 21gat
X-Gm-Gg: ATEYQzwjarz2Mr1jMTe1b951m/6yFCSYW/3lHmGDwc+VLY2F34k3a+oC1Np44Y7xU9S
 FODVJBmiEMV2XoOJGxIg1o6umw4+sVPVanEPf/+SbNNfRjF/Yt1cGhIPOOV6ksRfjqLNRaeTmPp
 acrBMlLLfVwXzo+Ks1Y81/r63ays+jpCUccxih7tUivRcvjYbSaNAoJfAjbooK2oRV1NLmeWvmF
 MTwDAktepCT4j+vSMN0TSH8/w4HYcSu51hONtyGV6bRq+nayItlQI7v/pzthcVjFNWLaOlewjN8
 sH+tWPe8G5q3jBOhzu49z0q1HVcsHwpI52/tPQsHgv3V1vwO+pqBzCl7CrcD1S4YzeKIXRHiKX+
 skeNQdnMEjfbqgcAZwFOmJ6gYwtDjstT18SNr7suvWvCOEGVCp3P6VZY62mywnkl4Sl5Pkh9y8M
 1+xamzMyoilE5+3Le8jMh4PIF1kAWKFeI3erwxGxn+qO20dFMXOjFnOWrp5gvhgUqUERzhtSIv0
 KAX
X-Received: by 2002:a17:902:ecd1:b0:295:560a:e499 with SMTP id
 d9443c01a7336-2aeae78c845mr8367615ad.5.1773193135466; 
 Tue, 10 Mar 2026 18:38:55 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2aeae2466d3sm5390175ad.22.2026.03.10.18.38.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 18:38:54 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@linaro.org
Subject: [PULL 08/16] gdbstub: Have scripts/feature_to_c.py generate more
 verbose output
Date: Tue, 10 Mar 2026 18:38:29 -0700
Message-ID: <20260311013837.69945-9-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260311013837.69945-1-pierrick.bouvier@linaro.org>
References: <20260311013837.69945-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62b.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Make the structure field names explicit, so it is easier
to figure what is what when reviewing multiple entries.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Tested-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Link: https://lore.kernel.org/qemu-devel/20260310232045.58440-9-philmd@linaro.org
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 scripts/feature_to_c.py | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/scripts/feature_to_c.py b/scripts/feature_to_c.py
index 3aa62fb895f..1329695ad04 100644
--- a/scripts/feature_to_c.py
+++ b/scripts/feature_to_c.py
@@ -85,13 +85,16 @@ def writeliteral(indent, bytes):
     num_regs = max(regnums) - base_reg + 1 if len(regnums) else 0
 
     sys.stdout.write('    {\n')
-    writeliteral(8, bytes(os.path.basename(input), 'utf-8'))
+    sys.stdout.write('        .xmlname = ')
+    writeliteral(0, bytes(os.path.basename(input), 'utf-8'))
     sys.stdout.write(',\n')
-    writeliteral(8, read)
+    sys.stdout.write('        .xml = \n')
+    writeliteral(12, read)
     sys.stdout.write(',\n')
-    writeliteral(8, bytes(feature_name, 'utf-8'))
+    sys.stdout.write('        .name = ')
+    writeliteral(0, bytes(feature_name, 'utf-8'))
     sys.stdout.write(',\n')
-    sys.stdout.write(f'        (const char * const [{num_regs}]) {{\n')
+    sys.stdout.write(f'        .regs = (const char * const [{num_regs}]) {{\n')
 
     for index, regname in enumerate(regnames):
         sys.stdout.write(f'            [{regnums[index] - base_reg}] =\n')
@@ -99,7 +102,7 @@ def writeliteral(indent, bytes):
         sys.stdout.write(',\n')
 
     sys.stdout.write( '        },\n')
-    sys.stdout.write(f'        {num_regs},\n')
+    sys.stdout.write(f'        .num_regs = {num_regs},\n')
     sys.stdout.write( '    },\n')
 
 sys.stdout.write('    { NULL }\n};\n')
-- 
2.47.3


