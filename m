Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D68D3C5B572
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2026 14:50:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvcBl-0000Tz-RO; Sun, 16 Aug 2026 10:50:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvcBV-0008Ot-D9
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 10:50:04 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvcBT-0001OD-La
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 10:50:01 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67GDmShe3952895
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 14:49:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 54GFn1ok6djl80fazqWH76nah0qW2Xxhm2gnp1sqOFg=; b=EGyq3SpHirBzlK2Z
 PAUaR0t+N5FANOmyOuSMaIl8b1tnpRuwyR08axjFgVgL7c2KVLkdI43lB4qjLzKS
 joZ5chihqbvH3/mhtIv48QEplkTEV8oiYxIeZlyd4vWMciUnvc3lHg+/yLPEtieL
 T0aBsdSQnpA9qbsONCDEEizzLCiQwwYRJH7XkiX7Ko47aKlpWiGR7sZuKNAQ4xTb
 MpBkpDhYpjPdgz012auTCFCxyYaS0XGe8bXt9F9xCD9zroc54/06w/c+Fc2IPzai
 h7rNtJcGvvO/XEZO+8VlRkYp+ZFumbiUqUvhT7d4+n6N6EH5vup7NHV/RCYOo5yY
 VWQ4Tg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g2ghnumcs-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 14:49:58 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51ebdfceddcso29892151cf.3
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 07:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786891798; x=1787496598; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=54GFn1ok6djl80fazqWH76nah0qW2Xxhm2gnp1sqOFg=;
 b=JQpBwjjpw5lpA6Ibnz9E6/iX3Bxm43xeHS6Q/ZcuYQtBIijcR8R+/tPXtZ15VGMFMu
 nu3+K6LyYJEd380PD5Wup1GaLaSStbuR6I3TO7Ugi5y5Y+fOoEXeWhC5t1+S+0I2kRyx
 wGUJT9hM09fijpkH1+fMPJbQxi/g2svCp+iEHZtLwzalZkEm/IOV8pmBn7K77esXtHJX
 k8CsS44wDiUW+6aM/bIEojKdwMyPovxvqntDfMJVts75HAgFr/djLlkzO1iGPaPcDSJ9
 dRiBrdyC7PlEJf2Va85gD+gdqde3pLvoEovXyJ7yDsmy0K59Zr6KAuUdahz09fCbD3FD
 CYxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786891798; x=1787496598;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=54GFn1ok6djl80fazqWH76nah0qW2Xxhm2gnp1sqOFg=;
 b=Wxg3almHShWFACg9sDrPeM8BUBmgGhG+jZPmW1OpVa/5wveMvQovhA0diCYBeJHkbC
 KiulZJLFJxT2DyGjVK+28/uxSncnbpocnM/WbmHa7ziwZ8fa93Qg0wC2I6J3CBtEu0SN
 XCVwZFWUYa+y1CRESFCNIywgG31d6fUA1mAUrAI7eXMrqmW8LoOEwCD8Suue1Vw8GMnS
 lvUh2h/ENfk/twVZnsqk7D5xEF858c6WGfDNVDSXMh5jX8B0EvkVIoBCxx62VbnT0dku
 hC0eIC179lyAJru1JgeF3rPF2oJFTJVKZBsP8zNPYD3prSe+HCrONC/8Yd5JTdK29BM0
 PuPg==
X-Gm-Message-State: AOJu0YzBXpb2Hx8fYCKu3I1iaWQfjTkrhs7sZ61Y42AxIy+5pI/rT4Vb
 qa1zKWIt1b26ZJ25hyHUYDAfcu6rR58LK2y+RwiozV1kSYudqO78Sv31YiHUweHwQF/0njwy53v
 3nIu7tDiZgnpMtIkArDQUnnXNFQ+lIy8Abg5UbZevkxGN3DZLw5D7FbSHgcY1GeHlvg==
X-Gm-Gg: AR+sD132gHRXnSeTu9r0K2wi4TYs/r9eMphHNyfe1/Ltg3AsFF9SIOZuZXN5+2IE31E
 LlJNj6eWp3kmplszcykXq3IpwGaNiJFL413QH9zn08bak5dj8srl6dqV9e3QdeyKY+HREj4HVgL
 OQKpNyxmGNHgRsm4p/mJPW27BPf0oG98MhMPkQWwMOx8YpufAdnzYCmwMdwfgcXZYu2gLk8uroi
 4WP/5xFYLFuZE9PKACUzRFdfociZwjT6nl2ukUlUKksfD9E9B8NEvqVgZGJRG2duprRwYzSdsid
 Xh1HnvDlzjfB2sTCRtGROM1z1yzOfdYDQYJZ3tNxiq4J6GfAWQLV6SUxCnwc01wFYgGthvzurb1
 WGXEk2Hb3qhUS5Ow6qkk8aPPb+Qw8N3UWK365GPrYXw==
X-Received: by 2002:a05:622a:e0cf:10b0:52d:8c01:5238 with SMTP id
 d75a77b69052e-52d8c01530bmr108453141cf.33.1786891797915; 
 Sun, 16 Aug 2026 07:49:57 -0700 (PDT)
X-Received: by 2002:a05:622a:e0cf:10b0:52d:8c01:5238 with SMTP id
 d75a77b69052e-52d8c01530bmr108452971cf.33.1786891797484; 
 Sun, 16 Aug 2026 07:49:57 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499961098cdsm66580045e9.6.2026.08.16.07.49.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 16 Aug 2026 07:49:56 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 28/56] hw/cpu: Move system-specific cpu_exec_realize() to
 cpu-system.c
Date: Sun, 16 Aug 2026 16:45:27 +0200
Message-ID: <20260816144556.69009-29-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260816144556.69009-1-philmd@oss.qualcomm.com>
References: <20260816144556.69009-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE2MDExOCBTYWx0ZWRfX9a/drgaeRTvv
 46Wg4aFDMUGQ8IHv0cN5aIyWlh2TOnZm7xS0s4CKFWnIgfuk6V+88wChEaa7GiXLiJhzqlR0unK
 jiLRpE7m9YiGElYKU7cryv4pf2+R/DWNBomQYJ1BU6Xq+QOAPlSNPd2zGCVTklJ+9BsZ5UI7v1I
 Fg4HsKlnBYmfJrtzBeWg+Hy2GMRxRs2+A+Ze8tkl08/X5O2rRlc9Q+lvihuTY/XHmcr+X+ldsjp
 DD2CKOCsbggLZZz+mE+18ViY6SlKbEEMPpiu7MpGcanhvVZsTA4TpWCuFM0GlQuGylDjcCa2mQ3
 fRdYhv6/2bii8Mp1+OrcxPN9T48ZATZi2CwaZ+/R5ShUQqLODr9OOB0XDLvgRJjeVJ1yZuWB+MS
 smya4wXYIvtthdIB8puiFCxojoQfCkzPz3K//owD69VmHE+PJJQleqDfhqhVQa4JDLnNklmnFbw
 X0QOa1X4cpPpxlZAt7Q==
X-Proofpoint-ORIG-GUID: MVPs-l4QKQ-gr85m2kOjM9TlpBPoUyd2
X-Authority-Analysis: v=2.4 cv=QN5YgALL c=1 sm=1 tr=0 ts=6a81ce16 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=pilchTG5AImVgDdFcq4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE2MDExOCBTYWx0ZWRfXztvyMclLvz1U
 CRD8WI74SzB6/dMzxLtC9+NpJO0Z+JyF7ZMlm5/1oYWiWTSv82Y6JjUL8L4JD/i8GmsOvsxfDtv
 5z8XafhEzFbDkgvH6kji62LZAR8sBwk=
X-Proofpoint-GUID: MVPs-l4QKQ-gr85m2kOjM9TlpBPoUyd2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0
 clxscore=1015 priorityscore=1501 malwarescore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608160118
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

Current cpu_exec_realize() body only contains system-mode
related code. Move that method out of cpu-common.c to
cpu-system.c, removing the system / machine mentions in
this common file. Add an empty stub for user-mode.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20260811183410.22428-9-philmd@oss.qualcomm.com>
---
 hw/core/cpu-internal.h |  1 +
 hw/core/cpu-common.c   | 24 ------------------------
 hw/core/cpu-system.c   | 27 +++++++++++++++++++++++++++
 hw/core/cpu-user.c     |  5 +++++
 4 files changed, 33 insertions(+), 24 deletions(-)

diff --git a/hw/core/cpu-internal.h b/hw/core/cpu-internal.h
index ae6a31bca2d..44715b44329 100644
--- a/hw/core/cpu-internal.h
+++ b/hw/core/cpu-internal.h
@@ -15,6 +15,7 @@ void cpu_class_init_props(DeviceClass *dc);
 void cpu_exec_class_post_init(CPUClass *cc);
 
 void cpu_exec_init(CPUState *cpu);
+void cpu_exec_realize(CPUState *cpu, Error **errp);
 
 void cpu_vmstate_register(CPUState *cpu);
 void cpu_vmstate_unregister(CPUState *cpu);
diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
index cd7c8763cf5..4f4c87f33a0 100644
--- a/hw/core/cpu-common.c
+++ b/hw/core/cpu-common.c
@@ -33,7 +33,6 @@
 #include "exec/log.h"
 #include "exec/gdbstub.h"
 #include "system/tcg.h"
-#include "hw/core/boards.h"
 #include "hw/core/qdev-properties.h"
 #include "trace.h"
 #ifdef CONFIG_PLUGIN
@@ -246,29 +245,6 @@ bool cpu_common_realize(CPUState *cpu, Error **errp)
     return true;
 }
 
-static void cpu_exec_realize(CPUState *cpu, Error **errp)
-{
-    Object *machine = qdev_get_machine();
-
-    /* qdev_get_machine() can return something that's not TYPE_MACHINE
-     * if this is one of the user-only emulators; in that case there's
-     * no need to check the ignore_memory_transaction_failures board flag.
-     */
-    if (object_dynamic_cast(machine, TYPE_MACHINE)) {
-        MachineClass *mc = MACHINE_GET_CLASS(machine);
-
-        if (mc) {
-            cpu->ignore_memory_transaction_failures =
-                mc->ignore_memory_transaction_failures;
-        }
-    }
-
-    if (DEVICE(cpu)->hotplugged) {
-        cpu_synchronize_post_init(cpu);
-        cpu_resume(cpu);
-    }
-}
-
 static void cpu_common_realizefn(DeviceState *dev, Error **errp)
 {
     cpu_exec_realize(CPU(dev), errp);
diff --git a/hw/core/cpu-system.c b/hw/core/cpu-system.c
index 8a9f2fcea84..a64e8c2b687 100644
--- a/hw/core/cpu-system.c
+++ b/hw/core/cpu-system.c
@@ -25,10 +25,12 @@
 #include "exec/target_page.h"
 #include "system/memory.h"
 #include "qemu/target-info.h"
+#include "hw/core/boards.h"
 #include "hw/core/qdev.h"
 #include "hw/core/qdev-properties.h"
 #include "hw/core/sysemu-cpu-ops.h"
 #include "migration/vmstate.h"
+#include "system/hw_accel.h"
 #include "system/tcg.h"
 #include "cpu-internal.h"
 
@@ -221,6 +223,31 @@ static int cpu_common_pre_load(void *opaque)
     return 0;
 }
 
+void cpu_exec_realize(CPUState *cpu, Error **errp)
+{
+    Object *machine = qdev_get_machine();
+
+    /*
+     * qdev_get_machine() can return something that's not TYPE_MACHINE
+     * if this is one of the user-only emulators; in that case there's
+     * no need to check the ignore_memory_transaction_failures board flag.
+     */
+    if (object_dynamic_cast(machine, TYPE_MACHINE)) {
+        MachineClass *mc = MACHINE_GET_CLASS(machine);
+
+        if (mc) {
+            cpu->ignore_memory_transaction_failures =
+                mc->ignore_memory_transaction_failures;
+        }
+    }
+
+    if (DEVICE(cpu)->hotplugged) {
+        cpu_synchronize_post_init(cpu);
+        cpu_resume(cpu);
+    }
+
+}
+
 static bool cpu_common_exception_index_needed(void *opaque)
 {
     CPUState *cpu = opaque;
diff --git a/hw/core/cpu-user.c b/hw/core/cpu-user.c
index c2cb00a85d3..1e38c88f9bd 100644
--- a/hw/core/cpu-user.c
+++ b/hw/core/cpu-user.c
@@ -38,6 +38,11 @@ void cpu_exec_init(CPUState *cpu)
     /* nothing to do */
 }
 
+void cpu_exec_realize(CPUState *cpu, Error **errp)
+{
+    /* nothing to do */
+}
+
 void cpu_vmstate_register(CPUState *cpu)
 {
     assert(qdev_get_vmsd(DEVICE(cpu)) == NULL ||
-- 
2.53.0


