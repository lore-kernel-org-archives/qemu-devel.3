Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2122606A31D
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2026 17:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Ap2tylf9;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=O1PdNr6l
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKfgQ-00045k-RE; Sat, 24 Oct 2026 13:37:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xKfgB-00040P-5d
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 13:37:15 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xKfg9-0008Jv-1x
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 13:37:14 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69OHQgbw3256372
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 17:37:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=Z2pEkDwt+Ue
 G6hMatXJ8kazKLOszcym22PHppw/adCc=; b=Ap2tylf9R1BwMOcxlh3SN//jPV9
 rjUMGwZN70khbd6uwFqkItuBu5M3iOzj0HjNdfUoysOdeLwj/jhh+P6a9OzD/q3v
 eBpH3x5oEZtrZ87LtcKnVZbcjc+1J+4yBTVUdifGeENZGCCrRWrnY0IZ8Qlc/Ysy
 dUC3NplWOX3KCuYs/OeT/fe7mS70zBKoe5g/61gKa79celGgoQo2tl8ErFdMv+Bx
 ZD9He/8PSgjRJQupaW5WC1lz7G/L0k1BiHHzm4hYiPp5VM1NjXaqCq+CFNTuu7lq
 KIu5DNKQRZ6UO/2rKLRPqogN8kSL5XN/G7Tu3+WjP6SypryGXw7zYLOeHEQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgjcgssfq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 17:37:11 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-3addd73e66bso856468a91.2
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 10:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792863431; x=1793468231; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Z2pEkDwt+UeG6hMatXJ8kazKLOszcym22PHppw/adCc=;
 b=O1PdNr6lId9joCcY7YJbUtWfUh7+ZqLbquN9qRwm+7uHB1jjQ7+wYIei4wTEsYOSiY
 qxGDt4okUO8GF3blEFaeO5m/40RMkbaP2E6soaSX41bJ4zwVYg7Ux8v9tlAIzrknbdQO
 +2kbbLGx6pfEYyKTejq/vZl0fgL0fVQTrK05ThO/1piXhIN4s8dic00u6KCSqtp9H3xg
 z6AdvdcrAI//LaFrvHczHpDHcEhChTiTBER1l0cgX3muG2VW9TNWong0fRHmuYphTbIH
 QVfvR9ZTFXP21TVd6/zP61rxodIQYHt+pWDceTJZ0WW5a60Tqb+vZ1DqmAOrTAWTKbba
 0wtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792863431; x=1793468231;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Z2pEkDwt+UeG6hMatXJ8kazKLOszcym22PHppw/adCc=;
 b=0eMs1QqVDvX3QukwezsEakqUmbG1wrDGaGNTifLcVnusvRgElAA5N7alXJ3JamCHRN
 Iw7Bacp0OQ918zT47ft/SmQ8EapA5gmB7MT78zUrkUWMcnlNu1+WozhjYsFTs9vxLS7/
 m+oDJoVrkJVWgVMO2WEUC/p5R5DBve0rRSTPqNg9EAWsG9VC3jhekv3Q50ipDIimdqMV
 NAaVbnRpKoea0RnqV3hLpSDI24zYrkTy8ln3YseC2d5SyKGAM2yLJc3Rzg2vjzLrkdN5
 v2KdqN2FWYoWOH0Ow6fn8G8niGj2drZycv+Zce6kT5t6+59YjcbIO7DyEzVl8AmN8DJF
 QKCQ==
X-Gm-Message-State: AFq9FYKbI5IDLpk+r8ZOEpgmwYkAIOQXTC03/vyV8uugdE3nyiG2M6DQ
 DxLrWHoTIx4w+f1X47wMMFN4LoP6q+/9ILD5FsiQgD9KsgtaLIqM9EH8SOoJKq8s8zD2a5KMO3x
 ReJsrCSGeYn33aGnhIl9JRx/YVJDkMvrZdO3lVDk5Zq60Ar06BS8CSh/B+kI9d0yIPQ==
X-Gm-Gg: AYBFou2iLU1ALT6gqReIZiA3uCQBTreRhQyZhqhX6C7OxV/8lgI3NiE/GiZnGFKBdvw
 Wj1M8AzPzdeasug3wLskWH64rehkmk7Df+/PqhoBlXGatTWrDt/S78IxKUPlGjqsbycHd1A6y4A
 xUw/YVXpHz5hGgpkIcXbFXGQeomOPUVZfz4K2x2S9go46SD08geLcRdGkFuJ72w/kmdnVCHgVZw
 XJto+6peypEgfMDle6wUlsJh5jkcnLvLd0O5KiT5nxqTbpdHVmg3K8kvyHdK2VbwR9stSpzWYhc
 6hNuzKIXoVWq02f2jp/7qHHm6+IGfND/V0zAkt1SkZCXs/WD2tUZO3UvMDSrXfZzYi4+j5L1WCW
 r3B3Y2iMJUv2ZXsXbgLw5mkbSmxg+yYByCPYeSyFOKVxJDdbPLjNwje5G+cq9tMQ=
X-Received: by 2002:a17:90b:2648:b0:3ad:53a7:62d5 with SMTP id
 98e67ed59e1d1-3adeae6d7admr2042754a91.12.1792863430963; 
 Sat, 24 Oct 2026 10:37:10 -0700 (PDT)
X-Received: by 2002:a17:90b:2648:b0:3ad:53a7:62d5 with SMTP id
 98e67ed59e1d1-3adeae6d7admr2042732a91.12.1792863430444; 
 Sat, 24 Oct 2026 10:37:10 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3adebbb1a13sm3324093a91.2.2026.10.24.10.37.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Oct 2026 10:37:10 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 16/20] target/riscv: rename virt_acpi_setup to
 riscv_virt_acpi_setup
Date: Sat, 24 Oct 2026 17:36:45 +0000
Message-ID: <20261024173649.7405-17-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261024173649.7405-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261024173649.7405-1-pierrick.bouvier@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI0MDA3MCBTYWx0ZWRfX2c2pSe7aB9wW
 vIT8KGlLThMQ9wa4VjDnj6sbkFsDRz3b0qxM8eeRnqA67arkz8VhdEQvId08V2aEyBEEVdOhRZL
 qFgxd15moeKIVqI4EBzHjvQ/noY8HP0=
X-Proofpoint-GUID: LEOwWOHtFC_bCHkG1p9h_RQObfqT3XO5
X-Authority-Analysis: v=2.4 cv=JvhkP84C c=1 sm=1 tr=0 ts=6adcecc7 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=JF9118EUAAAA:8 a=tnRFC3LkjjiXvWSh4a8A:9
 a=iS9zxrgQBfv6-_F4QbHw:22 a=xVlTc564ipvMDusKsbsT:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI0MDA3MCBTYWx0ZWRfX2BrHRT7hj9ww
 gGbdYy+vCcQY0zapKyqWrMnesHvyhK0a4R+IS7gVsqVUc4HyTv+43MrEN6YGdu2DfI0Gf0nh7/U
 6bD/uLZ/ONEMmhUaGVYvU5zLpad72z5vjmMlZ0FOTyW5v/8xKXsuus8ASaspGmKK+RKJulIVxaN
 +Dy/3PjF2Th1jwPaVf7WMutA8X2LMVU2rw2Esi34kl3yx+V8nOTpX9JK4sBM2AtwhXrFs8nDSWQ
 tBtnknbcvQW48Pup/rINZBfvNHfU7nyQTlorLk43cHdJ8m/gCy+01W8N/FfiFGv63eb/ivYRDZf
 cF6gWLH/Hp/n7chWLAoL9FA+nc1DmYP4DSie/GZmpypkYdSoLEoCooQXitD/GlYnfYA/sK5rUn3
 D/ODTruw8AXUSm8gJPfYwJo8nc6+3q3ja/jnW/4b8VsKXuhETKqguHBGT928qg24eh2gYpTTBAB
 mQE61vnVOea1SRBt3RQ==
X-Proofpoint-ORIG-GUID: LEOwWOHtFC_bCHkG1p9h_RQObfqT3XO5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-24_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610240070
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

This removes conflict with same function from target/arm.

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Link: https://lore.kernel.org/qemu-devel/20261024061616.27381-6-pierrick.bouvier@oss.qualcomm.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 hw/riscv/virt-acpi-build.c | 2 +-
 hw/riscv/virt.c            | 2 +-
 include/hw/riscv/virt.h    | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
index 0475dcb5c60..4565359e908 100644
--- a/hw/riscv/virt-acpi-build.c
+++ b/hw/riscv/virt-acpi-build.c
@@ -1021,7 +1021,7 @@ static const VMStateDescription vmstate_virt_acpi_build = {
     },
 };
 
-void virt_acpi_setup(RISCVVirtState *s)
+void riscv_virt_acpi_setup(RISCVVirtState *s)
 {
     AcpiBuildTables tables;
     AcpiBuildState *build_state;
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 2c6f983f83f..de1c92463ad 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -712,7 +712,7 @@ static void virt_machine_done(Notifier *notifier, void *data)
     virt_build_smbios(s);
 
     if (virt_is_acpi_enabled(s)) {
-        virt_acpi_setup(s);
+        riscv_virt_acpi_setup(s);
     }
 }
 
diff --git a/include/hw/riscv/virt.h b/include/hw/riscv/virt.h
index 16d86edfcfc..6e4fbf4b647 100644
--- a/include/hw/riscv/virt.h
+++ b/include/hw/riscv/virt.h
@@ -122,7 +122,7 @@ enum {
     (VIRT_PLIC_CONTEXT_BASE + (__num_context) * VIRT_PLIC_CONTEXT_STRIDE)
 
 bool virt_is_iommu_sys_enabled(RISCVVirtState *s);
-void virt_acpi_setup(RISCVVirtState *vms);
+void riscv_virt_acpi_setup(RISCVVirtState *vms);
 
 /*
  * The virt machine physical address space used by some of the devices
-- 
2.43.0


