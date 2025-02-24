Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E7F6C021B6
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 08:26:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmTmD-0000io-Hr; Mon, 24 Feb 2025 03:25:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yongxuan.wang@sifive.com>)
 id 1tmTlx-0000Uf-7s
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 03:25:05 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yongxuan.wang@sifive.com>)
 id 1tmTlv-0001Em-DE
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 03:25:04 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2211acda7f6so88003185ad.3
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2025 00:25:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1740385502; x=1740990302; darn=nongnu.org;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to;
 bh=YYEOMkvva/1IHr6h82yrTDeY/QvDiMhqXdSRY7LyxdI=;
 b=ZzjgeGeniXjW/8do6Mn39fmhsG2KwTK6mdByVxEoFtFeN3kFRqv1V6YU9kUAMcQHsi
 W6rrRF66/RxGwi3kSn2+Y8aFAOr8KqNsobVrNeDYEF0PSgdSasQHk6yZW0a4tssnvJ5M
 UZ8H0YmZ9O+RmXHal/DsV9AHhH6iiR1R8RxIMhw1aBJNMA8flThbrlTlkF2N4/Lc2St/
 wExBxmti5a4BmuGCogOEjpbfqGaoDSGnCITmgg4P07Dt3n+ynodozKIZeMSX06djvyP7
 xFd+oR1M3sL7cK/a0r9ARLMTo8h3Wnb9fSPYz9NuSpJ3KRKRn8Sed86rEDiMV9ueTN6d
 /m0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740385502; x=1740990302;
 h=references:in-reply-to:message-id:date:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YYEOMkvva/1IHr6h82yrTDeY/QvDiMhqXdSRY7LyxdI=;
 b=VbkSO1mjyOG6gSnfdU02b95BANMhaamOKrjvljmbg5gJ0+Q4PQReqNvfk5Qh0Vxk0C
 Oz0UrLhfmGu70/6ZGj4fnsh8hM4wRnqW/BZoRCPLfc1DpGKzDgYKf7arSod4HPTzZfiE
 0+1l4j6mRQ/dV4PAl4HIC51syRCoP+7kvZAehCu7CjCX7tkLhrbFsTjJn0jIwn7CvHAN
 /Xe0myD730ZpD5J9JQ+1CSReeG6u/SINcpj8mkxpFAVTg7A4DGxc9ShUlSGPJaQKEtxE
 5dn8uzJYbqcaPepqUmolOodE9/CK9gySLoLSeQxj7YVcPY8q2wTE4COqvL8WKLCJCuAL
 1AOA==
X-Gm-Message-State: AOJu0YylSJfwFxNmfGo6PD9MUPuJHkg24PTWLShKvn3Jv9K8N0p/BzGs
 CU0oIBu59i9Kig3d3fyGdONSifmVJSuHrAPMTJabkYkwdsiDP4l6Gaq0dOM/eM/z/rqqAI8gsPw
 B0SJSOLMSJPl9PaDOvmVPQbWAHm8mP2g3uUsPywWzWInXMdmrucKRsCimMhrd950RYsvmjs6AfP
 uuNX0M2Bib5N4IAeKyT3ieUIKxf11X4FtSpsuPlNmlCQ==
X-Gm-Gg: ASbGncubO6S3GCHtkyJkwCjokT1BIPWNG/2dOV//gt6woZ/L3rdzRjdSuoizr4JfMkz
 b6Ax0rihjCLmJCjrEJXSYieFmc4Pyc9xJUa7ZriN06OdKSDZbzAx9Fti0xwN3q0mz06ZsZM/Q0V
 5dOSn1mFBfCaQPe2k8VlcPP/x0oP66JYRofA/dMO+l93GnPlwlWQhUMmJNr0xd8uRbZ8Okcylch
 YXsRSBsRrHs96+mdCFCqm4GlxM4z/6GhuOLG3dP2c/LQ1Q5H5u49UEgM95xe85GkLHmjE4Uux50
 WueMF3LuihWPYh/F9NqgFd9A1b6CdCEArM3NFvzqb65WkXD016JUUuhc
X-Google-Smtp-Source: AGHT+IHqru5QSjb9BmEx2XWBaNez57R75JTp0uS3W11selVagBhbIoeymiUkALT2yo/ICfOQA+nkcA==
X-Received: by 2002:a05:6a00:8c2:b0:730:7d3f:8c6c with SMTP id
 d2e1a72fcca58-73426d9002cmr18051654b3a.22.1740385501536; 
 Mon, 24 Feb 2025 00:25:01 -0800 (PST)
Received: from hsinchu26.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7325c88d74esm17714914b3a.149.2025.02.24.00.24.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2025 00:25:01 -0800 (PST)
From: Yong-Xuan Wang <yongxuan.wang@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: greentime.hu@sifive.com, vincent.chen@sifive.com, frank.chang@sifive.com,
 jim.shu@sifive.com, Yong-Xuan Wang <yongxuan.wang@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: [PATCH v2 8/8] hw/intc/imsic: prevent to use IMSIC when host doesn't
 support AIA extension
Date: Mon, 24 Feb 2025 16:24:15 +0800
Message-Id: <20250224082417.31382-9-yongxuan.wang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250224082417.31382-1-yongxuan.wang@sifive.com>
References: <20250224082417.31382-1-yongxuan.wang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=yongxuan.wang@sifive.com; helo=mail-pl1-x632.google.com
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

Currently QEMU will continue to create the IMSIC devices and enable the
AIA extension for guest OS when the host kernel doesn't support the AIA
extension. This will cause an illegal instruction exception when the
guest OS access the AIA CSRs. Add additional checks to ensure the
guest OS only uses the IMSIC devices when the host kernel supports
the AIA extension.

Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
---
 hw/intc/riscv_imsic.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/hw/intc/riscv_imsic.c b/hw/intc/riscv_imsic.c
index dc8162c0a7c9..8c64f2c21274 100644
--- a/hw/intc/riscv_imsic.c
+++ b/hw/intc/riscv_imsic.c
@@ -375,12 +375,21 @@ static void riscv_imsic_realize(DeviceState *dev, Error **errp)
 
     /* Force select AIA feature and setup CSR read-modify-write callback */
     if (env) {
-        if (!imsic->mmode) {
-            rcpu->cfg.ext_ssaia = true;
-            riscv_cpu_set_geilen(env, imsic->num_pages - 1);
+        if (kvm_enabled()) {
+            if (!rcpu->cfg.ext_ssaia) {
+                error_report("Host machine doesn't support AIA extension. "
+                             "Do not use IMSIC as interrupt controller.");
+                exit(1);
+            }
         } else {
-            rcpu->cfg.ext_smaia = true;
+            if (!imsic->mmode) {
+                rcpu->cfg.ext_ssaia = true;
+                riscv_cpu_set_geilen(env, imsic->num_pages - 1);
+            } else {
+                rcpu->cfg.ext_smaia = true;
+            }
         }
+
         riscv_cpu_set_aia_ireg_rmw_fn(env, (imsic->mmode) ? PRV_M : PRV_S,
                                       riscv_imsic_rmw, imsic);
     }
-- 
2.17.1


