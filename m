Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE8D606A33A
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 08:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=a6V6Avu7;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ExlMcHx/
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNnTV-0002v2-8H; Mon, 02 Nov 2026 03:33:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1xNnT6-0002pd-MK
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 03:32:41 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1xNnT4-0004pq-4v
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 03:32:40 -0500
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A23vJVA3324695
 for <qemu-devel@nongnu.org>; Mon, 2 Nov 2026 08:32:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=o2WTlMn45sv
 ydn72LQlriq+X1SEu1otNlNrqtX8iKUs=; b=a6V6Avu7hTWJY38sTn3pRQquwk4
 w5B6o4hAwXUPn4vLbroECIetw5n+Gp1PPo58wEU3FVYPdIMPWmbnvpaf7nixSj4T
 8Ucm7VOy25yHzRM1uZ7c1iUDiM2m/zaDE/TIYw5vfCu4peUjh+JVMrhPwh9qaWqU
 +yYAZVuoLQe9L2b9u6dBrgR/7xoRAxqKTQhn4zZ5vglyX8QrUkeuS+6lWPMhjYlS
 M3X5BpyIURFfAT8ggngn5lVLd8XfctPylIZJGT7pZIA3FAEkhu/LStmT1n0TpCN/
 tWlz/j/ruASaCWnmwMfSGwXEvKIq/G93zNyCrkQdE5tP8MhuhillrUcvhug==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn7b6p329-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2026 08:32:37 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-33bf1d17dfeso393925eec.2
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2026 00:32:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793608356; x=1794213156; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=o2WTlMn45svydn72LQlriq+X1SEu1otNlNrqtX8iKUs=;
 b=ExlMcHx/5ysEpx75hwYk9Id0GbaZz7uGAygqR/leO8Rg2Fd6H+wNelpV3ptCw+j4+w
 EIs8hdZzqjtwqSRvP9GW9Ef3ohd/EnRMXBIJ/i5K64edICcRYxCjkCFj8/rPxUb5PCVr
 d0Vt5VAY04TTukbhsq76k3eaCWz2vrC0DA6qrQspRrVkNVqJrJF/2A8muTczU6NvbhLF
 WjhhnYI6TGP9wtNiVqw7Ej57LtMJCO5bazQ7MHMFbQ17FUZYazEYYeigy7QkyNV8wJ7n
 PwZr8E4IBuO0S0mBs7XuB6VGMRzPqAu+ij2x1IxjqbGOVhf2emTFFjJ0QZkwBH+MbCAo
 eZWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793608356; x=1794213156;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=o2WTlMn45svydn72LQlriq+X1SEu1otNlNrqtX8iKUs=;
 b=iWW5tynvgIIjCsu5aiq3KAtYqXkB3qXtAhJXjL/wplmYINVoJIGOicfoH9n1U9rlpV
 T69r67lv/iIbog+tMFu507RhGNGagVrJ4p505cEjdpkZmlZ6F+L+DuRx6ZL2vqbekr92
 BWMKHDtnm1XovEBO3xxytx3EpBrDVxNyokuIYQlEmeeo8yQ5b++J9T8Q4FOfAnaBWcLq
 Z1wlkml7siW1CeI4UL9XURynLHB8BqB2pXi5tz97BFGT0eiGMB9l5EbLcr3l+ZLPI38L
 HaH6avKXbn+Olfnu6+T5iR+jBSPJFANn7GKk+5zuFzcVu+oem6nI1DxfUYReXeFAwbyj
 v7OA==
X-Gm-Message-State: AFq9FYKD3Nkda6JIg/HoxupoWOd7SbBLCt3KXNZtk5J6SbrEb73VZv1A
 i59DMs2rqCV9oaq13g5reKd+ypKLBUuuo9/xoL6arnxb9EtNEDIFr0YkfDWJPdWwlHYDKsjSCX1
 jM+ElQTkEPDhZvmwtToJ5ZvU9hCNfyTyK50PD7mv7JXofbNNTT4DUp3v5vQfH0gNQjw==
X-Gm-Gg: AYBFou3GtHF/jqRcMzAjqXEaqArU+C+NSIvciLAeWECoJp8AULJcPi2fGF8MvkBr+/2
 EBb5JFXhzI0FV2pMpxIa/NQY1w2odjzCuAJBuG3Kf/8qoJcasGj1lb9EdrmrDNcbK8A3Y1g6AkM
 g4onv1fNPwhk8dcLWEjXo9xonFznX6il+R1ZLjXr3Zj2AtxyIUvDxNZaGXzGhhDkWHeKUVHHUNM
 1UrJouw7n28U7GTKjbBp2pb/HapTd12Xr6pca0sPW5Q7xggP+OzL7a6t2R7X4lkwg18hHPkKUop
 hKUQZSB1mhOuEHM6w/7j8ZqTjyXtueIG51I7jD831RZDWuZrtToYtikLwmYXsK0Y+WQ6qDs7Lg5
 fH2sKpXGh61Lue0Om2ef8rsFhRqm5AxPx9NEBKHZSDCUtaG9sPSNNHXTXDDY9hLalBbFGeMcC9x
 jn507+TWDFdiApk5PPL312QK/RbBeeQsiV6JP73H+06OlX2ZpWuYJHRALjD1pNWuVRNxBNwz3Qj
 HQSPgik
X-Received: by 2002:a05:7022:c46:b0:1a1:9106:cfff with SMTP id
 a92af1059eb24-1ac5c45fd28mr20482673c88.2.1793608355909; 
 Mon, 02 Nov 2026 00:32:35 -0800 (PST)
X-Received: by 2002:a05:7022:c46:b0:1a1:9106:cfff with SMTP id
 a92af1059eb24-1ac5c45fd28mr20482636c88.2.1793608355245; 
 Mon, 02 Nov 2026 00:32:35 -0800 (PST)
Received: from hu-slingapp-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b106edc7f8sm15083213c88.9.2026.11.02.00.32.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 00:32:34 -0800 (PST)
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
Subject: [PATCH v13 07/10] riscv: add RPMI system suspend service
Date: Mon,  2 Nov 2026 14:01:55 +0530
Message-ID: <20261102083159.3383468-8-subrahmanya.lingappa@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261102083159.3383468-1-subrahmanya.lingappa@oss.qualcomm.com>
References: <20261102083159.3383468-1-subrahmanya.lingappa@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: vfJpnHWPmchMxVBdTpGOuV5mMfIoBH7k
X-Authority-Analysis: v=2.4 cv=QuvLTlyd c=1 sm=1 tr=0 ts=6ae84aa5 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=6a6dvNLtoisV_qPEzFoA:9 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-GUID: vfJpnHWPmchMxVBdTpGOuV5mMfIoBH7k
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDAzMyBTYWx0ZWRfX1nVqBU2OtNJJ
 +eWTZwzM5uNr7us0k4KrUejuMLMbevj2gL0GsoF9BNMKzJn9BVZjEbSntzRdXuv8maBe3BBNrSk
 yxc9J2V/+nNnU1vEcru6MIBvGZgE2+o=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDAzMyBTYWx0ZWRfX0SXKIx+9Ecj+
 WPPmNLkeawfZ+eyBlo18skJTLPw4r64lUoKknXlYTb+RnsbsNXpf9G+lx2ZfJoO/fPtf47PjBIG
 MtooUDcfWbF3CBwrplEWgHNeBcEtUvuPTUOYN3UxZS1XSYX4bYd6XDUW1Ng4Mi8swP5SoTtA75U
 vjTuR9URIpYuFL/XeCweTx1uhJusXDaOx6eyJoJFgRmHN/MBFiy36AvZoz0b0696nlUFP0BolKH
 nZlE0+8SNZ/gzE+u/LR+Zr4VlcaBhk/rzXyv2716HBUj0T0KF5kAVdl31kJWc4E0+rpvvVI3UKx
 nkNCDsQDXgd50vBq+PNd3i5kLZCHfalUu2rQDY4UedZvNn2BbiQXOmprhFrcXCUE++9KfDcRT4o
 7yUkWcJXvzdyl9ElWukCvXJSp7FByiZzhTsrBqyyf6x6033KxP3LVBFj1N/UT4azCUYm8F8BNa8
 wNR8ykjOIjlCrm4YGHw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 impostorscore=0 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020033
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=subrahmanya.lingappa@oss.qualcomm.com;
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

Add the RPMI System Suspend service group for RISC-V virt.

The service advertises suspend-to-RAM support through librpmi, registers QEMU wakeup support, and routes the finalize callback to the generic system suspend path. Process only the accepted System Suspend event instead of polling every RPMI service group from an unrelated doorbell request.

On wakeup, publish the suspend event under the BQL and defer the HSM hart resume until vCPUs are ready to run. Cancel stale wakeup work during teardown. Machine reset removes and recreates System Suspend around HSM reconstruction so the service always references the current HSM object.

Signed-off-by: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
---
 hw/misc/meson.build           |   1 +
 hw/misc/riscv_rpmi.c          |  30 ++++--
 hw/misc/riscv_rpmi_hsm.c      |  15 +++
 hw/misc/riscv_rpmi_internal.h |   8 +-
 hw/misc/riscv_rpmi_syssusp.c  | 175 ++++++++++++++++++++++++++++++++++
 hw/riscv/virt.c               |   5 +
 include/hw/misc/riscv_rpmi.h  |   9 ++
 7 files changed, 235 insertions(+), 8 deletions(-)
 create mode 100644 hw/misc/riscv_rpmi_syssusp.c

diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index 00ae6f1b41..b619452df3 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -185,4 +185,5 @@ system_ss.add(when: 'CONFIG_RISCV_RPMI', if_true: [files(
   'riscv_rpmi.c',
   'riscv_rpmi_sysreset.c',
   'riscv_rpmi_hsm.c',
+  'riscv_rpmi_syssusp.c',
 ), librpmi], if_false: files('riscv_rpmi-stub.c'))
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
index 0000000000..e614322330
--- /dev/null
+++ b/hw/misc/riscv_rpmi_syssusp.c
@@ -0,0 +1,175 @@
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
+#include "qemu/timer.h"
+#include "system/runstate.h"
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
index 876dd450f7..132387c740 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -483,6 +483,11 @@ static const RiscvRpmiServiceConfig virt_rpmi_services[] = {
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
-- 
2.43.0


