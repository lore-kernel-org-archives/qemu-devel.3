Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1B91C3DA7F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2024 00:06:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sX8Kl-0000yZ-Od; Thu, 25 Jul 2024 19:57:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8Ki-0000r4-U9; Thu, 25 Jul 2024 19:57:16 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8Kh-0001Kq-6C; Thu, 25 Jul 2024 19:57:16 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-76cb5b6b3e4so292519a12.1; 
 Thu, 25 Jul 2024 16:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721951833; x=1722556633; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TQ6H5pSLiuZ7uuSY0SB7J25bCXUaO9FF8fBD9NzKeUU=;
 b=O4VgyeXZWMAIrr4Svb+vJ4BNoIU2ZoMiaOxS4iPTDQZGka0kw1BbBdyyQYDriiVd3E
 7kd1n6bQ968C6UTKvIhqEBcsjcnmF/9EiKrSSmz9GMZf940vg/fXZjMbtB3lBuMYj/Cv
 RJaUoEVf1fsNxQrpO9ho0YwG7iRxAZplQ/ZX8zf6HUIma1q+5vL8dUnEs1qRh/v56ifx
 NFaEGHa6084J8MXl6Nns9Zngcvs7conY4NPksuir2Nt44Z9xaaEmI9lEinDlhzzIIZJD
 Qb8SGyWawlAv0EwsHw2AnIqNIfDRTAIaczWaFOOEyRAYUeb4C9Iotkfmnbfwyff28YzR
 De7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721951833; x=1722556633;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TQ6H5pSLiuZ7uuSY0SB7J25bCXUaO9FF8fBD9NzKeUU=;
 b=HGKueoLxuAd2WVR5Skwievmuv7oKR+cGLyVxMyhTO7iVZBVCBzX3HNqAx3ooUVbdZ9
 CWka12MdgY4QxKG3wq9sem597cWXOSNX1tlaGIKAYRn8tNKE7cC3y9UdfKZLIuVVl7vC
 SL7AQ+8HGnPuvK5y4nGz667mV7ArfhPbQY40+qVzVSA8M9MZ/IVGD1y05ARFvKndJVeW
 2WH09RNJOJvGIMS15HaF3gPfL2w/MA3g65JFo1Pivr8EDiPa3uZ2F9rzx/+YdgPSGi8x
 /JePMBWqeBMKt9/RThocnDNvKcnN/FiwxleSjNg0cQCeLR6G5Q/XXH/oVs7OJrvk9dzE
 EfEg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4LTKFlKy8xz+OaiRBk8MqvH4cszyHgAMkLWLLSIC0J6R5D2HmF8M3opDzYvOEClFrsIU35XkqOaeaiYYq9jPBe7sq
X-Gm-Message-State: AOJu0YyCm92SiA8hlOG2ETpfMdATOgWEDjL1LQcG978qXsMh/oWQyxOK
 OcVq5dfQMrNUm4U9yTfHAwvC+Wh4BseBEEw9ieXWt1hbCi1weLCHy4f2Ag==
X-Google-Smtp-Source: AGHT+IFHJylrExSWERwp3XmXpXV6AgNpFpm2reAfVnRdndZrGUXa2la/OqREn4JL9vfrelsj+fgGow==
X-Received: by 2002:a17:90a:b118:b0:2c6:ee50:5af4 with SMTP id
 98e67ed59e1d1-2cf2e9ab0b7mr3866095a91.6.1721951833185; 
 Thu, 25 Jul 2024 16:57:13 -0700 (PDT)
Received: from wheely.local0.net ([203.220.44.216])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2cf28c7fef3sm2142060a91.16.2024.07.25.16.57.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 16:57:12 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Frederic Barrat <fbarrat@linux.ibm.com>,
 Michael Kowal <kowal@linux.vnet.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PULL 47/96] pnv/xive2: Enable VST NVG and NVC index compression
Date: Fri, 26 Jul 2024 09:53:20 +1000
Message-ID: <20240725235410.451624-48-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725235410.451624-1-npiggin@gmail.com>
References: <20240725235410.451624-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x534.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Frederic Barrat <fbarrat@linux.ibm.com>

Enable NVG and NVC VST tables for index compression which indicates the number
of bits the address is shifted to the right for the table accesses.
The compression values are defined as:
   0000 - No compression
   0001 - 1 bit shift
   0010 - 2 bit shift
   ....
   1000 - 8 bit shift
   1001-1111 - No compression

Signed-off-by: Frederic Barrat <fbarrat@linux.ibm.com>
Signed-off-by: Michael Kowal <kowal@linux.vnet.ibm.com>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/intc/pnv_xive2.c      | 20 ++++++++++++++++++++
 hw/intc/pnv_xive2_regs.h |  2 ++
 2 files changed, 22 insertions(+)

diff --git a/hw/intc/pnv_xive2.c b/hw/intc/pnv_xive2.c
index 33e76633b5..c3b5bfe61f 100644
--- a/hw/intc/pnv_xive2.c
+++ b/hw/intc/pnv_xive2.c
@@ -217,6 +217,20 @@ static uint64_t pnv_xive2_vst_addr_indirect(PnvXive2 *xive, uint32_t type,
     return pnv_xive2_vst_addr_direct(xive, type, vsd, (idx % vst_per_page));
 }
 
+static uint8_t pnv_xive2_nvc_table_compress_shift(PnvXive2 *xive)
+{
+    uint8_t shift =  GETFIELD(PC_NXC_PROC_CONFIG_NVC_TABLE_COMPRESS,
+                              xive->pc_regs[PC_NXC_PROC_CONFIG >> 3]);
+    return shift > 8 ? 0 : shift;
+}
+
+static uint8_t pnv_xive2_nvg_table_compress_shift(PnvXive2 *xive)
+{
+    uint8_t shift = GETFIELD(PC_NXC_PROC_CONFIG_NVG_TABLE_COMPRESS,
+                             xive->pc_regs[PC_NXC_PROC_CONFIG >> 3]);
+    return shift > 8 ? 0 : shift;
+}
+
 static uint64_t pnv_xive2_vst_addr(PnvXive2 *xive, uint32_t type, uint8_t blk,
                                    uint32_t idx)
 {
@@ -238,6 +252,12 @@ static uint64_t pnv_xive2_vst_addr(PnvXive2 *xive, uint32_t type, uint8_t blk,
         return xive ? pnv_xive2_vst_addr(xive, type, blk, idx) : 0;
     }
 
+    if (type == VST_NVG) {
+        idx >>= pnv_xive2_nvg_table_compress_shift(xive);
+    } else if (type == VST_NVC) {
+        idx >>= pnv_xive2_nvc_table_compress_shift(xive);
+    }
+
     if (VSD_INDIRECT & vsd) {
         return pnv_xive2_vst_addr_indirect(xive, type, vsd, idx);
     }
diff --git a/hw/intc/pnv_xive2_regs.h b/hw/intc/pnv_xive2_regs.h
index ca05255d20..e8b87b3d2c 100644
--- a/hw/intc/pnv_xive2_regs.h
+++ b/hw/intc/pnv_xive2_regs.h
@@ -427,6 +427,8 @@
 #define X_PC_NXC_PROC_CONFIG                    0x28A
 #define PC_NXC_PROC_CONFIG                      0x450
 #define   PC_NXC_PROC_CONFIG_WATCH_ASSIGN       PPC_BITMASK(0, 3)
+#define   PC_NXC_PROC_CONFIG_NVG_TABLE_COMPRESS PPC_BITMASK(32, 35)
+#define   PC_NXC_PROC_CONFIG_NVC_TABLE_COMPRESS PPC_BITMASK(36, 39)
 
 /* NxC Cache Watch 0 Specification */
 #define X_PC_NXC_WATCH0_SPEC                    0x2A0
-- 
2.45.2


