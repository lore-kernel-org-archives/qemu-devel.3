Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 884EDC3ABC3
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 14:17:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEqQM-00046T-Sf; Tue, 13 May 2025 10:16:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1uEqQ4-00043k-Qc
 for qemu-devel@nongnu.org; Tue, 13 May 2025 10:15:47 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1uEqQ2-0005bX-Sb
 for qemu-devel@nongnu.org; Tue, 13 May 2025 10:15:44 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43d2d952eb1so42104685e9.1
 for <qemu-devel@nongnu.org>; Tue, 13 May 2025 07:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=adacore.com; s=google; t=1747145741; x=1747750541; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=98OOmrWk25E/kwedxRasvOoS2mo+ShZuSOIhL7Rf3TY=;
 b=UbA1purcJ66oyDt1g9lAjt1woRnpsgNUKH0XeXK58Niy8zCqdYLFHO7WP53zMEFfmV
 MdcezDKEM1fD0ZZNJnStZX/sJfcAv+p3Rgh4u6rNAG1XBTvuOZwCWRJk/+EygJsCasIH
 mKCOrc8ihCONWH9SpI61oELGW9yvkvmLu1Se+6hsKnUfFXfmfpf8HH9ACvIMWTdGEDIZ
 MLQ47FYW/BrpBFS8+gEx7Z2XUXY44E8+iyj2VSm2aiY6AKQClzIydGocuxH8XOhMTlqD
 asVLDabsSxT72ICZSQam5YUjPOgI9UtKfWiHx2sCLNVIKDAYyodNrKpJ0OAOR92UWRxP
 XW0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747145741; x=1747750541;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=98OOmrWk25E/kwedxRasvOoS2mo+ShZuSOIhL7Rf3TY=;
 b=ePHfaERiXdtxEGKJVqR7lcAVfyUX6UkXykRcrn17EqE+KPiHhbTksI05C2d9UqgJDR
 hvw0+ad+AaoY72/XuXlO+0IIA8NTSlhdSTAL2Wu+2AZq//+BR6pUcPtv/ekMLQNTH34I
 8R6aOTh5tep1IK3opZH2g0Jn42OTS1Naljsj8aEseYKhRUWyfBFupyJW4HQYHd/hKpZ/
 Zi1WU34iwPyWS64/N+H+hOSdtAm6nFaktEijFYrIzLycayqmTmjsz+Gv1tia7QXtnv+e
 sUVorVASaHLFYK+nGaqfg6BTEjvKDvRW5JTrKsGQjlcbfkRmMkG5B4C6fd2SgqzoyEtR
 7Glg==
X-Gm-Message-State: AOJu0YysiLnxI9dzZ7kb9ELM2xj7pWAPqh0FW4ACUrUf9pp7miT5b3Av
 c1pPeQydl8vt6uCi9MJlZ9PLECkWJ16slAwSJDxcxX9c312CCnPGQdIzu9dfJ89wPGLYOLoNZH4
 =
X-Gm-Gg: ASbGncua7uSuMzxPld5E+rXzoXBpYmb5U+fxK9DhJASxooAX8Eod2kZLgNfyIr2K/9F
 djalpOSegCdduw1iN9ByeGaTJgFK02G8SOrHCStKcrfjb+Z5PaJIPcInWhqS7jH/dUHS2gv3fK0
 azrP6DasFWvOt+s82fFrmsbz6d1wv7zb44/ZwYVFSCwrdsVdWLj8pfIhguSA0WcOkeRTDQ7C4as
 Y9jUzeV+kOrHcJUDd6olh8xQgbwfQpIC2to6BCZbcksyNKleUlkPo1AoLR1aFWq012zrxLX+ZUs
 poawfUz5264rVNw6mZ6ZEsZnQvFCNChZawJvpW/dZf6uI/C/+qd3n24Z05l9myvdds3rwRy5UEK
 RUcwCZfK2/PLQ7et21b5EBX+eMOBhxtQl6XD0hmgv1l3L5gJsH9ZIgpM+dNc=
X-Google-Smtp-Source: AGHT+IGvqRaK+FTGLRpircEGGo5AQcMitbUzwfvXykGemkI2WAM7g40PBcwY8T4rzfABAay2k9Lp5w==
X-Received: by 2002:a05:600c:4451:b0:43d:526:e0ce with SMTP id
 5b1f17b1804b1-442d6dc51e8mr128437535e9.21.1747145740789; 
 Tue, 13 May 2025 07:15:40 -0700 (PDT)
Received: from chigot-Dell.telnowedge.local
 (lmontsouris-659-1-24-67.w81-250.abo.wanadoo.fr. [81.250.175.67])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442cd3b7e7fsm213438805e9.39.2025.05.13.07.15.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 May 2025 07:15:40 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, edgar.iglesias@gmail.com,
 alistair@alistair23.me,
 =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>
Subject: [PATCH 4/4] hw/arm/xlnx-zynqmp: adapt cluster-id based on the boot cpu
Date: Tue, 13 May 2025 16:14:48 +0200
Message-Id: <20250513141448.297946-5-chigot@adacore.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250513141448.297946-1-chigot@adacore.com>
References: <20250513141448.297946-1-chigot@adacore.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=chigot@adacore.com; helo=mail-wm1-x333.google.com
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

When gdb is being connected to QEmu, it will be attached to the first
CPU cluster. However, the ZynqMP board has two clusters, those being of
two different architectures.
Therefore, when gdb is connecting to the ZynqMP, it receives the target
descriptor of the first CPU cluster. Up to now, it was always the APU
cluster, which is AARCH64.

When booting on a RPU, gdb will still connect to the APU. If gdb is
supporting only ARM32, it will receive the APU target descriptor,
resulting in:
  | (gdb) target remote :1234
  | warning: while parsing target description (at line 1): Target
  | description specified unknown architecture "aarch64"

Adjust the cluster-id based on the boot cpu will resolve the above
issue; allowing a pure ARM32 toolchain to debug programs running on
RPUs.

Signed-off-by: Clément Chigot <chigot@adacore.com>
---
 hw/arm/xlnx-zynqmp.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/hw/arm/xlnx-zynqmp.c b/hw/arm/xlnx-zynqmp.c
index be33669f87..f23ace6446 100644
--- a/hw/arm/xlnx-zynqmp.c
+++ b/hw/arm/xlnx-zynqmp.c
@@ -221,7 +221,13 @@ static void xlnx_zynqmp_create_rpu(MachineState *ms, XlnxZynqMPState *s,
 
     object_initialize_child(OBJECT(s), "rpu-cluster", &s->rpu_cluster,
                             TYPE_CPU_CLUSTER);
-    qdev_prop_set_uint32(DEVICE(&s->rpu_cluster), "cluster-id", 1);
+
+    /* In order to connect gdb to the boot cpu, adjust the cluster-id.  */
+    if (!strncmp(boot_cpu, "rpu-cpu", 7)) {
+        qdev_prop_set_uint32(DEVICE(&s->rpu_cluster), "cluster-id", 0);
+    } else {
+        qdev_prop_set_uint32(DEVICE(&s->rpu_cluster), "cluster-id", 1);
+    }
 
     for (i = 0; i < num_rpus; i++) {
         const char *name;
@@ -380,7 +386,6 @@ static void xlnx_zynqmp_init(Object *obj)
 
     object_initialize_child(obj, "apu-cluster", &s->apu_cluster,
                             TYPE_CPU_CLUSTER);
-    qdev_prop_set_uint32(DEVICE(&s->apu_cluster), "cluster-id", 0);
 
     for (i = 0; i < num_apus; i++) {
         object_initialize_child(OBJECT(&s->apu_cluster), "apu-cpu[*]",
@@ -475,6 +480,13 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
 
     ram_size = memory_region_size(s->ddr_ram);
 
+    /* In order to connect gdb to the boot cpu, adjust the cluster-id.  */
+    if (!strncmp(boot_cpu, "apu-cpu", 7)) {
+        qdev_prop_set_uint32(DEVICE(&s->apu_cluster), "cluster-id", 0);
+    } else {
+        qdev_prop_set_uint32(DEVICE(&s->apu_cluster), "cluster-id", 1);
+    }
+
     /*
      * Create the DDR Memory Regions. User friendly checks should happen at
      * the board level
-- 
2.34.1


