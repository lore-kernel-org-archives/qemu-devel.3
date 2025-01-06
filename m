Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D73FE77198
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2025 05:45:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tUfu1-0003hg-7Z; Mon, 06 Jan 2025 00:43:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1tUfu0-0003hR-Ai
 for qemu-devel@nongnu.org; Mon, 06 Jan 2025 00:43:48 -0500
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1tUfty-0004Hm-UE
 for qemu-devel@nongnu.org; Mon, 06 Jan 2025 00:43:48 -0500
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-2f43d17b0e3so20477573a91.0
 for <qemu-devel@nongnu.org>; Sun, 05 Jan 2025 21:43:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1736142225; x=1736747025; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H/EMwbW9ao32OaXwASoWqvLNsXxITTvHnX2/S/pK7bk=;
 b=DD7VN7iZXDPBixbxaoPfg1GvzXm8toK/m3NQHNHhjYFt2wBIMM+faRM3kHlOOAiKPL
 mXbFAXf4jingnrG5wBPcsfAjDkAVLI1vv7OTxEe3Z5yWKOheow/KlwcSsRia3r4zUG50
 4xzYbDGdKd/sHyl6r/KTun6gAQtuRFnbv1V7GpsDni9p0+AYswwDSwgeqnCiLoE63b3W
 VS8fJuqoMl+YWHLiA+8m2rl5Tt1OfA9U2TjBdBuIAQYdRcnq+R7NB8x/JyhNE0nXp6tg
 1KDkpt+LUii+S4ziCf5VY3Ax17lD/VD/FI1Y0HHOEi/oHaotCL26gheJBuK0LqwsC8UG
 FVhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736142225; x=1736747025;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H/EMwbW9ao32OaXwASoWqvLNsXxITTvHnX2/S/pK7bk=;
 b=pBatcOodFNv3eaYAMX4pjpvyB+cpUWIBe1+q0lf8NiridQOWCFAueei3E+4U9JJEmj
 I2CWR2Lb6LoYGbrAYEXaUSFQDUjWE+ZhtItwKtWzVPYJikb+J22fDfr1PmkgoicNf1MA
 T1UqsvK4EjThBExi2+gTbU/mv1B1a4C1RsVqVjrxbnOpttVmOxhXvRCndvPR6OSrBZvX
 wFEkjfTlzW0AUkq4ENrrVOij2AIgEQ7sWyGWEELg8jAzHIsZ7GzP84SIBlL20b/1fYIE
 b/sDaK4OsB00oTCJnDkGTOcaxZS6RP27jDkRtUbAAURYMtlooDVpX6ibBWpZy8WI+CqP
 auPQ==
X-Gm-Message-State: AOJu0YylZP1z1jBuQtzTWgsz9i6v3pxhFJWUQM4dH6/kJsRnUldqnXqH
 hW+1CuWNku83K1O75pgIvfa+NRhH5VSp2Wk6PdE4AUGkWkW9EDcY0hW08rFAwGg/ZSfN5FUi9+9
 T9Npe/n27Hj7ALd8/ZQCjHmVhoP4UVaxrdIXBcdjsDgdjqhBQGb1AIIwzP7PCiYDOAEUJz26/sn
 Lf0eWBTXDVcu11yfhoBieWkYB85SgpKeVc/RpfQ6UUPg==
X-Gm-Gg: ASbGncsawkuymdJiwiilVwM8od3/FPj/LTXOfH5tBQ5vVKzN9wPfmit5luSTGSDD+dW
 vZcAGp6i0rlDFYz5Mqnv0uK0n+qarWXJsXeEq23qvndTZESlTp7RsYiJezrNiR4L8Xjc6zYEWz/
 iagcu+5g26d+e9xDUYCjtzM35WFuDAiOM2g3rZJwtghSZvAeuPeufEBkgTUW+++aZ7UxIHD+DNO
 gk5QbFC2jnDFhGlz+csRCm+N2aQ4NTSBAkig0n6ItM8Jlw3+6cYubk8wF9c+DxN51iAMLwzXN3D
 Dnt1Dq7RynA=
X-Google-Smtp-Source: AGHT+IEtvkda5k/jHKPGaQepjhqIYd2Hl+ttgBCcPenIceaQwpNr3fumalfhX7c3zDEYdmYSaNHjRA==
X-Received: by 2002:a17:90b:1f92:b0:2f5:63a:44f9 with SMTP id
 98e67ed59e1d1-2f5063a47b8mr17635688a91.23.1736142224491; 
 Sun, 05 Jan 2025 21:43:44 -0800 (PST)
Received: from fchang-1826.internal.sifive.com ([210.176.154.33])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc96eac6sm285722215ad.80.2025.01.05.21.43.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jan 2025 21:43:44 -0800 (PST)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Tommy Wu <tommy.wu@sifive.com>,
 Frank Chang <frank.chang@sifive.com>
Subject: [PATCH v12 1/6] target/riscv: Add 'ext_smrnmi' in the RISCVCPUConfig
Date: Mon,  6 Jan 2025 13:43:31 +0800
Message-Id: <20250106054336.1878291-2-frank.chang@sifive.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250106054336.1878291-1-frank.chang@sifive.com>
References: <20250106054336.1878291-1-frank.chang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=frank.chang@sifive.com; helo=mail-pj1-x1035.google.com
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

From: Tommy Wu <tommy.wu@sifive.com>

The boolean variable 'ext_smrnmi' is used to determine whether the
Smrnmi extension exists.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
Signed-off-by: Tommy Wu <tommy.wu@sifive.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_cfg.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index fe0c4173d2..28b43932db 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -129,6 +129,7 @@ struct RISCVCPUConfig {
     bool ext_ssaia;
     bool ext_sscofpmf;
     bool ext_smepmp;
+    bool ext_smrnmi;
     bool rvv_ta_all_1s;
     bool rvv_ma_all_1s;
     bool rvv_vl_half_avl;
-- 
2.34.1


