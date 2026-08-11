Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFADEC5CFDB
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 10:56:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtk8w-0000Ws-AA; Tue, 11 Aug 2026 06:55:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wtk8Y-0008Uv-3M
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 06:55:17 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wtk8U-0000ML-BX
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 06:55:13 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67BALnmf3288768
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 10:55:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 HxZTiY4hftmnkRlAI0itymOJtdwmyHMvObdJRrQQgrg=; b=YotJQ//Gwmpbog/M
 EgRdCziu1tdHjrCggCjaWZnZVdkg7MnWnZAY9N8Wnl2rG5QPxbcaM3MNmp36bA3a
 +sTG79DjR4a59Vk77ZovcewAPteZleJtqGYUAfmwFwiIvralJ/DAxU+rD2HgjipT
 CCIaO/L7+A8zj+1Ixa99qzgynuWTHq0m0SbZ2ibMY6bpiXMfZs4g5pqbJgexRhT2
 UtsPCI6UTWvMeGaHBChIJ+OkMND8nSjf056wZkTOreR8kU2fdBwNdOPTAdXfNI2D
 TPNVs5rXoO9Py2YP8u2WPCW1wzvhsBylq4a6Ox/PaPMLNI8qm1LcDKAjoO9Zf12r
 Cfbmlw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fyxwerw1e-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 10:55:08 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51c1d137a68so63692421cf.3
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 03:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786445708; x=1787050508; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=HxZTiY4hftmnkRlAI0itymOJtdwmyHMvObdJRrQQgrg=;
 b=h4qLeTTTYbQGXWK7tRTL3S9GDDv262FQusAp55dA/JD6aatGP5Zas5AWT2CmgWzYMP
 csjL6rQ5PO2fgAzLye3yXm+tWZgcvzs7sHz0AgX+7H9v92U19sZTSBBmjdHXMROYcH5T
 9I0MFVcnfhOR8FnQwRlWxlkUosDm+8BUFY0SL807KPbdErvr/cCBtBxpCi6NXr0YOt6j
 GKN3Hgp6VrExrPqjCJYBABA29xNAjWJXyct+BrevrzH+TVrQyQwTX1cBGDxpS1ypqETo
 KNdsb/MkrxIqbpyuCUidxgrhU13vHTVngNDiyaQJnIoP2pH7FKBsMsnXLnPW5UQTRzzs
 NuTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786445708; x=1787050508;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HxZTiY4hftmnkRlAI0itymOJtdwmyHMvObdJRrQQgrg=;
 b=BkIkguYBKkGMaHQPV0nhZdR4TvdO00CSc1GolE5MQny3yiWd5FWdgUlE+pL9Kz+py+
 6vEGb0UtyHn9DTs2mHz+0OEIaszisfnn13ZC60rE7uumt1G8me1MPbFaIVUFTh4Pm7gd
 AiQ+SEG3xT07hRLUpvUGIUG7pgg7HZPYQmGwfrte2b4fdcb6q53HcJgU76z0EhWWUf3Z
 W3VtLYcnrzZQAp0d70D7FQ+gfTo0Lux2AyNAJlkntt63ytelyKOCOK6Og+lE/ORex4BK
 kWg8WljdijZHix5D+23Y9SOtwAriJrQr4bw7sAMhvs0WqbtGo1WeLuz4r1v9kT9qvu7C
 vsgA==
X-Gm-Message-State: AOJu0YyBI1gJ4bMaH31v2sLeKPzaNVOjdQ7JPtw3CJLaWnas+2Z39FJE
 mvIhIMa0CseFiH9zPN4DmFkXUnpYwAkDepIOMmt01y96uGYjSQqZVQ2ZcN6eC9RODOYZH1Gf6MG
 +QB2y332EmftoAInRQstx/EpVVbHkQJgbsc5f0qXmS6Upq0wbVXnCui9Vj89+qcy+7g==
X-Gm-Gg: AR+sD11L/qe7rkTz7aOgb69j/PsLOpRp969OjUdaIA+AcbVMdHFT8Ff6lpd49sBTBJN
 /s5GAwr5fN+zwpOYeDEAVXmdEIQamQFE/CmxMoaaoMo3KCQuOL3kPiKscjHRYEoJyGuR+MygSM+
 +FGleTH1sVSXpXzzM9jDh+/k9Gb81nBsTQi4C/gAtRe8L3psye57MM70DLByR/utAWlOT3vUPr2
 Fb3ONEhKEpnIUkkuo++0okkxJRxfXcim6zAfpGxslPCKQIvP6AsYKWCCEQxuG2d7I0I7YOkmTgE
 65T6eI5evxxzTg/i9JnGfIhNFbljPssxBzare5cReqPhSAnpAqx9afnq85WMW4DzAFrlZy2iW7T
 OQd7v4QVhoCnIaioMUMA9YaQngcMD6YipCvoEv+1FvtUNPxw=
X-Received: by 2002:a05:622a:4818:b0:51c:1027:34d4 with SMTP id
 d75a77b69052e-52d584fd96bmr19240241cf.11.1786445708421; 
 Tue, 11 Aug 2026 03:55:08 -0700 (PDT)
X-Received: by 2002:a05:622a:4818:b0:51c:1027:34d4 with SMTP id
 d75a77b69052e-52d584fd96bmr19239031cf.11.1786445707001; 
 Tue, 11 Aug 2026 03:55:07 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4814a72a1fcsm3492404f8f.33.2026.08.11.03.55.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 11 Aug 2026 03:55:06 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-s390x@nongnu.org, "Dr. David Alan Gilbert" <dave@treblig.org>,
 Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org,
 Corey Minyard <minyard@acm.org>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Nicholas Piggin <npiggin@gmail.com>, Aditya Gupta <adityag@linux.ibm.com>,
 Glenn Miles <milesg@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Cornelia Huck <cohuck@redhat.com>
Subject: [PATCH v3 5/7] hw/nmi: Rename nmi_monitor_handler() -> deliver_nmi()
Date: Tue, 11 Aug 2026 12:54:23 +0200
Message-ID: <20260811105425.7429-6-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260811105425.7429-1-philmd@oss.qualcomm.com>
References: <20260811105425.7429-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: LLVfaGXgE_OiUppwBikC6Of4R0Fb-rua
X-Authority-Analysis: v=2.4 cv=K8QS2SWI c=1 sm=1 tr=0 ts=6a7aff8d cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=ffKbFpdEYwWhcrXovwUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: LLVfaGXgE_OiUppwBikC6Of4R0Fb-rua
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDA5MCBTYWx0ZWRfX8qb/xtmRF/m1
 ISoHjTpXXOgCTovNSoEqBAjbGNFmQZ+zH51VDI/FFoVs3RhKJ7VycPF9gQVxqJlJ19YP8LYmvA8
 OxaIBEpsVP1o44C0pjI3Wc77j8racZE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDA5MCBTYWx0ZWRfX8m5MF67OOXdX
 nb20mJVjcg/q/V1FtHW+UIfVGZhov5FFUQo7Q4ex9+tLoyv3+azxPXAYtYg7XqGULncQ3oRK7j7
 tSp8KfQrCwQYT0rPTBsInOIwShO+VlVdRPIiu/XGrzIjcO4BqEwenwVfVkUtNMs6J2psi6s9h3h
 OQQDM7U59m1Nv5ErJt36KL2Ok89cpKOTGXsbWltbOPFNAOLy0iKWdeilqz2kqZODSblfiL8Ya8T
 qTGbEBDl2cU2HEdsv2WQgUg9hEBxoFsaSX5beF1Hu2m1QRZDPep/9NIoQCTlA1NChAJ5fe8rCh1
 3ZNK2nQw8MXQBLdXgV+wgi79SpbJDoH8jbVbc2ezJuXdNbDtMI09ogBlf5HVMGDfcpDP2HBDggG
 M023i8Gl5Bruy1yWfEug4mdTpqeEa+i2aycaCxfPS/AMnPObUIePTLookUjgL4W8oYo0La9OuqZ
 ADeAiHdYUukeCCTH2KQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_01,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 spamscore=0 priorityscore=1501 bulkscore=0
 clxscore=1015 phishscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0
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

nmi_monitor_handler() is not related to the monitor,
rename it as deliver_nmi().

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 include/hw/core/nmi.h      | 4 ++--
 hw/core/nmi.c              | 2 +-
 hw/hppa/machine.c          | 2 +-
 hw/i386/x86.c              | 2 +-
 hw/intc/m68k_irqc.c        | 2 +-
 hw/m68k/q800-glue.c        | 2 +-
 hw/misc/macio/gpio.c       | 2 +-
 hw/ppc/pnv.c               | 2 +-
 hw/ppc/spapr.c             | 2 +-
 hw/s390x/s390-virtio-ccw.c | 2 +-
 10 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/include/hw/core/nmi.h b/include/hw/core/nmi.h
index e77c382452a..d6bd2a9fceb 100644
--- a/include/hw/core/nmi.h
+++ b/include/hw/core/nmi.h
@@ -38,12 +38,12 @@ struct NMIClass {
     InterfaceClass parent_class;
 
     /**
-     * nmi_monitor_handler: Callback to handle NMI notifications.
+     * deliver_nmi: Callback to handle NMI notifications.
      *
      * @ns: Class #NMIState state
      * @errp: pointer to error object
      */
-    void (*nmi_monitor_handler)(NMIState *ns, Error **errp);
+    void (*deliver_nmi)(NMIState *ns, Error **errp);
 };
 
 /**
diff --git a/hw/core/nmi.c b/hw/core/nmi.c
index 662f2051123..02c0ff2c21d 100644
--- a/hw/core/nmi.c
+++ b/hw/core/nmi.c
@@ -37,7 +37,7 @@ static int do_nmi(Object *o, void *opaque)
         NMIClass *nc = NMI_GET_CLASS(n);
 
         ns->handled = true;
-        nc->nmi_monitor_handler(n, &ns->err);
+        nc->deliver_nmi(n, &ns->err);
         if (ns->err) {
             return -1;
         }
diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index 2b44debc388..47e0302bac8 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -851,7 +851,7 @@ static void hppa_machine_common_class_init(ObjectClass *oc, const void *data)
     mc->default_ram_id = "hppa.ram";
     mc->default_nic = "tulip";
 
-    nc->nmi_monitor_handler = hppa_nmi;
+    nc->deliver_nmi = hppa_nmi;
 }
 
 static void HP_B160L_machine_init_class_init(ObjectClass *oc, const void *data)
diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index 0ea5453403d..48f7575895a 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -389,7 +389,7 @@ static void x86_machine_class_init(ObjectClass *oc, const void *data)
     mc->get_default_cpu_node_id = x86_get_default_cpu_node_id;
     mc->possible_cpu_arch_ids = x86_possible_cpu_arch_ids;
     mc->kvm_type = x86_kvm_type;
-    nc->nmi_monitor_handler = x86_nmi;
+    nc->deliver_nmi = x86_nmi;
 
     object_class_property_add(oc, X86_MACHINE_SMM, "OnOffAuto",
         x86_machine_get_smm, x86_machine_set_smm,
diff --git a/hw/intc/m68k_irqc.c b/hw/intc/m68k_irqc.c
index bc41b44d455..281542e3997 100644
--- a/hw/intc/m68k_irqc.c
+++ b/hw/intc/m68k_irqc.c
@@ -97,7 +97,7 @@ static void m68k_irqc_class_init(ObjectClass *oc, const void *data)
     InterruptStatsProviderClass *ic = INTERRUPT_STATS_PROVIDER_CLASS(oc);
 
     device_class_set_props(dc, m68k_irqc_properties);
-    nc->nmi_monitor_handler = m68k_nmi;
+    nc->deliver_nmi = m68k_nmi;
     device_class_set_legacy_reset(dc, m68k_irqc_reset);
     dc->vmsd = &vmstate_m68k_irqc;
     ic->get_statistics = m68k_irqc_get_statistics;
diff --git a/hw/m68k/q800-glue.c b/hw/m68k/q800-glue.c
index b13e5ef95f1..b75f7f44d3c 100644
--- a/hw/m68k/q800-glue.c
+++ b/hw/m68k/q800-glue.c
@@ -237,7 +237,7 @@ static void glue_class_init(ObjectClass *klass, const void *data)
     dc->vmsd = &vmstate_glue;
     device_class_set_props(dc, glue_properties);
     rc->phases.hold = glue_reset_hold;
-    nc->nmi_monitor_handler = glue_nmi;
+    nc->deliver_nmi = glue_nmi;
 }
 
 static const TypeInfo glue_info_types[] = {
diff --git a/hw/misc/macio/gpio.c b/hw/misc/macio/gpio.c
index 1bdca728f97..086d90f20b6 100644
--- a/hw/misc/macio/gpio.c
+++ b/hw/misc/macio/gpio.c
@@ -201,7 +201,7 @@ static void macio_gpio_class_init(ObjectClass *oc, const void *data)
 
     device_class_set_legacy_reset(dc, macio_gpio_reset);
     dc->vmsd = &vmstate_macio_gpio;
-    nc->nmi_monitor_handler = macio_gpio_nmi;
+    nc->deliver_nmi = macio_gpio_nmi;
 }
 
 static const TypeInfo macio_gpio_init_info = {
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 8676be7bbb1..bfb1d45d058 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -3583,7 +3583,7 @@ static void pnv_machine_class_init(ObjectClass *oc, const void *data)
     mc->default_ram_size = 1 * GiB;
     mc->default_ram_id = "pnv.ram";
     ispc->print_info = pnv_pic_print_info;
-    nc->nmi_monitor_handler = pnv_nmi;
+    nc->deliver_nmi = pnv_nmi;
 
     object_class_property_add_bool(oc, "hb-mode",
                                    pnv_machine_get_hb, pnv_machine_set_hb);
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 189334b9f0a..ed545acf3c0 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -4652,7 +4652,7 @@ static void spapr_machine_class_init(ObjectClass *oc, const void *data)
     mc->nvdimm_supported = true;
     smc->resize_hpt_default = SPAPR_RESIZE_HPT_ENABLED;
     fwc->get_dev_path = spapr_get_fw_dev_path;
-    nc->nmi_monitor_handler = spapr_nmi;
+    nc->deliver_nmi = spapr_nmi;
     vhc->cpu_in_nested = spapr_cpu_in_nested;
     vhc->deliver_hv_excp = spapr_exit_nested;
     vhc->hypercall = emulate_spapr_hypercall;
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 5d8a73a63df..f9e8ecb4fe0 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -830,7 +830,7 @@ static void ccw_machine_class_init(ObjectClass *oc, const void *data)
     hc->plug = s390_machine_device_plug;
     hc->unplug_request = s390_machine_device_unplug_request;
     hc->unplug = s390_machine_device_unplug;
-    nc->nmi_monitor_handler = s390_nmi;
+    nc->deliver_nmi = s390_nmi;
     mc->default_ram_id = "s390.ram";
     mc->default_nic = "virtio-net-ccw";
     dsi->qmp_dump_skeys = s390_qmp_dump_skeys;
-- 
2.53.0


