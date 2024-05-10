Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7B03C25B5F
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2024 13:19:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5Q8N-0005sI-Em; Fri, 10 May 2024 09:17:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fea.wang@sifive.com>)
 id 1s5K8M-0001ck-Rd
 for qemu-devel@nongnu.org; Fri, 10 May 2024 02:53:34 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fea.wang@sifive.com>)
 id 1s5K8K-0004nm-Di
 for qemu-devel@nongnu.org; Fri, 10 May 2024 02:53:34 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1edfc57ac0cso13698855ad.3
 for <qemu-devel@nongnu.org>; Thu, 09 May 2024 23:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1715324011; x=1715928811; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rYDRJr2Sli1gOcjJSn4QR8SIHpM0aP0XTZg/I/oH8oI=;
 b=L2rPqW7wYgk3RXcgEPyAAsfUwiE7sH7vCRSMvKhsFLcymQVLR6fFlCLg0Lb0QjbKaG
 lZKR69n6ch5z/tEi4CEuTt2dd5AO79mMSMVebt9ZDdb9etPhEw77JWVxd/yOit85IcAv
 DwNSDYdGjiGo6IkRxlFeB+Vr6IUe5wecyeUaLldvTvkVoaHe7PYsdV4PXQOys29hVoxJ
 RpI+5u3jNv8wvj4k720NFQO66ga7G9fiz5Mx5bdlUwtnBGB6QmfBoezYp2QKQ/kgN7Or
 QyrZF7/poPYGGrplxK6AA7YwODcg64kFgtRbLj6u40Q4zUaF+1D6CrSZ3opRmll7dBwN
 LUsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715324011; x=1715928811;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rYDRJr2Sli1gOcjJSn4QR8SIHpM0aP0XTZg/I/oH8oI=;
 b=uCgkbYDUmA3KMjak7GBrpPqWIY1FiRQ5JYInTxc+zcBMHMHU/zNncMG24eBG0fI0/v
 iHAGhRfgXSUeA/nt+jOvKCm5HiyqsvJLhqMUGn81OORkOZlptoV40FTBNttRUc2T3rmc
 PUKMUGlX/pTPoBUDaJTIo4nkGCX9yjjY4Evj086SBpdVTuywl4DXEncYQFbMrM/PSHi4
 ZW9nXhDnewcGLnw1mor+9gDUv4l/8C1F5EMr1ZcItgp/dB4PrssEzu09IxrqlosCksE8
 acvKzDYuz5nkqmkXaZzHjCvrcMd+hGbkICOliOvcvRf6nV+CdWFVfPGOaOnJpkt15nEJ
 rlDA==
X-Gm-Message-State: AOJu0YzWD10T8PLvnpx6hA348OtpWWHjm/PUGBz6W9wij8Hw0laXOvAT
 8QXsoFyzc2kD+gJOqEM0rTXYUtNL5NrrsUD69/k2ypaQY+bYJiP1wPyB7cprtwlrPlVIQukjAbM
 /TSBRn2YeS3oixbcOTpJ2hrVGvH27mPLKx7kdvi4VlMEAe4Qy+n+eBNLhzJkrs+h2EprTWvQkWO
 /xBRAJ0k+0E8w82XkmsPKHD1l/9w0nq2EiKjLPyA==
X-Google-Smtp-Source: AGHT+IFqSvcyZDzNEa8Xwql2/wnMqC8tb8/gVujYDB6CGU+TT1+FPPqwfdtPBMkX5M36O7kCeBCxxw==
X-Received: by 2002:a17:903:124b:b0:1ea:d979:d778 with SMTP id
 d9443c01a7336-1ef43c0fd92mr19470505ad.5.1715324010471; 
 Thu, 09 May 2024 23:53:30 -0700 (PDT)
Received: from hsinchu36-syssw02.internal.sifive.com
 (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1ef0bf31a7asm25579175ad.140.2024.05.09.23.53.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 May 2024 23:53:30 -0700 (PDT)
From: "Fea.Wang" <fea.wang@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Jim Shu <jim.shu@sifive.com>, "Fea . Wang" <fea.wang@sifive.com>,
 Frank Chang <frank.chang@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Andrew Jones <ajones@ventanamicro.com>, Max Chou <max.chou@sifive.com>
Subject: [PATCH 1/5] target/riscv: Reuse the conversion function of priv_spec
 and string
Date: Fri, 10 May 2024 14:58:51 +0800
Message-Id: <20240510065856.2436870-2-fea.wang@sifive.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240510065856.2436870-1-fea.wang@sifive.com>
References: <20240510065856.2436870-1-fea.wang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=fea.wang@sifive.com; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 10 May 2024 09:17:57 -0400
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

From: Jim Shu <jim.shu@sifive.com>

Public the conversion function of priv_spec and string in cpu.h, so that
tcg-cpu.c could also use it.

Signed-off-by: Jim Shu <jim.shu@sifive.com>
Signed-off-by: Fea.Wang <fea.wang@sifive.com>
Reviewed-by: Frank Chang <frank.chang@sifive.com>
---
 target/riscv/cpu.c         |  4 ++--
 target/riscv/cpu.h         |  3 +++
 target/riscv/tcg/tcg-cpu.c | 13 +++++--------
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index a74f0eb29c..b6b48e5620 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1769,7 +1769,7 @@ static const PropertyInfo prop_pmp = {
     .set = prop_pmp_set,
 };
 
-static int priv_spec_from_str(const char *priv_spec_str)
+int priv_spec_from_str(const char *priv_spec_str)
 {
     int priv_version = -1;
 
@@ -1784,7 +1784,7 @@ static int priv_spec_from_str(const char *priv_spec_str)
     return priv_version;
 }
 
-static const char *priv_spec_to_str(int priv_version)
+const char *priv_spec_to_str(int priv_version)
 {
     switch (priv_version) {
     case PRIV_VERSION_1_10_0:
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index e0dd1828b5..7696102697 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -829,4 +829,7 @@ target_ulong riscv_new_csr_seed(target_ulong new_value,
 uint8_t satp_mode_max_from_map(uint32_t map);
 const char *satp_mode_str(uint8_t satp_mode, bool is_32_bit);
 
+const char *priv_spec_to_str(int priv_version);
+int priv_spec_from_str(const char *priv_spec_str);
+
 #endif /* RISCV_CPU_H */
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 4ebebebe09..faa8de9b83 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -76,16 +76,13 @@ static void riscv_cpu_write_misa_bit(RISCVCPU *cpu, uint32_t bit,
 
 static const char *cpu_priv_ver_to_str(int priv_ver)
 {
-    switch (priv_ver) {
-    case PRIV_VERSION_1_10_0:
-        return "v1.10.0";
-    case PRIV_VERSION_1_11_0:
-        return "v1.11.0";
-    case PRIV_VERSION_1_12_0:
-        return "v1.12.0";
+    const char *priv_spec_str = priv_spec_to_str(priv_ver);
+
+    if (priv_spec_str == NULL) {
+        g_assert_not_reached();
     }
 
-    g_assert_not_reached();
+    return priv_spec_str;
 }
 
 static void riscv_cpu_synchronize_from_tb(CPUState *cs,
-- 
2.34.1


