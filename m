Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4655C43602
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 10:18:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wes1T-00085C-M0; Wed, 01 Jul 2026 06:18:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wes1Q-0007zk-93
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 06:18:26 -0400
Received: from mail-dl1-x1230.google.com ([2607:f8b0:4864:20::1230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wes1O-0004PF-K5
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 06:18:23 -0400
Received: by mail-dl1-x1230.google.com with SMTP id
 a92af1059eb24-13b2d7dc8d1so388748c88.1
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2026 03:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782901101; x=1783505901; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AzyXLWxgfnB9GYfv+2CNeQACOH3jbsa5rH69fbSpNSY=;
 b=qx4Hh3M1Oz6Rb8O874KXuTzV4D1aHZ58KsejnTgEktEWOE6o2aY7CU3FytSaHEMuXz
 tLwkYy67astcckUKoNpcgJrKcLtvO7+P5Z4dzKuosfEszM20THfs4RQjo/sD3juLwobi
 hQgGQBWoMH1Yylc2HI2jHVj2eRgRyi8wJ2PpSQowV/GMg0nloHQxWnFppgpO79n4Gopf
 zwpy1mpW25hMg0AWifW/gAqnHl0hH57zcK66Q6t/AniEobV9hDULsTKyu/8V3QGOy904
 RVrPtN5593Eaoysv5TF6cqiW2QJo4/yEfJE1bU5qzE+QDgAb2aN8ZjmeDTlDFQhnOY5y
 kpQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782901101; x=1783505901;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AzyXLWxgfnB9GYfv+2CNeQACOH3jbsa5rH69fbSpNSY=;
 b=jSNbkQxK6ZVO/GaqlQn7RDQQqxbtNtoIERAHjYstz8YGKuEzT0YH2TrSG2w9Aw6MKS
 /SYgecT8v8vKaxaWPhnSV4JrNljYg9CAFUfQiaJESnLYTLSJDgVET38Aijxjd/53KUg+
 EjXQsjzn3CohJRr3dlH161RoZUTtk2UrOTPbn/sXHnTD1HH0UfFtHtCyXhqpdzy3Wvxl
 DdWTwThMSRAk4T+qHgMYl8P45kgME0mDf5GGmEf7AtS0ZyYHRL7zuZsNqLiPrTMrBSV/
 +1J8YjUbclGtS71APiOk3uJRMWDlN+5Tvs5fLI/lv+vnYJa1yrezmRdzNqflW0c2IU7H
 elcA==
X-Gm-Message-State: AOJu0Yz9TQtkKwIyvAXc0mRiKUbmPCWbCEn6fydMvZ1x9AEmY4mZHgtv
 6PbWOPJI2Hi/3E/l84F4+qLAbY/OemczGYQjyQNaKUoPfvRL4HojfqPNKHZADA==
X-Gm-Gg: AfdE7cmGo/RPlv0An9vVs3m8oOW9cfBWT13glrtxkekr2QvkCWHgIA9j1BDos3zYpKu
 6788zXMpzEByUueG3kHRAimG56JahVMv7hlLzeweiB1yGeLztnJJ2w8J7Lv4AC0deYPA6aIwzyR
 iKLHVOWA3vVNcBrhwjrrztEcnPfWGcwoZLpmUrtLZKoz1piFAmZGUontNCRevLd9WIOkfHzdgjM
 YPkydLuGBKhoop18/HeJgGH2MhZy5V4DDV9BgzgdO8n5N8Sc1AJGqOpKDbmFOZwRPwPV4TfkJdm
 dEeNlyOLrRj1AZngaHEVfubXkFxWPa8kobHsE675DG/ZXPneKCM+n55UNQFFws/Qf0hGy2ybszR
 lWae11Fp0RhKmoPxTZUQKRTnaWum6DOHFjIl1fYxNabW8lANTTDnwVWYK8k4qvmuVBIz5Tcpsu1
 AiG20nXnugy5SkbutoAhZomy2Kp8sZVqA=
X-Received: by 2002:a05:7022:622:b0:137:f532:e342 with SMTP id
 a92af1059eb24-13b36d61aa9mr1065500c88.7.1782901100723; 
 Wed, 01 Jul 2026 03:18:20 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b2ab2e0e3sm19355047c88.7.2026.07.01.03.18.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 03:18:20 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 04/39] target/riscv/cpu: add CPU unrealize callback
Date: Wed,  1 Jul 2026 20:17:17 +1000
Message-ID: <20260701101752.2522962-5-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260701101752.2522962-1-alistair.francis@wdc.com>
References: <20260701101752.2522962-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1230;
 envelope-from=alistair23@gmail.com; helo=mail-dl1-x1230.google.com
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

Next patch is going to dynamically allocate debug trigger arrays during
realize() time.  We need a way of freeing them during unrealize(), which
doesn't exist at this moment.

There's a lot going on in that patch already so we're adding the
callback infrastructure beforehand.

Suggested-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260617131710.1855353-2-daniel.barboza@oss.qualcomm.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h | 2 ++
 target/riscv/cpu.c | 9 +++++++++
 2 files changed, 11 insertions(+)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 7582874c35..16e9f87b83 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -576,6 +576,7 @@ typedef struct RISCVCPUDef {
 /**
  * RISCVCPUClass:
  * @parent_realize: The parent class' realize handler.
+ * @parent_unrealize: The parent class' unrealize handler.
  * @parent_phases: The parent class' reset phase handlers.
  *
  * A RISCV CPU model.
@@ -584,6 +585,7 @@ struct RISCVCPUClass {
     CPUClass parent_class;
 
     DeviceRealize parent_realize;
+    DeviceUnrealize parent_unrealize;
     ResettablePhases parent_phases;
     RISCVCPUDef *def;
 };
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index fa497e5e8a..b47e2b41c8 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1009,6 +1009,13 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
     mcc->parent_realize(dev, errp);
 }
 
+static void riscv_cpu_unrealize(DeviceState *dev)
+{
+    RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(dev);
+
+    mcc->parent_unrealize(dev);
+}
+
 bool riscv_cpu_accelerator_compatible(RISCVCPU *cpu)
 {
     if (tcg_enabled()) {
@@ -2664,6 +2671,8 @@ static void riscv_cpu_common_class_init(ObjectClass *c, const void *data)
 
     device_class_set_parent_realize(dc, riscv_cpu_realize,
                                     &mcc->parent_realize);
+    device_class_set_parent_unrealize(dc, riscv_cpu_unrealize,
+                                      &mcc->parent_unrealize);
 
     resettable_class_set_parent_phases(rc, NULL, riscv_cpu_reset_hold, NULL,
                                        &mcc->parent_phases);
-- 
2.54.0


