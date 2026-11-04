Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03029606A326
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 05:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=WX7rQBy/;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=frBWnXeI
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOTCx-0005K1-IB; Wed, 04 Nov 2026 00:06:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1xOTCr-0005Hw-64
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 00:06:41 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1xOTCn-0002Dv-Ot
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 00:06:40 -0500
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A40R3HK1191107
 for <qemu-devel@nongnu.org>; Wed, 4 Nov 2026 05:06:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=d+pDUawxAXt
 CoCyAp3yiWcSw5cwf6H6rCMMVnTzmx6E=; b=WX7rQBy/W+I47wReU4etZU3KMGl
 bAPExMvnrQYyMoUcevs/P38kBW4JkxA73jN0TKQQp/nkuT8NzK9oOPbbM6ANmC8D
 g5eeEGAm1NB08GxbnCeI4bVo93rdT0QZ9uDjPvYkQY6lAG8QKgNOsh3ZUveAaiwa
 Q6BuXPxJd5Qm6/6+UxZQncWKV1Bkwl1lnxZMf3UaH2aMCVmEKt8zV/BKHAaA/8xd
 9HE8RxqqH+V7pHVPWMdMi1CXQmgjkqMr0tfOVChZyFO4cdzQy9JHI5FP+sIj+n0k
 wkuE+O9JT92ijwTi6dpbN8bqhZ3gF/OZJqHs790Z3nvbsiq4YgcDFO0ph8A==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hqm2pjbja-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2026 05:06:26 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-36c98e5ad40so49506eec.0
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2026 21:06:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793768786; x=1794373586; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=d+pDUawxAXtCoCyAp3yiWcSw5cwf6H6rCMMVnTzmx6E=;
 b=frBWnXeIuuw14p0QIb0TrCLr13EoFHQgyyJgf5a/TJWRpdjnSbXHM2en3akJzFV6Yx
 3XmSi5vh2PzfmoD4aRYRTXP6bR1L4xFgo2Eua9d7d8AQU01yKRq7jcFofawIdbPIQGP+
 j2wjP3x+Hs9A435eY8yv3aY2UvYoSUdNtrgbLxldGQvc2G05EZmd1sarcVFT9NTOwQF2
 vh0VbWgKYU2B0V14ruxJy+k0hUQoZdIjyDSKOvU/OsJSPyLYOG/GgTzQHDyP94whaOcP
 9tanW2YElGpwtli9q6wIywwjpbVQ4ZCtmiEJUWTa3sGHO0IHrCBRm/xP4kKqHmSS0Yjw
 XfFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793768786; x=1794373586;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=d+pDUawxAXtCoCyAp3yiWcSw5cwf6H6rCMMVnTzmx6E=;
 b=CPQS9SKimemFeUMHxAd6UhjIVBZPgPzIK+Q/Q4/L+qcovbRXD6C+bcGGfAtpHm/nqg
 u5Q0HBSdI4RAWjwzUeh3++Uwj1o+MfKZvqbT7sp4eCaTgLJ5qYi1Gd2dv4ORcwsDMEii
 1AIZWGy+o7kQAXrp5/Hf5nzwO115MMRuVUWz8LWXnrJeomzoItTieN+Ow7gDVOvgOn/W
 lw3gJiMMbYDxRTG1dYpw1F4if5dNzzuVjfrTar/CsX5o1bzE0rGFk5jIz5UA+GZH+0Ek
 W/jkubiFLOcAL3EEixctb/3i6pQJoGUgEwtxwo8Jjf7B1LaYu//TieFwAt/BbaVg/Ho3
 Oz+Q==
X-Gm-Message-State: APuU4Z/20JXpDtamMqJNPCGaXPnOm1S9Grv7ACxTgpOWghvtmQCGN6NO
 bIMzFoiHCdXykRcaIPGjiyJwN5IrqtwRsUwf9rtMs0TcgNWYN0Q6XKRJ0CtY2A3fNwuwdcpjaJD
 i57ZmJ9sD17o0xBjWDY6M9MiUpN53x9sZdqY7dkayegM2Y6xgzWn3yXggR2jDrdXNjg==
X-Gm-Gg: AYBFou0giUlj3lCWtDVHt011r4s1s8yPfB/091GA3y788lVQWhjwoY0OObewVBkcfKR
 mACdBprtl2mf7RjntrXbTD2uM5WHX8xu+w96V/eheqocpcLn1mhB5zCUie4MEKzXJFdLiZO9UfD
 IRomtt1IpeeYCbsn7vGOGYSkqGIHDA/hTAPRLoZzVEU7Vx8VGGMdPwJVgAvkhhbQXCaAeAQN2q8
 jh1gs30+GSgtwoKoicTXUL8hJOg/1J8U4SMqVhq4grLBLcEB8uMJ+jj3BZC11auF7yXdP9AZ80B
 T7BDFTljvHpiUBFqKM8E0mvvQiOfO33V1K1Uc10FcVkGO9Ya+bClm1lfTFrRB3+J0FoS5dwy/4M
 FEMO5bpvCOcXXf6TjLjNz/KkqbLxDmFsPlf5X2652ZDxFVjPox9Xa0ZxRZ/MwY6KYrnrDW+37z1
 B7zud2feyDsM9SuLYuHMrJodwC/zmajPYovlbjOiP79EfOtpKEPWDekcmSV2gAIV8eEGh/e4yXm
 p5hm4k/
X-Received: by 2002:a05:7301:fa6:b0:369:f195:a5ff with SMTP id
 5a478bee46e88-36a4231f8e3mr34526488eec.1.1793768785215; 
 Tue, 03 Nov 2026 21:06:25 -0800 (PST)
X-Received: by 2002:a05:7301:fa6:b0:369:f195:a5ff with SMTP id
 5a478bee46e88-36a4231f8e3mr34526445eec.1.1793768784515; 
 Tue, 03 Nov 2026 21:06:24 -0800 (PST)
Received: from hu-slingapp-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36ca390df28sm3925036eec.18.2026.11.03.21.06.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 21:06:24 -0800 (PST)
From: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org,
 Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>
Subject: [PATCH v14 07/10] riscv: add RPMI system suspend service
Date: Wed,  4 Nov 2026 10:33:20 +0530
Message-ID: <20261104050324.733555-8-subrahmanya.lingappa@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261104050324.733555-1-subrahmanya.lingappa@oss.qualcomm.com>
References: <20261104050324.733555-1-subrahmanya.lingappa@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDAyMCBTYWx0ZWRfX7p2/bCN2WGh2
 rm5ieiDa+O6DvcbnEsvUrJsNXMDRQsnXprR5fs8+O26Nqgu7zxs6V1FkpyEgMUGRYMy1T8/XrT+
 DAI3rSpxR7QFrqbv4arQtWpH2D9dZhdU1Vuj1jgIQWMl4R3VENjpgO2NG/lBWRzMN4DO2Pkjjcb
 qYZb+CrD3JseA4FT/pHIsp9akWODqTn7sSuRiqYHMPf1QuO73VDd0zrszhHbcBbzMdA4NALBdmn
 3uD+gPOK0rbp0QlbFSpQ0nNDau2wFaQKIoLuWdSeMIm5hPqnCr7ScL0pyeQeyOdH+ReDTfgnMSf
 afwnXA+YMhjOIdPUb3+WJEHQy31x0Him7UaVSyYt4Z6rsygjuawSe3vn/Oygq44uLi1B6GdIajI
 YGeD3PmrO6YYbvl1EdHPxKkBCV7adqINAG42k7QDas9yOdV380RgYu5ceJNqIwUi+WFd88/iNsY
 tCy01t3vy9Ljh+DJGrQ==
X-Proofpoint-GUID: UAOXQitXyYRe2kSu2xj-7aV3y7g3_pRR
X-Proofpoint-ORIG-GUID: UAOXQitXyYRe2kSu2xj-7aV3y7g3_pRR
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDAyMCBTYWx0ZWRfX1tj7sACs5l42
 ySfX4MZlV8L7VHMYLMF1x67CJEmyq1CayoyzXNGGAB53grBT0PWCSibS0VOG3OlF+YmFCI9jeN3
 AiHMad5Gd5fs8H9loWd5v96fCY+a09w=
X-Authority-Analysis: v=2.4 cv=c64+0h9l c=1 sm=1 tr=0 ts=6aeabd52 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=Mh6PCMENURz3S0C0lcMA:9 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_01,2026-11-03_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 adultscore=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611040020
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=subrahmanya.lingappa@oss.qualcomm.com;
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
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add the RPMI System Suspend service group for RISC-V virt.

The service advertises suspend-to-RAM support through librpmi, registers QEMU wakeup support, and routes the finalize callback to the generic system suspend path. Process only the accepted System Suspend event instead of polling every RPMI service group from an unrelated doorbell request.

On wakeup, publish the suspend event under the BQL and defer the HSM hart resume until vCPUs are ready to run. Cancel stale wakeup work during teardown. Machine reset removes and recreates System Suspend around HSM reconstruction so the service always references the current HSM object.

Reject malformed resume addresses before accepting suspend. Require the
target hart's configured instruction alignment and address width, and verify
that the resume PC is backed by RAM in the active system-memory map.

Signed-off-by: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
---
 hw/misc/meson.build           |   2 +
 hw/misc/riscv_rpmi.c          |  30 ++++--
 hw/misc/riscv_rpmi_hsm.c      |  15 +++
 hw/misc/riscv_rpmi_internal.h |   8 +-
 hw/misc/riscv_rpmi_syssusp.c  | 198 ++++++++++++++++++++++++++++++++++
 hw/riscv/virt.c               |   5 +
 include/hw/misc/riscv_rpmi.h  |   9 ++
 7 files changed, 259 insertions(+), 8 deletions(-)
 create mode 100644 hw/misc/riscv_rpmi_syssusp.c

diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index 6d93cd4ab0..1dc7aa7c67 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -188,3 +188,5 @@ system_ss.add(when: 'CONFIG_RISCV_RPMI', if_true: [files(
   'riscv_rpmi_sysreset.c',
   'riscv_rpmi_hsm.c',
 ), librpmi], if_false: files('riscv_rpmi-stub.c'))
+specific_ss.add(when: 'CONFIG_RISCV_RPMI',
+                if_true: [files('riscv_rpmi_syssusp.c'), librpmi])
diff --git a/hw/misc/riscv_rpmi.c b/hw/misc/riscv_rpmi.c
index 1bf9d77b04..56a092e49e 100644
--- a/hw/misc/riscv_rpmi.c
+++ b/hw/misc/riscv_rpmi.c
@@ -214,6 +214,10 @@ static const RiscvRpmiServiceOps riscv_rpmi_service_ops[] = {
         .service_group = RPMI_SRVGRP_HSM,
         .add = riscv_rpmi_hsm_add,
         .remove = riscv_rpmi_hsm_remove,
+    }, {
+        .service_group = RPMI_SRVGRP_SYSTEM_SUSPEND,
+        .add = riscv_rpmi_syssusp_add,
+        .remove = riscv_rpmi_syssusp_remove,
     },
 };
 
@@ -256,6 +260,7 @@ static void riscv_rpmi_init(Object *obj)
 static void riscv_rpmi_reset_hold(Object *obj, ResetType type)
 {
     RiscvRpmiState *s = RISCV_RPMI(obj);
+    bool reset_syssusp = s->syssusp_group != NULL;
 
     s->doorbell = 0;
 
@@ -263,9 +268,15 @@ static void riscv_rpmi_reset_hold(Object *obj, ResetType type)
         memset(memory_region_get_ram_ptr(&s->shmem), 0, s->shmem_size);
         memory_region_set_dirty(&s->shmem, 0, s->shmem_size);
     }
+    if (reset_syssusp) {
+        riscv_rpmi_syssusp_remove(s);
+    }
     if (!riscv_rpmi_hsm_reset(s, &error_abort)) {
         return;
     }
+    if (reset_syssusp && !riscv_rpmi_syssusp_add(s, &error_abort)) {
+        return;
+    }
 }
 
 static void riscv_rpmi_cleanup(RiscvRpmiState *s)
@@ -309,13 +320,6 @@ bool riscv_rpmi_service_enabled(RiscvRpmiState *s,
     return false;
 }
 
-void riscv_rpmi_context_process_a2p_request(RiscvRpmiState *s)
-{
-    if (s->context) {
-        rpmi_context_process_a2p_request(s->context);
-    }
-}
-
 bool riscv_rpmi_context_add_group(RiscvRpmiState *s,
                                   struct rpmi_service_group *group,
                                   const char *name,
@@ -340,6 +344,18 @@ void riscv_rpmi_context_remove_group(RiscvRpmiState *s,
     }
 }
 
+void riscv_rpmi_context_process_a2p_request(RiscvRpmiState *s)
+{
+    if (s->context) {
+        rpmi_context_process_a2p_request(s->context);
+        if (s->syssusp_event_pending && s->syssusp_group) {
+            s->syssusp_event_pending = false;
+            rpmi_context_process_group_events(s->context,
+                                              RPMI_SRVGRP_SYSTEM_SUSPEND);
+        }
+    }
+}
+
 static bool riscv_rpmi_validate_config(RiscvRpmiState *s, Error **errp)
 {
     uint64_t queue_bytes;
diff --git a/hw/misc/riscv_rpmi_hsm.c b/hw/misc/riscv_rpmi_hsm.c
index 42a4f3b096..08e78e1ee7 100644
--- a/hw/misc/riscv_rpmi_hsm.c
+++ b/hw/misc/riscv_rpmi_hsm.c
@@ -42,6 +42,7 @@ static RiscvRpmiHsmHart *riscv_rpmi_hsm_hart(RiscvRpmiState *s,
 
     return &s->hsm_harts[hart_index];
 }
+
 static void riscv_rpmi_hsm_wfi(CPUState *cpu, bool entering, void *opaque)
 {
     RiscvRpmiHsmHart *hart = opaque;
@@ -342,3 +343,17 @@ bool riscv_rpmi_hsm_reset(RiscvRpmiState *s, Error **errp)
     s->hsm_group = group;
     return true;
 }
+
+void riscv_rpmi_hsm_resume(RiscvRpmiState *s, uint32_t hart_index,
+                           uint64_t resume_addr)
+{
+    RiscvRpmiHsmHart *hart = riscv_rpmi_hsm_hart(s, hart_index);
+
+    if (!hart) {
+        return;
+    }
+
+    hart->start_addr = resume_addr;
+    run_on_cpu(hart->cpu, riscv_rpmi_hsm_start_cpu,
+               RUN_ON_CPU_HOST_PTR(hart));
+}
diff --git a/hw/misc/riscv_rpmi_internal.h b/hw/misc/riscv_rpmi_internal.h
index e56dba5b1a..8739c3f041 100644
--- a/hw/misc/riscv_rpmi_internal.h
+++ b/hw/misc/riscv_rpmi_internal.h
@@ -20,18 +20,24 @@
 extern const struct rpmi_shmem_platform_ops rpmi_shmem_qemu_ops;
 bool riscv_rpmi_service_enabled(RiscvRpmiState *s,
                                 enum rpmi_servicegroup_id service_group);
-void riscv_rpmi_context_process_a2p_request(RiscvRpmiState *s);
 bool riscv_rpmi_context_add_group(RiscvRpmiState *s,
                                   struct rpmi_service_group *group,
                                   const char *name,
                                   Error **errp);
 void riscv_rpmi_context_remove_group(RiscvRpmiState *s,
                                      struct rpmi_service_group *group);
+void riscv_rpmi_context_process_a2p_request(RiscvRpmiState *s);
+
 bool riscv_rpmi_sysreset_add(RiscvRpmiState *s, Error **errp);
 void riscv_rpmi_sysreset_remove(RiscvRpmiState *s);
 
 bool riscv_rpmi_hsm_add(RiscvRpmiState *s, Error **errp);
 void riscv_rpmi_hsm_remove(RiscvRpmiState *s);
 bool riscv_rpmi_hsm_reset(RiscvRpmiState *s, Error **errp);
+void riscv_rpmi_hsm_resume(RiscvRpmiState *s, uint32_t hart_index,
+                           uint64_t resume_addr);
+
+bool riscv_rpmi_syssusp_add(RiscvRpmiState *s, Error **errp);
+void riscv_rpmi_syssusp_remove(RiscvRpmiState *s);
 
 #endif
diff --git a/hw/misc/riscv_rpmi_syssusp.c b/hw/misc/riscv_rpmi_syssusp.c
new file mode 100644
index 0000000000..d70536a27a
--- /dev/null
+++ b/hw/misc/riscv_rpmi_syssusp.c
@@ -0,0 +1,198 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * RISC-V RPMI System Suspend service.
+ *
+ * Copyright (c) 2026 Qualcomm Technologies, Inc.
+ * Author:
+ *  Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
+ */
+
+#include "qemu/osdep.h"
+#include "riscv_rpmi_internal.h"
+#include "system/address-spaces.h"
+#include "system/memory.h"
+#include "qemu/timer.h"
+#include "system/cpus.h"
+#include "system/runstate.h"
+#include "target/riscv/cpu.h"
+
+static const struct rpmi_system_suspend_type riscv_rpmi_syssusp_types[] = {
+    {
+        .type = RPMI_SYSSUSP_TYPE_SUSPEND_TO_RAM,
+        .attr = RPMI_SYSSUSP_ATTRS_FLAGS_RESUMEADDR,
+    },
+};
+
+static enum rpmi_error riscv_rpmi_syssusp_prepare(
+    void *priv, rpmi_uint32_t hart_index,
+    const struct rpmi_system_suspend_type *syssusp_type,
+    rpmi_uint64_t resume_addr)
+{
+    RiscvRpmiState *s = priv;
+    RISCVCPU *cpu = RISCV_CPU(cpu_by_arch_id(s->hart_ids[hart_index]));
+    unsigned int alignment = ((cpu->env.misa_ext_mask & RVC) ||
+                              cpu->cfg.ext_zca) ? 2 : 4;
+    MemoryRegionSection section;
+
+    if ((resume_addr & (alignment - 1)) ||
+        (cpu->env.misa_mxl == MXL_RV32 && resume_addr > UINT32_MAX)) {
+        return RPMI_ERR_INVALID_ADDR;
+    }
+
+    section = memory_region_find(get_system_memory(), resume_addr, 1);
+    if (!section.mr || !memory_region_is_ram(section.mr) ||
+        memory_region_is_rom(section.mr)) {
+        if (section.mr) {
+            memory_region_unref(section.mr);
+        }
+        return RPMI_ERR_INVALID_ADDR;
+    }
+    memory_region_unref(section.mr);
+
+    /* The accepted request needs one targeted event pass to finalize it. */
+    s->syssusp_event_pending = true;
+    return RPMI_SUCCESS;
+}
+
+static rpmi_bool_t riscv_rpmi_syssusp_ready(void *priv,
+                                            rpmi_uint32_t hart_index)
+{
+    return true;
+}
+
+static void riscv_rpmi_syssusp_finalize(
+    void *priv, rpmi_uint32_t hart_index,
+    const struct rpmi_system_suspend_type *syssusp_type,
+    rpmi_uint64_t resume_addr)
+{
+    qemu_system_suspend_request();
+}
+
+static rpmi_bool_t riscv_rpmi_syssusp_can_resume(void *priv,
+                                                 rpmi_uint32_t hart_index)
+{
+    return runstate_check(RUN_STATE_RUNNING);
+}
+
+static enum rpmi_error riscv_rpmi_syssusp_resume(
+    void *priv, rpmi_uint32_t hart_index,
+    const struct rpmi_system_suspend_type *syssusp_type,
+    rpmi_uint64_t resume_addr)
+{
+    RiscvRpmiState *s = priv;
+
+    s->syssusp_resume_hart_index = hart_index;
+    s->syssusp_resume_addr = resume_addr;
+    s->syssusp_resume_pending = true;
+    return RPMI_SUCCESS;
+}
+
+static const struct rpmi_syssusp_platform_ops riscv_rpmi_syssusp_ops = {
+    .system_suspend_prepare = riscv_rpmi_syssusp_prepare,
+    .system_suspend_ready = riscv_rpmi_syssusp_ready,
+    .system_suspend_finalize = riscv_rpmi_syssusp_finalize,
+    .system_suspend_can_resume = riscv_rpmi_syssusp_can_resume,
+    .system_suspend_resume = riscv_rpmi_syssusp_resume,
+};
+
+static void riscv_rpmi_wakeup_timer(void *opaque)
+{
+    RiscvRpmiState *s = opaque;
+
+    if (s->syssusp_resume_pending) {
+        riscv_rpmi_hsm_resume(s, s->syssusp_resume_hart_index,
+                              s->syssusp_resume_addr);
+        s->syssusp_resume_pending = false;
+        s->syssusp_resume_addr = 0;
+    }
+}
+
+static void riscv_rpmi_wakeup_notify(Notifier *notifier, void *data)
+{
+    RiscvRpmiState *s = container_of(notifier, RiscvRpmiState,
+                                     wakeup_notifier);
+
+    rpmi_context_process_group_events(s->context,
+                                      RPMI_SRVGRP_SYSTEM_SUSPEND);
+    /*
+     * Wakeup notifiers run before vCPUs resume. Defer the HSM kick so
+     * OpenSBI can leave WFI after QEMU restarts execution.
+     */
+    timer_mod(s->wakeup_timer, qemu_clock_get_ms(QEMU_CLOCK_REALTIME) + 10);
+}
+
+static bool riscv_rpmi_syssusp_create(RiscvRpmiState *s,
+                                      struct rpmi_service_group **group,
+                                      Error **errp)
+{
+    if (!s->hsm) {
+        error_setg(errp, "RPMI system suspend service requires HSM service");
+        return false;
+    }
+
+    *group = rpmi_service_group_syssusp_create(
+        s->hsm, ARRAY_SIZE(riscv_rpmi_syssusp_types),
+        riscv_rpmi_syssusp_types, &riscv_rpmi_syssusp_ops, s);
+    if (!*group) {
+        error_setg(errp, "failed to create RPMI system suspend service group");
+        return false;
+    }
+
+    qemu_register_wakeup_support();
+    s->wakeup_timer = timer_new_ms(QEMU_CLOCK_REALTIME,
+                                   riscv_rpmi_wakeup_timer, s);
+    s->wakeup_notifier.notify = riscv_rpmi_wakeup_notify;
+    qemu_register_wakeup_notifier(&s->wakeup_notifier);
+    return true;
+}
+
+static void riscv_rpmi_syssusp_destroy(RiscvRpmiState *s)
+{
+    notifier_remove(&s->wakeup_notifier);
+    timer_free(s->wakeup_timer);
+    s->wakeup_timer = NULL;
+
+    s->syssusp_event_pending = false;
+    s->syssusp_resume_pending = false;
+    s->syssusp_resume_hart_index = 0;
+    s->syssusp_resume_addr = 0;
+
+    if (s->syssusp_group) {
+        rpmi_service_group_syssusp_destroy(s->syssusp_group);
+        s->syssusp_group = NULL;
+    }
+}
+
+bool riscv_rpmi_syssusp_add(RiscvRpmiState *s, Error **errp)
+{
+    struct rpmi_service_group *group;
+
+    if (s->syssusp_group) {
+        error_setg(errp, "duplicate RPMI system suspend descriptor");
+        return false;
+    }
+
+    if (!riscv_rpmi_syssusp_create(s, &group, errp)) {
+        return false;
+    }
+
+    if (!riscv_rpmi_context_add_group(s, group, "system suspend", errp)) {
+        s->syssusp_group = group;
+        riscv_rpmi_syssusp_destroy(s);
+        return false;
+    }
+
+    s->syssusp_group = group;
+    return true;
+}
+
+void riscv_rpmi_syssusp_remove(RiscvRpmiState *s)
+{
+    if (!s->syssusp_group) {
+        return;
+    }
+
+    riscv_rpmi_context_remove_group(s, s->syssusp_group);
+    riscv_rpmi_syssusp_destroy(s);
+}
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 32aa13325e..53a31d1abd 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -490,6 +490,11 @@ static const RiscvRpmiServiceConfig virt_rpmi_services[] = {
         .compatible = "riscv,rpmi-hsm",
         .service_group = RPMI_SRVGRP_HSM,
     },
+    {
+        .node_name = "suspend",
+        .compatible = "riscv,rpmi-system-suspend",
+        .service_group = RPMI_SRVGRP_SYSTEM_SUSPEND,
+    },
 };
 
 static uint32_t virt_rpmi_service_count(void)
diff --git a/include/hw/misc/riscv_rpmi.h b/include/hw/misc/riscv_rpmi.h
index 3a240941cd..3aaaaf68ae 100644
--- a/include/hw/misc/riscv_rpmi.h
+++ b/include/hw/misc/riscv_rpmi.h
@@ -13,6 +13,8 @@
 
 #include "exec/hwaddr.h"
 #include "hw/core/sysbus.h"
+#include "qemu/notify.h"
+#include "qemu/timer.h"
 #include "qom/object.h"
 
 #ifdef CONFIG_LIBRPMI
@@ -84,9 +86,16 @@ struct RiscvRpmiState {
     char *platform_info;
     const RiscvRpmiMachineOps *machine_ops;
     struct rpmi_service_group *sysreset_group;
+    struct rpmi_service_group *syssusp_group;
     struct rpmi_hsm *hsm;
     struct rpmi_service_group *hsm_group;
     RiscvRpmiHsmHart *hsm_harts;
+    bool syssusp_event_pending;
+    Notifier wakeup_notifier;
+    QEMUTimer *wakeup_timer;
+    bool syssusp_resume_pending;
+    uint32_t syssusp_resume_hart_index;
+    uint64_t syssusp_resume_addr;
     uint32_t *hart_ids;
     uint32_t hart_count;
     const RiscvRpmiServiceConfig *services;

