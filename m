Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E53CC43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 16:43:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfgxf-0005nS-ID; Fri, 03 Jul 2026 12:41:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wfgxd-0005k2-Uh
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 12:41:53 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wfgxY-0001mY-NG
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 12:41:53 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 663GIn3M476543
 for <qemu-devel@nongnu.org>; Fri, 3 Jul 2026 16:41:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 KMpp3aFM26Lyv0xLn4OgpzmL3P0zEDD0URj6gVEr5cM=; b=LGBm2DRLezU9GW2k
 0mcTE/uKbayts3h7JW/63D668/hU+h4Bwl4mVjcHXnfshtSy2C98LIU7VuIxfbyo
 Ntun9poucSmX0HVTna32014fk9Xu2yhJezJKUG83yUzmM+Kb4L9zxCbdQRCXvkju
 mVgjaI2xEFHXsWhHUKrL+qpUPCDlx6O6JgRycLXvaF71mKucMgR4GsCdM4GqkO69
 6ewNQJpncRHi1iUQ9gz25Nd88Yocd5U1C87tBovWXuDa+MylS0qfIRIyTcOds9ct
 aoJ9A4BpCoHK5RLY5KL1DGROahULd300YqlkCK0/JwST3P0H3AbyHcEKGXePbOT2
 PRMrpA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f60eybx9n-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 16:41:37 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-92e820609d9so49773985a.2
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 09:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783096897; x=1783701697; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KMpp3aFM26Lyv0xLn4OgpzmL3P0zEDD0URj6gVEr5cM=;
 b=iwMZJt+0OtTPYe0DCmYpfbyVBrJiRJgbybK7z+IQhpfYLBtRnGifjtFznnlH/w1CRf
 EQBFdre8s+iYDiyxsZ13MaKMAbCOyeGaC879yvIVfj2MejmTvpQ2HF+0xfc0i8aKPqVn
 oL8wEHQa7y74cTbtmMXlCSHCt/n9Cy6TU9UONzTW4h6A3p1gymulxn1EOsyAy4OaF+2O
 3YJZY5qpxcFGjkPHsW3viWlX7j6ubaTUe+aFS6IPw6whMgTjMQpllKrfNEVZMMYVtbJ6
 9sMSilP3soWXoJpUVHtEODJGUH1At/PTcUNA7m5vcpqK4CStIsMQr+fpZz/He9aEWViA
 /1Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783096897; x=1783701697;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KMpp3aFM26Lyv0xLn4OgpzmL3P0zEDD0URj6gVEr5cM=;
 b=XfIsgihzGBpQJvoY9BpSvR9fBR3kuJXeIFZN/hea9LZhcs2Y2kOh9jDUd3cOgTBQnQ
 3sOZ9pI/gXQWzgHhDQxivDnpk+UZxufmhLVjA2cD5XcBwaFH9wo3l7QiKnMnV8879TV2
 Ppu1yJR3HA+UF9a7Ppo9RvM7+AowxpYUEsm3M8BMZUVcdDVxjxbzWW9Bu1zA4mtTLHT4
 dMcoWbhCIVWe0XmxBJr6299WhBGoZhihBk+JJGlCHvJcNxvJgWSe6QgX0KbHn+YAhReN
 H/YvpakIDVZ5G6qv9L+1oimOKW3TzU9weO0wY0QJCQiHdLzt63UW1EEaO7Vptyze/4bD
 RWZQ==
X-Gm-Message-State: AOJu0Yw2DaZq+aRLeGGirQfpR0c6ijOTlrTQxggjOf+O4RKVpcLrnlho
 iJwKEWeijVvabvw8P4E/eric0TIqOTyL3PcMgU+DIQgew/ZzSP7YbW6Sg9cRSlnbdNvYMmVvF48
 rBDaMp6Q1D3E5IbIyMfaNbeOopsSo3ZNFJULqB9MhG5bXnB9pgMKBGrqUFhp+A9SFFw==
X-Gm-Gg: AfdE7cnhIMSV39hY6875v9haIpUEqqH9V59dblaImRoyNX2yRe7qUvaRcG6aU5VDyeU
 GxY3rfkpI52PbjJVnwy2S1eV2RoV+ZPO4b7Ts6YELE2v9fKmnkVZfltoYT6+Q69Br1u7VRJA6pN
 Ql0h3GrdiIhqbJiripYJYw/T46/ze4pvuYqrglhPDQyzxaxtYBn/ZNtDhvDsJwu5FOeGczGJVp3
 C9FXkPFx9va0R517KxL3Ue3/vH1UGDn5AN1RduXYxpbdpDRXNJAAaW6ap2d3DBr0brUmt8Z07rM
 V+04bh2B2CfB8LXFHivNQcp6sCXzhPfNNgjLww450s/TU4p50N6nzHF+AffhEDVOlVz/QCBJmlz
 5X/WpCRZVnoefTlZ0Foj76QkKS16qU5fBZfxwhHM/JB05gpTUP3puHIurWtmcWaPYIeW1
X-Received: by 2002:a05:620a:640e:b0:92a:dc07:2665 with SMTP id
 af79cd13be357-92e9a4ee486mr25798785a.54.1783096896991; 
 Fri, 03 Jul 2026 09:41:36 -0700 (PDT)
X-Received: by 2002:a05:620a:640e:b0:92a:dc07:2665 with SMTP id
 af79cd13be357-92e9a4ee486mr25794385a.54.1783096896543; 
 Fri, 03 Jul 2026 09:41:36 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493c63b6f1bsm132300565e9.10.2026.07.03.09.41.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 03 Jul 2026 09:41:35 -0700 (PDT)
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
Subject: [PATCH v2 29/33] cpu: Move CPUWatchpoint definition to
 'exec/watchpoint.h'
Date: Fri,  3 Jul 2026 18:37:52 +0200
Message-ID: <20260703163757.55500-30-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260703163757.55500-1-philmd@oss.qualcomm.com>
References: <20260703163757.55500-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDE2NCBTYWx0ZWRfX8XyVr8hL4TfV
 Roq/HOKZzO+Ir9lASL1ji+XhTqUQzjII4Q2ZAnRo4N0H08RUCoL+linkG1MA7Ia7hzV1WCfrX5T
 HozKwkv9KOx1ZxMTflbwmMJlNenSiW97wvgugGwBF7Fdt2q8G+lUcXLV8N2XPXmytNUWn6Jt8Cm
 g5dBIhMzubJkw8dXvAnzDy7DP9s3HobZfEbKr5cAbPmU6F+Q9VzRT6pJYPgk8vvH2IEG5EyzXNx
 8Yt+SIvyFNmC6FfT+e3L0487LJG3SD5h+UHIjojUR6EWjx+Pz5XA1OXIhKIGLB16wVzOFNhnAJX
 PfcAUpBREJAAh+uHvmmPypuKdz/asEDY+8D0+B0jAhwqFJ8Zb4M25kIDrN2x84dUK1gl5UDDnKb
 6mBm+D78MpQbytI09D+OjqQ+nGmVg1ey/TqYvHjhAg0HVbvgz47Rn7ozEiIksHXOdd9s5W3R/FS
 W3ul+ptgjxaXqFcCVYw==
X-Proofpoint-GUID: WhRdqdMZdEIMKq17MC2K4UYLqnvkSBxj
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDE2NCBTYWx0ZWRfX4zXhTXZGmAj7
 mpI21czXnln3n2jJu7VuAOBtB534+upuXZhDjF027QTVyN/T+jUUustBerlFUBFhbbRJD4ni2Vk
 GZG9BDkwzd6Ki4VhiGySkH/M+rqw5H0=
X-Authority-Analysis: v=2.4 cv=SPRykuvH c=1 sm=1 tr=0 ts=6a47e641 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=HjWuKgUHFhC_F9lk5HkA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: WhRdqdMZdEIMKq17MC2K4UYLqnvkSBxj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 spamscore=0 suspectscore=0 impostorscore=0
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

Define CPUWatchpoint in "exec/watchpoint.h", including this
header where appropriate.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/accel/tcg/cpu-ops.h |  1 +
 include/exec/breakpoint.h   |  9 ---------
 include/exec/watchpoint.h   | 12 ++++++++++++
 target/arm/internals.h      |  1 +
 gdbstub/system.c            |  1 +
 target/arm/hyp_gdbstub.c    |  1 +
 target/i386/kvm/kvm.c       |  1 +
 target/ppc/kvm.c            |  1 +
 target/s390x/kvm/kvm.c      |  1 +
 target/xtensa/helper.c      |  1 +
 10 files changed, 20 insertions(+), 9 deletions(-)

diff --git a/include/accel/tcg/cpu-ops.h b/include/accel/tcg/cpu-ops.h
index 568d82cdd32..d5994781c39 100644
--- a/include/accel/tcg/cpu-ops.h
+++ b/include/accel/tcg/cpu-ops.h
@@ -20,6 +20,7 @@
 #include "exec/memop.h"
 #include "exec/mmu-access-type.h"
 #include "exec/vaddr.h"
+#include "exec/watchpoint.h"
 #include "accel/tcg/tb-cpu-state.h"
 #include "tcg/tcg-mo.h"
 
diff --git a/include/exec/breakpoint.h b/include/exec/breakpoint.h
index 0c3cc0c8ff3..9d0dd89e7c9 100644
--- a/include/exec/breakpoint.h
+++ b/include/exec/breakpoint.h
@@ -33,13 +33,4 @@ typedef struct CPUBreakpoint {
     QTAILQ_ENTRY(CPUBreakpoint) entry;
 } CPUBreakpoint;
 
-typedef struct CPUWatchpoint {
-    vaddr vaddr;
-    vaddr len;
-    vaddr hitaddr;
-    MemTxAttrs hitattrs;
-    int flags; /* BP_* */
-    QTAILQ_ENTRY(CPUWatchpoint) entry;
-} CPUWatchpoint;
-
 #endif
diff --git a/include/exec/watchpoint.h b/include/exec/watchpoint.h
index ba148eff3d1..7b72de35aa5 100644
--- a/include/exec/watchpoint.h
+++ b/include/exec/watchpoint.h
@@ -8,7 +8,19 @@
 #ifndef EXEC_WATCHPOINT_H
 #define EXEC_WATCHPOINT_H
 
+#include "qemu/queue.h"
 #include "exec/breakpoint.h"
+#include "exec/memattrs.h"
+#include "exec/vaddr.h"
+
+typedef struct CPUWatchpoint {
+    vaddr vaddr;
+    vaddr len;
+    vaddr hitaddr;
+    MemTxAttrs hitattrs;
+    BreakpointFlags flags;
+    QTAILQ_ENTRY(CPUWatchpoint) entry;
+} CPUWatchpoint;
 
 int cpu_watchpoint_insert(CPUState *cpu, vaddr addr, vaddr len,
                           BreakpointFlags flags, CPUWatchpoint **watchpoint);
diff --git a/target/arm/internals.h b/target/arm/internals.h
index 067c3f2b8bb..72ef3a2bf9c 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -29,6 +29,7 @@
 #include "exec/vaddr.h"
 #include "exec/breakpoint.h"
 #include "exec/memop.h"
+#include "exec/watchpoint.h"
 #include "gdbstub/enums.h"
 #ifdef CONFIG_TCG
 #include "accel/tcg/tb-cpu-state.h"
diff --git a/gdbstub/system.c b/gdbstub/system.c
index 3098fd55740..1ce05989715 100644
--- a/gdbstub/system.c
+++ b/gdbstub/system.c
@@ -18,6 +18,7 @@
 #include "gdbstub/syscalls.h"
 #include "gdbstub/commands.h"
 #include "exec/hwaddr.h"
+#include "exec/watchpoint.h"
 #include "accel/accel-ops.h"
 #include "accel/accel-cpu-ops.h"
 #include "system/address-spaces.h"
diff --git a/target/arm/hyp_gdbstub.c b/target/arm/hyp_gdbstub.c
index dda6946ddaa..62dd91169dd 100644
--- a/target/arm/hyp_gdbstub.c
+++ b/target/arm/hyp_gdbstub.c
@@ -10,6 +10,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "exec/watchpoint.h"
 #include "cpu.h"
 #include "internals.h"
 #include "gdbstub/enums.h"
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 1e09155e92c..372781ae715 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -70,6 +70,7 @@
 #include "migration/blocker.h"
 #include "exec/memattrs.h"
 #include "exec/target_page.h"
+#include "exec/watchpoint.h"
 #include "trace.h"
 
 #include CONFIG_DEVICES
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 6bdfbbd68d6..85b15602396 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -41,6 +41,7 @@
 #include "trace.h"
 #include "gdbstub/enums.h"
 #include "exec/memattrs.h"
+#include "exec/watchpoint.h"
 #include "system/ramblock.h"
 #include "system/hostmem.h"
 #include "qemu/cutils.h"
diff --git a/target/s390x/kvm/kvm.c b/target/s390x/kvm/kvm.c
index 195e39df032..bb329883c97 100644
--- a/target/s390x/kvm/kvm.c
+++ b/target/s390x/kvm/kvm.c
@@ -49,6 +49,7 @@
 #include "hw/s390x/ipl.h"
 #include "hw/s390x/ebcdic.h"
 #include "exec/memattrs.h"
+#include "exec/watchpoint.h"
 #include "hw/s390x/s390-virtio-ccw.h"
 #include "hw/s390x/s390-hypercall.h"
 #include "target/s390x/kvm/pv.h"
diff --git a/target/xtensa/helper.c b/target/xtensa/helper.c
index 5a0e8655146..ac722f6782a 100644
--- a/target/xtensa/helper.c
+++ b/target/xtensa/helper.c
@@ -30,6 +30,7 @@
 #include "cpu.h"
 #include "exec/cputlb.h"
 #include "exec/target_page.h"
+#include "exec/watchpoint.h"
 #include "gdbstub/helpers.h"
 #include "exec/helper-proto.h"
 #include "accel/tcg/cpu-loop.h"
-- 
2.53.0


