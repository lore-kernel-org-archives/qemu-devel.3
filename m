Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87B0ECCA462
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 01:06:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHWOS-00039n-7H; Thu, 15 Oct 2026 21:05:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xHWMp-0001AW-4E
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 21:04:15 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xHWMn-0004MS-EO
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 21:04:14 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2e934449bb0so20563715ad.0
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 18:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792112652; x=1792717452; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DNCxt56iwr/DwwqKZmrSCmNQKp22MBknNcXOt7cd6yc=;
 b=H8mbF+1JsLbfLKk3D3WsSiGy1zP+zLdwvzqlj4wQtnikMrl7+ucNZEFKINVOCQvQKu
 e2D2xBH5V+lu7V5wAf7/Iq+pYQ/CmL+dTQjdecb3mOBaX9VTb9i3BBDZRZBsvZH2U9b+
 dLItoJSrXMoTHkbw7xmMFF6pjEr/CdHTWyJ0rCS/CEWDaS9QK01TGCjedRInFxkmg1wQ
 maVbq1suMKh2yADsh8RGhmOc8U5kNdQV7AAsg0/EQuuw0p/Cc0KFUMAIgURvwmXcasuv
 fpUpuNIN8o9XGwyTl7W1kqhRnDoeCd3SGLBAo056tra0STrqAvYGuwPfPLfoPDdVEkmk
 mV9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792112652; x=1792717452;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=DNCxt56iwr/DwwqKZmrSCmNQKp22MBknNcXOt7cd6yc=;
 b=bAXHvGnYUrN6glzgQgw3u8zy4zO/psgHvz1HQcZUr2psWDcBXiI/Q5PfttoIPljDXD
 7TTTeBk4sG37L+tFtE1JTJuuZj4kEzZiGUrwCKshFeNK7MAfgN13bi9JYkI2eOmbHVxU
 mRbmjRU3IAzmCUeStmL1I3aqmyvAk8Xp3kh1pQuLR2sKy5AZK3Rbu3UazpzoMUGslAzE
 cpTPs9aaoCbVyEgonHvU/2ay6ueAfenBC1edcb38A9aWXv3vaSZLgYams+7s/ZqZLIDF
 LBO7ZjjNdnD8NQP96XJJ1PWldAINLWNhm01B6LEC8UBZqT89g3xjtrkfAss4huJX+OIg
 oWgw==
X-Gm-Message-State: AFq9FYK2zYEuUrGZpoc/uhFXm13hS6vc0EKGAxvjy9nBVOevukPOkJAA
 nGK7jXsB5IYEQjjW78kObm4D259y8XHFDZAQHSIoSsTgvxOxmfHE45cir1budA==
X-Gm-Gg: AYBFou1MVjjvd1oupEe7341HxlyfHlaH5+Q9ahjIPZXKaLTeREo9hZJl3ZTnRgL2H9N
 pdwgd5A9m9wwgCSNznNow80KvP8dsWaLuGwqSED9qhAIwH0VUrpALhXyXye5c8eken5IPwdH+w1
 3FSVD+7oU7AqFhNhWTKL/FRaBTu+HffHjcoTAXLXF6pAIqnFa3KVPSb6/yAzD5HA4w8+5PKiJVO
 xawojbu8bmSmaeFtszhExASmc9v5li4etxDrfIAH67y6wr7W2ZnLZQFXDWwblLgU2TWQrA0e+cw
 ey+VKlCGbVKG9VnoyznhQyinmtgiA/7qE76b2oi7BI4jGBvfmtCBbRod5GPiKzoZ3c0LJzJ/t5g
 B3sMxrFcWbcPQO8eJOn4IczTytRWLf6QfBNsz2FLZT1FtIQLfPiDJ6g7NWnc9m2qdikBlVJJCiK
 aIrfNoCGLnWp1zQgEkE+uNaYdtMf48wxQ+xeB+L9IHAEliH6q7qwRWkcdDEOIqDbz2amPZQNqvv
 mosDoOBjqz6meLp
X-Received: by 2002:a17:902:ebc3:b0:2e9:4175:3079 with SMTP id
 d9443c01a7336-2e941753b4emr68827435ad.21.1792112651849; 
 Thu, 15 Oct 2026 18:04:11 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e97e833f1asm2513995ad.43.2026.10.15.18.04.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 18:04:11 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Max Chou <max.chou@sifive.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Chao Liu <chao.liu@processmission.com>
Subject: [PULL v2 30/50] target/riscv/cpu: List one implied-ext rule per line
Date: Fri, 16 Oct 2026 11:02:17 +1000
Message-ID: <20261016010237.1102834-31-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261016010237.1102834-1-alistair.francis@wdc.com>
References: <20261016010237.1102834-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x635.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UPPERCASE_50_75=0.008 autolearn=no autolearn_force=no
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

From: Max Chou <max.chou@sifive.com>

Every entry added to riscv_multi_ext_implied_rules currently has to
reflow whatever line it lands on, since entries are packed several
per line. List one rule per line instead so future additions are a
pure append.

Suggested-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Max Chou <max.chou@sifive.com>
Reviewed-by: Chao Liu <chao.liu@processmission.com>
Message-ID: <20260927082534.3228237-3-max.chou@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 58 +++++++++++++++++++++++++++++++++++-----------
 1 file changed, 44 insertions(+), 14 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index a175817e22..f99698b83e 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -2927,20 +2927,50 @@ RISCVCPUImpliedExtsRule *riscv_misa_ext_implied_rules[] = {
 };
 
 RISCVCPUImpliedExtsRule *riscv_multi_ext_implied_rules[] = {
-    &ZCB_IMPLIED, &ZCD_IMPLIED, &ZCE_IMPLIED,
-    &ZCF_IMPLIED, &ZCMP_IMPLIED, &ZCMT_IMPLIED,
-    &ZDINX_IMPLIED, &ZFA_IMPLIED, &ZFBFMIN_IMPLIED,
-    &ZFH_IMPLIED, &ZFHMIN_IMPLIED, &ZFINX_IMPLIED,
-    &ZHINX_IMPLIED, &ZHINXMIN_IMPLIED, &ZICNTR_IMPLIED,
-    &ZIHPM_IMPLIED, &ZK_IMPLIED, &ZKN_IMPLIED,
-    &ZKS_IMPLIED, &ZVBB_IMPLIED, &ZVE32F_IMPLIED,
-    &ZVE32X_IMPLIED, &ZVE64D_IMPLIED, &ZVE64F_IMPLIED, &ZVE64X_IMPLIED,
-    &ZVFBFA_IMPLIED, &ZVFBFMIN_IMPLIED, &ZVFBFWMA_IMPLIED,
-    &ZVFH_IMPLIED, &ZVFHMIN_IMPLIED, &ZVKN_IMPLIED,
-    &ZVKNC_IMPLIED, &ZVKNG_IMPLIED, &ZVKNHB_IMPLIED,
-    &ZVKS_IMPLIED,  &ZVKSC_IMPLIED, &ZVKSG_IMPLIED, &SHA_IMPLIED,
-    &SSCFG_IMPLIED, &SUPM_IMPLIED, &SSPM_IMPLIED, &SMCTR_IMPLIED,
-    &SSCTR_IMPLIED, &SSSTATEEN_IMPLIED,
+    &ZCB_IMPLIED,
+    &ZCD_IMPLIED,
+    &ZCE_IMPLIED,
+    &ZCF_IMPLIED,
+    &ZCMP_IMPLIED,
+    &ZCMT_IMPLIED,
+    &ZDINX_IMPLIED,
+    &ZFA_IMPLIED,
+    &ZFBFMIN_IMPLIED,
+    &ZFH_IMPLIED,
+    &ZFHMIN_IMPLIED,
+    &ZFINX_IMPLIED,
+    &ZHINX_IMPLIED,
+    &ZHINXMIN_IMPLIED,
+    &ZICNTR_IMPLIED,
+    &ZIHPM_IMPLIED,
+    &ZK_IMPLIED,
+    &ZKN_IMPLIED,
+    &ZKS_IMPLIED,
+    &ZVBB_IMPLIED,
+    &ZVE32F_IMPLIED,
+    &ZVE32X_IMPLIED,
+    &ZVE64D_IMPLIED,
+    &ZVE64F_IMPLIED,
+    &ZVE64X_IMPLIED,
+    &ZVFBFA_IMPLIED,
+    &ZVFBFMIN_IMPLIED,
+    &ZVFBFWMA_IMPLIED,
+    &ZVFH_IMPLIED,
+    &ZVFHMIN_IMPLIED,
+    &ZVKN_IMPLIED,
+    &ZVKNC_IMPLIED,
+    &ZVKNG_IMPLIED,
+    &ZVKNHB_IMPLIED,
+    &ZVKS_IMPLIED,
+    &ZVKSC_IMPLIED,
+    &ZVKSG_IMPLIED,
+    &SHA_IMPLIED,
+    &SSCFG_IMPLIED,
+    &SUPM_IMPLIED,
+    &SSPM_IMPLIED,
+    &SMCTR_IMPLIED,
+    &SSCTR_IMPLIED,
+    &SSSTATEEN_IMPLIED,
     NULL
 };
 
-- 
2.55.0


