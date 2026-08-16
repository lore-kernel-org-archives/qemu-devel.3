Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54490C5B572
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2026 14:51:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvcCN-0002cK-0X; Sun, 16 Aug 2026 10:50:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvcCB-0002HG-Nl
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 10:50:45 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvcC9-0001fL-Mw
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 10:50:43 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67GDkqcE3950246
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 14:50:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 cyFe2lwd5CJAd/OU8x66v6i2Ml3gSEnyF8C0HHAtKvA=; b=GslHwfUv6JshPAWp
 cOwZ48KdpDGQd5ZY21P6yktg4CmIT62gB24Q52YPVcyGcsF7ScmuJ1dEyGNboAEr
 XG/Fey6cUE10036jNmRufy50erx1JZ3h1jw6lH+3+4nTTN+DFjv9sPCcYmwDJqTt
 SRqQwNTG92lIQZFoAuen9tN5jGBhq4he4YMJjvRJ2k29JkInbIEt9vrMDXnIuhAt
 FvE7yJlvn+KQnPPBR1PikNV7FA9zNgVTI/JZymFYp3xiO3et1VCSfGL76kTpsumO
 w1MiBhue9zX37sJN4P6rbYyW1WKtdyVKZSBFiE0QaOZ84U9gDRcIppbujZh/r5Pd
 jIb1Zg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g2ghnumem-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 14:50:40 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-930b571432fso246484785a.0
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 07:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786891840; x=1787496640; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cyFe2lwd5CJAd/OU8x66v6i2Ml3gSEnyF8C0HHAtKvA=;
 b=cBpGePHQbW2o1VxGhUdEOwIXnj7lIUiuSKoiH/cm+L1njIjtfw6G4ojC9fP4VV7oe3
 eiz5chXhaN45W+/GXseI4ZdsSsYMePwdFYYlq6vXUJ+Z+8akHpohjBDdJ1ZM/0HZS2jL
 j0yVNYI9kqfPjYYBRIcycJ+Z/3ca9MSo+2Fq9uwCNz627q6wOsE5JlJ2OZy4TjZpF180
 YH9Xr5mSp0nMR0k233fCz7H3jc/yDnCw4kflnbKYeBuH8mJba9WlYlvMqblpxDzS6NL7
 5K9ZlL+i7KWl53SHBp9tWfePwzeZI/A7PRVsv/ksM7wi2k+Gri5NaxIGetn2TYTrp3R2
 cxSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786891840; x=1787496640;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cyFe2lwd5CJAd/OU8x66v6i2Ml3gSEnyF8C0HHAtKvA=;
 b=p5w0r0t/HK9Cs4PRfei3PAk0+iJOUo569bR0uJ3qb6fJyDCVDbOXreFAOfT64C5Ak1
 lCuJna4LJvV4IzYmgim/5J2DT3mZrvhQkEugShlpWLU7V3qKwKEjl18XyUI/9CcBmGzQ
 Kkr+W1abxI5AtC9Oqp5nTG8gyn9CXYyOLyTjoFkQX2/X1jJI1Anv00haJzvueU+A+E08
 79lLhNZq3220RSMsmsIWk7wFuEWTTqryBdygmvYv2o3pHKz15DUW6ZC39aJwQvsTW3ii
 O99+CF5Jn8crZeqo2kGKajpmFePv/wWtZDl3+3harW6lrAZ0AM0DGLGcgDuxPJxlsc6J
 wKYg==
X-Gm-Message-State: AOJu0YyGAkf3iBXk8cRA0YRkefy75mD32+WzLjT0CJ/rTjeGadhd197z
 Fk8Gbc1MbbRLfWWZuKzDKoeXrbULm0hWXbQqjqPJ/b1u9f9bETNGprBM6GR1DDj8O3iEyh4F+tv
 2ssZikC+j43tIy1wlPntkQH6JoRfm9ZE5MEgkZQvuSw1RA46A+u46ib9xqeK5j6qqyw==
X-Gm-Gg: AR+sD130V+X+9OpfovqjbfhDz5RHur1ObFiNZDfJihj7u7k06Lv6kxzdj/HhVTgtMJX
 YI4sky5Ct/X0qLY7lFoYFzSeyv9Hy5JDbmW/U9R0tF7rPqRRYE2MdRH5G0LLAJSo4IqJ126FwN8
 CAvj5Is1fzQORySVqGNTMlZR2L1yggJQDeNr7UvZT/q8hEtg6H+goizphMkHOUh2DnTFSsR5RkV
 L6IM5srkrR98mp/vwjZ1z42/HDAUXRj0468oHyHUx8KHY3rSU6o1G/c5s/aL9JA/oQ+7hapAdyQ
 GIBn8t2o6xdXFiotnoyAsUi+RAHUQ6vNB7pv/jxPNmWpQQBG/vfArlI3Acak1L0g6Ili8uHWisp
 yu/ObigiCnR/hNT476Mk5rdwWcGbiJvD97WLdXXYgOA==
X-Received: by 2002:a05:620a:258a:b0:936:f7bb:9530 with SMTP id
 af79cd13be357-936f7bb96bbmr99725685a.1.1786891839918; 
 Sun, 16 Aug 2026 07:50:39 -0700 (PDT)
X-Received: by 2002:a05:620a:258a:b0:936:f7bb:9530 with SMTP id
 af79cd13be357-936f7bb96bbmr99723485a.1.1786891839417; 
 Sun, 16 Aug 2026 07:50:39 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4815f219d3dsm25066490f8f.14.2026.08.16.07.50.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 16 Aug 2026 07:50:38 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 33/56] hw/nmi: Rename nmi_monitor_handler() -> raise_nmi()
Date: Sun, 16 Aug 2026 16:45:32 +0200
Message-ID: <20260816144556.69009-34-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260816144556.69009-1-philmd@oss.qualcomm.com>
References: <20260816144556.69009-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE2MDExOCBTYWx0ZWRfXzifEwapYevNT
 fPIEvhHdnmjrKFNDgKAKeUnAPDThl5hOY6eHbfuNQjZXvyE9RIACmm4F5+7v8j3PlXYbxoe6cIS
 GxqIZdfK7Id0Gp73WGsWi/NRGEpDA5F13oHjMb9Ppfbx7fj8m8LpfvtEI9aGy1SCdJ7z7ZL9PmS
 uPop3vWbms0g373tQJwXIij7rDbS87jyRn9LQ8uZApPVXe50vOPDciJ28baVpn7HBb6fprfUotx
 9bwM6OhLJNSiEEoQfKMcVWUHIP+WkxPJchRBLyliQxN6zCDfrT1wPT5CGuT4M8xTzo6qwheqla1
 XaAOnDMzJHA3HyO7rA+LdLeTKgCmfHUu7824uf2HxaI/14vGo2QstkmGCBYcb3X+IMO8/vTtIYI
 /AXXWIgj79JZR9f1vdQ/LYg/iW0SCYviI5eoRmgh/VuXDMz559XbnPXNumt+yQLYLdjrki+d/mX
 ogZ4e3TmwUsZkGgINkA==
X-Proofpoint-ORIG-GUID: qDm4Ec-SO9XmvB8lYXa90yYLrmroQE3_
X-Authority-Analysis: v=2.4 cv=QN5YgALL c=1 sm=1 tr=0 ts=6a81ce40 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=XQsbmRuMgCUMduHJsesA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE2MDExOCBTYWx0ZWRfX9zMKzJfT8V9W
 vgVH9I6qt3PgJ0/5qu/1zLp/jmA1CNwLbVVEt8tp0e/RaX7FJzf+l456utMiLhAvN0ybhEdQzhz
 q2t90jBQWqnW+ggu8hML8WjBiKfLkr8=
X-Proofpoint-GUID: qDm4Ec-SO9XmvB8lYXa90yYLrmroQE3_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0
 clxscore=1015 priorityscore=1501 malwarescore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608160118
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
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20260812121232.71958-6-philmd@oss.qualcomm.com>
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
index c376a588720..1bc90ceed35 100644
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
index ac04245d65b..21d9f51ddcc 100644
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


