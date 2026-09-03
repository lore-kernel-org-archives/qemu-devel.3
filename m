Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C50BEC624D7
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 10:45:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x24wd-00039G-Bf; Thu, 03 Sep 2026 06:45:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x24wb-00031R-W5
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 06:45:22 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x24wZ-0007P7-OJ
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 06:45:21 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 683AH4q4935013
 for <qemu-devel@nongnu.org>; Thu, 3 Sep 2026 10:45:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 l/Gg73EeuXDsxmGWWLO6e5XjomQj9g6yk/aNMfC08hQ=; b=S6KSxLQgceso33Ar
 +/nz2SqX2LF4ssN+oSiHZxsvIccSax9ZFZtroc8B04qNj6fP6ceyuv1FZ9ZCcaHl
 u5Wap2b0m+2Keb5C2yWnSqNChwb/SkrWtMjuZ9wL2lpE0DOP6UWICWu6LLX8H/aW
 YmCXJp+REVwhSKgQDrDuQ/eXkZ+J3AZgNHhaaMlW/9y/hFsSzU9X0H79kwgUoHvN
 +eMhYG1rJAxrwX8R7daz9MZ4rA6Me69+mXIY374FHl/otECLXjCJWv/7JjO5uF+N
 SUQ7ZJlQb+/Itwxmo22UbjBAqz3HLXLLItd670mZmWQ8ZzVjZ7WYbomx+KiUdIpU
 bw2PhA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gerdnbvpa-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 10:45:18 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-9393ac4961fso163667885a.2
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 03:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788432317; x=1789037117; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=l/Gg73EeuXDsxmGWWLO6e5XjomQj9g6yk/aNMfC08hQ=;
 b=XbD/Kqcie3UQKSTLlKZqC0dO4PWWwkU47Wy3PCRZUdMGj/S08z3GynaGdPXVXAPeFo
 +vIf3zjKYsyqsm4DWPeoSnnbgzg2hbe/WJRdL0ydQwYvdTgtQKkJUc6ky/+vQp/DtTV1
 jzQTnhfNh0YXt4hAFaJ5wekq7Ldnn/c/48hd4/SMS+i5AnCiWfsbRymdBt+iwv//yf4r
 kMBaZalsabX/kcURQdI8zHiT1ovyFz6zCyOkxrzR/RY0mMB2bw0wDewF6DO1obPD90hi
 DL4bP7UfJ/2EFSstbSyuzRWsaU+lva7LNkIx7D0zyE3Py5BuZz4ySRYdSKgBKG9OP83N
 FcLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788432317; x=1789037117;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=l/Gg73EeuXDsxmGWWLO6e5XjomQj9g6yk/aNMfC08hQ=;
 b=mdUgfWf4S+B8sSfnNlThHE3VDHnk7nlH07kM9rnqHMm7vLHA9y0SvUUii6Mx4NE2Nz
 ad4Hix3V15DqRBHsAR6I01NWQz5B7mRNiQVKih/WBnshVg1aQhb5GQfGS/rk9C54YAqC
 IejTnY6Kj5KlOxf0YM7DBnkvceCWen/gGxmCJe/dODDv8iIBCBT7skD1qmLriz+slb3m
 Kk1lgvakEuR+uvWoRLeZQlv2EKYmypWJN8hyfCXxSK+U5dlMFqSP5LbI7BxwoKXoI9SA
 OtEyBUYs5ZuPtdCTqOMFYElMlDjjlZ6EwDiKP1VEZsb51z9OQyUG2afKh4vwgTY6S49V
 u8ng==
X-Gm-Message-State: AFuF++m0aALPqkwSTmpJ+mPCbQGFFKBpWkmGG3gx71hAsh8ucU7KlKGC
 42F9cdG1OCntwTF3HRqMF97hOb3RvSziVEmbcVJck6nn0tPpljbHFwMsiZ7v4nZgVOOJf034hUM
 WtnVt+rx3yq+6iTCxI0I2ZBNFITw8Ye9hAqlyBJVoZvuE8ICoD+57niQ+62sSA3FNgw==
X-Gm-Gg: AYBFou0IWus0LGujxsq5tZdDlOWDocSVvT2qxvRqviqS1u5PQ927JyFsd9Kfaw049nS
 1vg3Hw7DvRBljZfVzuo71o4aHF+L49DjaLApPU+nLU+l64PQB1rEaHwyBLZVOPmDoTnTOdHqd59
 FPiqzAaplF8p6Uxm8TTiYitOcmS3l4Y9vzliA5oiqIIznn85syexKGiJe4ous1e3/JG2as0doA+
 dHkTidWxZbvHPzDkg1ALAx1aaDnJ8abCR4t4tzqF4AZhj8JSrnlnBy6CEqCO5vNCx7c3FP4LIJd
 zVYNduUJ8nZO41PoQ5FJxNwb7CyvHbC0qjrCe00U4ijbkrlS39k0i2JJlgk4sPa0fqCpg+TRbEO
 isqNuOcSuYwZLSrx5tHTiLoE5d4QO32EyDfjbXe0H
X-Received: by 2002:a05:620a:1a15:b0:937:1538:6b93 with SMTP id
 af79cd13be357-93960ff982bmr1304278085a.40.1788432316862; 
 Thu, 03 Sep 2026 03:45:16 -0700 (PDT)
X-Received: by 2002:a05:620a:1a15:b0:937:1538:6b93 with SMTP id
 af79cd13be357-93960ff982bmr1304272985a.40.1788432316272; 
 Thu, 03 Sep 2026 03:45:16 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ce7ac52c3sm85767345e9.4.2026.09.03.03.45.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Sep 2026 03:45:14 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 45/51] hw/riscv: remove {riscv32, riscv32_64,
 riscv64}_machine_interfaces
Date: Thu,  3 Sep 2026 12:39:29 +0200
Message-ID: <20260903103936.62355-46-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903103936.62355-1-philmd@oss.qualcomm.com>
References: <20260903103936.62355-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=YcmNIQRf c=1 sm=1 tr=0 ts=6a994fbe cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=HyVZBBfh0p0RB8WjpRcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDA5MiBTYWx0ZWRfX/09t/N3FRh+Y
 XJwOoIcK3xOcXmgFi6eAn0rVZ67wts8jbW9ovd8C8YwzvLh59K2PtMe489mnbJLXEbdnPwFlHcX
 h3o6n/pylpO3RJA4lnbkJ2t6OdmOp7Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDA5MiBTYWx0ZWRfX/9kuf4Toq03M
 KXRk3a8Ih1Hdx6bpIGQG/XhiCkwVFsH2XJ01mv1hUiBmz0SqgHr0MkqSvAEvb9faoz7UMTz3cNE
 E3BjPaTI74EwVya3hv08pH+jK3LucMwWovW2SNa1InAklVPkFT0MLU71g9dEcOBa6y4knNUIUE8
 GHiAMbEcH85GciwvJrKGLGfNtJoELUZ5TNb+GP4uRLf2D9NX1ni/TX3HVLFC1aCUhMAOVEgPYgj
 3XCollDk7cg1Wn26D0kol/xnVoPHQH9uJwRTwVM7M3MOxrTDFeYgzN/+XOi19Fr7Zqm5GFW80pf
 BjnRe90yDvsNnJ1IVYqWAGJhdLJHz1/jUwtacratkgQUnwfsNdePW3M93TKmSoXi0CbXvsOOJgb
 73YuE2NWQ9Gqo2pvCV1KW4ZC6IEeMYVok7VWGRqIK716aXU0YsG9SglZh79Hl1J2tOYziYTE0nB
 R/9po+AnhtGGkPt9sQQ==
X-Proofpoint-GUID: 0po9v5eIGDLn0QEMrxkW4gm9_taOwxjD
X-Proofpoint-ORIG-GUID: 0po9v5eIGDLn0QEMrxkW4gm9_taOwxjD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_03,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 adultscore=0 phishscore=0 impostorscore=0 spamscore=0 suspectscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
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
Message-ID: <20260901202043.26532-13-pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 include/hw/riscv/machines-qom.h | 15 +++------------
 hw/riscv/k230.c                 |  1 -
 hw/riscv/microchip_pfsoc.c      |  1 -
 hw/riscv/opentitan.c            |  1 -
 hw/riscv/shakti_c.c             |  1 -
 hw/riscv/sifive_e.c             |  1 -
 hw/riscv/sifive_u.c             |  1 -
 hw/riscv/spike.c                |  1 -
 hw/riscv/tt_atlantis.c          |  1 -
 hw/riscv/xiangshan_kmh.c        |  1 -
 target/riscv/machine.c          | 12 ------------
 11 files changed, 3 insertions(+), 33 deletions(-)

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
2.53.0


