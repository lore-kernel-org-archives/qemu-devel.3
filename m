Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9159CD5BB4
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 00:08:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQDQe-0006Df-1t; Thu, 21 May 2026 20:07:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wQDOQ-0002xc-CF
 for qemu-devel@nongnu.org; Thu, 21 May 2026 20:05:40 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wQDOL-0004kf-P0
 for qemu-devel@nongnu.org; Thu, 21 May 2026 20:05:34 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2bccb978bd9so46070475ad.0
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 17:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779408327; x=1780013127; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U9JBdFb8MfQaCnWXCpU/y4W6ZpR7jAtIYTHy49SGUZA=;
 b=sm8E5sL8WwD1Fh7OSiC0/rLDpZgFVdrsghnYRwS/EhkPIGiGC+vgSwevX/Ng+JAn7s
 yGjFZlZkM2JXL5SHuzXYGZwfrar85ft9yXdUsK8Hamye7Qm3LPCQ2LT2uqunEspIpKgQ
 WTpgR+PEJGdQeQ0DwGgzSbsaZUfjoKMqAEB53nuEMM0qjiaQx1C5acRdUhtO+bo/YoAw
 KDIVFG4fapl2pUwfpAAypOP5/87m5eZsx/DH7930DGQuC3Hn5MPDbeqPgxHKK8XB6Z38
 9/25UcGvPKx3eGRfVvYg56zxede+jmBElEK1g4RJPtR7701h9w+QbIJueYsgZvL4kvnK
 7EtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779408327; x=1780013127;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=U9JBdFb8MfQaCnWXCpU/y4W6ZpR7jAtIYTHy49SGUZA=;
 b=FTZso4y5iQhKBZeu4iCV4uK1chABCE8XIu887n/HI6jXwBL9rM+zZpZYHaSDnC1s8C
 /i6VBGSvu8Q+GsFOQTE4SxhvIVNI2bBZ+SLCTXml1MsJUsxlAadIgb2euhts2hgjeRN2
 v0WxKRJhw3CrLfrDkh2GB1VQJLUQlOa2uYcy0g2S66s6EGO7/F/31+aUuc3njWip0DQ3
 4yIXIvJYvkef6c3zU361dVm1Y7XlyI+5jFhXCvJ8BeNjLkduZN9Fl6XpYsNIHA6Xo7Er
 ek6Sp1tc/ryVROAuusSaCsamADUFP1fRP/t9pCbkBB14CvY1imEb9/jKXFIlS7Eca2XM
 FV4g==
X-Gm-Message-State: AOJu0YwysJ/ioqMGSrvYU25x++vP36+201nCNdoHcq85RhEVCQT3WKPn
 DgO2u8Gvc1PC2xsuu/hCxNapaV3cdzyafSop/ANjHVGGC13BWKFRP85JY4U7OySu
X-Gm-Gg: Acq92OGiAgPQSXw7qTwC3QQnh4WzS7yLVW62cLXgYYN15whh4EAdNEythTWjh98tuy/
 XcZDHEXAWZucT4r56Twlnmn6Yc6gpL53lWJI94pWG+xLBqho3zRaZfJprHvoU6+tb5/u0S4HxbE
 0aCmkdr9BJrAFEvs0JVn/9yZn8DqjjzPxUb7LdQP8BTU1IMK9wWux/gSEgRu44oPVPKrjj+eg/N
 0S8hPXJu8XRICuodFgcgxaUmbu3UsPMQYl+rX3fz/0iyArTu4HM5WG5VsLJM5ohdnZt2/AE/Ozz
 ZDLb7XJET5U3m+92fO+DBqb7Z3LuOvZLPfzQ2nnZ3CcPZ9X7lJ4+01mYlsUr1CtejZ355fdeOBS
 1VPPrVUORhkC2krDki2INC89oaAq3T/aiR8bj8YD/q86KgbL8DIK8x/pGVeI+La2KfJd57T+OVL
 g7FtclEG49haQwgiHICrh+kVDosZ+Dr3qWk1pJek1X1TTb6vuyR+A4
X-Received: by 2002:a17:902:e78e:b0:2bc:977b:846d with SMTP id
 d9443c01a7336-2beb07b5161mr7131415ad.5.1779408327346; 
 Thu, 21 May 2026 17:05:27 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beb114b54csm3915475ad.42.2026.05.21.17.05.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 17:05:26 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 35/48] target/riscv/tcg: use isa_edata_arr[] to enable max exts
Date: Fri, 22 May 2026 10:03:11 +1000
Message-ID: <20260522000324.23255-36-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260522000324.23255-1-alistair.francis@wdc.com>
References: <20260522000324.23255-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x630.google.com
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

From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

Use isa_edata_arr[] to enable all feasible extensions.  Filter
experimental and vendor extensions by checking if the riscv,isa or the
prop name starts with 'x'.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260512032926.1978818-11-daniel.barboza@oss.qualcomm.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/tcg/tcg-cpu.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index b7d59f40f2..eb48a76a6d 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -1614,13 +1614,18 @@ static void riscv_init_max_cpu_extensions(Object *obj)
 {
     RISCVCPU *cpu = RISCV_CPU(obj);
     CPURISCVState *env = &cpu->env;
-    const RISCVCPUMultiExtConfig *prop;
+    const RISCVIsaExtData *edata;
 
     /* Enable RVG and RVV that are disabled by default */
     riscv_cpu_set_misa_ext(env, env->misa_ext | RVB | RVG | RVV);
 
-    for (prop = riscv_cpu_extensions; prop && prop->name; prop++) {
-        isa_ext_update_enabled(cpu, prop->offset, true);
+    for (edata = isa_edata_arr; edata && edata->name; edata++) {
+        if (edata->name[0] == 'x'
+            || (edata->prop_name && edata->prop_name[0] == 'x')) {
+            continue;
+        }
+
+        isa_ext_update_enabled(cpu, edata->ext_enable_offset, true);
     }
 
     /*
-- 
2.53.0


