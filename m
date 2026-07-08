Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10D74C44501
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 16:20:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whUzb-00014Z-2P; Wed, 08 Jul 2026 12:19:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1whUzZ-00014G-HI
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 12:19:21 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1whUzX-0006yj-VY
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 12:19:21 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2cca0c5799eso7798395ad.0
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2026 09:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1783527559; x=1784132359; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=562gT512wWfhkRLNgMwPwc9/wP2/605Q6dgoo/Dp1wo=;
 b=XS2OI+ZGwqr0x6a2pGrgg2zjr7u4Xp0Lux165/iefW5Ntqm3883F8Y/FX6p4SM/Ixr
 7B2rvA2Apz8obbakUKsSj5SdNU1J5YOtHtSBhImEIBJfcc+2ZJfVrF51uvWSKZAvWzE8
 4WIQcD8kyecsjY6xyiSCjuxP7Ifsrb+6xRadyG9VkSK1mIBqOQyTJEP5DHXqPy7P2SBC
 nKfCWtXHc9Ka4gSzI5fthT7PyuExvdEPCkcFOy1jRz+XjA8bwzBh2foNIZRvHflF9I0m
 ea4ONCYpL0FTRo8jf0bEvyxGFYHzWBnqpZrTs11MbryiTd8CsJQ67pQcdNG5I20TwhSU
 xBnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783527559; x=1784132359;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=562gT512wWfhkRLNgMwPwc9/wP2/605Q6dgoo/Dp1wo=;
 b=A/fC3oB78Sx6/OQoT0l+bJZXnHksj0wFix2pJFvS1fgDXMhtexD2vtEbShQITAEvmz
 KVKne0MaI8nJzpVI7HAte9OwxN2+IHbXJsoFTbjjTes7NWu2kkIr/ohdXH7br6BnwEB0
 reYzk5zSrTqUEUbdWpzoPuXvw1KZmWFl4p9n+AynZwsj4dzN9z5JsBp9yy7tZmjM3qTf
 bM4YxJM2jxRKEFMmJCbR5+s/b6f4gcIOC6Y9q0PzbjgEmoNxxtIT1CUQ7Rj5Ylw+Wgqh
 /EP9zEM+WBIjlzU7fzTNzx31iIqut9WjpYzO1nxD4fkxcR5rTjxVfesBpU3lWtoBjxgZ
 MIlQ==
X-Gm-Message-State: AOJu0YxUVWcMp7VBLoET5qkae8wrkqq3Knfpd4wDtjRghHVBNch9zP3e
 9NE6gs3RTHxbybt38bugIVvpU2Hu6dbJngy4e4UECXTOCugE+UJK3qo7Rxy9/UMTlRpNIAbIT4L
 OL+vDpujt3t/s0v4KDYxCJTbGznouhs5ORwSkhxqZrq/rKciScCRcqlsF+me4EIEhKMjyH8yMHG
 Zt11nTLFNK/MIVPaNRylZnTA1J4R5p8FnlTZa5VUE=
X-Gm-Gg: AfdE7clNej4ROufUl9ads/ZrGmkXxYT0ZEH6M+AOLIeRBE/cGpVh4dePwTeE8qQqrdJ
 eW0bJoS4CVHJzdjpWTUuTNnMFOtZyl4+vcb+ELk8FcAedNUgyFLKxlWh3iz/GcPtIrvS7SAL50q
 tNdoZMgtpRw7ql9khpTVJMIbWJ2PbPKFgKkivQ8PSs5h/lzGaAzgnKdw/bSABENf4/hetSGkxke
 VdXeFtPhMdI+gBLqsVZ3WZ2c2olIs/4o05cvYiZpEAFmgRs6mKZAUYDmPBxFdL0ibpywB7ARAhU
 e08PT3HZaO3CvN8+7nu6qiqrPUTKym0HWBCKs1HAHafNpqho9vLCIIY9V/qoGwilNwe5ZHlh5Xn
 3eUe1A3j6nQeSqwuDwnvEM4wiw19NJxzF9qpi5Wr4ebhzJZKJny+wLkZc21QtEhyTIvKRuA35fI
 ypb8FSx8F9YHc8TdBb4zC9Q+mghoI0a14lSSclgaDEHoBlnTYFdU2TCRhvDiwBqKNrF7TJ710IG
 ywkFUV7eNTVPK1k
X-Received: by 2002:a17:903:11c7:b0:2c9:b48c:fdde with SMTP id
 d9443c01a7336-2ccea45abeemr35104855ad.26.1783527558477; 
 Wed, 08 Jul 2026 09:19:18 -0700 (PDT)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ccc9bdb56fsm30789265ad.15.2026.07.08.09.19.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2026 09:19:18 -0700 (PDT)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Max Chou <max.chou@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v6 4/9] target/riscv: Add implied rules for Zvfofp8min
 extension
Date: Thu,  9 Jul 2026 00:18:54 +0800
Message-ID: <20260708161859.1124848-5-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260708161859.1124848-1-max.chou@sifive.com>
References: <20260708161859.1124848-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=max.chou@sifive.com; helo=mail-pl1-x631.google.com
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

Add implied rules to enable the implied extensions of Zvfofp8min
extension recursively.

Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/cpu.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 38c580a22a..8cd1a5e056 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -2668,6 +2668,15 @@ static RISCVCPUImpliedExtsRule ZVFHMIN_IMPLIED = {
     },
 };
 
+static RISCVCPUImpliedExtsRule ZVFOFP8MIN_IMPLIED = {
+    .ext = CPU_CFG_OFFSET(ext_zvfofp8min),
+    .implied_multi_exts = {
+        CPU_CFG_OFFSET(ext_zve32f),
+
+        RISCV_IMPLIED_EXTS_RULE_END
+    },
+};
+
 static RISCVCPUImpliedExtsRule ZVKN_IMPLIED = {
     .ext = CPU_CFG_OFFSET(ext_zvkn),
     .implied_multi_exts = {
@@ -2826,7 +2835,7 @@ RISCVCPUImpliedExtsRule *riscv_multi_ext_implied_rules[] = {
     &ZKS_IMPLIED, &ZVBB_IMPLIED, &ZVE32F_IMPLIED,
     &ZVE32X_IMPLIED, &ZVE64D_IMPLIED, &ZVE64F_IMPLIED, &ZVE64X_IMPLIED,
     &ZVFBFA_IMPLIED, &ZVFBFMIN_IMPLIED, &ZVFBFWMA_IMPLIED,
-    &ZVFH_IMPLIED, &ZVFHMIN_IMPLIED, &ZVKN_IMPLIED,
+    &ZVFH_IMPLIED, &ZVFHMIN_IMPLIED, &ZVFOFP8MIN_IMPLIED, &ZVKN_IMPLIED,
     &ZVKNC_IMPLIED, &ZVKNG_IMPLIED, &ZVKNHB_IMPLIED,
     &ZVKS_IMPLIED,  &ZVKSC_IMPLIED, &ZVKSG_IMPLIED, &SHA_IMPLIED,
     &SSCFG_IMPLIED, &SUPM_IMPLIED, &SSPM_IMPLIED, &SMCTR_IMPLIED,
-- 
2.55.0


