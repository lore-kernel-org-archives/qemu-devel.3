Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ABF7C3ABBF
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 23:27:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uC57O-0006ei-0H; Mon, 05 May 2025 19:21:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uC578-0006Nf-6e
 for qemu-devel@nongnu.org; Mon, 05 May 2025 19:20:46 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uC573-0003bN-OK
 for qemu-devel@nongnu.org; Mon, 05 May 2025 19:20:45 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2254e0b4b79so75205425ad.2
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 16:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746487240; x=1747092040; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZaY3toZMvHik6Oxfda0st+OdZGZoqXe3KmHGIqEM8+g=;
 b=ZPiRanBdXUFBPUORJiTWqR8vaHdCL5hx6pYC3N3PMFb2JpL9vRlp4yzIusMUk2Mgtl
 fJhIMRtHuHL4sA4wEwtmHLQ5CRS6SqPAnAEe6da3xVUaJkdkw6l8/JQK6K4DUxWDH1fz
 sN4bks4Ki8kqSp1sBIcHJT9atDEwNZ2oi24D+sGUUvbz3v/2nZ6PBD6Xtk+wjKdPdmqf
 2MxhoP/wM2p/rXHoZwQoZelJI6Fy8S6djfjQLaauWdbu7jmylYnobrNKeAHtyzX6YMuq
 L2s+e2ZXV2N/ehK21oFrJdV6IPy+BmW/OXXPC84aDp4NZg05ASxnNgrbba/dUqR5Oab5
 AsIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746487240; x=1747092040;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZaY3toZMvHik6Oxfda0st+OdZGZoqXe3KmHGIqEM8+g=;
 b=CCUTdfyvfabdQrPssxl/79ICrtN07UJAF3uv1cPDc68PYgGi29GLxXSDlsGtNQWU81
 JK4+vRuEyUbX8ROly8xprE8EUNt4YLwBv0l42feinhPW4SxG/UGPVKtTJEy3xjAu2pXJ
 ribeGhk6hUrS6IR3aRd7nejXR9bJ05CKcFw1AuLAjJJuigSwS3SuANEmP2vQEKwx3wfH
 i0I84v/lrnxVjdDiWpm9A6pVyH6pW4qcsFhvE3Xx1bGAgCc8Mvn+Nkp08w6IaFEp1K6r
 SW//XR/bmbZ5jl/Jq/c+vOnFnZu5/bm3WwE5F8uoG0GMcDuqmKuAwI70WCLqY4WhppHe
 Zo5A==
X-Gm-Message-State: AOJu0YxBvjd/6lpIa+y40o74DxuTgMbzl43dCYADamANv3T8+hrgXI6e
 7IN8sY1rg8JfyeRP0JRf/YE4GqoSYS0NLtuUQ1Ny2tvOit6eFsQX/utNgCRCtbZDKGW7F10OuoI
 JHh8=
X-Gm-Gg: ASbGncuQ41P6kiMmBUghFdksHdBCbpl5rVQIvwOHP9dIveeUvqrUGv8RtbNyX/g58dj
 G7+4AObMk3FBIoamUsdJ0IHIzYU0D6RW1f32hvAndWei6qqo7W9vAuDMC4uqBF+pxpxvbEOKK/n
 si6nm+Sx3UiXPcnk7VkM+amTZ2vpYC2XghW4LcPkIv0xKZmpwQa+7OpL/CgT2HjR+FmI8KIN90+
 enRl3er60OgPn6emxhNsCQjorlS3plZfPl2Pg/axaDfZuWYbS4MD+cN4mNTxF2VrLr1ttCkPL+P
 2YlP9yXlG6U9LvtW7ijqSfQA8LC7uA/qnqJiFYBr
X-Google-Smtp-Source: AGHT+IEJpX9b4sIeMwievSiYenGx0avBZsdb5YYkcnnfwScYImSa6xg3N3nAjjr/lE8XrijHR6UurQ==
X-Received: by 2002:a17:903:1b2f:b0:223:f408:c3f7 with SMTP id
 d9443c01a7336-22e1ea47acbmr137947265ad.16.1746487240186; 
 Mon, 05 May 2025 16:20:40 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e1522917asm60981715ad.201.2025.05.05.16.20.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 May 2025 16:20:39 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, anjo@rev.ng,
 Peter Maydell <peter.maydell@linaro.org>, alex.bennee@linaro.org,
 kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v6 22/50] target/arm/helper: replace target_ulong by vaddr
Date: Mon,  5 May 2025 16:19:47 -0700
Message-ID: <20250505232015.130990-23-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250505232015.130990-1-pierrick.bouvier@linaro.org>
References: <20250505232015.130990-1-pierrick.bouvier@linaro.org>
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 10384132090..7daf44e199d 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -10621,7 +10621,7 @@ static void arm_cpu_do_interrupt_aarch64(CPUState *cs)
     ARMCPU *cpu = ARM_CPU(cs);
     CPUARMState *env = &cpu->env;
     unsigned int new_el = env->exception.target_el;
-    target_ulong addr = env->cp15.vbar_el[new_el];
+    vaddr addr = env->cp15.vbar_el[new_el];
     unsigned int new_mode = aarch64_pstate_mode(new_el, true);
     unsigned int old_mode;
     unsigned int cur_el = arm_current_el(env);
-- 
2.47.2


