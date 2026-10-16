Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72550CCF2C2
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 18:15:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHmS1-00079C-PY; Fri, 16 Oct 2026 14:14:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHmRs-000781-HC
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 14:14:34 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHmRr-0000Wk-0k
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 14:14:32 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69GG3YJd3260314
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 18:14:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=rV8Bi9ZeDb1
 EsS+gJuatp5brX7qzcoQ8TjRgOYQqDxQ=; b=l7IIRVDfJmxf9Hjusm1zY2bcBb/
 2Adl9/pSjYFWps/PRQYYOiCc15nV5RWQRskPR/y9Z4ksQZ7VjagfU02hZVeT1Ev0
 e3wXjuIwr17ifkYT+TsFH76YLwQJDdw5a8H2fPCr9pZIvrdV4zKN69s6Le5ii+wW
 hSr66moUE19XYI8mab3og6yNhjScak+wCtkiz1nCtcPp8nU7C2a6gqU6VC9EGjCE
 62jYBZPlHNKTqwnjduRf7xCNjfpqA6Rw3g+OKApWtEQBixsvCfkTqrsdR2xadWF7
 ZiE67KqTQWGB6uMU9EVQsZvwKRU68iGxs38SWW+zJo5cT/pEmTh1Y5KRyhw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hbq450gd3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 18:14:30 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3ac575a9198so355353a91.3
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 11:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792174469; x=1792779269; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rV8Bi9ZeDb1EsS+gJuatp5brX7qzcoQ8TjRgOYQqDxQ=;
 b=YWloEn2l8CrhPgd3t2639TBpIi4pys5KC3WaYLcdmSr8uSRemtQEk41Y4rAF9MeY+V
 ANLZm5/2PCEGSLG+WychKACjU1j/OeD6pNUpeiwC+laH5wSLfY8vIYtWtolKDljjLBZs
 XOvALt0dTGM588u5SMMf/+2c2ENYltfGmnIzEqZqIBx4IPA27RNMnFfR4GErw8zvU+Y/
 LLRnVIOCW97YH6DDR8QK+ojOlhzVdusBs1ITe/Xw7qg2uonD1H0bLFr25MjnKEAPTwhc
 iCBk4X+eCPm0m5VU+PoX5yY33d+H7BGtCBEDJf+2YDUL+SGpaF9KMU6xBsh2sgCuwnuL
 O/0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792174469; x=1792779269;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=rV8Bi9ZeDb1EsS+gJuatp5brX7qzcoQ8TjRgOYQqDxQ=;
 b=QV9NxIBN6ZoUEu3idODC3lD4u32dVFwPY513ywp1C5zt/JVPnlgOS39mcFrzzvI85q
 pSZQ2ChX5y4gfgZ7cZJoig2iHMzUIQW/LiehOS0JmppMvojTaRmFHVhzHTyxlurVgq2y
 9Kkr955j53UOELIrm/ui2YMAmiPiTh26S/3kG/7+RhpPq0/pbRzA0TW54XzmUVxYUnnz
 m89r22B5VGSkWCe38sWpEsc+pSc6jCPg7NesVARdctYneyTy/uFAVJ1CXRVz/o4Von8e
 Tvvb+cbNPqftBKKV1HqeDSdo7IFmv/EOb5woB03huEBPmQfsttlxH55TGkRp9L+YQK3C
 Z1Gg==
X-Gm-Message-State: AFq9FYI067IzfVHrEo9/IRLq0s7T8U5fu0c4aVrbcjxOubWy6ERqJixN
 yMZAEnWgOloejomDthjjiInkjWbbNvq7HxNuYpXt03cVqcIXnYWIx/mZs1ylqP3QFHmCDpsssUG
 EMbrtexesl9v29ttU//QmZZUtNZC277kLcCfQvAKuW6QeW7S6MKOU+l1vzpWu8uM5oA==
X-Gm-Gg: AYBFou0xl7xf81MpjuFnd9eF3QX4W7BeEUn0j/5TSrybvN4VNIkGtjZ4SSRz6Lu83SB
 vHB20ILZt+yNOCAtzFiMDlV5J0q8LLZlWyPIBFULNo18g4LnLXUGlz1OQGgF9DxeX7QVogMECpQ
 XGWsGNZf93TTdk7f7VSN63j1AYVHZPkVefCFsRWF0tX2A7bbijxjs3gblEwmYI6jiiR4jCcUhsY
 GvX///QcjJBRMnepdG4kuZ3RMWTJP6+6+T3oF9XSil96gFL8muVKe5lh3kXI+zuyEi/sD9wgmN/
 oSms5r3Vaor3Yk+ZFCwY8/JBpbs91FyEDj3v1p0lplLb70BGfuGq6AJfKSkXLkePw/Z+/2dWfY7
 6I18QCHcT8XeqS0e/rpfk/GuBEkeayZIelWbzzFG4W9zsO0w1S4ChfublvOheFNA=
X-Received: by 2002:a17:90b:5803:b0:3ab:36c4:b500 with SMTP id
 98e67ed59e1d1-3acee27acb6mr609545a91.5.1792174469195; 
 Fri, 16 Oct 2026 11:14:29 -0700 (PDT)
X-Received: by 2002:a17:90b:5803:b0:3ab:36c4:b500 with SMTP id
 98e67ed59e1d1-3acee27acb6mr609522a91.5.1792174468794; 
 Fri, 16 Oct 2026 11:14:28 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3acc48e8646sm4895282a91.10.2026.10.16.11.14.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 11:14:27 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 anjo@rev.ng,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v3 09/23] target/ppc: implement get_dump_info sysemu op
Date: Fri, 16 Oct 2026 11:13:56 -0700
Message-ID: <20261016181410.191743-10-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261016181410.191743-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261016181410.191743-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: alg23QC5boAYYvtWQRlXZTYNmF9I5kXd
X-Proofpoint-GUID: alg23QC5boAYYvtWQRlXZTYNmF9I5kXd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDA3MiBTYWx0ZWRfX6KPfxKMa0RKW
 Pedk3hIaO3/ybm9jDYatnhOxj2F+xHQCwqiLR2G/h9xFye1mNRmuz89JT04uKS0VpQhCSiwmo2A
 vASFrYHn3x+aLAOeMJqull7fZ/58tD+79/vlDr91cB/WpReCd3ZIvh7qlZ1VXI+GcQwOU/qJ/6u
 HiPbLXDXoTKdsRJQjp5yD16X6wL1Qninpfy33VQ4OL+Py/MryE7afYakOueEJw5kgJzPu9dcM5U
 9k4cJozBw826jqlK81rz0jG9SYHRfQwY9MsNYE/jeW8YxbsMIUPzu8iPKzRnLKP42yEGTMO0yFj
 dN0hT+rZSIrTPNFl0wSnkWBFRRbzmfhDM/NGaFsX0G+TsIs1yOtVNYyUMrPSRRpIhBwAYDeSC8i
 izWuGMZ/6caJIwcVWMzxuBY8v/0gUJbCcHs6+RRKhmRcfCH8NtX+P35wJyUC79Yu/Q4DOz1rr9Y
 zxhsyyrzZP0kNLPgScg==
X-Authority-Analysis: v=2.4 cv=e4GT2qp/ c=1 sm=1 tr=0 ts=6ad26986 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=HC5FQ_MKihgnNVCgyfIA:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDA3MiBTYWx0ZWRfX4xInfksZj2pI
 7HZroOWAmN9maOUWV0aHLcgjqlXuH/pk1p1Zn512HzFvBgbVcvyCzKuFghoXgUjfF98PUhlVdeN
 RrfWxuxZtKYex/vRRCZLO0AzkzmAxlY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_02,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 suspectscore=0 malwarescore=0 spamscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610160072
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

Reviewed-by: Anton Johansson <anjo@rev.ng>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 target/ppc/arch_dump.c | 23 ++++++++++++++---------
 target/ppc/cpu_init.c  |  1 +
 target/ppc/internal.h  |  5 +++++
 3 files changed, 20 insertions(+), 9 deletions(-)

diff --git a/target/ppc/arch_dump.c b/target/ppc/arch_dump.c
index 80ac6c3e320..7cb97082926 100644
--- a/target/ppc/arch_dump.c
+++ b/target/ppc/arch_dump.c
@@ -17,6 +17,7 @@
 #include "elf.h"
 #include "system/dump.h"
 #include "system/kvm.h"
+#include "internal.h"
 
 #ifdef TARGET_PPC64
 #define ELFCLASS ELFCLASS64
@@ -229,16 +230,10 @@ static const struct NoteFuncDescStruct {
 
 typedef struct NoteFuncDescStruct NoteFuncDesc;
 
-int cpu_get_dump_info(ArchDumpInfo *info,
-                      const struct GuestPhysBlockList *guest_phys_blocks)
+int ppc_get_dump_info(const CPUState *cs, ArchDumpInfo *info,
+                      const GuestPhysBlockList *guest_phys_blocks)
 {
-    PowerPCCPU *cpu;
-
-    if (first_cpu == NULL) {
-        return -1;
-    }
-
-    cpu = POWERPC_CPU(first_cpu);
+    const PowerPCCPU *cpu = POWERPC_CPU(cs);
 
     info->d_machine = PPC_ELF_MACHINE;
     info->d_class = ELFCLASS;
@@ -257,6 +252,16 @@ int cpu_get_dump_info(ArchDumpInfo *info,
     return 0;
 }
 
+int cpu_get_dump_info(ArchDumpInfo *info,
+                      const struct GuestPhysBlockList *guest_phys_blocks)
+{
+    if (first_cpu == NULL) {
+        return -1;
+    }
+
+    return ppc_get_dump_info(first_cpu, info, guest_phys_blocks);
+}
+
 ssize_t cpu_get_note_size(int class, int machine, int nr_cpus)
 {
     int name_size = 8; /* "CORE" or "QEMU" rounded */
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index b711f9c0a85..5853a92bffd 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -7473,6 +7473,7 @@ static const struct SysemuCPUOps ppc_sysemu_ops = {
     .get_phys_addr_debug = ppc_cpu_get_phys_addr_debug,
     .write_elf32_note = ppc32_cpu_write_elf32_note,
     .write_elf64_note = ppc64_cpu_write_elf64_note,
+    .get_dump_info = ppc_get_dump_info,
     .internal_is_big_endian = ppc_cpu_is_big_endian,
     .legacy_vmsd = &vmstate_ppc_cpu,
 };
diff --git a/target/ppc/internal.h b/target/ppc/internal.h
index a20a0f9f7e0..4238692a9eb 100644
--- a/target/ppc/internal.h
+++ b/target/ppc/internal.h
@@ -324,4 +324,9 @@ static inline int ger_pack_masks(int pmsk, int ymsk, int xmsk)
 TCGTBCPUState ppc_get_tb_cpu_state(CPUState *cs);
 #endif
 
+#ifndef CONFIG_USER_ONLY
+int ppc_get_dump_info(const CPUState *cs, ArchDumpInfo *info,
+                      const GuestPhysBlockList *guest_phys_blocks);
+#endif
+
 #endif /* PPC_INTERNAL_H */
-- 
2.47.3


