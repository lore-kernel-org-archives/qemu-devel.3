Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CD43D637A2
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2024 17:20:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBH0o-0000I9-AQ; Wed, 13 Nov 2024 12:18:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tBH0g-0000Ea-IM
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 12:18:30 -0500
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tBH0d-0003mm-VI
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 12:18:29 -0500
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-7245a9d0e92so802353b3a.0
 for <qemu-devel@nongnu.org>; Wed, 13 Nov 2024 09:18:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1731518305; x=1732123105; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wjMJ6Uq7LJenMqOe2Iuftby9TyEVWwxqXl1Fm+TaTQ8=;
 b=jf94k9vKt0jKCgEh4w0RhTsoqC39dTEtsD/83UKDR7OXaLigZK/b8Z+pHWnulnX5l5
 w5OcXyOiL0Re1u7ZOmXKPgwxi3cN57Y3kEGAPUG8p/njSvmzKdYsqzwAHMXq9cWccYyu
 L9INU7EGqbHYtD0mb7IIlxkZvsYnmfsmRpbqR1BX08DVtLHYAIZM+c/CfWuAhkLeqPn1
 UuuOmqynrHCVgjyUEFMvw7/5iOQjejHGkRldsufGxIi6ebxuRs4VPCbRJohZ//+fNmKI
 o4uRq/W/xDe0LoAYFHDtw11Rpn8l2enzifBGV+1ZsgyUFsWwUOOsNnKBsUXvlOO/yFnB
 Y2Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731518305; x=1732123105;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wjMJ6Uq7LJenMqOe2Iuftby9TyEVWwxqXl1Fm+TaTQ8=;
 b=IpPOgUO4Rrz6fWKigMVKJzEyMMFL6ixbOCTVg7Mash+pLwe9Vk+Nkmsa6irPY8SxwO
 zQ6mFyEjh4bSXeh1aa3OCxsRPUnRR/OC04xhUu4FUgb9ll2+6DY205JmkJ2IgvqQvHZx
 Hkve14xwrd6BqAsQ9i7Ig98bQi84trGoBNR7LOrSv9SrL9VVrpY5TDGcp7ERSHTTWAUM
 F8YcKOixA7PXKr0+O22Uvp7SJxoxpw5lUrj+yHF+YZZNcKTFBSUNFI1WANG93MprLXYn
 gnBBrSD6h1Eqq/iK7jJ3aK4iWMooe4st1nRkcMrHB2Zq1D/fQl+oT3WL8cX+ik2ds2Wv
 UmSQ==
X-Gm-Message-State: AOJu0YzG4U+zUZODk7eslxIDZD3LA+w4jRyOuF86X+Vu2FzGu/WaCJnF
 fjVmq/ab7MJmKr6JBd1pV+Cd43KscEZNlCNcm/Ev7KbnJ6LK9FeHQwoxPPEnZ5RBuBS+aokvbOe
 v
X-Google-Smtp-Source: AGHT+IGarIYB5NsHnbu2KyN/DKWvMxd7PL3UHYhfdroQD5QPsRgaAs9djSjpQ2rcRRGlDT+6fQi1tQ==
X-Received: by 2002:a05:6a00:998:b0:71e:3b8:666b with SMTP id
 d2e1a72fcca58-724579c5ff7mr4404549b3a.15.1731518304940; 
 Wed, 13 Nov 2024 09:18:24 -0800 (PST)
Received: from grind.. ([187.101.65.72]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-724078a9063sm13392889b3a.75.2024.11.13.09.18.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Nov 2024 09:18:24 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH for-10.0 7/9] target/riscv: add shvsatpa
Date: Wed, 13 Nov 2024 14:17:53 -0300
Message-ID: <20241113171755.978109-8-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241113171755.978109-1-dbarboza@ventanamicro.com>
References: <20241113171755.978109-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x430.google.com
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

shvsatpa is defined in RVA22 as:

"All translation modes supported in satp must be supported in vsatp."

This is always true in TCG so let's claim support for it.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/cpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index ae5676976b..068b019564 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -185,6 +185,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(zhinxmin, PRIV_VERSION_1_12_0, ext_zhinxmin),
     ISA_EXT_DATA_ENTRY(shcounterenw, PRIV_VERSION_1_12_0, has_priv_1_12),
     ISA_EXT_DATA_ENTRY(shtvala, PRIV_VERSION_1_12_0, has_priv_1_12),
+    ISA_EXT_DATA_ENTRY(shvsatpa, PRIV_VERSION_1_12_0, has_priv_1_12),
     ISA_EXT_DATA_ENTRY(shvstvala, PRIV_VERSION_1_12_0, has_priv_1_12),
     ISA_EXT_DATA_ENTRY(shvstvecd, PRIV_VERSION_1_12_0, has_priv_1_12),
     ISA_EXT_DATA_ENTRY(smaia, PRIV_VERSION_1_12_0, ext_smaia),
-- 
2.47.0


