Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8AABF3D5FF
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Mar 2026 11:38:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w6oSi-0002Mv-74; Sun, 29 Mar 2026 07:37:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vikingtc4@gmail.com>)
 id 1w6oSe-0002Li-GE
 for qemu-devel@nongnu.org; Sun, 29 Mar 2026 07:37:44 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <vikingtc4@gmail.com>)
 id 1w6oSb-00042A-Ot
 for qemu-devel@nongnu.org; Sun, 29 Mar 2026 07:37:43 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-c7412b07f22so1849638a12.0
 for <qemu-devel@nongnu.org>; Sun, 29 Mar 2026 04:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774784259; x=1775389059; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=f6tBx4kE4tawEvFskmw/LuVxmCKqiEYHJXY2wQ9tAY4=;
 b=d3j+SEuf1g7Zd/mTmFZ3+N2QGnMm34su4AkYnVziVKA1vuFVP3qEwfr24ddgKNwikU
 SINCn+wOLZbyPSIkwqvugf08ZWRYkfvGtb+vDx6kQ5upprkqZDvI3zDftI9fcKJRiPrl
 2Z4QFhAIa5rJnL9/Wv4K07SYrleppyCV19ZiPXYjWfwHFFBIuCEAkpcsqw+7rmRtqpsZ
 1CCU5xKppfRzbPhQx3efc/riGFQoiB20hEckrcv/Hs9ckUPeBaoyDVDqi2o1Ow9r2cib
 WUv3Aq5TsDRRkiAu6IGM2NcllnsEMf/Npl9Vc1R/5lNg2fwwCEQRGa4QB0cFN5nEccjB
 Deag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774784259; x=1775389059;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f6tBx4kE4tawEvFskmw/LuVxmCKqiEYHJXY2wQ9tAY4=;
 b=B1CH5ztCK6w5HZvMbQwJsP90wtD1HxTwOiYhtmAZWQYb8QmzxLLRNadvnliSweZupT
 nn7pbALM1v/hRM3j2P/phF9AVdDVwOywnodD8ZCqqDPSBgG2NpZxhQCxz2Uv3VVnw+z4
 xTXsOiEfCU8VWSudLLE2MAFOrO6xQEkbej5O6RH+/bJOf+n8jdpAL5pT0Asup22kLB71
 G1sj9Su+Pm57J3Fdca/RFUFMDQ4v8Zb6XX0mrWZqFn/q239PRmsswBOSi7Xd3y353AUo
 UuJyRfn8ufMm7r4mMIyhH28M4QAZwkHojMMDmhYZG7XZ7dq7h4jnRXe9VXk0i9cG6YpA
 pldQ==
X-Gm-Message-State: AOJu0YxSivVZ7ywNWHZxC16YeQI4lqx4WH6h8tEqKACSrsL4U+4qUGpV
 7TvqVrAG2oe5WtR/ZYRgE94q8wSLpKJmfA8Zc4W6XGLSlhDaObTbWXPZbR6gALkw2M4=
X-Gm-Gg: ATEYQzx1Q0KL/byKI0s0ijH3XcVKmSWshVMekFNu9K+Ehp+/FEcbsdLsmPViLl1djWI
 lSVR6px98bwlDwVV8M6Cphu1ggMXMSOnuDM1Y1ZHlvfowB086XjY4LoC7IX/2xUZ7xxpSO6oINB
 Z5JweiAsGFiGdtmCO3NPz7mgLYaEqZUELYNJlxo321U9G5YoLTHHbQfM7cKPLjD0fGpJy83ep0V
 ZQMAF7JuyF9WECxss3LEBubJkTfgnOK0biKe0BheWjB0zH3QmpRfOe7yYjxwt0Smp5H4ETYMRC0
 wQ0fZgQ1oRImY/FTTA656pt49vmH4+tu4YDnApLlZo3okqW/Oar1bPtalROcwq40SwXAjsbslpH
 ZKkqXPFr63d7BdjYCubw6qE/aLqOG3NZBXGaFL70/S2iY94OA/Wmol83akorU3XbD0xso+xrOKM
 oEDF9LeYnj3/8jUBVCgZ7LhTYS1UAvuv5YAoJ99PKhjWHpdQtTtAKkNyZTYy3Jwzjc9kSAxOX8a
 ij2VzDEDg==
X-Received: by 2002:a05:6a20:3d87:b0:39c:373b:3b48 with SMTP id
 adf61e73a8af0-39c8ab9ef24mr8169182637.25.1774784259463; 
 Sun, 29 Mar 2026 04:37:39 -0700 (PDT)
Received: from trieu2-huynh-trieuhpn-ubuntu24.bee-live.svc.cluster.local
 ([27.122.242.65]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82ca8467824sm4353108b3a.17.2026.03.29.04.37.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Mar 2026 04:37:38 -0700 (PDT)
From: Trieu Huynh <vikingtc4@gmail.com>
To: qemu-devel@nongnu.org
Cc: Trieu Huynh <vikingtc4@gmail.com>, Huacai Chen <chenhuacai@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>
Subject: [PATCH] target/mips: save CP0 timer in vmstate
Date: Sun, 29 Mar 2026 20:37:32 +0900
Message-ID: <20260329113732.482619-1-vikingtc4@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=vikingtc4@gmail.com; helo=mail-pg1-x52d.google.com
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

The MIPS R4K CP0 timer (env->timer) is not included in vmstate_mips_cpu,
so after loadvm the QEMUTimer has no scheduled expiry. This causes
qemu_poll_ns() to block indefinitely and the guest to freeze until an
external I/O event (e.g. a keypress) wakes the main loop.

Fix by adding an optional vmstate subsection for the timer, following
the same pattern used by ARM (gt_timer), RISC-V (env.stimer), SPARC
(qtimer), and OpenRISC (timer).

The .needed callback returns false when env->timer is NULL (KVM mode),
keeping the subsection optional for backwards compatibility with
existing snapshots.

nit: when trying to reproduce of this bug requires savevm to work on
MIPS Malta. That is currently broken by a separate crash in
vmsd_can_compress() introduced by commit 7aa563630b ("pc: Start with
modern CPU hotplug interface by default"), which is being tracked and
fixed independently [1], [2]. This fix is independent of that crash and
touches no shared code.

[1] https://lore.kernel.org/qemu-devel/20260316194759.22672-1-farosas@suse.de/
[2] https://lore.kernel.org/qemu-devel/87341zsvmc.fsf@suse.de/

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1987

Signed-off-by: Trieu Huynh <vikingtc4@gmail.com>
---
 target/mips/system/machine.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/target/mips/system/machine.c b/target/mips/system/machine.c
index 8af11fd896..473d3ab036 100644
--- a/target/mips/system/machine.c
+++ b/target/mips/system/machine.c
@@ -3,6 +3,7 @@
 #include "internal.h"
 #include "migration/cpu.h"
 #include "fpu_helper.h"
+#include "qemu/timer.h"
 
 static int cpu_post_load(void *opaque, int version_id)
 {
@@ -219,6 +220,23 @@ static const VMStateDescription vmstate_tlb = {
 
 /* MIPS CPU state */
 
+static bool mips_timer_needed(void *opaque)
+{
+    MIPSCPU *cpu = opaque;
+    return cpu->env.timer != NULL;
+}
+
+static const VMStateDescription mips_vmstate_timer = {
+    .name = "cpu/timer",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = mips_timer_needed,
+    .fields = (const VMStateField[]) {
+        VMSTATE_TIMER_PTR(env.timer, MIPSCPU),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 const VMStateDescription vmstate_mips_cpu = {
     .name = "cpu",
     .version_id = 21,
@@ -333,4 +351,8 @@ const VMStateDescription vmstate_mips_cpu = {
 
         VMSTATE_END_OF_LIST()
     },
+    .subsections = (const VMStateDescription * const []) {
+        &mips_vmstate_timer,
+        NULL
+    }
 };
-- 
2.43.0


