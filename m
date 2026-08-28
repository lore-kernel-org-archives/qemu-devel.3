Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30A0CC61DB9
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 23:03:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x05YA-0000cM-9V; Fri, 28 Aug 2026 18:59:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x05Y4-0000VZ-NM
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 18:59:48 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x05Y2-0005l9-6Y
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 18:59:48 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67SMTt0o3186230
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 22:59:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=9HDU9sE1lQO
 BnFHPuwDsy7y6JV3iI1B7Yiuam3D3PqM=; b=l//fuVFXQISEjxJvsKet7PVAmlX
 +vUlx01ToVS3RHVW2uwZrYcWFMhMoMQ+vwhruYWjP39DSBX583jQ3YaAbERycTsy
 qk5mUahuzLciPIcigduTjjyTMWGty2X2QloMXCplDV98Yj4qwwLHtYWJ2v9IywY0
 zsPsDt4YOvulJzr7t/rPnIL7tO+zENnkRKhoObAHxBhm+GSMB6wpCIhk3jA0k6d0
 gdlsgmuQSBWxmnaj2oNVtcTYkX+wiaXJhTeERcLsgbR8v0Q7ICrSZMIMMpk3LMSt
 wyCGjgBL/FPymCIpW4uhd4GqZ1aaLn6/fBFtUL9TV1rgZN1L6g8UNh/hXmw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gbag9t2rf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 22:59:34 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-38e7ff7b375so2206952a91.1
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 15:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787957974; x=1788562774; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9HDU9sE1lQOBnFHPuwDsy7y6JV3iI1B7Yiuam3D3PqM=;
 b=YR7cFuOk122IH1O3Uh82mz6DixipO1qatQv6foMqHFQLQcf8j1fG7BNzUuY6sOUvVw
 p42N3IwIeDhvGubjir2tM/EMK/PA1tIBO3u5xkl86VcloAoOiXxbRVAO4T4YiG5fsI8s
 t2dJ/M8WjpBCIsY7sMMm1GTNHnqJDKESZUZ3mfiEA8ZIdMvnyi5hh8AVqpBF5fhdjtVK
 J9w/3sCoIaoq+BiC9qM//dO0MjbAtRx6hEoZBVjlPTipHjYqb4yg2BKVjZb/PnsCf7AP
 9Za0Bexg1ijtQnrmOAT+Fw7kU51V2BjzHIYfoR9eBHhPj+EI2LHk+D52MIJp1vDh2Npo
 4ocw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787957974; x=1788562774;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=9HDU9sE1lQOBnFHPuwDsy7y6JV3iI1B7Yiuam3D3PqM=;
 b=QwjsZ3I1yaEh8BslS1hOfCTO+YNS9vzld0SPRH+0297Y6vRQjyZ6VallQwxzGpObQV
 tMA8Iu8irBE53UulX8nS6ZjYosM02JCb0bDJ4M6wAb3IfXY+IGS2FyKFSt/RO1sV0Kcg
 WTSxg92KXsYv6iItCG7zVF8+l6bzAaifW7HrjZChbYrJUkiwnSrAp34+gzvhrkLnCWpp
 tPlp4jqAzlhi9vemFwzwW2NZ8aoVEslVcYk558bf23goJRfMJ7iFU6QMNMVh980hESP/
 co/BdHIGUAcST0D05bWEZpd/N0ataENDiUWz9p6uCAKyDaGooSfJcajAg4q4g6gwbmDX
 s53w==
X-Gm-Message-State: AFuF++kfhHdbGCuIlJNa9s6T9x1Kdb2yhOkB+wNKpVErowSR6bRZqtaq
 SmREypeqjD6Mm6Wb+MlscehK5EvvGZ3Dq856yiMs4oA2+tFKBcE5Nkt0LvzyVaRClcDAtSZmoS9
 xpg0jZ4PbcXOpGOebAGMED6Ca7ffp+WJvnKxUx337uYB+E7S5YQ01mWpyC5e1jwwWRg==
X-Gm-Gg: AYBFou0Ni0syCe2oIPndykd+GFJGUJGT9PG2iqQh1+0C+yHD3V2cAXGtpJnoPDXXNvK
 W/AE/jOkmwvyMw/tbHJPNM33wgQ0ZTL2Ee1dJs7Edg8Cj0506N1uiPsUmlgE+vX670yXTE2p9kp
 szI097yQ6VO5pioklw0kf/YcbAmuikS5V+QfmWskKo5aNKm0dB1wvZZwICJNVx4xVAhIQ/znrpX
 xQ5CexbMbZJsHcTLT9D7LnKzwr/YYECoKFAL5RFVI6NUD0xoehDP1mbPhaoiRZ5W3cyC9P0Lf1p
 n3sP0qoOgQw3G0GV1ybUW3WpV6EgMyWRZRG11Eu7+isI2sE5JVfYD9FzV42Vx29JeFMhwFEHY30
 wIB6EujaYysoV3AdL00mdqKOIDSrtov3dbZd7lXSfHaQHWbbTYkInlLuKKmk=
X-Received: by 2002:a17:90b:48c5:b0:398:9be9:ab8c with SMTP id
 98e67ed59e1d1-3989be9ac97mr4466580a91.17.1787957973901; 
 Fri, 28 Aug 2026 15:59:33 -0700 (PDT)
X-Received: by 2002:a17:90b:48c5:b0:398:9be9:ab8c with SMTP id
 98e67ed59e1d1-3989be9ac97mr4466538a91.17.1787957973385; 
 Fri, 28 Aug 2026 15:59:33 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-142e0de4de3sm12862827c88.12.2026.08.28.15.59.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 15:59:32 -0700 (PDT)
To: qemu-devel@nongnu.org
Cc: anjo@rev.ng, Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 philmd@oss.qualcomm.com, Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 20/47] hw/riscv: remove {riscv32, riscv32_64,
 riscv64}_machine_interfaces
Date: Fri, 28 Aug 2026 22:58:34 +0000
Message-ID: <20260828225901.367438-21-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260828225901.367438-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260828225901.367438-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=UalhjqSN c=1 sm=1 tr=0 ts=6a9212d6 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=yOlMSSa_vBPGz9aVexsA:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDIwMCBTYWx0ZWRfX5naShibaCPkI
 t2Q0S1QVfOKNN1COLJeqPjN9i2NlDVIBibQAb3MdNOn9wv4Bl2kwnIa34WVkjfMDlVa04ObN4j5
 15r5/aaHslJNSq6qSCaKXueWQG7g7R4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDIwMCBTYWx0ZWRfXx5gI8Kz3/r9v
 oq11fVysVzhNMr4aDezbq9cBGmiYp+o623TBbHFpaIxk701G+M/SBGeTMqWYLJwgswc4TyDrJ37
 +cgDl57WnSVWy2CTuaYi5PIqpPtm5jMFvHVZGK6Drn7U7oejfY/3NwMC13/M/zss1gngl5WcWOv
 7y5n/dtaJbmOZ/UPBx9VleT2uTiAInMcOKPEdokbRwHx5JBApYEjqH8/NN05wSXBNAEQKjWiLY6
 bh3c+4P6n1IHv9p7jQL1DyK0zRGwU9YBzD/eIA0pSMO6kAuyG4arN+NW4AGHIiQtHtLj06kXhZ+
 re/jWmc338soRYd9s53GvjhRNB1z1bFFjmCwTYzVTiYtgXr9NOd1cATyeE7mFP7DqSjjrzjB8Xu
 MzhcdsrYgFHQ0Sud9mJ0jMaQiGgy7tywAuPoaRw5IeAGb44eFYrNBDgNpNSoogMkMBhKJWb5A6t
 x8yQLv1VICI7tknXkNA==
X-Proofpoint-ORIG-GUID: AN7hmrxKpHFYUlNI892Eg5MBuJKcHPla
X-Proofpoint-GUID: AN7hmrxKpHFYUlNI892Eg5MBuJKcHPla
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_07,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 suspectscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608280200
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
Reply-to:  Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
From:  Pierrick Bouvier via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 hw/riscv/k230.c                 |  1 -
 hw/riscv/microchip_pfsoc.c      |  1 -
 hw/riscv/opentitan.c            |  1 -
 hw/riscv/shakti_c.c             |  1 -
 hw/riscv/sifive_e.c             |  1 -
 hw/riscv/sifive_u.c             |  1 -
 hw/riscv/spike.c                |  1 -
 hw/riscv/tt_atlantis.c          |  1 -
 hw/riscv/xiangshan_kmh.c        |  1 -
 include/hw/riscv/machines-qom.h | 15 +++------------
 target/riscv/machine.c          | 12 ------------
 11 files changed, 3 insertions(+), 33 deletions(-)

diff --git a/hw/riscv/k230.c b/hw/riscv/k230.c
index 558f30b97e9..72d50d369a9 100644
--- a/hw/riscv/k230.c
+++ b/hw/riscv/k230.c
@@ -556,7 +556,6 @@ static const TypeInfo k230_machine_typeinfo = {
     .class_init = k230_machine_class_init,
     .instance_init = k230_machine_instance_init,
     .instance_size = sizeof(K230MachineState),
-    .interfaces = riscv64_machine_interfaces,
 };
 
 static void k230_machine_init_register_types(void)
diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
index 4017129c830..42d4fc39734 100644
--- a/hw/riscv/microchip_pfsoc.c
+++ b/hw/riscv/microchip_pfsoc.c
@@ -756,7 +756,6 @@ static const TypeInfo microchip_icicle_kit_machine_typeinfo = {
     .class_init = microchip_icicle_kit_machine_class_init,
     .instance_init = microchip_icicle_kit_machine_instance_init,
     .instance_size = sizeof(MicrochipIcicleKitState),
-    .interfaces = riscv64_machine_interfaces,
 };
 
 static void microchip_icicle_kit_machine_init_register_types(void)
diff --git a/hw/riscv/opentitan.c b/hw/riscv/opentitan.c
index 5b2f33d5aca..c58d8993303 100644
--- a/hw/riscv/opentitan.c
+++ b/hw/riscv/opentitan.c
@@ -338,7 +338,6 @@ static const TypeInfo open_titan_types[] = {
         .parent         = TYPE_MACHINE,
         .instance_size  = sizeof(OpenTitanState),
         .class_init     = opentitan_machine_class_init,
-        .interfaces     = riscv32_machine_interfaces,
     }
 };
 
diff --git a/hw/riscv/shakti_c.c b/hw/riscv/shakti_c.c
index 835b1f879b7..9fd7856dc24 100644
--- a/hw/riscv/shakti_c.c
+++ b/hw/riscv/shakti_c.c
@@ -98,7 +98,6 @@ static const TypeInfo shakti_c_machine_type_info = {
     .class_init = shakti_c_machine_class_init,
     .instance_init = shakti_c_machine_instance_init,
     .instance_size = sizeof(ShaktiCMachineState),
-    .interfaces = riscv64_machine_interfaces,
 };
 
 static void shakti_c_machine_type_info_register(void)
diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
index 71925583bd9..ede7cb52f00 100644
--- a/hw/riscv/sifive_e.c
+++ b/hw/riscv/sifive_e.c
@@ -168,7 +168,6 @@ static const TypeInfo sifive_e_machine_typeinfo = {
     .class_init = sifive_e_machine_class_init,
     .instance_init = sifive_e_machine_instance_init,
     .instance_size = sizeof(SiFiveEState),
-    .interfaces = riscv32_64_machine_interfaces,
 };
 
 static void sifive_e_machine_init_register_types(void)
diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 57a57c96e16..08687cfc363 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -680,7 +680,6 @@ static const TypeInfo sifive_u_machine_typeinfo = {
     .class_init = sifive_u_machine_class_init,
     .instance_init = sifive_u_machine_instance_init,
     .instance_size = sizeof(SiFiveUState),
-    .interfaces = riscv32_64_machine_interfaces,
 };
 
 static void sifive_u_machine_init_register_types(void)
diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
index 630b65f5697..3786de4b0b7 100644
--- a/hw/riscv/spike.c
+++ b/hw/riscv/spike.c
@@ -292,7 +292,6 @@ static const TypeInfo spike_machine_typeinfo = {
     .class_init = spike_machine_class_init,
     .instance_init = spike_machine_instance_init,
     .instance_size = sizeof(SpikeState),
-    .interfaces = riscv32_64_machine_interfaces,
 };
 
 static void spike_machine_init_register_types(void)
diff --git a/hw/riscv/tt_atlantis.c b/hw/riscv/tt_atlantis.c
index d808bcc11c3..5e155726abf 100644
--- a/hw/riscv/tt_atlantis.c
+++ b/hw/riscv/tt_atlantis.c
@@ -609,7 +609,6 @@ static const TypeInfo tt_atlantis_types[] = {
         .parent     = TYPE_MACHINE,
         .class_init = tt_atlantis_machine_class_init,
         .instance_size = sizeof(TTAtlantisState),
-        .interfaces = riscv64_machine_interfaces,
     },
 };
 
diff --git a/hw/riscv/xiangshan_kmh.c b/hw/riscv/xiangshan_kmh.c
index 384624d69ad..e02624b62b4 100644
--- a/hw/riscv/xiangshan_kmh.c
+++ b/hw/riscv/xiangshan_kmh.c
@@ -216,7 +216,6 @@ static const TypeInfo xiangshan_kmh_machine_info = {
     .parent = TYPE_MACHINE,
     .instance_size = sizeof(XiangshanKmhState),
     .class_init = xiangshan_kmh_machine_class_init,
-    .interfaces = riscv64_machine_interfaces,
 };
 
 static void xiangshan_kmh_machine_register_types(void)
diff --git a/include/hw/riscv/machines-qom.h b/include/hw/riscv/machines-qom.h
index 6c0bbdfc159..e5f45b32e69 100644
--- a/include/hw/riscv/machines-qom.h
+++ b/include/hw/riscv/machines-qom.h
@@ -11,15 +11,6 @@
 
 #include "hw/core/boards.h"
 
-/*
- * Interfaces specifying whether a given QOM object is available in
- * qemu-system-riscv32, qemu-system-riscv64, or both.
- */
-
-extern const InterfaceInfo riscv32_machine_interfaces[];
-extern const InterfaceInfo riscv64_machine_interfaces[];
-extern const InterfaceInfo riscv32_64_machine_interfaces[];
-
 /*
  * Helper macros for defining machines available in qemu-system-riscv32,
  * qemu-system-riscv64, or both.
@@ -27,14 +18,14 @@ extern const InterfaceInfo riscv32_64_machine_interfaces[];
 
 #define DEFINE_MACHINE_RISCV32(namestr, machine_initfn) \
         DEFINE_MACHINE_WITH_INTERFACE_ARRAY(namestr, machine_initfn, \
-                                            riscv32_machine_interfaces)
+                                            NULL)
 
 #define DEFINE_MACHINE_RISCV64(namestr, machine_initfn) \
         DEFINE_MACHINE_WITH_INTERFACE_ARRAY(namestr, machine_initfn, \
-                                            riscv64_machine_interfaces)
+                                            NULL)
 
 #define DEFINE_MACHINE_RISCV32_64(namestr, machine_initfn) \
         DEFINE_MACHINE_WITH_INTERFACE_ARRAY(namestr, machine_initfn, \
-                                            riscv32_64_machine_interfaces)
+                                            NULL)
 
 #endif
diff --git a/target/riscv/machine.c b/target/riscv/machine.c
index 59676c94470..22a918cec95 100644
--- a/target/riscv/machine.c
+++ b/target/riscv/machine.c
@@ -580,15 +580,3 @@ const VMStateDescription vmstate_riscv_cpu = {
         NULL
     }
 };
-
-const InterfaceInfo riscv32_machine_interfaces[] = {
-    { }
-};
-
-const InterfaceInfo riscv64_machine_interfaces[] = {
-    { }
-};
-
-const InterfaceInfo riscv32_64_machine_interfaces[] = {
-    { }
-};
-- 
2.43.0


