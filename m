Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64595C5B572
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 15:51:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtokJ-0003Q4-51; Tue, 11 Aug 2026 11:50:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wtokG-0003Om-Vc
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 11:50:28 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wtokB-0002pv-DM
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 11:50:28 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67BDX7Q5694276
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 15:50:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 x57BgP3ZuV25AGgYimgmWz0gswBw1JGdpZFwZdSIK+M=; b=SQ0Mq6QcM/b9JjLq
 5A4Xa7VosO8vmvSeuczpIAlER1OyyM9ctiHgac5eAVkcpd++zFzEhsa+TwNJdPXf
 iaY3F5vPb52QBRJbLJ0sGrNIF7NeSoyUvQpoGgXZ4RgDKpNFjAp0cPow0k1XSnET
 avjxktrSjz1L5XI77t3JeBc4fbkY48IgCFmQqV/XWDSuE1e2KIv2Ybhm7ZQ2kcyK
 0xVRXUOyZr7RIgSQc8Xw1D5qSqO9Znj/Xb3VIHgyTWAKfvd3g5hO6J3TcrIYiPBk
 hlkmKY4YjBcfzLaWJKQe1xMNgxJloZsJwtrSKYbXRxR94qAgm0I0kBfDb9dYLf33
 twDo4A==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g049grt06-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 15:50:21 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-52827090cc5so313001cf.0
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 08:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786463421; x=1787068221; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=x57BgP3ZuV25AGgYimgmWz0gswBw1JGdpZFwZdSIK+M=;
 b=gC6OSVGcjpGYc3BU/1ujPcW+vfOYb6PIYwzxwwwYCjpbFidULJsQFI0t5BnF8ebp2o
 cT7aD8ptf8IO5ZmoZ0H7p/vUB5EIrLrC/27Um1VKmNLkAEiEcun8Y8aVG7buGMgtQZ89
 7lAxKD85K5xxrG4FbDfpO9aUyPHmLa2o5vskLFHU2LSLhOmTTSls8VHyiZObAAAou4bz
 K8klKz1FEi4sY3JlxmxjfwWPwXnw2v3SUXVoo50fjBgcKutLKcIxgal+Qqi0bxUGdoVU
 s+U/OQ/9+DHrfeq3mkw4hrbNzbR/l3MfxsOZSA2sq6iqpKJmBQG+48DuOO8h1P9FyiGl
 xCIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786463421; x=1787068221;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=x57BgP3ZuV25AGgYimgmWz0gswBw1JGdpZFwZdSIK+M=;
 b=tWCFQPh3x7UyHu8vOxjSw9p8vkO5HagzuQq5n1Q2BcxRAsleJnxDx+umCHB2dwqbFP
 +KYDMFRP8WUVjcBPZykYTjEsZzgYEVpiS0ZNs2tmph5WArlhwCxayrszkcghlUMsvTnb
 eUvx+1/hQ0JBBS1yEAw/3I6Iy4OFpL6SuYxiUeeLavZa2Cq/wuY/8BoT9mQJxq0mc2KA
 IzOEJmftfZ6boJBl6CVNyEsOpCVroUDkhhE3N9fGu72k/hvJvCiEDyiiMm1EtgBsRIG0
 BrbPVY2W2Drn0MxyMcie24ekXZOMS1OtBowQ1VeGyGPNbnKBl52VTYSvqnavbTZONyca
 ueFg==
X-Gm-Message-State: AOJu0YzxdfCjnzMpQisOl6WociqraIEiSEr7+ubYCsgmRRocgs1eIskg
 3BCGACDzMUEulsnsytmo1oqy7A2A8+D8zvASbWdsxLrYE46QyiHtHmX8qfTlcjct6zoRzr1tW9L
 Um0jCbYxmExrt8OBjAQXV8Yh7BAnfPWINryUIEMr8aao2gWnwlNDH3G1NeBLY5+xOTA==
X-Gm-Gg: AR+sD10ma+wws7+gLJICQKFYIKZE2kPt1wN6Mxy082HruryH5v/ssQRWGhYa5Y93/oY
 M/Q0g5Jf2St9/GM8ws2O7t756qylXGcShBR1AJh0g4TXVF6STOO1IoDApJBRLs/pVCYaJe+wjkf
 Ms+qSnnGgrLr50TtD1HnPzm1dZbglOIQqyrfK+T9tdQpv3rIQVdJSdsI0R/WFNOoXwBMS1ppPbj
 NUhC6hYlpkNdBrhfL6wQV6eqLWlDrWTF4Ck7VS5VqNdHuotyorCYhku7CXkocH9aaCDKgne3Cc5
 Z0edf3p0QJ0Ke4eAgV1DCZ0f7yxneoNkGGXccf7/DnYrFpivdSw7b2G3gadXaPhtjTIj5sDomDi
 B14l4kQNetMAtU8L/Df+YE5gaqvsM4zQQPoPd5MRLQw==
X-Received: by 2002:ac8:5850:0:b0:516:d83d:b28 with SMTP id
 d75a77b69052e-52d6030e8e6mr11912361cf.17.1786463421142; 
 Tue, 11 Aug 2026 08:50:21 -0700 (PDT)
X-Received: by 2002:ac8:5850:0:b0:516:d83d:b28 with SMTP id
 d75a77b69052e-52d6030e8e6mr11911651cf.17.1786463420680; 
 Tue, 11 Aug 2026 08:50:20 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4997aaa4d2fsm1674885e9.1.2026.08.11.08.50.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 11 Aug 2026 08:50:19 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Corey Minyard <minyard@acm.org>,
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
Subject: [PATCH v4 6/7] hw/nmi: Remove unused @errp argument from raise_nmi()
Date: Tue, 11 Aug 2026 17:49:29 +0200
Message-ID: <20260811154930.13915-7-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260811154930.13915-1-philmd@oss.qualcomm.com>
References: <20260811154930.13915-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDEzMiBTYWx0ZWRfXzjXNHKqOdz+L
 AXLW2hHybvVH7edgCBPOUuSwRvHYjfkbjHOu/NF2U0Ocf3Fy3htf2gSfLoU3yJDqdg8dOouv36m
 6XW++okuP4M0bk/Jw9W1EO/a8FR0VRA=
X-Proofpoint-ORIG-GUID: 3UH6673fSB0vwdcuqbyoz30vwyQAbhIY
X-Proofpoint-GUID: 3UH6673fSB0vwdcuqbyoz30vwyQAbhIY
X-Authority-Analysis: v=2.4 cv=cvarVV4i c=1 sm=1 tr=0 ts=6a7b44bd cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=799TcV0OOjXjlcq3EAkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDEzMiBTYWx0ZWRfX63S0laspn6fR
 pRFNAeXD6CVISBKnAT4P78u31noEYpI0SqFentyh0p5xOlYVsuOAC0x8lhPVOASPHxwJqaQ9cNi
 pvfrF4lLt1NfxRG8ErewDma9zRsr0YD9yoA22w9K1CoavPWOKoGrScL/h05sg5b8tJKubP4zvOo
 lpo7x+1Zp+XDeDMRkUBPCEm154KQLDK1zI9tb2J9ngmstn/uoeRgfFc0uwweJocTy+XbpdRYYLk
 p0J507JF1ju2kJh1D0FN9xxOAyyN/+3MagP6k/GQMM7wOiNYVRNplJjgIkH2LK4MgLobLeXdszn
 mZ9niBkITurA/6nZayOWK3goTiOis8r1I+D5+LUR3Lx9navC9D7EHu8C0qlOJAk48ftDOOpAGJ8
 0aTKtDsZVtIU6iivQudy1oDeMfJOZYCeMwWoAT/sx5DZxw4bRJqPAipLlnqAWVmaAnlCAisBVCm
 Dqw+xAblTzGDTdL15XA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_03,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 impostorscore=0 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608110132
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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
index 1ba6f393449..d900d85e40c 100644
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


