Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACEEBCDB479
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 00:09:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcB9D-0007Sq-Kt; Tue, 23 Jun 2026 20:07:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wcB9B-0007S4-LG
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 20:07:17 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wcB98-0003CX-90
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 20:07:17 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65NK0rjs1286033
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 00:07:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 k1H5fBBe0pzKndrOzEcbxV2DHTShNMrbTZS+jXVioV8=; b=PBrJoFvaLUwtrEO1
 SiikUx/O95i8Ot7QlG+BkZ2CHTpLF3t/9YFJFxkeC6ZcF248mTmswze65GSG50p7
 4Fpfocxr37zxAhosGu1zZv/3uiPHGTApOuJd7SKgCokvhUtc716tJdbeJbslfmlZ
 0i6ZR38ZdU4sftJ0U10GId53ZV5EK+XYVlyPSkUxPi7i+NgTE9PeikrmrDWMd/vN
 yNOlEkdSjUdkoE0mKTZ4OMIZiyExP6h32REyK4YD4I1cUZPIiHKNvKJ+yCmIBfyh
 qxvaDRl1sWbLGxdachtOmWwa82N4QZr+O1zjoXwpXWVw/cYEhNYC6HsyzVth9V/n
 xPlnvg==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eyr32361g-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 00:07:03 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-8e0dfafa41fso9802326d6.3
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 17:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782259622; x=1782864422; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k1H5fBBe0pzKndrOzEcbxV2DHTShNMrbTZS+jXVioV8=;
 b=B0qtNYQT9YoNHcZyoyHbzEQPb11kWWuf6VeTmnDZkZOzbnL3Fxfd4ShjiqP2Pt0bbP
 QOb4bgGjRjdi08WizxHWjBYrXcFgrLuhhf8pVjN6E2OazyA7bC6b8cEytiOqz89B/N04
 0PfpweyAOQ0/F0/Du0c/lKU65QyIdquv+4xEha/BQU98qyVKLXFF+2aPBB9OjaplCxzd
 FX8Sijqj+H4+ZAevjRYa+F8hwDeM8TiI7dR7m0YaH6s6TRBgwsOyUG9b84pnsQGKcBLX
 n2i9G4QzFMw/9DOvgVYPEFGSzQcK8jRq/G4fN3VIvjDbh/HLpTpopoKFk+9rL1Vmh4PC
 Pacg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782259622; x=1782864422;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=k1H5fBBe0pzKndrOzEcbxV2DHTShNMrbTZS+jXVioV8=;
 b=ez+bQSBEUP2tTi3OvxRJaYqet98W5zeih9CL6DrKUcMe+rzivx8UeeTumu2vRuuP6V
 npcs3tpCDtK95SeodAPNunqjhKW8C3FvexfAwqMAfz3dZrOZT+spIt2ID8r2R6LlcEA1
 OBgRrVJKreH781iIWptLl6xVwmDJDkroa2a+UAhvReWRZk8bqszYxujFjDkqHfPykglP
 Q78IjMyhiJhLXM9Nm3C5hUCJJ5pxftASRHrFgcKsvHcdVA3OLDw9WBiK7ts/NnX9haZJ
 AxIWzUCrkRaHa/qOMERyfrxTBk0WhemFL55O13icnc2l+YxvQYOgUncgxBXCIdW+KjyQ
 GWfA==
X-Gm-Message-State: AOJu0Ywt272wgPXB8hFNGj8GHPcilRX6egbRUFv0OPr/2Fsno7reR19K
 Ajg2TPsYkQ0dzmUwu9P2PA0SvpA2KVIRBQc96x2w8+7QpJy2aE7oq4aH/xus+np7KDnbNxOmvly
 UHdq2Ll6wkmDf1BMPE1QzyPaq4/ZGqt6m9Po7DjarXM+T5qjQXC1CUqNAgP60nsqJlw==
X-Gm-Gg: AfdE7clmN3hQ1JFXvN4HgwqIepL7uvZj6eS4qI4GunC5Z5Z/oimVV840u7TrIfkRwMX
 k7r4lV15QhSH/3CLai1+Z/jUC75RmmSK7ACnASSnpPIQTeglNQFxqEX3wlI7vNDQaEAkpan4U6T
 CCPUeqq3PKxhDiSmmeQd4k80Jtw6WqLAq78hZEgnE1ltlXK2WVze1TTBujjUyzvfoMl7yWtZXK5
 +EV3Q24SOR47joKfLN6CyG0fu4v9SWwAbTtKXQ0nDhcmgyOgMNnoauDxK0G60ocaOboS0ilwahy
 7a+xLr/UaZ8o9bHZ53vUBx8soBrgkFpbueyooEKNQrgYGoajoV0uRiZwKzWfLLb0Dn3k3K9EkKX
 y8GiTuqiuNynxLgOAKOfUuXDmvojr7unfWmrzul7HWhqSaA==
X-Received: by 2002:a05:6214:5185:b0:8ce:ba04:7bcd with SMTP id
 6a1803df08f44-8e5365c727emr21905196d6.38.1782259622429; 
 Tue, 23 Jun 2026 17:07:02 -0700 (PDT)
X-Received: by 2002:a05:6214:5185:b0:8ce:ba04:7bcd with SMTP id
 6a1803df08f44-8e5365c727emr21904206d6.38.1782259621803; 
 Tue, 23 Jun 2026 17:07:01 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.79.21.40])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8df81cdec56sm142422976d6.32.2026.06.23.17.06.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2026 17:07:01 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 pierrick.bouvier@oss.qualcomm.com, philmd@oss.qualcomm.com,
 fritchleybohrer@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v2 07/24] target/riscv: move debug.h to tcg subdir
Date: Tue, 23 Jun 2026 21:06:14 -0300
Message-ID: <20260624000632.2149359-8-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260624000632.2149359-1-daniel.barboza@oss.qualcomm.com>
References: <20260624000632.2149359-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDE5OSBTYWx0ZWRfX6r/aLeXYLINI
 Pq1pOmbMYaAJ0lf3xN2IoylmGkG7DiZ8WlTHodfasZZReOFY91rq6mV67KEEgyx0cieTocd9Qeu
 yF+rG0knenleu/3EYXtSzYK3MacFwTo=
X-Proofpoint-ORIG-GUID: UNMfvWTh-MDm1ts-xQB0ALB8zvy19OVg
X-Authority-Analysis: v=2.4 cv=HrxG3UTS c=1 sm=1 tr=0 ts=6a3b1fa7 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=sHJf4AwOIoU3qjeHFPlg6Q==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=WBZ-eJHDTolNJtMr4n4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDE5OSBTYWx0ZWRfX+x2SDSyaRrQ7
 Pbh/nGNJQQxIF3qx6E2xK7pAupc/Zt4qzszYDnG8oS4n97KujtSnTjdnuCZPwtlc2Snn7pFJoJs
 3iRv6g/nROPkRCB5n3QfyyQDfKNW4+jQUuuL0//nTwMqX/mIuJRvCHpRvhvrTwb7tBOuggB+JNU
 xtizdeb0JWlR0TrTF4AGeNvRJKUIxdyokZAMlYoBpkDfPwubd+Qt7G2nsp58yE/z6PxTash/45L
 O9q3H3Co6AjlfaCvXNMpJIlwi/JnyXo14WqYG8CmpP0TewFWBd3tlkVRE9N/x//Ej3MdDtQ4Eqc
 iF/Zec5JJQUHrqGf2GsXo/r3bENNbRXEaM2br1byHSPsnG0XE41S/avLAceRTxaiTHdPaO+7F9m
 X9JBuVROt0zrv44k5Uvr3FnQFwnE1+RnoVGfTPdkBlPtAtbycQnrIzZkpgGcAXgnq+FVXfXM5SC
 ++pSVwod11KjIdiapSA==
X-Proofpoint-GUID: UNMfvWTh-MDm1ts-xQB0ALB8zvy19OVg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_04,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 adultscore=0 bulkscore=0 impostorscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606230199
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
index 319825882a..fe47ae64c9 100644
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
@@ -836,9 +836,11 @@ static void riscv_cpu_reset_hold(Object *obj, ResetType type)
     env->vill = true;
 
 #ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_TCG
     if (cpu->cfg.debug) {
         riscv_trigger_reset_hold(env);
     }
+#endif
 
     if (cpu->cfg.ext_smrnmi) {
         env->rnmip = 0;
@@ -996,7 +998,7 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
 
     riscv_cpu_register_gdb_regs_for_features(cs);
 
-#ifndef CONFIG_USER_ONLY
+#if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
     if (cpu->cfg.debug) {
         riscv_trigger_realize(&cpu->env);
     }
@@ -1011,7 +1013,7 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
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
index a893472c4e..8c347aa1c0 100644
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
index 7fb0ad5bc1..b460860409 100644
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


