Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF27FC30653
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 10:03:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMlxG-0006QG-BT; Thu, 27 Jun 2024 06:02:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sMlxE-0006EV-Pc
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 06:02:12 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sMlxC-0001iU-NO
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 06:02:12 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-70675977d0eso3947974b3a.0
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 03:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719482529; x=1720087329; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x13WhTxcZG7M/CZkZViFdoYco9hukctsn/jx6KYUPo8=;
 b=FaY/TtcOWF2RdWwUgWTvN9GH6c8NfpwiZneO3E3/844XFtbPLxAB2/ulQv4UUId4G+
 7vwZIh9LzhBQjzgaHJWclmXX24KV3RZ1Eb2EetxqQ8vlhnRxVwxXfy0RX0G6b2l5qSQX
 a8zJpZx3wKHmkq7wGLRi5LRNjJy/+ZDa38U8P28aLQEPlG7fbChUcfvEXC0rgfLxS4nX
 S+wXWA+xNOLeQQ3BYU0JvDfIUtWSFOsULZYvzfpAQRy2ZxYVhoFYEFA+N9vn8a6OVEc+
 4nnuSBlI638qkUQ73c2nw8Xxa1DjY3+W34eADqer7zpxM8PTSMgD0nm5Dhw3GVGC3FiY
 7/RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719482529; x=1720087329;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x13WhTxcZG7M/CZkZViFdoYco9hukctsn/jx6KYUPo8=;
 b=uzERbsACf9zpT0Hhg7up4WSgTUuBX8w1VSDXnU3/baIQ+0m+K+o4A2QIPd8uPDvUzT
 MdvsehYYxiaHQTy4A1kfpMqjpGFuCcE4aG79ejTEcWRxpND2hVPkE4wLws4ZR7j6erMN
 rY4h9weqEpOqGmlyZlx7TXgfH6dOh6sfd/C+4EG3BoIuQb9ClEsTDXcW6UOl6ypKG6va
 OrisLNOvxAnYpD1fG/Ej4w0KB7L74FtMZCXn1Jy1t53Q7FWp5xCTxCKAF6xtH0hlziAG
 ri5q1z3i1jS4T1Fn4BG7DEUC819P7iO5j+nojGV11hCSvFTEY6PdLX4yfhXwKTdSIFpb
 VVCg==
X-Gm-Message-State: AOJu0YwfDgSyh/aT8e+mhxPyUidbBEWUKf3icMvagxOBEiYgm3cQ1L3K
 1a3neR1byo537pKHobql/bUM9peXkD0BAHaqm2mhQ3+W234vliZ5Fz/KYl1L
X-Google-Smtp-Source: AGHT+IGaiiOvIvsq9mFKFWmueQB73fzF7cruGF30UBAPwOZ4omNUwzBlmIR7WQ4djt/rF4Aa1aE99g==
X-Received: by 2002:aa7:92c2:0:b0:705:c029:c9a7 with SMTP id
 d2e1a72fcca58-706745b6d61mr12030306b3a.15.1719482529019; 
 Thu, 27 Jun 2024 03:02:09 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-706b4a07326sm932431b3a.111.2024.06.27.03.02.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Jun 2024 03:02:08 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, "Fea.Wang" <fea.wang@sifive.com>,
 Frank Chang <frank.chang@sifive.com>, Weiwei Li <liwei1518@gmail.com>,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 20/32] target/riscv: Support the version for ss1p13
Date: Thu, 27 Jun 2024 20:00:41 +1000
Message-ID: <20240627100053.150937-21-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240627100053.150937-1-alistair.francis@wdc.com>
References: <20240627100053.150937-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x42a.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: "Fea.Wang" <fea.wang@sifive.com>

Add RISC-V privilege 1.13 support.

Signed-off-by: Fea.Wang <fea.wang@sifive.com>
Signed-off-by: Fea.Wang <fea.wang@sifive.com>
Reviewed-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Weiwei Li <liwei1518@gmail.com>
Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Message-ID: <20240606135454.119186-7-fea.wang@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c         | 6 +++++-
 target/riscv/tcg/tcg-cpu.c | 4 ++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index fd0f09c468..4760cb2cc1 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1779,7 +1779,9 @@ static int priv_spec_from_str(const char *priv_spec_str)
 {
     int priv_version = -1;
 
-    if (!g_strcmp0(priv_spec_str, PRIV_VER_1_12_0_STR)) {
+    if (!g_strcmp0(priv_spec_str, PRIV_VER_1_13_0_STR)) {
+        priv_version = PRIV_VERSION_1_13_0;
+    } else if (!g_strcmp0(priv_spec_str, PRIV_VER_1_12_0_STR)) {
         priv_version = PRIV_VERSION_1_12_0;
     } else if (!g_strcmp0(priv_spec_str, PRIV_VER_1_11_0_STR)) {
         priv_version = PRIV_VERSION_1_11_0;
@@ -1799,6 +1801,8 @@ const char *priv_spec_to_str(int priv_version)
         return PRIV_VER_1_11_0_STR;
     case PRIV_VERSION_1_12_0:
         return PRIV_VER_1_12_0_STR;
+    case PRIV_VERSION_1_13_0:
+        return PRIV_VER_1_13_0_STR;
     default:
         return NULL;
     }
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 4c6141f947..eb6f7b9d12 100644
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
2.45.2


