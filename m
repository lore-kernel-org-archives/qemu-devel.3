Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47581C43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 16:42:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfgx5-00050E-7i; Fri, 03 Jul 2026 12:41:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wfgx0-0004wj-Q2
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 12:41:14 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wfgwx-0001PS-Et
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 12:41:14 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 663GJHxo492638
 for <qemu-devel@nongnu.org>; Fri, 3 Jul 2026 16:41:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 MOmi6wrm0eC4tNd6GGXXYQxEoIV98ouYze/eblRNqP8=; b=Eh81VJe0Xv//dgZh
 2QfaAswc4yuYk2POI923C0WVNymbQRBVlgmJi+MmNbbnDryquD3p+czufKBpwmqW
 aPCmuto6LKNNiYGmudA4DN28TQtUDIG33bdBNBFRF80aZ2kIOeClFNLz7y5AVSd4
 Agz/j3vURnWzuKI3OFoL+GDFa5lKhThXjYNjbbmpOXme8ndykqkvpKYmhFI0tpIL
 zSAUVcje1JsGSd3YNtpKd2lAXwzXuZPh/ApBjRDbhsAkMDel5ogyRPzsDiy/Vl9v
 DPen+gIQ/yGLoUOZJ7FsnG9boMZaa+CpN0PqFjtwxfwZQR0/H1nZCWntDxpOn8YC
 mnWOnw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6dkkgquq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 16:41:00 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-92e56b2b350so146758185a.3
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 09:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783096860; x=1783701660; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MOmi6wrm0eC4tNd6GGXXYQxEoIV98ouYze/eblRNqP8=;
 b=KgXP6/8rF9nX6Ij3L7aEeTlqP3W4wF8Z0DTsV+KIJAeJIttCwpyHlrBvKHixfQq+Cd
 GYxaY2KINu+h22vmz1qECIdlIfQHhmCJ+B9HW9PKXbJnEPdKL+jWAhyi0hz+YCZzkZoJ
 Ntmsn2bKspx4wtOL24mC7oEh6wjMgZCbY9ZDMDP+6o/lMTt7nYXEPTkfR0wqRZWwr9vx
 MOmJbW4yMKq1wVOwqGGw0oaQ102UsoueHNe7Bn3SvuYgiPY3okfPH7OBzKTg34iCeo7z
 FzDanUb07BGNZQApYWyNiyDmEs1zJb+CUqDS0DvjlJmm0LmSM4dBDrmg+k3Zyye4fgHl
 yntg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783096860; x=1783701660;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MOmi6wrm0eC4tNd6GGXXYQxEoIV98ouYze/eblRNqP8=;
 b=Iu2TI7hxooPmc5qXHT6rkh//apVeowyAT9Ey/WSdTMoVSVcKeGSlhEn0VE8SG8YjWU
 FYS1YyQAc5t87Z3uLRr4/EKb6jn3P7ENXYN/g7k9+ReJ1+CWV9vmN0e2RLnp5qJdk4ZS
 iiT54MFoCfXI7iNcFDwEqck0cQ3GLDO8/f7uIDVc1KsuYYe2d+sELozJZB8ek520qKpa
 teySgg46+ePmzLXuCwfeQXhUGhKeFeS9g4yQVnKt0P4+ETDlZS+In+Ic5ydpdBvX7yrH
 eS7x9XP5S1it4ZstLuP2rFD+8pQuZQYLmWwvdM0ObLIZYc1824UTI74ieKmNdLIh0Fn+
 A3Vw==
X-Gm-Message-State: AOJu0Yy9jW6dpDzRMgQqsA7RZT3iz+e1kvA/yzzv7oyyFRum6Pu0WcdX
 eC/pFuFDoTkT54omcFfPFkNmjEiCYoQkB/2CiatImVAdj8S6yQDYP+3cwHPiigkaLukzHd9OlAu
 Ka7Dj3kWAJmjNKY8gXWlYcmop/tcNVPil48rdb9OLOXCzUHDrwMY9GJaRepSvADB7jQ==
X-Gm-Gg: AfdE7clSJYL0225aPVMZ7wfiYWCSKTehTgRmis45RfyaRuVXVSsnoxuCjFzI2kS8m1w
 IA5LBZgwWmP1ipH0sGr+lTn9nijATrNGbcwcNn/pvfSAF3E1bfAVPniORYGqAaO+Vd0zeCXZZyj
 CO75yFsBeiWrb0MtMpgKGmPYHsz5/uUNuCxXsB2YmJrz2xcWNBWa9llIPW+82iZYZnWJh+icB+g
 Tp+Hm7B1cYlSzV47FwzFDOTlSIMkDOtGn4f4TbU9M5ixtF8nnhyPZ9jbIXj4zlXlds1IWKDjO6X
 Cco5SXeVqmmaugfGUvrwE1io+3KYwT/dlwCq1fEuNHx20bHqYcIkFjTM3vb3/hAbRuJgahMYjjM
 YCVVvbyhgPhETlkWVQgNVAWySwvedKgdYsAySJ8bo6u9OK8bQJrG/sCKsPX4aeDI0juDH
X-Received: by 2002:a05:620a:400b:b0:92e:4eca:6fb7 with SMTP id
 af79cd13be357-92e9a2f76d8mr34411985a.2.1783096859764; 
 Fri, 03 Jul 2026 09:40:59 -0700 (PDT)
X-Received: by 2002:a05:620a:400b:b0:92e:4eca:6fb7 with SMTP id
 af79cd13be357-92e9a2f76d8mr34406885a.2.1783096859108; 
 Fri, 03 Jul 2026 09:40:59 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa0960b06sm588857f8f.28.2026.07.03.09.40.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 03 Jul 2026 09:40:58 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Chao Liu <chao.liu.zevorn@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-s390x@nongnu.org, Xiaoyao Li <xiaoyao.li@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>, alex.bennee@linaro.org,
 Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 24/33] gdbstub: Introduce GdbBreakpointType enumerator
Date: Fri,  3 Jul 2026 18:37:47 +0200
Message-ID: <20260703163757.55500-25-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260703163757.55500-1-philmd@oss.qualcomm.com>
References: <20260703163757.55500-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDE2NCBTYWx0ZWRfX7nmlv2DSMTdX
 ucfQYec4Dvmry9xwTRSmSxa2qYkK9S4ipa1pZRsonoj5bNtkkyosbhbXi1efLR2S16OZOsPFFji
 H71vtw5Wp0ifh3CGHNvKiEoozvqLE8fZ9hNVNowV9ybL9UoOH+L63V31CuFsvTnAuyv707RUqSj
 L6skdNFFMNw6RXNhy1FcV/NN9z7dgVlcp/Admw9uPdKFKixhEi0xhwdxNaCHQh9i2Oc2WFbhGgJ
 x+T+cCGp6ufd3eyp+bH2SKVzeJxCddLuxUnykKFotQT+99Zb25pKax/rxwZAs5FqmwDce8YNIWZ
 TOZE1p/7+I/L/EngkAi6B8mvLaxJHrf5WGG55BkeTXVAUyHTykGOhxFLvr7xW3hmrFnDGKq7FRQ
 KIzTBIbcDEz+beU4iMckfJmvRZj/XFt1jX0kOYBaOIOkiPZxsmhx00QK9M0dmMEAHRcXE8v3aa/
 9e13m3Zqz/fxdZxsDHQ==
X-Authority-Analysis: v=2.4 cv=LeUMLDfi c=1 sm=1 tr=0 ts=6a47e61c cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=z_0bWbdd-CfuK1dINPUA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: 8skOEh7gUSdHn5ZHGwmtkJol8gWW19sI
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDE2NCBTYWx0ZWRfX3F/f+KjEWSto
 RorzOYdlue8mOX7J+RpLpL12u5G7RzDOqBokjgygk56cKD6KmhiHgVSfSiyOEWHUxD7anavFJcy
 UrqAjPo9WhNpoNlqkWrnxJ+5LEOzIak=
X-Proofpoint-GUID: 8skOEh7gUSdHn5ZHGwmtkJol8gWW19sI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0
 suspectscore=0 bulkscore=0 impostorscore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030164
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

Introduce the GdbBreakpointType enumerator to better follow
code related to GDB protocol handling.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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


