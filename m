Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D793C43458
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 22:06:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wegZy-0006KE-NZ; Tue, 30 Jun 2026 18:05:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wegYk-0004mg-NR
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 18:04:05 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wegYj-0004Mm-5r
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 18:04:02 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65UJDmlx2937291
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 22:03:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 XqsW3jF+bUaGdQ+jOxxItYl0PoxDnV9eiRVyCqh6JoU=; b=OIk5jXMxqRu0IuWT
 hypuhKyrCHZtUL6K6KbQ2/qQ9F7k5lYynIDL9Cmu05T7PUpP6E4P6C5EPD6lhxIF
 N8MK2ywW/F5VToTYQjSuY7+iSkeLcfi4Z2K/MQnnpfuEipm0eKu6hqDCjZHNIMYS
 YzdjxJBnRYQcDHXcUSO9WgzjxvMTx10MbxhdOaxBjy3S76VrClP6ELWbInr1Ve+q
 nZx/eiquWILa9j8YDmYmeDFQMw8BeHijFhxlbxeBAVM9LfaHSjNsWFpf+WyN3LXh
 rydbOTWcWq+A7Z0OkhYo1ogVML/ABjjk2AfyE1pn2447DNOShmgtn/2KmPqEnCUA
 AEVcZw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f4fc0a41j-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 22:03:50 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-92e5e38fbc5so458581885a.2
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 15:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782857030; x=1783461830; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XqsW3jF+bUaGdQ+jOxxItYl0PoxDnV9eiRVyCqh6JoU=;
 b=THBP++4TSRafKzj6qdp5GaMSe9EEQqG3DQjSy/sa3CyARW0TwSzK39bm+5lqU3IAXB
 S+X8alPOInjzISkdVJj9ZadTR+yLZ1sno1c1TrUfgzpLXlqG2IqqZWL4zjNsCYCDpvk/
 feisctZtrxpomTPwiLGL8MpuJ2gBb7e+oXyCi2rQSGCqTTVKZG//pgZJYNhDcdrrFUId
 Ee9dV0Qi5YyXarUWEMPOMhT0/p69kvBeLYhrqRY1uvRD6s/HhMgGyZypxf7KtvEfI7Yd
 QsMfoO69icxQHPqTYZd64qKOZDr5t1lRDWe3cC7rtB8AVE+UC3+B7p/Nofa7HfKBCdEg
 +WMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782857030; x=1783461830;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XqsW3jF+bUaGdQ+jOxxItYl0PoxDnV9eiRVyCqh6JoU=;
 b=Eq9nV+Mb603sYu0Dll08y2oInbb62L02qtNb3X/XiZ9bvE03g2/v1Bgcn+FxwBKHZr
 vMdkIElrtiij9iTM/PuCc/3cjaOKXgwxj1Nymd4FnT8dyRwbxUrkk2xUHmZ/Up3Mu3UH
 h/9egMSFmR/Hi7meLKtbxqTuW0OB9kTmaXdfht1hJHhBsGdl2AeFZc6i9wp/aalyzTfg
 ku70dLRPo74H/ov2aBB9TOFBeRah+nUwkdyNQPgdL/v2Fwnw0SnD3yM6rt0Lnh9vih84
 gi6XrNdjLDjJ3GFqcXR89CquS7aaC9GAZgHpMYlq8wC/pc2R2H7v8z2wdzKJ2MO9IVPT
 fwpQ==
X-Gm-Message-State: AOJu0YxRGZu/8PPNmaSopkry5H74jxjPvJn6ZU/O3ExaNHFlSnK3epKA
 nRNe23rYP/e7cRbKmSIfZU5tG2MXvauTGx+ntTwpzgPu1chwsP9l8zguvqI+p0k1lsS0TiFQO0S
 DyN4nbysi+s5is/9qbcE1FFKbecsl3r96zy2XWSjuT/67GJPEGKBVOSG0S5Kvjtowiw==
X-Gm-Gg: AfdE7cn9ZSu0tWJ9vVYvxkv1GIXPr3wVv9Ecf+dGz1PoBNJnoY8pmLvmJxJQE4hS7eO
 o0yi9ZtnKCjyiSPAYqF07Zj2Vf2+AAaAeZtBk+Ujj+23XSbcpFO6lTv4JD2ZAGuOmyZbffX7rMY
 BKKkenl0xP8WuETQ+ddqMhVBWQUuFitXYzDCaErDHPyyCRLE8NuHv8WopDTqYXXqvrzhCPjQ1XQ
 T1tLwFKoL2DJ0HQ50UDtueLFg08cbV8JvXFcdvW4at4el3a/88G40KneheLZ5YET/XlgM9rg+0k
 mKVabD1sHYuuY4MbRkR5H6USX+O+kpsZU6NPhcCuPVvLZFZhgnqjOb2jsArAeyTER12Lq1jI2uP
 5rBnUk57H0np7iVQhLpOLucWOYpIwItR/u5+a1/btzqCrqdNi3iNHUUbpa+v+dUrIgueq
X-Received: by 2002:a05:620a:2316:20b0:92e:6a0e:a194 with SMTP id
 af79cd13be357-92e6a0eb438mr396068685a.36.1782857029477; 
 Tue, 30 Jun 2026 15:03:49 -0700 (PDT)
X-Received: by 2002:a05:620a:2316:20b0:92e:6a0e:a194 with SMTP id
 af79cd13be357-92e6a0eb438mr396063285a.36.1782857028942; 
 Tue, 30 Jun 2026 15:03:48 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-475641e4542sm11945682f8f.10.2026.06.30.15.03.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 30 Jun 2026 15:03:48 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Zhao Liu <zhao1.liu@intel.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-ppc@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 22/33] gdbstub: Introduce GdbBreakpointType enumerator
Date: Wed,  1 Jul 2026 00:00:49 +0200
Message-ID: <20260630220100.1289-23-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260630220100.1289-1-philmd@oss.qualcomm.com>
References: <20260630220100.1289-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDIxNSBTYWx0ZWRfX84ud3q284qg0
 FPwZvJj9nKQbnr09MSNDitajUlciJl1kS95wRvlcBg2Z+AVgonkLvXTq2wmoMUf8xc0CNtb8Vly
 s3Sq7T0mgfkkQN/zJwUZ6eObDTWbJQ2Ls6V7HPRmV2m2qdBWj1xr2yz3PGVzVxEdqyq+hB112IO
 szwVU12ZN4QABWrbItdQRlRQkrJmtqSq6JtdHwSGBw03aWr1n9uhxHSXXFhojr2243PVDjzP3Uv
 ggXSaiD4ukoJEGEH1tDDwwAXkW+zBaLF+ivQeqM+PekeFDGclUDOtxG6sfQjXgWjolu4PutQTeF
 B49CvdTrukMCe0zbng7R7jibTt63GttosqBQiE01Nkqi09lHrnmEmRkZQZh2hvkYg52WeBcttJA
 MRIEcwqJHFelEm9yqlalWGkoAqnikTSXSSWTM1YrhbUegVSUdVxS6Oh8v7uWKAu2mm/DgS/61pG
 k8z4h069saVjIQYsDVg==
X-Proofpoint-GUID: bi9MdumjqH5HHDZC9Y5wCDVthec0KoLN
X-Proofpoint-ORIG-GUID: bi9MdumjqH5HHDZC9Y5wCDVthec0KoLN
X-Authority-Analysis: v=2.4 cv=Ivkutr/g c=1 sm=1 tr=0 ts=6a443d46 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=z_0bWbdd-CfuK1dINPUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDIxNSBTYWx0ZWRfXyQ4HJR991iFO
 HRf1sEbJM2EtGKWAUKk+oWVw0BTrIqIGvbYy38my92aA2hz4YPSMBXFjR9P4y98JpVGSBwxhuUM
 G6saWnyAvXTVk/bxgTcrAaX4ldnfzxo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_05,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 clxscore=1015 malwarescore=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300215
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
---
 gdbstub/internals.h     |  7 +++++--
 include/gdbstub/enums.h | 12 +++++++-----
 gdbstub/system.c        |  6 ++++--
 gdbstub/user.c          |  6 ++++--
 4 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/gdbstub/internals.h b/gdbstub/internals.h
index dbae07d2577..32f2520d2ea 100644
--- a/gdbstub/internals.h
+++ b/gdbstub/internals.h
@@ -10,6 +10,7 @@
 #define GDBSTUB_INTERNALS_H
 
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
index d5e09802323..abeeebea8e2 100644
--- a/gdbstub/system.c
+++ b/gdbstub/system.c
@@ -624,7 +624,8 @@ int gdb_signal_to_target(int sig)
  * Break/Watch point helpers
  */
 
-int gdb_breakpoint_insert(CPUState *cs, int type, vaddr addr, vaddr len)
+int gdb_breakpoint_insert(CPUState *cs, GdbBreakpointType type,
+                          vaddr addr, vaddr len)
 {
     const AccelOpsClass *ops = cpus_get_accel();
     if (ops->insert_breakpoint) {
@@ -633,7 +634,8 @@ int gdb_breakpoint_insert(CPUState *cs, int type, vaddr addr, vaddr len)
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


