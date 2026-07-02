Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7969C43602
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 13:53:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfHpq-000258-Bv; Thu, 02 Jul 2026 09:52:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wfHpo-0001xH-SQ
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 09:52:09 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wfHpm-00082s-Sx
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 09:52:08 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 662D0nC3522511
 for <qemu-devel@nongnu.org>; Thu, 2 Jul 2026 13:51:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 qBLq/hTlgm1QtyfB42Sk4kHf4dGeBXIWIn56JGk66ik=; b=WYCykbE+IsETdIuY
 dZjmmZ60lkQvlaE1zLcPNlhJ0NL8lzrA9EqjwHn/BlI2hJD8MIBgmT6GZ6NANIeF
 W9ogj9QeqDMIxa0ZQrx1CImS1aG01b0lAhbTrUsGs407nuzO22FhtAxlfyuNxSBZ
 kP6lsgi+3TupTukAwjRTCFr0kksSmtFZOTIkM69jvK2cPF1sm09YHl5tzXypocFv
 yvJcE4dA4yfB++MgYAv8w3Qg2aUS9Ji8NHzOGlD0MuwhDjS6CRkmr/eLqOHPWvMx
 SJW62R2FJbquYJsR0xdj4xuYWUEiCK1b4b0nq0+bGBrT0qgOuUTWZB2BdqQX5XbM
 VGyKHA==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5knc1ggp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 13:51:55 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id
 ada2fe7eead31-739b4a4301dso1664199137.0
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 06:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783000315; x=1783605115; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=qBLq/hTlgm1QtyfB42Sk4kHf4dGeBXIWIn56JGk66ik=;
 b=H9rymkfl8xKvd15aGqFN0Gjn8W98jEcnMag8sc0f3QuNPvvBHEpzwZG2BPa5BaGn4K
 wqjsCTTpF8WTdYkC0fCnIeEyrB64UD6gpVBxSrDz+kL3p6Z9lwZMl0SRKgu+4To9zyep
 99MjABcuzriemgcf3BQuDcBRtNnQn0yAn91GYHIEkDJjroSdJYrtPBT1fEK3eU4Yr20h
 xOeIJ9XKJsBHmTuYWVk2TtfXU4Fze6nZUPvoPRza5BWz4ETFnCsk3TgsvR3n9N/a9dA7
 hpjeELOc4G27uRat0f4meh9ncpnT3VMuWg8RYrsDeG6U9GZ1qcHBfMnQy+fZxhMklwrs
 lGDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783000315; x=1783605115;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qBLq/hTlgm1QtyfB42Sk4kHf4dGeBXIWIn56JGk66ik=;
 b=YNSDbN03D/x3w6JMibL7Pw4P8pZoI3jD5NMNozwIJ3i7cCyG5tdC0Uscge/Wh5JxHj
 5Oz8shQu3iUGM9pmyQXTPYveBE5DOU8tSJNNJvQvg8gLSlMJdWDa5Bh7pJH34fFnQD1F
 Vw2gKq7Mw3ZAdCn3mMEf0vRho2wXx65CWOZmSo/nxPNyAb4n2K2VKksA4jehT5ywbWaz
 eqWVK0e0WD56uSfLEGJvoPao/vF2euHN5Xp6L/RHI9GoWSseqSz2Pp+9aYWOxyWm9KKI
 Q62Veza0kGYsoe575pfdV5vnwSuOuKphPTyEgt3caV/XSgT34YPntTDZR4fbbxO+yJLj
 XD/w==
X-Gm-Message-State: AOJu0YyQZlnUfXjEzsnSN2IYxbelnNe6e1OzYJxpDRKUpBSh4tw0UBsY
 Ac49++o5VhgRMtms2TRdaxWAmCuCbdHtVEyrWTWeuxhPCW6eqqOklhUIePzwKVM8eGtDrlSyn8k
 T0F6ZVZk7tZrMNtvvRxw7MnRqK+HjXwo8M73aUzMih2y2V6fZixi0ExrOD/osEYaLiw==
X-Gm-Gg: AfdE7ckPipDYXzj8nRZRPlQoDDV7+nQJdIfSbNlX8B7uWIHMBM+rL2sDRDqzu41vI/n
 W7YeBesNT/Nt0aVpQOkXl3ZsbDEGVGNT6Cs21hgAj3r6X+ndFRirDV13jiZdPJpQjsoc06ckAgt
 LCh6esAgi7eX0DUe8493oIAEvXj4oaN6GCkyk8wY5Iq4DvwHnFDW/t3D1D+yj48uF40S8c8xwyL
 MimRtpMFGaPUE23VXT9f74Rs47LpliR72A4jG/1OnfS26XWGkDmpkdUL0ys9gtVwfEzV8LHKm4H
 vEeyrgHZxGT5Mq8UgZ05Z2m0FoepNQ8Fcz/hqwp/5VsIPtvP0BuYrM5NSbO2hxaH3m18/d25O2p
 V3kRHFwrG1Q7EbSro7skDSkW08AxQibbMhobh0RK6zegCRw==
X-Received: by 2002:a05:6102:4414:b0:739:4fa1:50aa with SMTP id
 ada2fe7eead31-73dbf3a292dmr2417847137.14.1783000315297; 
 Thu, 02 Jul 2026 06:51:55 -0700 (PDT)
X-Received: by 2002:a05:6102:4414:b0:739:4fa1:50aa with SMTP id
 ada2fe7eead31-73dbf3a292dmr2417833137.14.1783000314862; 
 Thu, 02 Jul 2026 06:51:54 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.79.21.40])
 by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-73e1c4e64a3sm1276462137.9.2026.07.02.06.51.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 06:51:54 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v3 08/24] target/riscv: remove csr.h from kvm-cpu.c
Date: Thu,  2 Jul 2026 10:51:10 -0300
Message-ID: <20260702135128.1188021-9-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260702135128.1188021-1-daniel.barboza@oss.qualcomm.com>
References: <20260702135128.1188021-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: S2iETsi9BFD0hEn4vmt_wEdPlvlUH3L1
X-Authority-Analysis: v=2.4 cv=a4kAM0SF c=1 sm=1 tr=0 ts=6a466cfb cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=sHJf4AwOIoU3qjeHFPlg6Q==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=JF9118EUAAAA:8 a=KJWeSTv_TiI39BqBT3cA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=ODZdjJIeia2B_SHc_B0f:22 a=xVlTc564ipvMDusKsbsT:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDE0NCBTYWx0ZWRfX+KPpY5KsXhaj
 ihHDcOvluierfUrXye/ONJfPmioAdst+ATy0Qtt48wvCakmC4+j5LPnuvUTpSXVwisfmlzQDdvY
 5HqeodxgXGwbTkJX1nW/SarChOYEbiIX8Z8wEPeYTMCp2NYw1W8RW2gQxvnsi7Vq6jx5+dv+RGW
 SvXgsS6VbAZ2PhDdqe8zf0tc883rtf6OX7Rib+y2ZE1jcU+ai1tuMLQGON9KL5+TulWN0hPXdwZ
 iiLu+JawDJa1Q0PLmdSUMn3EHKCaW0ghKFM+LJKizb4pqwzU+sw323qLy4/+9LiXt/LdDkLBTpX
 UCwTfnGKzfL7MAelPK2DNdaADskqoP6C1W9Dq5jBX/s8/H68BvEo6I6A550kcxCGx2ZTsKgZXjz
 ccSj1qQlnCAC7l29dltYPQxwS/A9SnEBf77+doXnVt7S8lP7O3ZnrqyE5EnamXTEPsaLHOGO8b7
 RMp/O8Qnqyu6L5AK45A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDE0NCBTYWx0ZWRfXySiDmgK/rLEe
 FY/V3M6K70QVKEfoMlYukEV2sLo/brpEUy2W4/8S2yShZy5k7HF3nR1nX3KKW3j42MS0/D2aQYl
 ioryyIbQISZ0Fwb0m95Whk2NZme5vds=
X-Proofpoint-GUID: S2iETsi9BFD0hEn4vmt_wEdPlvlUH3L1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0
 suspectscore=0 priorityscore=1501 bulkscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020144
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

Move riscv_new_csr_seed from csr.c to cpu.c since this function is
shared with KVM.  With that we can remove the csr.h from kvm-cpu.c.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c         | 30 ++++++++++++++++++++++++++++++
 target/riscv/cpu.h         |  3 ++-
 target/riscv/csr.h         |  3 ---
 target/riscv/kvm/kvm-cpu.c |  1 -
 target/riscv/tcg/csr.c     | 29 -----------------------------
 5 files changed, 32 insertions(+), 34 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 301f4b3dc9..96e9efbf01 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -21,6 +21,7 @@
 #include "qemu/qemu-print.h"
 #include "qemu/ctype.h"
 #include "qemu/log.h"
+#include "qemu/guest-random.h"
 #include "cpu.h"
 #include "cpu_vendorid.h"
 #include "target/riscv/csr.h"
@@ -543,6 +544,35 @@ static void riscv_register_custom_csrs(RISCVCPU *cpu, const RISCVCSR *csr_list)
 }
 #endif
 
+/* Used by csr.c and the KVM driver */
+target_ulong riscv_new_csr_seed(target_ulong new_value,
+                                target_ulong write_mask)
+{
+    uint16_t random_v;
+    Error *random_e = NULL;
+    int random_r;
+    target_ulong rval;
+
+    random_r = qemu_guest_getrandom(&random_v, 2, &random_e);
+    if (unlikely(random_r < 0)) {
+        /*
+         * Failed, for unknown reasons in the crypto subsystem.
+         * The best we can do is log the reason and return a
+         * failure indication to the guest.  There is no reason
+         * we know to expect the failure to be transitory, so
+         * indicate DEAD to avoid having the guest spin on WAIT.
+         */
+        qemu_log_mask(LOG_UNIMP, "%s: Crypto failure: %s",
+                      __func__, error_get_pretty(random_e));
+        error_free(random_e);
+        rval = SEED_OPST_DEAD;
+    } else {
+        rval = random_v | SEED_OPST_ES16;
+    }
+
+    return rval;
+}
+
 static ObjectClass *riscv_cpu_class_by_name(const char *cpu_model)
 {
     ObjectClass *oc;
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 70b8729bd7..c0e9098728 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -972,7 +972,8 @@ bool riscv_cpu_accelerator_compatible(RISCVCPU *cpu);
 extern const bool valid_vm_1_10_32[], valid_vm_1_10_64[];
 
 void riscv_cpu_register_gdb_regs_for_features(CPUState *cs);
-
+target_ulong riscv_new_csr_seed(target_ulong new_value,
+                                target_ulong write_mask);
 const char *satp_mode_str(uint8_t satp_mode, bool is_32_bit);
 
 const char *priv_spec_to_str(int priv_version);
diff --git a/target/riscv/csr.h b/target/riscv/csr.h
index c791260f83..73d874ee98 100644
--- a/target/riscv/csr.h
+++ b/target/riscv/csr.h
@@ -12,9 +12,6 @@
 #include "exec/target_long.h"
 #include "cpu_bits.h"
 
-target_ulong riscv_new_csr_seed(target_ulong new_value,
-                                target_ulong write_mask);
-
 RISCVException riscv_csrr(CPURISCVState *env, int csrno,
                           target_ulong *ret_value);
 
diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 39d48a9db4..dcdaf7f2b3 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -31,7 +31,6 @@
 #include "system/kvm.h"
 #include "system/kvm_int.h"
 #include "cpu.h"
-#include "target/riscv/csr.h"
 #include "trace.h"
 #include "accel/accel-cpu-target.h"
 #include "hw/pci/pci.h"
diff --git a/target/riscv/tcg/csr.c b/target/riscv/tcg/csr.c
index 7da20b5500..2092cd712f 100644
--- a/target/riscv/tcg/csr.c
+++ b/target/riscv/tcg/csr.c
@@ -29,7 +29,6 @@
 #include "exec/icount.h"
 #include "accel/tcg/cpu-loop.h"
 #include "accel/tcg/getpc.h"
-#include "qemu/guest-random.h"
 #include "qapi/error.h"
 #include "tcg/insn-start-words.h"
 #include "internals.h"
@@ -5584,34 +5583,6 @@ static RISCVException write_mnstatus(CPURISCVState *env, int csrno,
 #endif
 
 /* Crypto Extension */
-target_ulong riscv_new_csr_seed(target_ulong new_value,
-                                target_ulong write_mask)
-{
-    uint16_t random_v;
-    Error *random_e = NULL;
-    int random_r;
-    target_ulong rval;
-
-    random_r = qemu_guest_getrandom(&random_v, 2, &random_e);
-    if (unlikely(random_r < 0)) {
-        /*
-         * Failed, for unknown reasons in the crypto subsystem.
-         * The best we can do is log the reason and return a
-         * failure indication to the guest.  There is no reason
-         * we know to expect the failure to be transitory, so
-         * indicate DEAD to avoid having the guest spin on WAIT.
-         */
-        qemu_log_mask(LOG_UNIMP, "%s: Crypto failure: %s",
-                      __func__, error_get_pretty(random_e));
-        error_free(random_e);
-        rval = SEED_OPST_DEAD;
-    } else {
-        rval = random_v | SEED_OPST_ES16;
-    }
-
-    return rval;
-}
-
 static RISCVException rmw_seed(CPURISCVState *env, int csrno,
                                target_ulong *ret_value,
                                target_ulong new_value,
-- 
2.43.0


