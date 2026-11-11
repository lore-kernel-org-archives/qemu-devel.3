Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5632606A31C
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 06:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=f1BQlFBb;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Fxo233Lo
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xR1SH-0008HA-LW; Wed, 11 Nov 2026 01:05:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1xR1SF-0008F6-Nr
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 01:05:07 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1xR1SD-0000lR-4n
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 01:05:07 -0500
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AB5KDIe863470
 for <qemu-devel@nongnu.org>; Wed, 11 Nov 2026 06:05:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=qF2EeNk9VqJ
 9/cd2mmxxCU1YhPyZgJdWd31R12OE3w0=; b=f1BQlFBbLBT5hgdzdrLre5yZ/t4
 qtJ/aO+1Ev16wF1fTdE2GpvMZUj+yFg/c6DmZxPaJdHYfmHtJ8ovtNO6mcpW79KU
 8MBrI8HlP+oSYo2mH5luHsDrlqXvsr9+E/f0xem2XeXo8hGARxIWMMqYGExx5TlZ
 RZmuxrwHN2O6HVd7L++j33XHRoM/I6xGvR0yDaT2Y5TS1AOq8b2RdRQF7io1VYt0
 faa+hKCw9o9+9tRKr46ZimLTgabSR/6/3fu32KwNQ1De2YP0vTtgts6Zro4XIekh
 /35t6p5QIBfmzhlg7Hj8cOdnpaJ73vO3QRs1Aa5zYb3+7YgXT9Whts1we3A==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvfawgqqp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 11 Nov 2026 06:05:03 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id
 ada2fe7eead31-77f133855b9so7805137.1
 for <qemu-devel@nongnu.org>; Tue, 10 Nov 2026 22:05:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794377102; x=1794981902; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qF2EeNk9VqJ9/cd2mmxxCU1YhPyZgJdWd31R12OE3w0=;
 b=Fxo233LoLom8HLqCbnwfACYGbZ65brGq80PS7ycTOIXs7WfoWlrRvAs+9eK7M5ROBv
 gwVSecTwWXgIBaW9BGZMcIWT17kIdVMdHjmFgGe7ERGD8iNSLUO7ytl+eGqJ5YSsEeaU
 0UrdCEHcWkqeD0IqBRafQQyAScwmGaj3klBM1hHJEUvDtee6SK5HXexlmiMas/tVkm0M
 XSmyONU987TnMRib8oz2TZ88wuE/rc453k7C8oOomymwot5Adop+Cef9Tfb7thm/NHi1
 CU9XgRjchxhalxTXpYJQd+gk+nh6Nzp76Hve+S/OQuMVInSlEZ76ReVNXCt10SjWT88G
 s2NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794377102; x=1794981902;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=qF2EeNk9VqJ9/cd2mmxxCU1YhPyZgJdWd31R12OE3w0=;
 b=CSTQukRsdrDw0UmzE8lVtHWGH4f2/xb4DFRvtmGgfFWOQNPQ3/01wZPRaE7xDB7e52
 b0CakSGuu0YklmvS8pUJkniWXNpDGdS8nSfi7FXMTT7KadHOcO3iwUPcP+fEnR9fQQsL
 ZyBS61NgkjTN5wc7alB/D7Cpq6RSjK4gdmMo2kfOApQYgy/wWRdOfgSj428WZt/l2liC
 7TfRkv4m1twIqfqYw9gfrjxRgfMvtx224wklUjIjr2DQ+ab82gy8Z3LtiAOCyjuUSgH9
 ZbKyp3NGMqAvjpTOpTtF3f854Jv9qjZepIb8HRmHCd4+vEYfiLfmht8W5g7ZmKQhct+e
 dTag==
X-Gm-Message-State: APuU4Z/Dit2HbOzeWSvFAQTbFw+pnN1Uf2uyfaL81/xRYXrTdnbJhkz7
 V/0MAUAjWiRv4opoBvmThEFXK13FG+jL6lL43e3xGNKj38TitKW7QTzM+lWhtLZgauhuHv2s6cO
 BspiPmjIZ3Ue5/8sfYSwq9pPWDb45a1fQKNE4Dj1/8ga5I5ioQFO+nNoJZ9DyVDyUeA==
X-Gm-Gg: AYBFou3OD5en8+XorC6iy4LNsajMZUdh+eE0V2b+foTg4h0m3x1eCnb/ISOsdi6PRMU
 4tBTPHNR7kbhTof7Z2ahiMq4PpQl0qwrQstede4V2z4+YavW66xCL1mlOTq8Hnt2zgjIOeZr8Tf
 olcJUvWYgVIkbpNvag8ZCnAi9OjM9ZDjvsKEvIW9xp+fDPO675zUsAKJGGOL5DtCjLGjYWCRAn8
 TLAHtLVAl7uOzl87EPL0TyMxYu335vgJnrRGsuNRwJHYUY32he8tOfaf6AaN9xelKP4Hr3fGrN6
 I26I4WDkdQwNWEKHOYsM7qjzNbjcF1goxIm3lDOBOKzW9ZyG9NZW7TUTZQDAiciJx6NTLvvgIpg
 6lw5u0tsrsQwinVKUDeycnvjtwZR4zqx6T5aKRg/z/pkbgM4Us0Ci9+ATBjPL9tiueEMxBIZbv4
 +GsQ/Q0M6THqmeRMUMaxPLIkk3lgAvOR6Jnhdf58hYdVuAczLoUZ+RzDqVbfZpjaIWxfdcYcAQ0
 H2XeyY=
X-Received: by 2002:a05:6102:6218:20b0:7b4:f1cd:80dd with SMTP id
 ada2fe7eead31-7d4ede113d2mr459438137.1.1794377102175; 
 Tue, 10 Nov 2026 22:05:02 -0800 (PST)
X-Received: by 2002:a05:6102:6218:20b0:7b4:f1cd:80dd with SMTP id
 ada2fe7eead31-7d4ede113d2mr459395137.1.1794377101577; 
 Tue, 10 Nov 2026 22:05:01 -0800 (PST)
Received: from hu-slingapp-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b3b5b2ff3bsm15067990c88.11.2026.11.10.22.04.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 22:05:01 -0800 (PST)
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
Subject: [PATCH v15 07/10] riscv: add RPMI system suspend service
Date: Wed, 11 Nov 2026 11:33:59 +0530
Message-ID: <20261111060403.3777501-8-subrahmanya.lingappa@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261111060403.3777501-1-subrahmanya.lingappa@oss.qualcomm.com>
References: <20261111060403.3777501-1-subrahmanya.lingappa@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDAyNCBTYWx0ZWRfX+MfzQvT2bQun
 IY383Xux88RGCt9QEmQ2DDy+zTmN8uUj2R3xy4TF5Vs0r6x0LvuerCUShidTvje7JDWfe858mya
 0gVdUjpvm9Tr1seTmaDMYpdgpzSX9WY=
X-Proofpoint-ORIG-GUID: 94yot_ooenA7MH6a7sPP0EJGhGobQ-Ca
X-Proofpoint-GUID: 94yot_ooenA7MH6a7sPP0EJGhGobQ-Ca
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDAyNCBTYWx0ZWRfX9E1x2PCrudir
 ZlJJRfsWYrbe2pKtdBs5oJDswKh6rFzi8ReYtnNlDkalqiGWM0xMhUc5btnMYZ+M/U5uU7CXLM6
 bjrJrkBJihw0pxkVFFgfFs4ySutqD/dpX5R+owUxJvsADxsRBLpUvK9GtDlKj4MFyWG6HyZAeTc
 7bleYnSBZbQ9Rf3oeKNa+l7WfQNACt/KLxN0eh9JZWgjdidFxPyySm7lFvpxq+GoJ2rR9daVdJf
 kagjno+QeIPck42mbVrzLSOqXNlkAVtmYVMhalu6YCJe+2/pd1b764Sd0OVqUmAPO792hOer21B
 qdSaUJQY6XF2SoiL5gnG4gTvjUpeS+hmrmPS7qiAYE82olu9hZB2/yxaGdCVLgGy0wHxSYxdw96
 /CiipeRGMqFP7Q3VhFWWw3dD2vuUsNFQ5Mr9SyKlZ/MogUDUxY9wmzTU9GavrssTPmdeiQOttSx
 QR6mNRsqZwdJKWdx5pQ==
X-Authority-Analysis: v=2.4 cv=CZadd7rl c=1 sm=1 tr=0 ts=6af4058f cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=Mh6PCMENURz3S0C0lcMA:9 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_02,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 phishscore=0 adultscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110024
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

The service advertises suspend-to-RAM support through librpmi, registers
QEMU wakeup support, and routes the finalize callback to the generic system
suspend path. Process only the accepted System Suspend event instead of
polling every RPMI service group from an unrelated doorbell request.

On wakeup, publish the suspend event under the BQL and defer the HSM hart
resume until vCPUs are ready to run. Cancel stale wakeup work during
teardown. Machine reset removes and recreates System Suspend around HSM
reconstruction so the service always references the current HSM object.

Reject malformed resume addresses before accepting suspend. Require the
target hart's configured instruction alignment and address width, and
verify that the resume PC is backed by RAM in the active system-memory map.

Validate the librpmi hart index and target CPU before accessing hart state.

Signed-off-by: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
---
 hw/misc/meson.build           |   2 +
 hw/misc/riscv_rpmi.c          |  30 +++--
 hw/misc/riscv_rpmi_hsm.c      |  15 +++
 hw/misc/riscv_rpmi_internal.h |   8 +-
 hw/misc/riscv_rpmi_syssusp.c  | 210 ++++++++++++++++++++++++++++++++++
 hw/riscv/virt.c               |   5 +
 include/hw/misc/riscv_rpmi.h  |   9 ++
 7 files changed, 271 insertions(+), 8 deletions(-)
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
index 0000000000..0754f4b570
--- /dev/null
+++ b/hw/misc/riscv_rpmi_syssusp.c
@@ -0,0 +1,210 @@
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
+    CPUState *target_cpu;
+    RISCVCPU *cpu;
+    unsigned int alignment;
+    MemoryRegionSection section;
+
+    if (!s->hart_ids || hart_index >= s->hart_count) {
+        return RPMI_ERR_INVALID_PARAM;
+    }
+
+    target_cpu = cpu_by_arch_id(s->hart_ids[hart_index]);
+    if (!target_cpu) {
+        return RPMI_ERR_INVALID_PARAM;
+    }
+    cpu = RISCV_CPU(target_cpu);
+    alignment = ((cpu->env.misa_ext_mask & RVC) ||
+                 cpu->cfg.ext_zca) ? 2 : 4;
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

