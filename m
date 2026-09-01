Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 192CEC624D3
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 20:21:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1Uyb-0002KK-42; Tue, 01 Sep 2026 16:21:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x1Uya-0002Jd-CU
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 16:21:00 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x1UyY-0003Vb-DB
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 16:20:59 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 681HgInl3228253
 for <qemu-devel@nongnu.org>; Tue, 1 Sep 2026 20:20:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=i1XjhTBfJ/J
 vy+2Q7qdnr/ESZmxZ2swpF7fougGeY1k=; b=L53PtLqLZA1CKMFU3FagoIESlGB
 xz3H/N5kH6urqFcLI3Bc88BTO6ddq/1ud5Tw/OTVa6r7kk6YXu7qqp0pGOM4QcYC
 zG0i7R8+BxkGZgzp/1eGx3YPbxKpMXNlrFye/ckgKm2TmsiHgGjl9Sz/2v1/geV+
 Bxz1arRSEVJEeOigoSxlUIvRDrSugrlLRjlTZLtcItt8Q96R0dKn8DFcwgH05ZTo
 9b93D3+LJRn5H4qhXwAxPZqYfr819s5bdVH938Lx6tvkD5yQ6amN/lGYy7N0CVdd
 D9URNG50/QCWsbAkYKwazrP4+6oAQ+qesh5LZgr3uKargalyWNs/K4eE3jQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gdvmm2sua-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 20:20:57 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-38e8fee6af3so294070a91.1
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 13:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788294056; x=1788898856; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=i1XjhTBfJ/Jvy+2Q7qdnr/ESZmxZ2swpF7fougGeY1k=;
 b=PKVqs8dsLQbBAXbTGEcFFaTwgqsMBicC9URmpK93RN0Vs/BvpzAai4rGryzjH0GJoy
 1IqQw7w4ofzEIaP4SqzOlgyTRSai0uwm2yEM/utOGrTmYDTKcmZsHMFupaFNqQTjQUmA
 4nVGeJ5iX8rVyHIkqgBHZeDXbcguzpUOK6jzhskWGaRhNRC+JI77UgiFYx6STdxI9wAl
 Ph7M0H7I/4y63sGSzGNVvlEnoStk6/lklidlPgNRpoNqD4iUN9LFYpjhsho2P17NsUwC
 fQ5xDRekXM9fw/EuTImm2uC25j0NidvSE1XjbqWPXS16Hmpznf4HiYdcLdvq4OFQINB3
 JiZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788294056; x=1788898856;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=i1XjhTBfJ/Jvy+2Q7qdnr/ESZmxZ2swpF7fougGeY1k=;
 b=DwJm1QZ8+WabUCjPRZZBs5MPILmwUGoc5r7hgjcCfShW3wpK5j4zBU5JmcWPn/6hwd
 oHXjUlu3efuaYXDgvvBhc8uMSrqQsvWYY3LFzhQUd+8vZLqq+Fbi0l+G4MjkRTeGqStY
 axxXBBdoV1fKgVa7AcoNV94UhBkodQoWHb+pUH63DehOAnjRZdg5nqVz8FE4l4lJv4oI
 QPzqKqW41Wrl2KHPOxQyicDSIWe8XxInd6fVsPYgePJnUVmpJVi3BbLmLvqtzv7yv/DH
 SvINnq1fAtSRv8vFStIi6TMCeZIuD/YhfcHgkoWstX2Q7MI478rDsce9fDjkFH6t/Q6Q
 e8/Q==
X-Gm-Message-State: AFuF++leHh/6uyQfUYE4eAYxZfdrGQXRMixjGe45QvD8bjdI9WF4q9yS
 xI+Q8xHLpQQukAqaMHrwu61wUGTDP238eXreeNc7157vsZ++nnRnvL4STcMadZWEhOuVC5+Oohh
 raTQa6Jwm+5uVpvQTdHL1KvtfujvZFa4llTRdbhSSCFvly8hfVCFoOpFJjtaKMEBeSg==
X-Gm-Gg: AYBFou0vlTBBHS2L94FI6TrPKb36dUiLZbIem4PbsnYdL9yN7WGfyjySf8DSLMwZkRP
 hcJvBYQKayZWTP4oyRcLrAFSZkt0/58+NOX0sxwQbU2rqtd5YJaAfl4tIcYSAtr4LaIst08OVSg
 ODYjR0jhfi5fqOiytjK399I0tOw68lDV90cn1a5lbsdv6avr6wUl71aMhPo3yKrxlb7etuechD4
 YGJpNMj1U319rT6n36ZpL4zc1DPjkO3IPc5kYKFuaFETykHXZw71HOKw7wyO9LLQPsEOYx6Y2fi
 u/Fn9ApbONbCU2WkhlJeDAwNEceL/JMKHlGaswQ12br5BKxz7CV8NX/9/g5sEYkvCcklRsbgYN1
 6Bn68C1JkEJqoCL9uXnlgjyetlaL20IykLPdOC/ONUBrJCmhRgm2NK4E70o0=
X-Received: by 2002:a17:90b:3c07:b0:398:c0ad:711c with SMTP id
 98e67ed59e1d1-398c0ad98afmr33826709a91.15.1788294056466; 
 Tue, 01 Sep 2026 13:20:56 -0700 (PDT)
X-Received: by 2002:a17:90b:3c07:b0:398:c0ad:711c with SMTP id
 98e67ed59e1d1-398c0ad98afmr33826634a91.15.1788294056020; 
 Tue, 01 Sep 2026 13:20:56 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3990d7bb9d7sm7734802a91.15.2026.09.01.13.20.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 13:20:54 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 07/14] hw/arm: remove TYPE_TARGET_{AARCH64,ARM}_MACHINE
Date: Tue,  1 Sep 2026 20:20:36 +0000
Message-ID: <20260901202043.26532-8-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260901202043.26532-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260901202043.26532-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: b99CcrBWOSiCvMv9p4QO22KKR2ll65cP
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDE3OCBTYWx0ZWRfX9X2t8YX/lCX8
 iVZ7i0FnRLqjK2nAhYbRVwf1QRoq69EAsC08307ijgDsAkMwaPTOhroC3mGTapAdjTKIqmWzKVR
 ur54238UkNItFQColX3wOtH/SRoiiN4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDE3OCBTYWx0ZWRfX7iN4zQhgz+q+
 HCHW9qFFJk5SzDHv+JDQ3ULF06oEoTrbqsr4eviHnKEwoPqUcAd06e1AWHue18P/1uvVdVdInAq
 d2/aUhVOr9iUcC8vjstPe5FE1sGH9dMhqWmeuAwXjTgRjdfxi2+pzFGP+OArz5hQCA7tQbPptmI
 zHvpg1InuamRHfhRGa/UsuC2TlhyBToZ2BY9OeI8uXRRWT2YWIhuzAP31cjm71WMzmisTz0IJD/
 u+lPEZkU/HxpbLuYXqna19zbYt/vK5bHM3ZXYHRPcuFrdSScVXJ1zVTmkuuGlWtFB/s0aD1ByZT
 kugTmIbw0HboDcov7V+c2fEBysDsdPuBPszM6oMbfAPT+wr3QR4H86uLYeGpnGnCaKDWiBS9uhZ
 f1dNkECF4uHuwdQn/dPqdVh5nM2qbTCcg5oWijxFlnX0Wc9QOkGcdfpK6mVEBr3BRkDw1hIfpD5
 wSv4rZKwsFjCk4yF8GQ==
X-Proofpoint-GUID: b99CcrBWOSiCvMv9p4QO22KKR2ll65cP
X-Authority-Analysis: v=2.4 cv=GfwnWwXL c=1 sm=1 tr=0 ts=6a9733a9 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=SalYC_UygP5POjnEfZgA:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_05,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 phishscore=0 suspectscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609010178
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

We don't need those types anymore.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 hw/core/null-machine.c        | 2 --
 hw/nitro/machine.c            | 5 -----
 hw/remote/machine.c           | 2 --
 include/hw/arm/machines-qom.h | 6 ------
 target-info-qom.c             | 8 --------
 target/arm/machine.c          | 5 -----
 6 files changed, 28 deletions(-)

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
2.43.0


