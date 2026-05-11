Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36334CD37AC
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 13:32:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMQhU-00015B-10; Mon, 11 May 2026 09:29:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wMQhL-00011l-J5
 for qemu-devel@nongnu.org; Mon, 11 May 2026 09:29:29 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wMQhJ-0007Zh-Bj
 for qemu-devel@nongnu.org; Mon, 11 May 2026 09:29:27 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64B8Hupm1850346
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 13:29:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=xhY1RrgR0mv
 /fydQwswsX1ptnZC7EeZ9hHsA4fvI0NI=; b=f+Vpq3JQAZK2D1OFG+Tl6sMVb2T
 8xXbHe+KEwxIugtT3MVOCB+ElZkqIJ+TZn8ja1tFGuHBWJyVc/nMjnmlTJ5GwuVA
 ERhMWUNt61MXDsxUJl6LB0nEKpSMdeWRhvpl9lip7+4viLGTV8+LaxgL91jYRo+Q
 NKloxY7CDt5s9I8w/qC3h8aEW5d0wtbtBOCBcX9Rs7wr+ZQfIbn0vrOKr0M33Jll
 pwdrXdSBnQnHaDKVBVR8vDkddGHysuT3qnux8HQQxWhEDkVAL9cwB174U1pyHGQW
 raV1Ug3nChzWUIn9BC2elmzklsU0iYf3hgYLNpMdIC1Opavt+0Ca07YJR4g==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e3bfvh411-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 13:29:23 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-8aca14d1faaso110491116d6.3
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 06:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778506162; x=1779110962; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xhY1RrgR0mv/fydQwswsX1ptnZC7EeZ9hHsA4fvI0NI=;
 b=LG2WIMKzq6HrKTmL1ZPF4KzrTQfb0IURiKfgPNscNULBjYE4k1uh3Uuw0kT0DMLyOy
 /saugNJkEMVOLY89Zkdz9o0Rc/IjaB5eOXt9PkgK94mZCf0RhSBMF77p//wv2hCgGL0I
 B3cbIwvPcmQEdIvyUKD+3tr7zQCmLaUC5VHganjuNqQTaXpQQqlNNnvRKAZ1W+gjBa3P
 1Tzpss/YJAeqzfyZT4A8bmVYlYQ1fR2dBa/lGMWkJN9Xzk5LPAKMeL+jlt4xL7M/vesA
 zPc71uPF6ZGYD5UeGR95/RvG8zBSL/R3qCWlSFZCrVTCHHbT9Mt6lN/Dm3ta1MnbtP49
 0toQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778506162; x=1779110962;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xhY1RrgR0mv/fydQwswsX1ptnZC7EeZ9hHsA4fvI0NI=;
 b=cI0ORa8yUn/kvJsjEzRs55PEv6cDVOsgEAVinprLRgUnCYUBBReT5waUaudwyxVrB4
 mJwX+Wyr7WMrajaveAHRPriXWDn6xiyDgyiKIn/Y5jsQRqPihV7OqJghJ7NhDTV9Q3AO
 Djl8GzCRX61bAw25r9MJHBXQb/2fBxGyieaXI94Bvw8yefo592pCnoMpfUMGQA2nVjaT
 Us6n+cBojcq9UQEF8i55jdCVG5Wp1YhSFIkh1RFGAwCOiddmHOq8erP569Nv4wbusT/u
 6znRIcsHkdpUz3APIrULyGOENhgnwjdJABTLdNBCjDzsFb0AFC935I1etZzCUsntOxxK
 R9PQ==
X-Gm-Message-State: AOJu0Yw1JeyNlKbGk5Cr+FXREHzJiJsQFWG0hAA067v5UHo2SC9kMiGi
 EXKgE6PPX6CtkBqxZBagkHoXksXiEyEc/Efm+qxo6FMthma2CuTYLAQabXO3lmYLTFSH3a53+Md
 9DW0efFEe9kINpvI9nWX3KdA7y5fChaU/rVcqsKcxjPdEFAviaBQT6UZQcYcyfa9qEQ==
X-Gm-Gg: Acq92OEeO1dOyO3jYlAPciHcgYXnRJUgFT23dLyCnE7BOt9ivGXbEmA+NtKj9ajf2K8
 ATSkXtqa5+4CbU/vdtrpLuT5R+DqUbwbFUy7iV79UHKPBjJ0T5YVrnVqR2M3pE3zfXWAt6bh9OA
 PjUDq9t+jqsTakFgFrgADB6Cv5L/6GjAruuSFLRmO6lE+aUB97dApQE+c23mYUibu3V3a7O9T/b
 0AD1OM2U0e4CTRsZDCHWoknljXBXt6WvgYkuMV2CCYw6IlfudIHkkrs9uvSTGn+ZOvJ52HQkhSQ
 KA2IOSjFQLxFsqnWLVnZlsBwwPlx/5YaKodsd/m90YEL2X3h+nGv3f17OuEMzMSNAyc8lZSUNiB
 PPMphoV+C8YJyU7hTCtYW+o3260MT8LA8W1ouXkA5vXxiLiRLEfCSBCZqGuD9
X-Received: by 2002:a05:6214:226d:b0:899:fd80:f79f with SMTP id
 6a1803df08f44-8bc44f85b34mr355652766d6.23.1778506162041; 
 Mon, 11 May 2026 06:29:22 -0700 (PDT)
X-Received: by 2002:a05:6214:226d:b0:899:fd80:f79f with SMTP id
 6a1803df08f44-8bc44f85b34mr355652086d6.23.1778506161530; 
 Mon, 11 May 2026 06:29:21 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([191.202.238.222])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8bf39c81b3fsm95250326d6.29.2026.05.11.06.29.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 06:29:21 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Subject: [PATCH 03/13] target/riscv: make riscv-qmp-cmds use isa_data_arr[]
Date: Mon, 11 May 2026 10:29:00 -0300
Message-ID: <20260511132910.1738069-4-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260511132910.1738069-1-daniel.barboza@oss.qualcomm.com>
References: <20260511132910.1738069-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Fa4HAp+6 c=1 sm=1 tr=0 ts=6a01d9b3 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=etEqFfc6qwXwpI8uT8rzbw==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=6oxEnRjBsO9o_5No1nIA:9 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-GUID: wMT8bOiP2kFU8BNO7T6p-y29hkgI1im-
X-Proofpoint-ORIG-GUID: wMT8bOiP2kFU8BNO7T6p-y29hkgI1im-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDE0OSBTYWx0ZWRfX5AH0QPUZPflr
 T0mJFxIIfHkdcC9XDcDR0EPsIX0igDqeuKzAxvRFNWYonpVB8sm0d9r19Dbo/PgMujdbAmxJJBV
 qjwp+Itv1EIwjQtk26154Df7m0RRBMZu3Do7IwCF5AGn+mFNxqPhglWbAV4xnqZIA0gEGtAGRCl
 KyMsKD6yBBv8LQ+Kt8+1A91UauU4AUfvwRcOU3ytg6YltBS2ehxu5g0yFlEYNYtz/86SqNPkamZ
 ntcWGEfeOuSlZpuEoDlLmJjTivQuQEbGmkmg3Dvsnoh3zYlJUunwZEIpIXIS81TfvWOE/DB32QU
 z1aKUJZ8/ZeC2m0MDsJq86BTSBmZ68b9Oh3jDnQhsEslxe+tSPv45jS20HXK8D4r6rwkSqp5vdE
 61/JNQpK/kcJ7l2zX36kRVKCK3H+GgQLiMBwsdRRpO66xlkHNT6w3cGw3Gwpne2gryYU6HNPJMY
 TjrLDnIt9iFEvipJsrQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_04,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0 clxscore=1015
 malwarescore=0 spamscore=0 priorityscore=1501 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605110149
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

We want to reduce the usage of the riscv_cpu_* arrays in
target/riscv/cpu.c, centering everything in isa_edata_arr[] instead, to
reduce data duplication and make our lives a bit easier when adding new
extensions.

To do that we'll have to make isa_edata_arr[] do what the other arrays
are currently doing, not breaking existing semantics in the process.
The riscv_cpu_* arrays have a few exclusive uses:

- set default extensions for rv32 and rv64;
- create user CPU properties;
- misc uses around tcg-cpu.c and kvm-cpu.c.

We'll slowly make isa_edata_arr[] supersede these arrays.  Start by
adding a new 'prop_name' field in RISCVIsaExtData.  This field is needed
because not all extensions have properties and not all properties match
the riscv,isa string name.

Create two additional macros and reclassify existing isa_edata_arr[]
entries as follows:

- ISA_EXT_DATA_ENTRY creates an entry where prop_name == riscv,isa.
  Most of our regular extensions fall into this category;
- ISA_EXPERIMENTAL_EXT_DATA_ENTRY: same as above but add a "x-" to the
  prop name, i.e. prop_name == "x-" + riscv,isa;
- ISA_INTERNAL_EXT_DATA_ENTRY: used to declared internal extensions.  By
  'internal' we mean users/management can't set them on or off.

With these new macros we can start our simplification by changing
riscv-qmp-cmds to use isa_edata_arr[].  We'll just scroll through it
once and gather what we need.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 target/riscv/cpu.c            | 60 +++++++++++++++++++++++------------
 target/riscv/cpu.h            |  1 +
 target/riscv/riscv-qmp-cmds.c | 30 ++++--------------
 3 files changed, 47 insertions(+), 44 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index ee8f6e5296..42555cb28f 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -97,8 +97,24 @@ static void riscv_cpu_cfg_merge(RISCVCPUConfig *dest, const RISCVCPUConfig *src)
 #include "cpu_cfg_fields.h.inc"
 }
 
+/* Use this for regular user facing extensions */
 #define ISA_EXT_DATA_ENTRY(_name, _min_ver, _prop) \
-    {#_name, _min_ver, CPU_CFG_OFFSET(_prop)}
+    {#_name, #_name, _min_ver, CPU_CFG_OFFSET(_prop)}
+
+/*
+ * Same as above but for experimental extensions. We'll add a
+ * "x-" right after "_name" when creating the user property.
+ */
+#define ISA_EXPERIMENTAL_EXT_DATA_ENTRY(_name, _min_ver, _prop) \
+    {#_name, "x-" #_name, _min_ver, CPU_CFG_OFFSET(_prop)}
+
+/*
+ * Internal extensions are extensions we will declare in the
+ * riscv,isa DT but they don't have an user property, i.e.
+ * users/management can't enable/disable them.
+ */
+#define ISA_INTERNAL_EXT_DATA_ENTRY(_name, _min_ver, _prop) \
+    {#_name, NULL, _min_ver, CPU_CFG_OFFSET(_prop)}
 
 /*
  * Here are the ordering rules of extension naming defined by RISC-V
@@ -121,13 +137,13 @@ static void riscv_cpu_cfg_merge(RISCVCPUConfig *dest, const RISCVCPUConfig *src)
  * instead.
  */
 const RISCVIsaExtData isa_edata_arr[] = {
-    ISA_EXT_DATA_ENTRY(zic64b, PRIV_VERSION_1_12_0, ext_zic64b),
+    ISA_INTERNAL_EXT_DATA_ENTRY(zic64b, PRIV_VERSION_1_12_0, ext_zic64b),
     ISA_EXT_DATA_ENTRY(zicbom, PRIV_VERSION_1_12_0, ext_zicbom),
     ISA_EXT_DATA_ENTRY(zicbop, PRIV_VERSION_1_12_0, ext_zicbop),
     ISA_EXT_DATA_ENTRY(zicboz, PRIV_VERSION_1_12_0, ext_zicboz),
-    ISA_EXT_DATA_ENTRY(ziccamoa, PRIV_VERSION_1_11_0, has_priv_1_11),
-    ISA_EXT_DATA_ENTRY(ziccif, PRIV_VERSION_1_11_0, has_priv_1_11),
-    ISA_EXT_DATA_ENTRY(zicclsm, PRIV_VERSION_1_11_0, has_priv_1_11),
+    ISA_INTERNAL_EXT_DATA_ENTRY(ziccamoa, PRIV_VERSION_1_11_0, has_priv_1_11),
+    ISA_INTERNAL_EXT_DATA_ENTRY(ziccif, PRIV_VERSION_1_11_0, has_priv_1_11),
+    ISA_INTERNAL_EXT_DATA_ENTRY(zicclsm, PRIV_VERSION_1_11_0, has_priv_1_11),
     ISA_EXT_DATA_ENTRY(ziccrse, PRIV_VERSION_1_11_0, ext_ziccrse),
     ISA_EXT_DATA_ENTRY(zicfilp, PRIV_VERSION_1_12_0, ext_zicfilp),
     ISA_EXT_DATA_ENTRY(zicfiss, PRIV_VERSION_1_13_0, ext_zicfiss),
@@ -141,7 +157,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(zilsd, PRIV_VERSION_1_12_0, ext_zilsd),
     ISA_EXT_DATA_ENTRY(zimop, PRIV_VERSION_1_13_0, ext_zimop),
     ISA_EXT_DATA_ENTRY(zmmul, PRIV_VERSION_1_12_0, ext_zmmul),
-    ISA_EXT_DATA_ENTRY(za64rs, PRIV_VERSION_1_12_0, has_priv_1_12),
+    ISA_INTERNAL_EXT_DATA_ENTRY(za64rs, PRIV_VERSION_1_12_0, has_priv_1_12),
     ISA_EXT_DATA_ENTRY(zaamo, PRIV_VERSION_1_12_0, ext_zaamo),
     ISA_EXT_DATA_ENTRY(zabha, PRIV_VERSION_1_13_0, ext_zabha),
     ISA_EXT_DATA_ENTRY(zacas, PRIV_VERSION_1_12_0, ext_zacas),
@@ -211,13 +227,14 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(zhinx, PRIV_VERSION_1_12_0, ext_zhinx),
     ISA_EXT_DATA_ENTRY(zhinxmin, PRIV_VERSION_1_12_0, ext_zhinxmin),
     ISA_EXT_DATA_ENTRY(sdtrig, PRIV_VERSION_1_12_0, debug),
-    ISA_EXT_DATA_ENTRY(shcounterenw, PRIV_VERSION_1_12_0, has_priv_1_12),
-    ISA_EXT_DATA_ENTRY(sha, PRIV_VERSION_1_12_0, ext_sha),
-    ISA_EXT_DATA_ENTRY(shgatpa, PRIV_VERSION_1_12_0, has_priv_1_12),
-    ISA_EXT_DATA_ENTRY(shtvala, PRIV_VERSION_1_12_0, has_priv_1_12),
-    ISA_EXT_DATA_ENTRY(shvsatpa, PRIV_VERSION_1_12_0, has_priv_1_12),
-    ISA_EXT_DATA_ENTRY(shvstvala, PRIV_VERSION_1_12_0, has_priv_1_12),
-    ISA_EXT_DATA_ENTRY(shvstvecd, PRIV_VERSION_1_12_0, has_priv_1_12),
+    ISA_INTERNAL_EXT_DATA_ENTRY(shcounterenw, PRIV_VERSION_1_12_0,
+                                has_priv_1_12),
+    ISA_INTERNAL_EXT_DATA_ENTRY(sha, PRIV_VERSION_1_12_0, ext_sha),
+    ISA_INTERNAL_EXT_DATA_ENTRY(shgatpa, PRIV_VERSION_1_12_0, has_priv_1_12),
+    ISA_INTERNAL_EXT_DATA_ENTRY(shtvala, PRIV_VERSION_1_12_0, has_priv_1_12),
+    ISA_INTERNAL_EXT_DATA_ENTRY(shvsatpa, PRIV_VERSION_1_12_0, has_priv_1_12),
+    ISA_INTERNAL_EXT_DATA_ENTRY(shvstvala, PRIV_VERSION_1_12_0, has_priv_1_12),
+    ISA_INTERNAL_EXT_DATA_ENTRY(shvstvecd, PRIV_VERSION_1_12_0, has_priv_1_12),
     ISA_EXT_DATA_ENTRY(smaia, PRIV_VERSION_1_12_0, ext_smaia),
     ISA_EXT_DATA_ENTRY(smcdeleg, PRIV_VERSION_1_13_0, ext_smcdeleg),
     ISA_EXT_DATA_ENTRY(smcntrpmf, PRIV_VERSION_1_12_0, ext_smcntrpmf),
@@ -232,20 +249,21 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(smstateen, PRIV_VERSION_1_12_0, ext_smstateen),
     ISA_EXT_DATA_ENTRY(ssaia, PRIV_VERSION_1_12_0, ext_ssaia),
     ISA_EXT_DATA_ENTRY(ssccfg, PRIV_VERSION_1_13_0, ext_ssccfg),
-    ISA_EXT_DATA_ENTRY(ssccptr, PRIV_VERSION_1_11_0, has_priv_1_11),
+    ISA_INTERNAL_EXT_DATA_ENTRY(ssccptr, PRIV_VERSION_1_11_0, has_priv_1_11),
     ISA_EXT_DATA_ENTRY(sscofpmf, PRIV_VERSION_1_12_0, ext_sscofpmf),
-    ISA_EXT_DATA_ENTRY(sscounterenw, PRIV_VERSION_1_12_0, has_priv_1_12),
+    ISA_INTERNAL_EXT_DATA_ENTRY(sscounterenw, PRIV_VERSION_1_12_0,
+                                has_priv_1_12),
     ISA_EXT_DATA_ENTRY(sscsrind, PRIV_VERSION_1_12_0, ext_sscsrind),
     ISA_EXT_DATA_ENTRY(ssctr, PRIV_VERSION_1_12_0, ext_ssctr),
     ISA_EXT_DATA_ENTRY(ssdbltrp, PRIV_VERSION_1_13_0, ext_ssdbltrp),
     ISA_EXT_DATA_ENTRY(ssnpm, PRIV_VERSION_1_13_0, ext_ssnpm),
     ISA_EXT_DATA_ENTRY(sspm, PRIV_VERSION_1_13_0, ext_sspm),
-    ISA_EXT_DATA_ENTRY(ssstateen, PRIV_VERSION_1_12_0, ext_ssstateen),
-    ISA_EXT_DATA_ENTRY(ssstrict, PRIV_VERSION_1_12_0, has_priv_1_12),
+    ISA_INTERNAL_EXT_DATA_ENTRY(ssstateen, PRIV_VERSION_1_12_0, ext_ssstateen),
+    ISA_INTERNAL_EXT_DATA_ENTRY(ssstrict, PRIV_VERSION_1_12_0, has_priv_1_12),
     ISA_EXT_DATA_ENTRY(sstc, PRIV_VERSION_1_12_0, ext_sstc),
-    ISA_EXT_DATA_ENTRY(sstvala, PRIV_VERSION_1_12_0, has_priv_1_12),
-    ISA_EXT_DATA_ENTRY(sstvecd, PRIV_VERSION_1_12_0, has_priv_1_12),
-    ISA_EXT_DATA_ENTRY(ssu64xl, PRIV_VERSION_1_12_0, has_priv_1_12),
+    ISA_INTERNAL_EXT_DATA_ENTRY(sstvala, PRIV_VERSION_1_12_0, has_priv_1_12),
+    ISA_INTERNAL_EXT_DATA_ENTRY(sstvecd, PRIV_VERSION_1_12_0, has_priv_1_12),
+    ISA_INTERNAL_EXT_DATA_ENTRY(ssu64xl, PRIV_VERSION_1_12_0, has_priv_1_12),
     ISA_EXT_DATA_ENTRY(supm, PRIV_VERSION_1_13_0, ext_supm),
     ISA_EXT_DATA_ENTRY(svade, PRIV_VERSION_1_11_0, ext_svade),
     ISA_EXT_DATA_ENTRY(svadu, PRIV_VERSION_1_12_0, ext_svadu),
@@ -253,7 +271,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(svnapot, PRIV_VERSION_1_12_0, ext_svnapot),
     ISA_EXT_DATA_ENTRY(svpbmt, PRIV_VERSION_1_12_0, ext_svpbmt),
     ISA_EXT_DATA_ENTRY(svrsw60t59b, PRIV_VERSION_1_13_0, ext_svrsw60t59b),
-    ISA_EXT_DATA_ENTRY(svukte, PRIV_VERSION_1_13_0, ext_svukte),
+    ISA_EXPERIMENTAL_EXT_DATA_ENTRY(svukte, PRIV_VERSION_1_13_0, ext_svukte),
     ISA_EXT_DATA_ENTRY(svvptc, PRIV_VERSION_1_13_0, ext_svvptc),
     ISA_EXT_DATA_ENTRY(xlrbr, PRIV_VERSION_1_13_0, ext_xlrbr),
     ISA_EXT_DATA_ENTRY(xmipscbop, PRIV_VERSION_1_12_0, ext_xmipscbop),
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index e42f369408..fd9c3c4c9f 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -995,6 +995,7 @@ extern const RISCVCPUMultiExtConfig riscv_cpu_named_features[];
 
 typedef struct isa_ext_data {
     const char *name;
+    const char *prop_name;
     int min_version;
     int ext_enable_offset;
 } RISCVIsaExtData;
diff --git a/target/riscv/riscv-qmp-cmds.c b/target/riscv/riscv-qmp-cmds.c
index 8a1856c50e..93e6b7fa68 100644
--- a/target/riscv/riscv-qmp-cmds.c
+++ b/target/riscv/riscv-qmp-cmds.c
@@ -90,27 +90,14 @@ static void riscv_obj_add_qdict_prop(Object *obj, QDict *qdict_out,
     }
 }
 
-static void riscv_obj_add_multiext_props(Object *obj, QDict *qdict_out,
-                                         const RISCVCPUMultiExtConfig *arr)
+static void riscv_obj_add_multiext_props(Object *obj, QDict *qdict_out)
 {
-    for (int i = 0; arr[i].name != NULL; i++) {
-        riscv_obj_add_qdict_prop(obj, qdict_out, arr[i].name);
-    }
-}
+    const RISCVIsaExtData *edata;
 
-static void riscv_obj_add_named_feats_qdict(Object *obj, QDict *qdict_out)
-{
-    const RISCVCPUMultiExtConfig *named_cfg;
-    RISCVCPU *cpu = RISCV_CPU(obj);
-    QObject *value;
-    bool flag_val;
-
-    for (int i = 0; riscv_cpu_named_features[i].name != NULL; i++) {
-        named_cfg = &riscv_cpu_named_features[i];
-        flag_val = isa_ext_is_enabled(cpu, named_cfg->offset);
-        value = QOBJECT(qbool_from_bool(flag_val));
-
-        qdict_put_obj(qdict_out, named_cfg->name, value);
+    for (edata = isa_edata_arr; edata && edata->name; edata++) {
+        if (edata->prop_name) {
+            riscv_obj_add_qdict_prop(obj, qdict_out, edata->prop_name);
+        }
     }
 }
 
@@ -220,10 +207,7 @@ CpuModelExpansionInfo *qmp_query_cpu_model_expansion(CpuModelExpansionType type,
 
     qdict_out = qdict_new();
 
-    riscv_obj_add_multiext_props(obj, qdict_out, riscv_cpu_extensions);
-    riscv_obj_add_multiext_props(obj, qdict_out, riscv_cpu_experimental_exts);
-    riscv_obj_add_multiext_props(obj, qdict_out, riscv_cpu_vendor_exts);
-    riscv_obj_add_named_feats_qdict(obj, qdict_out);
+    riscv_obj_add_multiext_props(obj, qdict_out);
     riscv_obj_add_profiles_qdict(obj, qdict_out);
 
     /* Add our CPU boolean options too */
-- 
2.43.0


