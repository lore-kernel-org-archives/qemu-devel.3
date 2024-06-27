Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A4C0C3064D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 10:03:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMlxC-0005vg-8f; Thu, 27 Jun 2024 06:02:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sMlx8-0005X2-0h
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 06:02:06 -0400
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sMlx6-0001hp-2B
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 06:02:05 -0400
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-700cc97b220so1378844a34.0
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 03:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719482522; x=1720087322; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a7nUOVc8poO2k61wXomx0Mx7KlCErB954jv8HLoD7N4=;
 b=CAPaVOOIEuRxUNytAPIZxfBBCWw26O5pBtA7E5mDAfmXj2Nc/tms3Pz/fP9vEyocwv
 u15SqqJhXu3bTelfwX8HKQXgdJneQIrv/Ul66YlEhr+pYmPH1YilDmABmMT6OiHHwDpn
 7eNVHQmC6kD3ArQ9IOcG2MKJ0Udel5KyO4B+TUFI8/1a1jQBWYzKm6UGQogYiqitQVlK
 ePwsdeLEcAssLSsVECRlvQd5q0qV79GwcF4md4wA2moJYAz5a9MvbumbVXWn9dn/KcpF
 80YScoOYtAHcH14vwP68KF42IHi/1OBtnXjgVoCaVayStPc/9AB3eHtvBhQNUuSg3myJ
 Ysbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719482522; x=1720087322;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a7nUOVc8poO2k61wXomx0Mx7KlCErB954jv8HLoD7N4=;
 b=Vfp/Vgu+ipbVYftCfU4ApNVrkGDYIacyAYtJ/EXEJ3U0qI+ZxaIbZuTvHDFsXm/DCy
 iqgjUijqFLfmLpXjqJvJ/czZ42nW8K0hvuG0MCSD8Z3/Ju7ps9muy3L8pVRCwquariCD
 p9/ThfZCTbnX8TDhAcT1FvLphZ7EbPQLWLvoa591hGj70zuaXpGiWCioxPvHLpuqDg2d
 W7dZzNkc2ipYDTTXSmg1L6fNDphMVxkDb2nMdbQtuEVlQ+Cz+jClYfiE8C9me9sIqpcX
 I2s/bhTrS+v8XGpbjIrL7HXTLXeYUmMbSIkPWbTuFRd00kO8EaGJjKEGPJBuN0kyUsBm
 RhJg==
X-Gm-Message-State: AOJu0YzvnLJWFmoYNDjPXTF4s+a71uSAuD/+c7gzS9LHJZ23EHrzmI3W
 k4Yx75KRronlamQ6+3B3qN3royl+pT/gUZplBsP4zU7ehv/EvKQD9Z1G3vp1
X-Google-Smtp-Source: AGHT+IH22vdkztO0vTep4QjsMx/oz+x31D0X47UMXRdwd5yuSWwMQb6dvSOPtSA/SQy8oyrOqlvcKA==
X-Received: by 2002:a05:6870:d152:b0:254:8908:4281 with SMTP id
 586e51a60fabf-25d06e55f68mr12608592fac.44.1719482522055; 
 Thu, 27 Jun 2024 03:02:02 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-706b4a07326sm932431b3a.111.2024.06.27.03.01.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Jun 2024 03:02:01 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, "Fea.Wang" <fea.wang@sifive.com>,
 Frank Chang <frank.chang@sifive.com>,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 18/32] target/riscv: Add MEDELEGH, HEDELEGH csrs for RV32
Date: Thu, 27 Jun 2024 20:00:39 +1000
Message-ID: <20240627100053.150937-19-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240627100053.150937-1-alistair.francis@wdc.com>
References: <20240627100053.150937-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::332;
 envelope-from=alistair23@gmail.com; helo=mail-ot1-x332.google.com
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

From: "Fea.Wang" <fea.wang@sifive.com>

Based on privileged spec 1.13, the RV32 needs to implement MEDELEGH
and HEDELEGH for exception codes 32-47 for reserving and exception codes
48-63 for custom use. Add the CSR number though the implementation is
just reading zero and writing ignore. Besides, for accessing HEDELEGH, it
should be controlled by mstateen0 'P1P13' bit.

Signed-off-by: Fea.Wang <fea.wang@sifive.com>
Reviewed-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20240606135454.119186-5-fea.wang@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_bits.h |  2 ++
 target/riscv/csr.c      | 31 +++++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index c895aa0334..096a51b331 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -156,6 +156,8 @@
 
 /* 32-bit only */
 #define CSR_MSTATUSH        0x310
+#define CSR_MEDELEGH        0x312
+#define CSR_HEDELEGH        0x612
 
 /* Machine Trap Handling */
 #define CSR_MSCRATCH        0x340
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index a19e1afa1f..6f15612e76 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -3229,6 +3229,33 @@ static RISCVException write_hedeleg(CPURISCVState *env, int csrno,
     return RISCV_EXCP_NONE;
 }
 
+static RISCVException read_hedelegh(CPURISCVState *env, int csrno,
+                                   target_ulong *val)
+{
+    RISCVException ret;
+    ret = smstateen_acc_ok(env, 0, SMSTATEEN0_P1P13);
+    if (ret != RISCV_EXCP_NONE) {
+        return ret;
+    }
+
+    /* Reserved, now read zero */
+    *val = 0;
+    return RISCV_EXCP_NONE;
+}
+
+static RISCVException write_hedelegh(CPURISCVState *env, int csrno,
+                                    target_ulong val)
+{
+    RISCVException ret;
+    ret = smstateen_acc_ok(env, 0, SMSTATEEN0_P1P13);
+    if (ret != RISCV_EXCP_NONE) {
+        return ret;
+    }
+
+    /* Reserved, now write ignore */
+    return RISCV_EXCP_NONE;
+}
+
 static RISCVException rmw_hvien64(CPURISCVState *env, int csrno,
                                     uint64_t *ret_val,
                                     uint64_t new_val, uint64_t wr_mask)
@@ -4633,6 +4660,10 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
 
     [CSR_MSTATUSH]    = { "mstatush",   any32, read_mstatush,
                           write_mstatush                                   },
+    [CSR_MEDELEGH]    = { "medelegh",   any32, read_zero, write_ignore,
+                          .min_priv_ver = PRIV_VERSION_1_13_0              },
+    [CSR_HEDELEGH]    = { "hedelegh",   hmode32, read_hedelegh, write_hedelegh,
+                          .min_priv_ver = PRIV_VERSION_1_13_0              },
 
     /* Machine Trap Handling */
     [CSR_MSCRATCH] = { "mscratch", any,  read_mscratch, write_mscratch,
-- 
2.45.2


