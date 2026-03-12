Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54A36FED2C7
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 04:33:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0Xis-0004V0-3q; Thu, 12 Mar 2026 00:32:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w0Xio-0004Ub-H7
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 00:32:30 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w0Xim-00043n-Sv
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 00:32:30 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2ab46931cf1so13509465ad.0
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 21:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773289947; x=1773894747; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NziXTQ1sf7fWxugAcH7uSw0+8ApDkk8bxbN24KNdpBI=;
 b=TPtvEI4eYPcNP2Ouv5ydhtnV5/C8gqw6eDwtsn+gG0ECI4rwuVFdlphF6Y3Ku6279G
 8KFw7xdE1auu/wV+ZqLLp1j2CHF6hTsQxzpw/LUFGWBYAYf+J+eox4nO9Vlr1OPOBnyy
 XPudJlXSDDEjK8w4gTcLg0kyj9s3b0t1gVbKHMol8YMYtmkIpN/+xPZyTQRxE+R1URRc
 MbcYh8IJPOHW0YJt62SSl44ZuV7BRRdmLYYQ9MigDmBtshCodOdjbCHm9hlZwEbKt76t
 oPrUu+Q7pwpQbWYHranUtP/jLd90KmORjo0Yz03GJXVeHTtCdlKBLNKPnUo6knYf8JpL
 wEyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773289947; x=1773894747;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NziXTQ1sf7fWxugAcH7uSw0+8ApDkk8bxbN24KNdpBI=;
 b=N/bVvH5w1R2hEVYsruT8gQujP9jS3XAOnxg7Ag0qU+OnJdB9uaa8e8mb0Imc5fEQCp
 b88y8+mX9Adhef8qtW+y1yjG6cQQkOacDzzPQy2CIbhF2LMdU9N2KdowYvv76Hpqc2NY
 6RE+yYRt7Fkr9MF1RT+cVygUl6ptdBgogeWCUUkWZ3HLrkUHXVsRhDkveGmKGzZWz9qW
 s7TLOHY34n88HtZz3Vi4LSywSUCpUMLnq4MCuZx7muDSQoRGdq2WPaScYIYshmjLhxxN
 DNRW9TH7rX2UiXnBIxjhq2+tPSJYAC3Bkb3zRt+MpztKOESO1L6pCKFv41VHcd3RdHeX
 ZvHQ==
X-Gm-Message-State: AOJu0YwdH3sJ2XXgU1t/jy62yt4HG1nJfmriRroq5lym92R3FoMtanId
 KetMw/ygVs/w5RYlEkh3/pp5mIF37rvlDDOcOK0xe2/+HVkgjlTzGlH90Nx2MXVd
X-Gm-Gg: ATEYQzxNka+LX25yXEyoBu7oeHeUFfv7qmKI7N2ueZr/r+ZnmG/NDhPoJJ+HC7OLIPn
 neh89HEpqpXImWR8WsW0SvfW2T6iKXNpSCPM6Fn3bNmAZdHj6cEUo2phm34WuYzNETz8TT+nHAm
 BY0eMMpIBbpePrVqD61TxQ/J0Oh7VN6fyFYzXObH0u/cEWG+ABF+nFMlMxu9E1ERRl2m1TAoUl4
 JxtIHH5mzm25UIdBP/KyPEj7XtyKR85aQY58FpmF2W3ahvvUVA8xUle045PsCDOH6zkn5WR50l8
 snFxNeN3IC6zMJg9gXvGZO/heNHINyPOKbZKi765HY2TM7mKiSE3pGkDk8TG2NhG3OBEYPq9tDD
 U3/sBYJS37ofzu+qKD8H2mQ39KEy3csHFP8KmGF6tmbIbn7ZVTtiFFMWkE50P3zSUVAYSdg+Zdl
 9cabdsxpZ4H5sp125l13UWBYcw0vWwIs1vzQzdtjowvQ==
X-Received: by 2002:a17:903:32cc:b0:2ad:b213:feba with SMTP id
 d9443c01a7336-2aeba4416d2mr18412685ad.5.1773289947113; 
 Wed, 11 Mar 2026 21:32:27 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2aeae222ab6sm54340785ad.10.2026.03.11.21.32.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Mar 2026 21:32:26 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org, armbru@redhat.com, pbonzini@redhat.com,
 berrange@redhat.com, peterx@redhat.com, philmd@linaro.org
Cc: alistair23@gmail.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH 4/7] hw/arm: fsl-imx7: Don't call qdev_get_machine in soc init
Date: Thu, 12 Mar 2026 14:31:55 +1000
Message-ID: <20260312043158.4191378-5-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260312043158.4191378-1-alistair.francis@wdc.com>
References: <20260312043158.4191378-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62e.google.com
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

From: Alistair Francis <alistair.francis@wdc.com>

Calling qdev_get_machine() in the soc_init function would result in
the following assert

    ../hw/core/qdev.c:858: qdev_get_machine: Assertion `dev' failed.

when trying to run

    ./qemu-system-aarch64 -S -display none -M virt -device fsl-imx7,help

as the machine wasn't created yet. We call qdev_get_machine() to obtain
the number of CPUs in the machine. So instead of initialising the CPUs in
the SoC init let's instead do it in the realise where the machine
will exist.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/arm/fsl-imx7.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/hw/arm/fsl-imx7.c b/hw/arm/fsl-imx7.c
index 9a230d222f..2defa498d3 100644
--- a/hw/arm/fsl-imx7.c
+++ b/hw/arm/fsl-imx7.c
@@ -32,20 +32,10 @@
 
 static void fsl_imx7_init(Object *obj)
 {
-    MachineState *ms = MACHINE(qdev_get_machine());
     FslIMX7State *s = FSL_IMX7(obj);
     char name[NAME_SIZE];
     int i;
 
-    /*
-     * CPUs
-     */
-    for (i = 0; i < MIN(ms->smp.cpus, FSL_IMX7_NUM_CPUS); i++) {
-        snprintf(name, NAME_SIZE, "cpu%d", i);
-        object_initialize_child(obj, name, &s->cpu[i],
-                                ARM_CPU_TYPE_NAME("cortex-a7"));
-    }
-
     /*
      * A7MPCORE
      */
@@ -179,6 +169,15 @@ static void fsl_imx7_realize(DeviceState *dev, Error **errp)
         return;
     }
 
+    /*
+     * CPUs
+     */
+    for (i = 0; i < smp_cpus; i++) {
+        snprintf(name, NAME_SIZE, "cpu%d", i);
+        object_initialize_child(OBJECT(dev), name, &s->cpu[i],
+                                ARM_CPU_TYPE_NAME("cortex-a7"));
+    }
+
     /*
      * CPUs
      */
-- 
2.53.0


