Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48998CC6B38
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 18:15:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHmSO-0007Gl-0E; Fri, 16 Oct 2026 14:15:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHmRw-00078l-2i
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 14:14:36 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHmRt-0000X4-Vk
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 14:14:35 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69GI5Q3T4097700
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 18:14:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=INvVrZ39Ldo
 +gl9V/gb3YVe9ExWXcZCWdyXT9jgl6NA=; b=T6Yna1+TMk+5HZecQ4xlmTj/Wn8
 OFTf7ejbK+Ci0KTrSD8GZcfdGvKtPaQE0buamt17HLJ3HKGxXvNgqMJvjjgu0OH7
 XYBGRJdBEoQFRXsaHUNqtI6OlANSPPBuR5+HsqIAS2xY54TrraVoiDuMfwvs9xNZ
 IWLXBWjZ0Nr8+4ObZuTgyd6M0DX6tsF5VVzkl8ZNzdGHFicD7A56Cv3HIhYEqo1D
 VcDSESfNqyYwPqcjh8rzD2WOndhecC0HckJXMUU8KGH0eg0O574ZJrf8l+aARoo2
 dtcWHzcWmBIHzNMXqs2WfP8/RLo7bHJ0czEYld3u3qs5/+eg0WQmgaohwSA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hbrw7014g-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 18:14:32 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-3acd21ba24eso156882a91.3
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 11:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792174472; x=1792779272; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=INvVrZ39Ldo+gl9V/gb3YVe9ExWXcZCWdyXT9jgl6NA=;
 b=Lp5sUCFgEo7YjveWhdhXeVB9jBsnVHDPEJBj1vLkc6mC6y/pdzaPzvYIPsIP/a/Z5L
 ISU5uwaB1xUpF24VKHm7rFBZOCeNbXqhCWjKTlkha2QDHZHl2zPSs0S8Qz2E3bJDijXd
 IdxqNCavXnAx+yYQlY9vg5rB/uHvqQzlQ2YqfCyrb5APyIWoldYOqMmj4YYqkml30Oun
 ME4aywaEcyrlKalZjnvVw0ona6kTxaEW+IQk+owMU95V0eekcmf/UheXrwzT8Js+jvVs
 YxW7QNULoBfl0vkgntI7BTu/FTS2QNvxL8xCVXWIIauzqUTFubMUtPiSxwS559iv9T8t
 1Q/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792174472; x=1792779272;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=INvVrZ39Ldo+gl9V/gb3YVe9ExWXcZCWdyXT9jgl6NA=;
 b=z/fqqyyUVFxpGizDT2gEO0aghgS0xSXhLQrgrath+OXYyagimX7voOyTyAtbRQJnij
 EEHIbIW0LHfQYUeY35OE0J9WCbOWG1+KLSnbIt8qeVxOGg0RgzDZyQ0m3dp9QVlaH0Ld
 rro4yv9lG+FM7sEsEMYmdtcUQWjnTPEebECpNMFmvoMP9tKJk0CvyZ1mevSKevDVzmCf
 U/JgdcecF+l3Px6/uZvtC3X75OKCh6O+WhGiY9cPWKDbd9qy1/rsHnVywT0H7iB252BW
 xk542kLHfWawiCowavKB71Qc6g/QPINbNzZBApSy1qoRi9tBchltDa2BwCR/H8XPJogh
 rOTw==
X-Gm-Message-State: AFq9FYKQ5FL2LpYMwMqjH2KWZ7cr6aOxcHm6gFqkowXeE7VSg0tMbfhi
 KIV0PvbtOKkS2wSnuvxsY11uCENNpWcmwS6caaF7tjtHzzMPcvncwOXlAdx6a2MIrXLE1B5ioRV
 f9JwQ3BVEN8KWr3gNTff+C9INxlDkUPZd/OIpVOncFZ9xbIjuQLVpebFtRfARLJcctQ==
X-Gm-Gg: AYBFou36HHNDQvRvyMmQ4SDqO3sLHlXUQuyRUUmEOHiOPqMhLx+LHVotasDHkQdjeyY
 2S09izW76hICT8gKvOYsX1DuBSoay6vRdkgw0x/RS34lBnyyvaVhs8jNAoAYLgydyXDoC+RL6fX
 IwIz4pM96WBoZU1wA8qRICYWzM3TPa/+SZ7csh4awOGC4AzF2J794UAwrlaVvMggr2IP0QbpFy8
 9vDtntMMFG8TDeQtZcesME9pLfsqVk0FGV0me/fpcLksI5zZ/rU9wicW9pcpU5zMMyyhUWryttv
 Nf6PtApaC83z+4eQu6HAHFkJhAFcxrK1db1PBBLIfSp1LCA4r5uZJZJGWJ+qVfOunGHyEwVcPLv
 Yn53hcoRF/hH+btOi4bEzIlEKq6SdwNXLXP4HmUJgjuAMOpfdqc5lgPSk6PxDors=
X-Received: by 2002:a17:90b:4d10:b0:3ac:9c37:9429 with SMTP id
 98e67ed59e1d1-3acef56fff7mr573537a91.52.1792174471941; 
 Fri, 16 Oct 2026 11:14:31 -0700 (PDT)
X-Received: by 2002:a17:90b:4d10:b0:3ac:9c37:9429 with SMTP id
 98e67ed59e1d1-3acef56fff7mr573479a91.52.1792174469887; 
 Fri, 16 Oct 2026 11:14:29 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3acc48e8646sm4895282a91.10.2026.10.16.11.14.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 11:14:29 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 anjo@rev.ng,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v3 10/23] target/riscv: implement get_dump_info sysemu op
Date: Fri, 16 Oct 2026 11:13:57 -0700
Message-ID: <20261016181410.191743-11-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261016181410.191743-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261016181410.191743-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDA3MiBTYWx0ZWRfXzprYFgB+ONLX
 vhZMpFC6IWvFci8qyBg7YEy7OLyjhTbbBrtj32MXrhvb8ZbRyK2Kb4WjtBHczGT3ba3dpv3sIbc
 F9hzMv0zP9jMff3UKdXZRufnsOhcVqQ=
X-Proofpoint-ORIG-GUID: Gfh2NluMdX3926I83fWz2tfmPp0tAfTg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDA3MiBTYWx0ZWRfX4W2sMNFTV0XC
 tROYwFcXMRhkMvgYa0iX9MMm49oMohg8YgIQ2CVs+dtKcxJRx6v4ABSY9VGGp2lc4+5X7A5GM76
 xtTDPBQDERWDd1BoZSLE5fY3hb7fTb/G3HnjTDWEM6fVCpg7QBg6Jr+yZqEMmqtpOW4pCad5yhc
 17s/K1SCu008PBii1SP9bXHgpBTnIVJdMWXPuXwHBGEay2y+ccsmZ0hgKj0cTWO132HhaC29BIe
 QGs10eIvpeYAx/K+k0p9xogHUGz8gIwF4tdVt0rwhHrC0vxgNbilwrslm3qCuBZh5Diy+BhfhsZ
 toBwP6hLS+c8GE8L9QNMo/fjTHeDj3JtZIpPiBAwOXiB4jGBgJShntNvjUA09mUxH3IhJO7uWjH
 VLllBzj38EYE2zQkAu8Tf4uiUVaae+7nQcRD1u87sUNa+BygdG3D+uc/tUmh6HoNMnVv66V3q/5
 wHWOHQeW3JSWAMx/6sg==
X-Proofpoint-GUID: Gfh2NluMdX3926I83fWz2tfmPp0tAfTg
X-Authority-Analysis: v=2.4 cv=XKKl2ghE c=1 sm=1 tr=0 ts=6ad26988 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=WNGBrETkOK3pTO-6kIgA:9 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_02,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0
 adultscore=0 priorityscore=1501 impostorscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610160072
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
 target/riscv/arch_dump.c | 25 +++++++++++++++----------
 target/riscv/cpu.c       |  1 +
 target/riscv/internals.h |  2 ++
 3 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/target/riscv/arch_dump.c b/target/riscv/arch_dump.c
index 12b68799070..6562c32cfca 100644
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
+int riscv_get_dump_info(const CPUState *cs, ArchDumpInfo *info,
+                        const GuestPhysBlockList *guest_phys_blocks)
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
 
@@ -187,6 +182,16 @@ int cpu_get_dump_info(ArchDumpInfo *info,
     return 0;
 }
 
+int cpu_get_dump_info(ArchDumpInfo *info,
+                      const GuestPhysBlockList *guest_phys_blocks)
+{
+    if (first_cpu == NULL) {
+        return -1;
+    }
+
+    return riscv_get_dump_info(first_cpu, info, guest_phys_blocks);
+}
+
 ssize_t cpu_get_note_size(int class, int machine, int nr_cpus)
 {
     size_t note_size;
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
index f17d011d22f..ea4b4140c09 100644
--- a/target/riscv/internals.h
+++ b/target/riscv/internals.h
@@ -207,6 +207,8 @@ bool riscv_cpu_has_work(CPUState *cs);
 #endif
 
 extern const struct SemihostingCPUOps riscv_semihosting_ops;
+int riscv_get_dump_info(const CPUState *cs, ArchDumpInfo *info,
+                        const GuestPhysBlockList *guest_phys_blocks);
 
 /* Zjpm addr masking routine */
 static inline target_ulong adjust_addr_body(CPURISCVState *env,
-- 
2.47.3


