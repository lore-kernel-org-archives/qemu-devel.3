Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1B1CD0BB44
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 22:21:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3jih-0004uN-2H; Wed, 23 Oct 2024 18:20:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t3jib-0004tW-4X
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 18:20:42 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t3jiY-000612-DY
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 18:20:40 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-20cdda5cfb6so2051715ad.3
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2024 15:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729722037; x=1730326837; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gjhwi7DEbs2CzCNXR3q88cVL7xxDIOJClyURjZ5MuMU=;
 b=WZbQvilMn26+uU2CHrAWGe3e62M68D6v51tMvFG3q6xsL7mfAft5BwRgPkiaALaQ3w
 lkWcG5b1hKe8g0HInLi5hcbfg2ScDZKxX85O35TPCP3k6b+m//0jF2fOzhtbW9cinwI2
 VLM3iEs76Tbq0bIeKuusYX7Ng5O/4As+1Vhqbn4I+MLp0iDDrWjyhjKq09u/P4M3pmNN
 9Ichh2hOyb9UOyO7j0Rj2T3siEqQOETYD6DApoJAbmbrwZsu2a70ZeIq4J5q4Ra0pmER
 YXE9cQujPGaTeYTfqAfp/Lw1d7r0C2vnqiuEBmwxLjWoslTp3LRi2PRLeXvgMKZ5q0lL
 IkYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729722037; x=1730326837;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gjhwi7DEbs2CzCNXR3q88cVL7xxDIOJClyURjZ5MuMU=;
 b=nAh5apWZjAkRxwWwt4XkU1hjucuEnOVZ8yqL5gbKS/sgLAZ95oACua+q8JJFqj488s
 lnu3TZWwmPf/34GhUd8ME8CtNcVO9od5XTKQCcEu7a3YBshBElx+YjMVhWGLpAQ/6ubH
 O7p/k2UIFP9dWgDKpmSaIbfSYiR4OI4kiPYyb0lHP08wEafBFRNDL23ktZK3jZI0Lyi3
 7+BngICEsi8EiGnWIt+uL9pPpRlao/w+cKc3KgZt1LbB0oawzu240OLSzs3ahEYdfr40
 VZg8QvvQKPg5ywXotWmLfbh5IRfSql3Z26lpC9ydtXSHSV4kCXttbS/DDI7lLexWzP5f
 dY/g==
X-Gm-Message-State: AOJu0Yweiz4zq7IB0HnhnVn+yWb3ueUSDdsmdgL0vDB33NivHgqVI0zN
 wZwjmklcfzjo70V6TwzeRij1igddcBcjDM+wYdRqMQ4XeM2bM7zsO3714e0/7O+9Vw5Vgq7BgbJ
 u9cpo9Q==
X-Google-Smtp-Source: AGHT+IF8QB+85jU2UmCpZkS5o/DZXrIvZQ1wzktu3q5is4pESeQQRFEUN32aUWc5gpNWFMbfo12RaA==
X-Received: by 2002:a17:902:e80c:b0:20c:e5b5:608a with SMTP id
 d9443c01a7336-20fa9de92a8mr58247955ad.5.1729722037151; 
 Wed, 23 Oct 2024 15:20:37 -0700 (PDT)
Received: from linaro.. (216-180-64-156.dyn.novuscom.net. [216.180.64.156])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20e7f0dba36sm61897395ad.215.2024.10.23.15.20.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Oct 2024 15:20:36 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 2/2] cpu: ensure we don't call start_exclusive from cpu_exec
Date: Wed, 23 Oct 2024 15:20:26 -0700
Message-Id: <20241023222026.1430014-3-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241023222026.1430014-1-pierrick.bouvier@linaro.org>
References: <20241023222026.1430014-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x630.google.com
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


