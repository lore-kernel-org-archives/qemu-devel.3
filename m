Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A901B606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 18:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Tgh3xUqc;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Oy5529Ns
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJaoU-0004Tv-56; Wed, 21 Oct 2026 14:13:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xJaoO-0004S7-Ph
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 14:13:16 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xJaoN-00084M-4F
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 14:13:16 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69LHpElR2384113
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 18:13:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 iSu/3rfOXr3KnlWfxYH3mqgdMtcqBvhBkdiL/nbm4MM=; b=Tgh3xUqcMMKJTCpt
 Moa5NlwcsCK1xosr4SJlnzUHL3Zex9+yeIvTpCkrQtrwZbWkyLPW6yCSHUodJfnN
 LZOfP9t9Nzh5o+VG1rR1Zyi76KZxoz4vmHCH2L6x2n9JcbNkxvrL6+uh4aQ4fzDq
 CYOFxgqnHVXcvVgl6VtniLF38AH/6BOXWJoC7/7OKDO7S909vDzGjtva4cbT0EVd
 BoMc2kI/+yCGdNkqmr83U7ZNLa1fbG1MOI1usp8HBweIBxPMWwUEttdjJ+7U0/Sw
 VFVX18Fds5VsBB/GhozZARYxA+rYK88Nr3dcg9Yjcz8ELfbXft6ldhdJjnNEbQ0f
 pRKl/w==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hf0ke0jum-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 18:13:03 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3ac575a9198so1665580a91.3
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 11:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792606383; x=1793211183; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=iSu/3rfOXr3KnlWfxYH3mqgdMtcqBvhBkdiL/nbm4MM=;
 b=Oy5529Nsj3CPuv/jLt7skC3612+pX7Qzy2jTOVreltD6FB+BF5U2Uldz4jZK30Xyxn
 ILR4zVgRj+41Fi9i6GR1B/JB8aEOmlow1SuuN9lj8LFpG7txEnei+hga+RiZtVAOIVQU
 /pVfoxZdDHjysCxZqin64eaRPEOz4X2HTB2HTu12k5/MmB7ifhqaVjd1IZKGXiG35kB0
 4X0ZNzXyoGxUd+eHRhOFMmsjEn8M9o/PICpF9IHH0H5ozAcOnDblxSgyBXggdrwy55We
 divxnUzr1Xiuoh+90PsSw+qEl6E65jh88ts1Gr1XjtxZ7gdV826SrNds0GFgdY6/isi/
 qJbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792606383; x=1793211183;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=iSu/3rfOXr3KnlWfxYH3mqgdMtcqBvhBkdiL/nbm4MM=;
 b=V05BvfZYPKt+4iknJ7QaaxbjNterQt5JkJDBA9X/+T9S2CndbyGZLWKie8TSq9chC0
 s5Cvs2I0ceBn2XmuoCYxCPPh9NwgDBEPUb/tQcNTTU2amm+VyzL3WBd4aaV0iyS1qpSX
 PYKmyCY4p4sE9l6Z+63uGLG3paH2DgU3c+2Ow8Y31WWvG3Nb35CSC5c87TnOZa2ptPQK
 GOGkVOdy55X1P85985BPL+ozJyCXno7Pi+O9VZGV4i5Ft8yxCtckLIiYVXoYl0sT3MR8
 /NUN6s1u7vegUOQYHrJEYXEXnZQ1r5yAl87huHdI9F4HEgvWUumJT1OrPta/oz4ctNZe
 Ax8A==
X-Gm-Message-State: AFq9FYL111ivO/jTGEU1VjwtgvWHzLPyf61sJHyMY9vpRxeBiymi8AKq
 FN+BpUE+WH+yGZEEnc4OEmgBvvXjjekIpjBtvaSWi4uDodJPV7sjAlz9f3LZBAp3ZmeTr5Xc7MZ
 BzdXaG29PdCfONHgKNK10Uq8GxIrHb4qUAW1fWE2jNio6kpBBtTNZ02EqKRfRZNkO4w==
X-Gm-Gg: AYBFou3xZNYAnLvTTJUOlXqIb+Fn7u5YRZRJG0wArnR9BgMZ/5XYV9xQhCBBUaA5o/g
 WmQV9OG6UJP6rfGph1fIlcOK9A6Y915WPaaDreudX5rWKPjym1kY0DhH49tjZ063RpfHlMFtemq
 sEd68fMOfG+02iq2lK6yatFz2hLL6Hb8GPHVNJOOtrSnJvsfOPRFuMztX4cQ0sraGz2yeMUUGFr
 zxAXPlb38dTDBk0+bEuOb//PfN7FzYOfES6wWgf6Z05tkKijD9y7tRP3qMQDuoWq4luZIWlSGYG
 fSbmTAhljbIK86olXN8lJCbBtwOAD98lxw9ANUWocBwTfBQbyAm0JTcFoqeL4WfsUOCt/EfW+nR
 tm9qQFLZkuus+41FVU0uFTNDvQyLyqno810z4s77DyXuskidbBDPGEzkS40qyNQg=
X-Received: by 2002:a17:90b:548e:b0:3a8:2c7e:8986 with SMTP id
 98e67ed59e1d1-3ad86f44838mr2388162a91.17.1792606382934; 
 Wed, 21 Oct 2026 11:13:02 -0700 (PDT)
X-Received: by 2002:a17:90b:548e:b0:3a8:2c7e:8986 with SMTP id
 98e67ed59e1d1-3ad86f44838mr2388148a91.17.1792606382499; 
 Wed, 21 Oct 2026 11:13:02 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ada48ed74bsm499152a91.3.2026.10.21.11.13.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 11:13:01 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 anjo@rev.ng, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v5 15/21] target/arm: implement get_note_size sysemu op
Date: Wed, 21 Oct 2026 11:12:38 -0700
Message-ID: <20261021181244.867840-16-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261021181244.867840-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261021181244.867840-1-pierrick.bouvier@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Qn0mRkQ0WUu6J1D8YuYvp-qNQkUDLsy0
X-Proofpoint-ORIG-GUID: Qn0mRkQ0WUu6J1D8YuYvp-qNQkUDLsy0
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA3MiBTYWx0ZWRfX2rUc28LZyfLE
 Sv/eh7sNqvB7bYhcMf/eKvP2D8mgNlUgtxz2Q4fLTBSSGy49ld1x0cyQbo4izwuitxCN2IPegF8
 kPyYmeRD2I/6vRpUHMexULiJM3E0Dw8=
X-Authority-Analysis: v=2.4 cv=KOzPn1Fo c=1 sm=1 tr=0 ts=6ad900af cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=Vcmh8FhFDDEcUw5d5KwA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA3MiBTYWx0ZWRfX21hxqhWuFKPp
 2yzFssIt74oRj1K+xRW43c+XLVV3Kr69CeERcyL2KYNMRCeeOP9CRsN9GHylsHhQ2o3R0/tQI7z
 ZwJXWOVAJsXZwjdQkRWs3hjtDVQZTVTQKUguaLdgDroUM7+7E7KwhC+zj3k5NziCLrHRQT1R3/8
 So755V+/it7DV8G7z7pCUO2rxYzspreNUxaoChgiyLkDTYPGKAA0NzN0RwY3ShDKdVhCrEEw4wP
 B8I/YkfqGFxXnbeJShYx/yluAT9RfiN87VbMMo/CrZniqoQ7jLF/OCkNvlXlDZ6ut2j6/g+ayUa
 xx6zaQXHf+9PWHAm1kw4+j9O8cjbOlWd8Oc86D0fob1phdLOtEm4iih11QthRJK9Le5sMmWpRHq
 awy18FrqqT5xPNzx5yRS9FM4i/EDoCv958OcEbteJSyaItI7dHqQo28si4K407aUv6T/RfDU4vk
 Vc1RjAXOc++GaZiMiJw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 impostorscore=0 suspectscore=0 bulkscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610210072
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


