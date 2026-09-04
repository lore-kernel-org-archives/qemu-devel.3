Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B5D7C79F81
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 05:24:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2MNa-0003lh-VL; Fri, 04 Sep 2026 01:22:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1x2MNZ-0003iu-Jz
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 01:22:21 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1x2MNV-0001WQ-VH
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 01:22:19 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-854f8068301so358736b3a.0
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 22:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788499337; x=1789104137; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5P8Lf/t9f75aliMIc50V17Li5qLsVl/i2+hYndtJzqI=;
 b=dk0dwVWqFiZJTIbiVhOp59XDuy4LM50tX+sWJ4IvY5XjMCNLp+VGx+wuyUMeWpolDk
 oNoX3hH8QnPQUMDQXn57E5ZwP6axAhMTqTtyeTz+DnT4gOaPVKZGejBjYJLwVZ79Hl77
 uxq+xKe+B3/eyWh/vK8d4Uqky5wC9c8HuCiFnYhGQ38RdgJduBzH4IS0ux5VtALJ0jFv
 XeYarQBS3POiAXI8+Q9AEKQkvgShL1rFhg+dI9U4b8Q1W7n1kfON44EBQL1FNTXD3kup
 L27Au4lA1D5ySdFjFv7sBeaX9svED599uyz5Rcs93Q6C0xtmJSAVtPt/zqVOkDyJIrVe
 BMfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788499337; x=1789104137;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=5P8Lf/t9f75aliMIc50V17Li5qLsVl/i2+hYndtJzqI=;
 b=kQhfnyD8DPeh253F09JilsvbCTIMIsA7uIGguFx2hLZ79z1/cV2+hS7vamXVR5Omfg
 ZhKu9Uoliwb6AzczCF41TUneIceheAfc8ZB37iGvwwzeOnxUcKASzXAqSNy6wDML/nyo
 IV2ESiVD2NUV7jlS69RpAKsnpgPIIm+PCn5Xq4IeahCYeL8IC/XzBuwPnmKtAwGeZBVx
 EYj9L3t/qD71V42z/CotU0bQYMRLJiTP9UBGMtXsqioqUYpaWJBZrp/gRGQtL1EKS27r
 T/v75Vro3AF9dvaiCVdfv8uhZKGDEcrujMWJZ3GMS+IZQPKUh5BWg63U6fKx28kP5IAU
 fxOw==
X-Gm-Message-State: AFuF++nWuEb23pqCFtGdEi55NfSLeL53dBdX8YJr/B/9Opnvuu4YC3X2
 QvNO/UfbpwMdZBzw0ItVzrGHggAQWynRb2kSRejo3Qw9BotfGrsiedxbn5UiGg==
X-Gm-Gg: AYBFou1+HUi5RBFQZrNPfGzfvecbt4wKeRv/BY9RCo6ICd0c5GW7mzykFMbXlERkyoU
 pwrG/bfrk1mnc2nDEZD1hFrDgrJZq1dmpNpiabMtHLrV/9A95Q0p8+S9W3S8+6zHKSrrAS1Pnk4
 eT8eMSK0aCT4jSLbHeDYuSX33eFUEFj5I6hYx94UcbI8bZm66BCjNiFSi04NzytuSzSmdSd/Sgk
 ILnnDsv3Uu8YturtWSGwYQdXRxPGcYCPpHpN3SqE9FoWPg/Kv4kOewUQGQ+cUcqwNnrQkV/Pjll
 7ZlsLhitScUp7EIbnIMC7nGZaOmmFxFfED/fNX/hnAF3/d/cXPMv9rdXH7Bv+yKxL5b7cVYvA/s
 VUUK8lIJvA503XQLLvNOaQ2IZuA3O7wSfSS8kXjMhcJSj3w3XaP9y5N5rKg1p9b8RvZaOcd5aib
 TM9A8I16UPCJByYgsoyhLYoTTJsnofVZNjW6kKTsc5Kc2wOUvrQ92IGkMFwcZvjyAGnBcCpFgVk
 i9/zQ==
X-Received: by 2002:a05:6a00:3021:b0:857:727c:a1f3 with SMTP id
 d2e1a72fcca58-8616907fefamr5669796b3a.21.1788499336717; 
 Thu, 03 Sep 2026 22:22:16 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc455445e34sm402147a12.15.2026.09.03.22.22.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 22:22:16 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Portia Stephens <portias@oss.tenstorrent.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>, Joel Stanley <joel@jms.id.au>
Subject: [PULL 45/47] hw/riscv: Add property to hart array to allow private
 memory
Date: Fri,  4 Sep 2026 15:19:41 +1000
Message-ID: <20260904051943.799041-46-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260904051943.799041-1-alistair.francis@wdc.com>
References: <20260904051943.799041-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x42f.google.com
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

From: Portia Stephens <portias@oss.tenstorrent.com>

There are platforms where CPUs have different mapping of system memory.
The global system memory does not allow for this. This adds an optional
property on the hart array to assign a specific memory region. The array
passes the region to each hart it creates, so a machine can alias the
harts' memory to system memory, while the harts view memory from their
own memory region.

Signed-off-by: Portia Stephens <portias@oss.tenstorrent.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Joel Stanley <joel@jms.id.au>
Message-ID: <20260903055131.257903-15-joel@jms.id.au>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/hw/riscv/riscv_hart.h | 2 ++
 hw/riscv/riscv_hart.c         | 8 ++++++++
 2 files changed, 10 insertions(+)

diff --git a/include/hw/riscv/riscv_hart.h b/include/hw/riscv/riscv_hart.h
index 197fa16231..c3cd05a2c8 100644
--- a/include/hw/riscv/riscv_hart.h
+++ b/include/hw/riscv/riscv_hart.h
@@ -42,6 +42,8 @@ struct RISCVHartArrayState {
     uint64_t *rnmi_irqvec;
     uint32_t num_rnmi_excpvec;
     uint64_t *rnmi_excpvec;
+    /* Optional private memory region for use instead of system memory */
+    MemoryRegion *memory;
     RISCVCPU *harts;
 };
 
diff --git a/hw/riscv/riscv_hart.c b/hw/riscv/riscv_hart.c
index 747754be61..32fd39737f 100644
--- a/hw/riscv/riscv_hart.c
+++ b/hw/riscv/riscv_hart.c
@@ -53,6 +53,8 @@ static const Property riscv_harts_props[] = {
     DEFINE_PROP_ARRAY("rnmi-exception-vector", RISCVHartArrayState,
                       num_rnmi_excpvec, rnmi_excpvec, qdev_prop_uint64,
                       uint64_t),
+    DEFINE_PROP_LINK("memory", RISCVHartArrayState, memory,
+                     TYPE_MEMORY_REGION, MemoryRegion *),
 };
 
 static void riscv_harts_cpu_reset(void *opaque)
@@ -117,6 +119,12 @@ static bool riscv_hart_realize(RISCVHartArrayState *s, int idx,
     object_initialize_child(OBJECT(s), "harts[*]", &s->harts[idx], cpu_type);
     qdev_prop_set_uint64(DEVICE(&s->harts[idx]), "resetvec", s->resetvec);
 
+    /* Use private memory instead of system_memory if provided */
+    if (s->memory) {
+        object_property_set_link(OBJECT(&s->harts[idx]), "memory",
+                                 OBJECT(s->memory), &error_abort);
+    }
+
     if (s->harts[idx].cfg.ext_smrnmi) {
         if (idx < s->num_rnmi_irqvec) {
             qdev_prop_set_uint64(DEVICE(&s->harts[idx]),
-- 
2.55.0


