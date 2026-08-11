Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24F35C5B56A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 15:51:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtolH-0003xP-R3; Tue, 11 Aug 2026 11:51:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wtoky-0003lU-Es
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 11:51:13 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wtok2-0002et-Iu
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 11:51:09 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67BDX5uT767022
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 15:50:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 0edfJ/cchANNWiukKnZOf9OSLonHl948sTIY1UKAj1Y=; b=ABVZCzW7tbiA6S/G
 01R+5ADQJHZXvp1qb0zb3jwZ/ov50hAvSGZuAlTlgwEtVMxUzjnI8s3rPaJ6XIRB
 C6dwKrEYFfYzM0tfGPda9b6IBc78CKjtcXG7Tlfkq4pzcOPNXTRjCfU5hzHb4rHr
 t3nyV6qxxFy7rnfjI85yryGv/TYeptmWxgxetYVtbdvP2OnIZmhrKb1njSRbV1hk
 DrkAT3XeYYU+KZi5CLniKkLEMtHpQcu3/WXeg9e2LH49qTncGtQplBHF4LlWcNPX
 c8wggd7yjlgXKlBoe61bvbHpOH59mJep4Bm2L4z3t0mU41pfd0aoJf5kOR3tYEmd
 RPqNBw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g01nc1b12-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 15:50:13 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-52ce3c7cb2eso758771cf.3
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 08:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786463413; x=1787068213; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=0edfJ/cchANNWiukKnZOf9OSLonHl948sTIY1UKAj1Y=;
 b=Kp9XwsqJPyyffCbHyz0VBowHWvWBEgXrxeH6V7b136PU9BmRLZHhHwiGpOQkReyS+n
 o8qOFo9XGV8VniLfo6rrhueawnvG9vRSmFFZpTa035XZNzAcUO+wrEVb8xnHk/v4pi6C
 +/cQqs1CKeLY9z2i73EQqOeb+qgvufbpGxp4x0IdB9gID3C+MN2bigmYL1sMcH8IgtiW
 hfrWTWCQB8ZaNbMqrkyv8R4TgGDvG5meeH2JC6LttwtwhauAgHLPfx232p9Y5YT55cD2
 tvCgGGFmCba+eolB/yFTNwgbtu6IW/42Qafh5yu9c2FWo53Hm90T6uivCmrORGJ+k+C0
 t89Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786463413; x=1787068213;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0edfJ/cchANNWiukKnZOf9OSLonHl948sTIY1UKAj1Y=;
 b=AZmDi2+V/ZBGuGK49F0FqBWZeSyntE+L5S8e1BMgps5EVROUradvn3U4GvDxT0J/SR
 XnhTwZYoA+VOQ8TYn9vQxcXaUTZ8LxEdi+rRq88hIdEbb1k8KYt2K4HVYxmajJz32A9c
 w1NonImzXqFnHZQwfL8uMrQmEgf27LxhLIMNfk5aC1PjxnYNn5+h19ChapmF37bBJbuJ
 Z9LhvjuNboBngXWw5NHZ0rCvJ0+RYoYuJAd7LtbjgJdLZTSaZNh+ZaGGB8xRvjxJ8sWL
 Wk9dLXfkTh5zOaxpHg/WIByvf09IV+/jWdJ2TFvzPUiS+725KRb4vmxmJCYNkZKFqyaF
 mevg==
X-Gm-Message-State: AOJu0YzSpHIYNbgJNKj2V4PBIzT+R4uOB0iaYcInPK8DlZYmDfexUZ1o
 Y0uQfFyQe0gRiHUbWa0WgOlluwXHHaDX6NGa4NEzkqs4DlI0GumTxPp55B5fF49uzJ8nzX+N4kb
 ofZT3Quh+AV8NR6Mw1zzlqB1olIk+hFck4V7/0DuJHJfHEGr+MlJ05jsjm1xN5KttCA==
X-Gm-Gg: AR+sD11M0X8rF8s3Cev+cL6KZV4893WMMqv+f1v8sy6nWUrqHwBJjtznAngIS+ihu3s
 IyGZTeovjlMJUJWeFzBJgqMpvisiTzbSbmihf1VoJTY1SadFu48voJYhJVw4WWzzlmXKJsXqR3c
 Pd913TB/5KX7+q5tclu52Eh2rfyi6JlBZwWKCqwjiofjV8Dy1vFaRkfDwe9U8l4AoAEgZRavgt8
 9eMzyPFkrlXlWPiroD5IIelbkgzfSctvMbEnUG8FMdRcNUiN/LgAElu9NXAASB6Z0Eoity21UA8
 Z18GIj8gBfUqdjdRUtqI9HW6eAUhb1nI7yeKiAOJzpCCXlYu+0WaIB14z/AcjjheW1vNr6dhWjG
 q65OgXu+tAkPnyMd38j7JwKof6M2Xa8PgXDoAaNPozQ==
X-Received: by 2002:a05:622a:2508:b0:51e:47a4:4851 with SMTP id
 d75a77b69052e-52d58498252mr40396331cf.8.1786463412548; 
 Tue, 11 Aug 2026 08:50:12 -0700 (PDT)
X-Received: by 2002:a05:622a:2508:b0:51e:47a4:4851 with SMTP id
 d75a77b69052e-52d58498252mr40395881cf.8.1786463412125; 
 Tue, 11 Aug 2026 08:50:12 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4997abeba30sm1307555e9.9.2026.08.11.08.50.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 11 Aug 2026 08:50:11 -0700 (PDT)
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
Subject: [PATCH v4 5/7] hw/nmi: Rename nmi_monitor_handler() -> raise_nmi()
Date: Tue, 11 Aug 2026 17:49:28 +0200
Message-ID: <20260811154930.13915-6-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260811154930.13915-1-philmd@oss.qualcomm.com>
References: <20260811154930.13915-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDEzMiBTYWx0ZWRfX1SyVqNVq85+G
 YnFyTe+MTN3Ob0DD/9930f0+UC7t2inXhS3zb+V/+zC6CbsEicBSC2dNytCFFV3JPsdi2zs/yTs
 zMb7ZGbeHNJGwYxbrFITJlF168XjlYw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDEzMiBTYWx0ZWRfX4nzVvEZ6m6ie
 R2V+Op6ptyAdUbCjmYaJV6beY01a/dQy9hoUydk4x8YHBqXh7KDJJOFQxvhW5ipaml5jf7VNynJ
 ozrPgbJdjqxDzEgrEMqGUp/NvyWo9JJ/Qakh2bj+eYBcxHUZhkUlw004nVZwN4N1/xIl5ZBOff0
 uK6/qdwWNEz/0MbH815wxon3Etyc2gzM5eB3vrXW3/2Gmj7ojLqmmP4LIuKhRpLbaY29oKo4u3v
 h4X86uWs9YkHe+5y8lA3DI8wdffnsYV+PpKrvrEEJb+vimSFLoWGgW2MS2StxZbgJJKHGc0PVAe
 lmxXrJQftDq1rfUYtxrOepAJkbxqNwRFnG43hGX+OFaDUdbBNqeNMfUAkHsZFQ/yylstGluxJwX
 +uWU1Nv5+haQldeUbvmbaeFF4GZYQJB6Yf+LeECHg86/rXMmacxGfPPtFIp39H/o8BZbpdDEM16
 lRG41d7B1LTdjleemcA==
X-Authority-Analysis: v=2.4 cv=RY6gzVtv c=1 sm=1 tr=0 ts=6a7b44b5 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=XQsbmRuMgCUMduHJsesA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: LGF2EdLzD7X8OcyZu4rYHAiSCDckoCzI
X-Proofpoint-GUID: LGF2EdLzD7X8OcyZu4rYHAiSCDckoCzI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_03,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 adultscore=0 suspectscore=0 spamscore=0
 malwarescore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608110132
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

nmi_monitor_handler() is not related to the monitor,
rename it as raise_nmi().

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 include/hw/core/nmi.h      | 10 ++++++----
 hw/core/nmi.c              |  2 +-
 hw/hppa/machine.c          |  2 +-
 hw/i386/x86.c              |  2 +-
 hw/intc/m68k_irqc.c        |  2 +-
 hw/m68k/q800-glue.c        |  2 +-
 hw/misc/macio/gpio.c       |  2 +-
 hw/ppc/pnv.c               |  2 +-
 hw/ppc/spapr.c             |  2 +-
 hw/s390x/s390-virtio-ccw.c |  2 +-
 10 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/include/hw/core/nmi.h b/include/hw/core/nmi.h
index 2ff5be1e214..1ba6f393449 100644
--- a/include/hw/core/nmi.h
+++ b/include/hw/core/nmi.h
@@ -38,12 +38,14 @@ struct NMIClass {
     InterfaceClass parent_class;
 
     /**
-     * nmi_monitor_handler: Callback to handle NMI notifications.
-     *
+     * raise_nmi: Callback to handle NMI notifications.
      * @ns: Class #NMIState state
      * @errp: pointer to error object
+     *
+     * Called by nmi_inject() to perform the machine-specific
+     * action when a NMI is requested.
      */
-    void (*nmi_monitor_handler)(NMIState *ns, Error **errp);
+    void (*raise_nmi)(NMIState *ns, Error **errp);
 };
 
 /**
@@ -58,7 +60,7 @@ struct NMIClass {
  * and on s390 it triggers the RESTART interrupt on the first CPU.)
  *
  * The NMI is injected by looking for QOM objects which
- * implement the TYPE_NMI interface, and calling their nmi_monitor_handler
+ * implement the TYPE_NMI interface, and calling their raise_nmi
  * method. Usually it is the machine model class that implements
  * this interface.
  *
diff --git a/hw/core/nmi.c b/hw/core/nmi.c
index 2d890f2995d..a6edf4fbf01 100644
--- a/hw/core/nmi.c
+++ b/hw/core/nmi.c
@@ -37,7 +37,7 @@ static int do_nmi(Object *o, void *opaque)
         NMIClass *nc = NMI_GET_CLASS(n);
 
         ns->handled = true;
-        nc->nmi_monitor_handler(n, &ns->err);
+        nc->raise_nmi(n, &ns->err);
         if (ns->err) {
             return -1;
         }
diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index 2b44debc388..717cfde61da 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -851,7 +851,7 @@ static void hppa_machine_common_class_init(ObjectClass *oc, const void *data)
     mc->default_ram_id = "hppa.ram";
     mc->default_nic = "tulip";
 
-    nc->nmi_monitor_handler = hppa_nmi;
+    nc->raise_nmi = hppa_nmi;
 }
 
 static void HP_B160L_machine_init_class_init(ObjectClass *oc, const void *data)
diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index 0ea5453403d..d1414ff63db 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -389,7 +389,7 @@ static void x86_machine_class_init(ObjectClass *oc, const void *data)
     mc->get_default_cpu_node_id = x86_get_default_cpu_node_id;
     mc->possible_cpu_arch_ids = x86_possible_cpu_arch_ids;
     mc->kvm_type = x86_kvm_type;
-    nc->nmi_monitor_handler = x86_nmi;
+    nc->raise_nmi = x86_nmi;
 
     object_class_property_add(oc, X86_MACHINE_SMM, "OnOffAuto",
         x86_machine_get_smm, x86_machine_set_smm,
diff --git a/hw/intc/m68k_irqc.c b/hw/intc/m68k_irqc.c
index bc41b44d455..29f758dafd1 100644
--- a/hw/intc/m68k_irqc.c
+++ b/hw/intc/m68k_irqc.c
@@ -97,7 +97,7 @@ static void m68k_irqc_class_init(ObjectClass *oc, const void *data)
     InterruptStatsProviderClass *ic = INTERRUPT_STATS_PROVIDER_CLASS(oc);
 
     device_class_set_props(dc, m68k_irqc_properties);
-    nc->nmi_monitor_handler = m68k_nmi;
+    nc->raise_nmi = m68k_nmi;
     device_class_set_legacy_reset(dc, m68k_irqc_reset);
     dc->vmsd = &vmstate_m68k_irqc;
     ic->get_statistics = m68k_irqc_get_statistics;
diff --git a/hw/m68k/q800-glue.c b/hw/m68k/q800-glue.c
index b13e5ef95f1..265af90a8e6 100644
--- a/hw/m68k/q800-glue.c
+++ b/hw/m68k/q800-glue.c
@@ -237,7 +237,7 @@ static void glue_class_init(ObjectClass *klass, const void *data)
     dc->vmsd = &vmstate_glue;
     device_class_set_props(dc, glue_properties);
     rc->phases.hold = glue_reset_hold;
-    nc->nmi_monitor_handler = glue_nmi;
+    nc->raise_nmi = glue_nmi;
 }
 
 static const TypeInfo glue_info_types[] = {
diff --git a/hw/misc/macio/gpio.c b/hw/misc/macio/gpio.c
index 1bdca728f97..db0c4ecb3cf 100644
--- a/hw/misc/macio/gpio.c
+++ b/hw/misc/macio/gpio.c
@@ -201,7 +201,7 @@ static void macio_gpio_class_init(ObjectClass *oc, const void *data)
 
     device_class_set_legacy_reset(dc, macio_gpio_reset);
     dc->vmsd = &vmstate_macio_gpio;
-    nc->nmi_monitor_handler = macio_gpio_nmi;
+    nc->raise_nmi = macio_gpio_nmi;
 }
 
 static const TypeInfo macio_gpio_init_info = {
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 8676be7bbb1..a9f74245866 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -3583,7 +3583,7 @@ static void pnv_machine_class_init(ObjectClass *oc, const void *data)
     mc->default_ram_size = 1 * GiB;
     mc->default_ram_id = "pnv.ram";
     ispc->print_info = pnv_pic_print_info;
-    nc->nmi_monitor_handler = pnv_nmi;
+    nc->raise_nmi = pnv_nmi;
 
     object_class_property_add_bool(oc, "hb-mode",
                                    pnv_machine_get_hb, pnv_machine_set_hb);
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 189334b9f0a..ad571481c44 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -4652,7 +4652,7 @@ static void spapr_machine_class_init(ObjectClass *oc, const void *data)
     mc->nvdimm_supported = true;
     smc->resize_hpt_default = SPAPR_RESIZE_HPT_ENABLED;
     fwc->get_dev_path = spapr_get_fw_dev_path;
-    nc->nmi_monitor_handler = spapr_nmi;
+    nc->raise_nmi = spapr_nmi;
     vhc->cpu_in_nested = spapr_cpu_in_nested;
     vhc->deliver_hv_excp = spapr_exit_nested;
     vhc->hypercall = emulate_spapr_hypercall;
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 5d8a73a63df..a59346a2120 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -830,7 +830,7 @@ static void ccw_machine_class_init(ObjectClass *oc, const void *data)
     hc->plug = s390_machine_device_plug;
     hc->unplug_request = s390_machine_device_unplug_request;
     hc->unplug = s390_machine_device_unplug;
-    nc->nmi_monitor_handler = s390_nmi;
+    nc->raise_nmi = s390_nmi;
     mc->default_ram_id = "s390.ram";
     mc->default_nic = "virtio-net-ccw";
     dsi->qmp_dump_skeys = s390_qmp_dump_skeys;
-- 
2.53.0


