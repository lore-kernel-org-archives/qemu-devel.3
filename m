Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFBD5C27C52
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 06:33:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEkC5-0000qF-Bf; Wed, 05 Jun 2024 02:32:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1sEkC3-0000pu-4t
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 02:32:19 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1sEkC1-0007DH-LE
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 02:32:18 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-6f8ec7e054dso4468150b3a.2
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 23:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1717569135; x=1718173935; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2MCGoy4AY3BGS3+IW2ec2T3KfBFGkFZbhEPH8gR9eZo=;
 b=UoAQ6ZFQwUSg0MmxaF3nYyFjtXAohyRJLzK1LWlvak7pvpZ2sts4l0VnLCO0af2SXC
 ZmiPUp/txG1tq5XHf/7jrpzllI6ZWmUAgsqHFXTNp421zNdl/47WyV0nKsreWdK+BtQD
 o7WnvrfY4ItSemu6j5MPaXsNv1xX6XtRTiXAUxn6dI5qggFeQE1uyongldyo6zMVhox9
 M6RCpxHi7ykYmNqFzds/Sv7J1MqN90Yjf3349KOwCTQT2B8h+91hBuemuj6QwLmwWubN
 uhqdHfeC7JvQO1ZocGQt+RkIcS7IE8QTtFE4xJKlSlhPiFN4g2NufUFHhdrAtYL/gH7P
 oNcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717569135; x=1718173935;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2MCGoy4AY3BGS3+IW2ec2T3KfBFGkFZbhEPH8gR9eZo=;
 b=EVGAz/0E5dVsgx+ocHA0J7pvsVMvNFjmvceOvZGLjayJGzSMwI72lr1AkjgEWXC7A/
 VCUi1dGHONdQ2Jww1gQLNs0M4S4LGhryHztmBHNapAUc+3b+/sNNLz5FZSFtu4iqJDii
 syZRz4S7N+AMmhFOWXukRaWLYoXFDkphpfQBMuQcTpxHKol+UxyB1asDEHM4xiMY51d2
 rw/F3yVKxbyaHZ2XME3bZbqIPTXHQaT/27hWC6hsYjP+ZMLrB54s8090uoexyvwqKr6i
 XIqA7avdrBSEFyhfoyekMpd99TeolIrjJ6QHM0mw1TNdzCVpbIsxKIqjaKar82VjrjeQ
 5zsg==
X-Gm-Message-State: AOJu0YzIC+0JtTjYHpSE4SWKgki6Ijrk2O7VAjjOI+YSYfXSdRqMglrL
 wzaP7G4Qf640U05UOV5U+hbVoKEl9ngrM3Ov/AE4b48LkBKDNxuTAa7EJKFqMbh/kcTVKepUyDe
 4qODRNdBVk6p/93NUCOcnd5hfTn7bCl6za324RPdaOMHueSx5OPVAyc/a/M84i83et+3cosvoQL
 pHlwZ+BYoX1UxJTT2lyRlse66KxT71pHUFZP3ZJhLEjA==
X-Google-Smtp-Source: AGHT+IEKVn7ctHMFwVjIrhfCmWUcLZzdKvRYkzVauS/LgY30+jyGNonvPs8AoQASmPOJARwqndit3A==
X-Received: by 2002:a05:6a21:318b:b0:1b2:91a0:6255 with SMTP id
 adf61e73a8af0-1b2b71b5cdbmr2359579637.62.1717569134980; 
 Tue, 04 Jun 2024 23:32:14 -0700 (PDT)
Received: from hsinchu16.internal.sifive.com
 (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f632356c84sm94819725ad.76.2024.06.04.23.32.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Jun 2024 23:32:14 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 qemu-riscv@nongnu.org (open list:RISC-V TCG CPUs),
 Frank Chang <frank.chang@sifive.com>
Subject: [PATCH RESEND 3/6] target/riscv: Add MISA implied rules
Date: Wed,  5 Jun 2024 14:31:51 +0800
Message-ID: <20240605063154.31298-4-frank.chang@sifive.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240605063154.31298-1-frank.chang@sifive.com>
References: <20240605063154.31298-1-frank.chang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=frank.chang@sifive.com; helo=mail-pf1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

From: Frank Chang <frank.chang@sifive.com>

Add MISA extension implied rules to enable the implied extensions
of MISA recursively.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
---
 target/riscv/cpu.c | 50 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 49 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index c7e5cec7ef..a6e9055c5f 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -2242,8 +2242,56 @@ RISCVCPUProfile *riscv_profiles[] = {
     NULL,
 };
 
+static RISCVCPUImpliedExtsRule RVA_IMPLIED = {
+    .is_misa = true,
+    .ext = RVA,
+    .implied_exts = {
+        CPU_CFG_OFFSET(ext_zalrsc), CPU_CFG_OFFSET(ext_zaamo),
+
+        RISCV_IMPLIED_EXTS_RULE_END
+    },
+};
+
+static RISCVCPUImpliedExtsRule RVD_IMPLIED = {
+    .is_misa = true,
+    .ext = RVD,
+    .implied_misas = RVF,
+    .implied_exts = { RISCV_IMPLIED_EXTS_RULE_END },
+};
+
+static RISCVCPUImpliedExtsRule RVF_IMPLIED = {
+    .is_misa = true,
+    .ext = RVF,
+    .implied_exts = {
+        CPU_CFG_OFFSET(ext_zicsr),
+
+        RISCV_IMPLIED_EXTS_RULE_END
+    },
+};
+
+static RISCVCPUImpliedExtsRule RVM_IMPLIED = {
+    .is_misa = true,
+    .ext = RVM,
+    .implied_exts = {
+        CPU_CFG_OFFSET(ext_zmmul),
+
+        RISCV_IMPLIED_EXTS_RULE_END
+    },
+};
+
+static RISCVCPUImpliedExtsRule RVV_IMPLIED = {
+    .is_misa = true,
+    .ext = RVV,
+    .implied_exts = {
+        CPU_CFG_OFFSET(ext_zve64d),
+
+        RISCV_IMPLIED_EXTS_RULE_END
+    },
+};
+
 RISCVCPUImpliedExtsRule *riscv_misa_implied_rules[] = {
-    NULL
+    &RVA_IMPLIED, &RVD_IMPLIED, &RVF_IMPLIED,
+    &RVM_IMPLIED, &RVV_IMPLIED, NULL
 };
 
 RISCVCPUImpliedExtsRule *riscv_ext_implied_rules[] = {
-- 
2.43.2


