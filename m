Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB61D606A319
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 21:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=lJnEwORd;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NxT2LFu1
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIutl-000322-6s; Mon, 19 Oct 2026 17:28:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xIutL-0002oE-35
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 17:27:41 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xIutH-0006Jh-2a
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 17:27:33 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69JJKPUY3329443
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 21:27:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 FnH9RKdoFi+hdX5O3IHwfqO5DPrkvPO9GBpfHbjXL9I=; b=lJnEwORdJ+e1hOrk
 eXRJ3aPw8r4ZN4DIGopUiM+LKbhZO0I+kAIsu5MP3KOyJa3EPeU9YtToJytNInVf
 32mZc0FMx1EOgyXz42WnDPi+rx/nAv6bEiVubOqx9iLx3UUPxyYOfcfWeTRDmsQB
 Af9GbLaoRNpDjzgW34HVBNjaC7+4PyPcfMdHbJAPDDOzJpRZbfC5p4NUmYkSR4dw
 RuEXmEwOttZ8SQwKrNz/FF4+iCwAhsIYaz0/8OS0YO+EIERZ2qahrGh0/Arkt0hF
 i4j/U3nJJzLrCFc93ZwyOvV9Yfp1XrJ+Jq37xaApD+2SSPlllYcs9GhB1HS02087
 UIQ/kg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdkmfj353-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 21:27:11 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3ab926c236aso2468098a91.0
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 14:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792445230; x=1793050030; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=FnH9RKdoFi+hdX5O3IHwfqO5DPrkvPO9GBpfHbjXL9I=;
 b=NxT2LFu1UkVS+2GqON3dIyr+nIzqBGZHMn0S5cXphZ/khcy4qEwDsV9y++psRptBaY
 UUaMyN5FyaNbJCFSHjPWGVR2nfq4+0wskKhhc0WpulDfF7L9HTCpQ9EhBxjvNOpyaplR
 +jp/qhCGPtH5uinpckrWxHUBWwyESDDJOMAOSYBFpvDpDNJbqRSyTLbS6R5TvFF/7SzP
 +4BEWjLYDuagm3VbjaV+7fTBFZz7LU2tcCsIy5hoM1QiYfxcnMy7cx8dRLlzD+UYMLYW
 LA4IKMwtzkiyrMY8LiP9KLLeg9gSafyzzi3eFL32A+A+PXoLGk88RW2eEZEiCdstmu8y
 ZZHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792445230; x=1793050030;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FnH9RKdoFi+hdX5O3IHwfqO5DPrkvPO9GBpfHbjXL9I=;
 b=yCqrUnoxZHKP3eQGsrG3DMwLUxQSr054/akE0saSvhRQvifOo3/Z1cVBk00n+6DYZQ
 ank5+uCYuteiDd6EwR4eK7RNQ8esJR0/IWhY3KIuisIhTtHLgZGfbc2AYqGPvOKDSzro
 OG/tF+SsLGUkLSbcEKhbal9DbO5d0QHpI/Liciw1L5dtdSH1+o/gEHZvQut86uPFKRNP
 mP5rrK9Mv++M5JNreB8OyDsp2vhRY+t+3DVhePRBCS86ODOm6D+nR9F3JkUh3a5qmtPi
 MFSkd+3syYEugjOh3zSXr+dqzJQolojVFlXvNC+DkKfSIWVnECH5X6dUXy/w4G5X3j0j
 lIpQ==
X-Gm-Message-State: AFq9FYLUxVjKwI80zYYq4r3EdaFJxky+8Muw0crqlEAijkavJzoPezY1
 kouy1IrhKiwDy6QS2KgHrqKJjaM8pq46E9IQQsGJvZg41gPoekEtscT+B/vXxDt6ebKcLYZksSe
 5ras7wFHNp5VqY+BkQGwaRXXa0vnCEZWk8y7TPyiz1IG8b16xwqwVXsBjdYoqcd9QCw==
X-Gm-Gg: AYBFou0ltxCgOeZwQQeFt7izmmPMN9XQdm5DofmXVUQfs/jeBT9xw28dGQ6aQmbFcoN
 yjWAEc9Rx1y9nkZWeoOq2Bdwb9s4dQGwwqlSpTcHkzVqtfRT7s4n3Qs9vUirRA4WXWclf6LSgXr
 hTI2/+jz0PB/b+sW2eEN74MWgQul8FrCPbIAFptfv6XOnMrweVbxNyF9xXhHQ7ByFkIbL14E8Og
 fy2VtC+9/rvsTCvKEOZcKgrWXm42bjOgA8xPjCVpV2hg8akwdy6d4dYbkpsXoooALHjplCIoCcF
 hbZbx3+wc6+/dIW9TOSEAgRc8J6YqAPA3DlHx3U6wguZc3hPwU5r1+zM7EG/ZoDQszaot0S2Ylr
 68VcugMQYeBsq46aJCLDj+RhVOgkndilbz5yQ9cww29SyUvZubsbWe/Z55XYxl+A=
X-Received: by 2002:a17:90b:2247:b0:3a7:8350:3f7e with SMTP id
 98e67ed59e1d1-3acef4e49bdmr7008206a91.44.1792445230522; 
 Mon, 19 Oct 2026 14:27:10 -0700 (PDT)
X-Received: by 2002:a17:90b:2247:b0:3a7:8350:3f7e with SMTP id
 98e67ed59e1d1-3acef4e49bdmr7008189a91.44.1792445229970; 
 Mon, 19 Oct 2026 14:27:09 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ad60f2c785sm867061a91.7.2026.10.19.14.27.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 14:27:09 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 anjo@rev.ng,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v4 06/21] target/arm: implement get_dump_info sysemu op
Date: Mon, 19 Oct 2026 21:26:33 +0000
Message-ID: <20261019212648.154493-7-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261019212648.154493-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261019212648.154493-1-pierrick.bouvier@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: GWjLYlbFlWueaof38sxYcZw83SB0iEAv
X-Authority-Analysis: v=2.4 cv=O+isLx9W c=1 sm=1 tr=0 ts=6ad68b2f cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=iHWeOob8v6k5DsbZtYsA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA4NSBTYWx0ZWRfX95G7Ax8fPTTp
 ihlVQg+Ip3Pi5H0sAh07PsmvsuZFRwjAVKc9OPvGMrjzn6W9//QDFEJMnhUPUNsyyx8ehwg4DJ5
 cWhQVBgP1RfPgZwufgHAtnIqc1F+X6avAaLqWQ+elfiNQt8z6NUjWttR1bXaI1rEqraT0wdMqlK
 VxS+AxmGNNx3u+IiL4AwbZTl6ootVPZUde5kti45FwsfgKircEjkrjdLYQmhptVKdpj1Hp1OVgK
 RqgOYz6377FFmA8chh9HfXfUw12gsm58TF9Y2Mhp0q1DnV+JcIUBx8vL/ol7TTygKHglaocI1Pr
 1EzXxnbWZ8alSWIWipr2NTwHk3MX7b46Z13bwGAsyJY1QZGuBvMcismxAtRfgf+Nn38Mxq4TcEj
 QbU0IQAdzGDSAnEXBpur5J9W5QKDmZtTH67+4QsjWHP9i18BkULXIiLMJPKhcBbwrr1Ef/UVqPV
 dbiz19ll4/fH6E0nv6Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA4NSBTYWx0ZWRfX9iJ5bgRdAoR5
 cgLMHzQ8/5sfPR6E7tXmhvYQMixFWqALMET8TUb2dIK8YNZ6lurzZOjfhFmPMtcUfEXAqY5UQ/f
 Bqa+hEv2c6mffOcoq2XEa+TjG3q33Nc=
X-Proofpoint-ORIG-GUID: GWjLYlbFlWueaof38sxYcZw83SB0iEAv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_05,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 lowpriorityscore=0
 bulkscore=0 suspectscore=0 spamscore=0 clxscore=1015 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610190085
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
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 target/arm/arch_dump.c | 23 +++++++++++++----------
 target/arm/cpu.c       |  1 +
 target/arm/internals.h |  2 ++
 3 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/target/arm/arch_dump.c b/target/arm/arch_dump.c
index 1dd79849c13..98eecf3d26d 100644
--- a/target/arm/arch_dump.c
+++ b/target/arm/arch_dump.c
@@ -385,21 +385,14 @@ int arm_cpu_write_elf32_note(WriteCoreDumpFunction f, CPUState *cs,
     return 0;
 }
 
-int cpu_get_dump_info(ArchDumpInfo *info,
+int arm_get_dump_info(const CPUState *cs, ArchDumpInfo *info,
                       const GuestPhysBlockList *guest_phys_blocks)
 {
-    ARMCPU *cpu;
-    CPUARMState *env;
+    const ARMCPU *cpu = ARM_CPU(cs);
+    const CPUARMState *env = &cpu->env;
     GuestPhysBlock *block;
     hwaddr lowest_addr = ULLONG_MAX;
 
-    if (first_cpu == NULL) {
-        return -1;
-    }
-
-    cpu = ARM_CPU(first_cpu);
-    env = &cpu->env;
-
     /* Take a best guess at the phys_base. If we get it wrong then crash
      * will need '--machdep phys_offset=<phys-offset>' added to its command
      * line, which isn't any worse than assuming we can use zero, but being
@@ -439,6 +432,16 @@ int cpu_get_dump_info(ArchDumpInfo *info,
     return 0;
 }
 
+int cpu_get_dump_info(ArchDumpInfo *info,
+                      const GuestPhysBlockList *guest_phys_blocks)
+{
+    if (first_cpu == NULL) {
+        return -1;
+    }
+
+    return arm_get_dump_info(first_cpu, info, guest_phys_blocks);
+}
+
 ssize_t cpu_get_note_size(int class, int machine, int nr_cpus)
 {
     ARMCPU *cpu = ARM_CPU(first_cpu);
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 81ec1ce21c6..7bf0c5e74f8 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2569,6 +2569,7 @@ static const struct SysemuCPUOps arm_sysemu_ops = {
     .asidx_from_attrs = arm_asidx_from_attrs,
     .write_elf32_note = arm_cpu_write_elf32_note,
     .write_elf64_note = arm_cpu_write_elf64_note,
+    .get_dump_info = arm_get_dump_info,
     .internal_is_big_endian = arm_cpu_internal_is_big_endian,
     .legacy_vmsd = &vmstate_arm_cpu,
 };
diff --git a/target/arm/internals.h b/target/arm/internals.h
index e849e357cfe..61b0bbf1ba8 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -438,6 +438,8 @@ int arm_cpu_mmu_index(CPUState *cs, bool ifetch);
 #endif /* CONFIG_TCG */
 
 extern const struct SemihostingCPUOps arm_semihosting_ops;
+int arm_get_dump_info(const CPUState *cs, ArchDumpInfo *info,
+                      const GuestPhysBlockList *guest_phys_blocks);
 
 typedef enum ARMFPRounding {
     FPROUNDING_TIEEVEN,
-- 
2.43.0


