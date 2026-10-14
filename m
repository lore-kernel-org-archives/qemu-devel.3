Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99D20CC6B33
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 23:48:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xH8g0-0006wp-TX; Wed, 14 Oct 2026 19:46:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xH8fy-0006wA-M3
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 19:46:26 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xH8fw-0006QI-Gr
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 19:46:26 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69EM1MGq301075
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 23:46:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=FkmLZ0/PgKf
 U1+3kAqC65R2W35DO2t+OPelmPIX00AI=; b=Q91b7J3y/LrBwysWhip0gIgVK+v
 BFdKaoLtBWfgpb3B8BvbGsnL6xlLgDAbGN4qhQQamdIZ+aEJDzPTqHiYiUWWZVjc
 iwIv+R5SNO+QiebwH271yNVw8FiE1mHnEpKgjoIAtoSjYiG4zs3B4+D3UIUxX36R
 gXJRLYWL7QhY1xyPg/mEZwIEpH1Er97Qd+QYryDMRV9ycpSXG7CQhKGjzAlMjEWF
 sZowTJyuzWEyADuEMeRHeBABxqJbsWM9SyGZTtjWEmTSVywldPwyL2lfA3wIS1UK
 qQ2K3UyWIpYjsqlOLZASf3vF5rVpkJufpMnuzMhUPDcfB9EMT9Aw6TE6slg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ha4623y25-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 23:46:23 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-357e2bc3b1bso7483533eec.0
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 16:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792021582; x=1792626382; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FkmLZ0/PgKfU1+3kAqC65R2W35DO2t+OPelmPIX00AI=;
 b=PJX5FQ6BApfvsQZz50vVccjRM9DwJuGL+Lxwq7sCU9QEAls3r5ZvTZKFV3NDj/c7v3
 7b1sqN/g/76ir7mSa8mcu+sbOa2HqWjllVIerBLRxEowHG5uZNedKvaoB2IXSzl7dvsv
 obLwpmtYezss7hl4H5UmNSH4h77fgThAP8c11DUve9gEyiybWkt+ICeLiGOjULRqzKDl
 VptUrTM0E9tTTBce6qsFFs3V4skMLn5KEGjVMre5ood5RUFmUHvGkb/Ig+/i9+dpXIRX
 BBUzC8PRj4g7XDfJpCAOkDGeIbSvWb6QDuWFK5L+eOL0FP/spwLhsngOXHT8TJ9h1/ue
 KjRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792021582; x=1792626382;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=FkmLZ0/PgKfU1+3kAqC65R2W35DO2t+OPelmPIX00AI=;
 b=X1u5yld3azQ9r99YFx66eOAbS1Ugj8GoGa6WY/KfpQZZhZvCNGfShNRdQhmHeiPtSp
 X/VE68NBc7kVCfydUJSgaVKlK214wgKFTeFaPjZCCARtz/C8Ku4qtihmds7DV3PdT6QV
 kRmO8yC7Eqw03RZe1lUTFHgBIrVKZiNf0QXEoRAETl6jxE3tGVf1SwchiAo9HHPWMurB
 bFYv76d0Ot7XT8gag3rEMIj3JmoqV8Ho1qtZe8AxcoI/hCOC/EkIGrti7VlR6K5QfpM9
 ilMDEvlyps19H3p1+qFw68Nw2Yr8MW/uc76ShCvjQ/7jaAm4KDljYlucM4TbyfD3GlFo
 QDAQ==
X-Gm-Message-State: AFq9FYJ61zs8+mD6iPxV/Z7ST6qxQRB/byBL9PO8xFTJZInrlbAY/4wW
 z546a3HOJ8Omfa4RQkulGU/a5cAvKXhhywSqrB43JSnRacI22D9D3nS5lDMxriGJv/D+ZS+kdZU
 3FBU35oXjva/yoRNq9k1KLH0NvoorsDEUg4MIMNfSYJ5kd1gilxrxvugB5N+qAkKllQ==
X-Gm-Gg: AYBFou07kpWk/0ZhrMY9LATzV3pnQ8qWmQ1OPTDPVI26HvvDJX1PiVH2apW45WD9z8t
 47cUCPmB4ew/vQ4qYlDsISYeTs/sXHblieJYyQTQlvpXVEil7oiS8sJNuzWVrD0ui4GVM5w90C6
 0zZH35cxaNGGyIv+MhY0trC2eBYf+A6DSAFuuPqLbS2CXEJvQ2lXIDl+qznnrbfY+niDLDTpzHE
 h10OTJIuMWduCnREjwLd2Dvbj8botVHY36qed6JiMYPuxgi9fn2JHdj4qknTKDqm9fN/hyJ9zJT
 Rjb0DMNdSK06MLKeieTRGERh6aeK3tvmtzOlMUiGnPIESY0uVUX+RbC9vnPz0S40svjailEphIV
 O+0MA/tZe36R71Zvos1NX4WOp1c5jODyo90YwkN1soTh9VWbhNrtitreKnEFx
X-Received: by 2002:a05:7300:f582:b0:34c:5831:8a19 with SMTP id
 5a478bee46e88-3537e0493a0mr22737724eec.40.1792021581999; 
 Wed, 14 Oct 2026 16:46:21 -0700 (PDT)
X-Received: by 2002:a05:7300:f582:b0:34c:5831:8a19 with SMTP id
 5a478bee46e88-3537e0493a0mr22737700eec.40.1792021581451; 
 Wed, 14 Oct 2026 16:46:21 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-358de54fe47sm42506147eec.31.2026.10.14.16.46.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 16:46:21 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 03/19] target/i386: implement get_dump_info dump op
Date: Wed, 14 Oct 2026 23:45:49 +0000
Message-ID: <20261014234605.209084-4-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261014234605.209084-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261014234605.209084-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: vG5SKX878eBh4slz0zukLRu7msswta3M
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA5NCBTYWx0ZWRfXzmccbWa+Jh4I
 XWITv5b+7UkVWFZwZoJHCKKnI7Jqe+IwH0IWpr4rk6U33Nj04v3iXxVir76LcDnXWSR0mnAoM0e
 oGnY2BCgpfOaq52RLTFFGUG2R+lzvTzLR5LU3sVmElzCoGiS3c4heSA4nh7MfemD+IPJev/Mr02
 4sE6ieGEHQw/Qlivzaa8JpFD0uSxXSWFmU4VHkSSRyNCk8JGn0C9MplTVvsr1VLV+r1cnV1fUvs
 fETkMpVw08Ry2REuaBMLWz2Au9+sYcSSxCa6tve8zCj97Uud2tn64Ry7W4dVWx/C5l93ITKHQfv
 wiGWIP3uXHjaO5EdmG0EczU/Gcxz8S8M5P/st0x6fbfiVLX9UWlUUr0Ga1ExM+MmVi2EQ6zAXfP
 evKaZ+rv7FO7z1tKqobCklFfAJekdbjsB1b4aceuSJl/+cODOp1sh7nFJGcdkXMrRUH97G1hCQ0
 9E063nELylE88kEAWTA==
X-Authority-Analysis: v=2.4 cv=ErZHPicA c=1 sm=1 tr=0 ts=6ad0144f cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=v1y5J0KreYPJ0FnAcikA:9 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA5NCBTYWx0ZWRfX4b3ZRliPFERo
 o8u9cn/5yjkC1+gDdyKIF+MDYCeoHn+4xXVcocfKwyx04KnAnOel320KDXel344fH8/QRTrgLk7
 i3Ob+qQqrZ5TVuEjXxyrkvCmqH9QUIY=
X-Proofpoint-GUID: vG5SKX878eBh4slz0zukLRu7msswta3M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 bulkscore=0 impostorscore=0 adultscore=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610140094
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

For now, we keep the global cpu_get_dump_info symbol defined.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 target/i386/arch_dump.c    | 24 ++++++++++++++++++++----
 target/i386/cpu-internal.h |  2 ++
 target/i386/cpu.c          |  1 +
 3 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/target/i386/arch_dump.c b/target/i386/arch_dump.c
index 16e47c4747d..a8e74e6b24f 100644
--- a/target/i386/arch_dump.c
+++ b/target/i386/arch_dump.c
@@ -16,6 +16,8 @@
 #include "system/dump.h"
 #include "elf.h"
 #include "system/memory_mapping.h"
+#include "cpu-internal.h"
+#include "hw/core/dump-cpu-ops.h"
 
 #define ELF_NOTE_SIZE(hdr_size, name_size, desc_size)   \
     ((DIV_ROUND_UP((hdr_size), 4)                       \
@@ -394,15 +396,15 @@ int x86_cpu_write_elf32_qemunote(WriteCoreDumpFunction f, CPUState *cs,
     return cpu_write_qemu_note(f, &cpu->env, s, 0);
 }
 
-int cpu_get_dump_info(ArchDumpInfo *info,
-                      const GuestPhysBlockList *guest_phys_blocks)
+static int x86_get_dump_info(const CPUState *cs, ArchDumpInfo *info,
+                             const GuestPhysBlockList *guest_phys_blocks)
 {
     bool lma = false;
     GuestPhysBlock *block;
 
 #ifdef TARGET_X86_64
-    X86CPU *first_x86_cpu = X86_CPU(first_cpu);
-    lma = first_cpu && (first_x86_cpu->env.hflags & HF_LMA_MASK);
+    const X86CPU *cpu = X86_CPU(cs);
+    lma = !!(cpu->env.hflags & HF_LMA_MASK);
 #endif
 
     if (lma) {
@@ -429,6 +431,20 @@ int cpu_get_dump_info(ArchDumpInfo *info,
     return 0;
 }
 
+const DumpCPUOps i386_dump_ops = {
+    .get_dump_info = x86_get_dump_info,
+};
+
+int cpu_get_dump_info(ArchDumpInfo *info,
+                      const GuestPhysBlockList *guest_phys_blocks)
+{
+    if (first_cpu == NULL) {
+        return -1;
+    }
+
+    return x86_get_dump_info(first_cpu, info, guest_phys_blocks);
+}
+
 ssize_t cpu_get_note_size(int class, int machine, int nr_cpus)
 {
     int name_size = 5; /* "CORE" or "QEMU" */
diff --git a/target/i386/cpu-internal.h b/target/i386/cpu-internal.h
index 37c61a1bc3d..f2fc95b295b 100644
--- a/target/i386/cpu-internal.h
+++ b/target/i386/cpu-internal.h
@@ -65,6 +65,8 @@ void x86_cpu_get_crash_info_qom(Object *obj, Visitor *v,
 void x86_cpu_apic_create(X86CPU *cpu, Error **errp);
 void x86_cpu_apic_realize(X86CPU *cpu, Error **errp);
 void x86_cpu_machine_reset_cb(void *opaque);
+
+extern const struct DumpCPUOps i386_dump_ops;
 #endif /* !CONFIG_USER_ONLY */
 
 #endif /* I386_CPU_INTERNAL_H */
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 74eebeabd7a..21216c32125 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -10957,6 +10957,7 @@ static void x86_cpu_common_class_init(ObjectClass *oc, const void *data)
 #ifndef CONFIG_USER_ONLY
     cc->max_as = X86ASIdx_MAX;
     cc->sysemu_ops = &i386_sysemu_ops;
+    cc->dump_ops = &i386_dump_ops;
 #endif /* !CONFIG_USER_ONLY */
 #ifdef CONFIG_TCG
     cc->tcg_ops = &x86_tcg_ops;
-- 
2.43.0


