Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6839C5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 12:13:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu7pV-00070l-IR; Wed, 12 Aug 2026 08:13:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wu7pN-0006x9-JZ
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 08:13:03 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wu7pK-0007Uh-Gi
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 08:13:00 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67CB4CFs3664634
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 12:12:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 zCA+9dgAGufk368/sCekoHYXZzEAVfMYc8ljN/zifGg=; b=nRURCD6+346+BQW+
 sHFN00ZT3oRz7y2lsWqIE+nnC6DlTGfPgLAx4lBFm3KJ/gVHoKdj0aYXEhws68kE
 YzPB6F/F//d+sn+Uvz6hKYuWRLZZ9ID2Io1/PjXSfV6F3qfvhTiW6AsV+uIcK5Y0
 JmK02jHitHyMjoUmcphqWpcIBu6SJzsAZIYpWm0CE0tzlZR+E7MWt37WrEZCMEO9
 hRSba657esc0NQmftUzpbVTyFrbptB6q7UnW/xIaOEnc2ID5Wsy+pVwknkV9BJUL
 sF9sTvzFCGKOiuCpM45mwg8FeXXz69/6cSln4n9SbOJDfMMHwTEzmKOncT2CLya0
 AzH9/g==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g0m6rh3p2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 12:12:56 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-52b4f6ac06aso15808371cf.1
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 05:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786536776; x=1787141576; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zCA+9dgAGufk368/sCekoHYXZzEAVfMYc8ljN/zifGg=;
 b=Hy9qWsAz4LcuHv5s52zG5eUGo/T+O03u9BgtfW/9ZlpUxBtLU+J9l/rtcpwL40buBd
 dlTLLWYCne4nW2pApfKOPDDiTprqD4rxVhbegtcMqfwmz6Co5ixXUNmdYewCHaDQ8qsA
 hsYhsTm4rogsFSMiugcj1zFActHEPp2DBg+wiDxPJjooEf6mq/eVTyrPDpZqKFKNB7yZ
 XEi+Wf8mMj6MnBhKpZlyVMnNm9cXUzffci/klp8jAwqd5fJoUhYBDswb9SlYPKQOb1K8
 XouT4JlmrypWYb6n9qI26Mi7Ttewtex4flmFh7zeQXIcnOJe+jKRXBGoQHXuwA1dMf2N
 8qcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786536776; x=1787141576;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zCA+9dgAGufk368/sCekoHYXZzEAVfMYc8ljN/zifGg=;
 b=jgmZJttE7Wu+Xj4XGraudXjWCvh0h+viAfAZwVQhezxj1OJDP+YdkXzOEKaVYjrpN0
 zRhvPr413mBEmvKchASf8uN2rDPpkFVGVXtvYRaJ3TwqAvdOYcyzKcHR5DS7HaRMaIVy
 q99Zo0+35WcGZefow6z6QWi9wtoNwLAYTLFBpRn1guTq5VOV2OGEeIpbvueBdXU1//VI
 q8VYRJpx0hXPLp/i9k+7j4xCAe8a8eIC0HwrrbYa+AETbMlYETzpLSer2xskOVDFC9mf
 GGPQCuQloF2JKqOF6tcZo53DOLbDnP1cEyNdEO+8gn0XDdWSpAVHh9fBjdzzKLsKB4+0
 aipA==
X-Gm-Message-State: AOJu0YzCMM/lTl06alNWwsqgyPWJdL62x0u8oJWgnIWZeGOO+DTRKWUY
 7Ww5FHtLXZnLnl9LCEcv+OGS6Bvz8SIguipYNlWZpScbREne3IEdM0ueX93pyP2pcCkC8X37Ea3
 1LbG9oJRqdCBXYXzMSAGuoq2vS2CHd3I0l3WCT2Q28OYJKQ7VZ05yeB14k6x7hpLEMg==
X-Gm-Gg: AR+sD11goQXa6r4fklLUMkGMH2Sife7sQtO9HMwfTK9dOaM9/NcQsnf8DX0B5Lk17FJ
 tK5Oh2z1SfJiKfEX7pEtaWo7CxjpDchdOKczCDnr8WSWo10EimXXAQAiop1vjYYY+SuY4fK/Mvn
 Ydfwua9bMyOqfQ2sX5GVCdqnE50I+nKzRjmLIE8mZsuwWpYjDhHCx0Q2YMGTFYzjb4GrIbzQtKP
 v3ovq6wqWVt4JF1DeFEoVN80MlixRSdmoEasDOtuVQW+9k2WvpoWrRRK/3jUPpO9UdueXSV55q5
 TD0hjR3HyU0Df72h+Rom274iGzlKyMmNDILHpip3LUHnhhtJhkdbJquNUOYPPjKRc04kd8tufJZ
 AATRPn9IJrB6or64feU0nu/V6CLtsCRB8fRbtDqVbrw==
X-Received: by 2002:a05:622a:1a9b:b0:51b:fe3c:6c1 with SMTP id
 d75a77b69052e-52d647f3112mr33151611cf.27.1786536775891; 
 Wed, 12 Aug 2026 05:12:55 -0700 (PDT)
X-Received: by 2002:a05:622a:1a9b:b0:51b:fe3c:6c1 with SMTP id
 d75a77b69052e-52d647f3112mr33150831cf.27.1786536775282; 
 Wed, 12 Aug 2026 05:12:55 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4997c946ce1sm42492555e9.5.2026.08.12.05.12.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 12 Aug 2026 05:12:54 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 3/7] hw/nmi: Remove @cpu_index argument from
 NMIClass::nmi_monitor_handler()
Date: Wed, 12 Aug 2026 14:12:28 +0200
Message-ID: <20260812121232.71958-4-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812121232.71958-1-philmd@oss.qualcomm.com>
References: <20260812121232.71958-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDA5OSBTYWx0ZWRfX1Nkd1Em04BX1
 YpGCeY93450//2hIqYvCNHTHOTLr+bgrukhMcVPUY9ytxmG1qdMsMuZ3ZJA1qtZIFN9aUtU45To
 X/RPPhUa/dAf3xU5mcLLtq+iCmT+6PDt0BEGbeHIUVSEG84v50o5u61GID4p26L7de0zgr5TlJj
 efoL2d7YgbRTtblCdhz6e3Uwex+sSGCUpwGkR4thqNDoDyLzlRMpNt+fGHI8ypKF8i27Ndtlfce
 dUYLaKZDlF6jhgh2Is9To8UwO75T2D38Rs7hiLoKL7cxea4vnaVNDI5/eqD79k6+3F+GETIJZgY
 p0uyVDaLOsPBLO3k1xLxvxS0TISYbCm/szFgIxLcR5iz4aPXPnSsnQEwhjTeAcTmi6WL2UI+kPl
 Uv8D45PBzfinjlqLVy3KkK8tSg73yCYpZpEnGxoE3ozS3pBfA5zt/woyrBelGrQMZiIBduBMjTj
 hsrDsNqc/8bNsKiWUcA==
X-Authority-Analysis: v=2.4 cv=Wb08rUhX c=1 sm=1 tr=0 ts=6a7c6348 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=KpD7k0r93PjNlcRUnYkA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: _6VRce8jR4liBCYbokJ92Z21fWJ9HefA
X-Proofpoint-ORIG-GUID: _6VRce8jR4liBCYbokJ92Z21fWJ9HefA
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDA5OSBTYWx0ZWRfXxecLqsXx5NSH
 C1DIZP6eXk6Kh7eyromBVoAdCnn5Nr0TPth1Gpv8tmMB1rejWWIELbl/LZelb58ujRV9Z49RqBs
 HNYVXyIA0pARw0CofNtlOSQi6a72q5M=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120099
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Only s390x was using the 'cpu_index' argument, but since the
previous commit it isn't anymore (it use the first cpu).
Since this argument is now completely unused, remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 include/hw/core/nmi.h      | 8 +++++++-
 hw/core/nmi.c              | 2 +-
 hw/hppa/machine.c          | 2 +-
 hw/i386/x86.c              | 2 +-
 hw/intc/m68k_irqc.c        | 2 +-
 hw/m68k/q800-glue.c        | 2 +-
 hw/misc/macio/gpio.c       | 2 +-
 hw/ppc/pnv.c               | 2 +-
 hw/ppc/spapr.c             | 2 +-
 hw/s390x/s390-virtio-ccw.c | 2 +-
 10 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/include/hw/core/nmi.h b/include/hw/core/nmi.h
index fff41bebc69..4c4ce79071d 100644
--- a/include/hw/core/nmi.h
+++ b/include/hw/core/nmi.h
@@ -37,7 +37,13 @@ typedef struct NMIState NMIState;
 struct NMIClass {
     InterfaceClass parent_class;
 
-    void (*nmi_monitor_handler)(NMIState *n, int cpu_index, Error **errp);
+    /**
+     * nmi_monitor_handler: Callback to handle NMI notifications.
+     *
+     * @ns: Class #NMIState state
+     * @errp: pointer to error object
+     */
+    void (*nmi_monitor_handler)(NMIState *ns, Error **errp);
 };
 
 void nmi_monitor_handle(int cpu_index, Error **errp);
diff --git a/hw/core/nmi.c b/hw/core/nmi.c
index 22724046575..ff6454437c1 100644
--- a/hw/core/nmi.c
+++ b/hw/core/nmi.c
@@ -40,7 +40,7 @@ static int do_nmi(Object *o, void *opaque)
         NMIClass *nc = NMI_GET_CLASS(n);
 
         ns->handled = true;
-        nc->nmi_monitor_handler(n, ns->cpu_index, &ns->err);
+        nc->nmi_monitor_handler(n, &ns->err);
         if (ns->err) {
             return -1;
         }
diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index d762163ddf5..2b44debc388 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -829,7 +829,7 @@ static void hppa_machine_reset(MachineState *ms, ResetType type)
     cpu[0]->env.cmdline_or_bootorder = 'c';
 }
 
-static void hppa_nmi(NMIState *n, int cpu_index, Error **errp)
+static void hppa_nmi(NMIState *ns, Error **errp)
 {
     CPUState *cs;
 
diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index dc7f0d56b01..0ea5453403d 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -147,7 +147,7 @@ static const CPUArchIdList *x86_possible_cpu_arch_ids(MachineState *ms)
     return ms->possible_cpus;
 }
 
-static void x86_nmi(NMIState *n, int cpu_index, Error **errp)
+static void x86_nmi(NMIState *ns, Error **errp)
 {
     /* cpu index isn't used */
     CPUState *cs;
diff --git a/hw/intc/m68k_irqc.c b/hw/intc/m68k_irqc.c
index 68ddb5351be..bc41b44d455 100644
--- a/hw/intc/m68k_irqc.c
+++ b/hw/intc/m68k_irqc.c
@@ -70,7 +70,7 @@ static void m68k_irqc_instance_init(Object *obj)
     qdev_init_gpio_in(DEVICE(obj), m68k_set_irq, M68K_IRQC_LEVEL_NUM);
 }
 
-static void m68k_nmi(NMIState *n, int cpu_index, Error **errp)
+static void m68k_nmi(NMIState *n, Error **errp)
 {
     m68k_set_irq(n, M68K_IRQC_LEVEL_7, 1);
 }
diff --git a/hw/m68k/q800-glue.c b/hw/m68k/q800-glue.c
index ac9062c6488..b13e5ef95f1 100644
--- a/hw/m68k/q800-glue.c
+++ b/hw/m68k/q800-glue.c
@@ -159,7 +159,7 @@ static void glue_auxmode_set_irq(void *opaque, int irq, int level)
     s->auxmode = level;
 }
 
-static void glue_nmi(NMIState *n, int cpu_index, Error **errp)
+static void glue_nmi(NMIState *n, Error **errp)
 {
     GLUEState *s = GLUE(n);
 
diff --git a/hw/misc/macio/gpio.c b/hw/misc/macio/gpio.c
index 1a7c534d652..1bdca728f97 100644
--- a/hw/misc/macio/gpio.c
+++ b/hw/misc/macio/gpio.c
@@ -188,7 +188,7 @@ static void macio_gpio_reset(DeviceState *dev)
     macio_set_gpio(s, 1, true);
 }
 
-static void macio_gpio_nmi(NMIState *n, int cpu_index, Error **errp)
+static void macio_gpio_nmi(NMIState *n, Error **errp)
 {
     macio_set_gpio(MACIO_GPIO(n), 9, true);
     macio_set_gpio(MACIO_GPIO(n), 9, false);
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index c0cb45dbfbc..8676be7bbb1 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -3552,7 +3552,7 @@ static void pnv_cpu_do_nmi(PnvChip *chip, PowerPCCPU *cpu, void *opaque)
     async_run_on_cpu(CPU(cpu), pnv_cpu_do_nmi_on_cpu, RUN_ON_CPU_HOST_INT(0));
 }
 
-static void pnv_nmi(NMIState *n, int cpu_index, Error **errp)
+static void pnv_nmi(NMIState *ns, Error **errp)
 {
     PnvMachineState *pnv = PNV_MACHINE(qdev_get_machine());
     int i;
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index b79828b4e90..189334b9f0a 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3550,7 +3550,7 @@ void spapr_do_system_reset_on_cpu(CPUState *cs, run_on_cpu_data arg)
     }
 }
 
-static void spapr_nmi(NMIState *n, int cpu_index, Error **errp)
+static void spapr_nmi(NMIState *ns, Error **errp)
 {
     CPUState *cs;
 
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 4f7861dbbb7..5d8a73a63df 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -725,7 +725,7 @@ static HotplugHandler *s390_get_hotplug_handler(MachineState *machine,
     return NULL;
 }
 
-static void s390_nmi(NMIState *n, int cpu_index, Error **errp)
+static void s390_nmi(NMIState *ns, Error **errp)
 {
     s390_cpu_restart(S390_CPU(first_cpu));
 }
-- 
2.53.0


