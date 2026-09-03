Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C9A8C624D7
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 10:45:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x24wU-0002jI-Kg; Thu, 03 Sep 2026 06:45:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x24wS-0002bU-Jk
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 06:45:12 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x24wQ-0007O8-UQ
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 06:45:12 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 683AHBjr1328202
 for <qemu-devel@nongnu.org>; Thu, 3 Sep 2026 10:45:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 65LJzxr2vu9J3ZcTiKvu6EAA29gHMoI3gixs+8qBmRU=; b=cdDSCPih5+or3zGN
 Btpuw9dJCzK7ZV/uG+bjagksyc+qXM4/bxD93nrZJuoVeC9EJ84sGM+7LXytGtAT
 kzjw+NIqtUw4pMVZ7NOIH7jWDlpTALQci0cXIoo2gnp4Dumv7y3x9XAhiSWQzsIn
 9/4v0TxluAshEGDkttimIoFOA9d91gTCJnYsSd1Havvy/jg61sFiOWgHg6zeuKg6
 08P+3cTyYwGg/LnOQXelVeYbZn2Fqf7BDUgZ/Mo+zgcWZNR517y/XZ6YzJTaadHI
 YHcO2eo/9fHuBiqsJUb+tBQ7c5xupGBQGCHFDNVp7XQ36NA22WeMwuOIXsbmm8ki
 DXG8XQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4genrnmme3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 10:45:09 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-9393ac4961fso163645785a.2
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 03:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788432308; x=1789037108; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=65LJzxr2vu9J3ZcTiKvu6EAA29gHMoI3gixs+8qBmRU=;
 b=LEzlMEsEiJApzZEJzDyJXmhyC9Tw6iLzUkDDWIgXTE9iHALPovIMjdC1QoG1gtg9FL
 qOkslx2t+W7AsGa2rJxQY6slE+ao05naVuSjKS0JAbitWLDU+vWH10gztG6Sv/CIAPz9
 e5Swv0dK7W754JBBqGgBF1sp0LBwDrY0xONO7DoJpT//OJglZgSKj2RhblqtrD0jkh2x
 mR5wH+mIMbxRWevHTYVEU6KbAa5qbfivxtqESLs53Mp+KZ41/bR1gIxBEqWkr5W1qM3X
 DjnIMH8PxbRNuVDfewVHpLx0PNtmD+XwUr4GE1ld7C984VPbIvEHEHzH/5zzQyrsg+my
 Hc3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788432308; x=1789037108;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=65LJzxr2vu9J3ZcTiKvu6EAA29gHMoI3gixs+8qBmRU=;
 b=OA3iGgMGQnsZ7L0ObUvE0ztI4f5YLUAmgM6lhJLgvmTbG0pd39FFJ3xDGqog3qwlbd
 F4ALO4FuQJYVhhig12arc72fcVbGzu9UbSR8LoZuF+nUkCwdReoquJAKdsz/OZFd1BrA
 y2+OmXVyZcEhImAooQVnkpqQkVxkB1mulESQp8qu4gpLby5CJfd5X291q8YB8fT6D8eH
 uj5BAbz/N1FHF1sDHFwX4Ia8e6yBZklNCA/H9Ypp4Y45q8aFZ49g/VHr4cUxSnwp/2g9
 cPYDRMoo9FYHKP2RhSkmYSh62m+wlXSMMKkTMMT4CykZgZ5NYClRRUmoxtMZHo78wPeZ
 62Kw==
X-Gm-Message-State: AFuF++ljw7G8+GVd33jPFROeZf9IvCabLsAsQStyMuePW2I7FSX3AKd7
 dd09Ejolcdr/Z/nxeyFh3/iPFEwhrOTRMqpzRKIIrQ3zYrmNdQNAOnb9wZTGrUsClwPDqlteo4R
 a1OLtDeUH3SJl27uLVC+Jr33ZzY8G94xbdKU+Sehv3sQneC5HAFmDWt6e74ibzmfadg==
X-Gm-Gg: AYBFou1iMkWHgNOUMbQSDq4/klPemtpG1pp+4uBsK7g6He7/hTbWWLSRF0aal1TX/A5
 UGkph1K/xITW9fFgv5UEy3REVrfENKr4BEQJHsf5NPoUv24ao5FgKN6578PAqbgDZCWnOW+GM8v
 Hir1MnYdeFHt8ihZeaLbAz0DbI2IiS+iSeemQGsF2+trezNKVZdUPICOoMUlT0hUJefeC2peqkG
 cOnULwE0FkNuHHUaRCNngoZS4anZAlNiCTO7tYFA5LhPy+OfArZy590/hjWG44T/f9hJ6v5akQX
 lPCgL5ViygVPXURLWqVyNrf6g0lcVMtrpQiUhGgZ1N/giQEqJ52QSSuLB3m2ebk71Cjaw3QSM23
 OYXRhgaTCxIzaF62YiIMvMMcy1dhthWfPGCV4LPzK
X-Received: by 2002:a05:620a:2545:b0:937:6900:a7ae with SMTP id
 af79cd13be357-93960dfe4b3mr1160660685a.15.1788432308496; 
 Thu, 03 Sep 2026 03:45:08 -0700 (PDT)
X-Received: by 2002:a05:620a:2545:b0:937:6900:a7ae with SMTP id
 af79cd13be357-93960dfe4b3mr1160654885a.15.1788432307941; 
 Thu, 03 Sep 2026 03:45:07 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-484492ce236sm14941005f8f.35.2026.09.03.03.45.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Sep 2026 03:45:07 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 44/51] hw/riscv: remove TYPE_TARGET_{RISCV32,RISCV64}_MACHINE
Date: Thu,  3 Sep 2026 12:39:28 +0200
Message-ID: <20260903103936.62355-45-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903103936.62355-1-philmd@oss.qualcomm.com>
References: <20260903103936.62355-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: sB5PEzpBRgSxMBzfu6GBE8Mnc1GkmH-M
X-Proofpoint-ORIG-GUID: sB5PEzpBRgSxMBzfu6GBE8Mnc1GkmH-M
X-Authority-Analysis: v=2.4 cv=YKuvDxGx c=1 sm=1 tr=0 ts=6a994fb5 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=h_r1GPaHZSNDaGzxDFMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDA5MiBTYWx0ZWRfXwxCEU43kD5y/
 tHmZT+U8Tml1Z9/ywZdREJYPhnlzz79k6HSRkl5naW9vHdbDOuy3NAAHgmpX0A5Fu+xzFmN1FYy
 3tL/SCJHQ2qaKCzQRyvO2oP4iTufPLYwYo5HOGOrGZPwYWUOe9AyQu8pIJ/PvFUwo9P381/2Ix6
 109DNrjXNrKKlaJbbF4CTwCBqPZW0K8wzIW3GEz997FvJzFaes138lIeZxl+okaaHEt4LNTow3B
 xStb/Rk2AsXmHilrc9jzVMtKGBgZ0hGjYP7H20TKl3NDCSyWj1dWoqTZ1x9KNfuP4Q6WBlxgn5P
 2Y+eIyxCP7QE5Av18CRtsUP9R4sTH37H5j0eF0aNYTpFn9YrG3/GpeFCbURBULHk3rHP1DeJugx
 AJbbBGbPpR+BYb8kGfSCdYjKD7Y7GPm75St/TFMTvDMSuqzE7bn306d0IqCDf8oBzFKqrL6x5HZ
 k5r9pETg0M0gzlWEyCA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDA5MiBTYWx0ZWRfX7ziInekbFcho
 DG87MxE+oAus5XSp07AV2URrBbXcYUYe9WqkmyxWbw44J/LJGh3jVbraly3MyRM/RWneUT5xU2P
 k53KKTDetA37CJQ1H4duD7GpsozvIe8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_03,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 adultscore=0 impostorscore=0 malwarescore=0
 phishscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609030092
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <20260901202043.26532-12-pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 include/hw/riscv/machines-qom.h |  6 ------
 hw/core/null-machine.c          |  5 +----
 hw/riscv/virt.c                 |  2 --
 target-info-qom.c               | 13 -------------
 target/riscv/machine.c          |  4 ----
 5 files changed, 1 insertion(+), 29 deletions(-)

diff --git a/include/hw/riscv/machines-qom.h b/include/hw/riscv/machines-qom.h
index ee346227bb2..6c0bbdfc159 100644
--- a/include/hw/riscv/machines-qom.h
+++ b/include/hw/riscv/machines-qom.h
@@ -11,12 +11,6 @@
 
 #include "hw/core/boards.h"
 
-#define TYPE_TARGET_RISCV32_MACHINE \
-        "target-info-riscv32-machine"
-
-#define TYPE_TARGET_RISCV64_MACHINE \
-        "target-info-riscv64-machine"
-
 /*
  * Interfaces specifying whether a given QOM object is available in
  * qemu-system-riscv32, qemu-system-riscv64, or both.
diff --git a/hw/core/null-machine.c b/hw/core/null-machine.c
index 2aa748233b3..2f008c4a702 100644
--- a/hw/core/null-machine.c
+++ b/hw/core/null-machine.c
@@ -56,7 +56,4 @@ static void machine_none_machine_init(MachineClass *mc)
     mc->no_cdrom = 1;
 }
 
-DEFINE_MACHINE_WITH_INTERFACES("none", machine_none_machine_init,
-                               { TYPE_TARGET_RISCV32_MACHINE },
-                               { TYPE_TARGET_RISCV64_MACHINE },
-                               { })
+DEFINE_MACHINE("none", machine_none_machine_init)
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index d58656f70d1..d2ae321a376 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -1811,8 +1811,6 @@ static const TypeInfo virt_machine_typeinfo = {
     .instance_size = sizeof(RISCVVirtState),
     .interfaces = (const InterfaceInfo[]) {
          { TYPE_HOTPLUG_HANDLER },
-         { TYPE_TARGET_RISCV32_MACHINE },
-         { TYPE_TARGET_RISCV64_MACHINE },
          { }
     },
 };
diff --git a/target-info-qom.c b/target-info-qom.c
index 7959853e0da..f98d3d7698e 100644
--- a/target-info-qom.c
+++ b/target-info-qom.c
@@ -14,19 +14,6 @@
 #include "qemu/target-info-qom.h"
 #include "hw/riscv/machines-qom.h"
 
-static const TypeInfo target_info_types[] = {
-    {
-        .name           = TYPE_TARGET_RISCV32_MACHINE,
-        .parent         = TYPE_INTERFACE,
-    },
-    {
-        .name           = TYPE_TARGET_RISCV64_MACHINE,
-        .parent         = TYPE_INTERFACE,
-    },
-};
-
-DEFINE_TYPES(target_info_types)
-
 static void target_info_qom_class_init(ObjectClass *oc, const void * data)
 {
     TargetInfoQomClass *klass = TARGET_INFO_CLASS(oc);
diff --git a/target/riscv/machine.c b/target/riscv/machine.c
index 31c49ca3e6a..59676c94470 100644
--- a/target/riscv/machine.c
+++ b/target/riscv/machine.c
@@ -582,17 +582,13 @@ const VMStateDescription vmstate_riscv_cpu = {
 };
 
 const InterfaceInfo riscv32_machine_interfaces[] = {
-    { TYPE_TARGET_RISCV32_MACHINE },
     { }
 };
 
 const InterfaceInfo riscv64_machine_interfaces[] = {
-    { TYPE_TARGET_RISCV64_MACHINE },
     { }
 };
 
 const InterfaceInfo riscv32_64_machine_interfaces[] = {
-    { TYPE_TARGET_RISCV32_MACHINE },
-    { TYPE_TARGET_RISCV64_MACHINE },
     { }
 };
-- 
2.53.0


