Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C624AC5B56A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 16:11:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtp4G-0001vF-NI; Tue, 11 Aug 2026 12:11:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wtp4E-0001uE-OM
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 12:11:06 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wtp42-0002Gf-9O
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 12:11:05 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67BDWjAM1317223
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 15:49:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 jqAk9IvSPfgz7bsMCJKg5NL2Zwfd00WMYGreeaB3SyY=; b=XdVOrhgZckSHPI6x
 A2uXAv5dGDDzonxiq1o75SQmdhi1oYqTgKEG4dykAyXtsixQAuTrlnwvTECRKnAq
 5ozqGqLkTVQdQNVfW+dDmIsMRGmpCrzPNZ4H0nSxSuTjQOWlwVVnRO1IvcmVau10
 Zlx5MxR1Xw/jc5RX8EE/8Hpfy2obJeb+70GUoCM4mxbi1kV/nP6kct13u2F82+z2
 0n1gYZbA4Y8YemB/9IMsUFIwIg2KvMZCxBaANhS3kDcV1AnXdXknutVMMhxU7I++
 YT31i0/PTK2C2yIn4FcsJH2TS6/0gXz81Hdyx91c5xQXZO26jDCQhCd8kMAuCavY
 RGGYag==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fyqmk3jv5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 15:49:58 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51c1d137a68so813301cf.3
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 08:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786463397; x=1787068197; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=jqAk9IvSPfgz7bsMCJKg5NL2Zwfd00WMYGreeaB3SyY=;
 b=FE2JRhtFhXsdnj7Bz5HU+cP7pRLabKdtn3ZsD2NEhmvpIIQcv/M1UBOtkavpFeAyIr
 rGdvQv4eo2BnEcPwzIqpn5G73ucPLbdI4b4hxY+uvVlcHvAGNPRghuj5zuKctd0TOxPu
 /s6l2ckw5SPtHhTUe/GfBjefCbE5MI6EYWNKcGY5RrNrAmIOsYKKHCQf9DsJK8VjUNDt
 OJqtB0hbk2CgyA1qm17p9ji39uygG7O3NGC/mBCapJdWuf7EcMur0Y5SAe6rzhcinzUY
 kqDhd84t7HJY9Ox5yKBzA0Fjqd1lkxdtaqdkh5+v5WTkBe8oCkMm8ID8usZSmtq/RmC4
 QUeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786463397; x=1787068197;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jqAk9IvSPfgz7bsMCJKg5NL2Zwfd00WMYGreeaB3SyY=;
 b=RMVIWcAeD46fiiPv3knigtT2q3VqMeGsOKTWzUYxLePcn3gGJAYsjhqH/eSGNbwa2c
 dwxQIofQ6JGnqAB5+sobMkjro389VaY9SfR1TkzicSiUdwDxI2qbilCZ+Nw6ZEhn+4eW
 vAMNqVjIVmYYXPPcd52azDvGHlpY8B+elgO7Dn+azvpG21oZ9sQ4zIcYVG7ucb5kDKhN
 xgfEvkDQMDKai0ikFtV18wfpUm73Gz9vrquXMinyGsqHJKV+EyXKZUp1s3gTmPb5PbMM
 wdPCf2jVoZLlzWVLINobrmw3ufEG5iRGtCAxW/63wsNmQgg7l1/smoKWFzmR2gxQRX/D
 qweA==
X-Gm-Message-State: AOJu0YzMBMzQWdLivHZlXvDQYgxZJiSEvJxZhGKylC5FtigZJe+RQ7YF
 uiMRLL52Y1w5T84bOfkoLpMlUFi9dk6MyrLMdzcxIVh00Eyd+EDFgRb2nc/Uo9W9/JL9QLbP+ND
 3/BHwgBJBwVMWJDr7xZS5A+kw+Ul+YEF1xXxNixWm5hy12N4Yj/XvRmnVUNOYUOvW3w==
X-Gm-Gg: AR+sD11vt41Fyq9jPZQSa8L588BhEx9zv1DXB5WTWRPzI2gkzkbspFHgqaTGh2Og6Lv
 OBour6F4PpBnSp/N4UbZdwFgW1SMta+AGkkD052XDhd5DGGrM0pVckH2hOWsLYIQlOtHp5zcZkt
 CMwoLSB5nAA+xE6erVG8dvuzvVvLScE1Ht0xlqODP0ksAy6Hbow4dwXsWvqwr1VMqAO+iawutZs
 G6IorljPiH8CA7KPmuZrDFqsIuYIHHzrcexhiCktcv0ECzETbW91YE/Ie/KrqN3CPpkRx0gMtZM
 JOvTaKgkuv2tPBk/1JJikN+lHjTSsLNLYvkhny00O2uzZ239816RulGooWI48PiUKKgKyIAXkX1
 yVlsjoT2hsM/qjBQRo3e+EVOcpocivA1KGA9PAPCeWQ==
X-Received: by 2002:ac8:7d53:0:b0:52d:354c:5b91 with SMTP id
 d75a77b69052e-52d58500711mr37561751cf.16.1786463397445; 
 Tue, 11 Aug 2026 08:49:57 -0700 (PDT)
X-Received: by 2002:ac8:7d53:0:b0:52d:354c:5b91 with SMTP id
 d75a77b69052e-52d58500711mr37561231cf.16.1786463396871; 
 Tue, 11 Aug 2026 08:49:56 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4814a70976csm5176021f8f.19.2026.08.11.08.49.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 11 Aug 2026 08:49:56 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Corey Minyard <minyard@acm.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>, "Michael S. Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Nicholas Piggin <npiggin@gmail.com>, Aditya Gupta <adityag@linux.ibm.com>,
 Glenn Miles <milesg@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Subject: [PATCH v4 3/7] hw/nmi: Remove @cpu_index argument from
 NMIClass::nmi_monitor_handler()
Date: Tue, 11 Aug 2026 17:49:26 +0200
Message-ID: <20260811154930.13915-4-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260811154930.13915-1-philmd@oss.qualcomm.com>
References: <20260811154930.13915-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDEzMiBTYWx0ZWRfX43eiSHk95cpA
 nBeBCUrBz3G80Ot5J8Yvc20RVmE/jymvhtOeFr/uLCYq1UxM4+BWTtxGhxN8r2O9qdoR79RXVcR
 qd1+t0J+75aDZX8qEDHP2C3C/fhXOcv26u0LoYr35GAtfY5KpqOk/VoUWjftsdRqdN3icpnjOLz
 MMurU7H9q69T9XtrOwegKmHDgdRPdtA4yhb398aY1zU9YoOuGonRx8ZYm0F2jVrX92ecw8eHgMl
 IidIJS5BhUkfjRzdS7btYmjs2bxWMrmiFYHxp1FXIOxOQCcfs/5XHSydUct3FHAiz1l1s4LqVul
 W/io09Uupx77vgIyPoQAYUsm2rZpxoRKzSyJl75DdUwXsVRxv+IIPNeVJpCl91Tj9EtAVj1AmC6
 UzTUXmTHJjb74VspzyI7EC7K2TW2/Bx09/PlgzRemhUmbUe2/Cjsm6dHH12+a5qLKXHHx3bL0zh
 WwQKEQbDUHWbdvMWFMg==
X-Authority-Analysis: v=2.4 cv=O4YJeh9W c=1 sm=1 tr=0 ts=6a7b44a6 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=KpD7k0r93PjNlcRUnYkA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDEzMiBTYWx0ZWRfX41O270SUVvWM
 l6aN+m4VMilmtKI6e9RY3hYutnjGOxZ4LHwfspAdIHeAPMQBTdNiS1wK84qsZefivd1FmohtZmj
 3qzXMsxrl8P1j/McKP/4yutoi6qs2kI=
X-Proofpoint-GUID: 53bzyR-uygKjAv7DNkraKzcxGd3YTI5T
X-Proofpoint-ORIG-GUID: 53bzyR-uygKjAv7DNkraKzcxGd3YTI5T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_03,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0
 priorityscore=1501 suspectscore=0 spamscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608110132
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


