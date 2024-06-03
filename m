Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14B15C27C44
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 11:18:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE5hS-0006Gm-M5; Mon, 03 Jun 2024 07:18:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sE5hD-0004kv-2U; Mon, 03 Jun 2024 07:17:47 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sE5h8-0006LV-N2; Mon, 03 Jun 2024 07:17:45 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1f4c7b022f8so38055835ad.1; 
 Mon, 03 Jun 2024 04:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717413459; x=1718018259; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5qcQTiAdEv5FwQ27d9xmN3ZTsEtqw8BucwxaZ316zkY=;
 b=i9EkhQFh+rK3wsLrxevdTJY2z7KLv9m2k+Gd3VrwDykomCP7jOtXMQ0+1PZhQGzjst
 zB7L9Izyum9FPCKUAqsgf5iNKgOgC7Foge0qJec6YHNR6/TXrIXKI2mGsJhUepqBxhhN
 DYRY3IF15sTg+G4ABdpXH3VolcUx+I2KkCnkrxn7AK7rK/ouUqomtF3UMj0cqQi3NKsD
 WNW3Z07GBavXDkMTff8VynklUTtk/kwYGdhyM9pwpgd7R7DLGXdmxnjQwiwDqgCC/9W3
 Ysn600JvJ0PHrmbpCxvzcqgdmwMC88f6SSg26nJzP4CySPY5kGQJ9bgSLhVJYOgORngd
 iA3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717413459; x=1718018259;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5qcQTiAdEv5FwQ27d9xmN3ZTsEtqw8BucwxaZ316zkY=;
 b=DUuISO9WLAaJ/sIK/3/n28vd9ZH0j/8lPTE3VTI/qGD7d1YyO93hEaXqTI2iR9KG7j
 52BlxGlIkPLRNiHn8MyflxxJ5Ol9LOfXXZ4nhQp52VOV6ZOHRHrO5jrMb/P2Z/BNJnHS
 1wajh2WlYIcPBrVFWgjV3K8fATrsoVfBlJTbk9aCIhkG4dlfaHC545z1qsllmdZc+WBx
 U4QgMlQDkHaMgXGKpIw04iX4Y8vUHfH2jOhWG4lhbIQFrmaHyhfDacABx0ldGswhtvvG
 0GCfiBkRxIr+Wt2nb/rX98pdnbw0Vsvry0+vXvkNe9RAIx8+Nbil/IoTCnE8+FlqTC8C
 FDiw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVAzYxcyb0JLbxBriElnPZOITcgMxkijdhQIqlLpHd9C3WwVJ5L9v+EYEkabYK4xAajvMfVIPa2q1E2jzf+zh7AWW48exBU
X-Gm-Message-State: AOJu0YzaXRNGuGBl4nTtUH5P96NYDTg8PTF9t2Lum1NHiJFun7JXUtuq
 A3iqSqX9BjyF6N/OIFf4/T+Hqq/1pEGoBltM3L+FCQ5uRbER/zL/T6+xfA==
X-Google-Smtp-Source: AGHT+IF9Cdee7jeshmcjHDKjUQVxnWbIgFwGJXO2McPQ+VxIMUzLcFKvtw7m5/rTlLVQXnegNT2onQ==
X-Received: by 2002:a17:902:d507:b0:1f4:5b00:401 with SMTP id
 d9443c01a7336-1f6370a0bb7mr97974495ad.54.1717413458677; 
 Mon, 03 Jun 2024 04:17:38 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f6323e18c7sm62375435ad.177.2024.06.03.04.17.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jun 2024 04:17:38 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Yangyu Chen <cyy@cyyself.name>,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Max Chou <max.chou@sifive.com>, qemu-stable <qemu-stable@nongnu.org>
Subject: [PULL v2 14/27] target/riscv/cpu.c: fix Zvkb extension config
Date: Mon,  3 Jun 2024 21:16:30 +1000
Message-ID: <20240603111643.258712-15-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240603111643.258712-1-alistair.francis@wdc.com>
References: <20240603111643.258712-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Yangyu Chen <cyy@cyyself.name>

This code has a typo that writes zvkb to zvkg, causing users can't
enable zvkb through the config. This patch gets this fixed.

Signed-off-by: Yangyu Chen <cyy@cyyself.name>
Fixes: ea61ef7097d0 ("target/riscv: Move vector crypto extensions to riscv_cpu_extensions")
Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Max Chou <max.chou@sifive.com>
Reviewed-by:  Weiwei Li <liwei1518@gmail.com>
Message-ID: <tencent_7E34EEF0F90B9A68BF38BEE09EC6D4877C0A@qq.com>
Cc: qemu-stable <qemu-stable@nongnu.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index a74f0eb29c..0d6fb9b4ba 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1539,7 +1539,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
     /* Vector cryptography extensions */
     MULTI_EXT_CFG_BOOL("zvbb", ext_zvbb, false),
     MULTI_EXT_CFG_BOOL("zvbc", ext_zvbc, false),
-    MULTI_EXT_CFG_BOOL("zvkb", ext_zvkg, false),
+    MULTI_EXT_CFG_BOOL("zvkb", ext_zvkb, false),
     MULTI_EXT_CFG_BOOL("zvkg", ext_zvkg, false),
     MULTI_EXT_CFG_BOOL("zvkned", ext_zvkned, false),
     MULTI_EXT_CFG_BOOL("zvknha", ext_zvknha, false),
-- 
2.45.1


