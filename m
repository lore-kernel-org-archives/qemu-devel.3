Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 926F0FED2C7
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 04:33:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0Xj2-0004WN-HS; Thu, 12 Mar 2026 00:32:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w0Xiy-0004W2-G8
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 00:32:41 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w0Xiv-0004BH-4N
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 00:32:39 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2ae4e538abdso7286795ad.3
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 21:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773289955; x=1773894755; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aocj2Vj5R7UmvfH1Q0atiy67oG5ncEAshxWbQyPErH0=;
 b=Ye1iQBumYjLqflJBok9+2h/RlBfunZpn8ZRhBakDKH6SZpu4kjihpZf0fyuukveeD0
 tDFIuSakP4lr6c2OGnvQFX8DIsd2JjGU6GcVmusVDCVWBbGM4lRaf86qRXGdgPtMesw+
 E9YljSw372K47U7E1kuLI0YLhKO9B7vnwwtGmXhpz7hEh/iZqUDEWDccOiOd+WxgBt9J
 0b3NuNnRrhVA4C/UtsTS1emluxUAr1CchrpwDej0DTtYejWj0aHStsT6Q22MYBByY6mU
 3JPD9QsxNPl6ZXKsHGI3+8ibqBXy7TwHBLz9rH0AJChIqvblOVFLza7j5/5+tBvB1p+l
 M2Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773289955; x=1773894755;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aocj2Vj5R7UmvfH1Q0atiy67oG5ncEAshxWbQyPErH0=;
 b=KRK2EXQNHjPu4YtRi/t0379GhskAMRqoSc+pmaw5iteKoU2tP4IFXwmnd5dD7UezJE
 exC3c5yYQG9A8lWXNGVJ/2r1dZHbsJAKAMm8S3CZ59ovkwXsuIoNRNw4PxAm2cGJgrdp
 K9Ok8SQQOHA9SkSn6J+pzrBTZki2RAR+PnCNb/lyuhwsUdW2fTaT7ou/Ve8YHj96+gC7
 lSZaH1Ts6kUw7oUhwSsskbjUhjeDhDwij12vD1E2vdFuaLpYXh275Cr+ZeFhtbq3h7Cs
 1ae6WbATTpwP0q+FYqH/Ppjz5TsmZBC1RFc+kqetLuJTv84VJe9mSV98DTzKmCu2dRxT
 5k1g==
X-Gm-Message-State: AOJu0YzhMkq8IESuKeN+gGNt83hwp2P5qdsdFw58GHt8puOEk1CsdY3H
 GuM9rntZF3vvVDNUzOKWuAW5cbvqwcYq3g2lND27sQWykNtVOfl6RAsEO25w4t13
X-Gm-Gg: ATEYQzyXV95Vtg1maHBeDxRViFqY9JmCD3rdX+uoIKWgRfIpOPbJcJzHkkU6ar3UO7x
 JKAGL0h9kcMthbdymTpnQRjheFujgBw7VFQwWgM+wa0Y8Xrz7DzY+n/FiKBWB3hQeV8+pPRgskY
 YxsamR+HUp/Kc4lHx6Wndk+kQWI5P/ngFl+y2nsstmtQJ+slzqZfwsg7sX0GF/AxZ54Dkuhcpu9
 LhHQUGdtqr5MeW6wzh3wOr8xV4Y3wyWjTFd10QGpHkVPGqezEjPY2xlligu96uBE3G3k14PoAye
 jHJ2tM01/E5SVZLqfYCbp0z/cAPeeckvXQFWP3yoB+KcqcM04QwdM2n0cTXJjasH61dJcbYDV6F
 FNyXMba7UoOFaJZQ9M53EVAt8hYSn2lar0tn3AdRpDSXaMfTtCQyOBjI1W6fZ2c8WuMCCkyVUoH
 wxrwKqKfvwhV1Mqq7pvfyIAo0ZXhEXZuUA5HUFUISFUQ==
X-Received: by 2002:a17:903:32cd:b0:2ae:aa16:ad09 with SMTP id
 d9443c01a7336-2aeae7d3ccbmr51238365ad.23.1773289955166; 
 Wed, 11 Mar 2026 21:32:35 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2aeae222ab6sm54340785ad.10.2026.03.11.21.32.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Mar 2026 21:32:34 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org, armbru@redhat.com, pbonzini@redhat.com,
 berrange@redhat.com, peterx@redhat.com, philmd@linaro.org
Cc: alistair23@gmail.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH 6/7] hw/arm: fsl-imx6: Don't call qdev_get_machine in soc init
Date: Thu, 12 Mar 2026 14:31:57 +1000
Message-ID: <20260312043158.4191378-7-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260312043158.4191378-1-alistair.francis@wdc.com>
References: <20260312043158.4191378-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x631.google.com
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

    ./qemu-system-aarch64 -S -display none -M virt -device fsl-imx6,help

as the machine wasn't created yet. We call qdev_get_machine() to obtain
the number of CPUs in the machine. So instead of initialising the CPUs in
the SoC init let's instead do it in the realise where the machine
will exist.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/arm/fsl-imx6.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/hw/arm/fsl-imx6.c b/hw/arm/fsl-imx6.c
index 39667c4a49..f663ddbf0a 100644
--- a/hw/arm/fsl-imx6.c
+++ b/hw/arm/fsl-imx6.c
@@ -38,17 +38,10 @@
 
 static void fsl_imx6_init(Object *obj)
 {
-    MachineState *ms = MACHINE(qdev_get_machine());
     FslIMX6State *s = FSL_IMX6(obj);
     char name[NAME_SIZE];
     int i;
 
-    for (i = 0; i < MIN(ms->smp.cpus, FSL_IMX6_NUM_CPUS); i++) {
-        snprintf(name, NAME_SIZE, "cpu%d", i);
-        object_initialize_child(obj, name, &s->cpu[i],
-                                ARM_CPU_TYPE_NAME("cortex-a9"));
-    }
-
     object_initialize_child(obj, "a9mpcore", &s->a9mpcore, TYPE_A9MPCORE_PRIV);
 
     object_initialize_child(obj, "ccm", &s->ccm, TYPE_IMX6_CCM);
@@ -119,6 +112,7 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
     unsigned int smp_cpus = ms->smp.cpus;
     DeviceState *mpcore = DEVICE(&s->a9mpcore);
     DeviceState *gic;
+    char name[NAME_SIZE];
 
     if (smp_cpus > FSL_IMX6_NUM_CPUS) {
         error_setg(errp, "%s: Only %d CPUs are supported (%d requested)",
@@ -126,6 +120,12 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
         return;
     }
 
+    for (i = 0; i < smp_cpus; i++) {
+        snprintf(name, NAME_SIZE, "cpu%d", i);
+        object_initialize_child(OBJECT(dev), name, &s->cpu[i],
+                                ARM_CPU_TYPE_NAME("cortex-a9"));
+    }
+
     for (i = 0; i < smp_cpus; i++) {
 
         /* On uniprocessor, the CBAR is set to 0 */
-- 
2.53.0


