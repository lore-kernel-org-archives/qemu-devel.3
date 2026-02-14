Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6CD8EF99F0
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Feb 2026 02:14:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vr5A6-0003oE-8K; Fri, 13 Feb 2026 21:13:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vr5A4-0003nh-MY
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 21:13:32 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vr5A3-0004ch-5G
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 21:13:32 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4837634de51so4538985e9.1
 for <qemu-devel@nongnu.org>; Fri, 13 Feb 2026 18:13:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771035209; x=1771640009; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZOdWgV2/IOn9a1EHv9glZetOs4gjLWtVaCBAgnLarRY=;
 b=oKRQMkC8n8hUD50KRmgWRsWnysiK31Pu9E+MPYsSpZi2fYbhwtp9DxgqHTztEsfgdj
 lUi0krpYACm5rgegDAyqiLNE/0MSa6ND+NXKje5/AkUt0GL14j6WVzAqJT7D4ZPLedr2
 DwLQRdbxEQwqqf3JNnk9mhz+lcwWR4VVb4xeVdGHSWgeSZtR7VQ5s/xjE3Pjw24yz4FO
 P//0IwxsRzgnLij6AFpGkGQgH+aDICrZN7J3fcvC3HntSIBKKVVCGsiVPwiliBPtti67
 hGGZJ8l7fobDVR29o91aJEU2UlDeRklJVNJrVYNWHrr0zFBuESFQdzrCEdqXzu0Bc2AT
 MYxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771035209; x=1771640009;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZOdWgV2/IOn9a1EHv9glZetOs4gjLWtVaCBAgnLarRY=;
 b=VfxBeEN+xql/c5oHDbtePlqn0pm8KaNzrqZ7SCcLmS/Av6rZ7d7LMtk3dTxNEYHM73
 +VcUKBLPmbkG9V/suPDUygvwzN5vDSCGxD1modo8NEO3elvD/F0+Baj/J62oeR04ieUr
 VbAK2jLsCyc1g5q2JhfRYdJvx0aNkJStVCNHk4fExr1Goe3teEvmWaHRW9wk7K9F/dwU
 2ci+G/vp07VzcpZo1+LUb6qjI+CUG3sFwZpgSNCyea9oh3fslI+o+7ZX5bvixK0sBtiU
 gHcTD4M0XIoIpYtsQfJ3W0VsAurtgRy3f5/ZDurk1NQEuXEOgVRGOeVaW0ofJekQ6WOh
 Bd7w==
X-Gm-Message-State: AOJu0YzZaq1AHVyRDf1zjXdR+q3qL3z6WrQegoklDqJhklFXNxb/oA6o
 Gejv0nQcdYEXUnD5equCbV4uM51f1T6lg7jvayRpTSPSVK80/oQ0DunGEY8oVJT5u/Sx3Fm+KQy
 FKAPZOYU=
X-Gm-Gg: AZuq6aIsdAoutqIuzal4HbvCQdOXc+4V1C62jnFo3qm69gifmbqE6lPBvA7GoN52ir0
 yVOANvXzytBZLNpPG4OGWKpEf1ZaSs7MnVGIEeZGwWuJ+G+R7wF/bAn4XrEqiXGhBQ8C/pbASrq
 Ci8TAKtV3sBR1G/sX7VCX60FGAXFi2QA/fVK2iqe0NSxQP8z1VrEqSua85FiR6nu7r/u7E3jITH
 Ltkg/AmCxflwUwGVCF4G9PIrpWi5OxCXbBgfqIqU29WJhbvzckqaPS4VTK3cbs71UZM4E2Qs1X3
 E8/75C16mGe3LoBvxS3F1ffrub35yBVg7sp6NSMAaw4jbs8tJ9Hp1GAxZ45B4oxh7WWc2s+V4Jq
 v98qdWh8dRDPXMwslPejaLlo+ZM5ElvkmqxTql2iL1cOFxIT+SonqJ6Hy+KrdSC3y9wPnEsu5ou
 Lpivl5STosCpwi8xO4qGJ4UZ80ChpTaUs4Gr+4Erq4bD5zbVnrkdF3UnB4B0m93xRrOtWI0kZTZ
 KwudUmon/o=
X-Received: by 2002:a05:600c:468d:b0:47e:e20e:bbb4 with SMTP id
 5b1f17b1804b1-4837108fcf1mr80633225e9.26.1771035209399; 
 Fri, 13 Feb 2026 18:13:29 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48370a41be2sm50789865e9.1.2026.02.13.18.13.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 13 Feb 2026 18:13:28 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Chinmay Rath <rathc@linux.ibm.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-ppc@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 6/8] hw/sparc: Set graphic display dimensions generically
Date: Sat, 14 Feb 2026 03:12:37 +0100
Message-ID: <20260214021240.58657-7-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260214021240.58657-1-philmd@linaro.org>
References: <20260214021240.58657-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

If a dimension is not set, have the machine init code
set the default value.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sparc/sun4m.c        |  9 +++++++++
 hw/sparc64/sun4u.c      | 10 ++++++++++
 system/globals-target.c |  6 +-----
 3 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
index 0c0d658d301..a17bdb36927 100644
--- a/hw/sparc/sun4m.c
+++ b/hw/sparc/sun4m.c
@@ -892,6 +892,15 @@ static void sun4m_hw_init(MachineState *machine)
                      hwdef->esp_base, slavio_irq[18],
                      hwdef->le_base, slavio_irq[16], &hostid);
 
+    if (!graphic_width) {
+        graphic_width = 1024;
+    }
+    if (!graphic_height) {
+        graphic_height = 768;
+    }
+    if (!graphic_depth) {
+        graphic_depth = 8;
+    }
     if (graphic_depth != 8 && graphic_depth != 24) {
         error_report("Unsupported depth: %d", graphic_depth);
         exit (1);
diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
index 5d7787fc1a5..b8bda1eb816 100644
--- a/hw/sparc64/sun4u.c
+++ b/hw/sparc64/sun4u.c
@@ -666,6 +666,16 @@ static void sun4uv_init(MemoryRegion *address_space_mem,
                                 sysbus_mmio_get_region(s, 0));
     nvram = NVRAM(dev);
  
+    if (!graphic_width) {
+        graphic_width = 1024;
+    }
+    if (!graphic_height) {
+        graphic_height = 768;
+    }
+    if (!graphic_depth) {
+        graphic_depth = 8;
+    }
+
     initrd_size = 0;
     initrd_addr = 0;
     kernel_size = sun4u_load_kernel(machine->kernel_filename,
diff --git a/system/globals-target.c b/system/globals-target.c
index e3f7d846ac0..17a27a06218 100644
--- a/system/globals-target.c
+++ b/system/globals-target.c
@@ -9,11 +9,7 @@
 #include "qemu/osdep.h"
 #include "system/system.h"
 
-#ifdef TARGET_SPARC
-int graphic_width = 1024;
-int graphic_height = 768;
-int graphic_depth = 8;
-#elif defined(TARGET_M68K)
+#if defined(TARGET_SPARC) || defined(TARGET_M68K)
 int graphic_width;
 int graphic_height;
 int graphic_depth;
-- 
2.52.0


