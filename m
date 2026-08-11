Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67BC5C5CFDB
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 18:36:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtrJz-0008Tm-2V; Tue, 11 Aug 2026 14:35:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wtrJx-0008M5-BJ
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 14:35:29 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wtrJt-0002pR-HQ
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 14:35:28 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67BGOHx01094027
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 18:35:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 5cKNYN1YVV/K1jHg9iJCW7yGQ3ybLzpVvQJS3M//mQs=; b=Lql9sAjZZP6bEaBy
 jmWk3rsV8wV7KJWNWxp3H4c+7+MVeD/Fn0H5xpOyk/HNHk7IDwxEST/2ah/xrW+8
 kdyPnyB5DfKyagCYVRlY2lhzhqvnEoajGz+4a4SXLNbToZuUKY3B0fjbXVMsTyQW
 se5K3aHXUuwZlcUnA0KXiBWQNRO0Cb5i0Iya06xrJtQSkGlBOEz9fYsOcg7sP0VJ
 yqmLBQsQOIBLBAkr6OkqdevuZ0oOd1QIt5clfz1G72GaRPM8o58zdR5J/jqgI8sJ
 VGv1FSmcmBINDPSh3DS2ExnXXTbQ4dcm7EUBkYkk947dCrJeDSb+c9E3vZkHuPPK
 PT0vVw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g049gsj96-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 18:35:13 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-52d28f8737eso3975301cf.2
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 11:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786473313; x=1787078113; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=5cKNYN1YVV/K1jHg9iJCW7yGQ3ybLzpVvQJS3M//mQs=;
 b=GBg6eMW5+cnzeLQngIuo2dDd6Z0O6X4gQ5YCP+ihRXo5ZA+mYBKAAcLchPl8tPt+WQ
 hNasqEycMnfvDau28Rniw9Pzpl6vMaK0tlMzaKQwabQ4JI7OGstwOLXokKH8dqjDu34Y
 sxYH2OKNz58y5WUs5r6a/1fcN+ZL84PvIlQG7T2OUgHDMM2DBYdsFxZ7YTiPMVJIy+XJ
 +BPSmyQPMzb/cpr3VfrDSOqc74EIs6+fM5xMKXNwnj6s8E3/5h2+QBl4KRvuwEIkRqTx
 xHkY+AVQl0RrryInYUEyetwpEwFZ1X7TRMxtLri+ZT4hZruI4ny9dtMwALudoEY2xApa
 aXEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786473313; x=1787078113;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5cKNYN1YVV/K1jHg9iJCW7yGQ3ybLzpVvQJS3M//mQs=;
 b=a3BTZF6FCsgylpnIinANazSOnQWQ0wiMCmCg3HaDluf0M8/pCocpZq8doobqhDuWHu
 LBhfbSGlUhrrrTMqiewOojpfMOCz0YUOYxy/0/tVaEu6fe/W6u9sE9PO20shxB4BfQHQ
 UBtbO7C3uu8Rh+42QAqcmxW0xs9byCsnH0lIyAzMAOBAdUo5xFzLxC9F/AVn6G9sjLvf
 CT7yvl7C6VKtbCmnSZ9sBhfYK7E+P7xZCwvs+LqJ0zwM5871LsyoFMdQ8hymjPHETt9Y
 zflpLwImV41+VhCsco3p+KPm+GZ48lc2KPUmVZpRo1pu1c8HQk2Bzldsk2fN5le5D63W
 6cTQ==
X-Gm-Message-State: AOJu0Yw1aG2hE5Osyt9Qi0V526fyyrwHjF5d/UF7pxa1d3xeGlwV9t+k
 OCbhkXTk0F8CS4QPWg62YFnu0bkELLnNLo39Xhg3iipK7b0HspwBIfj/pLyBBn9DmowcfvXNMn8
 SVovmtAi7gIL3ncnhXVEJLGajonM7fy4BR0kPzm7qqyyxS0TR71f20f+NdHUObgvw9g==
X-Gm-Gg: AR+sD11QizkHOrYfEgEL48Fy4tqAwQTCSvSQ9qSkLUY6YjhvF4++3EADb90oGElNbCB
 TRluz53aJgCorgoJ5MCXsThb7z15ZMzw8mp7lvpYda5hAEjYPcb1ozZWtZPBqPh2gefpbExXhBd
 rCjRIwNJG+4bRL0tS/8JpZZb4f5U1McOONHp99QIwEK9DpUstu8URbMz8G7XPnE8YLpsC7DeCj9
 r8B6hBBtZfqfDQUWWcsKwfjUz7r2B50lOzEjeWX6L3omJMerhsXeOVBSWIGcj0NL83O/R3geK3x
 Jw/Um8YgHGxrdLzS5EjUHoQGLhP7sn3kAWKaslWS71v007Ue12bOvWBPTRsDvrZswAeBUiKJsH+
 m/0hSPigEbjqN4EhJt2GJtEyDID/PcOejO4nssT/vSQ==
X-Received: by 2002:ac8:58ca:0:b0:50d:3e1e:7998 with SMTP id
 d75a77b69052e-52d586946b4mr43853141cf.37.1786473312890; 
 Tue, 11 Aug 2026 11:35:12 -0700 (PDT)
X-Received: by 2002:ac8:58ca:0:b0:50d:3e1e:7998 with SMTP id
 d75a77b69052e-52d586946b4mr43852861cf.37.1786473312462; 
 Tue, 11 Aug 2026 11:35:12 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4997ad79e5csm3958745e9.3.2026.08.11.11.35.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 11 Aug 2026 11:35:11 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-arm@nongnu.org, qemu-s390x@nongnu.org, kvm@vger.kernel.org,
 qemu-riscv@nongnu.org
Subject: [PATCH 8/8] hw/cpu: Move system-specific cpu_exec_realize() to
 cpu-system.c
Date: Tue, 11 Aug 2026 20:34:10 +0200
Message-ID: <20260811183410.22428-9-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260811183410.22428-1-philmd@oss.qualcomm.com>
References: <20260811183410.22428-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDE1NSBTYWx0ZWRfX8DU+1zSZeWDu
 2qSyJrj1erO6TQ5HW1leCHSnVBagppOoQzShzfRQHeadgLunMo0R65malIK2M5kxctQJ1VdG0wH
 9vwBOsmMqfHJJpodqD0lxB/RhfEavic=
X-Proofpoint-ORIG-GUID: kUYQ07dhi4n7a8a0XV3F4PG72jRI1ldm
X-Proofpoint-GUID: kUYQ07dhi4n7a8a0XV3F4PG72jRI1ldm
X-Authority-Analysis: v=2.4 cv=cvarVV4i c=1 sm=1 tr=0 ts=6a7b6b61 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=pilchTG5AImVgDdFcq4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDE1NSBTYWx0ZWRfX7VVLHQbhrUsU
 0dtfikkfqZAdQ6TZI/F2E+st0s0GXws8FMCFpVriJ0cerxnRf+v+SLoEsC6zocx21mby+2CRkAl
 HNg4yoyZGcrDEg0SevVwfVS3nDjM9IP2p3nTMcr30TWGgcqrAPpxIMfls7JUcWvEea0MQwhWq3q
 VhtNsyl8IyuJHSXip93gCS0hVnQv9+TlMaTWUkAfDdTS/vUVibR56rqS3PoX0XVITZjyG5JWCwS
 +0lx4dUFDZaIVSrPqGooF2nFAxy1FpzBsw7myaBJdElUmaoOQJjDvgIoyaCsEodrC5Pa/dmRG2E
 cFMbEIzAwM8WqsoHv8PGfR91a/29PjLSn+WwdPi+E2xRiaxTGfhv0x+wk9gURhmWP9GOZtqc0Dv
 uf0aLO5/IuT35a+4YKmnK61y885PDUm92WDZY5w8YsaNaW1I4CzOjfosS3bjpxzlBApwGZGrL02
 RyV0c68XMQnZwIDuf/Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_04,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 impostorscore=0 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608110155
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

Current cpu_exec_realize() body only contains system-mode
related code. Move that method out of cpu-common.c to
cpu-system.c, removing the system / machine mentions in
this common file. Add an empty stub for user-mode.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/core/cpu-internal.h |  1 +
 hw/core/cpu-common.c   | 24 ------------------------
 hw/core/cpu-system.c   | 26 ++++++++++++++++++++++++++
 hw/core/cpu-user.c     |  5 +++++
 4 files changed, 32 insertions(+), 24 deletions(-)

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
index 8a9f2fcea84..feadfb5af00 100644
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
 
@@ -221,6 +223,30 @@ static int cpu_common_pre_load(void *opaque)
     return 0;
 }
 
+void cpu_exec_realize(CPUState *cpu, Error **errp)
+{
+    Object *machine = qdev_get_machine();
+
+    /* qdev_get_machine() can return something that's not TYPE_MACHINE
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


