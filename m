Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F9F606A319
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 21:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=AITw8uVq;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Ibd0xtgy
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xK0nR-0001mV-MX; Thu, 22 Oct 2026 17:58:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xK0nO-0001lO-Uy
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 17:57:58 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xK0nN-0000Gz-4W
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 17:57:58 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69MKDenm1230415
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 21:57:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 jLMOrNYPQSF49sQNsRBHe+BAzwP9vHmvUbmzXhvfuXc=; b=AITw8uVqTPwVCZLO
 Me9+OoLBbKZyj8SupM+egujAAMIslYynuI1iaMW4Iz26JrhMP5ut4/ArT7QaRXqU
 GqIGXLQHvt3JkrZFyBiR4FHaSTegCHW5UpfIp/APobkrITNn+7K0apZOmz1nJhpW
 Il+Mz+bLTsVA1XHqYg8BWbF+sGZ+hqgf1AM7FoX/SRgFxdokqYCFnh0nynbMrMJW
 qEP4TJLPZHNNGcXViJZhv5mVa9suAsuP3bfAqnhJOH2XS9YqzXofTsC9zgIxnraa
 TmNbFy6/ysf9XLBllkYiZ1WxgDbgMG4L9dTPXnQKltMoNImU9zgNm8lrn3w9PDh7
 YykpXg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqmj8rbn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 21:57:55 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3acc98e3b3cso213024a91.3
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 14:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792706275; x=1793311075; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=jLMOrNYPQSF49sQNsRBHe+BAzwP9vHmvUbmzXhvfuXc=;
 b=Ibd0xtgyuGpnkQB7aQmpy5wcuXW/x92wLUCGpe/l1+9ssobvOHmmQJ5ko2qcij6EfJ
 XjSTtSvgm4vVvwcyWSrkrsP0rITNYy/TFpFhW9thtVR1oWEioBwSjArAM36B23DSN/Or
 lLj+l4tXORzjhGSAO52fE2FbljsfzrwjTRMVLLcelx1ZhIAeSN02BzIs+1ryUy1DxXFb
 n3FczXiaXFBYUr3oFCkmaJ/0nfXIBvdyfMPF5LiaLEve61OO3ChFK0GOjS82bz+AtkN9
 aw43x92jG+NZ2LSawi0tzAfCCuuG2j6t7wBLnOgiLPW6p0PO1090OxVU2TIqr3AO7wSX
 11cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792706275; x=1793311075;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jLMOrNYPQSF49sQNsRBHe+BAzwP9vHmvUbmzXhvfuXc=;
 b=UwtilzLI24K7o7dVGr2QqH13ANk+EEl01JP029sDB+1QWAgznmCNv/ToJu0i3iWweG
 RxPTuhPcsflw/nAPPk5tpdVv+9Zc6QwfDzfSllfqHO37mXcPNWKfSZoMkaTZiiDyyDxv
 oVbjJZhyGZ9XUR8IJPjyURc86IFWpUBM0WozrOejAyteS9OKB9Ea7RKyzOXA/xkl8Fui
 XG2IXQQ+muGMAHqldob+uYHHPNuAurjvHz1pf9L+oWQcZDd2h8OAXa9e45BtJI5U1r6Q
 E/FHAUY4MZ4LZG3UeLPzPcuP1apz+P6W+0z2ePGn4FnFo0r++rhPbgo9ox1jdLEBurXb
 u4Hw==
X-Gm-Message-State: AFq9FYK48yx79lP9cAiH8DhLHUFPH/5lHSD5AlIgVvopOuhyIJehwrQG
 e7yu1Jnk0Y/9ZmEVWbQiRdzc+6lYtQ7I/IlfLPDPLW9m1rGNCHNwZjPRz173ZjSXOay0RYlVFWW
 nRqdW56MkLapCJPbR2IGaI8SAvJaoV7DkXxtUKvTdHwJQiq2XFRB7eutARTS4moLrvw==
X-Gm-Gg: AYBFou1cOHTch5/q9j/CZG0mwRYOGWNcr8lwG+q/y5tvCkJticWUO6y5GYxoB5DO9gD
 Ho817zDSf6zBwUuBwzwEvj00iC3GiRzvuDLNGEsAkaOkdGG2UJZpaNHzqW+Wjv11+K48zUxhFgs
 0UPjdeG5qaHI+8rM3WJdOCs/Ujf4fJwdQPYyFYzadKaxu6AeAnvdMczB6OeuVwjkDcAXuqD3oqc
 /p5zVTBtZkrfugr6QVZp2TldPKRhKb/PVQ2V1BCxHdN3jHwBD36YD0RilDvR+2MjiM52mYuzhn6
 Ly+hSi0jVASB7TrgM7+tQdHJGvaAFL26V47MT8gN9ag9AnEemZfX/gtN9Qg3BVypTbX64nHw8vG
 XQ/immDQwXs4iiYz23rPQmL7yXex2Rkd3WNwlD1V3+uOI1Jg/KzzN/5ZpXL+zDCE=
X-Received: by 2002:a17:90b:3846:b0:3ac:9ed8:f310 with SMTP id
 98e67ed59e1d1-3adce7ab90bmr138229a91.49.1792706274622; 
 Thu, 22 Oct 2026 14:57:54 -0700 (PDT)
X-Received: by 2002:a17:90b:3846:b0:3ac:9ed8:f310 with SMTP id
 98e67ed59e1d1-3adce7ab90bmr138218a91.49.1792706274164; 
 Thu, 22 Oct 2026 14:57:54 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3adca62e477sm648061a91.2.2026.10.22.14.57.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 14:57:53 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 07/27] target/i386: implement get_dump_info sysemu op
Date: Thu, 22 Oct 2026 14:57:26 -0700
Message-ID: <20261022215747.2479440-8-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261022215747.2479440-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261022215747.2479440-1-pierrick.bouvier@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 6wTAi5LCiNtAsImZ6wG0IQPzHBGhZb7F
X-Authority-Analysis: v=2.4 cv=cPR1IVeN c=1 sm=1 tr=0 ts=6ada86e3 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=KBKSk-pTE1mK2UdVZucA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA4NyBTYWx0ZWRfX6oKwcqpJxYtI
 Dbr2GYx7DM2WYtBXSRGjFYfeL8Roh0nrjm5rXH768k3CcO+6lnaZuAYAVRmeB1gDOqIwOMYwuBa
 D7UstFi/yL7NMiyTJxGuR4iefUX3a5s=
X-Proofpoint-ORIG-GUID: 6wTAi5LCiNtAsImZ6wG0IQPzHBGhZb7F
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA4NyBTYWx0ZWRfX4f8ZdahhLq03
 G3KdjogQicsl6hRcGyr7rpn5dilw1oPfmEsqESIlEoSHQDv/NY2OKhqzhytt0V1x28I+V1UQwAC
 pzDjVvpMJrGBpIPvOQh0kGwOZD1hIfZ5e+ahizEn2cp5HSjsUa0cL2wKlgXgjaWx1HsfYpW5mLN
 g+cUEsOh3ZUPVmH4UlZcXFCHiyoYMLio94SgUpH6I1TUXsTkfhm0SghwGDaKvrqM8vSu2PLkLj+
 WqBLAh+FLA9609zxERe6LRFQBcK4VEBi+qddHCSIqhIR21WgbYZ9varY/EX/AL9oMswJFLZfbKd
 voL+epMJjH+IIkkAO19P9FLlal0AD92uXP3vY0h8Gpio7ca33e5YOZh7oEbRqvqSlrdhc24DeSy
 A4dMn1TPmd5xJw27py0X+fcF2kQb341HoNGu8FwT7jLVp97h3ADb+3Je+nv5L2P2cq5R+Lhz0KC
 MfjvbQwrDr1Te2wi7Jg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 suspectscore=0
 impostorscore=0 priorityscore=1501 malwarescore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220087
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

For now, we keep the global cpu_get_dump_info symbol defined.

Reviewed-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20261021181244.867840-8-pierrick.bouvier@oss.qualcomm.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 target/i386/arch_dump.c    | 18 ++++++++++++++----
 target/i386/cpu-internal.h |  3 +++
 target/i386/cpu.c          |  1 +
 3 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/target/i386/arch_dump.c b/target/i386/arch_dump.c
index 16e47c4747d..ed273708c60 100644
--- a/target/i386/arch_dump.c
+++ b/target/i386/arch_dump.c
@@ -16,6 +16,7 @@
 #include "system/dump.h"
 #include "elf.h"
 #include "system/memory_mapping.h"
+#include "cpu-internal.h"
 
 #define ELF_NOTE_SIZE(hdr_size, name_size, desc_size)   \
     ((DIV_ROUND_UP((hdr_size), 4)                       \
@@ -394,15 +395,15 @@ int x86_cpu_write_elf32_qemunote(WriteCoreDumpFunction f, CPUState *cs,
     return cpu_write_qemu_note(f, &cpu->env, s, 0);
 }
 
-int cpu_get_dump_info(ArchDumpInfo *info,
-                      const GuestPhysBlockList *guest_phys_blocks)
+void x86_get_dump_info(const CPUState *cs, ArchDumpInfo *info,
+                       const GuestPhysBlockList *guest_phys_blocks)
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
@@ -425,7 +426,16 @@ int cpu_get_dump_info(ArchDumpInfo *info,
             }
         }
     }
+}
 
+int cpu_get_dump_info(ArchDumpInfo *info,
+                      const GuestPhysBlockList *guest_phys_blocks)
+{
+    if (first_cpu == NULL) {
+        return -1;
+    }
+
+    x86_get_dump_info(first_cpu, info, guest_phys_blocks);
     return 0;
 }
 
diff --git a/target/i386/cpu-internal.h b/target/i386/cpu-internal.h
index 37c61a1bc3d..75bbd00bc7a 100644
--- a/target/i386/cpu-internal.h
+++ b/target/i386/cpu-internal.h
@@ -65,6 +65,9 @@ void x86_cpu_get_crash_info_qom(Object *obj, Visitor *v,
 void x86_cpu_apic_create(X86CPU *cpu, Error **errp);
 void x86_cpu_apic_realize(X86CPU *cpu, Error **errp);
 void x86_cpu_machine_reset_cb(void *opaque);
+
+void x86_get_dump_info(const CPUState *cs, ArchDumpInfo *info,
+                       const GuestPhysBlockList *guest_phys_blocks);
 #endif /* !CONFIG_USER_ONLY */
 
 #endif /* I386_CPU_INTERNAL_H */
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 5da80ade70e..49f453bb011 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -10920,6 +10920,7 @@ static const struct SysemuCPUOps i386_sysemu_ops = {
     .write_elf64_note = x86_cpu_write_elf64_note,
     .write_elf32_qemunote = x86_cpu_write_elf32_qemunote,
     .write_elf64_qemunote = x86_cpu_write_elf64_qemunote,
+    .get_dump_info = x86_get_dump_info,
 #ifdef CONFIG_HMP
     .monitor_defs = x86_monitor_defs,
 #endif
-- 
2.47.3


