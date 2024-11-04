Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0928AD1CA05
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 22:21:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t85Rn-00056q-43; Mon, 04 Nov 2024 17:21:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t85Rl-00056f-P5
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 17:21:17 -0500
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t85Rk-0003n3-46
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 17:21:17 -0500
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-7ee11ff7210so3438473a12.1
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 14:21:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730758874; x=1731363674; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=CtjK6uM8BJttcc5DlKkj0akc4KPUoC3/df35iFHLVEY=;
 b=HQpGTFeAiXq8dtH39VNf694sq3V3jeaTLdoRH1M8B4f+YIE+8aAVYo6FnbOf9Qsu1B
 Wxm8WFkV4643RQOY1j6/0+QyfHQvfHQTrdffAaIBZOXUrRRhLAdKV243y02+zFg4IZ5N
 niGO9Gv8Tfbr7lHrVAjFVoNPF+QRtHzkWBUi4P7Cbhf8KYLzdIN4np1HhsuQRPMV6jD+
 oIsNOc/q4LEMpyzGPgmOWagb3MLc5bOkt58hWKuI4cFmydJHscnqB5f7hdPU5u8Whnw3
 amOihc3i0fjA4Y8PkMpyHrTWMSN2Nb8/nNOXC3koIMptModOIn2K8g4H0SUqpop3oxEl
 EKKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730758874; x=1731363674;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CtjK6uM8BJttcc5DlKkj0akc4KPUoC3/df35iFHLVEY=;
 b=cu3CS/PCoHq1EurW9ZemyKTfwlZG9jbM7gkGQLTFeRmxwqXoiOje6CNGUVS9BK4E3/
 eRKybX2Z3dzFAFoQf2L5gSWCRxoTZ3wsA6golqAvdothE7dSGZI2dOFnyjnyg+voEC/a
 1tRaiCa1NbogmRXWinuQXWwFgB1f/cj7gIh5KfqM5G9/Y1ygsZDC/B2P++PhllKDcsZn
 QhC/VtQ5BU8aE7N67LGdlnN/pevp03Y3sqESNJ/WxTfbh+BEV5xEnAIkt5I+OZGCbVLZ
 oSQWSdc1xSntWkXow3bP+CGi864gcpnaTY8+6D9+SU2vHbFlrtUQQbdVNqpK/jKU/orx
 pgqA==
X-Gm-Message-State: AOJu0YzJ8u7luHqyfMm40nhqMigTGSoAAvwmcrh6/7psb667+M75QAk5
 gTklnT5rxqZk15FscFmPf49cSKmlV4hxX+FidJJlHgWSG0xxgUOp2ph7MmBrLIrPvrD1z+jqpVh
 SZHg86Q==
X-Google-Smtp-Source: AGHT+IFEZfAAgXcBOfbaUQH8AKA340IWSEJiu6JQC00u/RA1eztquMjBOjOGqVRa0Qty5ZDFJ1dOQQ==
X-Received: by 2002:a17:90b:2e4d:b0:2e5:e269:1b5a with SMTP id
 98e67ed59e1d1-2e94c54a67emr17180374a91.41.1730758873765; 
 Mon, 04 Nov 2024 14:21:13 -0800 (PST)
Received: from linaro.. (216-180-64-156.dyn.novuscom.net. [216.180.64.156])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e93da983edsm8100117a91.4.2024.11.04.14.21.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 14:21:13 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, pbonzini@redhat.com,
 Cameron Esfahani <dirty@apple.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH] target/i386/hvf: fix clang compilation warning
Date: Mon,  4 Nov 2024 14:21:02 -0800
Message-Id: <20241104222102.1522688-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x534.google.com
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

../target/i386/hvf/x86_cpuid.c:35:28: error: a function declaration without a prototype is deprecated in all versions of C

Fixes: 7cac7aa7040a823c585f1578a38f28e83c8bf3e1
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/i386/hvf/x86_cpuid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/hvf/x86_cpuid.c b/target/i386/hvf/x86_cpuid.c
index 3a116548a3d..492e8bfc809 100644
--- a/target/i386/hvf/x86_cpuid.c
+++ b/target/i386/hvf/x86_cpuid.c
@@ -32,7 +32,7 @@
 static bool cached_xcr0;
 static uint64_t supported_xcr0;
 
-static void cache_host_xcr0()
+static void cache_host_xcr0(void)
 {
     if (cached_xcr0) {
         return;
-- 
2.39.5


