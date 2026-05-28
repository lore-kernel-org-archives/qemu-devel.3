Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 376ECCD5BD1
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 06:00:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSTn5-00007l-3F; Thu, 28 May 2026 02:00:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1wSTn2-00006Y-HM
 for qemu-devel@nongnu.org; Thu, 28 May 2026 02:00:20 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1wSTn0-0006Jy-Lx
 for qemu-devel@nongnu.org; Thu, 28 May 2026 02:00:20 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-36a35e4eefeso5052115a91.1
 for <qemu-devel@nongnu.org>; Wed, 27 May 2026 23:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1779948017; x=1780552817; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=xUTCP8FFqBSgq1JOzqKvtPUl2UPI6qYQMOfZtf9+WHA=;
 b=lGRq6kknBe6U+Z+wK5jnXTZbUDxKxwcInIm+EeThbg1TJRV+XXc8f99SpginyM33LQ
 jiC6CuR181CfqRIatqH4gCemOURdk+dgplCUf1Th4mmbmon1UTyDsSAULx1j3PjF/OK+
 x7ucxP8ArE7FIey9t8vFVGC7j9vxuGGucuDeWmqKZ1rtO7pYAvIIVOeulF6pTtWscqbD
 +WpHOSxGnC73+1iphO8eQNghP7fSzfU2/0o7STPjxNB/UCHylwal3AsLPbWm4qbXAkC/
 buE+GOLs6vjJ6dAVTw2tbf0HzSc2DdZS/fnX3I0M+RXkavce92Tpjxb46FQxvI7ep1V0
 CNWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779948017; x=1780552817;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xUTCP8FFqBSgq1JOzqKvtPUl2UPI6qYQMOfZtf9+WHA=;
 b=fY4E6j2Pp7ZrSRF2MURiaC5tyKrymvYh/VkCFfwmmMES8tJmps/0O11nCCpP6L7VOA
 hk7DQ6vvRu5ZoMiTh8sesq4Ps8nuWd63C890y1wBqY2MUf3U/5tTTUnv+RgjY76wTzMh
 +ebuXK0wIYeiQSaTFx10po0Vb9tl7n4xpZh86T+ay8kfl6VODupm9si8UIdOJw8YHLDp
 1q5HNxMUrfZJBVO/qFXzeQlcy9GQTfljx+2KDOUB8D4ErJYSMGXX20mE/a3VJTfZI9Ii
 Te2Q+a7e8QcMwvOKp5qw5vhJLeEsaD1d1mg48TQB1joawWCFPn+5baS2PeIft17r1cAL
 Soqw==
X-Gm-Message-State: AOJu0YwlADmxNBQ/6YvevJilQ4KYyh9+rDM9xTahTbYzkuSFP+DRKOZz
 lbZqLECmurRQpF+BgizpsOaVp8TuyErwN1NWBOzzrJoi/A3e2Y6pteEBe0I575HSy9fQ1mwF/CZ
 NGUsSPKu104wyp9q7R3MlWttJkcop/v4+w7jJ4Z6tzMYJ30hpWROL8KWkXfBdOkLLQysvtvCB4v
 CVzRxoqcFoTuYxDDLNf9n8/rGiq0MeoimIopmHCIEV5Col48c9
X-Gm-Gg: Acq92OHO7zWXL6gnKhlZ5Fp6m0WFKFex5ajQCnZjC+nl/GUJgktp2OFvEbvtITx1c16
 nQIiAzYwaDW9ML9Zw3EjvjAGbpjyRItaEm890l5/2KEh59FA/B3TDTP7bsg0QMMzJjK/3MIg1lb
 JnVAR4KsmsC7q69Vs+Lb0pZJholHkOz8MK+iJMhqosOnmTa/OI+qbpqF0VTCnEmaFloUb2LwnGm
 2FMtBTPG9fen0iJ7rfgms/TdSXInSY3Cv5azu7lSMGJU1gMPAdEtTqp5ba/X/U1ljeLWqsXVH2G
 cNz4VWLBZHk3eEYj7Zqk0BDNbirE0rJrKOTkmWPs4F7fwJrKjSjlAqpDwPSLefpfnrgpQpjcA/z
 3WNqY2u2+6CQKb4aufHsmxQ1KqtBprf6XUShpbdPDpf+DsScvxw68Ji4xe3N9ruHBUmXF0lBUcL
 pqoIDdzcE1hpErT5BrM8cNke6eja5PVMjEM4cUxT7aFXPLxES6GBwgsifBHgjm
X-Received: by 2002:a17:90b:1a84:b0:368:6998:b49e with SMTP id
 98e67ed59e1d1-36a6745ccccmr25036771a91.9.1779948016287; 
 Wed, 27 May 2026 23:00:16 -0700 (PDT)
Received: from hsinchu16.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36b90d23ef2sm646108a91.17.2026.05.27.23.00.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 May 2026 23:00:15 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 qemu-riscv@nongnu.org (open list:RISC-V TCG CPUs),
 Frank Chang <frank.chang@sifive.com>
Subject: [PATCH] target/riscv: Reorder Smrnmi CPU fields above CPU reset line
Date: Thu, 28 May 2026 14:00:07 +0800
Message-ID: <20260528060007.717307-1-frank.chang@sifive.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=frank.chang@sifive.com; helo=mail-pj1-x1033.google.com
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

From: Frank Chang <frank.chang@sifive.com>

Smrnmi CPU fields introduced by commit: #5db557f should be reset when
the CPU resets, so move these fields above the CPU reset line.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
---
 target/riscv/cpu.h | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index d9c1e000cb2..682c6e752cc 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -491,6 +491,15 @@ struct CPUArchState {
     uint64_t hstateen[SMSTATEEN_MAX_COUNT];
     uint64_t sstateen[SMSTATEEN_MAX_COUNT];
     uint64_t henvcfg;
+
+    /* RNMI */
+    uint64_t mnscratch;
+    uint64_t mnepc;
+    uint64_t mncause; /* mncause without bit XLEN-1 set to 1 */
+    uint64_t mnstatus;
+    uint64_t rnmip;
+    uint64_t rnmi_irqvec;
+    uint64_t rnmi_excpvec;
 #endif
 
     /* Fields from here on are preserved across CPU reset. */
@@ -509,15 +518,6 @@ struct CPUArchState {
     uint64_t kvm_timer_state;
     uint64_t kvm_timer_frequency;
 #endif /* CONFIG_KVM */
-
-    /* RNMI */
-    uint64_t mnscratch;
-    uint64_t mnepc;
-    uint64_t mncause; /* mncause without bit XLEN-1 set to 1 */
-    uint64_t mnstatus;
-    uint64_t rnmip;
-    uint64_t rnmi_irqvec;
-    uint64_t rnmi_excpvec;
 };
 
 /*
-- 
2.43.0


