Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95961606A323
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 22:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=MEQuE8F0;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=fpuFAQqv
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xK0na-0001uX-L4; Thu, 22 Oct 2026 17:58:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xK0nX-0001pH-KQ
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 17:58:07 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xK0nV-0000JN-UC
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 17:58:07 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69MIHd4B1495654
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 21:58:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 JYdzBN1HpEeM18lXBZKKe1ZA5oQSjyRefXXiOBbMnf4=; b=MEQuE8F0mn+ccp6z
 e3d/NuCpsYwBd/YFfBFZm0CCUTDm22SGqf6aWC1K/ULIA/ee5Q9YKt96d/jqah57
 ZuQoKVZh+OOyhxUGMahKzp4AH4rYEkK3sx5S6Z3sG+KjJXrYKl9yPZlt36Vrwk5w
 SOgr5rA2XwJ1NgLhuMB9jFUzwgqFYJXBe0/4qCpBk/ksapRQv7DzCoHCht8s0rIf
 XqxQi2PCq+ggdCEH/b7cpyxoKDLBWQlZSYVcanPpBkrQENzGWx8b7EtnEC8wyQ07
 xh9fvZK2fTZUHrARhhZPbw4tmUW5qYOx3MyaF4iVzw9D39vOiZnfoITlwArFiQWu
 dlZERA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqmr8q4e-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 21:58:04 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-3ab2cb8d5dbso212174a91.1
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 14:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792706284; x=1793311084; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=JYdzBN1HpEeM18lXBZKKe1ZA5oQSjyRefXXiOBbMnf4=;
 b=fpuFAQqvV1wOag9FVsFJnCNP5aUrKKH8ek61oKVRxCe868YIOXH4DEhBqP9lSb4i0e
 bKKBOkDZ6eAh+emCB8Vx+bOx7ug4L6sXVA6LiQzb2UTo2Ym8rEmrTSMbFN5Ff6zfgRBQ
 tWe9C9yU77GrnNCPln3ArZY5x3rVWN6imYiFn+LjAMNeQpG1fyio1UsjGsF/URHfWM9z
 yCZqQT3pEyqJsx9yuR0WKpvuaaB29gIVk+PsOqFM7xkq+uEWhkwtYjiXtE3FX2uTNKpb
 ZiOKu4SaLKiCeAUX+9dwdMueAp3cdxoh68d83iqzzPbL0tx9Jx0ST/EXAJusteaZeDB/
 ZTOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792706284; x=1793311084;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JYdzBN1HpEeM18lXBZKKe1ZA5oQSjyRefXXiOBbMnf4=;
 b=We7XPlQkpyANCkpXDSRza4fNkZh0vmomrzk5SXyoZB4Gz7RUUXmAeetC051y1onFMH
 3Hizy0Z4qJATHlZt+CQj0SEb4gl8M/TR1Nom/0Gr4FqLao2sDFlpE1bQVQ5ndXxhahqA
 KG/1Nzt5sFMhLLWZ+TwLVIcsONzLNCX90FvrAu0ydflQNjmWxTNsCzN/XUUY5/TO+nXc
 hblXUrj/X18Yv4pfdfMTpDzG5sF/lxk4/o5pMjipPmpNTwuw9hA6E5vArmHByXDgKUak
 dbyRyfAxmLikpNNwoZVFmz1XWACjdnZabkoWGAxspE87rueNvb5WBb1AumyBGZWcmRid
 llYA==
X-Gm-Message-State: AFq9FYK2H4zYE9aRLMdFlg31AsayJGun6OU/f6fjjtFpZgSdnY4smAd3
 0izRJXMqH3IGORgh21XPYiAka8u2MfA3f4eaVQ1/628Gyq4OABUBt3mImCfScEOzcDL09EuX8c4
 8NkEd+GK26grBtW7rQxve3dg0qTlDVA+qqG6eIQcWm1csAI/WtwWIFt8DQNuRFTnJqQ==
X-Gm-Gg: AYBFou3Q4omo9wgnqU+rtrly9GD0wvzMLl0JsjjJyYmT7Fa6wbZtY30nStzWAbY7EZ0
 Iilxw4Bgr51r6QoOgpkJvvpo6ix6Y+VKnQZ1wCnuKMFzZVsPYblSCYTeU157ZViZrJmHdXBR560
 8+E4LX26j0Ga5YqpWk3Uw4UZla4jrL+56nYUfdgpD+K/yta+LquzRA4M5gecYYlm6MYtNOE+G4Y
 Sj37dMSqqqMRxWrROkcRJh28b2yeAewNRCYeJhs6qStR8tMIVNyU548EwzP1MzknAVu9/iK9i32
 yWO+SlqC2OycRw4L5pzI8dp1XhmbYsJXlvHGD+gT8Ft3TEc064nld8UBDU66OLjx9RSmZEjNYFQ
 KJvaeRD43t4w3jveBc1ff8tg7dIXzbXGIL/XVXrhIuzzFAP206KTlBFmuY36kRF0=
X-Received: by 2002:a17:90b:35c5:b0:3a0:e1f7:9b04 with SMTP id
 98e67ed59e1d1-3adcdf98367mr185001a91.12.1792706283850; 
 Thu, 22 Oct 2026 14:58:03 -0700 (PDT)
X-Received: by 2002:a17:90b:35c5:b0:3a0:e1f7:9b04 with SMTP id
 98e67ed59e1d1-3adcdf98367mr184988a91.12.1792706283383; 
 Thu, 22 Oct 2026 14:58:03 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3adca62e477sm648061a91.2.2026.10.22.14.58.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 14:58:01 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 15/27] target/arm: implement get_note_size sysemu op
Date: Thu, 22 Oct 2026 14:57:34 -0700
Message-ID: <20261022215747.2479440-16-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261022215747.2479440-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261022215747.2479440-1-pierrick.bouvier@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: uDFsnw7MrRvtur_K1GsxBBWpbIpjdoT7
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA4NyBTYWx0ZWRfX952TtqrclAqj
 rGMN2vuppUFJ3c5Lpw8egirRIJlz0HOcdTM24gHNODhVXu8JzHTdMwSjUPC02TP5/WU0qre30Xl
 OlfU4gJuYILiAxLOIiL4lTFGWO9k1EM=
X-Authority-Analysis: v=2.4 cv=VNZIDNPX c=1 sm=1 tr=0 ts=6ada86ec cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=Vcmh8FhFDDEcUw5d5KwA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA4NyBTYWx0ZWRfX0ONxEHq0Wrp6
 v8Km98/pdfO/r8Inva2dPIMO7iNIcWJTsmeMSmi2zrQMJq+p3jPxMbs8YtVmSGtxaB9ohnjARbm
 sd0Dk5PRBtLb0q0pij7/5FRuFVfTqn+6+FGSFOX9+ECovKLl0IkS9l5wfFu+IeYDYpG85sXTa4N
 s0B5w6SdnwN03OxfGWvxEqRR6rZFDxVRTywc/FWqPUCCfnLLuhrw81y4171V9hVBt1sDXKBt2Um
 u7p46tb2fCNKqyMVbzPwa7vK1Rf38i0hrQbEfDHVlJdVF9SzYf3yp57Id3uqZ78WGRBow23+W2r
 cR+ULqnv4X+0lXQ78CBzrWzbk3RsH3kibnWLG5WSAG3EJ/mwXzfHF8IxXPnfnKQgX8Gte68vGWP
 WKMvSMVs4qcRJzS9h9zM4qlpp4wm+MzCLejub3b34H9PMd2OAttuoBwrPViqknv+R6zRvhIBBDH
 ZN8VLo1/wbAJPb4NTPg==
X-Proofpoint-ORIG-GUID: uDFsnw7MrRvtur_K1GsxBBWpbIpjdoT7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 bulkscore=0 adultscore=0 phishscore=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220087
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

For now, we keep the global cpu_get_note_size symbol defined.

Reviewed-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20261021181244.867840-16-pierrick.bouvier@oss.qualcomm.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 target/arm/arch_dump.c | 10 ++++++++--
 target/arm/cpu.c       |  1 +
 target/arm/internals.h |  2 ++
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/target/arm/arch_dump.c b/target/arm/arch_dump.c
index 6a009ae1a66..a09f7c59db6 100644
--- a/target/arm/arch_dump.c
+++ b/target/arm/arch_dump.c
@@ -430,9 +430,10 @@ void arm_get_dump_info(const CPUState *cs, ArchDumpInfo *info,
                      ? ELFDATA2MSB : ELFDATA2LSB;
 }
 
-ssize_t cpu_get_note_size(int class, int machine, int nr_cpus)
+size_t arm_get_note_size(const CPUState *cs, int class, int machine,
+                         int nr_cpus)
 {
-    ARMCPU *cpu = ARM_CPU(first_cpu);
+    ARMCPU *cpu = ARM_CPU(cs);
     size_t note_size;
 
     if (class == ELFCLASS64) {
@@ -450,3 +451,8 @@ ssize_t cpu_get_note_size(int class, int machine, int nr_cpus)
 
     return note_size * nr_cpus;
 }
+
+ssize_t cpu_get_note_size(int class, int machine, int nr_cpus)
+{
+    return arm_get_note_size(first_cpu, class, machine, nr_cpus);
+}
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 7bf0c5e74f8..73fdc6e460f 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2570,6 +2570,7 @@ static const struct SysemuCPUOps arm_sysemu_ops = {
     .write_elf32_note = arm_cpu_write_elf32_note,
     .write_elf64_note = arm_cpu_write_elf64_note,
     .get_dump_info = arm_get_dump_info,
+    .get_note_size = arm_get_note_size,
     .internal_is_big_endian = arm_cpu_internal_is_big_endian,
     .legacy_vmsd = &vmstate_arm_cpu,
 };
diff --git a/target/arm/internals.h b/target/arm/internals.h
index 8c1c6e7c44e..06092d29b36 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -440,6 +440,8 @@ int arm_cpu_mmu_index(CPUState *cs, bool ifetch);
 extern const struct SemihostingCPUOps arm_semihosting_ops;
 void arm_get_dump_info(const CPUState *cs, ArchDumpInfo *info,
                        const GuestPhysBlockList *guest_phys_blocks);
+size_t arm_get_note_size(const CPUState *cs, int class, int machine,
+                         int nr_cpus);
 
 typedef enum ARMFPRounding {
     FPROUNDING_TIEEVEN,
-- 
2.47.3


