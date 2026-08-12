Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84F38C5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 12:13:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu7pk-00075Y-Q4; Wed, 12 Aug 2026 08:13:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wu7ph-00075B-Jq
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 08:13:21 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wu7pf-0007aP-64
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 08:13:21 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67CB4JDV2860087
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 12:13:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ZzR+XR+yKsgN+SuwZnPqfhvWy3kpezZnGAUbKXQNob4=; b=VYk98RrcD/UA+sl1
 5wAZLjMpu8w8GwFwkMeXVCxJ6aXxq20rC6nV6hRppz+af9KoQoR9VPfT3iqhfyJO
 VeBHP4szy2fk5OIxHRq73Z0uUHylYJ8f/yo7ovcpUhq5mM66GnbF13Jbd5kW/a5c
 4YNSiwDSSBpQyOnBw0uoLQxWXZ2F5Ix30jeaVa2H5uNf9GK0LQ1LY5BtABvVeu2i
 Cal4W2leTjfByuPUqytNdMGz9KPT1+Q0/Xd74vzWnGBcP/uFeD3BGEE2s9ZhkIFz
 Y1PMEHSbul7Xu0DN90EFlH8m2tg5fk50OFkQn/sx1YYvY0v7if3tCpV6iyByBNMs
 vHYC1Q==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g0mnd8yyh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 12:13:17 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-8e934385db1so11092766d6.0
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 05:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786536797; x=1787141597; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZzR+XR+yKsgN+SuwZnPqfhvWy3kpezZnGAUbKXQNob4=;
 b=Nz0KbLcMJYjUTM+Ty5OTCA4M8NQXO41A8A/MeMayiUYh4MXkXFyv+KHjVqs9JanFKo
 02vOZHOHkYxIsfMKpvVy/uWfcMom2V1fFo4JmthXNMZ7PhTJTR/14XDYpmy7ley6VW9d
 kO12yXx8sdHV8Zj9/Gqx388g/Q8GTNGp+ttK2ROb/8PlHA4E0BYphyYg33sSszOim2ck
 QQLJrqls80Zw8hA6M3qonOFQ5Xot5P9eeBRYbxzrd9jy1gQyYv0VZszGoX2izLSjbwlL
 E+EbPgQ095LBrUkj6yWIe0kLTnrazuTZHZJ8fJuBsrys7M1jFrubOQybalGoZnwbNeJv
 Nb9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786536797; x=1787141597;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZzR+XR+yKsgN+SuwZnPqfhvWy3kpezZnGAUbKXQNob4=;
 b=ZSLROdEsOcUrmUCehK8oHpP1lTecHW0dTiFallG4x7ey9JreeH6D7b8EBEjAg8f/sG
 Gz9Y4rb9z73B1sGxOknpbtVoYUqUiJe/6lKr2yN4IMr7KjfKf1mjjbx9bi8SLyUv9lb0
 YhmehlgJgHKcRNY7JMYWDPDJhp89SeEa8uUO+GfyVzn5P8ytMm10F9+OyMfk6pzd94Dh
 cix7hhd7TETMVBL8wGi/843GKhbszgJMu3bMGjHZuWFjKcnbZukJWqI7XgxijQOXGVQn
 w6ffsmZIlzZVZGYjoZSID5l6MxqgGEpCF6XDjUR6s/nJpXjukJVWy1v56lmBTU/U1GX0
 4Z+Q==
X-Gm-Message-State: AOJu0YzIYpin7m1kdFYb+oQXwIX0PRx2MMipxT+mUKWU4ra6zojrS5ej
 3Uk95yg4leptbM4W8Owxo1SMUFmVU8zu2egnKzBrVWiutUzZyUqSsKFNZ2O3xUyEmNZxU3ZIg0C
 xb1pSoJJLu+oxI6Zlh3r+7s2FhnUpRe8iZXjqfVS9CRsZKsqbU+Nq0esN5UDDHwSiIQ==
X-Gm-Gg: AR+sD10j1/yO5tcvaCKxiExapk7b2HWw0sS1xsY2h9vx4I22AlWFI4pTf2I3UaOO0F+
 61RMT9mW6MQu8dQisflv4DoWPKU18EjfyiDCD9cH52DGl3QhvTUzrPJGsqk2m6KUtd39vIwZXGT
 6Bh8s5QQs1s+bsMOvWC5agxnmOVNh11ib4GqdBcJxtMWeFLsrPh/IMHvLJOTGSIHbyR9iWmPmTh
 ag1qOGGqgZ/eLje0/kaiirMv+fMOYjZ9rAUUZsyJY4IZvPibTRHpdagZUWAWyH1bhQPnjFHA42t
 doHRBSan0fg2Y0Fd0LWrDByt6uixb93z/FoT8MAW6P2BW8dwmGMRkLEZYfkhuyFNMRdsf+FIWus
 OlBFTOUAVthfhQcCEc5rJcLvCuGjSmS1pWW1FDdZ7oQ==
X-Received: by 2002:ac8:5852:0:b0:51c:22c5:daee with SMTP id
 d75a77b69052e-52d64832821mr33401641cf.29.1786536796700; 
 Wed, 12 Aug 2026 05:13:16 -0700 (PDT)
X-Received: by 2002:ac8:5852:0:b0:51c:22c5:daee with SMTP id
 d75a77b69052e-52d64832821mr33401121cf.29.1786536796140; 
 Wed, 12 Aug 2026 05:13:16 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4997aaaecabsm72646945e9.5.2026.08.12.05.13.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 12 Aug 2026 05:13:15 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 6/7] hw/nmi: Remove unused @errp argument from raise_nmi()
Date: Wed, 12 Aug 2026 14:12:31 +0200
Message-ID: <20260812121232.71958-7-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812121232.71958-1-philmd@oss.qualcomm.com>
References: <20260812121232.71958-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDA5OSBTYWx0ZWRfX8s5WOUpQbWI+
 mML8RdrdCDsdROLN3F+xA8q9lO5BZuU5xwtefOarNiaJJoAj2kiZjwv8i8DY0t4LLzFPAeQLs7i
 uRrRK+oC7CoNxbj/4V/WCE2hD1D/9WI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDA5OSBTYWx0ZWRfX4tDzrBqtDwYe
 x+fG8B8lWzF4238ngvDzGq/2Duf2DjB6cvY+rfSWEDMO51V/yl1VtkGBNtWodHHzc/7ym72Th0f
 6JyodCwnH89Gd0056qkPgpfV5Xv+xnH5sgF5qI/6lWQLu/mmToe70hv1p7xTOyGt2b3oLjx748C
 qhM+qLn3z/VMpY8yCknN42OfM2IdmKOJA5/rEFX32F+nePdgFxhT0dvkewGzMVEi7YkagltkmVI
 6t4bqFg7EMElRMM0/Qtu5AL5UvpvncW8pzBwO8wxJPnMGDCTwuBmN8bKAYdUl5i0i5P47svX7BD
 AQDct+8sd1EvOJnjUQcr1o0Rzuq84+5OROfVqF5LVTVuloLl/bA/G/EUmJ63/P8CRc5jYR72qDa
 S1fAcoPjQQaXeZ+aA0a0/m1W9AVVPE33LSUp5F+xWbLQErnrUzsnu37l0TGOScba9JkyFXL61Gv
 WepfPvAzZ/TY2AXEB4Q==
X-Proofpoint-GUID: oBnrH1ppLLP9FdjC39mr4z-v1Vo_Xhd6
X-Authority-Analysis: v=2.4 cv=C87ZDwP+ c=1 sm=1 tr=0 ts=6a7c635d cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=so-psXbHftmeYDB8DEMA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-ORIG-GUID: oBnrH1ppLLP9FdjC39mr4z-v1Vo_Xhd6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 spamscore=0
 clxscore=1015 priorityscore=1501 bulkscore=0 adultscore=0 malwarescore=0
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

Not a single handler update @errp. The single user is
nmi_inject() filling with "machine does not provide NMIs".
Remove the unused argument from the raise_nmi() callback,
simplifying the methods in hw/core/nmi.c.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
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
index ad571481c44..e0678156e73 100644
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
index a59346a2120..c1ce7825650 100644
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


