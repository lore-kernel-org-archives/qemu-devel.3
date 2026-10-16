Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55206CCF2C2
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 18:29:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHmf0-0007dG-Tl; Fri, 16 Oct 2026 14:28:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHmeu-0007ce-GT
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 14:28:00 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHmes-0002wf-MT
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 14:28:00 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69GE654Q2154151
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 18:27:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=EkjBTuuNx1t
 3GDjOBqoqRzdYNtKWZGyVRWPYYW/o6iI=; b=VbGhBGIsBJnvN8MlgCmMxz74uF+
 gXdtzAziZN77DcexlGDaL2glTfuXVR6f/ICmlYS93lxKTiGBOSVyjR4z8NKFjU/Y
 mXTQLf2ygmJ0048jSJL7/A2O6TszxreKr1PxESs0lKbYneMlN870ZJnUx05odyAW
 bbh+cjRloNY6No4gP2izFItBkbgH6rA57V1ijdrFu1o1WZuRaeO7in9jLb7DV49Y
 Hhs63Uu8ADvCZy8S/x2hB9ohBIdA9YpQxs09JwqUF73TltOEX1RWMO9D0qvq7FOV
 ORil7ggoD2VI45YtNhklpACpeZMpwL58dUbmPjeEnEZG8Q8dEDITjW7lrvw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hbhumsue3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 18:27:57 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3ab868fe362so339856a91.2
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 11:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792175277; x=1792780077; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EkjBTuuNx1t3GDjOBqoqRzdYNtKWZGyVRWPYYW/o6iI=;
 b=jtc7FWlwcEnssX6foUE+GOvl+kQLqs2YEhiLUeEW90kwmDQE44NSme9bwgu93eoSza
 6AYU4RerRoLpgQAMqJ7XsCtTxSuR3g/pNaolqj7wh0wt3AqFZ311aVcXdLaMRCCMMzIU
 L1Q+tFI5PYX89Tw44X17kpvoLiO3PDIvrsSGi0Tycmcc3Ffe9smGc2YOc0kovGODY3oX
 z8Qv1a3eFiaeEzDJwEngYnK03bc6HrzCSYsgY6sRjEKr6trhgjFlqIsEo9JzK9LZ2mBY
 GaBwV3eRgAdmBy9LVoMS4wKsheZVkJ0e0jDdZZQMAnapwhfW6Hpu7LxFSEm2kjxv6xVi
 uvVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792175277; x=1792780077;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=EkjBTuuNx1t3GDjOBqoqRzdYNtKWZGyVRWPYYW/o6iI=;
 b=KeQtfuyYKyeF3MdylmjTSXbHQNQpJBRQqjuhgRTFclFUFnuRXf3LjSqLRaCr5h2dI9
 BHX28c59K9qKm1mufJjcyRe/z7T7h10B+CLKSbqEdwJKbQ2t/T1i/elJ+V7rVm2iCZD7
 fQgPQRFBqtaspmPdtk6Q8EJdugfdN7VPQ77gY5YWrwCj9w/cni/P4o9N2YjfQjzT/akG
 EXdgwqMQhNco54uUUfDS3AjoTXnxVkT0geOInV9fnMoGeVCjS8gIAUyX2c3o4MCloPf6
 pOwtIIbdi6az88M2oh4DZrGQ4CJVJEj6EgVho6o4/FSryNU68HIn6/bXSCJ/DtQ2+G/6
 qXJg==
X-Gm-Message-State: AFq9FYJJXiCcWwqtbWSwq3fBj8T4Zfjj9Kaizoye2zfCFWQ8gIIqB+M+
 0UyDDSeZ5HRqchjwLRSijcO3gka8kA/Wf+xkvTh71Fe3tO2e/Got0+hAjrAn15toryKbpt1Wh2g
 RZrsddJojdaJJ8r2zR81MQlvWtpECLuOMJWx/IF1Z1qbjl3OIAOjFxnG63Kz4CqywTQ==
X-Gm-Gg: AYBFou11+AtFtj2QRHpGIUvWawr2o263Q0lz9f+PHzsfFJHQqOxQjrHs6KMB50IACcu
 9radYfk2Hbvwh5x4eXADUW8BV+UyBd8KL5mZC0fTzMGQ2lnZ40j5cDk5B5Urwo0HJVKM7Bd0P3L
 NjXmCB/A+GNagHNLVQQkworVy/KjmRNHiUpsL2sJNQvvRgomHCaWjd9AHxGnClYDqSRoSxLmNbG
 Z8rpB+uYD6G0qP0XU3ymZ8Y0GffVaYt87TFnbVJ5tG58TqAFTHuArM9iMbh+DU/+i5QqLuxjTgV
 a9wFFhR1Yrx1Ay4EeKbj1lIZEaF0uICne8eqR15xMfPQfP6+OHLtUoJoZQWJrKLUOZJD4xo1y3C
 xuXZz9zOmnHzX5jgFyAGCDIHNwqW1m3KrirKjmEICEN4zND9gci+JyXmti1/+N+Y=
X-Received: by 2002:a05:6a20:ac44:b0:3e0:d508:59b0 with SMTP id
 adf61e73a8af0-3e2263a213dmr107292637.34.1792175276739; 
 Fri, 16 Oct 2026 11:27:56 -0700 (PDT)
X-Received: by 2002:a05:6a20:ac44:b0:3e0:d508:59b0 with SMTP id
 adf61e73a8af0-3e2263a213dmr107274637.34.1792175276269; 
 Fri, 16 Oct 2026 11:27:56 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cd6549c7034sm1557291a12.16.2026.10.16.11.27.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 11:27:55 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 2/6] target/riscv: rename virt_acpi_setup to
 riscv_virt_acpi_setup
Date: Fri, 16 Oct 2026 11:27:47 -0700
Message-ID: <20261016182751.264704-3-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261016182751.264704-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261016182751.264704-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDA3MyBTYWx0ZWRfXxrG3b8vmZJXF
 /p46iHf3UBV2b/g6YgGJElc+UML/o6F4ee6ukr0nZja9ek1p2lRZ2JM125wERXoue7C0+VWt2q0
 J3hqSCJQDMQVZmT4ItEKycQCVUDwYb4=
X-Authority-Analysis: v=2.4 cv=H+BOUOYi c=1 sm=1 tr=0 ts=6ad26cad cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=4gaXr956veXMTRLKBwsA:9 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: skn0uDHT4A3k1a0E1HwFdp4t3frMlX3G
X-Proofpoint-ORIG-GUID: skn0uDHT4A3k1a0E1HwFdp4t3frMlX3G
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDA3MyBTYWx0ZWRfX5RoaEXL146on
 Rd6QP60VUv2i3SxaVV3UnFw3zZNEPaYLJBBRPTAcvMfgI77jt9fxcXrOVNW1WmlKEuHHiJ6YYNF
 LvMNEKT1aHFG/bwpDxcmEY+a2ZEAsHrP5CigWY0gqkeZacOzxMMwzCXkB8z/0BK+YB7c1bVPvxS
 TWpXJzkK9BMd1UbsuLLMXy9GJVgTb5ZGnwrcPOMijCYdJszj2g6UHdV5r+OBjP6NP56L+FW/Pm8
 oqoXYr03u2Ci8Vk4Uc+fl83ySGE753SHWZYYFTeZb78ahYEQtXHXZdwZFBnN11ahVrAxeN0gG5B
 wqCRxEvkaGrkBJ78t/K/9H27O3WHQWNsS8NQ40oJ+mlhNHq9h/3Q6CH5SrnKvrJkXJFSS3jdK+X
 fpaLcabm+kjn0gTTCgQloEV2pe0GslTkp+uIJubWM1fvpX9fUej3DxA3ONJxeJwPuR2E8i39mA2
 hojSGohJ4yLJjLlTx9A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_02,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 bulkscore=0 phishscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610160073
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This removes conflict with same function from target/arm.

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
index b53ae07f9b9..220f125d56b 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -711,7 +711,7 @@ static void virt_machine_done(Notifier *notifier, void *data)
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
2.47.3


