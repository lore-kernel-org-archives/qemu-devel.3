Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70A81FED2C7
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 04:33:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0Xiv-0004Vd-F5; Thu, 12 Mar 2026 00:32:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w0Xiu-0004VL-2V
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 00:32:36 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w0Xir-00044w-SQ
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 00:32:35 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-c73bbdc01b7so183571a12.2
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 21:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773289951; x=1773894751; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jQMrNml6U9cDIhsQ5mDwSAwjyDPFJNp8soUiNVdW58g=;
 b=T75gldbsIxizLC5v0/XWLQCt4hS43ktucCRos8tmp9s16sSPCXAicoxjwk7FF6dd+q
 N1L1yWp0ak5U/1j+HxdGFJD+XOZZZl4sjEG4dq9MtG4FghScpB2WXLyVAjdCT9Cky2r/
 VxhmliQP74Aj4CmwP+aKxYYpANkRGUJdEGIT7Xi2voIBSpK9dvq6pOy/PyCx92t5hetY
 2kiqLhfNQ2hHZIdtqY+edWBwn5Xcz2d5jKFT+yjNJamnOc3PzlO/di/9SzBWPnys9hOl
 qklPAnrz+cn3EctHRYh/rHzGvAmDB9KgoAoJv5cIro9R9NDF/1qtVIXEFAlb58FUJ6d3
 X8Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773289951; x=1773894751;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jQMrNml6U9cDIhsQ5mDwSAwjyDPFJNp8soUiNVdW58g=;
 b=s43coq9IZNMO2BaKUn/YmquwRilq/wfI7RzRmAKcMD+EanfzUjbqJM8lBTMb2A278h
 /jaH5QJW78EdGltoSkZbKNTNb/xgaTkgmpCIxahAN1Bb7K9jvWikjD8SRC3F0UQexcd3
 FDC8okl1VQQ4kD0E6vbxW/L9OSNWpQWB50ysQI2cxD+5X8uGx6iiX6utLgf1OfOA5JB6
 9vcnARiiON0t8sBqVUEwxJWV0sGmzD33Cwd6WA3QlR0WLQaC+Y5S4eT/GM6wkU0csMy5
 K3jVjklnFgf/pZj6M0ZLZuj+pF9dcRC5zZy+TxGhJalP3fxTbR3AKG4O3oIMjs3sFxcj
 XjgQ==
X-Gm-Message-State: AOJu0YxUKPVHHvZIOiACXUTE5vTYyUI3rt3D+VYFlAmkpp2a1cXBiUGT
 JZZWL8fAhWKQBLDJh3Cl/SP8A8Bk7uXqOg9c3aTaJY60eUY13cwHuMvhWJkhuRWD
X-Gm-Gg: ATEYQzyzmp1bpVopD4Fwr2NMMKn5fbVwMJUZUAMNO80AqNwE7volsvI5YQfzv/9S+3L
 WDSHGQR9NrfPwwyHNpF2l3eWK58IozY3eGVxUffpeFN9K/uUI2pvTDZmqCKzFlc0K9pe1LM7STS
 m5bQrhSClqT5acW0nybMFZEYvI2PYCYQ3XqURt/7ItWlVn4xqrNuAls1G38TAKzlTVsnPNbsicH
 pcKhztbmfAG6VFCHsUwPPDxs5IUgHhdtBC6MI2cGIDWVIan9A8O63/JMomfkUraFyBkHftQDYQ5
 o2mo9zibYSPjLxBZCrzR3eEC8n2kcX5qGUuG0kwuO2LSgSqjTGfqbt1DowjwdpNO+QHwkapsMJZ
 SqFVwALefmzjiRwbZGy+YsBM6xhNvVKyo1hunTaF5P+f/CUSbSf9P2Pq/AzWzEYySBlGTv1RJ6d
 hV9Zr81uI4zkuxbmVbFKxozUJv7XKxYluC8Kquf0chkA==
X-Received: by 2002:a17:903:32cf:b0:2ae:50ec:fa34 with SMTP id
 d9443c01a7336-2aeae8ab700mr51887435ad.46.1773289951108; 
 Wed, 11 Mar 2026 21:32:31 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2aeae222ab6sm54340785ad.10.2026.03.11.21.32.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Mar 2026 21:32:30 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org, armbru@redhat.com, pbonzini@redhat.com,
 berrange@redhat.com, peterx@redhat.com, philmd@linaro.org
Cc: alistair23@gmail.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH 5/7] hw/arm: fsl-imx8mp: Don't call qdev_get_machine in soc
 init
Date: Thu, 12 Mar 2026 14:31:56 +1000
Message-ID: <20260312043158.4191378-6-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260312043158.4191378-1-alistair.francis@wdc.com>
References: <20260312043158.4191378-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x536.google.com
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

    ./qemu-system-aarch64 -S -display none -M virt -device fsl-imx8mp,help

as the machine wasn't created yet. We call qdev_get_machine() to obtain
the number of CPUs in the machine. So instead of initialising the CPUs in
the SoC init let's instead do it in the realise where the machine
will exist.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/arm/fsl-imx8mp.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/hw/arm/fsl-imx8mp.c b/hw/arm/fsl-imx8mp.c
index 79f9142777..b36df82971 100644
--- a/hw/arm/fsl-imx8mp.c
+++ b/hw/arm/fsl-imx8mp.c
@@ -193,16 +193,9 @@ static const struct {
 
 static void fsl_imx8mp_init(Object *obj)
 {
-    MachineState *ms = MACHINE(qdev_get_machine());
     FslImx8mpState *s = FSL_IMX8MP(obj);
-    const char *cpu_type = ms->cpu_type ?: ARM_CPU_TYPE_NAME("cortex-a53");
     int i;
 
-    for (i = 0; i < MIN(ms->smp.cpus, FSL_IMX8MP_NUM_CPUS); i++) {
-        g_autofree char *name = g_strdup_printf("cpu%d", i);
-        object_initialize_child(obj, name, &s->cpu[i], cpu_type);
-    }
-
     object_initialize_child(obj, "gic", &s->gic, gicv3_class_name());
 
     object_initialize_child(obj, "ccm", &s->ccm, TYPE_IMX8MP_CCM);
@@ -265,6 +258,7 @@ static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
     MachineState *ms = MACHINE(qdev_get_machine());
     FslImx8mpState *s = FSL_IMX8MP(dev);
     DeviceState *gicdev = DEVICE(&s->gic);
+    const char *cpu_type = ms->cpu_type ?: ARM_CPU_TYPE_NAME("cortex-a53");
     int i;
 
     if (ms->smp.cpus > FSL_IMX8MP_NUM_CPUS) {
@@ -273,6 +267,11 @@ static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
         return;
     }
 
+    for (i = 0; i < ms->smp.cpus; i++) {
+        g_autofree char *name = g_strdup_printf("cpu%d", i);
+        object_initialize_child(OBJECT(dev), name, &s->cpu[i], cpu_type);
+    }
+
     /* CPUs */
     for (i = 0; i < ms->smp.cpus; i++) {
         /* On uniprocessor, the CBAR is set to 0 */
-- 
2.53.0


