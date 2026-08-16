Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20D18C5B572
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2026 14:51:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvcCR-00033r-8z; Sun, 16 Aug 2026 10:50:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvcCP-0002ol-1r
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 10:50:57 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvcCL-0001fx-J2
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 10:50:56 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67GDkkFM2760249
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 14:50:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 vBD/qH2HrRdyEfxFb3mpRVBEwoXoeUz72F8VXcHmGwk=; b=I8kRp0YgdFB6BnEo
 RriSf4uolTUDSMWKk7ZmRPEToxtErVLrrmVEA+e+6Xe4M9cAwrENxn7B53gQ18/s
 +/P7uwp40CHyfq3xNKEx9k4CNqdXWLhZ23kOblwr8ZPjGkPS6Eh16HTAG2M4JOVS
 nJoOiRNcJ1rgnf9SQ2CAAEduuO+Pdr3jUmlNJMGLp6pb5kZqiHpS3SOdr7cTqhG+
 qKU90RybF6kB4t30e/q+PuvbWnDv+6bNUbdGDMAWpOrzjQEZDG5MqVo1PIOMOtad
 aFYTX9yxg47BVnGM/9QGOaK4T0/zpt0ls51gxeeXEDGgZLvk12hTModznIHiY+Rb
 DSR2zQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g2h9gkh7j-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 14:50:49 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-5283df62d68so30333381cf.0
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 07:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786891849; x=1787496649; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vBD/qH2HrRdyEfxFb3mpRVBEwoXoeUz72F8VXcHmGwk=;
 b=BN7h/q3QfNWlQDHnTA73B+fHpn52lIFd7LvycRzdcNh1x/ajZm/jv7yi7IGWHAsCTO
 eqlKD9r+NnO65PYhsUkuw/oH/lgGaUaxFSN2U2WhRHeqbqXTZEG3Xit/rwy96pjnnDyu
 sz2OhsQblcB4ez3ia8zRlSzjcDFJYOm900v1DCaE8h/lpOFSbdxQKDv/vj0Fam/wvKJj
 ykk3ngUZNDPOUO7jWSnl1vlvs9KB2rCSlq133iLWbZAgNTjvjU3wINMw3x2OX9qrb4mD
 yLg75cNhjqLiggGqvlZ0GkgmAYr/InmZlw+6CjZFXpMAd8VUUcUpz+piYO8lb44DcBYu
 AveA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786891849; x=1787496649;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vBD/qH2HrRdyEfxFb3mpRVBEwoXoeUz72F8VXcHmGwk=;
 b=fBrCbs8KE+meWlnU+d3RibBxj56paDLbloxmZfybViqygD8HM7LbvIZGgfgxGlpF1/
 ODLf7NHHkcIJv3SXD027w5urWvfklCgSj4hpSL+eGKlPhJy0/TTpjZG/j8B3v6vLKBlW
 8gjkYzqcrpOcoy9B172t86dSpcv8SwZIjMx/MeaNvADxVfmNPtrVruUGKMmoWgdXlVWv
 HlZWiPewIVzwCCVHrYk5gvcBPKdFe73gjjSKem4I3AKVmlc4cc2qHXtd2qw5KlOxazEd
 yKXzDq5GkDSMEji7PsOWxQwPuFk9TYy6hRg4O4N3ypgdzl+doVi91fp01u0AJ0hxHm7X
 K6Rw==
X-Gm-Message-State: AOJu0YyypZ1TcLF2pYzogFnXuOnMQrpIFPzhNEotjAiiHE42d50vP+EC
 oTM7QvfZ1tQv84KaMZWD2Idjh+/SJ2AtqdsjKT1IN3qAkSocn0Pdp4KzesbYaxa5b10YLJLNCGu
 awoWXnoxgBSEYWfcAuWWqfcFPgIp/c2rq3e8Kr6SLIFe2pKX0uCwm/TSB9w5xfJUqJg==
X-Gm-Gg: AR+sD123Moaumxr8RZBjwR0IbDxQa7kS+NLRh+gmbcLQEJDcBczfy06npNb4immsk9u
 oXwZh+eBNvhFc3oRhvsAhabN+UeCcx1UEFsSIZqXvG4ktbITFJL8nPgBsf31QYiJECaVRgRRH3B
 Dq0565/mz4I0tANYHwH4QA7RvXPYaIh5Etxdrlzw/Rck4gWmJwAPFk6HXRdRShBS3w6vCTlq/YN
 Yjh7b/Mw4h7nvXpyRiF8G01P4zH3BWLvP83ZvBQf/HSz5c4NEWRsBlohSEzXIJrxpVu3PfQJD4x
 H0u8Z8r1xItRWSoRJE3/5vTxYREG9xjT7yMX9exxmJwOehv6cWH32u2rYAsQ2/mViiHmnX5ssU6
 IG6EHWagaoDMRTCV9wXjiR1ljnK9kJrN7k9sNlgDS7g==
X-Received: by 2002:a05:622a:64f:b0:51c:f3:34e3 with SMTP id
 d75a77b69052e-52d854d42camr198088891cf.28.1786891848778; 
 Sun, 16 Aug 2026 07:50:48 -0700 (PDT)
X-Received: by 2002:a05:622a:64f:b0:51c:f3:34e3 with SMTP id
 d75a77b69052e-52d854d42camr198088411cf.28.1786891848087; 
 Sun, 16 Aug 2026 07:50:48 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4815f2c07d2sm24459004f8f.30.2026.08.16.07.50.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 16 Aug 2026 07:50:47 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 34/56] hw/nmi: Remove unused @errp argument from raise_nmi()
Date: Sun, 16 Aug 2026 16:45:33 +0200
Message-ID: <20260816144556.69009-35-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260816144556.69009-1-philmd@oss.qualcomm.com>
References: <20260816144556.69009-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: K-A-LhQjxIoYa8USWLkAfovma-ifzjxQ
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE2MDExOCBTYWx0ZWRfXwePjKUNhYgFE
 Gj2aZ3T/JECbcXBFQM5C15aIgrl96f54J5oqCgrCqw8DZUDXJx1Uzncd6gRmJCWBWPdvHdm96gg
 sxqdWp4ViJJDZjaUyFCHZ4RawWAgzyA=
X-Proofpoint-GUID: K-A-LhQjxIoYa8USWLkAfovma-ifzjxQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE2MDExOCBTYWx0ZWRfX+mlhI+SFXwUQ
 fsEU6xsosEU3UUrLq+NNy7/o4e22Cx3eAi6py2QjocmC8nHaj4B2NVa6riUa2T0paesogZADyg3
 GtKyLK1vZyqXRgrjcowMdmqBHdmpCgilYR+x5A5opnk+EXC2BXUmVmnUvFP08izJkWxddYXzZ6n
 pdkHI5Qlu4eFXCMS8e8H7VcX+WmZGF8P493/JF1ZK/s6ugzQK3vPxw/KtyQbS9c03Tdz+dKJBfx
 DoR63PJOFu9E1rMMI7UBlNFKoNLae4VNuNoyJgKYRva/23UaSvnBdznb2yZogSQpP9CM5BmSdVT
 kR0uP8dokErX1o/LIoHwDN9ZSdgxC8Y8zndbbD8m49lohXOSuRAUzHVl3p9/Da0QjKKTkApEYDQ
 f8CSGufkA5TalqvoFfOFZUsciXK+C47hXM3RDkK4CVVxOAoX801GChWzqHJrbuI6rCsLDgMaKnh
 CVzrflrG+4n1wF7juIQ==
X-Authority-Analysis: v=2.4 cv=XM4AjwhE c=1 sm=1 tr=0 ts=6a81ce49 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=so-psXbHftmeYDB8DEMA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0 phishscore=0
 priorityscore=1501 clxscore=1015 malwarescore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608160118
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

Not a single handler update @errp. The single user is
nmi_inject() filling with "machine does not provide NMIs".
Remove the unused argument from the raise_nmi() callback,
simplifying the methods in hw/core/nmi.c.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20260812121232.71958-7-philmd@oss.qualcomm.com>
---
 include/hw/core/nmi.h      |  3 +--
 hw/core/nmi.c              | 32 ++++++--------------------------
 hw/hppa/machine.c          |  2 +-
 hw/i386/x86.c              |  2 +-
 hw/intc/m68k_irqc.c        |  2 +-
 hw/m68k/q800-glue.c        |  2 +-
 hw/misc/macio/gpio.c       |  2 +-
 hw/ppc/pnv.c               |  2 +-
 hw/ppc/spapr.c             |  2 +-
 hw/s390x/s390-virtio-ccw.c |  2 +-
 10 files changed, 15 insertions(+), 36 deletions(-)

diff --git a/include/hw/core/nmi.h b/include/hw/core/nmi.h
index a8feac3b67e..d71d92dfbb9 100644
--- a/include/hw/core/nmi.h
+++ b/include/hw/core/nmi.h
@@ -40,12 +40,11 @@ struct NMIClass {
     /**
      * raise_nmi: Callback to handle NMI notifications.
      * @ns: Class #NMIState state
-     * @errp: pointer to error object
      *
      * Called by nmi_inject() to perform the machine-specific
      * action when a NMI is requested.
      */
-    void (*raise_nmi)(NMIState *ns, Error **errp);
+    void (*raise_nmi)(NMIState *ns);
 };
 
 /**
diff --git a/hw/core/nmi.c b/hw/core/nmi.c
index a6edf4fbf01..c44b0cf892d 100644
--- a/hw/core/nmi.c
+++ b/hw/core/nmi.c
@@ -23,45 +23,25 @@
 #include "hw/core/nmi.h"
 #include "qapi/error.h"
 
-struct do_nmi_s {
-    Error *err;
-    bool handled;
-};
-
 static int do_nmi(Object *o, void *opaque)
 {
-    struct do_nmi_s *ns = opaque;
+    bool *handled = opaque;
     NMIState *n = (NMIState *) object_dynamic_cast(o, TYPE_NMI);
 
     if (n) {
-        NMIClass *nc = NMI_GET_CLASS(n);
-
-        ns->handled = true;
-        nc->raise_nmi(n, &ns->err);
-        if (ns->err) {
-            return -1;
-        }
+        *handled = true;
+        NMI_GET_CLASS(n)->raise_nmi(n);
     }
 
     return 0;
 }
 
-static int nmi_children(Object *o, struct do_nmi_s *ns)
-{
-    return object_child_foreach_recursive(o, do_nmi, ns);
-}
-
 bool nmi_inject(Error **errp)
 {
-    struct do_nmi_s ns = {
-        .err = NULL,
-        .handled = false
-    };
+    bool handled = false;
 
-    if (nmi_children(object_get_root(), &ns)) {
-        error_propagate(errp, ns.err);
-        return false;
-    } else if (!ns.handled) {
+    object_child_foreach_recursive(object_get_root(), do_nmi, &handled);
+    if (!handled) {
         error_setg(errp, "machine does not provide NMIs");
         return false;
     }
diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index 717cfde61da..98931481b20 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -829,7 +829,7 @@ static void hppa_machine_reset(MachineState *ms, ResetType type)
     cpu[0]->env.cmdline_or_bootorder = 'c';
 }
 
-static void hppa_nmi(NMIState *ns, Error **errp)
+static void hppa_nmi(NMIState *ns)
 {
     CPUState *cs;
 
diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index d1414ff63db..f8ba3244e22 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -147,7 +147,7 @@ static const CPUArchIdList *x86_possible_cpu_arch_ids(MachineState *ms)
     return ms->possible_cpus;
 }
 
-static void x86_nmi(NMIState *ns, Error **errp)
+static void x86_nmi(NMIState *ns)
 {
     /* cpu index isn't used */
     CPUState *cs;
diff --git a/hw/intc/m68k_irqc.c b/hw/intc/m68k_irqc.c
index 29f758dafd1..47f626c0fa0 100644
--- a/hw/intc/m68k_irqc.c
+++ b/hw/intc/m68k_irqc.c
@@ -70,7 +70,7 @@ static void m68k_irqc_instance_init(Object *obj)
     qdev_init_gpio_in(DEVICE(obj), m68k_set_irq, M68K_IRQC_LEVEL_NUM);
 }
 
-static void m68k_nmi(NMIState *n, Error **errp)
+static void m68k_nmi(NMIState *n)
 {
     m68k_set_irq(n, M68K_IRQC_LEVEL_7, 1);
 }
diff --git a/hw/m68k/q800-glue.c b/hw/m68k/q800-glue.c
index 265af90a8e6..223e7d9019c 100644
--- a/hw/m68k/q800-glue.c
+++ b/hw/m68k/q800-glue.c
@@ -159,7 +159,7 @@ static void glue_auxmode_set_irq(void *opaque, int irq, int level)
     s->auxmode = level;
 }
 
-static void glue_nmi(NMIState *n, Error **errp)
+static void glue_nmi(NMIState *n)
 {
     GLUEState *s = GLUE(n);
 
diff --git a/hw/misc/macio/gpio.c b/hw/misc/macio/gpio.c
index db0c4ecb3cf..ba001f7b206 100644
--- a/hw/misc/macio/gpio.c
+++ b/hw/misc/macio/gpio.c
@@ -188,7 +188,7 @@ static void macio_gpio_reset(DeviceState *dev)
     macio_set_gpio(s, 1, true);
 }
 
-static void macio_gpio_nmi(NMIState *n, Error **errp)
+static void macio_gpio_nmi(NMIState *n)
 {
     macio_set_gpio(MACIO_GPIO(n), 9, true);
     macio_set_gpio(MACIO_GPIO(n), 9, false);
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index a9f74245866..f0413639f98 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -3552,7 +3552,7 @@ static void pnv_cpu_do_nmi(PnvChip *chip, PowerPCCPU *cpu, void *opaque)
     async_run_on_cpu(CPU(cpu), pnv_cpu_do_nmi_on_cpu, RUN_ON_CPU_HOST_INT(0));
 }
 
-static void pnv_nmi(NMIState *ns, Error **errp)
+static void pnv_nmi(NMIState *ns)
 {
     PnvMachineState *pnv = PNV_MACHINE(qdev_get_machine());
     int i;
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 1bc90ceed35..20e024907b1 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3550,7 +3550,7 @@ void spapr_do_system_reset_on_cpu(CPUState *cs, run_on_cpu_data arg)
     }
 }
 
-static void spapr_nmi(NMIState *ns, Error **errp)
+static void spapr_nmi(NMIState *ns)
 {
     CPUState *cs;
 
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 21d9f51ddcc..06e5def9092 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -725,7 +725,7 @@ static HotplugHandler *s390_get_hotplug_handler(MachineState *machine,
     return NULL;
 }
 
-static void s390_nmi(NMIState *ns, Error **errp)
+static void s390_nmi(NMIState *ns)
 {
     s390_cpu_restart(S390_CPU(first_cpu));
 }
-- 
2.53.0


