Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17DBECC6B38
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 18:19:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHmTn-0000sW-FC; Fri, 16 Oct 2026 14:16:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHmS7-0007BE-Jd
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 14:14:51 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHmS3-0000Yy-NX
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 14:14:45 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69GI4eXN4023134
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 18:14:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=woThypxyPlz
 t0BPJCfIotk7v+p9yZubu9GTRjnBpjAs=; b=LJEzaGgppZ2Jtk6j5RG6VbpuQco
 i9tVlwTpjHgXjCH1RBb0Rp+e/YdiG43IaNTX5GNxRir0knCloel/WQ6Bmttf23CB
 WvksWxeglk7mig2y59JwnTtjco7muI2Ontt/bSee10SHgoqX2zIppdaqUJUg1i9L
 H6cptKbgRAGriP6iLY6da9ONPgIx4EdNkIeZMkojngrW1JD9GicwEUvqfljSn7zK
 R0IGg3x+k6F41cVyZs3LPH43/d8mHd2iU9RZzTBPOVAM1CnlJXTR/AmUuvnoFTkz
 IjuFTmBB9peZbmpBNlL3GQuK/qWumQ2Jclt2OOgxEGvvjoJkDDaKjrxcbAA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hbrvwg16w-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 18:14:37 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3ac7a4ba546so1008086a91.0
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 11:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792174477; x=1792779277; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=woThypxyPlzt0BPJCfIotk7v+p9yZubu9GTRjnBpjAs=;
 b=SedIDcAtCRTiGByw3Sv2CMgCMrEZ/p9oCvmOhrjlYNHwYR5S5W02qwFSGNLTI4U1kj
 NyJLR1OQqdz8hzVTJT4GErwfkzJvzS3279JQIonW+Wagt5Sb93+w2/9mGllWCbUoYqQe
 OZBjmL8TX2P2Dycl8/ec8e5ozrHeBDZPvfwr4gEaL7K7HqExOtACMVf/u7/5rzEX93lm
 9H3VDUBpvS1iGSKceGScuWa4Q2G9NzU1DT3wLQhcP1SlM0K6oHxCmwdUgpDE8He/QqBu
 x6T3gtVXBTbaE8EsHFTqKkdKzvyWXYVbqKDsI/e8utlh04hn83AzPRdQAJ0NYLGR3vG7
 qUOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792174477; x=1792779277;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=woThypxyPlzt0BPJCfIotk7v+p9yZubu9GTRjnBpjAs=;
 b=nCL6glztTlnfxV9+BDeyt2mmiwmtokTLl/UBt70Kyqsu59LFIjDK4fotRdMSvQb/US
 9pgEUW+NPQ0ZxJ5Zg8lQ/ociWVNZhSFYG+qIF9j0gczuwA/kGNJaoAaVJpAys72NmZ9D
 +w3qk/SJpw3DXxVOTASRK8euFS9LVSjULcyNGS5WLTg47rAz73Yf6+OVTuF8+DHd6zbO
 DziKJAbYZ9T23e9uYdZ7xWVf2yEalu5WtGgNjjWKxf5s53Z2JWGsF04x/nrASAStkrRK
 p9p8g+wcBAlnJ6HGKM02xYLVD85X0IkQpdmYMgSkuUywRpEcl1pNBDrk7cLxR/3hgrJE
 z/HQ==
X-Gm-Message-State: AFq9FYLXYpFcD7NGWhECPeKpsZhsAwfNMIIxVy+zS0hfQKBeLEek9DBH
 9Ujj3GsrH0gSywPkWDuucMWFqf8Jg2pFciANwUCbOlASlA3r5zSpA2Eii0eR2XBWExH794qR1Ug
 vvbU6/jo3BqcYeAR/tKb5HjkGrs0g1KzDE3GNOhiRW9fGwoZOdQxkWkP0xN4GXVTM+Q==
X-Gm-Gg: AYBFou364UPpAKxABn3cUuccvke8LfkxF+Kp9DmRrp36tvsUCcROx5vXWKUFrI7Y26D
 QoFcKfiBGeah9vFrhkJUYw3EsQ+siWuJ8kacgynqUM5SOgqZaB6X3Z+x2R5YPe1bFAxtVK9fx6i
 HVvK5KmGcMFwnT+myZfd8znzWa8pe5wcYCuQlqy3jb2QKL9GO3MRXsRR+nvnu9/HNRDeemQ8aq4
 ytSh3MHf2e31xyo1CMzkefv80Id98nfcx92DHo8tDB32Oiw2zADc6fEtoKBP+zzfkC2GvDHDY62
 NlzHw3xOJfE0o22xHuWgtAQ3+1epVyw9PjDCnp1bAASI7R5Z5z9ViHo3jxd9vw2knahBdsIuy8L
 LWEcyIVTDiO5WlsxRdft9AOoZ9N3m4KlHYQ3g7h/mOscu1mzW8fiTUjZUYkd4hcQ=
X-Received: by 2002:a17:90b:560d:b0:3a0:bf71:eccf with SMTP id
 98e67ed59e1d1-3aceefbde01mr371741a91.14.1792174477215; 
 Fri, 16 Oct 2026 11:14:37 -0700 (PDT)
X-Received: by 2002:a17:90b:560d:b0:3a0:bf71:eccf with SMTP id
 98e67ed59e1d1-3aceefbde01mr371724a91.14.1792174476646; 
 Fri, 16 Oct 2026 11:14:36 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3acc48e8646sm4895282a91.10.2026.10.16.11.14.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 11:14:35 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 anjo@rev.ng,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v3 14/23] dump: remove cpu_get_dump_info
Date: Fri, 16 Oct 2026 11:14:01 -0700
Message-ID: <20261016181410.191743-15-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261016181410.191743-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261016181410.191743-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: -XnPEj0eURlZPmB-y1utzYmRUtt0W1xO
X-Authority-Analysis: v=2.4 cv=COa/zhrD c=1 sm=1 tr=0 ts=6ad2698d cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=5zY7TNBH-1z3wV7SeYEA:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: -XnPEj0eURlZPmB-y1utzYmRUtt0W1xO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDA3MSBTYWx0ZWRfX6BICP1AFXSJd
 o03ca7+9gv85F+G9N6vzdxFc4oGu6kC5/xIyZBelCksmcbuBaOEKakVwhZhkgBpLSfeukGBNyuY
 fmKzQmuVrNc9VmOWJC3RJFzTP1aN6Z71d7TaEmrevr+MVbw+DmwNkqq4GKNZg/8GiWM3NiXFJ33
 HLlqF9pqdofHp6oFZajG9h/+bExmSiFhaUNpqtFFD97XKCwGzkUmTHYWPLxolkQyPVB8gG1dLNE
 tAR6UVTf1bEcyKhYtdSvdp9AbugZ8pFfd6u2cgkOr8hZv0TumBu17waAoYOG+J4G9WiBw63z8ri
 0LtjfP17GRU/dEw+pNYnM6Mz7OJain301CdqGvE5kK2i126YM9iFN5JjwioNDFxvZhdIvKzbu1/
 byaYhiZCsAnHFaTKvsjb1dVBNju4FvIUs5LSfjT7bt5SfPU3BMAaXn3Dt0JNt9oFAMuD386hkLf
 wStex0v7D8yWuxAceaA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDA3MSBTYWx0ZWRfX7z3zApOkliUy
 DWBfqKxvTt6jBl9/JwjqpLAqedAox0LApZ4g3zjRg2mNe2BFsKbkCW0Dstg066U7/uCP3W/SFyd
 PBM9XGiNv7p7Yx8sIDKPrFmYYRHJWE8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_02,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 malwarescore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610160071
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

Now that both cpu and the dump implementation use the SysemuCPUOps
interface, we can remove cpu_get_dump_info, including its stub.

Reviewed-by: Anton Johansson <anjo@rev.ng>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 include/system/dump-arch.h   |  3 ---
 stubs/dump.c                 |  6 ------
 target/arm/arch_dump.c       | 10 ----------
 target/i386/arch_dump.c      | 10 ----------
 target/loongarch/arch_dump.c |  6 ------
 target/ppc/arch_dump.c       | 10 ----------
 target/riscv/arch_dump.c     | 10 ----------
 target/s390x/arch_dump.c     |  6 ------
 8 files changed, 61 deletions(-)

diff --git a/include/system/dump-arch.h b/include/system/dump-arch.h
index 743916e46ca..b89e495661f 100644
--- a/include/system/dump-arch.h
+++ b/include/system/dump-arch.h
@@ -27,9 +27,6 @@ typedef struct ArchDumpInfo {
     void (*arch_cleanup_fn)(DumpState *s);
 } ArchDumpInfo;
 
-struct GuestPhysBlockList; /* memory_mapping.h */
-int cpu_get_dump_info(ArchDumpInfo *info,
-                      const struct GuestPhysBlockList *guest_phys_blocks);
 ssize_t cpu_get_note_size(int class, int machine, int nr_cpus);
 
 #endif
diff --git a/stubs/dump.c b/stubs/dump.c
index df7897b72b1..2ce3c5e274d 100644
--- a/stubs/dump.c
+++ b/stubs/dump.c
@@ -14,12 +14,6 @@
 #include "qemu/osdep.h"
 #include "system/dump-arch.h"
 
-int cpu_get_dump_info(ArchDumpInfo *info,
-                      const struct GuestPhysBlockList *guest_phys_blocks)
-{
-    return -1;
-}
-
 ssize_t cpu_get_note_size(int class, int machine, int nr_cpus)
 {
     return -1;
diff --git a/target/arm/arch_dump.c b/target/arm/arch_dump.c
index 98eecf3d26d..181691b81c6 100644
--- a/target/arm/arch_dump.c
+++ b/target/arm/arch_dump.c
@@ -432,16 +432,6 @@ int arm_get_dump_info(const CPUState *cs, ArchDumpInfo *info,
     return 0;
 }
 
-int cpu_get_dump_info(ArchDumpInfo *info,
-                      const GuestPhysBlockList *guest_phys_blocks)
-{
-    if (first_cpu == NULL) {
-        return -1;
-    }
-
-    return arm_get_dump_info(first_cpu, info, guest_phys_blocks);
-}
-
 ssize_t cpu_get_note_size(int class, int machine, int nr_cpus)
 {
     ARMCPU *cpu = ARM_CPU(first_cpu);
diff --git a/target/i386/arch_dump.c b/target/i386/arch_dump.c
index d5016c198cb..004a639030e 100644
--- a/target/i386/arch_dump.c
+++ b/target/i386/arch_dump.c
@@ -430,16 +430,6 @@ int x86_get_dump_info(const CPUState *cs, ArchDumpInfo *info,
     return 0;
 }
 
-int cpu_get_dump_info(ArchDumpInfo *info,
-                      const GuestPhysBlockList *guest_phys_blocks)
-{
-    if (first_cpu == NULL) {
-        return -1;
-    }
-
-    return x86_get_dump_info(first_cpu, info, guest_phys_blocks);
-}
-
 ssize_t cpu_get_note_size(int class, int machine, int nr_cpus)
 {
     int name_size = 5; /* "CORE" or "QEMU" */
diff --git a/target/loongarch/arch_dump.c b/target/loongarch/arch_dump.c
index e216e906414..5a0e1742242 100644
--- a/target/loongarch/arch_dump.c
+++ b/target/loongarch/arch_dump.c
@@ -152,12 +152,6 @@ int loongarch_get_dump_info(const CPUState *cs, ArchDumpInfo *info,
     return 0;
 }
 
-int cpu_get_dump_info(ArchDumpInfo *info,
-                      const GuestPhysBlockList *guest_phys_blocks)
-{
-    return loongarch_get_dump_info(first_cpu, info, guest_phys_blocks);
-}
-
 ssize_t cpu_get_note_size(int class, int machine, int nr_cpus)
 {
     size_t note_size = 0;
diff --git a/target/ppc/arch_dump.c b/target/ppc/arch_dump.c
index 7cb97082926..c70c2d0b125 100644
--- a/target/ppc/arch_dump.c
+++ b/target/ppc/arch_dump.c
@@ -252,16 +252,6 @@ int ppc_get_dump_info(const CPUState *cs, ArchDumpInfo *info,
     return 0;
 }
 
-int cpu_get_dump_info(ArchDumpInfo *info,
-                      const struct GuestPhysBlockList *guest_phys_blocks)
-{
-    if (first_cpu == NULL) {
-        return -1;
-    }
-
-    return ppc_get_dump_info(first_cpu, info, guest_phys_blocks);
-}
-
 ssize_t cpu_get_note_size(int class, int machine, int nr_cpus)
 {
     int name_size = 8; /* "CORE" or "QEMU" rounded */
diff --git a/target/riscv/arch_dump.c b/target/riscv/arch_dump.c
index 6562c32cfca..13aaa87202b 100644
--- a/target/riscv/arch_dump.c
+++ b/target/riscv/arch_dump.c
@@ -182,16 +182,6 @@ int riscv_get_dump_info(const CPUState *cs, ArchDumpInfo *info,
     return 0;
 }
 
-int cpu_get_dump_info(ArchDumpInfo *info,
-                      const GuestPhysBlockList *guest_phys_blocks)
-{
-    if (first_cpu == NULL) {
-        return -1;
-    }
-
-    return riscv_get_dump_info(first_cpu, info, guest_phys_blocks);
-}
-
 ssize_t cpu_get_note_size(int class, int machine, int nr_cpus)
 {
     size_t note_size;
diff --git a/target/s390x/arch_dump.c b/target/s390x/arch_dump.c
index 9a92efd249a..4301cf400e4 100644
--- a/target/s390x/arch_dump.c
+++ b/target/s390x/arch_dump.c
@@ -469,12 +469,6 @@ int s390_get_dump_info(const CPUState *cs, ArchDumpInfo *info,
     return 0;
 }
 
-int cpu_get_dump_info(ArchDumpInfo *info,
-                      const struct GuestPhysBlockList *guest_phys_blocks)
-{
-    return s390_get_dump_info(first_cpu, info, guest_phys_blocks);
-}
-
 ssize_t cpu_get_note_size(int class, int machine, int nr_cpus)
 {
     int name_size = 8; /* "LINUX" or "CORE" + pad */
-- 
2.47.3


