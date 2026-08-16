Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0C29C5DF70
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2026 14:51:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvcBy-0001mM-8t; Sun, 16 Aug 2026 10:50:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvcBw-0001fb-EZ
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 10:50:28 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvcBu-0001c1-F3
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 10:50:28 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67GDklB93609386
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 14:50:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 /TI55kTmRszhsBOU9JNOcf2+ospWSGcNv4d1cCzyn9E=; b=OxxXK8h+smfe+kH8
 lSG3fFl9yh4y4+Sc7DC4jzLOcuZNEaYBQRdkzsy0iYaApKX/SHy07hH53ErbEdBg
 l9H++RlkRlv9LJ/mq42iZ+xHK38Wk/25q6WT2TPkNjJ/aPXP8h4hwTVN0DHzE94d
 m5a2z84kh0Dm17HDBTW5471rYy6AS9c6HlpSliDoyKRJtoMKFc1xJ5/RvVoNEEh+
 lmtel/c7NoI2g2HX49WLYRKJzlNpaXSA3gCiFwQIOLOrtW0g0Io++TeqsOgOSUUf
 6MTzrYHZOS9xrI2tfp+pa6FTPetP4Fb6YmQpEXa1BJLBUFTLVYBMZopnumkEfHpB
 cE1tjQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g2ghfuk4y-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 14:50:24 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51c1c7f135bso45118231cf.0
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 07:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786891824; x=1787496624; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/TI55kTmRszhsBOU9JNOcf2+ospWSGcNv4d1cCzyn9E=;
 b=HaOiVwia97vt/VSkxBvdtj6V4gqr4g9ClIHGrY/3yy5wUZhNxCZC8LJqYGsFZ933jP
 sYmr4qabl/ReD+em2Bepx1p5eNo+hdH81okADEGG2nepBLKxCZ1medxJlzB13T3UyEsi
 DevUR+iRsg0pIORC8ce2ZWLg6uiyY6xGJnzrBstru09+Hj8Wil7vUm4/Z/q5ouAW1Tv+
 Orp6LhiK0HIxV+HHjbnVCcRNhR24Y7C18midS675Pcn8Ls4DQTXGaTqzxhIYFhq9RSv/
 1X4Q/zXz7/elEv7Ud+bhVC2gVbYjO0yScMP7KFNF1oogLaGio/2QbUCHOHgl93f48hqR
 XrhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786891824; x=1787496624;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/TI55kTmRszhsBOU9JNOcf2+ospWSGcNv4d1cCzyn9E=;
 b=V+gyVcvV0CoJDnHQsXpV9xtGatNinwjSZy88Ril0sMtAcjB/wzLCUVZQLVc0BgxJG8
 6RhNg/qIBv+8eF/NxY1ssdZ9k+4xCYXzDoqwWBnz96AAz55N7V3HETEN2Izyv372++X9
 wCpHFUK0d9G0FFjfwAgwZFt3+Of5aTFJJXZAUC1n1QpuQvrOh+f2ArvORimqrA56S10T
 5ytKOXAazO8vueJ7ikxJm05+kExgAexwWNCLa1M1E0GgdUZOIZo2Yb6qMpFV5R4KXxJ3
 zeQF8ArBsYilgTNURjNty/A4kfbe3n2Ez3Md8gFubwJvxzNtTlyHJWCgGNLCDvbP27F1
 eC5w==
X-Gm-Message-State: AOJu0YzCDpidKV320SZuZnFzN/TzU16qI5zwKF5BsjWnFBG6gZJwnqt8
 LnlAxkB/NJS3OALJEAwJE8+9CLTJl6/T3NiD/5PXxIRCKko2ZNu3KzGGtB38Nc4xtP+/sDzV1eC
 K5dk1Y2jMUpbptHrJy9xl70cYXl71ajq1STtcTgvFs/GrEhB1zaMpPIjIieEBu665Sg==
X-Gm-Gg: AR+sD11FHp/eV/Djyf4b0lFVCv8uMZJ/p56ggswyBV3p2a98x2zFJBg97Z+Fh//caBz
 rqKQcBDmKHmbaQgf+ki4bVYri+Sj3f7daoyid+WnLg0fDBKCG5VAMV5tJIyZzsbQ8gHLmhN4VoY
 152j1IbPWHBpzdz0+5eRsdlsQoXpC0qiBpcfHvm/hGgPisqUSqmUUwclWY0RRlR4G3Tadlt/pQp
 zQv670v1byI7wBxSHgesCQvx05gjV8IARo8k7FNhvJEs3MjGjf4nnrdqtFa4khWrUpSbxN3tfkD
 Knr2vncFO8fTeVar6m4F1e7YLtVSuu1y4z1wdoXeDy/myT2H6fLpc5QsM7fDrGp5NNPxpBRstSK
 W1ggSzkxdODT8xv3a7Vx5piUfpHxckXvayTpdv84svQ==
X-Received: by 2002:ac8:7fc4:0:b0:51c:1fd1:e755 with SMTP id
 d75a77b69052e-52d854dc9e7mr180565501cf.36.1786891823951; 
 Sun, 16 Aug 2026 07:50:23 -0700 (PDT)
X-Received: by 2002:ac8:7fc4:0:b0:51c:1fd1:e755 with SMTP id
 d75a77b69052e-52d854dc9e7mr180564981cf.36.1786891823487; 
 Sun, 16 Aug 2026 07:50:23 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4815f219e12sm22753327f8f.10.2026.08.16.07.50.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 16 Aug 2026 07:50:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 31/56] hw/nmi: Remove @cpu_index argument from
 NMIClass::nmi_monitor_handler()
Date: Sun, 16 Aug 2026 16:45:30 +0200
Message-ID: <20260816144556.69009-32-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260816144556.69009-1-philmd@oss.qualcomm.com>
References: <20260816144556.69009-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE2MDExOCBTYWx0ZWRfX/YdiRvbDiYbD
 WqdhrpvZvfMQcRtOLOdENyKyHRkq96t6A/Imco+d3Fz3SSgXWKb0zfk0DjHKPUpeZ4B6I/Jh8RW
 gOfyaQOhFeHRY0g8XGDY47Tn1jRuNwY=
X-Proofpoint-ORIG-GUID: h_wqT950txo4kMVnj8yPej6nD2nSEWqM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE2MDExOCBTYWx0ZWRfX/SpHN51nXoSR
 JjSMG2QHapxKSNCUucKhZgTaJGrEmMu6vEN/Fbsg8TXsUyEQf9Bpy6zNr+Nt9rvSSNAOq9b9c72
 6h77o8clGObmRSsi/upGKx/qldrlIgE7PHeKkiURuMU3Zn9CyvLhdK5UoDEzVB30crH1QLdx5xq
 efuongdoiqKLbMu44Hyui/Kej7aaLg0eYlgDjq+So4GwwRvQ3tDevv7zlSCisC/vCwWz2KKH2u/
 l/++T37nXS+GXTDD8enX5ou+vezWM47389secp5HP54x6QbFqJm793ptnPDRnHL7F7ReabGpMQu
 NxPZR/3VOSmt6Md/95e0wtiUI7OoPDVrLMcPsRdlYLMw3bHvN0jRfaYbZMko9lXs4MHe6x+rE4P
 QaSpSOcAAnOehDeIBFoOabz6mEKQMlMcsvCuzrAFqSQo3wzrGh2q4z2Ww6VRPJJzoa6INUDZGNY
 WItRLfULdvo9OrYAZzg==
X-Authority-Analysis: v=2.4 cv=TMJ1jVla c=1 sm=1 tr=0 ts=6a81ce31 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=KKAkSRfTAAAA:8 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=KpD7k0r93PjNlcRUnYkA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: h_wqT950txo4kMVnj8yPej6nD2nSEWqM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 phishscore=0 clxscore=1015 bulkscore=0
 spamscore=0 suspectscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608160118
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
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20260812121232.71958-4-philmd@oss.qualcomm.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
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
index 7e284edd7d0..c376a588720 100644
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
index a2f373b1190..ac04245d65b 100644
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


