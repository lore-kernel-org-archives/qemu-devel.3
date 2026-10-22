Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5EF606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 21:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=CdZjuyo8;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=H8o+cmFx
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xK0nU-0001o4-VX; Thu, 22 Oct 2026 17:58:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xK0nS-0001n9-D9
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 17:58:02 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xK0nQ-0000I4-Jt
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 17:58:02 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69MIHlq14087410
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 21:57:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 TQxOJD9sdXe4P3cse9nrS6RZEtdZudlSJOZsX1XjkkQ=; b=CdZjuyo8+VW+xflv
 Bb+MQ8lFxROm1QY8Ek0I7DLlJ9clviygd5Fe/ZUEH8Y6QPz0+fhofyeBoNkdfcIO
 7vTHEEAAZu6OeLj/5tkpZf9c85esfZhBzXHovyQwyT3C93jAA6FrzcY+gFWcYEDB
 hhFhfYKQYMox1PMpVYoan5Yr1rLAtJlYk53nDOtdX/274yJc/eaw4WSk/5x/2vpU
 H9LY+A4vlDPWER8BvR0WGHo3PKo/ybqHItdCpjwX2CAu0chAGtpCEX0N9cFJki+U
 Zy29QAQb4jR4lSHC8SHw8Bakw+ZqZWHaO4uZR9thbcBw6/hKU+YtzTNvx9DIS4WW
 ujD7XA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqmtrq56-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 21:57:59 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-3ad30487d55so362331a91.2
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 14:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792706278; x=1793311078; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=TQxOJD9sdXe4P3cse9nrS6RZEtdZudlSJOZsX1XjkkQ=;
 b=H8o+cmFxkm9iiCfqUqJAPHTwdY8lMa/pJfqwsmhXXpcgGx6s6noTiZYoIGmHXDGsgT
 QP/fciHWZlQP7R8CSez5j0xs1USTTzOi0+R1z7o2/s1esUCY+lSg9+s65Z9GqT7tFh7X
 aecNuDPuRs5uL0cC6+SHCDxVx2uzzdirCX50EXFKqNaQnBUvpEpvcpQK7qVKyDMF5MMf
 RNBYqXyccX5VH4Dr1uveTv0ac54tAgsOBpPL+4+xc2gxWsM+hKoeCpNVIv76l7B8p2jo
 vtsUGaGgg/o9r4Pi4nQkvGIBNOQjwN9tzZjbWli+7Y/5JEWqnG31DE5I3AsFgzVsWtm9
 vTow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792706278; x=1793311078;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=TQxOJD9sdXe4P3cse9nrS6RZEtdZudlSJOZsX1XjkkQ=;
 b=aHlbgzPFY+n+til072UW99TfptOGgKcM8+G0euqmiXZlWUPvwfJi6pJNNa2/BQLopy
 N2rE2486mri0LWGTb/aIpL5KCWII6gOUZ337/xgl2YZuXwxETfxOX65e74ot29E3ye+E
 hBzYJxcb3oz3qYb/h9alEIZEkzjX7AELG0xQZXcUxqb7R+5vgWES2KII+qIBVcdrWazC
 Z+znmEvKwOEXNvzQfOrkLDbSGo8kBF5+vV6TxoHloOqgk8GVEj21JK4siHDPcbraq5Cm
 nGTHbJt3GmhnWmQh3+bjUxHd4ezqn+ZdXQojYvf3JFIX6j9SSujAiu77JGEhsO1cGA/K
 qQkw==
X-Gm-Message-State: AFq9FYKh2RqE+6dHTfsYlH5yy8mUaaEDO6rmyMBv9PJIJunjVrMyGvJx
 r9ClX/en6SZeCMPrDRnC9N118LxcUdD6j4ZhsXgYRLHt9RpZyAWVqbrDX+1hF8Th3lzovWIIpgx
 ARcvd+Wab2fnQwjIprtfwOFMticxERMXuNcsLt0bVfKPZNg4RGfEMiEJiGQHiroBJpg==
X-Gm-Gg: AYBFou0FZF7aLOn8jy06lMKrNuRQiIc9iKX5dHMGeQctvKI6AP4oZhTRUHPVmtuNolt
 a586ux3YrGJQj4+O65E+209S+13FfAG+7bNb4JeMl5r05h/siP9h3CtGvByeBJD1hZF13H+Z1nk
 /Fy1KxSc8wA/uTcJB85l8MQLK8w4nuAta0RMKsjaLTrtIL3AfM2WM0eSoLTkmwylmDnl8cHKSW5
 YkyXt2STVBNuD2U1xNMTZDdBl+rMM92b3OV+P5N1pWntO/JhgadrbXmqq/aE8RrURmbkHuBs1nl
 H36JByv4yevJ4mPIhzm5kMayBSFX5HfXFpPjNrfF2zglCz+WPXxl0B+/FG/DCNBXwTpSwVABhFe
 +zZqJol6GfZHgBNOT0wMhMRiSNjmSFokyElYPktoYcFIycqz+zshcF9pKVfbfDjw=
X-Received: by 2002:a17:90b:4a12:b0:3a4:b0f3:6597 with SMTP id
 98e67ed59e1d1-3adcd7fe438mr249905a91.0.1792706278549; 
 Thu, 22 Oct 2026 14:57:58 -0700 (PDT)
X-Received: by 2002:a17:90b:4a12:b0:3a4:b0f3:6597 with SMTP id
 98e67ed59e1d1-3adcd7fe438mr249892a91.0.1792706278091; 
 Thu, 22 Oct 2026 14:57:58 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3adca62e477sm648061a91.2.2026.10.22.14.57.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 14:57:57 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 10/27] target/riscv: implement get_dump_info sysemu op
Date: Thu, 22 Oct 2026 14:57:29 -0700
Message-ID: <20261022215747.2479440-11-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261022215747.2479440-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261022215747.2479440-1-pierrick.bouvier@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Gt3XaU1C c=1 sm=1 tr=0 ts=6ada86e7 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=4PEAfV7dsZCClPGPoiUA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: oKTW4DgcEYJjfFYe9a0NOcumyrBdFzFO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA4NyBTYWx0ZWRfX5yElLMwUEc4+
 eANpAwPiHx+g1B4BaoI4SQUbhwBCJK+Q7nvUtHqpbDbX2w21QrUBkTJe4iHtj6g5Rvf+OKJ6ck7
 euItwAFHfBb/KNb4UrlEwv1L3TKiy1OGbWYWbtVOdKYL2TzEVF4VtWkASt9LBadAGwAoB9Dx07N
 g5ByEWIWw7E219gJVpl6NsP3SJD749ZA0b56Wm/AZ8UqnqqQ7H+D6f6PWiT9QkAbFDn0hIJFo0U
 cy4As6mpmYMErBgMZCyd6w7HdZ6LJVCw1I2cupOWWtuhneigh093Pz3HTin0p5A/qiVAQtk82uU
 cgEt56+hY9TK2O1hYOr2wXW2D+GDyqLSwVKQRjzOAqnKyCDL1UD7UsYbrgr6vqttdAi70rvUmm/
 EBv/QbDBQ5/G5OANO5fpkPbnnIRJuxMdu9ulOwVMFK/sidS/rAmD4L6yf8M2G1UcAdU/qqXEJRS
 6bGaPKOijg19xQE+JyA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA4NyBTYWx0ZWRfX+Iit4J1wV/YA
 dmMwXMiqIM3qz9CqSyPAhb88WTOOWzYUv5F5+Lgq/B3SRUlw0sQ5kPhU4kz6HL913BOLoG8lBjO
 sSwG9iplXyCzKfOAIGxsUpRpqGsdBAs=
X-Proofpoint-ORIG-GUID: oKTW4DgcEYJjfFYe9a0NOcumyrBdFzFO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 suspectscore=0 malwarescore=0 adultscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610220087
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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
Link: https://lore.kernel.org/qemu-devel/20261021181244.867840-11-pierrick.bouvier@oss.qualcomm.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 target/riscv/arch_dump.c | 24 ++++++++++++++----------
 target/riscv/cpu.c       |  1 +
 target/riscv/internals.h |  2 ++
 3 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/target/riscv/arch_dump.c b/target/riscv/arch_dump.c
index 12b68799070..4c442a78312 100644
--- a/target/riscv/arch_dump.c
+++ b/target/riscv/arch_dump.c
@@ -20,6 +20,7 @@
 #include "cpu.h"
 #include "elf.h"
 #include "system/dump.h"
+#include "internals.h"
 
 /* struct user_regs_struct from arch/riscv/include/uapi/asm/ptrace.h */
 struct riscv64_user_regs {
@@ -161,17 +162,11 @@ int riscv_cpu_write_elf32_note(WriteCoreDumpFunction f, CPUState *cs,
     return ret;
 }
 
-int cpu_get_dump_info(ArchDumpInfo *info,
-                      const GuestPhysBlockList *guest_phys_blocks)
+void riscv_get_dump_info(const CPUState *cs, ArchDumpInfo *info,
+                         const GuestPhysBlockList *guest_phys_blocks)
 {
-    RISCVCPU *cpu;
-    CPURISCVState *env;
-
-    if (first_cpu == NULL) {
-        return -1;
-    }
-    cpu = RISCV_CPU(first_cpu);
-    env = &cpu->env;
+    const RISCVCPU *cpu = RISCV_CPU(cs);
+    const CPURISCVState *env = &cpu->env;
 
     info->d_machine = EM_RISCV;
 
@@ -183,7 +178,16 @@ int cpu_get_dump_info(ArchDumpInfo *info,
 
     info->d_endian = (env->mstatus & MSTATUS_UBE) != 0 ?
                      ELFDATA2MSB : ELFDATA2LSB;
+}
 
+int cpu_get_dump_info(ArchDumpInfo *info,
+                      const GuestPhysBlockList *guest_phys_blocks)
+{
+    if (first_cpu == NULL) {
+        return -1;
+    }
+
+    riscv_get_dump_info(first_cpu, info, guest_phys_blocks);
     return 0;
 }
 
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 08a4d14ea1f..059aee855df 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -3104,6 +3104,7 @@ static const struct SysemuCPUOps riscv_sysemu_ops = {
     .has_work = riscv_cpu_has_work,
     .write_elf64_note = riscv_cpu_write_elf64_note,
     .write_elf32_note = riscv_cpu_write_elf32_note,
+    .get_dump_info = riscv_get_dump_info,
     .legacy_vmsd = &vmstate_riscv_cpu,
 #ifdef CONFIG_TCG
     .translate_for_debug = riscv_cpu_translate_for_debug,
diff --git a/target/riscv/internals.h b/target/riscv/internals.h
index f17d011d22f..d2993842a32 100644
--- a/target/riscv/internals.h
+++ b/target/riscv/internals.h
@@ -207,6 +207,8 @@ bool riscv_cpu_has_work(CPUState *cs);
 #endif
 
 extern const struct SemihostingCPUOps riscv_semihosting_ops;
+void riscv_get_dump_info(const CPUState *cs, ArchDumpInfo *info,
+                         const GuestPhysBlockList *guest_phys_blocks);
 
 /* Zjpm addr masking routine */
 static inline target_ulong adjust_addr_body(CPURISCVState *env,
-- 
2.47.3


