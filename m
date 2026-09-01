Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E507C624D7
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 20:21:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1Uyi-0002O7-5b; Tue, 01 Sep 2026 16:21:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x1Uyh-0002MN-4d
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 16:21:07 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x1Uyf-0003XC-4o
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 16:21:06 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 681HgaaG3737607
 for <qemu-devel@nongnu.org>; Tue, 1 Sep 2026 20:21:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=9HDU9sE1lQO
 BnFHPuwDsy7y6JV3iI1B7Yiuam3D3PqM=; b=BZcqqVKabEi8/PE7fkoIZcBT3wO
 wcimfeswDIdxhKef24JCKY5X+zolwUzEQb4kYV2PUsHfAGDcTLYoWBXs0jwaM5TS
 CXKgn3u6k46RPcqTMmOSGa7iV9ScJALPlZ+2T+D5Xi9JnBVANR+mLT1KtqLW3c1+
 C85YUavE/oY+QYH+YK+zi9hb1mvy8fC8RPDC3LsOMHaKXic7Hr8lehKgWauz0h5W
 b23nsZRqfsCZboA5mNAg9okPwjZseGJ3BBSGOcx9zRlqmHhyu5SaOgiQrdBwpfT6
 767wVpi3oajxpGgfy0F03LkUe66Q1bGrSBEr2rbYJkL47Zs76cCKfiJDMRQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gdynt1x11-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 20:21:04 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-39906175917so321163a91.2
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 13:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788294063; x=1788898863; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9HDU9sE1lQOBnFHPuwDsy7y6JV3iI1B7Yiuam3D3PqM=;
 b=CpjAW3kBKfHd/K9qh9ZOjGogfldYa74ujKUPRFSN3Ljv2Q0G2eJC7rgqgJTRY79Fc6
 EyhGzwouk0uAiT9HCSmLDX5oBZVYnheAKbAN3WCinARKy190mOf4/sK0Gn+Rm9jwLbVw
 NF55enrAswItGrEdQvhA7biOexyT1DOvp7uqvEX33M401Cn8f2NP07wrLPztyDPfKgjB
 iqrIeiyrZ/WhdD2Lw1beUpl3nDVqncJyjVYEvh9bzf5ls2SEt/PA5pscmtfF9CqyWAlN
 rfKq2gx58KJAM1neLLcVjQDQ1zYkGSqhqbJ5aiCjFAOOu08DMUIWc3HZ6chUDeecDQZ5
 buBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788294063; x=1788898863;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=9HDU9sE1lQOBnFHPuwDsy7y6JV3iI1B7Yiuam3D3PqM=;
 b=BX8HimJumOELa/5tfJH8n/xy5e9NhxbxfjPWQoEAjqfDI3mMaXdAKMZRCijbTaNw3N
 Tz2EhVidHkFqGTck0Pzmzmt2ITCUzzhf0k6sQZsOkaB6bsiFPSS7dJLhpirauaAyKQtH
 ifFQ8iFs4i00+eKQh/c+Q+XRzc3lRVHHMHCyHc91HvLs3pz2/vMtvDCLZ32rbwdarEr8
 MfsBWqxUqaDNV/kQ/DV83gro1tUe2yqSjjkNSzgSjwjLj+UQMYEHTDPH8EyTX1MNGmdv
 Jg6wq4Lr6eQXY0R3iB1TM/RbnScFFT4g2V/3Q0OxNbne1BkN91uJvEg5qr/mkxY1i12B
 1aPQ==
X-Gm-Message-State: AFuF++kxNX2i4sPelaGAxmIQZcKB8G6PQL3EW3ez3NViziPu++WqGwYy
 ks3tdVfrAOqp1qpfkEJ0B1GR4ocHG6PJpO7BaSQUhcn2XmWDQcpykLp8/ml688Ql11/cQAPJnir
 HgnEFcLqjyA2c4ENt8qmcPoHh5z7HiLk6MxDSn4Ebxo90Vf5FKIYtbNbN3dwEWE1PiQ==
X-Gm-Gg: AYBFou3SZUU5aL3vfRtpoxzizGmA6c5GfiW9cAHD47Qk/yfyWT5wsGGw0g4KhtW5QA0
 UgGIuf6KF3/xyT2ZwX8Qp/fenQWTdoACHDVp83te9e7zSxtgReuLTornu7QHKQrsBq27/GnIosv
 39Xideeq59i8+LzeYeaJQ9AP8XCfwOO8ECbKf9WZcl6H4lUal/zuT8V4C+H45CYPjICpAWkvhMD
 0MDGDmbYyVWo2vNEonxFjjwTFcKHD8jK3b/bSXsHeM8RHmqYh8o6AATKiKN6fjz4k2GyoiJj5ro
 X2CG3u3cuesCzusdYv2JR4tbobKWZSd8Gcq+YZw0ISB7w4ONP1WYTFrt225pXq+FeAiAiKuvADx
 qA9CC3dOxibjIjK5F9VPuM/jcZtYXlftb7D6pwJ6kAjqbB1XnfB0kLiEaxYg=
X-Received: by 2002:a17:90a:2c9:b0:398:9c39:520f with SMTP id
 98e67ed59e1d1-3989c3957f1mr28273052a91.15.1788294062930; 
 Tue, 01 Sep 2026 13:21:02 -0700 (PDT)
X-Received: by 2002:a17:90a:2c9:b0:398:9c39:520f with SMTP id
 98e67ed59e1d1-3989c3957f1mr28272926a91.15.1788294062301; 
 Tue, 01 Sep 2026 13:21:02 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3990d7bb9d7sm7734802a91.15.2026.09.01.13.21.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 13:21:01 -0700 (PDT)
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 12/14] hw/riscv: remove {riscv32, riscv32_64,
 riscv64}_machine_interfaces
Date: Tue,  1 Sep 2026 20:20:41 +0000
Message-ID: <20260901202043.26532-13-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260901202043.26532-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260901202043.26532-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDE3OCBTYWx0ZWRfX/0GpI2rNEGaJ
 OgLD0lqTLCPpCkfbOXVmwwxQ3S2v2SCbGwYk1kBG6jvxtNCk0PwbnxLzzw/VjqZ6a/jNyQx5FRp
 Ls96yGPREk7gGbO4dWDTRo0gdkPaAA2HGljFl4t4gdC2G5iYd9l984kj3V8yHw+fyEAeN2JbOO2
 dPrNckOXqNhLTed1RIkNomCvjoQCcOXGo3hu+arXbyZciXhnqRc1k6BDrXfW5klVpTef7v0ENzR
 CtfU/sIFEEJko2k1fy3I/m0Hw4VxaStr1mF3F3HB2Cio1Bqg/PB1tYDOTfRwZ055kzFs5sKQ49G
 mV1yFcHEcner4JquU/Y5RG45zmwDalheyZjQQIB/x0wVNYbsT2lS4ozcTDKH7+cgjnwIDENWq1p
 rvgWIzzC4vMv6XUpt+XzDdsYE34vnFluXHsFcSRhaQYdstbNcLwOPnHeozz57A6SgZ3m2qLysFE
 1Gq+IhTnZcWgipc3Y9g==
X-Proofpoint-ORIG-GUID: 6GocpUXA9MZ1s2nVSYCqjYoaY0oZHjx6
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDE3OCBTYWx0ZWRfXyvLmCE8k92Io
 yr4L3rl3odD1AB+DMk4T1zLdpgAE4S7Tn5/reg2H+r9CqrTUgH8HUk8OduF+X1Gl5EFkIR6CndY
 lgpSrm0Nx7YNbyW5+2nDb5n1e23NJiE=
X-Authority-Analysis: v=2.4 cv=LfkMLDfi c=1 sm=1 tr=0 ts=6a9733b0 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=yOlMSSa_vBPGz9aVexsA:9 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: 6GocpUXA9MZ1s2nVSYCqjYoaY0oZHjx6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_05,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 phishscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501 suspectscore=0
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


