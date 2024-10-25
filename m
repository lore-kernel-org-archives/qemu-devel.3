Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B3CCD149D9
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2024 17:54:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4OVQ-0000in-Ox; Fri, 25 Oct 2024 13:53:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t4OVO-0000hx-UE
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 13:53:46 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t4OVN-0001g4-Fv
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 13:53:46 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-7203c74e696so1667964b3a.0
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2024 10:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729878824; x=1730483624; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gjhwi7DEbs2CzCNXR3q88cVL7xxDIOJClyURjZ5MuMU=;
 b=OYpuNdOBW76ctholB04Yutgz17bxxJ3H+r14udv0OT8TZkWBsbUI5mLi8YNjXMt/vN
 DDos/GuLRBTftPX4CQf5nVM2rDy47lwtH6bzjiMY9usX0fTnlT8Ma6Fa1lyXpeJbP6V7
 ICIYeN1KZFfrDqnBlIRJuxQXkgymXQP1Za+uM+loJWqu6KtRUjX6S0JV0rSrgnXlJjoY
 Es6Oj3+0qDVEODyX94GrRmMidcvwFTWLVwb9lC59BVMP1sCPPhm1wJMdarcEX5aRy7FM
 15fZEQZly65e+8MojvcStN4AQN6QbHjR51nfpz1E3GcldArNWc2bH6yHsFlorUDLIFO3
 hxGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729878824; x=1730483624;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gjhwi7DEbs2CzCNXR3q88cVL7xxDIOJClyURjZ5MuMU=;
 b=W9iUxWX+lAg1cpMT85VhuqJuLrHiQ+JpL4GQPtWUsYRroAdKxLRN7ffJwtuDGdHL6r
 bf0htCf4kThDsgEs1lvEHFZUA+EzMoLEHGyar5zk4icHz6EfTg5SjwAxzIbo6+eoJJJ2
 5KpYMWiRfnhEfgmtz47JdRuqQrdCZ0oSGjx7BoBgNn5OtpeFaD7XvHElGUJode+qZTex
 5mcEBM63bBoZ6yjX8MEYlBxb5s8+V+DaW5bng76/QnVJvV9rpRE0HjCr9thioCuwNXj2
 09pj8tQIAXL7hJC48426zsfo/wW9cFGQLM2j71+PhpWXikWUuA/AiDaa0YRdnfh89MmE
 wX+A==
X-Gm-Message-State: AOJu0Yy/v+KD+AsRUmyvL5rQQ5Gm86YnHRCDUkso4vtTM/prIQc7eno1
 Yvn2070tF+e0UaEoE7NPxp7rAV9VLShY50dVRDcxlRxN5Yu3Jb6ikUb/ajnHi9s7o+bZZWnsmjR
 E91N5+w==
X-Google-Smtp-Source: AGHT+IFF+F0dqNiKVzzxlLcgqtUL+LLwjQcFQH8Kg11uYUXsbFJfg9SNn4Fh9YYAIFhgAErYDB7I8w==
X-Received: by 2002:aa7:8891:0:b0:71e:5b92:b036 with SMTP id
 d2e1a72fcca58-72063072821mr514345b3a.22.1729878823558; 
 Fri, 25 Oct 2024 10:53:43 -0700 (PDT)
Received: from linaro.. (216-180-64-156.dyn.novuscom.net. [216.180.64.156])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72057a3cf5asm1329416b3a.201.2024.10.25.10.53.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Oct 2024 10:53:43 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 2/2] cpu: ensure we don't call start_exclusive from cpu_exec
Date: Fri, 25 Oct 2024 10:53:34 -0700
Message-Id: <20241025175334.2549425-3-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241025175334.2549425-1-pierrick.bouvier@linaro.org>
References: <20241025175334.2549425-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x434.google.com
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 cpu-common.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/cpu-common.c b/cpu-common.c
index 6b262233a3b..c979138fce9 100644
--- a/cpu-common.c
+++ b/cpu-common.c
@@ -194,6 +194,9 @@ void start_exclusive(void)
     CPUState *other_cpu;
     int running_cpus;
 
+    /* Ensure we are not running, or start_exclusive will be blocked. */
+    g_assert(!current_cpu || !current_cpu->running);
+
     if (current_cpu->exclusive_context_count) {
         current_cpu->exclusive_context_count++;
         return;
-- 
2.39.5


