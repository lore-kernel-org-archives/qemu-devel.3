Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CD92CDB466
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 19:34:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbkNW-0000XC-KN; Mon, 22 Jun 2026 15:32:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wbkNV-0000WV-8c
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 15:32:17 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wbkNT-0001pH-DB
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 15:32:16 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65MFVoJi3842519
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 19:32:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=AZWlSGpH+zt
 vHihs2CQRxejyQo0DP9CWkQJ0wjaKtzU=; b=Cl1Tho4+u0Df4zipa7Mkuasn/yn
 K9U8uaygIEqMM0U6Z5l3YpCnyEJSQsJxKYNNtFNzDo55wkj2Qb6QHFIp38FbJ7Sv
 MCVDR1OdUq0oqx3EI9l7VvtkQBhyeyejqsRpPF3uSiOiAxgJoweqHr/RGfweiKIf
 vRK0H6896EQ7KWie76xfU9Q7QuyPJlk1w1wByRFQprnjd6JOZJi1L4+64aPIRXZQ
 kzwO+qiZRlub7gGgEiK1YvptJsv3pDw16U7mCh+ELoLO50qPmeLmC6/wgHTFca6L
 534mpXT9ZAivI4trAz3xCOzcQ7xL8f+lNS/eBtAc0vwhmQr8rO6qV3eVoXg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ey2yht17p-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 19:32:13 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-915f6ff639aso1220472785a.1
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 12:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782156733; x=1782761533; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AZWlSGpH+ztvHihs2CQRxejyQo0DP9CWkQJ0wjaKtzU=;
 b=GbB7yqB4idoSPp3/BF1VPxwGODwXwvDlNC7WJ86k40dx4eA92E2tzQZCFXg+NBsMVn
 VlTAD6FhTGtS8D+LJwuFu25O4dijLEatvGVjp8XBO10zAmjc5/gKviFVVwoLcW/JFuiR
 ay7d7zXKR78kN1nAEh0/K3upD6HohjedP8g6o7csatYQ66SZHF4BsiUikRM/1CLzv9kD
 LnC4Z8Gh2ed9Y1R34OfVykrLOlK11Em9Xaj/FGAJobAzaE2HYgt5sPNnSGbCOzo0NCtz
 dfuvcPJ09rhYkX0rJDY4dnebfjVUkEZ82UKTXreI30luycCGLgx9ZIhcwpyLivZXBBP4
 Ds3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782156733; x=1782761533;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AZWlSGpH+ztvHihs2CQRxejyQo0DP9CWkQJ0wjaKtzU=;
 b=ZPQieHtZfh4R1LG3159HjfBjDD0A/WPeGmFirZqp54k5F337Fp/Uom2oktfevFdTUb
 uzGn5GPdV0c+SLOmVXHX+wzmOiBi92NyqPemY9MOo9aY9LADtwiiVo5aEUbDrT3gq3Ol
 CoX1esqX36w4nqj5mpSwyJH9v5xxQTMc1h4g+8WjbQy29b7Ea/RGMvrU5QmVEtViQypC
 iTrxxj9iKhS2yhq8U4gjN7tgzmjh5eszX352AdZo3mc8fnxt8tzall+4UECQ6AL3vosi
 xL0fu4NH519cI1hjgWM4WxHKr7ZUDq4JYDG9PTdqMSFFOUkU03/yY/fsm9xhtcqA73Io
 ThHg==
X-Gm-Message-State: AOJu0YyD1WgrwzNXFdLs9WDxtgJKttOcHOX94ZVv0KtlYTCLgCbInQGy
 mmV4Ej7eVx5F7GfMUNgnoXnlOXt0PtYbUOma1E/DM0EvKpqiE1dwkm9WFQh0dhjxl4Hwjj7TeyW
 nTtWvotBziSzJEt34MHEm6m98bJ0MkYGiuh+69iCvDd44crudUApZTz7qfPbUPY0XLw==
X-Gm-Gg: AfdE7cmF/2GJhHONFUR0EH2W6656t3uy+Jh8wV4TEEkQA9ALRXzmBdpl121rQ+H9Arm
 /pE3X0LGCFFojv6LivymVoWruwDpnPAnlPEKxyB68KminDOPt51PXuPe8whEtkkqP0Q6ohWjo1p
 tnGAWSuSf23as75Cxh7bVh3RhkYHJYuqqv/oxW+I7vCY0fSW5K9bqqVIB73BQqcfRhB1cqkImBU
 td4eLTcMtA5306lKGilrQuf+4vmXIa60lL5G05mXJdqJpJF3+c8Yvg9Z2mSZC7VftxC0AW/4hTh
 l/YtFDPE0OMeGnDWpyNupF+O/n86oDl/dwuNjJG1WQ+wHswTk95sNGtuuVlHMC5Zzy+rjTPrBOU
 EV7uBiKbDMVtGld3bg7LcEeMiK1jINT8StvtrRhvQsG0O1g==
X-Received: by 2002:a05:620a:40ca:b0:915:6cfc:5018 with SMTP id
 af79cd13be357-92093131f92mr2755055185a.58.1782156732939; 
 Mon, 22 Jun 2026 12:32:12 -0700 (PDT)
X-Received: by 2002:a05:620a:40ca:b0:915:6cfc:5018 with SMTP id
 af79cd13be357-92093131f92mr2755050285a.58.1782156732435; 
 Mon, 22 Jun 2026 12:32:12 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.79.21.40])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-926004ab49csm61489585a.34.2026.06.22.12.32.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 12:32:12 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 philmd@oss.qualcomm.com, pierrick.bouvier@oss.qualcomm.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH 07/24] target/riscv: move debug.h to tcg subdir
Date: Mon, 22 Jun 2026 16:31:23 -0300
Message-ID: <20260622193141.1449724-8-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260622193141.1449724-1-daniel.barboza@oss.qualcomm.com>
References: <20260622193141.1449724-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDE4OSBTYWx0ZWRfX1B7+lgIjxihv
 0QTOmUNvQSSFsmxqIgkjwPABPvC6SpKiA8iniMCFYRRqtMIwOQ7Lk5Y7DRDwQEUEJJEh2mDis0Q
 fzPDPfR9fZqa978NzZvP0+hJ8kKQgPE=
X-Proofpoint-ORIG-GUID: Yp6EVkFwLNnY5ehkx_lCOY7NBZWwEiJ_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDE4OSBTYWx0ZWRfX+xB8B6ui9uOq
 9Pk414wdqZEM8xpyKCp7g6Zc4URDgVmmTskDwQuHi75QEWIGQ7xg6ssc17VlCfiwE8IISD1JOY8
 zXw+4SQ9wQaiSgdZw35GgxUuFcvFo8e+TQiSTUQEjtuQiK3bor28/CbRwdr39OkObLcq3N65KuR
 Z1/F7xmhVwf9DP2wu4kCuPNY6NfdYROTZhlC9MRhMZOAnpKOxdzL7I1jcfMWrtSBLr5g6Yqx1nQ
 b/3cX+rp5HgGO5v03m9uGyv6nlU2j+nDmv3GCAshVzZmwKCVMuc7hxpx+cPQ6GSiX37F+dDzRtn
 hijPEqGNnH8aoOL5fjVg4sxb4Sk6OAZYj3n2PCL1PiKAkd9Muq1CzVVrE18pCiX/FNF+OW/NnJr
 35ZO4W8tFjOmpc9BAl1S8i8FffKAE6fUYfZKiV2mTcJV5de758iLfMMyi9GOq6ciDqctx44OH9f
 fRKgIwnqAbnZs2g8cPQ==
X-Proofpoint-GUID: Yp6EVkFwLNnY5ehkx_lCOY7NBZWwEiJ_
X-Authority-Analysis: v=2.4 cv=cKbQdFeN c=1 sm=1 tr=0 ts=6a398dbd cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=sHJf4AwOIoU3qjeHFPlg6Q==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=tQvhUsybbcJyJE2uAKwA:9 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_03,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 adultscore=0 phishscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606220189
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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
index 0a7e6f6ed0..f999042178 100644
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
index bd93d6f3a8..4d89486cad 100644
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
index 59edcdd370..9293d61024 100644
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


