Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8121FCB63B
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2026 15:27:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vytYI-0004wb-Ha; Sat, 07 Mar 2026 10:26:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vytYG-0004w0-SC
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 10:26:48 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vytYF-000849-BC
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 10:26:48 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-439b9b1900bso4901415f8f.1
 for <qemu-devel@nongnu.org>; Sat, 07 Mar 2026 07:26:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772897204; x=1773502004; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lyFJMidGdKfjK3ch02S4UC88fe7pRdRHRDfb2uPU+CU=;
 b=spB+z3iOvDxpS5zoIbZMFO2QxPXZ8MMP7iY2iYeX9jxg3lHxBvazgIfajg5gGE1dad
 WRyHQtp5uvu//whVhLO+brt+ZqJW8llc9wxcHfGJuYOP5pXDOGUUhGROR5J7XRDlgnW0
 LKiCrv3NPAYPxVxFmtipe4sU6EYLopPOKYR1wUX45ED/7aIID6uspjWIFvjSFBMvRp6v
 JQ8tiIfp1HXekRD/fBypJxaUAQ2zqeXE1NLnAEcfqgHPz/0Mi8X6UaMfDUFZJEwyo7Am
 uUJbKlO3yOE2wrzd3cBHuvrR2dXYxlZqB4oMEEqjs2ch5GzxS75Rf0Figwr/QweZQHJk
 3qZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772897204; x=1773502004;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lyFJMidGdKfjK3ch02S4UC88fe7pRdRHRDfb2uPU+CU=;
 b=ZBK30lUElb2H/yIV0nRIKZp9nalry0hsTU8D2/UlBw71z/0KCljepFEaU2Nnrpfby4
 nrLVNQq4oDmlFVvMq/0VQuq9SWMMhik6VCfAcJFlzV3s3/VB84jMOOZbCARE3/Q84uwb
 pWHkykn67xwMPadf2RW4EtGiRQF8ab9ULHpHeBn+OpfpVeK97oqOSfux3AdDXwsBTKBM
 HOlWiC4T6X9rEZQV/o4VaDLKYBulD5mH1Ms6jMllMKYdY77D+uLyJvVBE3kYkhHtlK60
 zs1kdWl93CR6KiY4TR5lpizbA7Y1dM4QTciN7JeqvyAzueb9E/r2l6Wwfrm7vE4uGRRs
 8c3A==
X-Gm-Message-State: AOJu0YxirFXFmcucXC55ciJuPYe+oPZNdstdaInp/J5FA+8n6ogEne0G
 WTDbx1RQsRKgY8pvrWModnZb2a+p0nBrdSMojcu0DchV5KouTs1RL34ywclAdRed+rCSSJECYdU
 sVtQn9mQ=
X-Gm-Gg: ATEYQzxy5RW030xtvbhY+KesI0e3sTYM5eOHBusZpQRuH0QQ0UTroH+tXutdpcvTUoK
 pT0bvWg5yzrR/XkMaEb/HLS7Vu77MMNfl+C4XhAQfSJ0jn6H7b59qhzDADYfKJzkIvkdSIwP0WS
 0LY0FO9ovrnkLtZ+3Rmq5bQr0kS2GQE5VDY3JGtvs7pXtgjQdENT/5gc5XksRAXjc5B7ELfPIr+
 relYHQ8rugdqLE7UcUf9Yif4d+Pb43xoO4xryfUfSDL+vCpNaCe0Hv6D2axH+/mMbeJ21NTqskq
 vAuv0d2e7BhKd4Kz6ARTgP046tG2KU8HnRwjtABUTurQWuuG835Y3lIrcoW1VnRDyx2SkVVxKP5
 bRJT1YtSWy+sjqdEri6LF5LetxYt5LTOltTirBK28IMls2F3I6N+KS/w/IpGnZyQFRQPSy+sMuA
 xfCg6m8GolWmVzRZJLqJ8kwJeAyOyHNXQiTRFxBl8tQbEyUqqKBVR/EpZ/7xA/je/+u7DbXerSY
 3uhQn5TWQU=
X-Received: by 2002:a05:600c:8b26:b0:480:1c85:88bf with SMTP id
 5b1f17b1804b1-4852697a5c1mr92596345e9.27.1772897204430; 
 Sat, 07 Mar 2026 07:26:44 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439dad8d95dsm12878764f8f.7.2026.03.07.07.26.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 07 Mar 2026 07:26:43 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Cl=C3=A9ment=20Mathieu--Drif?= <clement.mathieu--drif@bull.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Ani Sinha <anisinha@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH 01/10] hw/i386/pc: Remove deprecated pc-q35-3.1 and
 pc-i440fx-3.1 machines
Date: Sat,  7 Mar 2026 16:26:25 +0100
Message-ID: <20260307152635.83893-2-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260307152635.83893-1-philmd@linaro.org>
References: <20260307152635.83893-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

These machines has been supported for a period of more than 6 years.
According to our versioned machine support policy (see commit
ce80c4fa6ff "docs: document special exception for machine type
deprecation & removal") they can now be removed.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/i386/pc_piix.c | 13 -------------
 hw/i386/pc_q35.c  | 14 --------------
 2 files changed, 27 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 29c8e997131..13981fb3aba 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -655,19 +655,6 @@ static void pc_i440fx_machine_4_0_options(MachineClass *m)
 
 DEFINE_I440FX_MACHINE(4, 0);
 
-static void pc_i440fx_machine_3_1_options(MachineClass *m)
-{
-    PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
-
-    pc_i440fx_machine_4_0_options(m);
-    m->smbus_no_migration_support = true;
-    pcmc->pvh_enabled = false;
-    compat_props_add(m->compat_props, hw_compat_3_1, hw_compat_3_1_len);
-    compat_props_add(m->compat_props, pc_compat_3_1, pc_compat_3_1_len);
-}
-
-DEFINE_I440FX_MACHINE(3, 1);
-
 #ifdef CONFIG_XEN
 static void xenfv_machine_4_2_options(MachineClass *m)
 {
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index f102da8e4a1..52b8064b4d2 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -600,17 +600,3 @@ static void pc_q35_machine_4_0_options(MachineClass *m)
 }
 
 DEFINE_Q35_MACHINE(4, 0);
-
-static void pc_q35_machine_3_1_options(MachineClass *m)
-{
-    PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
-
-    pc_q35_machine_4_0_options(m);
-    m->default_kernel_irqchip_split = false;
-    m->smbus_no_migration_support = true;
-    pcmc->pvh_enabled = false;
-    compat_props_add(m->compat_props, hw_compat_3_1, hw_compat_3_1_len);
-    compat_props_add(m->compat_props, pc_compat_3_1, pc_compat_3_1_len);
-}
-
-DEFINE_Q35_MACHINE(3, 1);
-- 
2.52.0


