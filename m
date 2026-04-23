Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C24BFDEE2B
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 17:03:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFxSB-0000Uh-7L; Thu, 23 Apr 2026 13:03:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFxRu-0000Mg-UO
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 13:02:56 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFxRr-0004cr-2t
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 13:02:46 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-48896199cbaso68058535e9.1
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 10:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776963761; x=1777568561; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YGkoFuEm7+jO9F5J4WaA/pQTANhW5MV3tHvArzYt2ao=;
 b=JzWNyKd5jLVT91ecLdhSEPDPHXBHbFPjLvcqTW2hWoLSUqeXxsqjmagpH21VgAfrCS
 wM5Axl+mmX+o1dI/MRKu2a/LFemGSWPZ/ieVcZZgrsBrg5wa9NsZwxRmuSHDUz364Qrr
 7pfNH6k650XNlOOIOE1tBd4Brfkn69GcVq0uBJlJDjirrDi2lJ98EHSSnsPExM05L2l0
 JW92woBBHmb5MI6nFexVPEWHKUrsLle399jBAY+6FaTlUyHuIKPedQgQbwby7Va3qun+
 d9M99Zn4/PxHmwnU8eHlZlpXS4XJnUVUgMdOkRM6A39rZhei3kx/ELlzBcsSaTNkKEwS
 mHog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776963761; x=1777568561;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YGkoFuEm7+jO9F5J4WaA/pQTANhW5MV3tHvArzYt2ao=;
 b=iISjDdfJMQrarL9ks+YmJiDfZd06PFE9FYK5w3v4uFCGm61XQWIInJmxK3DdsleqrK
 kPViJa1FNa/HumpGVsLJyp67BXfZxnhJO4ie+CTqaZr2rRwySfgvHCrxX7xD/LyFEHea
 DP64DbQz6a5X0aQlRGy3VY9bd0UPWUKb1cXZ5B2eRS0RKiFo6sBlZFpk+KDS2N9j5WGV
 eClqAVEzHvGv87LnfT3nn+79iOv8SWkKtYH0J8tPpmS4NRFOwV/dXJRmBlgbqQ1dsWgE
 u4S/JlXuDv5nVrfydlzSr+NcGL6WTSsZkrzX4JbjAWLqqw5+IMXKy3B4YXSTsPbSLpvH
 m5tw==
X-Gm-Message-State: AOJu0YzGR7EksXTQh2a07/ZE7IlTo5O8RyZTKHYAtNwRkNy1SzzyJk7j
 eY1PX9Ltqm4fFLnI4raKFZ1FNmsCLnNd3u7eiPQsO6lpmYnSvjAD3VfImNlKQsgKUu7nZPhi31X
 KeqYrSTI=
X-Gm-Gg: AeBDieus9vSwQhaNziLkVbehCZAi6XkTwx0t3AIu8xhrH0nHxUi1Fy+n/uj31PccTcx
 XmfevMRb/lGiN8+NgkDc6mQzcODfY6a9oW8ACMP+iok4IsiHVX01UdrCYMFynSefcI4FY5UtrIk
 cZ1mJCh0l7H0BjiXXiEmf8ihbBM9W2ea/QoS/92oxx5rfTJdUyq1fD6Xh3u+bwhDVt9ldcQ8peY
 ornprRfxWj5Qu0c9WoLfxj35A3odfXf9dVgkHBBMim1WVOAEpRhncPsVKUy0rdGceVYHO4pmATU
 aLM8zM5qRZ6N8tCp3cm3WYqPuKjhJMoDuUme35AtbvOFXAEzeyGYccDsHVCakbz+DJjj72O2Hxs
 NpIBozmqvsxoDZc0SL8AaHSURr1KQVydgelFx0f+d8lxjgAKLwsfCv7Lz5LS+/rxiJ5Xnx0jTO4
 Lbjz+ixNy09AjK8sikZAHNX6LbU49rHiEQrn2pv5xG0RiqKxTBTeCCf2AbyWUYFtVouuv9sQbKV
 1yayjkeC09X520MrjPXIQ==
X-Received: by 2002:a05:600c:3553:b0:48a:52f2:a0f1 with SMTP id
 5b1f17b1804b1-48a52f2a5f0mr207640535e9.18.1776963760832; 
 Thu, 23 Apr 2026 10:02:40 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fc0f82bbsm912678555e9.3.2026.04.23.10.02.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 23 Apr 2026 10:02:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Roman Bolshakov <rbolshakov@ddn.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Mads Ynddal <mads@ynddal.dk>, qemu-arm@nongnu.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PATCH 01/16] target: Simplify env_archcpu(cpu_env(cpu)) expression
Date: Thu, 23 Apr 2026 19:02:13 +0200
Message-ID: <20260423170229.64655-2-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260423170229.64655-1-philmd@linaro.org>
References: <20260423170229.64655-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

env_archcpu(cpu_env(CPUState)) expands to ArchCPU,
available via the ARCH_CPU() macro. Use the latter
to avoid using &env.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/hvf/hvf.c       | 2 +-
 target/hexagon/translate.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 5fc8f6bbbd9..2fb768048b8 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -2303,7 +2303,7 @@ static int hvf_handle_exception(CPUState *cpu, hv_vcpu_exit_exception_t *excp)
 
 static int hvf_handle_vmexit(CPUState *cpu, hv_vcpu_exit_t *exit)
 {
-    ARMCPU *arm_cpu = env_archcpu(cpu_env(cpu));
+    ARMCPU *arm_cpu = ARM_CPU(cpu);
     int ret = 0;
 
     switch (exit->reason) {
diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
index 633401451d8..825b236dd24 100644
--- a/target/hexagon/translate.c
+++ b/target/hexagon/translate.c
@@ -978,7 +978,7 @@ static void hexagon_tr_init_disas_context(DisasContextBase *dcbase,
                                           CPUState *cs)
 {
     DisasContext *ctx = container_of(dcbase, DisasContext, base);
-    HexagonCPU *hex_cpu = env_archcpu(cpu_env(cs));
+    HexagonCPU *hex_cpu = HEXAGON_CPU(cs);
     uint32_t hex_flags = dcbase->tb->flags;
 
     ctx->mem_idx = MMU_USER_IDX;
-- 
2.53.0


