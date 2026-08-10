Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D731AC5AD7B
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2026 21:38:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtXh3-0003xs-Gt; Mon, 10 Aug 2026 17:38:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wtXh1-0003x9-II
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 17:37:59 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wtXgz-00083x-L6
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 17:37:59 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67ALXCPj2772961
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 21:37:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 lB6nNj707NuJjIyuK1uCPtMJPjvc61I/WcRZHId+tQM=; b=QmUfQr116GbnLVWw
 8/WUXLwI/R59VN+6/Pi7FZQepwHpuNjS5oNJCYjmCQtkhKLW48z9CDZhaIvjegu9
 IyF/IhboFWw7/VXqYCVrWTRlk3t+ZzQ8ioP0jY767k05j5IETx26i5/x8vD8SVNc
 fmg3GcqiypoLQ2LxluzeF2rR/vWfnTYSOfxqsK44j3/p7fmjg/X/g8D0fqACOjOM
 PVWgKe8HEu73Rf2T8CH2SWct3qWJKc4KuTlSC2Jkr1kb8iuBbmWREYKU6VA6pJlB
 kke8FrJ4hWEF3+rmlYctWNFst7JkCAwGbi/TLvuwtHKvJDdjZeW7EeobA7m2fsKU
 mFzq1Q==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fyjjv146n-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 21:37:56 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51c1d7886cdso45812991cf.1
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 14:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786397876; x=1787002676; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=lB6nNj707NuJjIyuK1uCPtMJPjvc61I/WcRZHId+tQM=;
 b=APVJyEm4aOe3vtSis/KmKEykq4Ni6FEYMfA/xbIHc7aE3vksQahUFc/ctYHYkcVW2m
 VPdWTnRfnh7ltAarThIflikBHb62u6WwMN6Bnvu49K4gK0YFlerSXnubrYUKvNB5BYyh
 Raf124RwwLQr3dpUkckudbmxpjD2LCc5pKjQZTI0R9Jh0IAq4XUkL3LkrIaO9RkWdxdJ
 H+D3jkxTp6IYnOS30yA5dZzKESvvYS6T818e+A9vQaHxAM5obsxJMMj4mwFdsW9sHudR
 1eXjA2MbfSAIISp6bnS9NbEYOUZ2EEJyO35/tvKXq1dGiKKKvP7MJcsSD7ZXjX4fPd+e
 BdXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786397876; x=1787002676;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lB6nNj707NuJjIyuK1uCPtMJPjvc61I/WcRZHId+tQM=;
 b=R2AseD8HczXAc0aVw4CmnnefaxEkbGExscuxCDoYP7mJUrDARszRROiuljmAAeHcqe
 2+vDzze9hAVoqcXtk3py82wrQO+/XfgpsIrdeCWPFzpFSwF6T4s/ZRSOZ0cXZVOXmsoP
 4UH2I39FUGGO6qWjCDGdtLctYijT8SgcaF8jW3wvL4cTwGxUKn1lVuqOi0XakACwlLlu
 tnFwacxg/zffR3CHgAVeO5dKaNa1/7OlRdMjo7Nb+JLtHUIfUz5P1G0tQ4Mjr8nG9bNP
 knMpxWRkaHPJWTjpLWzYqUdtYlG+2QE0fM6ZO8OV/4YMAl8+QqQIXSu1fwbPyVTIF4Kr
 wCrw==
X-Gm-Message-State: AOJu0YxpjZVQrrFWVfOc0WeN4J2Hf3RhrhFP61k41Ih1LXOiTjAKl9VA
 fmUiIcKrKJmga3vJv4ba9ht4fyW2N6tcHLgg3k6QcM1lpSSdlFkELmznybG+EScP9OHwv/y8vl1
 O1EA+eq2Jsth0eaUaQv15O+KO1KS5MdZL1T5jr10stfuYwDYVdkx9KlJL2Z7mNVDniw==
X-Gm-Gg: AR+sD13h5fpe+NzfjwL2KmGuxeGYW4DK0hBEpS/rIyoru4qR6Zu0CgtkTXLokRsf7RI
 /A//dSKfs9Hlf18x0QJ1lYM9eNW7GAiUHcWLOImlh/15WLszQQyVEnp4QnTFSjs2a5mwtGXTqZs
 bGymxt2KC0po/Zql3m2NfB34lUYfTJoa8++b9e3R/IA44M1DCbeScku9cvccaJtZEqSYwpb829Y
 EqHTqGm/6GFcJtbaaG1aHQC6pikCt3jC4Q6jp/3oRyiHQ/8NyfFT907p2m321Tk8VrIDPOUGLmU
 B8p50BdKGKu3oy4vSprk6xEhyFarcv+LaPf1N0wEm4SwTveeQDn/eFJY958fpceFy/nYGq3NNQB
 xakdFa9j2CkIYWfa00PrhNqSJDgeNDp0mgSu/F2VAqKGp1mc=
X-Received: by 2002:ac8:58c2:0:b0:51c:9ab2:dfd2 with SMTP id
 d75a77b69052e-52d4bc9da8emr50686321cf.33.1786397876013; 
 Mon, 10 Aug 2026 14:37:56 -0700 (PDT)
X-Received: by 2002:ac8:58c2:0:b0:51c:9ab2:dfd2 with SMTP id
 d75a77b69052e-52d4bc9da8emr50685871cf.33.1786397875556; 
 Mon, 10 Aug 2026 14:37:55 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-480021fb89bsm35835876f8f.30.2026.08.10.14.37.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 10 Aug 2026 14:37:54 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Corey Minyard <minyard@acm.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-s390x@nongnu.org
Subject: [PATCH 4/4] hw/nmi: Remove unused @cpu_index and @errp arguments
Date: Mon, 10 Aug 2026 23:37:22 +0200
Message-ID: <20260810213723.58467-5-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260810213723.58467-1-philmd@oss.qualcomm.com>
References: <20260810213723.58467-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDE4MiBTYWx0ZWRfX6oCB4BxqxpXf
 CN9uBtYmY5OeTphJCBdLKM7u5enKLGCiV4GH741sH3zoybVOOdBWEBmFbkM+xo8aHlK7B3BEHfx
 jqvQX/hBgBmLSfIOv3FsNeC4qqYaZbYkcwl7Gm40V5Rkh+YmDO2JLxNjVSdyNlL51bvUuEyN3qu
 EvSlLw/k+B08s+CYX6kMoX3Kw6FGStaM4T1cxL6QA1yPyj0JLk7vj0NOGxvvkY1DzDY1mslQM1M
 RQQpqscYo7/Gn/fVCCJcI7vAOTl+Y7LLtB2i4fuQBpW3vPHEMYigqfg7aonNER4rc7OQprq0sCC
 zSDW8e5fOFq2NEuCM0tJ4Psj9XxLhgFFKkV2E0V0gE8Cl3JGr1raf6teF3PI/sx+/7srNi6iuCl
 MPf8IPKNOlytvlHpM2jX/XEKPRMQbXNugurCqdUUITai01Z/s56Bwn9ysQysk23NZAvjoBnFqkP
 ja98lfY2ToO29+k368Q==
X-Proofpoint-ORIG-GUID: GQ_EEpCdRns190S6qePCdT_rbDJSCtiN
X-Authority-Analysis: v=2.4 cv=KLtqylFo c=1 sm=1 tr=0 ts=6a7a44b4 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=l7mRzedawI2mqaqXN0wA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: GQ_EEpCdRns190S6qePCdT_rbDJSCtiN
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDE4MiBTYWx0ZWRfX6Qf75V8JLApu
 ukvh5rTEeeBw/0pQ7nIiILf4P/K43fAF36Wyj4G3++NgWpJKGd628yx1fS3ADyIrPL5SRqztxTK
 tXxrGf2IRD9SVfWqyGNKF0hBqRghDzg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_05,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 priorityscore=1501 bulkscore=0 spamscore=0
 adultscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608100182
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

NMI delivery never fails: remove the unused @errp argument.
nmi_handler() neither use the @cpu_index argument, remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 include/hw/core/nmi.h | 2 +-
 hw/core/nmi.c         | 7 ++-----
 hw/hppa/machine.c     | 4 ++--
 hw/i386/x86.c         | 5 ++---
 hw/intc/m68k_irqc.c   | 4 ++--
 hw/m68k/q800-glue.c   | 4 ++--
 hw/misc/macio/gpio.c  | 4 ++--
 hw/ppc/pnv.c          | 7 +++----
 hw/ppc/spapr.c        | 4 ++--
 9 files changed, 18 insertions(+), 23 deletions(-)

diff --git a/include/hw/core/nmi.h b/include/hw/core/nmi.h
index 2f554d58b7f..476b5d02fa1 100644
--- a/include/hw/core/nmi.h
+++ b/include/hw/core/nmi.h
@@ -37,7 +37,7 @@ typedef struct NMIState NMIState;
 struct NMIClass {
     InterfaceClass parent_class;
 
-    void (*nmi_monitor_handler)(NMIState *n, int cpu_index, Error **errp);
+    void (*nmi_handler)(NMIState *ns);
     void (*nmi_cpu_handler)(NMIState *ns, CPUState *cs);
 };
 
diff --git a/hw/core/nmi.c b/hw/core/nmi.c
index fb623fd00be..3f4ef5b2094 100644
--- a/hw/core/nmi.c
+++ b/hw/core/nmi.c
@@ -45,11 +45,8 @@ static int do_nmi(Object *o, void *opaque)
         ns->handled = true;
 
         /* Generic handler */
-        if (nc->nmi_monitor_handler) {
-            nc->nmi_monitor_handler(n, ns->cpu_index, &ns->err);
-            if (ns->err) {
-                return -1;
-            }
+        if (nc->nmi_handler) {
+            nc->nmi_handler(n);
         }
         /* Per vCPU handler */
         if (nc->nmi_cpu_handler) {
diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index d762163ddf5..93874b5d5c9 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -829,7 +829,7 @@ static void hppa_machine_reset(MachineState *ms, ResetType type)
     cpu[0]->env.cmdline_or_bootorder = 'c';
 }
 
-static void hppa_nmi(NMIState *n, int cpu_index, Error **errp)
+static void hppa_nmi(NMIState *ns)
 {
     CPUState *cs;
 
@@ -851,7 +851,7 @@ static void hppa_machine_common_class_init(ObjectClass *oc, const void *data)
     mc->default_ram_id = "hppa.ram";
     mc->default_nic = "tulip";
 
-    nc->nmi_monitor_handler = hppa_nmi;
+    nc->nmi_handler = hppa_nmi;
 }
 
 static void HP_B160L_machine_init_class_init(ObjectClass *oc, const void *data)
diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index dc7f0d56b01..201746945d5 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -147,9 +147,8 @@ static const CPUArchIdList *x86_possible_cpu_arch_ids(MachineState *ms)
     return ms->possible_cpus;
 }
 
-static void x86_nmi(NMIState *n, int cpu_index, Error **errp)
+static void x86_nmi(NMIState *ns)
 {
-    /* cpu index isn't used */
     CPUState *cs;
 
     CPU_FOREACH(cs) {
@@ -389,7 +388,7 @@ static void x86_machine_class_init(ObjectClass *oc, const void *data)
     mc->get_default_cpu_node_id = x86_get_default_cpu_node_id;
     mc->possible_cpu_arch_ids = x86_possible_cpu_arch_ids;
     mc->kvm_type = x86_kvm_type;
-    nc->nmi_monitor_handler = x86_nmi;
+    nc->nmi_handler = x86_nmi;
 
     object_class_property_add(oc, X86_MACHINE_SMM, "OnOffAuto",
         x86_machine_get_smm, x86_machine_set_smm,
diff --git a/hw/intc/m68k_irqc.c b/hw/intc/m68k_irqc.c
index 68ddb5351be..5d4e5a10ab8 100644
--- a/hw/intc/m68k_irqc.c
+++ b/hw/intc/m68k_irqc.c
@@ -70,7 +70,7 @@ static void m68k_irqc_instance_init(Object *obj)
     qdev_init_gpio_in(DEVICE(obj), m68k_set_irq, M68K_IRQC_LEVEL_NUM);
 }
 
-static void m68k_nmi(NMIState *n, int cpu_index, Error **errp)
+static void m68k_nmi(NMIState *n)
 {
     m68k_set_irq(n, M68K_IRQC_LEVEL_7, 1);
 }
@@ -97,7 +97,7 @@ static void m68k_irqc_class_init(ObjectClass *oc, const void *data)
     InterruptStatsProviderClass *ic = INTERRUPT_STATS_PROVIDER_CLASS(oc);
 
     device_class_set_props(dc, m68k_irqc_properties);
-    nc->nmi_monitor_handler = m68k_nmi;
+    nc->nmi_handler = m68k_nmi;
     device_class_set_legacy_reset(dc, m68k_irqc_reset);
     dc->vmsd = &vmstate_m68k_irqc;
     ic->get_statistics = m68k_irqc_get_statistics;
diff --git a/hw/m68k/q800-glue.c b/hw/m68k/q800-glue.c
index ac9062c6488..6a9592182a4 100644
--- a/hw/m68k/q800-glue.c
+++ b/hw/m68k/q800-glue.c
@@ -159,7 +159,7 @@ static void glue_auxmode_set_irq(void *opaque, int irq, int level)
     s->auxmode = level;
 }
 
-static void glue_nmi(NMIState *n, int cpu_index, Error **errp)
+static void glue_nmi(NMIState *n)
 {
     GLUEState *s = GLUE(n);
 
@@ -237,7 +237,7 @@ static void glue_class_init(ObjectClass *klass, const void *data)
     dc->vmsd = &vmstate_glue;
     device_class_set_props(dc, glue_properties);
     rc->phases.hold = glue_reset_hold;
-    nc->nmi_monitor_handler = glue_nmi;
+    nc->nmi_handler = glue_nmi;
 }
 
 static const TypeInfo glue_info_types[] = {
diff --git a/hw/misc/macio/gpio.c b/hw/misc/macio/gpio.c
index 1a7c534d652..f6fce5b3532 100644
--- a/hw/misc/macio/gpio.c
+++ b/hw/misc/macio/gpio.c
@@ -188,7 +188,7 @@ static void macio_gpio_reset(DeviceState *dev)
     macio_set_gpio(s, 1, true);
 }
 
-static void macio_gpio_nmi(NMIState *n, int cpu_index, Error **errp)
+static void macio_gpio_nmi(NMIState *n)
 {
     macio_set_gpio(MACIO_GPIO(n), 9, true);
     macio_set_gpio(MACIO_GPIO(n), 9, false);
@@ -201,7 +201,7 @@ static void macio_gpio_class_init(ObjectClass *oc, const void *data)
 
     device_class_set_legacy_reset(dc, macio_gpio_reset);
     dc->vmsd = &vmstate_macio_gpio;
-    nc->nmi_monitor_handler = macio_gpio_nmi;
+    nc->nmi_handler = macio_gpio_nmi;
 }
 
 static const TypeInfo macio_gpio_init_info = {
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index c0cb45dbfbc..817f2ed7ae4 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -3552,12 +3552,11 @@ static void pnv_cpu_do_nmi(PnvChip *chip, PowerPCCPU *cpu, void *opaque)
     async_run_on_cpu(CPU(cpu), pnv_cpu_do_nmi_on_cpu, RUN_ON_CPU_HOST_INT(0));
 }
 
-static void pnv_nmi(NMIState *n, int cpu_index, Error **errp)
+static void pnv_nmi(NMIState *ns)
 {
     PnvMachineState *pnv = PNV_MACHINE(qdev_get_machine());
-    int i;
 
-    for (i = 0; i < pnv->num_chips; i++) {
+    for (int i = 0; i < pnv->num_chips; i++) {
         pnv_chip_foreach_cpu(pnv->chips[i], pnv_cpu_do_nmi, NULL);
     }
 }
@@ -3583,7 +3582,7 @@ static void pnv_machine_class_init(ObjectClass *oc, const void *data)
     mc->default_ram_size = 1 * GiB;
     mc->default_ram_id = "pnv.ram";
     ispc->print_info = pnv_pic_print_info;
-    nc->nmi_monitor_handler = pnv_nmi;
+    nc->nmi_handler = pnv_nmi;
 
     object_class_property_add_bool(oc, "hb-mode",
                                    pnv_machine_get_hb, pnv_machine_set_hb);
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index b79828b4e90..a2195796efe 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3550,7 +3550,7 @@ void spapr_do_system_reset_on_cpu(CPUState *cs, run_on_cpu_data arg)
     }
 }
 
-static void spapr_nmi(NMIState *n, int cpu_index, Error **errp)
+static void spapr_nmi(NMIState *ns)
 {
     CPUState *cs;
 
@@ -4652,7 +4652,7 @@ static void spapr_machine_class_init(ObjectClass *oc, const void *data)
     mc->nvdimm_supported = true;
     smc->resize_hpt_default = SPAPR_RESIZE_HPT_ENABLED;
     fwc->get_dev_path = spapr_get_fw_dev_path;
-    nc->nmi_monitor_handler = spapr_nmi;
+    nc->nmi_handler = spapr_nmi;
     vhc->cpu_in_nested = spapr_cpu_in_nested;
     vhc->deliver_hv_excp = spapr_exit_nested;
     vhc->hypercall = emulate_spapr_hypercall;
-- 
2.53.0


