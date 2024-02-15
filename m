Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC16EC4829E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 19:29:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rahQB-0001ne-Jt; Thu, 15 Feb 2024 14:29:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1rahQ8-0001mD-NU
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 14:29:20 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1rahPg-0004hp-DX
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 14:29:19 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1d7393de183so10668955ad.3
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 11:28:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1708025325; x=1708630125; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aY2GQ2qh0XeeuvRECl5CCzJvBtPvf5PTqd8C4F8QamY=;
 b=Lr9neBHW2U6psaW+xZqiqL3vVcdNOWTuKglnkguwba6Hl8HLtfkewIM40jsKyFPoGE
 KiPHsTMzJ0Nl9qMyfbeduW8fTQfgTufT4zeyp+hmpNoVUuocLa/nq/DCskcbr5hTCa/1
 wrcSkX5DKPjcLspGlED9lKs+Fn/uR+V+O2hLxLo/DS+84mjHYzhBxqVvFpbcCcvjVL0k
 tSniwdiEFLO0T0IcumvDvq+na85mKj7fu9qGKDZ/OB33Y7YAVz2A9gzigI3SvW4TKyTm
 hNGZbo4Ngyh/pgUoovYuNwk1S6k8Ms7+TAmDuNW4sVgbUiMmSiaPmVUWbaRB1P9m4Xuf
 o5FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708025325; x=1708630125;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aY2GQ2qh0XeeuvRECl5CCzJvBtPvf5PTqd8C4F8QamY=;
 b=a96CgphfcwdPyTKYz8kBUTuBmejnl9Trig8D1QI70J+/4URcEiUQE+X7v13fPrlNZ4
 LZNpS/UlAf9rh/P6+1N2XQvBLsIh1koPrGNkMXyhYfGqNllaoTCiuKXST6x4dxProihm
 ClJqSxLDy4HHwnyKzQ1HIsKrckCcEmE3jaw5S6QDdByGXxUnzT+W43Q+o2iHfr7r9OdB
 cWiLRkfiawDuUEM84UsdgkkkNnmCTS+64FEVihvjtcz/8YxzF1IfTO2p2YXucRPmnla6
 YhkQSm4D/6FxTneUYG1Aj/4QukpBzA0UktC4vz1Zqfl4Wcxg6Z4dZoyO4toQOnHU59Ry
 3PIA==
X-Gm-Message-State: AOJu0YzQo/gLpWXjXN7KnEN2toyI8fL6KHIJoWeY41aPxuBiGM3YGScl
 g4xU4A+X79uR1fdDxETTM4K35MvLVda/Xe3K8uTeard2By2KOHhSEyBgG5ke+BdBJ6c16o+z0tA
 stYfVuKAaW5e4tpECAz7YoxUa1Omlb8kJPdH2ceW0dW2SI0fWXTU4uKDTekxjkQG+6+6Wrc5lZX
 071WiVcXebsyNFkp1loVKKYZJ3d3NyIZFUmHStsbu5
X-Google-Smtp-Source: AGHT+IEr5o8CE3vDUoaj1VJw5ztI2DVXDsB6xUJRSWSZa/Sb69YA4XaF7abySA7YnUhjty3OTnZJig==
X-Received: by 2002:a17:903:2281:b0:1db:7052:2f75 with SMTP id
 b1-20020a170903228100b001db70522f75mr3277770plh.49.1708025325471; 
 Thu, 15 Feb 2024 11:28:45 -0800 (PST)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 u8-20020a170902a60800b001db5ee73fe9sm1618653plq.114.2024.02.15.11.28.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Feb 2024 11:28:45 -0800 (PST)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: dbarboza@ventanamicro.com, Max Chou <max.chou@sifive.com>,
 Riku Voipio <riku.voipio@iki.fi>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [RFC PATCH 4/6] accel/tcg: Inline cpu_mmu_lookup function
Date: Fri, 16 Feb 2024 03:28:15 +0800
Message-Id: <20240215192823.729209-5-max.chou@sifive.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240215192823.729209-1-max.chou@sifive.com>
References: <20240215192823.729209-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=max.chou@sifive.com; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Max Chou <max.chou@sifive.com>
---
 accel/tcg/user-exec.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index 68b252cb8e8..c5453810eee 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -942,8 +942,11 @@ void page_reset_target_data(target_ulong start, target_ulong last) { }
 
 /* The system-mode versions of these helpers are in cputlb.c.  */
 
-static void *cpu_mmu_lookup(CPUState *cpu, vaddr addr,
-                            MemOp mop, uintptr_t ra, MMUAccessType type)
+static inline QEMU_ALWAYS_INLINE void *cpu_mmu_lookup(CPUState *cpu,
+                                                      vaddr addr,
+                                                      MemOp mop,
+                                                      uintptr_t ra,
+                                                      MMUAccessType type)
 {
     int a_bits = get_alignment_bits(mop);
     void *ret;
-- 
2.34.1


