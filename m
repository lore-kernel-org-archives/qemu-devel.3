Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCD3BC43458
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 22:04:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wegYb-0004OO-2J; Tue, 30 Jun 2026 18:03:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wegXA-0002j8-Lw
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 18:02:31 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wegX8-0003st-Kt
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 18:02:24 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65UJDsS72959924
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 22:02:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 PZLbCHHJVVo9tzbQGh7Lv3WnuDKgE812wa9Iighf7Qc=; b=EHHy+u15n0P5zT8G
 drKLL5EcfyJD3AKrfYnoFbXhoraORYBpNMk+zBxjNi0bXULo1ZRpx/4BcKkGWHx2
 Rvcilh1/tDaEaTps1KGdCQoXLBKKpfSB6uOrcKFRFdvPRtGNI3aC2zS1+zteertt
 4O57OyrFcFzN+T7l4C2G1P8bgj6OBjHZgPTPaDELJNDRv6IAfxm3+LeXHyZS//7g
 1Qk/NvJ230zkFrAElhXr5JMW0AFaRVsGfbdtymA2N4NMkn/mcCPiAo4knZFGjbBb
 6Lpuc/QIup1iBggZvJk78QUTkw12LG6fhrVVZadMwZtMeMnZ2k3usap4ch7WV7fz
 kIdnuQ==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f4jkt8y2d-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 22:02:20 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id
 a1e0cc1a2514c-966a617821aso2572847241.3
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 15:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782856940; x=1783461740; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PZLbCHHJVVo9tzbQGh7Lv3WnuDKgE812wa9Iighf7Qc=;
 b=K3Rgjo/dQsuwaz/xG/CO1QgVG1zeSo7tZb7GzFjuohhKr8YLQYaEySHOXl7qrqxaYG
 BFD63/A9FnExeplfH05Bd78GtBUiIkl9zOpMpxvzPmbxNVd1Szq6kZpz9YP+fzRzssAb
 u9xW48lcXmhMhzbQjk19bdVpFImec8VLPIp1ubCiT0BrsfUm18YNZLr4bZO/mGBJ/b5I
 /DXmdUygJBqIFnlF5bJB8z2Lx9eF2UW9TK7uboJplh+cdE1IOG1JkyucDrCgXfY6EZFV
 wEgf3iWRJEio6FyAtIkqdUL9V2FubJ9XXZz/a7ge6WAcVxM6pSGiCdZLg+elYHrV0GGq
 /LWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782856940; x=1783461740;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PZLbCHHJVVo9tzbQGh7Lv3WnuDKgE812wa9Iighf7Qc=;
 b=KsQLYr3nuY30ZtXhC+BaOniKvyIGcuDyHXHLbeXvqmt8fC8HkJRknDphjsKmoN/p1P
 e0YVTlZ99By2ekke+rKlUqXXEo14zMQRTeY7CK9IscfHxuF0aNEI4LHlEOu/F0jDYttN
 lhe1MI41hWQ+u0+PDPPAOY3uUcZLG6k7Z2JT7XvBIE7dZ2MggkDnUreDmlHaJvJpkqwY
 bLrZRb+bg/l/Tu4Bzr4K6m6zT4kF31XD8rzohmJ37tD2ln6tcbmHm1RLQnjiw9x1Y2AV
 cYwbTLQ8MW263W1g0iFNTBPDHiepldjRpIdMQgrnLB1xeZdNvsutWHcUxWekY0O1xnI9
 6JoA==
X-Gm-Message-State: AOJu0Yx8WJrToDtP7TE1HgvcErdCpSbb6KSx6PWpttCwy/vgieYAU8R+
 uvykECfzc3lpNT1edi9t03CgtnhyQT7JSt1FB5/MkGRjPyzHmEQA/65QjvDcRyYEH0IYFFX0+gj
 8fdkfd3W9vXbhn+ThuJ5Cf2G+BH6HeZGqEGrxR6RdhjEfYTQpVvs332C9PSRywMVlWg==
X-Gm-Gg: AfdE7ckadnUqITSQ9iqmtjjp6D2hXixd8NRx4YSgSrBRW5TDCf+fZ005YKX0wo3GKSv
 rMeD63FQLxGTCyQfQJjzjdJ4bn0khRENu7Ia+x5jlCksYQby+U4AXO9FbarGguO9KghmQfmr1uk
 U8ysMYkCpAYIIlsVU+wALLGuYMbvAcuvw5mJOA0adawh487I7t+T38IuDQJSBX2lGnbRwdDQsTI
 4n3Ba+oR8rnmPK9rvD5xxzlH243s/IDbv3OJsvhnvSmFT1ZannpPG514Rl3IBacsk+eGfjy41eQ
 Bug1zRI2Cb25V3ObvTGC8vrRb+DjBmifdmUheiqIhEqqtS4EzwI3sNYhaokuO87XPWhgXUJmsnq
 +8XVDFemOuy74mzvZMKfZYbCohFpVxMoD2GXq0NoYxz9WkwI1XT6A8qLmVe7NHuAog791
X-Received: by 2002:a05:6102:5804:b0:739:97bf:9189 with SMTP id
 ada2fe7eead31-73a38840eb0mr2316434137.19.1782856940105; 
 Tue, 30 Jun 2026 15:02:20 -0700 (PDT)
X-Received: by 2002:a05:6102:5804:b0:739:97bf:9189 with SMTP id
 ada2fe7eead31-73a38840eb0mr2316356137.19.1782856939454; 
 Tue, 30 Jun 2026 15:02:19 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493be4c7f2csm28217525e9.3.2026.06.30.15.02.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 30 Jun 2026 15:02:18 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Zhao Liu <zhao1.liu@intel.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-ppc@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 10/33] accel: Change gdbstub_supported_sstep_flags() ->
 get_gdbstub_config()
Date: Wed,  1 Jul 2026 00:00:37 +0200
Message-ID: <20260630220100.1289-11-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260630220100.1289-1-philmd@oss.qualcomm.com>
References: <20260630220100.1289-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDIxNCBTYWx0ZWRfX88VV6h9K04PH
 D+HC6Gc+eN1buLn/ryuuFEX3zqli6ACiB92aKs4iZwuH81Pm6bYeR22g37jPZ3JrLNGeWeiSpGN
 QGxnaFfBkZbrBeqEAEvPg95G5OPp+7g=
X-Proofpoint-GUID: 127xc8LsUR_7dmg-ghpRFF8ifHQHI2on
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDIxNCBTYWx0ZWRfX/Hhgw7vb+sET
 zRpPk3myXurSAdnzXXT51xjdgR6znVT/dW1Iv8OIW8IzMSABNaRfVyB7+TInXDOkzUmFoajCCAF
 VNPrAACfeLSuR7ex6AjVEjn5gZZi8nGW0lAfC9Sv+lrM8rAfkA/insp0hMGm2uFFZX0BWVhvW+Q
 uBrh+YZDN8FowVpNksP02BmkqL27+azSzZakRs5jahQa4vlbrqBKyOV7HoEaA/ziHR7SvpzxFna
 HwPkIXYPhjdqf6Ca8zIWUrRzlrOk9UpCljrsi/EIvJcCB4I9DbQthtVMuAHoNRPOj9oDmk+Qgvk
 xmTLi/nin6INGqlh/vOUn40+PiDNrdoV606ieYvVM5LOyQIq25zOvD3JunLAiAty8ZFodKCxomX
 24YUaROGAinsqBc6nOs7zFjzQAWnfouop/WjxkXXXgUMh49iY5CG17dQYFgbNOSxstWKSh8whq+
 CQjZvuL3MZe6GzdC55Q==
X-Authority-Analysis: v=2.4 cv=R+wz39RX c=1 sm=1 tr=0 ts=6a443cec cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=PyuShGlAArM5Lf9eh-UA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=TOPH6uDL9cOC6tEoww4z:22
X-Proofpoint-ORIG-GUID: 127xc8LsUR_7dmg-ghpRFF8ifHQHI2on
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_05,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300214
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

In order to have accelerator return multiple gdbstub parameters,
pass @supported_sstep_flags as argument instead of returning it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 include/accel/accel-ops.h |  2 +-
 include/qemu/accel.h      |  7 ++++---
 accel/accel-common.c      |  9 +++++----
 accel/hvf/hvf-all.c       |  6 +++---
 accel/kvm/kvm-all.c       | 12 +++++++-----
 accel/tcg/tcg-all.c       |  8 ++++----
 gdbstub/gdbstub.c         |  2 +-
 7 files changed, 25 insertions(+), 21 deletions(-)

diff --git a/include/accel/accel-ops.h b/include/accel/accel-ops.h
index f46492e3fe1..1bc359ff3e5 100644
--- a/include/accel/accel-ops.h
+++ b/include/accel/accel-ops.h
@@ -37,7 +37,7 @@ struct AccelClass {
                        hwaddr start_addr, hwaddr size);
 
     /* gdbstub related hooks */
-    int (*gdbstub_supported_sstep_flags)(AccelState *as);
+    void (*get_gdbstub_config)(AccelState *as, int *supported_sstep_flags);
 
     bool *allowed;
     /*
diff --git a/include/qemu/accel.h b/include/qemu/accel.h
index d3638c7bfda..92f9c538f31 100644
--- a/include/qemu/accel.h
+++ b/include/qemu/accel.h
@@ -74,11 +74,12 @@ bool accel_cpu_common_realize(CPUState *cpu, Error **errp);
 void accel_cpu_common_unrealize(CPUState *cpu);
 
 /**
- * accel_supported_gdbstub_sstep_flags:
+ * accel_get_gdbstub_config:
+ * @supported_sstep_flags: pointer to store the single step modes in
  *
- * Returns the supported single step modes for the configured
+ * Set the supported single step modes for the configured
  * accelerator.
  */
-int accel_supported_gdbstub_sstep_flags(void);
+void accel_get_gdbstub_config(int *supported_sstep_flags);
 
 #endif /* QEMU_ACCEL_H */
diff --git a/accel/accel-common.c b/accel/accel-common.c
index 62590a7d9a6..526ab2a0cfb 100644
--- a/accel/accel-common.c
+++ b/accel/accel-common.c
@@ -113,14 +113,15 @@ void accel_cpu_common_unrealize(CPUState *cpu)
     }
 }
 
-int accel_supported_gdbstub_sstep_flags(void)
+void accel_get_gdbstub_config(int *supported_sstep_flags)
 {
     AccelState *accel = current_accel();
     AccelClass *acc = ACCEL_GET_CLASS(accel);
-    if (acc->gdbstub_supported_sstep_flags) {
-        return acc->gdbstub_supported_sstep_flags(accel);
+    if (acc->get_gdbstub_config) {
+        acc->get_gdbstub_config(accel, supported_sstep_flags);
+    } else {
+        *supported_sstep_flags = 0;
     }
-    return 0;
 }
 
 static const TypeInfo accel_types[] = {
diff --git a/accel/hvf/hvf-all.c b/accel/hvf/hvf-all.c
index 21b9b71a6df..284ce8ebff1 100644
--- a/accel/hvf/hvf-all.c
+++ b/accel/hvf/hvf-all.c
@@ -228,9 +228,9 @@ static int hvf_accel_init(AccelState *as, MachineState *ms)
     return hvf_arch_init();
 }
 
-static int hvf_gdbstub_sstep_flags(AccelState *as)
+static void hvf_gdbstub_config(AccelState *as, int *supported_sstep_flags)
 {
-    return SSTEP_ENABLE | SSTEP_NOIRQ;
+    *supported_sstep_flags = SSTEP_ENABLE | SSTEP_NOIRQ;
 }
 
 static void hvf_set_kernel_irqchip(Object *obj, Visitor *v,
@@ -278,7 +278,7 @@ static void hvf_accel_class_init(ObjectClass *oc, const void *data)
     ac->name = "HVF";
     ac->init_machine = hvf_accel_init;
     ac->allowed = &hvf_allowed;
-    ac->gdbstub_supported_sstep_flags = hvf_gdbstub_sstep_flags;
+    ac->get_gdbstub_config = hvf_gdbstub_config;
     hvf_kernel_irqchip_override = false;
     hvf_kernel_irqchip = false;
     object_class_property_add(oc, "kernel-irqchip", "on|off|split",
diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 6cd5f95d06e..72d6eb464db 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -4281,14 +4281,16 @@ static void kvm_accel_instance_init(Object *obj)
 }
 
 /**
- * kvm_gdbstub_sstep_flags():
+ * kvm_gdbstub_config():
  *
- * Returns: SSTEP_* flags that KVM supports for guest debug. The
+ * Set SSTEP_* flags that KVM supports for guest debug. The
  * support is probed during kvm_init()
  */
-static int kvm_gdbstub_sstep_flags(AccelState *as)
+static void kvm_gdbstub_config(AccelState *as, int *supported_sstep_flags)
 {
-    return kvm_sstep_flags;
+    KVMState *s = KVM_STATE(as);
+
+    *supported_sstep_flags = s->gdbstub_sstep_flags;
 }
 
 static void kvm_accel_class_init(ObjectClass *oc, const void *data)
@@ -4299,7 +4301,7 @@ static void kvm_accel_class_init(ObjectClass *oc, const void *data)
     ac->rebuild_guest = kvm_reset_vmfd;
     ac->has_memory = kvm_accel_has_memory;
     ac->allowed = &kvm_allowed;
-    ac->gdbstub_supported_sstep_flags = kvm_gdbstub_sstep_flags;
+    ac->get_gdbstub_config = kvm_gdbstub_config;
 
     object_class_property_add(oc, "kernel-irqchip", "on|off|split",
         NULL, kvm_set_kernel_irqchip,
diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
index 8eb4a6b89e8..89f7e025021 100644
--- a/accel/tcg/tcg-all.c
+++ b/accel/tcg/tcg-all.c
@@ -242,7 +242,7 @@ static void tcg_set_one_insn_per_tb(Object *obj, bool value, Error **errp)
     qatomic_set(&one_insn_per_tb, value);
 }
 
-static int tcg_gdbstub_supported_sstep_flags(AccelState *as)
+static void tcg_gdbstub_config(AccelState *as, int *supported_sstep_flags)
 {
     /*
      * In replay mode all events will come from the log and can't be
@@ -251,9 +251,9 @@ static int tcg_gdbstub_supported_sstep_flags(AccelState *as)
      * them occurring every time we single step.
      */
     if (replay_mode != REPLAY_MODE_NONE) {
-        return SSTEP_ENABLE;
+        *supported_sstep_flags = SSTEP_ENABLE;
     } else {
-        return SSTEP_ENABLE | SSTEP_NOIRQ | SSTEP_NOTIMER;
+        *supported_sstep_flags = SSTEP_ENABLE | SSTEP_NOIRQ | SSTEP_NOTIMER;
     }
 }
 
@@ -266,7 +266,7 @@ static void tcg_accel_class_init(ObjectClass *oc, const void *data)
     ac->cpu_common_unrealize = tcg_exec_unrealizefn;
     ac->get_stats = tcg_get_stats;
     ac->allowed = &tcg_allowed;
-    ac->gdbstub_supported_sstep_flags = tcg_gdbstub_supported_sstep_flags;
+    ac->get_gdbstub_config = tcg_gdbstub_config;
 
     object_class_property_add_str(oc, "thread",
                                   tcg_get_thread,
diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index f54415a9db7..1e0a6638bff 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -72,7 +72,7 @@ void gdb_init_gdbserver_state(void)
      * By default try to use no IRQs and no timers while single
      * stepping so as to make single stepping like a typical ICE HW step.
      */
-    gdbserver_state.supported_sstep_flags = accel_supported_gdbstub_sstep_flags();
+    accel_get_gdbstub_config(&gdbserver_state.supported_sstep_flags);
     gdbserver_state.sstep_flags = SSTEP_ENABLE | SSTEP_NOIRQ | SSTEP_NOTIMER;
     gdbserver_state.sstep_flags &= gdbserver_state.supported_sstep_flags;
 }
-- 
2.53.0


