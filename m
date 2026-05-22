Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84ED9CD5BAB
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 00:06:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQDNT-0001mC-K8; Thu, 21 May 2026 20:04:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wQDNR-0001l8-Um
 for qemu-devel@nongnu.org; Thu, 21 May 2026 20:04:33 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wQDNQ-0003Pu-9H
 for qemu-devel@nongnu.org; Thu, 21 May 2026 20:04:33 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2ba17c8cfacso65844455ad.2
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 17:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779408270; x=1780013070; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Oexc3WaCAOy/tuwIEhfKj7IUvhj6ywE8pLBhOUrwZYI=;
 b=OF3wMNJGTygaP4i3rkV9xJklzWqLAZkhhs2aDFS13IGZdum+n+g/+BsO5KdEvlZUE6
 dRHeGsXDoMAJG2pXPB0q7xg0lCiO7/oBliWSaWy6Yw3BZrGyHZz/L/OlzkfPMvPiN8iy
 AlSbX7mRUMtX8P+qgCjN9V7zWjwzy0O2Gi0yzUwOb0wb7zrKQTqlERDm4zezVP/NG5PJ
 yhjbVV4sjvIeS/4bPokXXtaOMsppTKFe6tkz0FMMq+Aolrhn3OCOzapbpiZ7TGfMAoTM
 jONntK+QjGgwEO/2DM1+YfTdgXbFLKO4T4ehqH4aJT0SRD+dbaMEMA3kujwkKFBl3sqU
 /DUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779408270; x=1780013070;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Oexc3WaCAOy/tuwIEhfKj7IUvhj6ywE8pLBhOUrwZYI=;
 b=n8Af5TejrkGbkqdFkr0989qL0nBazfL0nXQVhU5ensOZmXZVoOXIdnnsv4d8nD+rTh
 ZZFe1VO3dDQVOan37bhLlPdKgo0+rDvHc4rMxYIrrYFC8VYaVQPHRKRcvEeqpaRVMDnp
 sFlKVebnMhdJuPCVmezSkekBUSnMJKqpoEUsULNiAL+Qc33gevr7G0mQgUS1XpywcD/C
 gS/yS6fjQMSH3voNmSTmp+00em8QZphLs9sxMj2+X9aYVpTgyEYGMIP7iAKW2phBsjLv
 PLfVlCqR2zcWyQKDCuYFffND+bfSZ6iStapATYTD4SFtgA1mHO54tkmHLUMOx4ORWAW6
 PR2A==
X-Gm-Message-State: AOJu0Yy5qOBhel+DFJo9jkQaF+551Xg8OdKFRHjLx4XNNoVL4pjWdakM
 QU6mPXkFze8QNb3uiepWob/i96+rpJ6fwN2SHVUtYB4upFP0+yobFjXwG/Batd03
X-Gm-Gg: Acq92OHepHOJtb3Ur8eoqAO+l1k1E91tE2AlS28JI1Wk94rElM3ImDuaqvWTt8TCNz/
 QlqSDEpG7xhTdo8CZTu+MX5S/9TgfGoJNSEpBLzu7uF+OxznRWyyr0HdAZKdz2BIja8C+SpKEXZ
 3KwAsv4p2PJAYwDdYtAq7bEFxYRYTXw50DDnjsUeuopEsPwxzZY+D92LogrdvUrcmgkyUnQzP7A
 CJpi4KlXIXraWvNiEA3rjCVYuoz9bed1Ie3syHb51R2hVrby9Q/Wp/5sot3FOsMjmTlbQmsq5xX
 7S3YmEzGbTs2nboA0eHrDq6qnALpHYiVJEhjFfvnfaktZ3qXVMpUZwdCMU1TZBUet1W9m5UOwuu
 jJcvi/dEXZ9CZy1ltFCDd0/wgc5OBDyto+Xoc2AOiM+ozrSo0bdhtbxJGEZCn4pP00vHolTHwR3
 OSIPRVK1peDiHHprjiRhGOqreE/rkAsePLHSBBpzurHg==
X-Received: by 2002:a17:903:1ac3:b0:2bc:7d1d:b677 with SMTP id
 d9443c01a7336-2beb065f97fmr11187665ad.36.1779408270581; 
 Thu, 21 May 2026 17:04:30 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beb114b54csm3915475ad.42.2026.05.21.17.04.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 17:04:30 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Zishun Yi <vulab@iscas.ac.cn>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Subject: [PULL 17/48] target/riscv/pmp: Fix integer overflow in TOR and NA4
 address computation
Date: Fri, 22 May 2026 10:02:53 +1000
Message-ID: <20260522000324.23255-18-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260522000324.23255-1-alistair.francis@wdc.com>
References: <20260522000324.23255-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62f.google.com
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

From: Zishun Yi <vulab@iscas.ac.cn>

According to the RISC-V Privileged Manual: "The Sv32 page-based
virtual-memory scheme described in sv32 supports 34-bit physical
addresses for RV32, so the PMP scheme must support addresses wider than
XLEN for RV32."

However, the current QEMU implementation uses `target_ulong` (which
resolves to `uint32_t` on RV32) for PMP address variables.  When
shifting these addresses left (e.g., `this_addr << 2`), an integer
overflow occurs, truncating the high bits of the 34-bit physical
address.

Fix this issue by changing the types of PMP address variables
(`this_addr` and `prev_addr`) to `hwaddr`.

This issue was discovered and reported by SpecHunter, an AI-driven
architecture specification analysis tool.

Link: https://github.com/yizishun/rv-isa-sec/blob/master/output/riscv-isa-manual/pr-2472/qemu.txt
Signed-off-by: Zishun Yi <vulab@iscas.ac.cn>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Message-ID: <20260511102627.3120140-1-vulab@iscas.ac.cn>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/pmp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
index 5391caa59c..a71091a316 100644
--- a/target/riscv/pmp.c
+++ b/target/riscv/pmp.c
@@ -227,8 +227,8 @@ static void pmp_decode_napot(hwaddr a, hwaddr *sa, hwaddr *ea)
 void pmp_update_rule_addr(CPURISCVState *env, uint32_t pmp_index)
 {
     uint8_t this_cfg = env->pmp_state.pmp[pmp_index].cfg_reg;
-    target_ulong this_addr = env->pmp_state.pmp[pmp_index].addr_reg;
-    target_ulong prev_addr = 0u;
+    hwaddr this_addr = env->pmp_state.pmp[pmp_index].addr_reg;
+    hwaddr prev_addr = 0u;
     hwaddr sa = 0u;
     hwaddr ea = 0u;
     int g = pmp_get_granularity_g(env);
-- 
2.53.0


