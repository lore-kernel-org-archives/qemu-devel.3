Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF62CC624D7
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 10:44:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x24w1-0001Ku-Jp; Thu, 03 Sep 2026 06:44:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x24vx-0001J8-GJ
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 06:44:41 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x24vv-00079F-Ph
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 06:44:41 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 683AHMck3852414
 for <qemu-devel@nongnu.org>; Thu, 3 Sep 2026 10:44:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 zHQmDVzoj0QvSmQe65ZGl3crIuQWtg913g8PCZTy/lk=; b=IPzLTagN4fcFTWbW
 xI2Wqg+vFWZzoj4waAMVmxCtbJos8nGnlbeR/9pQdBTCksv1uijHwwqtIm143C40
 EdBePFXWbrRhI31cZ/CYnxH8appJzfYHKJGEsyrioNdIPVUGcgK689U/ucP5NgS2
 2CuBh/2lANEs5q8hlATV0iwqu3aQm8DLvMPNvNMJfh17QUwdbxNp+Ne0FlqVB6lW
 cPXvkGCi8N8B/iXEDEmPKBTecO5BtDbjSPLQGgBft0ALMqdbW/29SNBKySshgxjb
 8RNrz8KRRr2RJRV50LCj6f9GD7kOEPwlGMNTtxmdohZxyDwih/2SepPn9tk9SCZ2
 +BbfXA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gf51m0njr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 10:44:38 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-934963b2bc0so420714085a.3
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 03:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788432277; x=1789037077; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zHQmDVzoj0QvSmQe65ZGl3crIuQWtg913g8PCZTy/lk=;
 b=h0fWvw1LsfEDWWScLk2fjANa5F2dqqeug3pyO1aOoBWV0Ywc48q+yC5HglFD0/XD6/
 y05LjUtAKaYNQvD7Nex8NxKGyfi1qOolOyWNLw85jhCIRildADMBYESYt05wh8KgACMo
 ANdHCpSHdvLcvQozdPTB9+/RO21KyZdrshO6dZmQDCYRmFqhz8x0FFqFHrx2oMSjVP01
 jXPAZbAJ2+qOKmpNCj7OdCBawgp5xYadjRfRSmMhyK/DUeUqB2HqeLo2Iwqstn3waaji
 vQunb9UIaXT70eiuGhqkSC2GgO23qQUpqAjdjegzWJ9bMuEqEeMWOnnXxxxQlCnsbIMj
 WKAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788432277; x=1789037077;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zHQmDVzoj0QvSmQe65ZGl3crIuQWtg913g8PCZTy/lk=;
 b=i5qqSq5zVBDwtgTfjuB/6ZhObsE+/UOXlk5RPojQvTzwA+eupdgJVcb6QDNCK4Wsrl
 96kgfvdRcUCeKW/2DqZ5tMrYh7RWgf1wRBveZTx4VRLq3Z163Kwbo/dPkfom4pyiIIlM
 dCA38g9QjDFhsQlP9CCkqKviGzckUMbmpqFJc5xV3Kkod8tIlLT+E2imxyiDKoELwt93
 0MiBjPGcMbnioCL/jNsiU6XYq18YOK10aBwjU6/qYteBkVCWifZgcI2UNZvr7d9k/eQ+
 UFBWb/8qjUp30N9QO4NtWt40Sb5cmobXJ5xkLgyotmPRQgGHBzu523/l2Wwl4nVbe8NC
 2Wkw==
X-Gm-Message-State: AFuF++nFDj9sIYRBfXybG9pJRdojhzj8/WKQmL0s4YGiJoj2uUPxnRon
 P/Amsdk1mQC4pfrngRDIf6iORZ/Dp1Bf0iPxlCIlT8h3MkjXo+FfVDEwONY72vJd9oFNYU7gCk0
 Ke1ohMFLd9si6vdm6/0g78gUDkuuyyoSjokSX4h5H7HAXwL0yHaNA5goOxTQNcOkx/A==
X-Gm-Gg: AYBFou1Jd40kT2P1nk9tsVs+/CQ9PN6njfTEuMcQlpnJmvXnBZrOmMCMmldmZjv/aW0
 Mmrijwpd27eDPUI7W1wpO13FVGeVcr82aIKyNeW0kPnE4xRzQ3V0X85bhmkcWys9BSsbNBYbFf7
 D/57qCL6TB5vlIvssBMoNtBQq+rlmRVXlDnd4OVdsy2+QWvvKkCcqOb8xE5fxHoaNmD3I1v3o2N
 hQ5T7ct0ASIN2PEskKwaKeY/9j2aMaMfIUNBVcj25Vh3kYbyfQ5Zt7oU1nrsm4407BR7QDQcvbZ
 PtlhGxpEZR7grz1AcHE7X6YLq7SlQgjb2d09o3s21UpZ77H/W529uZdAG4X4XVfpYPXGdyDSj8J
 CkyGncyA0udG6+hZdNh5X0QY2V2Mhp0tKGtTOUNG7
X-Received: by 2002:a05:620a:6019:b0:939:7c8:78b1 with SMTP id
 af79cd13be357-93960edcf5cmr1415015185a.24.1788432277526; 
 Thu, 03 Sep 2026 03:44:37 -0700 (PDT)
X-Received: by 2002:a05:620a:6019:b0:939:7c8:78b1 with SMTP id
 af79cd13be357-93960edcf5cmr1415011285a.24.1788432277065; 
 Thu, 03 Sep 2026 03:44:37 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cee5e6115sm63664525e9.14.2026.09.03.03.44.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Sep 2026 03:44:34 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 40/51] hw/arm: remove TYPE_TARGET_{AARCH64,ARM}_MACHINE
Date: Thu,  3 Sep 2026 12:39:24 +0200
Message-ID: <20260903103936.62355-41-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903103936.62355-1-philmd@oss.qualcomm.com>
References: <20260903103936.62355-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 7q5jXCUJ1oh_rwEBo_P-7anNeRFI-pWQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDA5MiBTYWx0ZWRfX8eeI7RCGM/Fk
 vtdbQ0X/S8QKq137sNIwMcLQk0dBeF7jiKCEIwv+McS0KiY+NUhdG2vciKk4AxOaVHj/u1GdHa7
 /lODVrVtVTFpX7VAPDu5YsGGNQ+O0Oe7vhuOC+IntY2bebmJvaEqGQt6CYH2HPvm1TjcUIZ6Wib
 dzBjZ9fg+ht5lTrbz7ISPkvbhfIrFR1608rmW99uvZaMZZYgqNKXrTl9S+n/gYdFXhtyiVmPBH3
 9tPpLR/0ur2xmCVLenFs4Hmo7/3hN0P9D07QQydTM3ZxsVBBvdV8Gjv9Fn6Jvx2LwjFzzdTW4RI
 yh+mtRy354Y09YLTkvl5TCK7sagB5OjDjVe9WtLrTXrBh06sYocBWhoy+xgVkmInGVTxK1C/Oay
 fNdAF0mafqeBghba17FaPYRZbk1UncZQgmO1E86bBFf0nbV0DTC+dd1nLkzn7YMWE/6lU10KGhd
 P/tG7NgDEoAjfC1wu0g==
X-Authority-Analysis: v=2.4 cv=X8Ji7mTe c=1 sm=1 tr=0 ts=6a994f96 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=h_r1GPaHZSNDaGzxDFMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDA5MiBTYWx0ZWRfX/0Njq+VXs8UN
 Gf+XOxly8Hno9zUR0NmVNsX98aL+YpUnt5R96rma9AWeRG/WVGJ1HFBDnv67QANM02QiAdelmOm
 5C/QH0NizZY6VzSzk8jx3q/0p/aE97Q=
X-Proofpoint-ORIG-GUID: 7q5jXCUJ1oh_rwEBo_P-7anNeRFI-pWQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_03,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030092
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

We don't need those types anymore.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <20260901202043.26532-8-pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 include/hw/arm/machines-qom.h | 6 ------
 hw/core/null-machine.c        | 2 --
 hw/nitro/machine.c            | 5 -----
 hw/remote/machine.c           | 2 --
 target-info-qom.c             | 8 --------
 target/arm/machine.c          | 5 -----
 6 files changed, 28 deletions(-)

diff --git a/include/hw/arm/machines-qom.h b/include/hw/arm/machines-qom.h
index 3ed39384e59..81ffa434303 100644
--- a/include/hw/arm/machines-qom.h
+++ b/include/hw/arm/machines-qom.h
@@ -11,12 +11,6 @@
 
 #include "hw/core/boards.h"
 
-#define TYPE_TARGET_ARM_MACHINE \
-        "target-info-arm-machine"
-
-#define TYPE_TARGET_AARCH64_MACHINE \
-        "target-info-aarch64-machine"
-
 /*
  * A machine filtered with arm_machine_interfaces[] or
  * arm_aarch64_machine_interfaces[] will be available
diff --git a/hw/core/null-machine.c b/hw/core/null-machine.c
index f132a7b89b4..c1ecf3214fd 100644
--- a/hw/core/null-machine.c
+++ b/hw/core/null-machine.c
@@ -58,8 +58,6 @@ static void machine_none_machine_init(MachineClass *mc)
 }
 
 DEFINE_MACHINE_WITH_INTERFACES("none", machine_none_machine_init,
-                               { TYPE_TARGET_AARCH64_MACHINE },
-                               { TYPE_TARGET_ARM_MACHINE },
                                { TYPE_TARGET_RISCV32_MACHINE },
                                { TYPE_TARGET_RISCV64_MACHINE },
                                { })
diff --git a/hw/nitro/machine.c b/hw/nitro/machine.c
index 8849959359c..bb8878299bc 100644
--- a/hw/nitro/machine.c
+++ b/hw/nitro/machine.c
@@ -262,11 +262,6 @@ static const TypeInfo nitro_machine_info = {
     .parent = TYPE_MACHINE,
     .instance_size = sizeof(NitroMachineState),
     .class_init = nitro_machine_class_init,
-    .interfaces = (const InterfaceInfo[]) {
-        /* x86_64 and aarch64 only */
-        { TYPE_TARGET_AARCH64_MACHINE },
-        { }
-    },
 };
 
 static void nitro_machine_register(void)
diff --git a/hw/remote/machine.c b/hw/remote/machine.c
index df08f640199..6580e0d9683 100644
--- a/hw/remote/machine.c
+++ b/hw/remote/machine.c
@@ -149,8 +149,6 @@ static const TypeInfo remote_machine = {
     .class_init = remote_machine_class_init,
     .interfaces = (const InterfaceInfo[]) {
         { TYPE_HOTPLUG_HANDLER },
-        { TYPE_TARGET_AARCH64_MACHINE },
-        { TYPE_TARGET_ARM_MACHINE },
         { }
     }
 };
diff --git a/target-info-qom.c b/target-info-qom.c
index 7958a5cc685..eb9491338ca 100644
--- a/target-info-qom.c
+++ b/target-info-qom.c
@@ -16,14 +16,6 @@
 #include "hw/riscv/machines-qom.h"
 
 static const TypeInfo target_info_types[] = {
-    {
-        .name           = TYPE_TARGET_ARM_MACHINE,
-        .parent         = TYPE_INTERFACE,
-    },
-    {
-        .name           = TYPE_TARGET_AARCH64_MACHINE,
-        .parent         = TYPE_INTERFACE,
-    },
     {
         .name           = TYPE_TARGET_RISCV32_MACHINE,
         .parent         = TYPE_INTERFACE,
diff --git a/target/arm/machine.c b/target/arm/machine.c
index 89127e5d83c..42a1427fa16 100644
--- a/target/arm/machine.c
+++ b/target/arm/machine.c
@@ -1348,18 +1348,13 @@ const VMStateDescription vmstate_arm_cpu = {
 };
 
 const InterfaceInfo arm_machine_interfaces[] = {
-    { TYPE_TARGET_ARM_MACHINE },
-    { TYPE_TARGET_AARCH64_MACHINE },
     { }
 };
 
 const InterfaceInfo arm_aarch64_machine_interfaces[] = {
-    { TYPE_TARGET_ARM_MACHINE },
-    { TYPE_TARGET_AARCH64_MACHINE },
     { }
 };
 
 const InterfaceInfo aarch64_machine_interfaces[] = {
-    { TYPE_TARGET_AARCH64_MACHINE },
     { }
 };
-- 
2.53.0


