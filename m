Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77198C5CFC1
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 10:56:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtk9a-00018i-HU; Tue, 11 Aug 2026 06:56:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wtk8s-0000Sm-9u
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 06:55:34 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wtk8l-0000N0-IH
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 06:55:33 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67BAMXcc661416
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 10:55:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 bcgG1w08NZt/b36jhnBwiPFIYGpEfokKXu7wwwpAve4=; b=kMGS1SyqfocZjbQ9
 mIL3+LYXtMgCwzFUlaw+RyJV9zvVVqi21zCvkcvwXElo/v/O26YnGWIT4et43y5H
 TeXF14ogCA92lz8PRsSPa4wzfiitqI0Zc2B7l7wlDocDwfKe43/CSKP158gfFZPr
 saG31eAdnheVeNj5S5SpLtA07azEoSxYYKOf1AV8cChNnB+kTWtrSwG3Lk7u3VOw
 eW/Gce8BWeNPDuszd6LEc0OyunqT+/JQc194fqiP3oI1VV0HBNhMIkG65Wzj0Nuj
 r9+l7DNDfhmIyCdBDlqYLRHWBf9R3ggRCLOPOlHDSJXAQb7zBQC46PqwIPS7vIXA
 q4YsPg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fyjyfuntd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 10:55:15 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51c1a9764f0so4014141cf.1
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 03:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786445715; x=1787050515; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=bcgG1w08NZt/b36jhnBwiPFIYGpEfokKXu7wwwpAve4=;
 b=hDpPDnANtDRmUC8Ow1k9yiGak33xQzAfhuAedOTLzPFU0TkxUSMtj4m1OSXU5S+AhT
 PJh73RuSfsGNPq6b+dX+Q0vt3YAxpucM1SFiwor2kHG3+K9u6ZcqAg/FJCl7gyYYYEOF
 fbQqlbpmIMi74p3FgSR+K6x5t1tRYURVmWs+TUbcVdgf6WeXt0YnIXI6PYQxAnIBczCs
 +KBVTNbpOeR+h7P0gHDz4KXktNEO/h/Dkwagsqmz6/RbM+uuWtGVuVp3CUm8JmDfSF15
 a4YO8konHa5KvFG2kFjSoa2ridvpoWP+1j1Q1rFLc9nE4jN66dy6yoPgy0N8BIYaDaBP
 TOJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786445715; x=1787050515;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bcgG1w08NZt/b36jhnBwiPFIYGpEfokKXu7wwwpAve4=;
 b=LbaF7MmYsu8u/V+XvbrhARrMYz2pAcn3wTRCXhSyeUcVIC+ju0EglBfCh4/bFD9SSu
 yGaIfo6n/1jfEuj4b76cLOyF8Unmw592ng+i9jCq7CJtyVujLak2CbUz13UMNxs5dMTr
 ulMs9A3wxqorekpSGs4U/qHY+GM1J9wTXPjejKXtRQTge6BVdNW+A4X5WtIXHTgQlxzE
 8/qgdiWNiUZ3DTHVupLUWb4filYvBMToIqHkYQehH0wLrwxD9Rod3n9Q8Nca7R68Zjhv
 UpPLp8wJKjsKxxNS84H+T6mRR0H3KNCC8x5nf0QA7oqeQUvjcB7zsvh7gDzTi2UbCFBu
 fPXw==
X-Gm-Message-State: AOJu0YxeI2GwcVEEk5vTCyyrNEPtFq3L78lOiAgGUGl2Z9ySAaDbqnh2
 GSDrVk4DtBfsVBJvLqcw3yUuQIic3k6tiqaQt5JAlD9L+O2ob2SZAepxUPoqtcMN6gO7K79LnFi
 rxO7LdtvF+LFAq79NqLIRERwvXUXhAbqHarbgT5yvHD7Cz8KfCtpkl4Wtt/1ANfnRVw==
X-Gm-Gg: AR+sD12xDwZfwOn6FnXMuhNJZfFYdqPVdtZHYNA9CbrZvd6Dy8pXWpe+aPn57Yog3wL
 tTRxicyNx0Q0bVIoChZN29kv2dQOUS4x3ZKIleah4ccORgENsUAP7C+UCL552bjgBA9nFKXW6fi
 WlPDxdZIDkc9KS3ERfWXm33/ElyF+ZbEzwTh6x7Mp0RDXOKTz3fynoH8png/jHGMHTJ6rmjgGLb
 GOvQEEW3Ru/KB+AxMyjXhNyx8DJG3JHd1umQRQ2EdI0HDsTl26+gb6VISTFF9kcD+HvKziAraKs
 /8awKLepiiOlk8FUyIG5pb9PNw48ZMN6Ej1i5pUHqoOtEbk1060l0VreELijIuOgSa7WuWsV0oC
 MpgU8tdQN1PselwF5RIfJvtCSxHXvEZMXWkuqnsvMdnpfJq8=
X-Received: by 2002:ac8:6909:0:b0:51c:2022:cef5 with SMTP id
 d75a77b69052e-52d585d80d9mr17728521cf.26.1786445715320; 
 Tue, 11 Aug 2026 03:55:15 -0700 (PDT)
X-Received: by 2002:ac8:6909:0:b0:51c:2022:cef5 with SMTP id
 d75a77b69052e-52d585d80d9mr17728131cf.26.1786445714883; 
 Tue, 11 Aug 2026 03:55:14 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4814a5be110sm3639112f8f.10.2026.08.11.03.55.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 11 Aug 2026 03:55:14 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-s390x@nongnu.org, "Dr. David Alan Gilbert" <dave@treblig.org>,
 Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org,
 Corey Minyard <minyard@acm.org>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>, "Michael S. Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Nicholas Piggin <npiggin@gmail.com>, Aditya Gupta <adityag@linux.ibm.com>,
 Glenn Miles <milesg@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>
Subject: [PATCH v3 6/7] hw/nmi: Remove unused @errp argument from deliver_nmi()
Date: Tue, 11 Aug 2026 12:54:24 +0200
Message-ID: <20260811105425.7429-7-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260811105425.7429-1-philmd@oss.qualcomm.com>
References: <20260811105425.7429-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 2GlorfXjnKuzxRGBR3vcsXR6rM2ZwdyO
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDA5MCBTYWx0ZWRfX6Pup8UE+hQP4
 GCjaZuAuWV5jUhqfvNtw43sYBi012LpykPDoNee8fH+l6WCqITrERul18aHoKnxVLWeDqxVY36P
 j8YM54yPdhlys2j9sFPJysYtDsEYBvM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDA5MCBTYWx0ZWRfX0zOPwrqs9mm2
 +w0E032rUi9GDwMBA6gsMsymMzoAgImRdKsFBlxPZqALHI08q3PyKK8xL2SX2ktz5YRdTpY0Nil
 kgv+xt+vsnvkCmPWx22akSCYq1wrkApqOPCxdjJizilJWxjPhTV5eq74ag76nA/1kL2xuE5nvpC
 8ifIA8wL7rmUbgyxnTst6yMcu351UhXM1yW2GuJ/BXK4pF7LYj3p6XoXdoEov+6L+g5HYF23Eb9
 TpQqEz8gobbYEyA756/+s7O05BNkrf3UzDLiH/HEcJXy9f06jVBS7Oy3FYpiacsBIqx397SXo3n
 TkZifX0NDFggfapCZcubjX5GwGexQ9+uhyW3CJXrxiXv89NV3X13GxIJQ5UlixcFb7iP/nXhpkd
 j8yn+wc6iB74GL3d4dZj++esAWMx/u9LN6H7LN2Su0HgoWMm+E5TDnU4slxOKHGvZJo849PAPmZ
 yrf1jhRUETSR5eq1hWA==
X-Proofpoint-GUID: 2GlorfXjnKuzxRGBR3vcsXR6rM2ZwdyO
X-Authority-Analysis: v=2.4 cv=Zd4t8MVA c=1 sm=1 tr=0 ts=6a7aff93 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=799TcV0OOjXjlcq3EAkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_01,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 malwarescore=0 suspectscore=0 adultscore=0
 priorityscore=1501 spamscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608110090
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

Not a single handler update @errp. The single user is
nmi_trigger() filling with "machine does not provide NMIs".
Remove the unused argument from the deliver_nmi() callback,
simplifying the methods in hw/core/nmi.c.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
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
index d6bd2a9fceb..b0f58542bcc 100644
--- a/include/hw/core/nmi.h
+++ b/include/hw/core/nmi.h
@@ -41,9 +41,8 @@ struct NMIClass {
      * deliver_nmi: Callback to handle NMI notifications.
      *
      * @ns: Class #NMIState state
-     * @errp: pointer to error object
      */
-    void (*deliver_nmi)(NMIState *ns, Error **errp);
+    void (*deliver_nmi)(NMIState *ns);
 };
 
 /**
diff --git a/hw/core/nmi.c b/hw/core/nmi.c
index 02c0ff2c21d..8eea75ad530 100644
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
-        nc->deliver_nmi(n, &ns->err);
-        if (ns->err) {
-            return -1;
-        }
+        *handled = true;
+        NMI_GET_CLASS(n)->deliver_nmi(n);
     }
 
     return 0;
 }
 
-static int nmi_children(Object *o, struct do_nmi_s *ns)
-{
-    return object_child_foreach_recursive(o, do_nmi, ns);
-}
-
 bool nmi_trigger(Error **errp)
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
index 47e0302bac8..51ecdabdbd5 100644
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
index 48f7575895a..8d82bd890da 100644
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
index 281542e3997..b78ca5ca11b 100644
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
index b75f7f44d3c..8be7696777e 100644
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
index 086d90f20b6..ba4df62c674 100644
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
index bfb1d45d058..2ec0c198fa5 100644
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
index ed545acf3c0..477054d8c85 100644
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
index f9e8ecb4fe0..255698fd7ed 100644
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


