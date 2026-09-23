Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EC0AC9830D
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 13:27:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9N0A-0004hm-MW; Wed, 23 Sep 2026 09:27:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1x9Mwq-0006Pb-CL
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 09:23:46 -0400
Received: from mail-dy2-x10.google.com ([2607:f8b0:4864:36::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1x9Mwl-0007xB-RD
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 09:23:41 -0400
Received: by mail-dy2-x10.google.com with SMTP id
 5a478bee46e88-33bf5a1c4d9so904281eec.3
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 06:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790169808; x=1790774608; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=F+o5KblLu0GyQgfzLlM1cTvsfq0uChm3NLiJCLhEk08=;
 b=OkZ1MQ1H1VBlEo/MpillvCXkCU/BkGeO53qD8Mjtts8LioeEUEzFNfs01y3Nts1HVH
 CaIAvjAvvuIeLqRgni5tf5/uq/15z9E4gjVBE/ObAu38htGUxECpIMbKncgaMNBMokgg
 tMCuhvGzA2yv6bch49uTfco/loO4UbWKeb/6dRh0qKtEYCvcX+GsaRcfgErW/G/AMOMQ
 w84z0QbHbRuEN2IeHWdQaYYZVuQrBY3Wnjp6oUT3JniTYNfBnLvu7SxelBP3CRm2cJPt
 864IlwmE/PHJEg6O/EZ1tKyIgpPcaaUsRnVukdU1/8793EbbPtFHBRZujxxBCwgz1DNJ
 K3Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790169808; x=1790774608;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=F+o5KblLu0GyQgfzLlM1cTvsfq0uChm3NLiJCLhEk08=;
 b=A+KsbWYNqScLNdR/qSyOeOAmpG3kCaCSY/Swqeggmu9iE2Kf6xonzt6kz6zg7ufqpb
 oEPII4JCwvyrAUdS0Fgl27u9hvKoMw+Yb/qNFYN//ljjl6/qMQZn6l2ATXGuIofSkurg
 6YhWu0mmBWfgIAP/3zWMXV2UWIAfuZIT0/ZzKFQybniFS7LG8FlJL2hpbittrZ2sKyt7
 ukS+c7JNckw6+B1FGC9Dz6jjVAwFhLi7HJ83J0aVm7awDhEaPuF91/2U9x4I22qj+HYy
 D0bif7msiNuYv26M7OfhJtVeg7J4AApLp9u7IUdeQ3dVydWyd9w55fxKGjyJI+RHgdSo
 FkNA==
X-Gm-Message-State: AFuF++mXu+ND35krJj48GyhhG2gAzOB6fUrwqeAIzN9fhkKoW+jeh/Ay
 gdIhTdVFs58N/8J09UqxUS8wRPsfFHI7ikvuL9ARYVoBVFGdWWX7cfdcWOlARGXnJHU=
X-Gm-Gg: AYBFou2yL7ufKJ3R0rtvpydPtnUUOHHq6+jqnlJ8OdsVvACVlIna+yDxOoa91yhLz7t
 f6XyRNoJQCEbrbV1Uxt65to3cJQW/9wKnaf9wXJlyFBz8I1hxecnlx/NDoSbygsTGyHOOFhMd8j
 s1wmeqh34A6vJcwEXcuxsCynWHhzxFk0nJvscnTBzIvUQ1FimaW/8G5lBEEut4wb2lc9A8PvVxn
 Of8dpqyeLjW3kAipkYPTCKaGC/5Svm8Tq4O9OKCVYdetTbQ+cTxQnvtYAeZIPpy8VhmaYstzbkC
 4ZoCT5Qjb42Ej1WoVe53LA7zaNYvtgMm0MLVMTyE6cJtPwcNMOLDrfzUBWymwQ+5jmZqS8Ui9Xw
 ZmvzyF/jNoRgnyCY9gF3ne210wn2UgP11HEbOK4SHwTc2eaVBU24E3AYbTiuqwKdZOD12xJVH3Q
 3XbHimxlncCP3h/3AATUk2cBLifXkVOI0ZRSfsrcTK1eeynfzpeOxyB7MeBvoHbzTuMAmcY2VWb
 w3ZO8k2OQuwZVffRfOvryItdHMvQDchOCa4/A38ZQ==
X-Received: by 2002:a05:7300:7b27:b0:33b:eec0:eefc with SMTP id
 5a478bee46e88-33e8e88ea29mr2331973eec.40.1790169802984; 
 Wed, 23 Sep 2026 06:23:22 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 5a478bee46e88-33e97236754sm5553695eec.29.2026.09.23.06.23.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 06:23:22 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Cornelia Huck <cohuck@redhat.com>, xen-devel@lists.xenproject.org,
 Chao Liu <chao.liu@processmission.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Peter Xu <peterx@redhat.com>, Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Sunil V L <sunilvl@ventanamicro.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Fabiano Rosas <farosas@suse.de>, Xianglai Li <lixianglai@loongson.cn>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Max Filippov <jcmvbkbc@gmail.com>,
 qemu-ppc@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Bibo Mao <maobibo@loongson.cn>,
 "Michael S. Tsirkin" <mst@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 David Hildenbrand <david@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-riscv@nongnu.org,
 kvm@vger.kernel.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Stafford Horne <shorne@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Weiwei Li <liwei1518@gmail.com>,
 Song Gao <17746591750@163.com>, qemu-arm@nongnu.org, qemu-s390x@nongnu.org,
 Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PATCH v3 040/114] target/riscv: replace leftover TARGET_LONG_BITS
Date: Wed, 23 Sep 2026 21:15:14 +0800
Message-ID: <20260923131635.1894-41-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20260923131635.1894-1-luoyonggang@gmail.com>
References: <20260923131635.1894-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:36::10;
 envelope-from=luoyonggang@gmail.com; helo=mail-dy2-x10.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

- Use target_long_bits() in bitmanip clmul/clmulr/xperm loops and in
  the m128 signed-div overflow check.
- Compare xperm element positions to target_long_bits() instead of
  sizeof(target_ulong), which is always 8 in common-system.
- Leave translate.c and insn_trans TARGET_LONG_BITS for riscv-tcg-tl.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 target/riscv/tcg/bitmanip_helper.c | 10 +++++-----
 target/riscv/tcg/m128_helper.c     |  2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/riscv/tcg/bitmanip_helper.c b/target/riscv/tcg/bitmanip_helper.c
index 5af3efe194d..db226146054 100644
--- a/target/riscv/tcg/bitmanip_helper.c
+++ b/target/riscv/tcg/bitmanip_helper.c
@@ -30,7 +30,7 @@ target_ulong HELPER(clmul)(target_ulong rs1, target_ulong rs2)
 {
     target_ulong result = 0;
 
-    for (int i = 0; i < TARGET_LONG_BITS; i++) {
+    for (int i = 0; i < target_long_bits(); i++) {
         if ((rs2 >> i) & 1) {
             result ^= (rs1 << i);
         }
@@ -43,9 +43,9 @@ target_ulong HELPER(clmulr)(target_ulong rs1, target_ulong rs2)
 {
     target_ulong result = 0;
 
-    for (int i = 0; i < TARGET_LONG_BITS; i++) {
+    for (int i = 0; i < target_long_bits(); i++) {
         if ((rs2 >> i) & 1) {
-            result ^= (rs1 >> (TARGET_LONG_BITS - i - 1));
+            result ^= (rs1 >> (target_long_bits() - i - 1));
         }
     }
 
@@ -98,9 +98,9 @@ static inline target_ulong do_xperm(target_ulong rs1, target_ulong rs2,
     target_ulong mask = (1LL << sz) - 1;
     target_ulong pos;
 
-    for (int i = 0; i < TARGET_LONG_BITS; i += sz) {
+    for (int i = 0; i < target_long_bits(); i += sz) {
         pos = ((rs2 >> i) & mask) << sz_log2;
-        if (pos < sizeof(target_ulong) * 8) {
+        if (pos < target_long_bits()) {
             r |= ((rs1 >> pos) & mask) << i;
         }
     }
diff --git a/target/riscv/tcg/m128_helper.c b/target/riscv/tcg/m128_helper.c
index 7d9b83b1b2c..e59a1ffd7a7 100644
--- a/target/riscv/tcg/m128_helper.c
+++ b/target/riscv/tcg/m128_helper.c
@@ -71,7 +71,7 @@ target_ulong HELPER(divs_i128)(CPURISCVState *env,
     if (vl == 0 && vh == 0) { /* Div by zero check */
         ql = ~0x0;
         qh = ~0x0;
-    } else if (uh == (1ULL << (TARGET_LONG_BITS - 1)) && ul == 0 &&
+    } else if (uh == (1ULL << (target_long_bits() - 1)) && ul == 0 &&
                vh == ~0x0 && vl == ~0x0) {
         /* Signed div overflow check (-2**127 / -1) */
         ql = ul;
-- 
2.52.0.windows.1


