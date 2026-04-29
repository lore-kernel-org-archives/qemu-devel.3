Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69506FF8867
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 04:50:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHws9-0004hG-Kg; Wed, 29 Apr 2026 00:50:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wHws7-0004VR-Vt
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 00:50:04 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wHws6-00008m-74
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 00:50:03 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2ad9516a653so61696535ad.0
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2026 21:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777438201; x=1778043001; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8aJdIKQsrxZX3dfBBdKm1LLNMdym3GoXLlya5UAy0ms=;
 b=C6lxuA69JsRGcmeK1doHk5hCe6aBtYjxq0gNfKRtnKZF6tfEzsMBBoFgDpMNoCI3n2
 XRlatSxqXhBQ4fXYUhmstQyhfL8xEuhfrVs/5yhqxP1U4PdSNFzPDuCuQy9THalS1Ong
 T8CnS6jL3hI+X9Kq4AQ26zY0bpzlejAGfk9sjEBgdFyo+SwBYGWhBnyysO5Yk6QK+HCz
 9HG9e7G3OzIRyQ0BMcntiodN2ZL4f4as1QW2z4SF4loXfsOWeolOv0AIaV5IVdsCuDbc
 l3uQtKuA6eWd2L1e+qKl4Y63nchnO1PHrT7M+NV7324JRY8PuAGQoWRFIPz8tEcQCbJR
 j5gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777438201; x=1778043001;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8aJdIKQsrxZX3dfBBdKm1LLNMdym3GoXLlya5UAy0ms=;
 b=kwDIdk2d0+obJsFfO4M3XRJiZG9NL7cGlSk/jC8Wism+abanp10b8qIZ4oo0MDN4J3
 ErGpuBnPginkzvLEk8o+kTk3/ghOGEfFfY28q9hW4RIH2HkC76eRRDwPOYz/DaMnjYDt
 jRTHMxTXsY4jpkuBGpNR+tZQSOPCLmOEDJPA12sSK5u9BnNIguYxOhhbe/1AvU0QwnEh
 j59qXdWICDsAHhbuyHNidqdblQf8rxNNdQGd5aukCAbhKKnJqD6sZKaWZcusO65q4qZy
 qNidY8D/XbYtrEulWEO4tRmfP8SCoESA/bV0QfzdHy0epZwKgTnO0Igq9z02ZcC4HACZ
 Ibmg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9K+i4iY9PKXOYIew5Z1TWpGoIR0L9jFpq8v9ZTmg4LVjtQrQn6aG+J5rZzhJOscOvdWDAxjgkdcbIg@nongnu.org
X-Gm-Message-State: AOJu0Yx0t5NqdlJPnApINFjf73+n3rKutB6hc4XK8B4q9mcBswo6xbyP
 AyIyUp2Meq3KvHW8oOPpWbUbQFlOKAUF+ZBnYzZfJgMNEhlfqj6sTjrs
X-Gm-Gg: AeBDievgZRt35rmn5bxOZqlybIdQ2ukWywN91wFL3/kllbRfQBR18qMeuU4xZjuYc7D
 snnI76A6ILpGpOZoouSLxBmZGkYknNWpDg9ZhVg7pqLFoFZJc2rhcrBNEPLIMBAAnSV5x2vb5bl
 iH25k5ltDJvyFMZ4dMaioy4mhv9t7EwyzyYFw8WVfxo1yHRx70E36zCkWW24teyCgvq6RmZ8yt+
 ueY3I7u0HgU4JtB4s6dhw/6qIbsHX0a27RZfD/ZGF/E2ZHn5WUXM2ecY5c55GaLTGXvcOlTdz3d
 PhuFCiqG2H5bEGMijdOJceqSiYbHEKACAbpgcKL92f10R/e3rFM3urK3cJ/F9mTiyaEhEjjIvMd
 jyzAEa0VUuGdWjL+OMK0YSs7ZKovjg4Fk5byVtVD/mT7Hsndgw70VHOGF3RXbwiKo1brjjaN/5Q
 x8LQDP/ObrU7HwAANB3QkVFcFQuA+9lz7G2gpzMpTf8qfaWXj5Uo0apwI+i3xTZl4=
X-Received: by 2002:a17:903:11c7:b0:2b2:65db:8c51 with SMTP id
 d9443c01a7336-2b98730ce7fmr20980545ad.8.1777438200784; 
 Tue, 28 Apr 2026 21:50:00 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b988772ae8sm7756145ad.7.2026.04.28.21.49.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 21:50:00 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: palmer@dabbelt.com, liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Yicong Yang <yang.yicong@picoheart.com>,
 Andrew Jones <andrew.jones@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 22/51] hw/riscv/virt-acpi-build.c: Use kvm timer frequency when
 kvm enabled
Date: Wed, 29 Apr 2026 14:47:23 +1000
Message-ID: <20260429044752.4176397-23-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260429044752.4176397-1-alistair.francis@wdc.com>
References: <20260429044752.4176397-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x629.google.com
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

From: Yicong Yang <yang.yicong@picoheart.com>

The timer frequency is decided by the host(kvm) rather than a fixed
RISCV_ACLINT_DEFAULT_TIMEBASE_FREQ on kvm accelerated VM. So build
RCHT with KVM provided timer frequency if KVM is enabled, just like
how we build the timer node on DT based VM.

Fixes: ebfd39289370 ("hw/riscv/virt: virt-acpi-build.c: Add RHCT Table")
Signed-off-by: Yicong Yang <yang.yicong@picoheart.com>
Reviewed-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
Message-ID: <20260325081314.57089-1-yang.yicong@picoheart.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/virt-acpi-build.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
index f1406cb683..fd6ca5dbc4 100644
--- a/hw/riscv/virt-acpi-build.c
+++ b/hw/riscv/virt-acpi-build.c
@@ -35,9 +35,11 @@
 #include "hw/riscv/virt.h"
 #include "hw/riscv/numa.h"
 #include "hw/virtio/virtio-acpi.h"
+#include "kvm/kvm_riscv.h"
 #include "migration/vmstate.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
+#include "system/kvm.h"
 #include "system/reset.h"
 
 #define ACPI_BUILD_TABLE_SIZE             0x20000
@@ -296,7 +298,10 @@ static void build_rhct(GArray *table_data,
 
     /* Time Base Frequency */
     build_append_int_noprefix(table_data,
-                              RISCV_ACLINT_DEFAULT_TIMEBASE_FREQ, 8);
+                              kvm_enabled() ?
+                              kvm_riscv_get_timebase_frequency(&s->soc->harts[0]) :
+                              RISCV_ACLINT_DEFAULT_TIMEBASE_FREQ,
+                              8);
 
     /* ISA + N hart info */
     num_rhct_nodes = 1 + ms->smp.cpus;
-- 
2.53.0


