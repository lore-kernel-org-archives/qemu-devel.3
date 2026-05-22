Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6448BCD5BAF
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 00:09:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQDP0-0003Ju-FS; Thu, 21 May 2026 20:06:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wQDO3-0002TC-BC
 for qemu-devel@nongnu.org; Thu, 21 May 2026 20:05:11 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wQDNu-00046l-Lh
 for qemu-devel@nongnu.org; Thu, 21 May 2026 20:05:08 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2b788a98557so42120205ad.2
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 17:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779408300; x=1780013100; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sLP3w59uPI1h+5Tg9DYeBVDTctFHrTCt4UXdYP49vr4=;
 b=sat+WW6gQ2hmxxKcSFOYTehqmJ2XsosZWDSMrXgCqBxdk2m7FnRBTm+Wb39VJevl3Y
 AFF+cRxXt1lMfwVutVnH/XO9L/OJ1T45e1WJdVC91oZEmOoWRrez6gttlfAGnH2KyeE0
 0ZjhgTTnyWGxGcYgXb980NKoHMEcvVJeQRLLgRTUGvrMFR+xXOHqEa7H4dJL2P7Az91l
 TLD5ruZo2ZAWs0CF0MhtQ8ypXL6OGfkRsCzLu08HM0M7kVOOALEU6X0RV5Hsz+ORVt75
 gtAjkJIsICINgPCAFruSQlWbrDVwlWVCXwIa2V2D4YFLHXr4tgNqtdamtFNqMd/Cn1O4
 vO4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779408300; x=1780013100;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sLP3w59uPI1h+5Tg9DYeBVDTctFHrTCt4UXdYP49vr4=;
 b=dmw/9R7L09B9AvNjP55xtGMwJK09OuZW6LrQHIWMIeve6uM04QMNql4RzJkoyFJgR8
 PVf4uD+0aIx/YgV5/VqUR2FOHzmM1Vy05g5ydHBm04AIX09kXtk5wMorsO2KtnNlvZv/
 75Yc+6O52oPTSO6m6cdax7arytTnPiSisYeVY57zt7tmuwgQ5oVpU+5GuDyEqG6UdkDN
 /mEDcC5aSus3ejtPoz1KahAq/DM3rdwCGYNpf4k0zyljpjZmABJhtHeL7C5VG78nKGoK
 Py8UPWKl0vdkm0hVFpsZ1yHhALxTzSNiD9JnU6vvUmu6wTlSwajDQZ3akBLLZkBdqFV5
 Asnw==
X-Gm-Message-State: AOJu0Yx7bbxBcrx1OIYPoaT6EUDJOYe4kwcD2nOSSSa8WdXKRGPk6Zb/
 nvT8anAq4BqP+lmxZLbxLgugJBnYcDe/bXoW1p2doNnHSJUeuyIcjK/CnCrm/0ko
X-Gm-Gg: Acq92OGFrRvYsRhC+sTS8pMTYHk0FtqHsdh/BP4WMNAPYq8xW8/SwMqLqrZYO1b7BFL
 r8g813K6Crsg/iFzkxNXiS6IuI68u/rJnLvnIm9MtPLFihsINygRP+D9mD3hWO6z7QyKBoOIwVw
 JYvzDLQZw3S375MM4ZTbDMJUwvhg2CE9O9GfZxE7n8l4eOb1bJRkGJAUqzcOniD6rqTCF7tykL/
 Xk5tEqwBvcQQ4U8PL32YBH7MT4MowXaQTFB/FoGiyox7h5RYaOdQe/FaeBQe1QXRZhYIWfKoTjS
 kXeQaKs012Ud6wGXGKjfoIuTZEa7P/iHtxt/ITH12h3kLxA6R+xvfdNs2yTZ4/oBupn8n6LQcpj
 fPz8TjjHuByVh0RQGJCw5hUqWTcwF7Lso5wjlOGEyVus5KzipNaeQk5uCvKUAiC49v8Q6JRIABm
 LW+qHvBNRU4f/yq/aa6Aywu0XX+NpbHpYvwaGfQZ7rxjtP7YHe/eKa
X-Received: by 2002:a17:902:da8b:b0:2ba:6bd7:8efc with SMTP id
 d9443c01a7336-2beb06d173bmr10664265ad.40.1779408299902; 
 Thu, 21 May 2026 17:04:59 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beb114b54csm3915475ad.42.2026.05.21.17.04.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 17:04:59 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 26/48] target/riscv/cpu.c: add xlrbr isa_edata_arr[] entry
Date: Fri, 22 May 2026 10:03:02 +1000
Message-ID: <20260522000324.23255-27-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260522000324.23255-1-alistair.francis@wdc.com>
References: <20260522000324.23255-1-alistair.francis@wdc.com>
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

The entry was missing from isa_edata_arr[].

Fixes: 32bbab666 ("target/riscv: add draft RISC-V Zbr ext as xbr0p93")
Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260512032926.1978818-2-daniel.barboza@oss.qualcomm.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 3f4fe71c80..f8a3b3ef4a 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -255,6 +255,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(svrsw60t59b, PRIV_VERSION_1_13_0, ext_svrsw60t59b),
     ISA_EXT_DATA_ENTRY(svukte, PRIV_VERSION_1_13_0, ext_svukte),
     ISA_EXT_DATA_ENTRY(svvptc, PRIV_VERSION_1_13_0, ext_svvptc),
+    ISA_EXT_DATA_ENTRY(xlrbr, PRIV_VERSION_1_13_0, ext_xlrbr),
     ISA_EXT_DATA_ENTRY(xmipscbop, PRIV_VERSION_1_12_0, ext_xmipscbop),
     ISA_EXT_DATA_ENTRY(xmipscmov, PRIV_VERSION_1_12_0, ext_xmipscmov),
     ISA_EXT_DATA_ENTRY(xmipslsp, PRIV_VERSION_1_12_0, ext_xmipslsp),
-- 
2.53.0


