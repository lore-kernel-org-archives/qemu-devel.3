Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03FF4C5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 12:13:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu7pc-00074X-84; Wed, 12 Aug 2026 08:13:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wu7pa-000743-H7
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 08:13:14 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wu7pY-0007Y3-G1
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 08:13:14 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67CB4BjZ569115
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 12:13:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 BzxWp6a13iMDHUY1cIEZUz72MRz0K1yfhW98Q2txljc=; b=O8Cz08vol0h0fwG1
 Lxq4enFZgbv+RWcNzdIPiUbwyDv3tF3/ZjTLE7Kh5ojaoQzA0IY3Ef2yHnbtwZII
 e3ErbkVii9Iq57cGjnfZq2jfUDZxsPIdcnNOcYzDCFo7vy395iPEaZboV3eFT+mt
 QNWpqPwu8aIHP6Z5WCfVbqeEUdrLnS4NObysKBNL0ZnCT3ar1wqFfkwbt3FMgTP/
 ep3tVKg4nm3wBsplCArFWP5vnqt2dCGMOnyNu4syxQ+9TNPbFsSzfGjEkqSBAn5q
 +pF8BJ5craBv0lYo66V4oTvEyLxdLht+ljRSX7eALoxR3rz46C6bRsBGxn1FN2ID
 Ix7JYQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g0nut8pbh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 12:13:10 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51c12e43b98so10687571cf.1
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 05:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786536790; x=1787141590; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BzxWp6a13iMDHUY1cIEZUz72MRz0K1yfhW98Q2txljc=;
 b=DpCG5HQFfZp2sjlSOUza/TsBqNH8b1wuUyGiuvkL12Ai+tMqYFdVDVotf+1WLUgiuB
 hqSkClenpq3vNmKa33wO43brto1sWgW4SsaBYJWN8sCatsr0X++AltkoopU5W8EL1KoL
 EYi64BqIEecNKbyvTFc51/csrF5kdGZHbjWq2T5p1gYRT6amDJJsbFyekqefY1CWTPb2
 rR/OG/uX3kQpxWkj8ZlrTQ4CDbX+kMm/HinyUeZe+E5Jy8MloBWRw9jBr5K7gGwUEjLh
 j6i+/kmqB7z0/DkDD654oaiw8hddkyRxyLIYzHv3RUY/o7DSTB9SXcFxl2leMHEiZNH3
 PuGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786536790; x=1787141590;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BzxWp6a13iMDHUY1cIEZUz72MRz0K1yfhW98Q2txljc=;
 b=oLAOr+Qs9jn0n7cB/kUkguEiIR0QJWcbRarRe3iMJDLfeMWcrbPOSpysHEP8acCUe+
 cfaKz4ECbAewSc5ZaA4B3HRR7NwF13iXacx5tEjCoka56czDg79HDl/r3g3UgkW1RPlf
 a8LtcAo0fblgd/f3/emUKMOsluSqOl+ELppSE7l+K8rsP37NH5Pz/xNUZ81Pv5bZkR6s
 oF3mFYAl6osu/qZqr/yvR4UfnUSgbSnMrfOSBI0EXybVdNQI/LbmgSWTHyioSrlD/7Ys
 JeFle1xsw2m6MU1gLhjowFlrDOKnn0TmkxoZiVybf5ftpNt2DzrWeK2ECt05HcX1S9Zw
 czZg==
X-Gm-Message-State: AOJu0YxfBLmxkxuUgcYkO9REQVNJ4MHVCVXLdtqd0xlSrEPz3KHWLPQE
 EQtDaCZ3iEBogoxxUIJwQ1K7f/yqTmKbjUxrYUJc25RBEH8/nNLHJVDK8dbXgo8/4VfYZnSOBu7
 buJHoKDbPdnk+GmAR2DRtRZds96OWDbaLQZnhUl4eDJfrIgzIShWoLJb9c/XCmkj/3g==
X-Gm-Gg: AR+sD122pJmEs/mWRXDJRlYAJz5igUASiONp72KAmr5OkJMeFgFxQelN8ZG8Idx0v8m
 EAiXF+5ozgLYwQ7JF32lydWVmdERfmmdlxG5UL1q+kPKgAtfVJxcaHbhymVJvr79prbmz4rRUbk
 NfANHHmGdNkxBJ287HLB2WO+PUGwl9kOyJrwTyAQSIumWwSHmFlArhfYuBfj0YPEqefiOpEWTTL
 vWVZ4c561bhvEb7GhY3obDBhTCgUpPmvxYl6ZSmoS9TatrrBxC6b3P3XPs0E2hbH+seDPOiBis6
 6qK0Oa/ckYUCvq2Jh8sJlNG6NNV4oTfWXWwQE1EdzoCa/AmEIRJ0tzioGCmZ/5oOK2gk/YIXPgT
 F+0Jy1X0BfJO20pYpmIJ2QOubY1OAC1DuW3r8jTXqWw==
X-Received: by 2002:ac8:5f10:0:b0:51c:e14:87a7 with SMTP id
 d75a77b69052e-52d64805fbamr33055571cf.28.1786536789848; 
 Wed, 12 Aug 2026 05:13:09 -0700 (PDT)
X-Received: by 2002:ac8:5f10:0:b0:51c:e14:87a7 with SMTP id
 d75a77b69052e-52d64805fbamr33054851cf.28.1786536789176; 
 Wed, 12 Aug 2026 05:13:09 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4997c939750sm44289245e9.3.2026.08.12.05.13.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 12 Aug 2026 05:13:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 5/7] hw/nmi: Rename nmi_monitor_handler() -> raise_nmi()
Date: Wed, 12 Aug 2026 14:12:30 +0200
Message-ID: <20260812121232.71958-6-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812121232.71958-1-philmd@oss.qualcomm.com>
References: <20260812121232.71958-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDA5OSBTYWx0ZWRfXxQY5sXOxvHEd
 EgFRbVAfvEkdtYu0bcgA5TPK6hZKepoN8nUT7i5UC5NdelJIQxoeQyii1sX3BWorpac0U2hXjp3
 eIA7IY0+wWPHJuHnn9QjUiXaNJmebeQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDA5OSBTYWx0ZWRfX4rQIwqX9pBQk
 6aLP19eABo7yQVJEZMzCGQ3+Budsm5faJD27gOu8UnnspLOYX5yAU0QX5TQXkHhHx+ZG/DfhX1Y
 JtwqnwQyggPx7NMwBPHduhbe2JQU4RQWuvfN0/kDnHHEE652EshjKOi/nDLZ1E7+BD4KjxQoTYg
 MZ0cACdwZYw/zxMUgp0d9wHxQo2OyYGtMgvKz/2rSfv8REJFKYIJwvqhBYCntilUuKQchtlKprS
 gmBGZ12UEnigwMUsdkTKImhBNkS+AE1C0fRlulitSaUpemxqGoux1gOZCTWsdqaU+pRD5xI3ZH+
 OM66XpsGWccrHo2jSrVD+uWp9MJqj8KX0IVcoKtHBI4/7HoNLsDjjMHZ0D9g5ohp7N3LVaedFis
 3Gi+awwcFqhpxIHqg9AtGIVeZ97jtsbISGcWk9iwOcy5X6xIsJPppd7gN0sKLyVIuN40Y/GmJwW
 9ij8qPJHtPYe2yls7Mw==
X-Proofpoint-ORIG-GUID: YgHvzDU0OwO1qrHo6QAhQ3gkvPFcwsQ3
X-Authority-Analysis: v=2.4 cv=POA/P/qC c=1 sm=1 tr=0 ts=6a7c6356 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=XQsbmRuMgCUMduHJsesA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: YgHvzDU0OwO1qrHo6QAhQ3gkvPFcwsQ3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015
 impostorscore=0 bulkscore=0 suspectscore=0 priorityscore=1501 adultscore=0
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

nmi_monitor_handler() is not related to the monitor,
rename it as raise_nmi().

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
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
index 851be28257e..a8feac3b67e 100644
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
  * The NMI is injected by looking for a QOM object which implements
- * the TYPE_NMI interface, and calling its nmi_monitor_handler method. Usually
+ * the TYPE_NMI interface, and calling its raise_nmi method. Usually
  * it is the machine model class that implements this interface.
  *
  * Not all machines implement NMI handling; this function
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


