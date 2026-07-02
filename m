Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C042C43602
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 13:53:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfHpq-00027Z-IE; Thu, 02 Jul 2026 09:52:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wfHpn-0001oo-3r
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 09:52:09 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wfHpl-0007zy-D9
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 09:52:06 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 662D0a0N522201
 for <qemu-devel@nongnu.org>; Thu, 2 Jul 2026 13:51:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 vbLW737oNQQrPNBx8WtyFR4N5LcmQHFE8I2qqIoK2bM=; b=iEt6odkxiYd6r/sx
 7TAyMNvrqVbQIO66f+CAGxLruIZ326R6SMvGJST0SxM2szUwackMLOAL8k4rKiJs
 q+Xfv5h+ydZpWBj8QRD9Tg1M5T61VX6vsx+D2iHbJzeMG52YFzkxxe6AxjvtYLBa
 DH70OsfMdbJ5dL9aan6mZ0jas0/uJ+lyg+7XBm0KuXxsmjmlM/ueXalrmhpLIaCZ
 yH0J5e4qOVIcIL0a/0GQ90oDiuk/qMuEXr4423sYVsYwPYrjtrWW8aPgcLEvj3JC
 XImi1r5Ld8YoucsDj/3E+XVaFlN1Zzlyw4tfaK9gEtLjO3bVpqb+wSLNG+uf1SyW
 0Cq/Wg==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5knc1ggf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 13:51:53 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id
 ada2fe7eead31-6751db2792dso867029137.3
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 06:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783000313; x=1783605113; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vbLW737oNQQrPNBx8WtyFR4N5LcmQHFE8I2qqIoK2bM=;
 b=JWoPfDF3evSc1Nt24Jz6yYgn91gt9eOMI1s+9PMsruaxERe+TzviHQziOPi4GPbvbz
 jv5PPsxFgkIG3vJcZrMpZn9DwfI19plqsoQlxkVuf1CPhoexzxA50vFQeD3Z+eWvq2Bv
 QLQU8EH8ZLtmYyIGUxi/Pmu6RzOOtWghf/Vj86ZKosMCTeNG4rr4R2+KDcidFkzzxplU
 Jo3yQ1eRvJkUg1pkdHUenMAIbZUZK3T9ZORg8UDZAQDLxMeTNzC4tbS1x4i01ekj+7je
 SpDXEJS1zT+uP16LaOWk5zxcHr2qd68+Cnq4yIBDCeIOTXyWO6IuCdnB77iAalyLHecP
 vAcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783000313; x=1783605113;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vbLW737oNQQrPNBx8WtyFR4N5LcmQHFE8I2qqIoK2bM=;
 b=szEUbdxUNfpJpBXbQVT8XABBrczLRoLOFvHa4ZwIWWtyeeAxnCy3RGx/+EDNyjm59I
 QFVykXeTlQFfR1ED6X0jAR0hSJDxPdwo51+/hxeLFpOiyiofj6vFPGX3lYa9S4G2uBmH
 r9lQqmZ/2LO92SCdzmP3KQrUmYNl9eMlD9X7xF9FHjh3ZOnBGNFKxQ/R70uhxv/tSrlA
 0rO1n25wMDr29fZx2onHwEzF89Ps1Tn3+pT7DqNCranaccRgyD4ue8EXt47gZfKghlpK
 ZRiLQkkRyvnvBcx3+txVJZpgl4+lmh/O9dayJ21FNEv3sMN/7s0EDkdDZLPKkQcvqLF/
 0YGw==
X-Gm-Message-State: AOJu0YzhTpt0ynoyz20lp4gYN7ufs/qY/lGfSVdP2FXBCHbCN6/QJf42
 hsunXws3BVmHl14rIhTwIzVY9Z22WuYZP5vbz3QCJ8OurxLjnOdXF9BYMNJ+Mpw/LDtXEqZGDJD
 WlTvT8OXRwZWJuAo2NTzGn2oe29/AstlmWi8V/bGAh3yeAORxPABXS6wO423V20LYqg==
X-Gm-Gg: AfdE7ckvKlYtFFaJMbNslpYWOXxujBoucaXp+o7osgB74qkBJXbd1103PgKe/i9GZPq
 JZ7nYZHsmY+r7dp152WjDOq5ahy2DvRdAeZmogMEBlzOI5POh6njnOcwHPQIQqXcSLPTfp/o0bh
 PIvxXRDzoLlEaiOWzLVhnhrhstAMMBkDQuPTjT23korrPpcBpz+Lq2CLmzTuqwnrH5Oihx4+lGV
 OFO7bJ73N0AvN3hhCj+AE2+VQTZm33uWxfEv4haAg/xhlTNEAf9TXs8BbvqzJsIMIQHCsmuM9Kb
 g9uHWH0ZnDb76Z+7jIaxrMeZV7iRzCRRP7Dc3is8sf4qSpPnalJl20cPTDzW36hEd0wZyckxluw
 qeSnCBCNaJrFq7h/VV2KDMZ8vXTzr730ywm2DXIYyMTVlKw==
X-Received: by 2002:a05:6102:5114:b0:739:5cfb:50f5 with SMTP id
 ada2fe7eead31-73da99df13bmr2356855137.18.1783000312844; 
 Thu, 02 Jul 2026 06:51:52 -0700 (PDT)
X-Received: by 2002:a05:6102:5114:b0:739:5cfb:50f5 with SMTP id
 ada2fe7eead31-73da99df13bmr2356838137.18.1783000312390; 
 Thu, 02 Jul 2026 06:51:52 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.79.21.40])
 by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-73e1c4e64a3sm1276462137.9.2026.07.02.06.51.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 06:51:51 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v3 07/24] target/riscv: move debug.h to tcg subdir
Date: Thu,  2 Jul 2026 10:51:09 -0300
Message-ID: <20260702135128.1188021-8-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260702135128.1188021-1-daniel.barboza@oss.qualcomm.com>
References: <20260702135128.1188021-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: zPMdi3xT8BpP03sqc_8uTC05Ny1iQlAK
X-Authority-Analysis: v=2.4 cv=a4kAM0SF c=1 sm=1 tr=0 ts=6a466cf9 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=sHJf4AwOIoU3qjeHFPlg6Q==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=JF9118EUAAAA:8 a=0TWWAF0crFuRuLJakD8A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=gYDTvv6II1OnSo0itH1n:22 a=xVlTc564ipvMDusKsbsT:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDE0NCBTYWx0ZWRfX0m3BTRCyx/ug
 kPFM2AfZxJwWO8kJox7IqRKNWM86/d62vpxnI2IvU4u7RDk7+6RIoeJ5TNtzL1A98FY+Aa2EN5Y
 1hb8GHm7APanIK09w9HlFHkQqE1gVnSvVkCsUEvH3CMFA4QVccOs3eEC6FbFUN2motWKhQRlRgx
 zawasbO61+AKBNwE/p/WqIJT6N6hVEuQLgQfjcdEg5WlPu2SPX4DOzcqMffg0xVBdtSBUNpOnTs
 E/dlS53XMo+nB1pExWVwwc9g0AFNipNoVR8Fnj2tx7Vu2YkIat/ONPv7CLz/oJmzc+uYreDBtEp
 /WLlGPqhCskdXnZ8BWZagvEQo8ZpryMUBTUpOArUoYB9XVZ1pHabUaV3YKKEKUeRumGiYUuMXPk
 f8axYEuGiMlnf8yyZlUYGm3GiE8EkK9fgs56fhvPrQzdgu2CiPNkb2YMyVluX4c7xQAsOfaXMi+
 FnI90y5VNO9CALJtGMQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDE0NCBTYWx0ZWRfX89Zq7MHopD2H
 xPEYc3wh7gbBW5k3IbWGNwPrzVFSdnAciJ5g8Q2SB7p4g1p8y3m8MtwP2jb/0YsaDuBPyBGTdBo
 +lXTocKqknyZdoAKaS5PKPw8uDBpY3E=
X-Proofpoint-GUID: zPMdi3xT8BpP03sqc_8uTC05Ny1iQlAK
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

riscv_trigger_* APIs are TCG only.  Wrap the usages we have of them
in cpu.c with CONFIG_TCG.

After that we can move the header to the tcg subdir.  This will be
enough to get this out of the way for the --disable-tcg build.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c             | 8 +++++---
 target/riscv/machine.c         | 2 +-
 target/riscv/tcg/cpu_helper.c  | 2 +-
 target/riscv/tcg/csr.c         | 2 +-
 target/riscv/tcg/debug.c       | 2 +-
 target/riscv/{ => tcg}/debug.h | 0
 target/riscv/tcg/tcg-cpu.c     | 2 +-
 7 files changed, 10 insertions(+), 8 deletions(-)
 rename target/riscv/{ => tcg}/debug.h (100%)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 65c6556c9f..301f4b3dc9 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -39,7 +39,7 @@
 #include "kvm/kvm_riscv.h"
 #include "tcg/tcg-cpu.h"
 #if !defined(CONFIG_USER_ONLY)
-#include "target/riscv/debug.h"
+#include "target/riscv/tcg/debug.h"
 #endif
 
 /* RISC-V CPU definitions */
@@ -843,9 +843,11 @@ static void riscv_cpu_reset_hold(Object *obj, ResetType type)
     env->vill = true;
 
 #ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_TCG
     if (cpu->cfg.debug) {
         riscv_trigger_reset_hold(env);
     }
+#endif
 
     if (cpu->cfg.ext_smrnmi) {
         env->rnmip = 0;
@@ -1003,7 +1005,7 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
 
     riscv_cpu_register_gdb_regs_for_features(cs);
 
-#ifndef CONFIG_USER_ONLY
+#if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
     if (cpu->cfg.debug) {
         riscv_trigger_realize(&cpu->env);
     }
@@ -1018,7 +1020,7 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
 static void riscv_cpu_unrealize(DeviceState *dev)
 {
     RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(dev);
-#ifndef CONFIG_USER_ONLY
+#if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
     RISCVCPU *cpu = RISCV_CPU(dev);
 
     if (cpu->cfg.debug) {
diff --git a/target/riscv/machine.c b/target/riscv/machine.c
index e1cbcaa349..11e869a9c1 100644
--- a/target/riscv/machine.c
+++ b/target/riscv/machine.c
@@ -23,7 +23,7 @@
 #include "system/tcg.h"
 #include "migration/cpu.h"
 #include "exec/icount.h"
-#include "target/riscv/debug.h"
+#include "target/riscv/tcg/debug.h"
 #include "hw/riscv/machines-qom.h"
 
 static bool pmp_needed(void *opaque)
diff --git a/target/riscv/tcg/cpu_helper.c b/target/riscv/tcg/cpu_helper.c
index 885b4172c0..310c18db46 100644
--- a/target/riscv/tcg/cpu_helper.c
+++ b/target/riscv/tcg/cpu_helper.c
@@ -35,7 +35,7 @@
 #include "semihosting/common-semi.h"
 #include "exec/icount.h"
 #include "cpu_bits.h"
-#include "target/riscv/debug.h"
+#include "target/riscv/tcg/debug.h"
 #include "pmp.h"
 #include "qemu/plugin.h"
 
diff --git a/target/riscv/tcg/csr.c b/target/riscv/tcg/csr.c
index 7168a4dc12..7da20b5500 100644
--- a/target/riscv/tcg/csr.c
+++ b/target/riscv/tcg/csr.c
@@ -34,7 +34,7 @@
 #include "tcg/insn-start-words.h"
 #include "internals.h"
 #if !defined(CONFIG_USER_ONLY)
-#include "target/riscv/debug.h"
+#include "target/riscv/tcg/debug.h"
 #endif
 
 /* CSR function table public API */
diff --git a/target/riscv/tcg/debug.c b/target/riscv/tcg/debug.c
index ba5bc6ae13..3c0fe70101 100644
--- a/target/riscv/tcg/debug.c
+++ b/target/riscv/tcg/debug.c
@@ -28,7 +28,7 @@
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "cpu.h"
-#include "target/riscv/debug.h"
+#include "target/riscv/tcg/debug.h"
 #include "trace.h"
 #include "exec/helper-proto.h"
 #include "exec/watchpoint.h"
diff --git a/target/riscv/debug.h b/target/riscv/tcg/debug.h
similarity index 100%
rename from target/riscv/debug.h
rename to target/riscv/tcg/debug.h
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index b73e3e9dd4..fe6350f497 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -37,7 +37,7 @@
 #include "hw/core/boards.h"
 #include "system/tcg.h"
 #include "exec/icount.h"
-#include "target/riscv/debug.h"
+#include "target/riscv/tcg/debug.h"
 #endif
 
 /* Hash that stores user set extensions */
-- 
2.43.0


