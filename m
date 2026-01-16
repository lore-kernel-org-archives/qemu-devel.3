Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E8E1D48981
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 11:22:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vghtM-000580-QO; Fri, 16 Jan 2026 06:21:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vghtJ-0004fE-KM
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 06:21:21 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vghtH-0007Mp-Oy
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 06:21:21 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-42fbc305882so1001127f8f.0
 for <qemu-devel@nongnu.org>; Fri, 16 Jan 2026 03:21:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768562478; x=1769167278; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=eHLs8AUi0uIKt/UnDT2O1wmc+fAIIzrx7AQFHa6gfgQ=;
 b=RO83T/FMQmjFaPIlIK90SMGV18bZEIfTzgJsJ6vebo7CCyumRqfBEEFjG4zu6HZaJm
 pUHSu364a2Tl07jSy7g4wM4G9Q4PcfJqfes+CshBdZL3HbuOKKgipLE0G1Oqhhj2L9xj
 u4FM9KXhkJxymTorJRCDfVbzNOEWFw05hLUrorjgIQsaqO0dH+O3wLEMNFBeJGFX0HHz
 Oh17sXDBT+H01Bas1NCXflgVk+afTquFSSwq1s8fu5WoHJphWOYJzPkxDSSy60FYUd5U
 24wauaoeHf16YxL2O4RmMrosLlqSgCMLXmQaKXIyDgvwQAx7JDe6pC2MqfwQ6NuIrBNi
 Om/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768562478; x=1769167278;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=eHLs8AUi0uIKt/UnDT2O1wmc+fAIIzrx7AQFHa6gfgQ=;
 b=KeRuVO7hK4mit25lSb/sd5pKVD1q4qatFG2r/H+T39D+sQD5nvygsysm93jHWjF1JZ
 StWo4IcZccFE0z+SD31OsbWYmHZzBQKSE0uNfA9Nr6aIO6j20jNwEZdnUY9FzwkjfvX7
 t2PsQ3B5VCacfqh7/esmqKzvs2FjelRgwstUtX76hEpaTOCikzsuVAbugHdff2TJ4Nlc
 vsqf9aihwWpWwTrax2Q3grmgErtiEgvV3Gti9aSx7v0ee1mDYPUGh/z8NFDcIxOrTxoM
 FKc2MNab1bV97N2wmLnzGUKnQaTj9p+XAkUVVHcPZitEKsRdj/Lhz5NU2cVcixrQPHVL
 ISdA==
X-Gm-Message-State: AOJu0YypoP39IsqpEK6IFt5PvLIggyNtrQEAmFOEJlhTZrYwl6i7uCET
 TAkdNH9/tSCdawnnP9lW3HcsW1cSXt7Hdqx724J6uKfGfAp7NwdyFpGxLWyzfCzGR/pEEdVsQY1
 Vm2wXt+U=
X-Gm-Gg: AY/fxX7kllukvbgMi8GYSAxLzONBTZBBdaJm4eFAzbkegCz5MQYrBSFHdOTalEdGCAl
 rBnc9UQRnuz+hCGwapuv4s4JfF5U+JDzEPLQ8UXgJJxD3gaBSVI1ec112m/7HSYPmm9SMgLLiox
 r1WSOembWBqx67uPIXYPIJ8MkT79GLVsdx0aTVZaXCO9+7Q5fXwns10q2trUTXzcHa78HovGtHq
 LBF9H+Z8JDD2PqLsQcsN41rzWEahNpz0nlzQjpFZh8Z+WJ14wARQIdHtkmLogC61NBw94M/84b0
 ApHRn7xGQp1V766htZvL599NDSfg517jjJcOQpxhXcjGTIJEStxfhljNBRh23yMcsnA9VVk/gfb
 KETdrLkJhhfkthrj/5ExVdkADkqFr+R7AY8Ozojpl/U67hglvUzJjyrc2swE44Onnxwq7C7V5Kj
 OsfOk6ArfqFupJeLUBxk5WBESN0+tRGE7EhiwWeRxuqQcW9RhYnZeZ+oXd3cEe
X-Received: by 2002:a05:6000:1845:b0:432:c0e6:cfcd with SMTP id
 ffacd0b85a97d-4356998af3emr3176524f8f.22.1768562477904; 
 Fri, 16 Jan 2026 03:21:17 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4356996cecasm4304496f8f.26.2026.01.16.03.21.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 16 Jan 2026 03:21:17 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 28/30] accel/nvmm: Fix 'cpu' typo in nvmm_init_vcpu()
Date: Fri, 16 Jan 2026 12:18:05 +0100
Message-ID: <20260116111807.36053-29-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260116111807.36053-1-philmd@linaro.org>
References: <20260116111807.36053-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

Fix typo to avoid the following build failure:

  target/i386/nvmm/nvmm-all.c: In function 'nvmm_init_vcpu':
  target/i386/nvmm/nvmm-all.c:988:9: error: 'AccelCPUState' has no member named 'vcpu_dirty'
    988 |     qcpu->vcpu_dirty = true;
        |         ^~

Cc: qemu-stable@nongnu.org
Reported-by: Thomas Huth <thuth@redhat.com>
Fixes: 2098164a6be ("accel/nvmm: Replace @dirty field by generic CPUState::vcpu_dirty field")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Tested-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-ID: <20260113203924.81560-1-philmd@linaro.org>
---
 target/i386/nvmm/nvmm-all.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/nvmm/nvmm-all.c b/target/i386/nvmm/nvmm-all.c
index b9bd9ed985a..f808828d492 100644
--- a/target/i386/nvmm/nvmm-all.c
+++ b/target/i386/nvmm/nvmm-all.c
@@ -985,7 +985,7 @@ nvmm_init_vcpu(CPUState *cpu)
         }
     }
 
-    qcpu->vcpu_dirty = true;
+    cpu->vcpu_dirty = true;
     cpu->accel = qcpu;
 
     return 0;
-- 
2.52.0


