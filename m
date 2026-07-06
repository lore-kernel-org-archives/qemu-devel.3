Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44E62C43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 13:49:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgjhH-0005nT-DA; Mon, 06 Jul 2026 09:49:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgjhG-0005jG-6z
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 09:49:18 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgjhE-00072V-Ep
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 09:49:17 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666AxTWm361576
 for <qemu-devel@nongnu.org>; Mon, 6 Jul 2026 13:49:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 NspIlLUgF9SndTa4e5c2rmKsjIKQXU8I7T8WHNuuwsc=; b=Y65HMkYOM85G7a95
 FBokLdgI6OYAoZjYx4GwdiiQGNClzOqVbo4gTUpMmFnccNLxmuX3GhGOkVF8LpBF
 X1cs52vwDn5P15dzzC4s0pQNgKB+Ieq5TLt1RW1mWdV2cdTFnsfxolgtoBZonkVw
 MwxjNpcj48VoQ6QBoU6exA01G+TuUxSab4DFwJHIJ3MVZNQrBZYG12QAS5EneMqq
 nqAfyVcXd2GH0Rf+ezCRCXMNqIxX/CZmzCHhvnqTwzSWtCeLSGEEFbznmpDtQ0DC
 +VwPXbv1VACrYhjo4X8z61si5xaUu+sPgNlCXu3OH3tYNaYLn4p+EngaTkiC4OK7
 eURUnA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f88h51bg2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 13:49:15 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-92e55721a8cso312632685a.1
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 06:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783345755; x=1783950555; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=NspIlLUgF9SndTa4e5c2rmKsjIKQXU8I7T8WHNuuwsc=;
 b=iByxWjPUVpPFCIloME6MdzbOUwkMLHtQvWL6g2+i6vjsuIeDfT4Em57UlaVazOBUhs
 jR98OfbknoGG2yQrqVCcStbRZLQGgTZjMQCtvoujIX4tlPDwY7CpbRJuC7u0gjEMerVo
 P6arw+MBRLylZrM7W982/VN+Hr+mTmfQtO+PxVQdk3Lo7M4vz6iUwjZUUn7LbU4k6VwM
 M4XuthnrpbYIBpjnS9Bhu9D1WW1+0oCKD3pPydbgzJiXOrMddl0c090E3ovgoF1YuqTC
 LmyZ0093IO0+vSi42qP2ofFgvgp8xCL130XslFMcCmQNl18LqgqUq/SllDEfUdujuDY7
 11jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783345755; x=1783950555;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=NspIlLUgF9SndTa4e5c2rmKsjIKQXU8I7T8WHNuuwsc=;
 b=JViGdSTK+vGGzIq8oGFU91XHPxVcbVmtViIB/wqZxZGeUQj8FWMCaJMie9M7ol3jGc
 mE5Ex95VzDhe9PH1Egq8nqbbvWKAwTf0juG2OVNNBDd4T8EuvDvVWIO9jDfvbanBZnUN
 FFxmcPx2XTHGQ5RJf3WtchnmNP29t4f96kOLrXwFfPAhkJdEn7ahtMh3q5h6QSnFUZfv
 iIJTJi7k4ad+LngiWhSDZktp1Ro5GGs0f7gHhZRmzc2S2AogoGTQs+jgqVpPWR8r2bE5
 JX6R33rHCDdPpLNawMKiGo3eZRbqqam9usRqQengS1LU61lba3rRzbVNXZPQsZ5azJzc
 +ISQ==
X-Gm-Message-State: AOJu0YxuwHDdfQzMTD8JqiPPug7eUJaQc3LMoqIGrGiraM7Wdn/o+8Ze
 v8VHjsIdvJtbuB8oUcQvle2ngvzt749YJjQdI3SPpJdZ/mGcsKq+ZuP5LQw2aWpcSZa+r8BRq7O
 YovqGS2x8XE7MZ/T3bBIuWFCl4NPgixt+sbRNamhcUM5mETuu67CnyTmJVDJXoGx/GQ==
X-Gm-Gg: AfdE7cmaff4jBGI2pMv1hE97PUMrCCgu4e48xEcY2IjGkcjBmzml89hyPbCTiQPvpGn
 vO72Kg5uiyABjaDH7EGR2K6c1wnQdgixQqOUN9m98TMC6HxwnysMnD6nVAWcfmie3KN7X6SzaMF
 jzm4ad9RCckt6dM3FEzFssOo1iD2djqJ318wvhcdURSXB2R2pPFS1T98rgbi4KYYhlCTYwWz7Kg
 xnn7DAUBJAd9qlo43NOG6TRmdmoGxRCoyMT/qOKkQQieePjc3H95W7+USsIIUzdY1mx3DBdj91K
 PCEpxrL/sS1rwT5hLXL8LCBNch2KHBpnru4ndGR22Wk0uIZ/VExCKggGCm9u/bw/tY3nBfBfSi3
 YWBCoq7QAFEibmxlrA/nwLe9BG+HUMniK1uMmnna+DLkXTzkYHHXXlZpWhQ==
X-Received: by 2002:a05:620a:4588:b0:92b:6805:91a6 with SMTP id
 af79cd13be357-92ebb5b4a9cmr88390485a.62.1783345754581; 
 Mon, 06 Jul 2026 06:49:14 -0700 (PDT)
X-Received: by 2002:a05:620a:4588:b0:92b:6805:91a6 with SMTP id
 af79cd13be357-92ebb5b4a9cmr88385885a.62.1783345754009; 
 Mon, 06 Jul 2026 06:49:14 -0700 (PDT)
Received: from localhost.localdomain (1.171.88.92.rev.sfr.net. [92.88.171.1])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47a9e4d6e4csm23212110f8f.10.2026.07.06.06.49.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 06 Jul 2026 06:49:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 24/32] gdbstub: Introduce GdbBreakpointType enumerator
Date: Mon,  6 Jul 2026 15:45:19 +0200
Message-ID: <20260706134527.84808-25-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260706134527.84808-1-philmd@oss.qualcomm.com>
References: <20260706134527.84808-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: _RYl2cMLREB80vDo0Q5VShpe5l2lF1nl
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDE0MSBTYWx0ZWRfX5Xp8DFJY3q1E
 QcMtDeiz1PGJifcT2t6LB2RJCQ1l4lUetK257VOvS3sY475/FneiDECSUthd2uOmx5PjWyBoIDp
 KvOaI0MvPrca6tMMARiASDmSbhtHA9o=
X-Authority-Analysis: v=2.4 cv=EPU2FVZC c=1 sm=1 tr=0 ts=6a4bb25b cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=PLEY+c9/kVlxBKEpvFYBUQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=z_0bWbdd-CfuK1dINPUA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDE0MSBTYWx0ZWRfX2GMT+pu/2f5S
 zTGbCfdtGntdPWWV2puyLHq+j0Qo+RXQnPfd3PqASEwyFvfli/ai1/YAa7Izlip5a98/+wVfu5W
 2XbdNUk6uz5ynNmfu0YwXkHBiewjGCjzB220S7VC8e5WIFLGfHWTKnnUmCdTfDKSibURcebpI7j
 Q/4UoCsMj3Yi2AKqlAbmm+Qhbi+LPsJwGiIST/8gBLjKaUFVFytbDUcwtrROj7nuQCX+vzN62xH
 H4eekok/rctyhj5iSO/ukcsO5JSuM+fN0PRRQVGY/pSvhDY18rS3iHAzZbby6SygohOoxnyvAq7
 A1qUX2IarnfXxZfQ3pmwxLXf9rS0YX8yikCc239QpRvuLF1Nsc6L/pXvRh4rDDuBCoQvE7X9Mig
 Nis/oKhtjb5WPbsJtqgdsNnJzlWO071NSnbySapCbcUyV6N0VKB9jLU/R3CuUz/zdkzMCM1uj3w
 VELckJyzBUqwZ9RJQ5A==
X-Proofpoint-ORIG-GUID: _RYl2cMLREB80vDo0Q5VShpe5l2lF1nl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 spamscore=0 adultscore=0 suspectscore=0 phishscore=0 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607060141
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

Introduce the GdbBreakpointType enumerator to better follow
code related to GDB protocol handling.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260705215729.62196-25-philmd@oss.qualcomm.com>
---
 gdbstub/internals.h     |  7 +++++--
 include/gdbstub/enums.h | 12 +++++++-----
 gdbstub/system.c        |  6 ++++--
 gdbstub/user.c          |  6 ++++--
 4 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/gdbstub/internals.h b/gdbstub/internals.h
index 0b74ea4000f..33f68672d1f 100644
--- a/gdbstub/internals.h
+++ b/gdbstub/internals.h
@@ -11,6 +11,7 @@
 
 #include "qemu/accel.h"
 #include "exec/cpu-common.h"
+#include "gdbstub/enums.h"
 
 /*
  * Most "large" transfers (e.g. memory reads, feature XML
@@ -217,8 +218,10 @@ void gdb_syscall_handling(const char *syscall_packet);
  * Break/Watch point support - there is an implementation for system
  * and user mode.
  */
-int gdb_breakpoint_insert(CPUState *cs, int type, vaddr addr, vaddr len);
-int gdb_breakpoint_remove(CPUState *cs, int type, vaddr addr, vaddr len);
+int gdb_breakpoint_insert(CPUState *cs, GdbBreakpointType type,
+                          vaddr addr, vaddr len);
+int gdb_breakpoint_remove(CPUState *cs, GdbBreakpointType type,
+                          vaddr addr, vaddr len);
 void gdb_breakpoint_remove_all(CPUState *cs);
 
 /**
diff --git a/include/gdbstub/enums.h b/include/gdbstub/enums.h
index c4d54a1d083..e4e2043d92c 100644
--- a/include/gdbstub/enums.h
+++ b/include/gdbstub/enums.h
@@ -12,10 +12,12 @@
 #define DEFAULT_GDBSTUB_PORT "1234"
 
 /* GDB breakpoint/watchpoint types */
-#define GDB_BREAKPOINT_SW        0
-#define GDB_BREAKPOINT_HW        1
-#define GDB_WATCHPOINT_WRITE     2
-#define GDB_WATCHPOINT_READ      3
-#define GDB_WATCHPOINT_ACCESS    4
+typedef enum GdbBreakpointType {
+    GDB_BREAKPOINT_SW       = 0,
+    GDB_BREAKPOINT_HW       = 1,
+    GDB_WATCHPOINT_WRITE    = 2,
+    GDB_WATCHPOINT_READ     = 3,
+    GDB_WATCHPOINT_ACCESS   = 4,
+} GdbBreakpointType;
 
 #endif /* GDBSTUB_ENUMS_H */
diff --git a/gdbstub/system.c b/gdbstub/system.c
index 9c4bd8ebcba..6e2dbc823e3 100644
--- a/gdbstub/system.c
+++ b/gdbstub/system.c
@@ -623,7 +623,8 @@ int gdb_signal_to_target(int sig)
  * Break/Watch point helpers
  */
 
-int gdb_breakpoint_insert(CPUState *cs, int type, vaddr addr, vaddr len)
+int gdb_breakpoint_insert(CPUState *cs, GdbBreakpointType type,
+                          vaddr addr, vaddr len)
 {
     const AccelOpsClass *ops = cpus_get_accel();
     if (ops->insert_breakpoint) {
@@ -632,7 +633,8 @@ int gdb_breakpoint_insert(CPUState *cs, int type, vaddr addr, vaddr len)
     return -ENOSYS;
 }
 
-int gdb_breakpoint_remove(CPUState *cs, int type, vaddr addr, vaddr len)
+int gdb_breakpoint_remove(CPUState *cs, GdbBreakpointType type,
+                          vaddr addr, vaddr len)
 {
     const AccelOpsClass *ops = cpus_get_accel();
     if (ops->remove_breakpoint) {
diff --git a/gdbstub/user.c b/gdbstub/user.c
index 90d6ee49fb5..9e6f9a6f376 100644
--- a/gdbstub/user.c
+++ b/gdbstub/user.c
@@ -790,7 +790,8 @@ unsigned int gdb_get_max_cpus(void)
  * Break/Watch point helpers
  */
 
-int gdb_breakpoint_insert(CPUState *cs, int type, vaddr addr, vaddr len)
+int gdb_breakpoint_insert(CPUState *cs, GdbBreakpointType type,
+                          vaddr addr, vaddr len)
 {
     CPUState *cpu;
     int err = 0;
@@ -811,7 +812,8 @@ int gdb_breakpoint_insert(CPUState *cs, int type, vaddr addr, vaddr len)
     }
 }
 
-int gdb_breakpoint_remove(CPUState *cs, int type, vaddr addr, vaddr len)
+int gdb_breakpoint_remove(CPUState *cs, GdbBreakpointType type,
+                          vaddr addr, vaddr len)
 {
     CPUState *cpu;
     int err = 0;
-- 
2.53.0


