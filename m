Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 014C1C282DE
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 02:02:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpdzl-0002GT-FV; Tue, 04 Mar 2025 20:56:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tpdz0-0007V0-HQ
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:55:43 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tpdyx-0000SB-L3
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:55:37 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-22355618fd9so108724855ad.3
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 17:55:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741139733; x=1741744533; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/+pVAm+qdHHoPEozzQnAWofmyOHOLCO+Ul/WzzNiW7U=;
 b=ITQaqPk2PhrvWiAktMtU7iNku3iudkjvxBs3AsI9s3WyUYyHqln0jKwA59smvtP4jf
 FODBBxyBH7sBtQ6HPY43Rk8n2DAE9iKjTPT59zPTQjA/dYWpETdfIA5lt8tYLgdbPxc4
 Hl46G+mHL73qcgPd8GYf9Dl0lIv7ylj+n31Ouj9pLpRFNszum1WlYvn+qUacJROy+SJp
 Srk8CAwJXfB3PwGTtOew46sP4/GfPLfNB+4JAdZCwPYhx3zyma5iKlkewsL5+C6a/X3G
 8qUEpJOqlqyTNnZGcPau0597f7yMIqlNy68O/DL2qChI5/kTrA6PxwmwZnJRoy8uYjwA
 45ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741139733; x=1741744533;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/+pVAm+qdHHoPEozzQnAWofmyOHOLCO+Ul/WzzNiW7U=;
 b=V7p4zI5v2nDW0QVyrMQE63WdaAelxanccj3YJaekYsjs5NOPSb5d6OR//uSmlqmKkN
 NzMTz3+SgwxDUdP8jY2qRiVZ5N73zeKTUgYbyIsUBK0uQ+cbDFAZ92hbcCrwZuaaTLh0
 uNILMP1P7dac+ZYgkn15Vn3yKbPAs0M0riB9xCy23PvYGKZOZ1coHg/5fr1soEcY6xx5
 c+BOBFVf9HjY0exNGHTWSSfag6h/iuTlj4WoFuRvpyqIjtz6knENMksTI5OVa/iQMyFl
 CLpd8pS2f3LxxP3UUrFik6DQ2yVh1kSrxhsKNnQUEZNWa6sbaE4EcTw5kL/wYCuk6i1t
 kANg==
X-Gm-Message-State: AOJu0Ywu7xzUHMYzmHsbS5FOBV41+5gHK0KyiHqhx68qIBun0htJwAve
 A6W9eIZF7HsLU4BerUnVwmAhuwAtTLNhwwlvbJKt6VffNg85Zaw7ry1b33f0rPQ=
X-Gm-Gg: ASbGncs8fBwoxnEInRIgCoCknce4PtjnUmkTrM7dbXbc7Y9F4TdILxsHQ7PnNREqEdk
 HWS3O9plfoDNaONP29P4OYzkGnuDXNx3xrP08DHJ0jxvqyH2uYflh0odNxtjR9gc+MA9zCCb6lR
 QX5mUucIufsb+N0LMtYGJw6/7d07DJv+MXWnsNMBzxc+T0TBnlXv2J3cDOX1+r1oV+/EbC7Z0GS
 rzg4EFxqGa9fKuDe2u67s/Z/q13wX2PWTFUyNOIaQ/gC0HY8m9CCs3LI1Xp6DF0fjSH6Oj38F3O
 6tju6SJnD7S18UrSUF1ADINVzpx8k7cCaZGvsiXw9G60LvODlQCqO7QMSR+EjnKM5OHZDTRebQ3
 hmW2T0JGy7W+eSZdXNTswHYZDsJHEkLAyaTkx+XZkUHWTEOBjGZ4=
X-Google-Smtp-Source: AGHT+IG9Qa6W+2RZ8jDp06RQZ2+2ktmK7g3N8ol7rVfFdEKCFnyGnOGoFKPqguFToxwPbsL34mgeTQ==
X-Received: by 2002:a17:903:182:b0:223:2630:6b82 with SMTP id
 d9443c01a7336-223f1c6903amr26918465ad.10.1741139733120; 
 Tue, 04 Mar 2025 17:55:33 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-223501f9e04sm102583695ad.87.2025.03.04.17.55.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Mar 2025 17:55:32 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Tomasz Jeznach <tjeznach@rivosinc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 47/59] hw/riscv/riscv-iommu.c: add RISCV_IOMMU_CAP_HPM cap
Date: Wed,  5 Mar 2025 11:52:55 +1000
Message-ID: <20250305015307.1463560-48-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305015307.1463560-1-alistair.francis@wdc.com>
References: <20250305015307.1463560-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x635.google.com
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

From: Tomasz Jeznach <tjeznach@rivosinc.com>

Now that we have every piece in place we can advertise CAP_HTM to
software, allowing any HPM aware driver to make use of the counters.

HPM is enabled/disabled via the 'hpm-counters' attribute. Default value
is 31, max value is also 31. Setting it to zero will disable HPM
support.

Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20250224190826.1858473-10-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/riscv-iommu.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index cdbb848181..d46beb2d64 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -2357,6 +2357,15 @@ static void riscv_iommu_realize(DeviceState *dev, Error **errp)
                   RISCV_IOMMU_CAP_SV48X4 | RISCV_IOMMU_CAP_SV57X4;
     }
 
+    if (s->hpm_cntrs > 0) {
+        /* Clip number of HPM counters to maximum supported (31). */
+        if (s->hpm_cntrs > RISCV_IOMMU_IOCOUNT_NUM) {
+            s->hpm_cntrs = RISCV_IOMMU_IOCOUNT_NUM;
+        }
+        /* Enable hardware performance monitor interface */
+        s->cap |= RISCV_IOMMU_CAP_HPM;
+    }
+
     /* Out-of-reset translation mode: OFF (DMA disabled) BARE (passthrough) */
     s->ddtp = set_field(0, RISCV_IOMMU_DDTP_MODE, s->enable_off ?
                         RISCV_IOMMU_DDTP_MODE_OFF : RISCV_IOMMU_DDTP_MODE_BARE);
@@ -2404,6 +2413,18 @@ static void riscv_iommu_realize(DeviceState *dev, Error **errp)
             RISCV_IOMMU_TR_REQ_CTL_GO_BUSY);
     }
 
+    /* If HPM registers are enabled. */
+    if (s->cap & RISCV_IOMMU_CAP_HPM) {
+        /* +1 for cycle counter bit. */
+        stl_le_p(&s->regs_ro[RISCV_IOMMU_REG_IOCOUNTINH],
+                 ~((2 << s->hpm_cntrs) - 1));
+        stq_le_p(&s->regs_ro[RISCV_IOMMU_REG_IOHPMCYCLES], 0);
+        memset(&s->regs_ro[RISCV_IOMMU_REG_IOHPMCTR_BASE],
+               0x00, s->hpm_cntrs * 8);
+        memset(&s->regs_ro[RISCV_IOMMU_REG_IOHPMEVT_BASE],
+               0x00, s->hpm_cntrs * 8);
+    }
+
     /* Memory region for downstream access, if specified. */
     if (s->target_mr) {
         s->target_as = g_new0(AddressSpace, 1);
-- 
2.48.1


