Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88347CCA490
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 23:23:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHrGk-0002st-E8; Fri, 16 Oct 2026 19:23:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHrGi-0002sB-T3
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 19:23:21 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHrGh-0001Rs-78
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 19:23:20 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69GNF9us482410
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 23:23:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=gxzfhBQPTlp
 QD1gauaZQgadOvZwnlYfgG+GUSV0P/rE=; b=aB/DaRdd8Tt2ZMoKFsj9Bx0xLR4
 ThvR612xhZPDx1SETKha3k0Xb9sP3XEy2UvVqkiSKB0qpFqBTngEu+MzYMqQAY9h
 MvIpcPN0dq8J47Jb6Ek7w1Ey1CGnL7VEWNxqVKnP3CrumUgw1DKPpyCJpUCVB5ho
 G4wzGwmsTyEDVM5KBoWyVu+rACRCTuEJb0BTP0pM36HTrXrRYoWLGVvG+2q1vLGt
 RmBVlewU4d5xrRAB+lLgZEzM8MoFsIWTqN47KOpUFieyLCEVoQC4LIMsHLx83zAB
 kKnqGPvMLdZUgtF698bPOibdWgIWIa5/SvMVt3d7tom5ewi9XpjdQ3eWPTw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hbrvwgxpd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 23:23:17 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-3aaee1fc104so603409a91.1
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 16:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792192997; x=1792797797; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gxzfhBQPTlpQD1gauaZQgadOvZwnlYfgG+GUSV0P/rE=;
 b=eO/QO323GnNSec0ISEQmDuc7a0AG/LolHmMwklQZaBPZBdUTDTbfRtMruZ3kI92c+P
 QM3kFy3vLdzAmnx86Dc3YeZonm5XS1eZ8cL0xYughOZSE9v7LUQUObQiOQABsVlIdnaZ
 4fZ2AKJKc9BvwgdyV2lvdGzDYc2PtVNRa1qQVtlNUaMw37g0SRoEdGopDX25F56oVja2
 qjDTYIbInYxHWVeMD6rDmdFEnKmpo1JOl7nsEHtZ8uclnw8ETgn4UZBj2NaLdlbzIF5k
 0156YgZ/cnLQzwVu2MSUmA4DmAipAoe2ES1Ix2zicau2HpoZ+cUmqUEQzcFGw+1sF7vx
 yhxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792192997; x=1792797797;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=gxzfhBQPTlpQD1gauaZQgadOvZwnlYfgG+GUSV0P/rE=;
 b=llwiVRjestA4G95HPjWtIp5Jx0Bu2qgkxtwLGXRYx/rBSag/8We8I8q8NIajGBWVLs
 SqQfQ/RNUUMu6Y7ev4BCuYmFZPgHVUyDfMvR0D7R88D4qkd6H8sfLkqKrn1c6UtT3f8+
 KHtFbod/TiX5KkMTtAzBg+uo9/VczKBwnlpjOtgTQtiUpqK5X6dwDnd0KPbUX+3TMlRw
 vJnVbxzPvXSjj31N4VPYAtO1Ngtve/217E+0ri1tXT+wlcdolQX81iqNjCPbEnFEN9za
 aSm0ldjTBWKE0/wiohKT0p1lN/2oezfsFqQAr1pFMEoMaJMUbnZaodgXGzyAzUYn6VF7
 4odA==
X-Gm-Message-State: AFq9FYJ8O45jZSHOAyrTt4ZGZgrkAgpEq338xT1HcDoXckZBSVK82eLj
 7DGz5c0X3z5Gl+CgIqIfEheT80X+fTvlVHb4Ywg0NzxHyznsPwbH/AjLgVltayje6pvAQXa7FD0
 7dBob24oZxllTKO+Iv7S9nJQcTJjK3Jz1Y1wES442dlD1pzUYCQSsUNbItWijia4jJA==
X-Gm-Gg: AYBFou12NVsqFfzL+rqjcSTMUUofHxN+P/O+ZZH59oqYQxoH5IuatyryreUGzUOZi/B
 II5wYLKOKdmmjx1FSWyD4V7GFLs20hDeeFmEcP3gJ8JgdJb2teghPNTPXVO+uRbx1IBSZ1/PN+3
 TsutP59Agw4iA1Q5oP0rnOPjeMyPTeey2z3FtECd+AlwoxR5x3evW4USrQqsMwjh7WqJRZS0pi6
 SSu1lmA+sGwwn9vtXBLON9bDfyhmC/y5fHLt/j7nLRTusN5eLWD+20Admi5yHqdMLzUDTYUquJb
 /WzMvLnmgcbdeDY5k4QvoMjaUsE3Y/2hOMrVYrcpEuPTNbRUQnTETpxM3YSeV7qnro1i1As2hhz
 p3cIBd0YxWd/tOCjb6dumiX/0dLEpfbe/OwkbEIfzj8b4JmVxJz9A1/TS2QQsRr4=
X-Received: by 2002:a17:90b:5743:b0:3a8:cc4f:3475 with SMTP id
 98e67ed59e1d1-3acef60db08mr1249142a91.60.1792192997080; 
 Fri, 16 Oct 2026 16:23:17 -0700 (PDT)
X-Received: by 2002:a17:90b:5743:b0:3a8:cc4f:3475 with SMTP id
 98e67ed59e1d1-3acef60db08mr1249121a91.60.1792192996586; 
 Fri, 16 Oct 2026 16:23:16 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3acd0cde4fdsm2829304a91.4.2026.10.16.16.23.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 16:23:16 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>, Anton Johansson <anjo@rev.ng>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Subject: [PATCH v2 4/9] hw/riscv/virt: restrict scope of virt_is_acpi_enabled
 to this file
Date: Fri, 16 Oct 2026 16:22:59 -0700
Message-ID: <20261016232304.1215119-5-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261016232304.1215119-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261016232304.1215119-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: McuZ5A_5iHvhPYfjMUo99tBZ0hUVLmyO
X-Authority-Analysis: v=2.4 cv=COa/zhrD c=1 sm=1 tr=0 ts=6ad2b1e5 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=1naKx9kII0DkZoFY_HMA:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: McuZ5A_5iHvhPYfjMUo99tBZ0hUVLmyO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDA5MyBTYWx0ZWRfX+DIKCJnNU9yw
 Aq8cTQqu9BHw2Z2YZZsPN6ScblI73wnUWpJNzU3M62AQ4dF7pLDsgQfJNR+hNtDh4bFyu4FheS7
 1rMELea2gG7C/HCGgD1qvf6zgmxL7uJKWeAzs7p9Vb6ZfQb0nVl49KsA7ofrPpP+9vd7zhs9SoN
 xaNNFfLRbrHeSRd7VZR9MS2tnwaxcddtHojzgs+wal2QJDX5wpGyWTC+oSAlEtLXyrd87oIfSU0
 z4Z/E1zREX1wS5KrcKi6BcJc7dMPOZMGFwcBJWh83xKd2EeOC2g6wSqZd4Bwokh/muQyZ/QUXp8
 /3ZE9mum3PYR4maZ2xtGmXBs84+4DXijzZ/TR3SMl07B5g99d9DbC6Ek1jUUWd0VlsDn183VrmD
 bn8BR/wSW5E0Ska7G6HhW3xGVaNqa21k9slmu8jODJjsENERR6S86YU+B/OUHszFX0AIeL8zJE+
 iD/tlzqv2woU5UAm5Vg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDA5MyBTYWx0ZWRfX5o/NZ1SoGLwA
 LyFVNVQJZ3+tJwIbRtp7f4FeVOg1yrWM4O+isXGVLoIKHdex+SRUUkzcunZKOPRp6FyjwU9J/JQ
 gj1s1+gBs8CUTDNN2G7K3sS5VqsDxoM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_04,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 malwarescore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610160093
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

This removes conflict with the same function from target/arm. To the
opposite of arm target, there is no external caller for this function.

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 hw/riscv/virt.c         | 10 +++++-----
 include/hw/riscv/virt.h |  1 -
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 894cdd97976..2c6f983f83f 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -72,6 +72,11 @@ static bool virt_use_kvm_aia_aplic_imsic(RISCVVirtAIAType aia_type)
     return riscv_is_kvm_aia_aplic_imsic(msimode);
 }
 
+static bool virt_is_acpi_enabled(RISCVVirtState *s)
+{
+    return s->acpi != ON_OFF_AUTO_OFF;
+}
+
 static bool virt_use_emulated_aplic(RISCVVirtAIAType aia_type)
 {
     bool msimode = aia_type == VIRT_AIA_TYPE_APLIC_IMSIC;
@@ -1067,11 +1072,6 @@ static void virt_set_iommu_sys(Object *obj, Visitor *v, const char *name,
     visit_type_OnOffAuto(v, name, &s->iommu_sys, errp);
 }
 
-bool virt_is_acpi_enabled(RISCVVirtState *s)
-{
-    return s->acpi != ON_OFF_AUTO_OFF;
-}
-
 static void virt_get_acpi(Object *obj, Visitor *v, const char *name,
                           void *opaque, Error **errp)
 {
diff --git a/include/hw/riscv/virt.h b/include/hw/riscv/virt.h
index e516898f9ad..16d86edfcfc 100644
--- a/include/hw/riscv/virt.h
+++ b/include/hw/riscv/virt.h
@@ -121,7 +121,6 @@ enum {
 #define VIRT_PLIC_SIZE(__num_context) \
     (VIRT_PLIC_CONTEXT_BASE + (__num_context) * VIRT_PLIC_CONTEXT_STRIDE)
 
-bool virt_is_acpi_enabled(RISCVVirtState *s);
 bool virt_is_iommu_sys_enabled(RISCVVirtState *s);
 void virt_acpi_setup(RISCVVirtState *vms);
 
-- 
2.47.3


