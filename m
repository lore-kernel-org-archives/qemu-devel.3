Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37330C25B7B
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 08:02:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s79ZE-0002cY-4I; Wed, 15 May 2024 04:00:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fea.wang@sifive.com>)
 id 1s79ZA-0002Ec-DR
 for qemu-devel@nongnu.org; Wed, 15 May 2024 04:00:48 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fea.wang@sifive.com>)
 id 1s79Z8-0006Vj-CB
 for qemu-devel@nongnu.org; Wed, 15 May 2024 04:00:48 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-613a6bb2947so5047341a12.3
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 01:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1715760044; x=1716364844; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=plUfPWk1RcWNFeTjma5GTrn41rKUM5YMo9L4XBxNpkk=;
 b=gkfXCFRtC6VDjowLjmTMKLohP9D9ISFdnUqPKJP9J83kAS0KGRhfEa3AFocJA9xgLw
 IXHjArz4A61GmoNVRTPUZRkb10bGTv7eakJ40NFExMDfZv8nse9VHq98jbXTQ8fsrfnT
 GMUmJyn6CR7JzL1f1noUCkVVKn9oed2DcyIFh1UgQj8V5IgwCKczVB2RJF7B/l3z4Z2O
 pmtWIwF//x/weQJor9FKe+0u279Lsflx5XOX9BS042RiQLFtLDl2Vy6qUy45SPoWAb2M
 pKdo0UTk0kpBjn4WEbPUgwR3uKYDDQqgT+M5VJzRqQDysrzHW5hDA9nB5bttiEJ7YelE
 hOqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715760044; x=1716364844;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=plUfPWk1RcWNFeTjma5GTrn41rKUM5YMo9L4XBxNpkk=;
 b=SxK7g46bZGzHWZGxi0oBfMvLtQDacXoczvcAis/76IMriARpKGo9bKf5DiqAfrPW77
 SDQ150aAwWRUfFEEN3kXNaeqL1vZmYE0h/eY6MRmklLgLZy0H3Jr6rLArAqNKK7rVNnQ
 SxNw68zTDLiM96n9qVfJfz9wBWzFYTGv/CGZlHm/wDAsJ0I/7jPbNfHB1XAJ31jb6w1H
 TnEk7BNXfVvdvmN+f2AEI3sE0NB3aIQSdca5V3qdee7HGjtp4dCZ+FDfFdSQvFI/rxfa
 tdeq7QRe52WSqsbhp2LGfDLyVIBluHyhsdJS7NXQRzQbS4FFEp0wzPc+JIeUiiUlGn40
 TvKg==
X-Gm-Message-State: AOJu0Yxuf7JivfFW3+xVAOFvrRX++R44ZHrl1ycb5nrtnc1PXjhMG1yL
 AJTah2SfBI7xFiwwqUD3frlh2dDFHL4fOboq+bNsLzm7NiHCOZJlja7Xtu2XEWaLIBFx5SKFsjk
 XfyhqWU783ETo3j5WN0Fh3IxatHjsOH1a6NdZsBwpYnoGRFHiZynFau7b6kTQ1BvzXpL3FOqX5c
 VJnXW76DC2lCs2hQY0JcDBijeH8cqIlLm6zNg=
X-Google-Smtp-Source: AGHT+IHdwK9HrZHtU+048ORG7yO7sAuzoM06wxvGUJ3n4iXwN1SkWXutaaPMAHc8wlUUVsrr+mjEJg==
X-Received: by 2002:a17:90a:e607:b0:2b1:f61a:4a2f with SMTP id
 98e67ed59e1d1-2b6ccd80143mr12519889a91.35.1715760044098; 
 Wed, 15 May 2024 01:00:44 -0700 (PDT)
Received: from hsinchu36-syssw02.internal.sifive.com
 (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1ef0b9d1642sm111418795ad.31.2024.05.15.01.00.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 May 2024 01:00:43 -0700 (PDT)
From: "Fea.Wang" <fea.wang@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: "Fea.Wang" <fea.wang@sifive.com>, Frank Chang <frank.chang@sifive.com>,
 Weiwei Li <liwei1518@gmail.com>, LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Andrew Jones <ajones@ventanamicro.com>, Max Chou <max.chou@sifive.com>
Subject: [RESEND PATCH v2 2/5] target/riscv: Support the version for ss1p13
Date: Wed, 15 May 2024 16:05:59 +0800
Message-Id: <20240515080605.2675399-3-fea.wang@sifive.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240515080605.2675399-1-fea.wang@sifive.com>
References: <20240515080605.2675399-1-fea.wang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=fea.wang@sifive.com; helo=mail-pg1-x52f.google.com
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

Add RISC-V privilege 1.13 support.

Signed-off-by: Fea.Wang <fea.wang@sifive.com>
Reviewed-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by:  Weiwei Li <liwei1518@gmail.com>
Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
---
 target/riscv/cpu.c         | 6 +++++-
 target/riscv/cpu.h         | 4 +++-
 target/riscv/cpu_cfg.h     | 1 +
 target/riscv/tcg/tcg-cpu.c | 4 ++++
 4 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 6dd3d7f4a3..ee2ec4c4e5 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1775,7 +1775,9 @@ static int priv_spec_from_str(const char *priv_spec_str)
 {
     int priv_version = -1;
 
-    if (!g_strcmp0(priv_spec_str, PRIV_VER_1_12_0_STR)) {
+    if (!g_strcmp0(priv_spec_str, PRIV_VER_1_13_0_STR)) {
+        priv_version = PRIV_VERSION_1_13_0;
+    } else if (!g_strcmp0(priv_spec_str, PRIV_VER_1_12_0_STR)) {
         priv_version = PRIV_VERSION_1_12_0;
     } else if (!g_strcmp0(priv_spec_str, PRIV_VER_1_11_0_STR)) {
         priv_version = PRIV_VERSION_1_11_0;
@@ -1795,6 +1797,8 @@ const char *priv_spec_to_str(int priv_version)
         return PRIV_VER_1_11_0_STR;
     case PRIV_VERSION_1_12_0:
         return PRIV_VER_1_12_0_STR;
+    case PRIV_VERSION_1_13_0:
+        return PRIV_VER_1_13_0_STR;
     default:
         return NULL;
     }
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 140eb43fcb..f691c7d828 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -96,12 +96,14 @@ extern RISCVCPUProfile *riscv_profiles[];
 #define PRIV_VER_1_10_0_STR "v1.10.0"
 #define PRIV_VER_1_11_0_STR "v1.11.0"
 #define PRIV_VER_1_12_0_STR "v1.12.0"
+#define PRIV_VER_1_13_0_STR "v1.13.0"
 enum {
     PRIV_VERSION_1_10_0 = 0,
     PRIV_VERSION_1_11_0,
     PRIV_VERSION_1_12_0,
+    PRIV_VERSION_1_13_0,
 
-    PRIV_VERSION_LATEST = PRIV_VERSION_1_12_0,
+    PRIV_VERSION_LATEST = PRIV_VERSION_1_13_0,
 };
 
 #define VEXT_VERSION_1_00_0 0x00010000
diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index e1e4f32698..fb7eebde52 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -136,6 +136,7 @@ struct RISCVCPUConfig {
      * TCG always implement/can't be user disabled,
      * based on spec version.
      */
+    bool has_priv_1_13;
     bool has_priv_1_12;
     bool has_priv_1_11;
 
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index fa186093fb..f53422d605 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -318,6 +318,10 @@ static void riscv_cpu_update_named_features(RISCVCPU *cpu)
         cpu->cfg.has_priv_1_12 = true;
     }
 
+    if (cpu->env.priv_ver >= PRIV_VERSION_1_13_0) {
+        cpu->cfg.has_priv_1_13 = true;
+    }
+
     /* zic64b is 1.12 or later */
     cpu->cfg.ext_zic64b = cpu->cfg.cbom_blocksize == 64 &&
                           cpu->cfg.cbop_blocksize == 64 &&
-- 
2.34.1


