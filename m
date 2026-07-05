Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CAA5C43458
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2026 22:02:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgUtW-0003oO-1D; Sun, 05 Jul 2026 18:00:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgUtU-0003lr-Mu
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 18:00:56 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgUtN-00010Y-UK
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 18:00:56 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 665M0FWl2717895
 for <qemu-devel@nongnu.org>; Sun, 5 Jul 2026 22:00:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 MOmi6wrm0eC4tNd6GGXXYQxEoIV98ouYze/eblRNqP8=; b=lx/frblejb/6+zY5
 fGTYEqpiM2/PgrHLXMePNz7JAkqzm4k6gYgUhl33kM/27L7O3bvAYViMSz1mg7lD
 VuLitVzWftTR2DDqdSuJF7jOmjvrUqQnVBa88z/LYN4ZwYrmgtTpRaI60XR/NQcQ
 lXBz3/UCrXd2GMYSBo3H+8Byhr0r5HPAy9KbI9akANQ9Gb6Q+iIyN4K0TGhUqVLX
 IaSb3qEfbYdbTnqq0HrJK02QYpCP3/GTUORptlk/83CInRxjpRwaCg8jAideE0r2
 J/JzfPZWrSpJpvhPU/NJOJxwoIsg5qrpV2vgx2Zca7gCADAezO74TDiTkOvYWHlf
 38RupA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6txekdxv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 05 Jul 2026 22:00:38 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-92e63df032bso281248585a.0
 for <qemu-devel@nongnu.org>; Sun, 05 Jul 2026 15:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783288837; x=1783893637; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MOmi6wrm0eC4tNd6GGXXYQxEoIV98ouYze/eblRNqP8=;
 b=TwBOZ177R4WLHSeFqAkzQwI278MYe69pcxenGCUwqT1QvmjB8zVsKX1TRwYdwfGRQU
 JqGqw6qJG7ohiYc0DJPw8j56NIR58qR7b16cbt9lPeKrtZEWFmZ1P6EjkSy2vjALLScu
 TK9o9K6tBX6iWVcMX8XnDnTPFW3xdXcnaKFFu9Ez/n4lawVLgcuXdJPIYjUr9+iYecSE
 nRXorOvmduASzq4DHr/Yg1Hbz3+vGoyrNiQYRqJMBp7s+LFTFhNn9Om+MCvuKuMtsDUh
 jxCG6Aup1nvzguOmK44tyb1vrUbe44mk3FrTU1B/mKpOVqwFL7vnODg0ax4J8fomphml
 uF5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783288837; x=1783893637;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MOmi6wrm0eC4tNd6GGXXYQxEoIV98ouYze/eblRNqP8=;
 b=MJwtFnO02KV4H72fojFxLubA84suD/y8REeJyrbS778yVsMdCbTj+A2S9q6EI/BvMg
 MVP//GLCtl//uZwXmzqtPUoGMoLhEd6ow8mKM6CbLd3nxfV+GZH+7FHl9dW0Z9BliKde
 NJ0FK2baHTOr+0eF5kh0o+YAJONYevnFYnr2cXB/AIvCywhZ04s9hNYWQqGsCFyrTBgq
 oV4Fv5PmPsAANapusuInqnIQdEEEgY/DqMIIHNGkDsAb7vLfsDIE1wsr++cJu0UkTUVy
 4Ik8mrRB/ZFrBueYnUcvtG/q5BhoBg+NvhXTXgO200nCfuvZOTVCdSMdbMIU2c+Z3cir
 LxTA==
X-Gm-Message-State: AOJu0YyvwS3wpt7VE0kRAfokPIU+MNRgnlHwD0GwTe9C+ivkO6f2h/x/
 RuPDyXdGVQMBRY9gs3h6ZdO9CYY1Vi7grWwqGI0WdUQZVrJugkT2U0e6PUZoITnL1QTgeXGwxmU
 N/lOr3dWmSV1q0K0Fb5Cw27VoATMy8OIgZe3OzR0orUIZNTga9b2xg81squjAQUBfag==
X-Gm-Gg: AfdE7cmKtOLfHzT2LcN6eP9N85SdUMtooCgFfc8fro3hjqiB7i8NP6ybYAZaxSm7XGJ
 C42KL9nw/h2X1rAgQKZZldvJFmLMskEOdBoLutc6t7UJqEXmcaD6k7PCDB4PL9qgHDObl4JJmoH
 x6zW+SpR7r1mousOLSaayhLCtV5064nbJOa+xPVo8WEcNEigIwkWDWDsf+j7waELtBh7rS7siG7
 hZtapNBv5ScNDjWnH7b/OQnYY5oZU5soNNoGMcp11DdGjNaBxSIzZh2UMry6/o7Nkoepc79/l55
 2f87eDaz30xnzzi5nOn3LyMom6GAS0koHRNBLKmDspN+SEdTLiIXN5ElHD1ljAGA4fmiq9UJ6Yc
 S8nL/5N58LNnB/q63DqU3zz4/U7AuN3KHFJP87iMHowtfP+Eb14SaYpeZEBfu4crbYdnn
X-Received: by 2002:a05:620a:258a:b0:92e:65d0:1cc7 with SMTP id
 af79cd13be357-92e8b5303a5mr1594205385a.28.1783288837086; 
 Sun, 05 Jul 2026 15:00:37 -0700 (PDT)
X-Received: by 2002:a05:620a:258a:b0:92e:65d0:1cc7 with SMTP id
 af79cd13be357-92e8b5303a5mr1594196185a.28.1783288836522; 
 Sun, 05 Jul 2026 15:00:36 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493ccb4cafesm220110595e9.0.2026.07.05.15.00.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 05 Jul 2026 15:00:35 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Chao Liu <chao.liu.zevorn@gmail.com>, alex.bennee@linaro.org,
 qemu-s390x@nongnu.org, Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Zhao Liu <zhao1.liu@intel.com>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v3 24/32] gdbstub: Introduce GdbBreakpointType enumerator
Date: Sun,  5 Jul 2026 23:57:20 +0200
Message-ID: <20260705215729.62196-25-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260705215729.62196-1-philmd@oss.qualcomm.com>
References: <20260705215729.62196-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA1MDIzOCBTYWx0ZWRfXzanjOtJBUb+g
 uL3Am5dyAr+ihZevZv6QRoOCpZgTB1tZ9CbUj4GAD/jI6FVzO4IJKdJtJHDxpvAfhwBIbc49VRM
 g43999DL6P7fUIuidHFJVJjoRi3w4xs=
X-Proofpoint-GUID: aiwPDf2yPLvYU8yohPsOOvh2JJDHO5IP
X-Proofpoint-ORIG-GUID: aiwPDf2yPLvYU8yohPsOOvh2JJDHO5IP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA1MDIzOCBTYWx0ZWRfX9FbE3Rno9hn7
 56i3NVU800XClWATMrTpHHHd4METnWajLAs3fKFk6KQcLnqmO/mELZO8wPonI58rYev6uGBuCEb
 JmRgV33ZPfRLVFh0T/s4T+sw7P0PepVGAtqZysdsgoAnm2rw2LlMnwXWXvq8S1R1FWKwepGHImm
 XteWamUp0f3FbAE3DMGr9759LDwmHeVMgZTlLot3qcNzgFK8tz9maIb6k76U40y04p641wcFm11
 eZnKg/ctq42zRvpZ/7KG0xhAHz+uMw1esLGQxp2ZK7VfD6Cu0lx4QfmJQ6Lo2RtMS+qg6zQcwEc
 WZbNFH2hleF9CwQO6iEsZeUReGFoSP6IyjR9WvTz+8ERz4GF33leXuAbe2uMAqD5J+mB+h718a3
 Cr+KWylhzWGoa7XXqBjbJKfdbrbWAw+5TXe/5z4NHTQhpGlcfMjhi62skjKA17uQ4vgLbh+nKMU
 rG+3e536q5IzeQHKJNg==
X-Authority-Analysis: v=2.4 cv=HLLz0Itv c=1 sm=1 tr=0 ts=6a4ad406 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=z_0bWbdd-CfuK1dINPUA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-05_02,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 clxscore=1015 suspectscore=0 impostorscore=0
 phishscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607050238
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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


