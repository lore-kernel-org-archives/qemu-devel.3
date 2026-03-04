Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FC45EF8FEA
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 13:42:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxmU3-0008FF-HO; Wed, 04 Mar 2026 08:41:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vxmT8-0007Bk-33
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 08:41:00 -0500
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vxmT3-0005Jz-VY
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 08:40:53 -0500
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-824b05d2786so5519820b3a.2
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2026 05:40:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1772631649; x=1773236449; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R+gJ1ftdbc7MnTJuyW3pS+FYRy14T0Rz76IONloUKJs=;
 b=ilsPLtnmpz4EESQCyjELNFgTBp0bPfI5HESAc6ms3X3mrdC16j7l19N57owZaQOIcb
 wOyrNJEnszUfhG94gd39itI6GpL/9CucL1ov72VSuc0ES/Q/DUlDkp6cKjfZUMM+a/Gi
 d4EJ//4LlfJGxGb7FoseC6oqDRSNu145dL4/MRIEJYr+bkxHAGQLHEaU8l+eFvgxkemz
 DKMohTAOiGWapFevxdSG4obI65sIyvJGQ/HiFEXDWqcrBQstLsg2/0okMINoMobLiJuf
 pu3Lnrc+HLjHFryD2mgRgv5C+XPS/OcNSBXUjQq0QHgyBeRSCB9T4ZzdC6uhq2+H2Be9
 vaUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772631649; x=1773236449;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=R+gJ1ftdbc7MnTJuyW3pS+FYRy14T0Rz76IONloUKJs=;
 b=EOIoz3BVmmI11zuBc79c8pNpUrhkjERb1ftbruglorJO1lE0N5/GfCl5YmTdnwnkt9
 qCUlcajGCdVZG7R1t8evw3foN1nWYcfnXBDn5Gj/V/OTbAQpY2wf7LW1z2ZZdmlt6ksH
 x6H3sxeZChWGUlkgO35Z3IOMuA0XEyHTEa9mYdmghYz01FbTY8wGTFAJfpmNSfS9voJP
 7uvcZjKF0koeDXSoW96bz9LXytznuNcCRocLYJWhr4mys/VojViFb1bUcFU7cX9Y0qtN
 K1kdXcsye2fampPXqFvSlCAvtXSIsHZJxV4myhGVnktD2N8YchrheJ+idcW34KVZd2Yl
 snkQ==
X-Gm-Message-State: AOJu0YwfqNUDmu1NZigC40pJn8ANfCStPlKTD8/3umDrCn+Dg9r7f5hI
 W2F1gyeLThPBqabAuUk90bPRFYZbHvz4XECA6REqTVI7OiscpeCZoen35bi2fPTQFRSLeZ66/+7
 IG/EOIQbPzXL9e3W19tNle4I5OzhmOzQwI7BkmXMDaKjU21BK6wnod0Vr0PS2TZqR0XsWNAjoFV
 ZRc+NO8Sk8L4XrVgpgBKk1WDr4sHu4o76xtPWmIkPpyA==
X-Gm-Gg: ATEYQzz93RgNQjCC0L/6HFBPEClRATpeBBB31dKVPNLSueigypb/JyaKxyMyvwhVcOa
 BSii4MS91/SmvC+CNwrZwlxoPvV5oizixsXHydPcTonUGdqNcZaYWZvRxVv+wsDR5k9XlQI6Vaa
 up0AzvetDQaDlgx8zObSZqLWa5F6c+wyFwlcBBy682/c5xCorg+jCRur65DLQqD5ah6mNwFBU03
 8mjCjzgsC3YOpI8stU5yWnzu3ymMnaa4PuMXMfhYgUuNNgWIXYe8z6qdnlp8nwzYv6dblV5p1nX
 ZDEIUVPu8OToXHFSOej8TALsDIuKYKFhkOeCisF70usrtF5N+j27FnPmN1Ek/SS0dvRIz0aDCSA
 r/qKUQmx3lfRhDANjx9wZQPwIzrpxRXUJx25jn3E6OTIIXgWf21l7JmcM6VDYgi4sfSKFtxwkJk
 jHDH8film6Wrq87uXL07KuCVmaYlfVAOCwiH5IBoHkEwIB0iOHaM08BzCPrPGzmo2ma0cW2fCKf
 +MeuBswF0vRYP9QCAB/fRfRDHE=
X-Received: by 2002:a05:6a00:bd93:b0:824:a635:4181 with SMTP id
 d2e1a72fcca58-8297294017emr2117580b3a.15.1772631648528; 
 Wed, 04 Mar 2026 05:40:48 -0800 (PST)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8297e11bf5dsm251921b3a.28.2026.03.04.05.40.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2026 05:40:48 -0800 (PST)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Max Chou <max.chou@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v4 11/14] target/riscv: Add implied rules for Zvfofp4min
 extension
Date: Wed,  4 Mar 2026 21:40:03 +0800
Message-ID: <20260304134006.2908449-12-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260304134006.2908449-1-max.chou@sifive.com>
References: <20260304134006.2908449-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=max.chou@sifive.com; helo=mail-pf1-x42b.google.com
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

Add implied rules to enable the implied extensions of Zvfofp4min
extension recursively.

Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/cpu.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 03eaa12028..3e655ab43d 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -2521,6 +2521,15 @@ static RISCVCPUImpliedExtsRule ZVFOFP8MIN_IMPLIED = {
     },
 };
 
+static RISCVCPUImpliedExtsRule ZVFOFP4MIN_IMPLIED = {
+    .ext = CPU_CFG_OFFSET(ext_zvfofp4min),
+    .implied_multi_exts = {
+        CPU_CFG_OFFSET(ext_zve32f),
+
+        RISCV_IMPLIED_EXTS_RULE_END
+    },
+};
+
 static RISCVCPUImpliedExtsRule ZVKN_IMPLIED = {
     .ext = CPU_CFG_OFFSET(ext_zvkn),
     .implied_multi_exts = {
@@ -2658,7 +2667,7 @@ RISCVCPUImpliedExtsRule *riscv_multi_ext_implied_rules[] = {
     &ZKS_IMPLIED, &ZVBB_IMPLIED, &ZVE32F_IMPLIED,
     &ZVE32X_IMPLIED, &ZVE64D_IMPLIED, &ZVE64F_IMPLIED, &ZVE64X_IMPLIED,
     &ZVFBFA_IMPLIED, &ZVFBFMIN_IMPLIED, &ZVFBFWMA_IMPLIED,
-    &ZVFH_IMPLIED, &ZVFHMIN_IMPLIED, &ZVFOFP8MIN_IMPLIED,
+    &ZVFH_IMPLIED, &ZVFHMIN_IMPLIED, &ZVFOFP4MIN_IMPLIED, &ZVFOFP8MIN_IMPLIED,
     &ZVKN_IMPLIED, &ZVKNC_IMPLIED, &ZVKNG_IMPLIED, &ZVKNHB_IMPLIED,
     &ZVKS_IMPLIED,  &ZVKSC_IMPLIED, &ZVKSG_IMPLIED, &SSCFG_IMPLIED,
     &SUPM_IMPLIED, &SSPM_IMPLIED, &SMCTR_IMPLIED, &SSCTR_IMPLIED,
-- 
2.52.0


