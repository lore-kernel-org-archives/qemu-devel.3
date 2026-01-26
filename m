Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 457CAD19511
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 17:49:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkQd9-0001ei-07; Mon, 26 Jan 2026 12:44:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1vkQcq-0001QD-S8
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 12:43:45 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1vkQcn-00008G-GU
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 12:43:43 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-42fbbc3df8fso2932245f8f.2
 for <qemu-devel@nongnu.org>; Mon, 26 Jan 2026 09:43:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769449420; x=1770054220; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Cksv2wEYfI04vz4eUGCQhWPSvdKN8I8JbTsxrif5bM0=;
 b=WsPlscQgisxWQBL8IdTosQN6+Avpb6SOSjRIg6a+eSV8T7DiEMD0Xpro89PjGok2zn
 jxZX+iiXfIpc07rHTAouXLj16O+3nwvu/zNbc7khGntnmaJ2+CMDBUIepq5cLFKW1jFX
 iOts2BZ+uH0zKT0Qd4PpwcpPz5mC/T2I/Xfwj/jKKH9OB1jyi+5aTMh1LOC7dKz/Ywnl
 EsG/RSk2zz1TOKc/JC7dYFkopanYMEYfXRCnjSBog9bTC5bu5GXVKYk7XCtiSW3RTNww
 HHC8kWamRw1KjqRXRQKyG/ct5PDiLOiXE59hFV3S1MiVAe4FdeNYB/kmYHZCRv0JITJ5
 kUig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769449420; x=1770054220;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Cksv2wEYfI04vz4eUGCQhWPSvdKN8I8JbTsxrif5bM0=;
 b=PBuGSdJ4O8KLSWBKhSL2uGq7nH8d5245Ei2Imfd7LJz1jUI0a3eal+S3kViCzpG4U6
 qaqeoG4edt0wiXpTgL7t99dHOXOqPk0+kATZuUZH/B7E5IIomyZWzs0bJEQ9ST+D2I46
 XgRL29r2a1aRIW9xtXet0tmfJBjPkOdqVSt/PrRtHpxSGPfAWd8y/m9MBT2FzwosLKFj
 62OtUulUfXO2VfW5EH4PlA1xMHw5oDCWFvsUGdSEGtzxGgyNrUpu/aVB8z8ekY6N+tT0
 N6DDAtmk4N/qleUeuGekRfATlzBA+0dY7NrRQ0urP799LYb/Ze4UL/vdI3sbvsnsN/o0
 /Ojw==
X-Gm-Message-State: AOJu0Yw+Ma9y8BDc2YIjJOooH/WQ+CpC2kpgolaOg7Q9MNJrSeCd8ox6
 GJ9OLHvCXSshsmoZl7MJZTx7g4WPN2VgFV3vdZ2y8a9Qyhe40oUySa947Ts2VCPc
X-Gm-Gg: AZuq6aIRqKYKR8xfwDt7QbE0LBM/iAzcnbTFVs57TF6EFYWMkempiTizS2e0u/AcwgA
 /wikdUqQQVbv7aB6eEunS8gLPrMj7Y1AsHDd/G3ALWUFcmPk2Va5gGjXXAGso30tM5dA0iH2dJr
 sLAc4QR1QkBKvZal6NR7ZXrcPOClwdreMsa57PS8j9Q0/gC6plCTpDE02Zm8bXOeYIV1D9vKsuY
 d2IP5DVoFgscY4Sj9Aj0xl+UVT0sYqoQP1ysGWfoL0SRl/awyMXUXOUB9vGCHmB0HaipZ17EzwQ
 v6DM4YltFVpqeQTKYtYxwaOBsoAfZQnF/wITb5FUCxffeJZAITvPYcutEULSJonGkwyQBoCs1Zx
 t4Y1ezkykuidjWL2ePmsMfdld0OEWuLZ0mfv62lePfjD72PmMW7ExPrT0OMQyysM3n0BLSWZHDe
 DefDlzqaVbeLxTlTWjXHjNTeD+nSNUetB0lZCIpNW/H6tsHz01qvom6w==
X-Received: by 2002:a05:6000:2509:b0:432:5b81:498 with SMTP id
 ffacd0b85a97d-435ca148113mr8878158f8f.23.1769449419793; 
 Mon, 26 Jan 2026 09:43:39 -0800 (PST)
Received: from thinkpad-t470s.. (93-143-71-105.adsl.net.t-com.hr.
 [93.143.71.105]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-435b1e71730sm34199603f8f.26.2026.01.26.09.43.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 09:43:39 -0800 (PST)
From: Ruslan Ruslichenko <ruslichenko.r@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, artem_mygaiev@epam.com,
 volodymyr_babchuk@epam.com, takahiro.nakata.wr@renesas.com,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Ruslan_Ruslichenko@epam.com
Subject: [PATCH 16/27] hw/core/fdt_generic_util: realize cpu clusters
Date: Mon, 26 Jan 2026 18:43:02 +0100
Message-ID: <20260126174313.1418150-17-ruslichenko.r@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260126174313.1418150-1-ruslichenko.r@gmail.com>
References: <20260126174313.1418150-1-ruslichenko.r@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=ruslichenko.r@gmail.com; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>

Realize cpu clusters at the end of fdt machine creation
process, as they need to be created after cpu's nodes
are realized.

Signed-off-by: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>
---
 hw/core/fdt_generic_util.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/hw/core/fdt_generic_util.c b/hw/core/fdt_generic_util.c
index 2f49909a50..83ce5b3466 100644
--- a/hw/core/fdt_generic_util.c
+++ b/hw/core/fdt_generic_util.c
@@ -158,6 +158,16 @@ static void fdt_init_all_irqs(FDTMachineInfo *fdti)
     }
 }
 
+static void fdt_init_cpu_clusters(FDTMachineInfo *fdti)
+{
+    FDTCPUCluster *cl = fdti->clusters;
+
+    while (cl) {
+        qdev_realize(DEVICE(cl->cpu_cluster), NULL, &error_fatal);
+        cl = cl->next;
+    }
+}
+
 FDTMachineInfo *fdt_generic_create_machine(void *fdt, qemu_irq *cpu_irq)
 {
     char node_path[DT_PATH_LENGTH];
@@ -173,6 +183,7 @@ FDTMachineInfo *fdt_generic_create_machine(void *fdt, qemu_irq *cpu_irq)
         while (qemu_co_enter_next(fdti->cq, NULL)) {
             ;
         }
+        fdt_init_cpu_clusters(fdti);
         fdt_init_all_irqs(fdti);
         memory_region_transaction_commit();
     } else {
-- 
2.43.0


