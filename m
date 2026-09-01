Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ACA7C61DD3
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 20:22:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1UyX-0002I6-Sf; Tue, 01 Sep 2026 16:20:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x1UyW-0002Hs-VZ
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 16:20:56 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x1UyV-0003Uc-5u
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 16:20:56 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 681IX68o3237613
 for <qemu-devel@nongnu.org>; Tue, 1 Sep 2026 20:20:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=6ngNY2danIh
 TqRMm611hp79hfteIG/+Ld0UI/A/Vx+8=; b=UIIKu+4/5ZrSJVlbfEW9Q6A1XWF
 iTiN57JEPEMjDjpb8qBsEmvEDg6XceE4vLlnr/Y/TqfGX4bkhCNznlZgr3QhMEAT
 B9HOvR8U+qSkQ3vF+MXvY7ZZ2JZ5FFN+MsPgMO1O1s9h0nRSgGFq+/yCG6fjUH/0
 pGGBg9mO/shie2jk6elBNUzADyzHaQyiLA4Ycl3Yq6W9qCuh6vAtQk+UoEFn96rM
 7CMj/pqHNat0fiWcodlDGEIC5Ln6j7acmx1LhzroLRJzf191ZfOsWaO+H1Go7uye
 XiinGvQwga8GuVcXQ/CzTZCWonixoNbtBoYJNmGiTXsDvDjnEXaueaUoy6w==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ge435rc9d-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 20:20:54 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-38e7ff7b375so309125a91.1
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 13:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788294053; x=1788898853; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6ngNY2danIhTqRMm611hp79hfteIG/+Ld0UI/A/Vx+8=;
 b=dIWOmCEDTtmCJF7UZ4TWRmMDqv4wVBjqKten14ZiKtEQpea3DdUYAgqzarHr8vLyF0
 Vvd/WkcQvV3fsTGTG2FMvV30ZBXM9CIyGm7QcXyNL3yzxZXPHpolhXDpBnhRiBEKMmz2
 VTKogkUi0s7h/F6z3jl+1Pxn+Q/oEFqb2T+i+C1TZIvqHAQeSDKhu2SkhTXa/3785luR
 +iS/apfwnlzBzMGD6Fxv4KnF/XUrzD+tpFZ31MRJzB5DO+S9LQCenkqNC0zgH7a/JwgW
 vwU3AkkT9OI6c8viLZNVr7KiIlF4BEAsMv71Q/yMMWkdwJq+rLvJEJOX9BhLIlI3semG
 dD5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788294053; x=1788898853;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=6ngNY2danIhTqRMm611hp79hfteIG/+Ld0UI/A/Vx+8=;
 b=dfdfVfx1bg4El4Bnc0poaI42CgwYtpuzWt9Be1e4MKubPx5/eZdO/BSOxXu/BaMOGA
 E05QCDz+9W4OkaXW1o9gUC8zKsUz/kys75rNb8Sjrg+Yud25P70BxMG/Nc3GL8PnKjxR
 XXizgK2HcxYldHTU1avGNk53U31y5owlTllTM4xdm1rJHfNvQY8QF++NK/d4evTS7YEz
 v2jtSMBbm/U+kqdOhwooszHpNayBbRgLlEcPmI9CZND011rZHPrKMRkcrza0+6/LuEvh
 CauTxEych3O/AeOvXLBtu625pPYG+wI2GFCb3jiseNkWZq/XWwewo+z/qGJnrcTI1jwh
 xacA==
X-Gm-Message-State: AFuF++n5CMikt3YnVs2X6WWaBgSEar5Xsptnc9FFAFkKLkKPb0Gyqh2u
 69XqiQQaFi4Wq/+C/u1/cMCPBLVbZBZU6hBj1qeO2g0yvCjExUgAsHSLD8QlRfc5zwO7AijQuvy
 h4kaVgnuS8zoqezhpJb0gbDXnm4J/0caPC7c/Z0/lTBLulIc7D5aepKD4TzlSCIpgQg==
X-Gm-Gg: AYBFou0HVG+jomGblBQJOdKoI871FCu6OlAGCMhv/EetHD/gyE3p4YuNWnBmDZLpoEw
 /9wu90Y8dToybUpJgi4bxD0omtk9jyghqnruQE32n3f8Vg0MXR9+ZgSXqC06DnMhtTmGDNykNVv
 5nxqM433NpRmJhoyFTIPA9L99M9qTYpI6JaYZHY79AdjMDQDsTG+F+aIsyu3ac2xyxyghfdntBl
 +lJ3Eu6gVWi64yP+yenJvWNy+YNPe0ENc2fXFG5uZH9zBxjpLJv1mkH9naxkF4ldnEZ1K0YzN05
 6lW5lcpgu3nmUju1HRX8MBCov8o7JNWs4mAg8gnT894fpWz/mmvr4jfSEJyHhb9DyE3wt4Xp8XO
 k2VEkjgwiJfQbUn7RkdIQijtmSeVW7z2YThNhmHZLxJf3C2Z0ynYA0GU3cKs=
X-Received: by 2002:a17:90b:314e:b0:398:c3ca:1ebc with SMTP id
 98e67ed59e1d1-398c3ca354fmr30030759a91.18.1788294053177; 
 Tue, 01 Sep 2026 13:20:53 -0700 (PDT)
X-Received: by 2002:a17:90b:314e:b0:398:c3ca:1ebc with SMTP id
 98e67ed59e1d1-398c3ca354fmr30030682a91.18.1788294052706; 
 Tue, 01 Sep 2026 13:20:52 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3990d7bb9d7sm7734802a91.15.2026.09.01.13.20.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 13:20:51 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 04/14] target-info: remove machine_typename
Date: Tue,  1 Sep 2026 20:20:33 +0000
Message-ID: <20260901202043.26532-5-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260901202043.26532-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260901202043.26532-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDE3OCBTYWx0ZWRfX2hTh/mmBjy1i
 Ql99aMoSib4IOM4G5AsKPOO9Qsu4SSdjFObHCjj4lq7kvhFqi1tdqxIh+4lQUF4YBN/KoAHXwN4
 DyY49tel5f0RTDN09Rvzkk0tkbxxSY74edd1IcikLVhBxQFNNDSvNfuV/sbaTMRw7f20L4g/Uo8
 ytVcbaR+lDsV7flEqgzM/o++n/jBGtkyG6JFhGoj0c7etmcpiOLMhtxXEKHzXKDZPAonSOxKiDU
 DLDg8yJ6kGEp4K707T8qgJsuHe83+6KMWrZ6bxPIQv7SO84mx9eyxtZlILKYXGM7HfGz7/8efYq
 FAI1m/Zkjjy9yHydtJgoxTmM51Tbpr1q4k/bf/ijY8nSsLgFWEo4XQ8C93PjStWV8Ov5GFi9MRc
 lsrqiGZWFJH7z3J91PgtViOrnK5slPWm0pyM6Hh1TvaF/eUheE/7+FORy51sqgCrc+STyU/dBNb
 b4GhM2yw6DrnFidHlJQ==
X-Proofpoint-GUID: pNwWlB8iKHn5BgI0TDAnWAX2ZNzwf-xC
X-Proofpoint-ORIG-GUID: pNwWlB8iKHn5BgI0TDAnWAX2ZNzwf-xC
X-Authority-Analysis: v=2.4 cv=JpnBas4C c=1 sm=1 tr=0 ts=6a9733a6 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=-0VSjDDMCBEubZ-f8bYA:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDE3OCBTYWx0ZWRfX9EHaexRNi7Jj
 85dyl7mSFor58g73lgWI05F67pkXaykUqhIPooidDBA6G+Zwn39wj+8opgk9MfxWlHddI9cbNS9
 I7J1JA2GzzDLL1y9zj5JKXlG5zwBCT8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_05,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609010178
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

This field is now unused, so we can remove it.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 configs/targets/aarch64-softmmu.c | 1 -
 configs/targets/arm-softmmu.c     | 1 -
 configs/targets/riscv32-softmmu.c | 1 -
 configs/targets/riscv64-softmmu.c | 1 -
 include/qemu/target-info-impl.h   | 2 --
 include/qemu/target-info.h        | 8 --------
 target-info-stub.c                | 1 -
 target-info.c                     | 5 -----
 8 files changed, 20 deletions(-)

diff --git a/configs/targets/aarch64-softmmu.c b/configs/targets/aarch64-softmmu.c
index 75d95b0e743..2200a4f19e9 100644
--- a/configs/targets/aarch64-softmmu.c
+++ b/configs/targets/aarch64-softmmu.c
@@ -18,7 +18,6 @@ static const TargetInfo target_info_aarch64_system = {
     .target_arch = SYS_EMU_TARGET_AARCH64,
     .long_bits = 64,
     .cpu_type = TYPE_ARM_CPU,
-    .machine_typename = TYPE_TARGET_AARCH64_MACHINE,
     .endianness = ENDIAN_MODE_LITTLE,
     .page_bits_vary = true,
     .page_bits_init = TARGET_PAGE_BITS_LEGACY,
diff --git a/configs/targets/arm-softmmu.c b/configs/targets/arm-softmmu.c
index 73546fa5737..9d558a0c1a1 100644
--- a/configs/targets/arm-softmmu.c
+++ b/configs/targets/arm-softmmu.c
@@ -18,7 +18,6 @@ static const TargetInfo target_info_arm_system = {
     .target_arch = SYS_EMU_TARGET_ARM,
     .long_bits = 32,
     .cpu_type = TYPE_ARM_CPU,
-    .machine_typename = TYPE_TARGET_ARM_MACHINE,
     .endianness = ENDIAN_MODE_LITTLE,
     .page_bits_vary = true,
     .page_bits_init = TARGET_PAGE_BITS_LEGACY,
diff --git a/configs/targets/riscv32-softmmu.c b/configs/targets/riscv32-softmmu.c
index 752c813077e..c1d94679c7e 100644
--- a/configs/targets/riscv32-softmmu.c
+++ b/configs/targets/riscv32-softmmu.c
@@ -18,7 +18,6 @@ static const TargetInfo target_info_riscv32_system = {
     .target_arch = SYS_EMU_TARGET_RISCV32,
     .long_bits = 32,
     .cpu_type = TYPE_RISCV_CPU,
-    .machine_typename = TYPE_TARGET_RISCV32_MACHINE,
     .endianness = ENDIAN_MODE_LITTLE,
     .page_bits_init = TARGET_PAGE_BITS,
 };
diff --git a/configs/targets/riscv64-softmmu.c b/configs/targets/riscv64-softmmu.c
index 5150f0fe9d9..f648a5c8944 100644
--- a/configs/targets/riscv64-softmmu.c
+++ b/configs/targets/riscv64-softmmu.c
@@ -18,7 +18,6 @@ static const TargetInfo target_info_riscv64_system = {
     .target_arch = SYS_EMU_TARGET_RISCV64,
     .long_bits = 64,
     .cpu_type = TYPE_RISCV_CPU,
-    .machine_typename = TYPE_TARGET_RISCV64_MACHINE,
     .endianness = ENDIAN_MODE_LITTLE,
     .page_bits_init = TARGET_PAGE_BITS,
 };
diff --git a/include/qemu/target-info-impl.h b/include/qemu/target-info-impl.h
index c917d546eab..cf42aabbc8b 100644
--- a/include/qemu/target-info-impl.h
+++ b/include/qemu/target-info-impl.h
@@ -21,8 +21,6 @@ typedef struct TargetInfo {
     unsigned long_bits;
     /* runtime equivalent of CPU_RESOLVING_TYPE definition */
     const char *cpu_type;
-    /* QOM typename machines for this binary must implement */
-    const char *machine_typename;
     /* related to TARGET_BIG_ENDIAN definition */
     EndianMode endianness;
     /*
diff --git a/include/qemu/target-info.h b/include/qemu/target-info.h
index 6c5b714288e..b23e5bc5865 100644
--- a/include/qemu/target-info.h
+++ b/include/qemu/target-info.h
@@ -23,14 +23,6 @@ const char *target_name(void);
  */
 unsigned target_long_bits(void);
 
-/**
- * target_machine_typename:
- *
- * Returns: Name of the QOM interface implemented by machines
- *          usable on this target binary.
- */
-const char *target_machine_typename(void);
-
 /**
  * target_cpu_type:
  *
diff --git a/target-info-stub.c b/target-info-stub.c
index 22b7911201c..d121b8c0170 100644
--- a/target-info-stub.c
+++ b/target-info-stub.c
@@ -29,7 +29,6 @@ static const TargetInfo target_info_stub = {
     .target_arch = glue(SYS_EMU_TARGET_, TARGET_ARCH),
     .long_bits = TARGET_LONG_BITS,
     .cpu_type = CPU_RESOLVING_TYPE,
-    .machine_typename = TYPE_MACHINE,
     .endianness = TARGET_BIG_ENDIAN ? ENDIAN_MODE_BIG : ENDIAN_MODE_LITTLE,
 #ifdef TARGET_PAGE_BITS_VARY
     .page_bits_vary = true,
diff --git a/target-info.c b/target-info.c
index 04c69c41f8a..012b384036d 100644
--- a/target-info.c
+++ b/target-info.c
@@ -32,11 +32,6 @@ const char *target_cpu_type(void)
     return target_info()->cpu_type;
 }
 
-const char *target_machine_typename(void)
-{
-    return target_info()->machine_typename;
-}
-
 EndianMode target_endian_mode(void)
 {
     return target_info()->endianness;
-- 
2.43.0


